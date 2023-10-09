% CDMA Technique
clc
clear;
close all;
BitStream = [-1 -1 0 1];
XLimiter = [1 5];
YLimiter = [-4 4];

% Creating the Walsh Table
Walsh1 = 1;
Walsh2 = [Walsh1, Walsh1; Walsh1, -Walsh1];
Walsh4 = [Walsh2, Walsh2; Walsh2, -Walsh2];

Multiplexed_Data = zeros(1, 4);
Encrypted_Walsh_Table = zeros(4, 4);

for row = 1:4
    for col = 1:4
        Encrypted_Walsh_Table(row, col) = BitStream(row) * Walsh4(row, col);
        Multiplexed_Data(col) = Multiplexed_Data(col) + Encrypted_Walsh_Table(row, col);
    end
end

figure(1);
for Number = 1:4
    subplot(4, 4, Number);
    stairs(Encrypted_Walsh_Table(Number, :));
    str = sprintf("Station %d Code", Number);
    title(str);
    xlim(XLimiter);
    ylim(YLimiter);
    grid();
end

subplot(4, 4, 5:8);
stairs(Multiplexed_Data);
title("Multiplexed Channnel Data");
xlim(XLimiter)
ylim(YLimiter)
grid();

Demultiplexed_Data = zeros(1, 4);
Decrypted_Walsh_Table = zeros(4, 4);

for row = 1:4
    for col = 1:4
        Decrypted_Walsh_Table(row, col) = Multiplexed_Data(col) * Walsh4(row, col);
        Demultiplexed_Data(row) = Demultiplexed_Data(row) + Multiplexed_Data(col) * Walsh4(row, col);
    end
end
Demultiplexed_Data = Demultiplexed_Data / 4;

for Number = 1:4
    subplot(4, 4, Number+8);
    stairs(Decrypted_Walsh_Table(Number, :));
    str = sprintf("Inner Product %d", Number);
    title(str);
    xlim(XLimiter);
    ylim(YLimiter);
    grid();
end

subplot(4, 4, 13:16);
stairs(Demultiplexed_Data);
title("Demultiplexed Channnel Data");
xlim(XLimiter)
ylim(YLimiter)
grid();
