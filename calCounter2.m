function output = calCounter2(num)
    
    if num >= 1 & num <= 15
        serviceTime2 = 6;
    elseif num >= 16 & num <= 45
        serviceTime2 = 7;
    elseif num >= 46 & num <= 70
        serviceTime2 = 8;
    elseif num >= 71 & num <= 80
        serviceTime2 = 9;
    elseif num >= 81 & num <= 100
        serviceTime2 = 10;
    end
    
    output = serviceTime2;