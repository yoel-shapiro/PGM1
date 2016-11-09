folder = '/home/yoel/Data/Dropbox/Probabalistic-Graphical-Models-Coursera/Week4-Decision-Making/';
load([folder, 'TestI0.mat'])

% base meu, test (id = 11) is not connected to D (id = 9)
%PrintFactor(TestI0.RandomFactors(10))
%11      1
%1       1       0.750000     no ARVD, test Negative  :-)
%2       1       0.250000     no ARVD, test Positive  :-(
%1       2       0.001000     has ARVD, test Negative :-(
%2       2       0.999000     has ARVD, test Positive :-)

[meu_base_j optdr] = OptimizeWithJointUtility(TestI0);
[meu_base_l optdr] = OptimizeLinearExpectations(TestI0);

% connect decision to test
TestI0.DecisionFactors.var = [9 11];
TestI0.DecisionFactors.card = [2 2];
TestI0.DecisionFactors.val = [1 0 0 1];
%PrintFactor(TestI0.DecisionFactors)
%9       11
%1       1       1.000000     D = N, T = N
%2       1       0.000000     D = P, T = N
%1       2       0.000000     D = N, T = P
%2       2       1.000000     D = P, T = P

Test_T1 = TestI0;
Test_T1.RandomFactors(10).val = [0.75 0.25 0.001 0.999];
[meu_T1_j, ~] = OptimizeWithJointUtility(Test_T1);
[meu_T1_l, ~] = OptimizeLinearExpectations(Test_T1);

Test_T2 = TestI0;
Test_T2.RandomFactors(10).val = [0.999 0.001 00.25 0.75];
[meu_T2_j, ~] = OptimizeWithJointUtility(Test_T2);
[meu_T2_l, ~] = OptimizeLinearExpectations(Test_T2);

Test_T3 = TestI0;
Test_T3.RandomFactors(10).val = [0.999 0.001 0.001 0.999];
[meu_T3_j, ~] = OptimizeWithJointUtility(Test_T3);
[meu_T3_l, ~] = OptimizeLinearExpectations(Test_T3);

delta_U_l = [meu_T1_l meu_T2_l meu_T3_l] - meu_base_l;
delta_U_j = [meu_T1_j meu_T2_j meu_T3_j] - meu_base_j;

value_l = round(100 * (exp(delta_U_l/100) - 1)) / 100
value_j = round(100 * (exp(delta_U_j/100) - 1)) / 100
