function [H] = homog(pg,pd) 

[val, pts] = size (pg);
mat = zeros( 2*pts, 9);
[row,column] = size(mat);

mat(1:2:row,1) = pg (1,:);
mat(1:2:row,2) = pg (2,:);
mat(1:2:row,3) = 1;
mat(1:2:row,7) = -1 .* pd(1,:) .* pg(1,:);
mat(1:2:row,8) = -1 .* pd(1,:) .* pg(2,:);
mat(1:2:row,9) = -1 .* pd(1,:);

mat(2:2:row,4) = pg (1,:);
mat(2:2:row,5) = pg (2,:);
mat(2:2:row,6) = 1;
mat(2:2:row,7) = -1 .* pd(2,:) .* pg(1,:);
mat(2:2:row,8) = -1 .* pd(2,:) .* pg(2,:);
mat(2:2:row,9) = -1 .* pd(2,:);



transMat = mat.' ;

mat
transMat


D =  transMat * mat;


[eigenVector, eigenValues] = eig(D);

[minimum,indice] = min(diag(eigenValues).');
H = zeros(3,3);
H(1,:) = eigenVector(1:3,indice);
H(2,:) = eigenVector(4:6,indice);
H(3,:) = eigenVector(7:9,indice);

H

end