clc
clear
close all
 
filename = 'Bruno Mars - 24K Magic (Official Music Video).mp3';
 
%read in audio file-----------------
[X, fs] = audioread(filename);
X = X(:,1);
N = length(X);
t = (0:N-1)/fs;
%-----------------------------------

%plot in frequency domain-----------
DFT = fft(X);
DFT = abs(dataFlip(DFT));
freq = 1:N;
%-----------------------------------
 
fc_high = 300;
%low cutoff frequency to isolate bass
 
figure(4);
[b2, a2] = butter(9,fc_high/(fs/2), 'low');
freqz(b2,a2);
filteredBass = filter(b2, a2, X);
%---------------------------------------------
 
figure(5);
x1 = fft(filteredBass);
dt1 = 1/fs;
df1 = fs/length(filteredBass);
time1 = 0:dt1:(length(filteredBass)*dt1)-dt1;
plot(time1,abs(filteredBass));
absBass = abs(filteredBass);
bassVal = absBass./.9.*255;
m = max(bassVal);
figure(6);
bassVal(bassVal > 255) = 255;


plot(time1,bassVal);
%a = arduino();
normV = bassVal;
Twin = 0.1;

TwinIn = Twin/dt1;
p = length(normV)./TwinIn;
voltages = zeros(1,450);
for i=1:450;
    voltages(i) = normV(i*round(TwinIn));
end

vals = round(voltages);

writematrix(vals,'bassFrequencies.txt');

