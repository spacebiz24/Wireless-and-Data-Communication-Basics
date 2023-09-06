% Log Distance No Shadow
clc
close all;
Fixed_Distance = input("Enter the reference distance: ");
Arbitrary_Distance = 1000 : 1000 : 20000;
% Values must be between 1.6 to 6
Path_Loss_Exponent = [2.2, 1.8, 3.0, 2.4, 2.6, 2.0, 2.1, 1.8, 1.6, 3.0, 3.1, 3.2];
Frequency = [914, 914, 1500, 900, 1900, 1300, 4000, 1300, 1300, 900, 4000, 1300];
Sigma = [8.7, 5.2, 7.0, 9.6, 14.1, 3.0, 7.0, 6.0, 5.8, 7.0, 9.7, 6.8];
X = 0;

for i = 1:12
    Lambda(i) = 3e8 / (Frequency(i) * 10 ^ 6);
    PL_D0(i) = -10 * log10((Lambda(i) ^ 2) / ((4 * pi * Fixed_Distance) ^ 2)) + X;
end
disp("PL_D0 -> D(dB) = ");
for i = 1:12
    for j = 1:20
        Path_Loss(i, j) = PL_D0(i) + 10 * Path_Loss_Exponent(i) * log10(Arbitrary_Distance(j) / Fixed_Distance);
    end
    disp(Path_Loss(i));
end

plot(Arbitrary_Distance, Path_Loss);
legend("Retail Store", "Grocery Store", "Office Hard Partition", "Office Soft Partition", "Textile/Chemical",...
    "Paper/Cereals", "Metal Working", "Indoor Street", "Textile/Chemical", "Metal Working");
xlabel("Distance in m");
ylabel("Path Loss in dB");
title("Log-Distance Path Loss Indoor Propagation Model (With Shadowing Effect)");
grid on;
