function [H] = homog(pg,pd) 

[coord, pts] = size (pg);
mat = zeros( 2*pts, 9);
[row,column] = size(mat);

meanPg = sum(pg') / pts
meanPd = sum(pd') / pts
Ag =  sqrt(2) / (sum(sqrt((pg(1,:) .- meanPg(1)) .**2 + (pg(2,:) .- meanPg(2)) .** 2))/pts )
Ad =  sqrt(2) / (sum(sqrt((pd(1,:) .- meanPd(1)) .**2 + (pd(2,:) .- meanPd(2)) .** 2))/pts )
Tg = [ Ag 0 -1*Ag*meanPg(1); 0 Ag -1*Ag*meanPg(2); 0 0 1];
Td = [ Ad 0 -1*Ad*meanPd(1); 0 Ad -1*Ad*meanPd(2); 0 0 1];
pg = [ pg ; ones(1,pts)];
pd = [pd ; ones(1,pts)];

pg = Tg * pg;
pd = Td * pd;


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



transMat = mat' ;

D =  transMat * mat;


[eigenVector, eigenValues] = eig(D);

[minimum,indice] = min(diag(eigenValues).');
H = zeros(3,3);
H(1,:) = eigenVector(1:3,indice);
H(2,:) = eigenVector(4:6,indice);
H(3,:) = eigenVector(7:9,indice);

H
H = Td' * H * Tg

end