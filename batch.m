function batch(start_val,end_val,filename)

X = [];
Y = [];
Z = [];
R = [];

    for i = start_val:end_val
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
            save('-mat',filename,'X','Y','Z','R');
        endif
    end

    save('-mat',filename,'X','Y','Z','R');

end