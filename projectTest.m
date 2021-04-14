a = arduino('com3','uno');

%Dummy Signal
pulse = zeros(1, 100);
freq = randi([1, 100], 1, 100);
pulse(25) = 4;
pulse(50) = 15;
pulse(75) = 25;

bassVol = max(pulse);
temp =0;

dcR = 0;
dcB = 0;
dcG = 0;

for i=1:100
    
    writePWMDutyCycle(a, 'D3', dcR);
    writePWMDutyCycle(a, 'D6', dcB);
    writePWMDutyCycle(a, 'D5', dcG);
    
    if pulse(i)>= 1
        temp = pulse(i)/bassVol;
        if freq(i) >= 0 && freq(i) <= 16 
            dcR = pulse(i)/bassVol;
            dcB = 0;
            dcG = 0;
        elseif freq(i) >= 17 && freq(i) <= 33
            dcR = pulse(i)/bassVol;
            dcB = pulse(i)/bassVol;
            dcG = 0;
        elseif freq(i) >= 34 && freq(i) <= 49
            dcB = pulse(i)/bassVol;
            dcR = 0;
            dcG = 0;
        elseif freq(i) >= 50 && freq(i) <= 66
            dcB = pulse(i)/bassVol;
            dcR = 0;
            dcG = pulse(i)/bassVol;
        elseif freq(i) >= 67 && freq(i) <= 84
            dcB = 0;
            dcR = 0;
            dcG = pulse(i)/bassVol;
        elseif freq(i) >= 85 && freq(i) <= 100
            dcB = 0;
            dcR = pulse(i)/bassVol;
            dcG = pulse(i)/bassVol;
           
            end
    else
            dcR = dcR - (0.05*temp);
            dcB = dcB - (0.05*temp);
            dcG = dcG - (0.05*temp);
            if dcR <= 0 
                dcR = 0;
            elseif dcR >= 1
                dcR = 1;
            end
            
            if dcB <= 0
                dcB = 0;
            elseif dcB >= 1
                dcB = 1;
            end
            
            if dcG <= 0
                dcG = 0;
            elseif dcG >= 1
                dcG = 1;
            end
        end
      pause(0.01);   
    end
   
   
               




clear a