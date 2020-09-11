
function distances=comp_distance1(centroid,X)

 distances = bsxfun(@minus,centroid*X',0.5*sum(centroid.^2,2));