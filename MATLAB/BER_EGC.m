% Bit Error Rate of Equal Gain Combining
clc;
close all;
clear all;
% Number of information bits
m= 10^3;
%Range of SNR values
snrdB = [0:1:20];
for j=1:1:length(snrdB)
    nerr = 0;
    nbits = 0;
    while nerr < 100
        infbits=round(rand(1,m));
        % BPSK modulator
        x=-2*(infbits-0.5);
        % Noise variance
        N0=1/10^(snrdB(j)/10);
        nl= sqrt(N0/2)*abs((randn(1,length(x)) + i*randn(1, length(x)))); %noise for the first
        n2 = sqrt(N0/2)*abs((randn(1,length(x)) + i*randn(1,length(x)))); %noise for the second
        hl =sqrt(0.5)*abs((randn(1,length(x)) + i*randn(1, length(x)))); %rayleigh amplitude
        h2 = sqrt(0.5)*abs((randn(1,length(x))+ i*randn(1 , length(x)))); %orayleigh amplitude 2
        %Equal Gain combining
        yl =hl.*x+nl; % Signal 1
        y2 =h2.*x+n2; % Signal 2
        yequal = 0.5*(yl +y2);
        % dec metric=(norm(y equal- hl *x-h2 *x)y^2;
        % Decision making at the Receiver
        estbits=yequal<0;
        % Calculate Bit Errors
        diff=infbits-estbits;
        nerr=nerr+sum(abs(diff));
        nbits=nbits+length(infbits);
    end
    % Calculate Bit Error Rate
    BER(j)=nerr/nbits;
end
semilogy(snrdB,BER,'or-','LineWidth',2);
legend('Rayleigh EGC Simulated', 'Rayleigh Theoretical');
axis([0 20 10^-5 1]);
xlabel('SNR (dB)');
ylabel('BER');
grid on;
