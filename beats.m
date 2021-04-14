clc
clear
close all
%a = arduino('/dev/cu.usbmodem14401','Uno');
filename = 'weFoundLove.mp3';
 
%read in audio file and plots-----------------
[X, fs] = audioread(filename);
X = X(:,1);
N = length(X);
dt = 1/fs;
t = 0:dt:(N*dt)-dt;
time = N/fs;
time = round(time);
figure(1);
plot(t,X); xlabel('Time'); ylabel('Amplitude'); title('Original Signal');
%-----------------------------------

 
%plot in frequency domain-----------
DFT = fft(X);
DFT = abs(dataFlip(DFT));
freq = 1:N;
figure(2);
plot(freq, DFT); xlabel('Frequency'); ylabel('Magnitude'); title('Original signal');
%-----------------------------------


%create and apply butterworth filter----------
fc_low = 200;
%low cutoff frequency to isolate bass

figure(3);
[b, a] = butter(6,fc_low/(fs/2));
freqz(b,a);

filteredBass = filter(b, a, X);
%---------------------------------------------



%plot filtered signal in frequency domain-----
DFT_filtered = fft(filteredBass);
DFT_filtered = abs(dataFlip(DFT_filtered));
figure(4);
plot(freq, DFT_filtered); xlabel('Frequency'); ylabel('Magnitude'); title('Lowpass filter');
xlim([4000000 5000000]);
%---------------------------------------------
 
 

 
%plot frequency vs time of filtered bass---
figure(5);
x1 = fft(filteredBass);
dt1 = 1/fs;
df1 = fs/length(filteredBass);
time1 = 0:dt1:(length(filteredBass)*dt1)-dt1;
plot(time1,abs(filteredBass)); xlabel('Seconds'); ylabel('Frequency'); title('Freq vs. Time');
xlim([0 5]);
%-------------------------------------------


%find peaks of bass----------------
figure(6);
findpeaks(abs(filteredBass), 'MinPeakDistance', 10000); xlabel('samples'); ylabel('frequency'); title('Peaks of Bass Frequency');
xlim([1000000 1800000]);
[pks, locs] = findpeaks(abs(filteredBass), 'MinPeakDistance', 10000);
figure(7);
findpeaks(abs(filteredBass), 'MinPeakDistance', 10000); xlabel('samples'); ylabel('frequency'); title('Peaks of Bass Frequency');
%----------------------------------


%find time in between each peak--------
timescale = rescale(locs,0,time);

loclen = length(locs);
interval = zeros(loclen);

for i = 1:loclen-1
    interval(i) = timescale(i+1) - timescale(i);
end
goodint = interval(:,1);
%-------------------------------------

%play song
%sound(X, fs);


%change color every beat---------------
%for i = 1:loclen
%    if mod(i,6) == 0
%        writeDigitalPin(a,'D3',1);
%        
%        pause(goodint(i));
%        writeDigitalPin(a,'D3',0);
%        
%   elseif mod(i,6) == 1
%       writeDigitalPin(a,'D3',1);
%        writeDigitalPin(a, 'D5', 1);
%        pause(goodint(i));
%        writeDigitalPin(a,'D3',0);
%        writeDigitalPin(a,'D5',0);
%    elseif mod(i,6) == 2
%        
%        writeDigitalPin(a, 'D5', 1);
%        pause(goodint(i));
%        
%        writeDigitalPin(a, 'D5', 0);
%    elseif mod(i,6) == 3
%        writeDigitalPin(a,'D6',1);
%        writeDigitalPin(a, 'D5', 1);
%        pause(goodint(i));
%        writeDigitalPin(a,'D6',0);
%        writeDigitalPin(a, 'D5', 0);
%    elseif mod(i,6) == 4
%        
%        writeDigitalPin(a, 'D6', 1);
%        pause(goodint(i));
%       
%        writeDigitalPin(a, 'D6', 0);
%    
%    else
%        writeDigitalPin(a,'D3',1);
%        writeDigitalPin(a, 'D6', 1);
%        pause(goodint(i));
%        writeDigitalPin(a,'D3',0);
%        writeDigitalPin(a, 'D6', 0);
%    end
%end
    
