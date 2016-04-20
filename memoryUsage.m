function [ memory ] = memoryUsage( boxes )
    memory = 0;
    for i  = 0:boxes.size() - 1
        memory = memory + boxes.get(i).size()^2;
    end
end

