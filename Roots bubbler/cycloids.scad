// Roots blower
// Hypocycloid
// x(angle)=(R-r)cos(theta) + r cos((R-r)Theta/r)
// y(angle)=(R-r)sin(theta) - r sin((R-r)Theta/r)

function hypocycloidX(angle,major,minor) = (major-minor)*cos(angle) + minor*cos((major-minor)*angle/minor);
function hypocycloidY(angle,major,minor) = (major-minor)*sin(angle) - minor*sin((major-minor)*angle/minor);
function epicycloidX(angle,major,minor) = (major+minor)*cos(angle) - minor*cos((major+minor)*angle/minor);
function epicycloidY(angle,major,minor) = (major+minor)*sin(angle) - minor*sin((major+minor)*angle/minor);
