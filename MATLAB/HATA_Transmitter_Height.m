% HATA Transmitter Height
clc
close all;
Effective_Receiver_Height = input("Enter RX Height: ");
Path_Distance = input("Enter the Distance between TX and RX: ");
Frequency = input("Enter the Frequency: ");
Effective_Transmitter_Height = 30:200;

% Sub Urban Area
Area_HRE_1 = (1.1 * log10(Frequency) - 0.7) * Effective_Receiver_Height - (1.56 * log10(Frequency) - 0.8);
Medium_Path_Loss_1 = 69.55 + 26.16 * log10(Frequency) - 13.82 *...
log10(Effective_Transmitter_Height) + (44.9 - 6.55 * log10(Effective_Transmitter_Height)) * log10(Path_Distance)...
- Area_HRE_1;
Medium_Path_Loss_1_dB = Medium_Path_Loss_1 - (2 * log10(Frequency / 28) * log10(Frequency / 28)) - 5.4;

% Rural / Open Area
Area_HRE_2 = (1.1 * log10(Frequency) - 0.7) * Effective_Receiver_Height - (1.56 * log10(Frequency) - 0.8);
Medium_Path_Loss_2 = 69.55 + 26.16 * log10(Frequency) - 13.82 * log10(Effective_Transmitter_Height) + ...
    (44.9 - 6.55 * log10(Effective_Transmitter_Height)) * log10(Path_Distance) - Area_HRE_2;
Medium_Path_Loss_2_dB = Medium_Path_Loss_2 - (4.78 * log10(Frequency) * log10(Frequency)) ...
    + 18.33 * log10(Frequency) - 40.98;

% Large City Urban Area
if Frequency < 3000000000
    Area_HRE_3 = 8.29 * (log10(1.54 * Effective_Receiver_Height)) .* log10(1.54 * Effective_Receiver_Height)...
        - 1.1;
else
    Area_HRE_3 = 3.2 * (log10(11.75 * Effective_Receiver_Height)) .* ...
        (log10(11.75 * Effective_Receiver_Height)) - 4.97;
end
Medium_Path_Loss_3 = 69.55 + 26.16 * log10(Frequency) - 13.82 * log10(Effective_Transmitter_Height) + ...
    (44.9 - 6.55 * log10(Effective_Transmitter_Height)) * log10(Path_Distance) - Area_HRE_3;
Medium_Path_Loss_3_dB = Medium_Path_Loss_3 - (2 * log10(Frequency / 28) * log10(Frequency / 28)) - 5.4;

figure
plot(Effective_Transmitter_Height, Medium_Path_Loss_1_dB, 'r', Effective_Transmitter_Height, Medium_Path_Loss_2_dB, 'g', ...
    Effective_Transmitter_Height, Medium_Path_Loss_3, 'b', Effective_Transmitter_Height, Medium_Path_Loss_3_dB, 'm');
legend("L_5_0(dB)(Suburban Area - Medium City)", "L_5_0(dB)(Rural Area)", "L_5_0(dB)(Urban Area)",...
    "L_5_0(dB)(Suburban Area - Large City)");
xlabel("Distance in m");
ylabel("Path Loss in dB");
title("HATA Model - Transmitter Height Varied");
grid on;