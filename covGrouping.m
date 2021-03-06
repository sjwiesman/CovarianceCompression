function [ boxes ] = covGrouping( P, m )
    boxes = java.util.ArrayList;
    for i = 1:length(P)
       box = java.util.ArrayList;
       box.add(i);
       boxes.add(box);
    end
    
    correlations = abs(corrcoef(P));
    for i = 1:length(correlations)
        correlations(i,i) = 0;
    end
    
    while memoryUsage(boxes) < m
        [maxElem, linearIndex] = max(correlations(:));
        if maxElem == 0
            break;
        end
        
        [row,col] = ind2sub(size(P), linearIndex);
        correlations(row,col) = 0;
        correlations(col,row) = 0;
        
        box1index = -1;
        for i = 0:boxes.size() - 1
            if boxes.get(i).contains(row) 
                box1index = i;
            end
        end
       
        if boxes.get(box1index).contains(col)
            continue;
        end
        
        box1 = boxes.remove(box1index);
        
        box2index = -1;
        for i = 0:boxes.size() - 1
            if boxes.get(i).contains(col) 
                box2index = i;
            end
        end
        
        box2 = boxes.remove(box2index);

        union = java.util.ArrayList;
        union.addAll(box1);
        union.addAll(box2);
        
        newMemory = memoryUsage(boxes) + union.size()^2;
        if newMemory > m 
            boxes.add(box1);
            boxes.add(box2);
        else
            boxes.add(union);
        end
    end
end

