function output = serviceCheck (num1, num2)
    
    if num1 > num2
        serviceBegin = num1;
    elseif num1 < num2
        serviceBegin = num2;
    elseif num1 == num2
        serviceBegin = num1;
    end
    
    output = serviceBegin;
        
    