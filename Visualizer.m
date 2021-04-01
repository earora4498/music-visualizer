clc
clear
close all

filename = 'Ocean Drive.mp3';

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
figure(1);
plot(freq, DFT); xlabel('Frequency'); ylabel('Magnitude'); title('Original signal');
%-----------------------------------


%create and apply butterworth filter----------
fc_low = 200;
%low cutoff frequency to isolate bass

figure(2);
[b, a] = butter(6,fc_low/(fs/2));
freqz(b,a);

filteredBass = filter(b, a, X);
%---------------------------------------------


%plot filtered signal in frequency domain-----
DFT_filtered = fft(filteredBass);
DFT_filtered = abs(dataFlip(DFT_filtered));
figure(3);
plot(freq, DFT_filtered); xlabel('Frequency'); ylabel('Magnitude'); title('Lowpass filter');
%---------------------------------------------

%create and apply butterworth filter----------
fc_high = 1500;
%high cutoff frequency to isolate melody

figure(4);
[b2, a2] = butter(9,fc_high/(fs/2), 'high');
freqz(b2,a2);
filteredMelody = filter(b2, a2, X);
%---------------------------------------------


%plot filtered signal in frequency domain-----
DFT_filtered2 = fft(filteredMelody);
DFT_filtered2 = abs(dataFlip(DFT_filtered2));

figure(5);
plot(freq, DFT_filtered2); xlabel('Frequency'); ylabel('Magnitude'); title('Highpass filter');
%---------------------------------------------


%create and play filtered audio (uncomment)---
bassPlayer = audioplayer(filteredBass, fs);
play(bassPlayer);

melodyPlayer = audioplayer(filteredMelody, fs);
%play(melodyPlayer);
%---------------------------------------------
