function [dy] = BackwardY(v)
% Helper function that computes the backward differences of field v
% along the y direction

% dy = [ v(1,:,:) ; v(2:end-1,:,:) - v(1:end-2,:,:) ; - v(end-1,:,:)];

dy = [ v(1,:,:)-v(end,:,:) ; v(2:end,:,:) - v(1:end-1,:,:)];

end

