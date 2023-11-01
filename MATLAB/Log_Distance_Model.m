% Analysis of Log-distance path loss propagation model (w/ & w/o Shadow)
clc
close all;

with_shadowing = input("w/ Shadowing? ");
Fixed_Distance = input("Enter the reference distance: ");
Arbitrary_Distance = 1e3 : 1e3 : 20e3;
% Values must be between 1.6 to 6
Path_Loss_Exponent = rand(1,12)*(6-1.6) + 1.6;
Frequency = randi([900, 4000], 1,12);
Sigma = rand(1,12)*(15-3) + 3;
X = zeros(1,12);

for i = 1:12
    Lambda(i) = 3e8 / (Frequency(i) * 10 ^ 6);
    PL_D0(i) = 10 * log10((4 * pi * Fixed_Distance) / Lambda(i)) ^ 2;
    if(with_shadowing)
        X(i) = Sigma(i) * randn(size(PL_D0(i)));
    end
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
title("Log-Distance Path Loss Indoor Propagation Model");
grid on;
