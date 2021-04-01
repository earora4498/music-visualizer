a = arduino('com3','uno');

for i=1:10
    writeDigitalPin(a,'D3',0);
    writeDigitalPin(a,'D6',1);
    
    pause(0.5);
    
    writeDigitalPin(a,'D6',0);
    writeDigitalPin(a,'D5',1);
    
    pause(0.5);
    
    writeDigitalPin(a,'D5',0);
    writeDigitalPin(a,'D3',1);
    
    pause(0.5);
end

clear a