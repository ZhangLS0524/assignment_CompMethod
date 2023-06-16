function output = generateRandom(count_cus, maxRange, rngType, seed)
    random = zeros(1, count_cus);

    % Generate random based on the selected generator type
    switch rngType
        case 1 % Mixed LCG
            % Define parameters for Mixed LCG
            a = 3;
            c = 43;
            m = 1337;
            
            % Generate randoms using Mixed LCG
            random(1) = mod (a*seed + c, m);
            for i = 2:count_cus
                numbers(i) = mod(a*random(i-1)+c, m);
                random(i) = mod(numbers(i), m);
            end
            
        case 2 % Additive LCG
            % Define parameters for Additive LCG
            a = 1;      % Multiplier
            c = 13;     % Increment
            m = 1337;    % Modulus

            % Generate randoms using Additive LCG
            random(1) = mod (a*seed+ c, m);
            for i = 2:count_cus
                numbers(i) = mod(a*random(i-1)+c, m);
                random(i) = mod(numbers(i), m);
            end

        case 3 % Multiplication LCG
            % Define parameters for Multiplication LCG
            a = 13;       % Multiplier
            c = 0;
            m = 1337;      % Modulus

            % Generate randoms using Multiplication LCG
            random(1) = mod (a*seed+ c, m);
            for i = 2:count_cus
                numbers(i) = mod(a*random(i-1)+c, m);
                random(i) = mod(numbers(i), m);
            end

        case 4 % Random Variate Generator for Exponential Distribution
            % Define parameters for Exponential Distribution
            seed = 369;
            
            % Generate randoms using Exponential Distribution
            for i = 1:count_cus
                lambda(i) = randexp(rand);
                random(i) = ceil(mod(lambda(i)*seed, maxRange));
                random(i) = random(i) + 1;
            end

        case 5 % Random Variate Generator for Uniform Distribution
            % Define parameters for Uniform Distribution
            minRange = 1;
            
            % Generate randoms using Uniform Distribution
            for i = 1:count_cus
                random(i) = ceil(minRange + (maxRange - minRange)*rand);
                random(i) = random(i) + 1;
            end
            
        otherwise
            error('Invalid option selected.');
    end
    
    output = random;
end

