function output = Input(message, size)
    
    %get input
    choice = input(message);
    boolean = 0;
    while (boolean == 0)
        if (choice < size+1 & choice > 0)
            boolean=1;
        else
            printf('\nPlease choose a valid number\n');
            %get input again
            choice = input(message);
        end
    end
    
    output = choice;