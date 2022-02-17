function thetaOutput = thetaConversion(thetaInput)
    %convert theta domain to [-pi, pi]
    if thetaInput < 0
        sign = -1;
        thetaInput = thetaInput * -1;
    else
        sign = 1;
    end
    thetaInput = mod(thetaInput, 2*pi);
    if thetaInput > pi
        thetaInput = thetaInput - 2*pi;
        thetaOutput = thetaInput*sign;
    else
        thetaOutput = thetaInput*sign;
    end
end

