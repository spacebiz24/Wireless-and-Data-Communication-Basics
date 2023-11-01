% Analysis of HATA propagation model by varying Tx, Rx height & distance
clc
close all;

switch input("Enter name of parameter to vary: ", "s")
    case "d"
        d = 1e3:1e3:20e3;
        varying_parameter = d;
        hte = input("Enter Effective Tx Height: ");
        hre = input("Enter Effective Rx Height: ");
    case "hte"
        hte = 30:200;
        varying_parameter = hte;
        d = input("Enter Distance b/w Tx & Rx: ");
        hre = input("Enter Effective Rx Height: ");
    case "hre"
        hre = 1:10;
        varying_parameter = hre;
        d = input("Enter Enter Distance b/w Tx & Rx: ");
        hte = input("Enter Effective Tx Height: ");
end

f = input("Enter the operating Frequency: ");

% Rural / Open Area
ahre_1 = Area(hre, f); % Area of Receiver antenna
L50_1 = MediumPathLoss(ahre_1, d, hte, f); % Medium_Path_Loss
L50_1_dB = L50_1 - 4.78 * log10(f)^2 + 18.33 * log10(f) - 40.98;

% Sub Urban Area
ahre_2 = Area(hre, f);
L50_2 = MediumPathLoss(ahre_2, d, hte, f);
L50_2_dB = L50todB(L50_2, f);

% Large City Urban Area
if f < 3e9
    ahre_3 = 8.29 * log10(1.54 * hre).^2 - 1.1;
else
    ahre_3 = 3.2 * log10(11.75 * hre).^2 - 4.97;
end
L50_3 = MediumPathLoss(ahre_3, d, hte, f);
L50_3_dB = L50todB(L50_3, f);

figure;
plot(varying_parameter, L50_1_dB, 'r', varying_parameter, L50_2_dB, 'g', ...
    varying_parameter, L50_3, 'b', varying_parameter, L50_3_dB, 'm');
legend("L_5_0(dB)(Rural Area)", "L_5_0(dB)(Suburban Area - Medium City)", ...
    "L_5_0(dB)(Urban Area)", "L_5_0(dB)(Suburban Area - Large City)");
xlabel("Distance in m");
ylabel("Path Loss in dB");
title("HATA Model");
grid on;

function ahre = Area(hre, f)
    ahre = (1.1 * log10(f) - 0.7) * hre - (1.56 * log10(f) - 0.8);
end

function L50 = MediumPathLoss(ahre, d, hte, f)
    L50 = 69.55 + 26.16 * log10(f) - 13.82 * log10(hte)...
    + (44.9 - 6.55 * log10(hte)) * log10(d) - ahre;
end

function L50_dB = L50todB(L50, f)
    L50_dB = L50 - (2 * log10(f / 28)^2) - 5.4;
end