folder = '/home/yoel/Data/Dropbox/Probabalistic-Graphical-Models-Coursera/Week4-Decision-Making/';
load([folder, 'FullI.mat'])

% q1
SimpleCalcExpectedUtility(FullI)

% q2
evidence = [3 2]; % var value
Full2 = FullI;
temp = Full2.RandomFactors;
normalize_flag = true;
Full2.RandomFactors = ObserveEvidence(temp, evidence, normalize_flag);
SimpleCalcExpectedUtility(Full2)

% q5
euf1 = CalculateExpectedUtilityFactor(FullI);
[meu optdr] = OptimizeMEU(FullI)

% tested, by printing to screen joint utility inside OptimizeWithJointUtility
load([folder, 'MultipleUtilityI.mat'])

OptimizeWithJointUtility(MultipleUtilityI)

OptimizeLinearExpectations(MultipleUtilityI)
