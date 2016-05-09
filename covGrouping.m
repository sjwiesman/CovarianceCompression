function [ groupings ] = covGrouping( P, m )
    groupings = java.util.ArrayList;
    for i = 1:length(P)
       box = java.util.ArrayList;
       box.add(i);
       groupings.add(box);
    end
    
    correlations = abs(corrcoef(P));
    for i = 1:length(correlations)
        correlations(i,i) = 0;
    end
    
    while memoryUsage(groupings) < m
        [maxElem, linearIndex] = max(correlations(:));
        if maxElem == 0
            break;
        end
        
        [row,col] = ind2sub(size(P), linearIndex);
        correlations(row,col) = 0;
        correlations(col,row) = 0;
        
        group1index = -1;
        for i = 0:groupings.size() - 1
            if groupings.get(i).contains(row) 
                group1index = i;
            end
        end
       
        if groupings.get(group1index).contains(col)
            continue;
        end
        
        group1 = groupings.remove(group1index);
        
        group2index = -1;
        for i = 0:groupings.size() - 1
            if groupings.get(i).contains(col) 
                group2index = i;
            end
        end
        
        group2 = groupings.remove(group2index);

        union = java.util.ArrayList;
        union.addAll(group1);
        union.addAll(group2);
        
        newMemory = memoryUsage(groupings) + union.size()^2;
        if newMemory > m 
            groupings.add(group1);
            groupings.add(group2);
        else
            groupings.add(union);
        end
    end
end

