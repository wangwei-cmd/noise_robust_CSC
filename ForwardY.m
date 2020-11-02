function [dy] = ForwardY(v)
% Helper function that computes the forward differences of field v
% along the y direction


dy=[v(2:end,:,:) - v(1:end-1,:,:);v(1,:,:)-v(end,:,:)];

end
