<#
.SYNOPSIS
  Render an OpenSCAD file to PNG(s), print its echo output, and check the model is
  a watertight (2-manifold) solid — for fast design iteration without re-approving
  ad-hoc shell commands each time.

.DESCRIPTION
  Wraps the OpenSCAD CLI. Renders a single frame or an animation sweep, from a
  chosen camera preset, with optional parameter overrides (e.g. -D "N=4").
  A manifold/STL check always runs (cameras have no side effects; the STL check is
  cheap and catches non-watertight geometry early). Output goes to _renders/
  (gitignored). Echo lines are printed to the console.

.EXAMPLE
  ./render.ps1                          # gerotor.scad, iso view, at $t=0, + manifold check
  ./render.ps1 -View top                # top-down orthographic
  ./render.ps1 -View bottom -t 0.12     # look up at the underside
  ./render.ps1 -Sweep 6 -View iso       # 6 frames across one rotation
  ./render.ps1 -D "N=4","ro=60"         # override params
  ./render.ps1 -D 'mode="plate"' -View iso
  ./render.ps1 -EchoOnly                # echo + manifold check only, no PNG
  ./render.ps1 -NoStl                   # skip the manifold check
#>
[CmdletBinding()]
param(
    # .scad file to render (relative to this script's folder). Defaults to gerotor.scad.
    [Parameter(Position = 0)]
    [string]$File = "gerotor.scad",

    # Camera preset. iso/top/bottom/side/low/front. (No destructive side effects.)
    [ValidateSet("iso", "top", "bottom", "side", "low", "front")]
    [string]$View = "iso",

    # Animation parameter for a single frame (0..1).
    [double]$t = 0,

    # If > 0, render this many frames evenly across one rotation (overrides -t).
    [int]$Sweep = 0,

    # Parameter overrides passed to OpenSCAD, e.g. -D "N=4","ro=60".
    [string[]]$D = @(),

    # Image size in pixels (square).
    [int]$Size = 600,

    # Only print echo + manifold check; skip PNG rendering.
    [switch]$EchoOnly,

    # Skip the manifold/STL check (otherwise it always runs).
    [switch]$NoStl,

    # Open the (first) rendered PNG when done.
    [switch]$Show
)

# Note: deliberately NOT using $ErrorActionPreference='Stop'. OpenSCAD writes
# progress/warnings to stderr; under 'Stop' a native stderr write can abort the
# script. We check results explicitly (Test-Path on outputs) instead.
$ErrorActionPreference = "Continue"

# Format numbers with a dot regardless of system locale (Dutch locale uses a
# comma, which OpenSCAD's -D parser rejects). Use for every numeric -D value.
$inv = [System.Globalization.CultureInfo]::InvariantCulture
function n([double]$v) { $v.ToString($inv) }

# --- Locate OpenSCAD --------------------------------------------------------
$scad = @(
    "C:\Program Files\OpenSCAD\openscad.exe",
    "C:\Program Files\OpenSCAD (Nightly)\openscad.exe",
    "${env:ProgramFiles(x86)}\OpenSCAD\openscad.exe",
    "$env:LOCALAPPDATA\Programs\OpenSCAD\openscad.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $scad) { $scad = (Get-Command openscad.exe -ErrorAction SilentlyContinue).Source }
if (-not $scad) { throw "OpenSCAD executable not found. Edit the path list in render.ps1." }

# --- Resolve paths ----------------------------------------------------------
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$src  = Join-Path $here $File
if (-not (Test-Path $src)) { throw "Source file not found: $src" }

$outDir = Join-Path $here "_renders"
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory $outDir | Out-Null }

$stem = [System.IO.Path]::GetFileNameWithoutExtension($File)
# Tag output with any param overrides so frames from different configs don't clash.
$tag  = if ($D.Count) { "_" + (($D -join "_") -replace '[^\w]', '') } else { "" }

# --- Camera presets ---------------------------------------------------------
# OpenSCAD --camera = eyeX,eyeY,eyeZ,rotX,rotY,rotZ,dist (gimbal form). The models
# here are centred on the origin and run ~100-200 mm tall, so dist ~600 frames them.
# `ortho` is used for the orthographic-style flat views; iso/low use perspective.
$cameras = @{
    iso    = @{ cam = "0,5,40,62,0,28,600";   ortho = $false }
    top    = @{ cam = "0,0,40,0,0,0,420";      ortho = $true  }
    bottom = @{ cam = "0,0,-40,180,0,0,420";   ortho = $true  }
    side   = @{ cam = "0,0,40,90,0,0,640";     ortho = $true  }
    front  = @{ cam = "0,0,40,90,0,0,640";     ortho = $false }
    low    = @{ cam = "0,0,-30,72,0,30,640";   ortho = $false }
}
$camDef  = $cameras[$View]
$camera  = $camDef.cam
$projArg = if ($camDef.ortho) { @("--projection=ortho") } else { @() }

Write-Host "OpenSCAD: $scad" -ForegroundColor DarkGray
Write-Host "Source  : $src   View: $View" -ForegroundColor DarkGray
if ($D.Count) { Write-Host "Overrides: $($D -join ', ')" -ForegroundColor DarkGray }

# --- Echo capture -----------------------------------------------------------
function Get-Echo {
    param([string[]]$Defs)
    $dargs = @(); foreach ($x in $Defs) { $dargs += "-D"; $dargs += $x }
    $echoFile = Join-Path $env:TEMP "_scad_echo.echo"
    & $scad -o $echoFile --export-format echo @dargs $src 2>&1 | Out-Null
    if (Test-Path $echoFile) {
        Get-Content $echoFile | Where-Object { $_ -match 'ECHO:' }
    }
}

Write-Host "`n--- echo ---" -ForegroundColor Cyan
Get-Echo -Defs $D | ForEach-Object { Write-Host $_ }

# --- Manifold / STL check (always, unless -NoStl) ---------------------------
# Exports an STL and reports whether OpenSCAD flagged it as non-2-manifold. A clean
# result means the model is a watertight solid (printable / boolean-safe).
function Test-Manifold {
    param([string[]]$Defs)
    $dargs = @(); foreach ($x in $Defs) { $dargs += "-D"; $dargs += $x }
    $stl = Join-Path $env:TEMP "_manifold_check.stl"
    $out = & $scad -o $stl @dargs $src 2>&1 | Out-String
    $bad = [regex]::Matches($out, '(?im)(WARNING|ERROR).*') | ForEach-Object { $_.Value }
    if ($bad) {
        Write-Host "  NOT manifold / has warnings:" -ForegroundColor Yellow
        $bad | Select-Object -Unique | ForEach-Object { Write-Host "    $_" -ForegroundColor Yellow }
    } elseif (Test-Path $stl) {
        Write-Host "  manifold OK ($([math]::Round((Get-Item $stl).Length/1kb)) KB STL)" -ForegroundColor Green
    } else {
        Write-Host "  STL export FAILED" -ForegroundColor Red
    }
}

if (-not $NoStl) {
    Write-Host "`n--- manifold check ---" -ForegroundColor Cyan
    Test-Manifold -Defs $D
}

if ($EchoOnly) { return }

# --- Render -----------------------------------------------------------------
$frames = if ($Sweep -gt 0) {
    0..($Sweep - 1) | ForEach-Object { [math]::Round($_ / $Sweep, 4) }
} else { @([math]::Round($t, 4)) }

Write-Host "`n--- render ($($frames.Count) frame(s), view=$View) ---" -ForegroundColor Cyan
$first = $null
$idx = 0
foreach ($ft in $frames) {
    # Integer-indexed names avoid locale decimal-comma filename mangling.
    $name = if ($frames.Count -gt 1) { "{0}{1}_{2}_{3:d2}.png" -f $stem, $tag, $View, $idx }
            else                     { "{0}{1}_{2}.png" -f $stem, $tag, $View }
    $png  = Join-Path $outDir $name

    $dargs = @(); foreach ($x in $D) { $dargs += "-D"; $dargs += $x }
    & $scad -o $png --imgsize="$Size,$Size" --camera=$camera @projArg `
        -D "`$t=$(n $ft)" @dargs $src 2>&1 | Out-Null

    if (Test-Path $png) {
        Write-Host ("  t={0,-6} -> {1}" -f (n $ft), (Resolve-Path $png).Path)
        if (-not $first) { $first = $png }
    } else {
        Write-Host "  t=$(n $ft) -> FAILED" -ForegroundColor Red
    }
    $idx++
}

if ($Show -and $first) { Invoke-Item $first }
