% Analysis of Bit Error Rate(BER) for BPSK signals over AWGN and Rayleigh channels
clc;
close all;

m = 10^5;
snr_dB = 0:20; 
for i = 1:length(snr_dB)
    n_err = 0;
    n_bits = 0;
    while n_err < 100
        inf_bits = round(rand(1,m));
        x = -2*(inf_bits - 0.5);
        N0 = 1/10^(snr_dB(i)/10);
        n = sqrt(N0/2) * abs(randn(1, length(x)) + i*randn(1,length(x)));
        h = sqrt(0.5) * (randn(1,length(x)) + i*randn(1,length(x)));
        y = h.*x + n;
        y = y./ h;
        est_bits = y < 0;
        diff = inf_bits - est_bits;
        n_err = n_err + sum(abs(diff));
        n_bits = n_bits + length(inf_bits);
    end
    BER(i) = n_err / n_bits;
end
snr = 10.^(snr_dB / 10);
theoryBer = 0.5.*(1-sqrt(snr./(snr+1)));
theoryBerAWGN = 0.5 *erfc(sqrt(snr));
semilogy(snr_dB, theoryBer, '-', 'LineWidth', 2);
hold on;
semilogy(snr_dB, BER, 'or', 'LineWidth', 2);
hold on;
semilogy(snr_dB, theoryBerAWGN, 'blad-', 'LineWidth', 2);
legend('Rayleigh Theoretical', 'Rayleigh Simulated', 'AWGN Theoretical');
axis([0 20 10^-5 0.5]);
xlabel("SNR(dB)");
ylabel('BER');
grid on;
