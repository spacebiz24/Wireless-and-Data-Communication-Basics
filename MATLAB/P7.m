% CDMA Technique
clc
clear;
close all;
BitStream = input("Enter 4 bits of data: ");
XRange = [1 5];
YRange = [-4 4];

% Creating the Walsh Table
Walsh = 1;
for i = 1:2
    Walsh = [Walsh, Walsh; Walsh, -Walsh];
end

Encrypted_Walsh_Table = zeros(4, 4);
Multiplexed_Data = zeros(1, 4);

for row = 1:4
    for col = 1:4
        Encrypted_Walsh_Table(row, col) = BitStream(row) * Walsh(row, col);
        Multiplexed_Data(col) = Multiplexed_Data(col) + Encrypted_Walsh_Table(row, col);
    end
end

figure;
for Number = 1:4
    subplot(4, 4, Number);
    stairs(Encrypted_Walsh_Table(Number, :));
    title(sprintf("Station %d Code", Number));
    xlim(XRange);
    ylim(YRange);
    grid();
end

subplot(4, 4, 5:8);
stairs(Multiplexed_Data);
title("Multiplexed Channnel Data");
xlim(XRange)
ylim(YRange)
grid();

Decrypted_Walsh_Table = zeros(4, 4);
Demultiplexed_Data = zeros(1, 4);

for row = 1:4
    for col = 1:4
        Decrypted_Walsh_Table(row, col) = Multiplexed_Data(col) * Walsh(row, col);
        Demultiplexed_Data(row) = Demultiplexed_Data(row) + Decrypted_Walsh_Table(row, col);
    end
end
Demultiplexed_Data = Demultiplexed_Data / 4;

for Number = 1:4
    subplot(4, 4, Number+8);
    stairs(Decrypted_Walsh_Table(Number, :));
    title(sprintf("Inner Product %d", Number));
    xlim(XRange);
    ylim(YRange);
    grid();
end

subplot(4, 4, 13:16);
stairs(Demultiplexed_Data);
title("Demultiplexed Channnel Data");
xlim(XRange);
ylim(YRange);
grid();
