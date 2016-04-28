X = [];
Y = [];
Z = [];
R = [];

for i = 2:6
    P = randn(i);
    P = P * P';
    detP = det(P);
    for m = 2*i:i^2
        Pnew = covCompression(P, m);
        assert(all(eig(Pnew - P) >= 0));
        detNew = det(Pnew);
        X = [X i^2];
        Y = [Y m];
        Z = [Z detNew - detP];
        R = [R detNew / detP];
    end
end

X
Y
Z
R

%figure;
%plot(Y,R);

%figure;
%scatter3(X,Y,Z);
%hold on;
%xlabel('Original Size');
%ylabel('Compressed Size');
%zlabel('Differnce in Determinant');
%hold off;

%figure;
%scatter3(X,Y,R);
%hold on;
%xlabel('Original Size');
%ylabel('Compressed Size');
%zlabel('Ratio');
%hold off;