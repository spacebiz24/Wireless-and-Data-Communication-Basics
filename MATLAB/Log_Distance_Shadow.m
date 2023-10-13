% Analysis of Log-distance path loss propagation model (w/ Shadow)
clc
close all;
Fixed_Distance = input("Enter the reference distance: ");
Arbitrary_Distance = 1000 : 1000 : 20000;
% Values must be between 1.6 to 6
Path_Loss_Exponent = rand(1,12)*(6-1.6) + 1.6;
Frequency = randi([900, 4000], 1,12);
Sigma = rand(1,12)*(15-3) + 3;

for i = 1:12
    Lambda(i) = 3e8 / (Frequency(i) * 10 ^ 6);
    PL_D0(i) = -10 * log10((Lambda(i) ^ 2) / ((4 * pi * Fixed_Distance) ^ 2));
    X(i) = normrnd(0, sigma(i));
    disp(X(i));
end
for i = 1:12
    for j = 1:20
        Path_Loss(i, j) = PL_D0(i) + 10 * Path_Loss_Exponent(i) * log10(Arbitrary_Distance(j) / Fixed_Distance)...
            + X(i);
    end
end

plot(Arbitrary_Distance, Path_Loss);
legend("Retail Store", "Grocery Store", "Office Hard Partition", "Office Soft Partition", "Textile/Chemical",...
    "Paper/Cereals", "Metal Working", "Indoor Street", "Textile/Chemical", "Metal Working");
xlabel("Distance in m");
ylabel("Path Loss in dB");
title("Log-Distance Path Loss Indoor Propagation Model (With Shadowing Effect)");
grid on;
