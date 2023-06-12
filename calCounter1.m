function output = calCounter1(num)
    
    if num >= 1 & num <= 10
        serviceTime1 = 5;
    elseif num >= 11 & num <= 25
        serviceTime1 = 6;
    elseif num >= 26 & num <= 50
        serviceTime1 = 7;
    elseif num >= 51 & num <= 80
        serviceTime1 = 8;
    elseif num >= 81 & num <= 100
        serviceTime1 = 9;
    end
    
    output = serviceTime1;