<#
.SYNOPSIS
  Render an OpenSCAD file to PNG(s) and print its echo output, for fast design
  iteration without re-approving ad-hoc shell commands each time.

.DESCRIPTION
  Wraps the OpenSCAD CLI. Renders a single frame, or a sweep of animation frames
  across one rotation, with optional parameter overrides (e.g. -D "N=4").
  Output PNGs go to _renders/ (gitignored). Echo lines are printed to the console.

.EXAMPLE
  ./render.ps1                          # render gerotor.scad at $t=0
  ./render.ps1 -t 0.2                   # single frame at t=0.2
  ./render.ps1 -Sweep 6                 # 6 frames across one rotation
  ./render.ps1 -D "N=4","ro=60"         # override params
  ./render.ps1 roots_bubbler.scad -Sweep 4
  ./render.ps1 -EchoOnly                # just print echo values, no PNG
#>
[CmdletBinding()]
param(
    # .scad file to render (relative to this script's folder). Defaults to gerotor.scad.
    [Parameter(Position = 0)]
    [string]$File = "gerotor.scad",

    # Animation parameter for a single frame (0..1).
    [double]$t = 0,

    # If > 0, render this many frames evenly across one rotation (overrides -t).
    [int]$Sweep = 0,

    # Parameter overrides passed to OpenSCAD, e.g. -D "N=4","ro=60".
    [string[]]$D = @(),

    # Image size in pixels (square).
    [int]$Size = 500,

    # Only print echo output; skip PNG rendering.
    [switch]$EchoOnly,

    # Open the (first) rendered PNG when done.
    [switch]$Show
)

$ErrorActionPreference = "Stop"

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

# Top-down orthographic camera, framed generously for these rotor sizes.
$camera = "0,0,0,0,0,0,250"

# --- Echo capture -----------------------------------------------------------
function Get-Echo {
    param([string[]]$Defs)
    $dargs = @(); foreach ($x in $Defs) { $dargs += "-D"; $dargs += $x }
    $echoFile = Join-Path $env:TEMP "_scad_echo.echo"
    # OpenSCAD writes echo output both to stderr and (with this export format) to
    # the output file. Read the file: it is locale-proof and reliable.
    & $scad -o $echoFile --export-format echo @dargs $src 2>&1 | Out-Null
    if (Test-Path $echoFile) {
        Get-Content $echoFile | Where-Object { $_ -match 'ECHO:' }
    }
}

Write-Host "OpenSCAD: $scad" -ForegroundColor DarkGray
Write-Host "Source  : $src" -ForegroundColor DarkGray
if ($D.Count) { Write-Host "Overrides: $($D -join ', ')" -ForegroundColor DarkGray }

Write-Host "`n--- echo ---" -ForegroundColor Cyan
Get-Echo -Defs $D | ForEach-Object { Write-Host $_ }

if ($EchoOnly) { return }

# --- Render -----------------------------------------------------------------
$frames = if ($Sweep -gt 0) {
    0..($Sweep - 1) | ForEach-Object { [math]::Round($_ / $Sweep, 4) }
} else { @([math]::Round($t, 4)) }

Write-Host "`n--- render ($($frames.Count) frame(s)) ---" -ForegroundColor Cyan
$first = $null
$idx = 0
foreach ($ft in $frames) {
    # Integer-indexed names avoid locale decimal-comma filename mangling.
    $name = if ($frames.Count -gt 1) { "{0}{1}_{2:d2}.png" -f $stem, $tag, $idx }
            else                     { "{0}{1}.png" -f $stem, $tag }
    $png  = Join-Path $outDir $name

    $dargs = @(); foreach ($x in $D) { $dargs += "-D"; $dargs += $x }
    & $scad -o $png --imgsize="$Size,$Size" --camera=$camera --projection=ortho `
        -D "`$t=$(n $ft)" @dargs $src 2>&1 | Out-Null

    if (Test-Path $png) {
        Write-Host ("  t={0,-6} -> {1}" -f (n $ft), (Resolve-Path $png).Path)
        if (-not $first) { $first = $png }
    } else {
        Write-Host "  t=$ft -> FAILED" -ForegroundColor Red
    }
    $idx++
}

if ($Show -and $first) { Invoke-Item $first }
