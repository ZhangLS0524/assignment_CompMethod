function output = calCounterEx(num)
    
    if num >= 1 & num <= 50
        serviceTimeEx = 3;
    elseif num >= 51 & num <= 65
        serviceTimeEx = 4;
    elseif num >= 66 & num <= 100
        serviceTimeEx = 5;
     end
    
    output = serviceTimeEx;