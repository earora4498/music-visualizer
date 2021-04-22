% clear
% close all
% a = arduino('/dev/cu.usbmodem144301','Uno');


% pause on

[voice, Fs] = audioread('24K Magic (Official Acapella + Talkbox) Bruno Mars.mp3');
voice = voice(:,1);
voiceLen = length(voice);
dt = 1/Fs;
time = 0:dt:(length(voice)*dt)-dt;
timeTotal = length(time);

Twin = 0.1;
Nwin = round(Fs*Twin);
ovrlp = 0;
win = hamming(Nwin);
nxtPwr = ceil(log10(Nwin)/log10(2))+1;
Nfft = 2^(nxtPwr);
[s,w,t] = spectrogram(voice, win, ovrlp, Nfft, Fs, 'yaxis', 'psd');
spectrogram(voice, win, ovrlp, Nfft, Fs, 'yaxis', 'psd');

[~, loc] = max(s);
guesses = (loc - 1) * Fs / Nfft;

gleg = length(guesses);
glegmax = max(guesses);
sound(voice, Fs);
window = timeTotal/gleg;
% for i = 1:gleg
%     if guesses(i) < 150
%         writeDigitalPin(a,'D3',1);
%         pause(0.1);
%         writeDigitalPin(a,'D3',0);
%     elseif guesses(i) < 300 && guesses(i) > 150
%         writeDigitalPin(a,'D5',1);
%         pause(0.1);
%         writeDigitalPin(a,'D5',0);
%     else
%         writeDigitalPin(a,'D6',1);
%         pause(0.1);
%         writeDigitalPin(a,'D6',0);
%     end
% end

f = zeros(1,450);
for i=1:450;
    f(i) = guesses(i);
end
f = round(f);
writematrix(f,'f.txt');


