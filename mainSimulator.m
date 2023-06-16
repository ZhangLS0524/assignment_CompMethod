function output=mainSimulator()
    serviceTime();
    interarrival();
    %Fixed Number of Users
    count_cus = Input ('Please enter the total no. customer for this simulation: ', 99);
    
%-------------------------------------------------Random Generator for Customer--------------------------------------------------------------------------% 


% User input to choose the type of random number generator
disp('Choose the type of random number generator:')
disp('1. Mixed LCG')
disp('2. Additive LCG')
disp('3. Multiplication LCG')
disp('4. Random Variate Generator for Exponential Distribution')
disp('5. Random Variate Generator for Uniform Distribution')
seed = ceil(rand() * 52337);

rngType = input('Enter the corresponding number: ');

% Adjust the range of random numbers based on the selected generator type
switch rngType
    case 1 % Mixed LCG
        maxRange = 20;
        randomItem = mod(generateRandom(count_cus, maxRange, rngType, seed), maxRange);
        randomItem = randomItem + 1;
    case 2 % Additive LCG
        maxRange = 20;
        randomItem = mod(generateRandom(count_cus, maxRange, rngType, seed), maxRange);
        randomItem = randomItem + 1;
    case 3
        maxRange = 20;
        randomItem = mod(generateRandom(count_cus, maxRange, rngType, seed), maxRange);
        randomItem = randomItem + 1;
        
    case 4 % Random Variate Generator for Exponential Distribution
        maxRange = 20;
        randomItem = generateRandom(count_cus, maxRange, rngType, seed);
    case 5 % Random Variate Generator for Uniform Distribution
        maxRange = 20;
        randomItem = generateRandom(count_cus, maxRange, rngType, seed);
    otherwise
        error('Invalid option selected.');
end


    
switch rngType
    case 1 % Mixed LCG       
        maxRange = 100;
        randomInterArrivalTime = mod(generateRandom(count_cus, maxRange, rngType, seed), maxRange);
        randomInterArrivalTime = randomInterArrivalTime + 1;
        randomServiceTime = mod(generateRandom(count_cus, maxRange, rngType, seed), maxRange);
        randomServiceTime = randomServiceTime + 1;
    case 2 % Additive LCG
        maxRange = 100;
        randomInterArrivalTime = mod(generateRandom(count_cus, maxRange, rngType, seed), maxRange);
        randomInterArrivalTime = randomInterArrivalTime + 1;
        randomServiceTime = mod(generateRandom(count_cus, maxRange, rngType, seed), maxRange);
        randomServiceTime = randomServiceTime + 1;
    case 3 % Multiplicative LCG
        maxRange = 100;
        randomInterArrivalTime = mod(generateRandom(count_cus, maxRange, rngType, seed), maxRange);
        randomInterArrivalTime = randomInterArrivalTime + 1;
        randomServiceTime = mod(generateRandom(count_cus, maxRange, rngType, seed), maxRange);
        randomServiceTime = randomServiceTime + 1;
        
    case 4 % Random Variate Generator for Exponential Distribution
        maxRange = 100;
        randomInterArrivalTime = generateRandom(count_cus, maxRange, rngType, seed);
        randomServiceTime = generateRandom(count_cus, maxRange, rngType, seed);
    case 5 % Random Variate Generator for Uniform Distribution
        maxRange = 100;
        randomInterArrivalTime = generateRandom(count_cus, maxRange, rngType, seed);
        randomServiceTime = generateRandom(count_cus, maxRange, rngType, seed);
    otherwise
        error('Invalid option selected.');
end

%---------------------------------------------------------Calculation---------------------------------------------------------------------------------%

%Inter-Arrival Time 

for i = 1:count_cus
    if randomInterArrivalTime(i) >= 1 & randomInterArrivalTime(i) <= 30
       interArrivalTime(i) = 1; 
    elseif randomInterArrivalTime(i) >= 31 & randomInterArrivalTime(i) <= 55
       interArrivalTime(i) = 2;
    elseif randomInterArrivalTime(i) >= 56 & randomInterArrivalTime(i) <= 75
       interArrivalTime(i) = 3;
    elseif randomInterArrivalTime(i) >= 76 & randomInterArrivalTime(i) <= 85
       interArrivalTime(i) = 4;
    elseif randomInterArrivalTime(i) >= 86 & randomInterArrivalTime(i) <= 100
       interArrivalTime(i) = 5;
    end
end


%Arrival Time
arrivalTime(1) = 0;
for i = 2:count_cus
    arrivalTime(i) = arrivalTime(i-1) + interArrivalTime(i);
end

%Calculate Counter for first loop
i = 1;
stop = 1;
while (i < count_cus & stop < 2)
    % Go to express counter
    if randomItem(i) <= 5 
        counter(i) = 3;
        serviceBeginEx(i) = arrivalTime(i);
        serviceTimeEx(i) = calCounterEx(randomServiceTime(i));
        serviceEndEx(i) = serviceTimeEx(1) + serviceBeginEx(1);
        waitingTimeEx(i) = serviceBeginEx(i) - arrivalTime(i);
        timeSpendEx(i) = serviceTimeEx(i) + waitingTimeEx(i);
        serviceBegin1(i) = 0;
        serviceTime1(i) = 0;
        serviceEnd1(i) = 0;
        serviceBegin2(i) = 0;
        serviceTime2(i) = 0;
        serviceEnd2(i) = 0;
        serviceBegin(i) = serviceBeginEx(i);
        serviceEnd(i) = serviceEndEx(i);
        noCusC3 = i;
        
    % Go to Counter 1
    elseif randomItem(i) > 5 & randomItem(i) <= 20
        counter(i) = 1;
        serviceBegin1(i) = arrivalTime(i);
        serviceTime1(i) = calCounter1(randomServiceTime(i));
        serviceEnd1(i) = serviceBegin1(1) + serviceTime1(1);
        waitingTime1(i) = serviceBegin1(i) - arrivalTime(i);
        timeSpend1(i) = serviceTime1(i) + waitingTime1(i);
        serviceBeginEx(i) = 0;
        serviceTimeEx(i) = 0;
        serviceEndEx(i) = 0;
        serviceBegin2(i) = 0;
        serviceTime2(i) = 0;
        serviceEnd2(i) = 0;
        serviceBegin(i) = serviceBegin1(i);
        serviceEnd(i) = serviceEnd1(i);
        noCusC1 = i;
    end
    i = i + 1;
    stop = stop + 1;
end

%To track customer on counter
noC1 = 1;
noC2 = 1;
noC3 = 1;

%For Second Loop and Above
for loop = 2:count_cus
    
    %Express Counter
     if randomItem(loop) <= 5 
        counter(loop) = 3;
        serviceBeginEx(loop) = serviceCheck(serviceEndEx(noC3), arrivalTime(loop)); 
        serviceTimeEx(loop) = calCounterEx(randomServiceTime(loop));
        serviceEndEx(loop) = serviceTimeEx(loop) + serviceBeginEx(loop);
        waitingTimeEx(loop) = serviceBeginEx(loop) - arrivalTime(loop);
        timeSpendEx(loop) = serviceTimeEx(loop) + waitingTimeEx(loop);
        serviceBegin1(loop) = 0;
        serviceTime1(loop) = 0;
        serviceEnd1(loop) = 0;
        serviceBegin2(loop) = 0;
        serviceTime2(loop) = 0;
        serviceEnd2(loop) = 0;
        serviceBegin(loop) = serviceBeginEx(loop);
        serviceEnd(loop) = serviceEndEx(loop);
        noC3 = loop;
    
    %Go to Counter 1 or 2
    elseif randomItem(loop) > 5 & randomItem(loop) <= 20
        %Counter 1 busy, counter 2
        if serviceEnd1(noC1) > serviceEnd2(noC2)
            counter(loop) = 2;
            serviceBegin2(loop) = serviceCheck(serviceEnd2(noC2),arrivalTime(loop));
            serviceTime2(loop) = calCounter2(randomServiceTime(loop));
            serviceEnd2(loop) = serviceTime2(loop) + serviceBegin2(loop);
            waitingTime2(loop) = serviceBegin2(loop) - arrivalTime(loop);
            timeSpend2(loop) = serviceTime2(loop) + waitingTime2(loop);
            serviceBegin1(loop) = 0;
            serviceTime1(loop) = 0;
            serviceEnd1(loop) = 0;
            serviceBeginEx(loop) = 0;
            serviceTimeEx(loop) = 0;
            serviceEndEx(loop) = 0;
            serviceBegin(loop) = serviceBegin2(loop);
            serviceEnd(loop) = serviceEnd2(loop);
            noC2 = loop;
        %Counter 2 busy, counter 1
        elseif serviceEnd2(noC2) > serviceEnd1(noC1)
            counter(loop) = 1;
            serviceBegin1(loop) = serviceCheck(serviceEnd1(noC1), arrivalTime(loop));
            serviceTime1(loop) = calCounter1(randomServiceTime(loop));
            serviceEnd1(loop) = serviceTime1(loop) + serviceBegin1(loop);
            waitingTime1(loop) = serviceBegin1(loop) - arrivalTime(loop);
            timeSpend1(loop) = serviceTime1(loop) + waitingTime1(loop);
            serviceBegin2(loop) = 0;
            serviceTime2(loop) = 0;
            serviceEnd2(loop) = 0;
            serviceBeginEx(loop) = 0;
            serviceTimeEx(loop) = 0;
            serviceEndEx(loop) = 0;
            serviceBegin(loop) = serviceBegin1(loop);
            serviceEnd(loop) = serviceEnd1(loop);
            noC1 = loop;
            
        elseif serviceEnd1(noC1) == serviceEnd2(noC2)
            counter(loop) = 1;
            arrivalTime(loop);
            serviceBegin1(loop) = serviceCheck(serviceEnd1(noC1), arrivalTime(loop));
            serviceTime1(loop) = calCounter1(randomServiceTime(loop));
            serviceEnd1(loop) = serviceTime1(loop) + serviceBegin1(loop);
            waitingTime1(loop) = serviceBegin1(loop) - arrivalTime(loop);
            timeSpend1(loop) = serviceTime1(loop) + waitingTime1(loop);
            serviceBegin2(loop) = 0;
            serviceTime2(loop) = 0;
            serviceEnd2(loop) = 0;
            serviceBeginEx(loop) = 0;
            serviceTimeEx(loop) = 0;
            serviceEndEx(loop) = 0;
            serviceBegin(loop) = serviceBegin1(loop);
            serviceEnd(loop) = serviceEnd1(loop);
            nosC1 = loop;
        end
    end
    i = i + 1;
end





%-------------------------------------------------Output--------------------------------------------------------------------------%
%logs
disp (' ')
disp ('--------------------------------logs--------------------------------------------------- ')
for loop = 1:count_cus
fprintf('Arrival of %2d customer at minute%3d. \n', loop, arrivalTime(loop))
fprintf ('The %2d customer has total of%3d items and queue at counter%1d \n', loop, randomItem(loop), counter(loop))
fprintf ('Service for %2d customer started at minute%3d .\n', loop, serviceBegin(loop))
fprintf ('Departure of %2d customer at minute%3d. \n', loop, serviceEnd(loop))
disp ('--------------------------------------------------------------------------------------- ')
end

disp (' ')

disp('--------------------------------------------------------------------------------------')
disp('|   Customer   |  RN. for Inter-   |   Inter-Arrival   |   Arrival   |   Number of   |')
disp('|      NO.     |   Arrival Time    |       Time        |    Time     |     items.    |')
for loop = 1:count_cus
fprintf('|      %2d      |        %3d        |        %3d        |    %3d      |      %3d      |\n', loop, randomInterArrivalTime(loop), interArrivalTime(loop), arrivalTime(loop), randomItem(loop))
end
disp('--------------------------------------------------------------------------------------')

disp(' ')


disp('Counter 1')
disp('-----------------------------------------------------------------------------------------------------------------------------------------')
disp('|   Customer   |   Arrival   |  RN. for Service  |   Service Time   |   Service   |   Service Time   |   Waiting   |   Time Spends in   |')
disp('|      NO.     |    Time     |        Time       |       Begin      |    Time     |        End       |    Time     |     The System     |')
for loop = 1:count_cus
    if serviceEnd1(loop) == 0
        
    else
fprintf('|      %2d      |    %3d      |        %3d        |       %3d        |     %3d     |       %3d        |     %3d     |         %3d        |\n', loop, arrivalTime(loop), randomServiceTime(loop), serviceBegin1(loop), serviceTime1(loop), serviceEnd1(loop), waitingTime1(loop), timeSpend1(loop))
    end
end
disp('-----------------------------------------------------------------------------------------------------------------------------------------')

disp(' ')

disp('Counter 2')
disp('-----------------------------------------------------------------------------------------------------------------------------------------')
disp('|   Customer   |   Arrival   |  RN. for Service  |   Service Time   |   Service   |   Service Time   |   Waiting   |   Time Spends in   |')
disp('|      NO.     |    Time     |        Time       |       Begin      |    Time     |        End       |    Time     |     The System     |')
for loop = 1:count_cus
    if serviceEnd2(loop) == 0
        
    else
fprintf('|      %2d      |    %3d      |        %3d        |       %3d        |     %3d     |       %3d        |     %3d     |         %3d        |\n', loop, arrivalTime(loop), randomServiceTime(loop), serviceBegin2(loop), serviceTime2(loop), serviceEnd2(loop), waitingTime2(loop), timeSpend2(loop))
    end
end
disp('-----------------------------------------------------------------------------------------------------------------------------------------')

disp(' ')

disp('Express Counter')
disp('-----------------------------------------------------------------------------------------------------------------------------------------')
disp('|   Customer   |   Arrival   |  RN. for Service  |   Service Time   |   Service   |   Service Time   |   Waiting   |   Time Spends in   |')
disp('|      NO.     |    Time     |        Time       |       Begin      |    Time     |        End       |    Time     |     The System     |')
for loop = 1:count_cus
    if serviceEndEx(loop) == 0
        
    else
        fprintf('|      %2d      |    %3d      |        %3d        |       %3d        |     %3d     |       %3d        |     %3d     |         %3d        |\n', loop, arrivalTime(loop), randomServiceTime(loop), serviceBeginEx(loop), serviceTimeEx(loop), serviceEndEx(loop), waitingTimeEx(loop), timeSpendEx(loop))
    end
end
disp('-----------------------------------------------------------------------------------------------------------------------------------------')

disp(' ')


%------------------------------------------------------- EVALUATION -------------------------------------------------------

if serviceEnd2(noC2) ~= 0
resultEva(count_cus, counter, waitingTime1, waitingTime2, waitingTimeEx, serviceEnd1, serviceEnd2, serviceEndEx, interArrivalTime, arrivalTime, serviceTime1, serviceTime2, serviceTimeEx, timeSpend1, timeSpend2, timeSpendEx);
else
resultEva(count_cus, counter, waitingTime1, 0, waitingTimeEx, serviceEnd1, 0, serviceEndEx, interArrivalTime, arrivalTime, serviceTime1, 0, serviceTimeEx, timeSpend1, 0, timeSpendEx);
end


    