function smoothness = calSmoothnessbyDir(sol)

    dn = diff(sol.nodeNumbers);
    stall = dn == 0;

    sol.dirs(stall) = [];

    theta = sol.dirs;
    dTheta = angdiff(theta);
    % dTheta = rad2deg(dTheta);
    smoothness = sum(abs(dTheta));

end
