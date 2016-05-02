X = [];
Y = [];
Z = [];
R = [];

for i = 2:100
    P = randn(i);
    P = P * P';
    detP = det(P);
    for m = i:i^2
        Pnew = covCompression(P, m);
i
        assert(all(eig(Pnew - P) >= 0));
m
        detNew = det(Pnew);
        X = [X i^2];
        Y = [Y m];
        Z = [Z detNew - detP];
        R = [R detNew / detP];

    end
    if (rem(i,5) == 0)
        save -mat output_data X Y Z R
    endif
end

save -mat final_values X Y Z R

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

