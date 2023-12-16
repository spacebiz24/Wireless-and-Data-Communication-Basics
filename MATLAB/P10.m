% Analysis of Bit Error Rate(BER) of receivers with Equal Gain Combining(EGC) 
% receiving diversity in frequency-flat and in slowly varying fading channel

clc;
close all;

m = 10^5;
snr_dB = 0:20;
for i = 1:length(snr_dB)
    n_err = 0;
    n_bits = 0;
    while n_err < 100
        inf_bits = round(rand(1,m));
        x = -2*(inf_bits - 0.5); % BPSK modulator
        N0 = 1/10^(snr_dB(i)/10); % Noise variance
        nl = sqrt(N0/2) * abs(randn(1,length(x)) + i*randn(1, length(x))); % noise 1
        n2 = sqrt(N0/2) * abs(randn(1,length(x)) + i*randn(1, length(x))); % noise 2
        hl = sqrt(0.5) * abs(randn(1,length(x)) + i*randn(1, length(x))); % rayleigh amplitude 1
        h2 = sqrt(0.5) * abs(randn(1,length(x)) + i*randn(1, length(x))); % rayleigh amplitude 2
        yl = hl.*x + nl;
        y2 = h2.*x + n2;
        y_equal = 0.5 * (yl + y2); % Equal Gain combining
        est_bits = y_equal < 0; % Decision making at the Receiver
        diff = inf_bits - est_bits;
        n_err = n_err + sum(abs(diff));
        n_bits = n_bits + length(inf_bits);
    end
    BER(i) = n_err / n_bits;
end
semilogy(snr_dB, BER, 'or-', 'LineWidth', 2);
legend('Rayleigh EGC Simulated');
axis([0 20 10^-5 1]);
xlabel('SNR (dB)');
ylabel('BER');
grid on;
