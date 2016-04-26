function P_sparse = covCompression(P, m)
    groupings = covGrouping(P,m);
    P_sparse  = eye(size(P));
    
    n = length(P);
    
    for i = 0:groupings.size() - 1
        group = groupings.get(i);
        d     = group.size();
        for j = 0:group.size()-1
            row = group.get(j);
            P_sparse(row,row) = (n/d) * P(row,row);
            for k = j + 1:group.size() - 1
                col = group.get(k);
                P_sparse(row,col) = (n/d) * P(row,col);
                P_sparse(col,row) = (n/d) * P(col,row);
            end
        end
    end
end