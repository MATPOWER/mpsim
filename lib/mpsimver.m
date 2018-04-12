function rv = mpsimver(varargin)
%MPSIMVER  Prints or returns MP-Sim version info for current installation.
%   V = MPSIMVER returns the current MP-Sim version number.
%   V = MPSIMVER('all') returns a struct with the fields Name, Version,
%   Release and Date (all strings). Calling MPSIMVER without assigning the
%   return value prints the version and release date of the current
%   installation of MP-Sim.
%
%   See also MPVER.

%   MP-Sim
%   Copyright (c) 2016, 2017 by Haeyong (David) Shin, Ray Zimmerman
%
%   This file is part of MP-Sim.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

v = struct( 'Name',     'MP-Sim', ... 
            'Version',  '1.0b1', ...
            'Release',  '', ...
            'Date',     '19-Mar-2017' );
if nargout > 0
    if nargin > 0
        rv = v;
    else
        rv = v.Version;
    end
else
    fprintf('%-22s Version %-9s  %11s\n', v.Name, v.Version, v.Date);
end
