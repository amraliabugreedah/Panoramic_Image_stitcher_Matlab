function [ LoG_mask ] = log_filt(sig)
% This function forms the log filter given sigma
    
    s = 2*ceil(sig*3)+1;
    LoG_mask = zeros(s,s); %Laplacian of gaussian mask
    ff = floor(s/2);
    cc = ceil(s/2);

    for i=-ff:ff
        for j=-ff:ff
            temp1 = -1/(pi*(sig)^2);
            temp2 = 1-(((i^2)+(j^2))/(2*(sig^2)));
            temp3 = exp(-((i^2)+(j^2))/(2*(sig^2)));
            LoG_mask(i+cc,j+cc) = temp1*temp2*temp3;
        end
    end

end

