function [dx] = ForwardX(v)
% Helper function that computes the forward differences of field v
% along the x direction


% dx=[v(:,2:end,:) - v(:,1:end-1,:),v(:,1,:)-v(:,end,:)];

dx=[v(:,2:end,:) - v(:,1:end-1,:),v(:,1,:)-v(:,end,:)];
end

