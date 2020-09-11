

function centroid=comp_center1(label,X,n,k)

ind = sparse(label,1:n,1,k,n,n);
centroid = (spdiags(1./sum(ind,2),0,k,k)*ind)*X;