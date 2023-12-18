% Analysis of Log-distance path loss propagation model (w/ & w/o Shadow)
clc
close all;

with_shadowing = input("w/ Shadowing? ");
d0 = input("Enter the reference distance: "); % Fixed_Distance
d = 1e3 : 1e3 : 20e3;
n = rand(1,12)*(6-1.6) + 1.6; % Path_Loss_Exponent - Values must be between 1.6 to 6
Sigma = rand(1,12)*(15-3) + 3;
f = randi([900, 4000], 1,12);
X = zeros(1,12);

for i = 1:12
    Lambda(i) = 3e8 / (f(i) * 10 ^ 6);
    PL_D0(i) = 20 * log10((4 * pi * d0) / Lambda(i));
    if(with_shadowing)
        X(i) = randn(size(PL_D0(i))) * Sigma(i);  % X(i) = normrnd(0, Sigma(i));
    end
end
for i = 1:12
    for j = 1:20
        PL(i, j) = PL_D0(i) + 10 * n(i) * log10(d(j) / d0)... % Path loss
            + X(i);
    end
end

plot(d, PL);
legend("Retail Store", "Grocery Store", "Office Hard Partition", "Office Soft Partition", "Textile/Chemical",...
    "Paper/Cereals", "Metal Working", "Indoor Street", "Textile/Chemical", "Metal Working");
xlabel("Distance in m");
ylabel("Path Loss in dB");
title("Log-Distance Path Loss Indoor Propagation Model");
grid on;
