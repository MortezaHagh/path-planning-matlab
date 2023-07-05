function smoothness = smoothness_by_dir(sol)

dn = diff(sol.nodeNumbers);
stall = dn==0;

sol.dirs(stall)=[];

theta = sol.dirs;
theta = deg2rad(theta);
dTheta = angdiff(theta);
dTheta = rad2deg(dTheta);
smoothness = sum(abs(dTheta));

end