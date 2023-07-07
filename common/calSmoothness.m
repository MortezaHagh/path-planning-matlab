function smoothness = calSmoothness(pathCoords)

    solX = pathCoords(:, 1);
    solY = pathCoords(:, 2);

    dx = diff(solX);
    dy = diff(solY);

    stall = dx == 0 & dy == 0;
    dx(stall) = [];
    dy(stall) = [];
    solX(stall) = [];
    solY(stall) = [];

    if numel(solX) > 2
        alpha = zeros(1, length(dx) - 1);

        for i = 1:length(dx) - 1
            a = sqrt(dx(i + 1) ^ 2 + dy(i + 1) ^ 2);
            b = sqrt(dx(i) ^ 2 + dy(i) ^ 2);
            c = (solX(i) - solX(i + 2)) ^ 2 + (solY(i) - solY(i + 2)) ^ 2;
            gamma = abs(acosd((a ^ 2 + b ^ 2 - c) / (2 * a * b)));
            alpha(i) = 180 - gamma;
        end

        sm = sum(alpha);
        smoothness = round(sm, 3);
    else
        smoothness = 0;
    end

end
