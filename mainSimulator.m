function output=mainSimulator()
    serviceTime();
    interarrival();
    %Fixed Number of Users
    count_cus = Input ('Please enter the total no. customer for this simulation: ', 99);
    
%-------------------------------------------------Random Item for Customer--------------------------------------------------------------------------%
minItem = 1;
maxItem = 21; 

for i = 1:count_cus
    randomItem(i) = floor((maxItem - minItem) * rand() + minItem);
end

for i= 1:count_cus
    randomServiceTime(i) = floor(rand()*99) + 1;
end

for i= 1:count_cus
    randomInterArrivalTime(i) = floor(rand()*99) + 1;
end 

    
%---------------------------------------------------------Calculation=====--------------------------------------------------------------------------%

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
noCusC1 = 1;
noCusC2 = 1;
noCusC3 = 1;

%For Second Loop and Above
for loop = 2:count_cus
    
    %Express Counter
     if randomItem(loop) <= 5 
        counter(loop) = 3;
        arrivalTime(loop);
        serviceBeginEx(loop) = serviceCheck(serviceEndEx(noCusC3), arrivalTime(loop)); 
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
        noCusC3 = loop;
    
    %Go to Counter 1 or 2
    elseif randomItem(loop) > 5 & randomItem(loop) <= 20
        %Counter 1 busy, counter 2
        if serviceEnd1(noCusC1) > serviceEnd2(noCusC2)
            counter(loop) = 2;
            arrivalTime(loop);
            serviceBegin2(loop) = serviceCheck(serviceEnd2(noCusC2),arrivalTime(loop));
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
            noCusC2 = loop;
        %Counter 2 busy, counter 1
        elseif serviceEnd2(noCusC2) > serviceEnd1(noCusC1)
            counter(loop) = 1;
            arrivalTime(loop);
            serviceBegin1(loop) = serviceCheck(serviceEnd1(noCusC1), arrivalTime(loop));
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
            noCusC1 = loop;
            
        elseif serviceEnd1(noCusC1) == serviceEnd2(noCusC2)
            counter(loop) = 1;
            arrivalTime(loop);
            serviceBegin1(loop) = serviceCheck(serviceEnd1(noCusC1), arrivalTime(loop));
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
            noCusC1 = loop;
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



    





    