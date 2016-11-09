% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeMEU2(I, EUF)

  % Inputs: An influence diagram I with a single decision node and a single utility node.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: the maximum expected utility of I and an optimal decision rule 
  % (represented again as a factor) that yields that expected utility.
  
  % We assume I has a single decision node.
  % You may assume that there is a unique optimal decision.
  D = I.DecisionFactors(1);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE...
  % 
  % Some other information that might be useful for some implementations
  % (note that there are multiple ways to implement this):
  % 1.  It is probably easiest to think of two cases - D has parents and D 
  %     has no parents.
  % 2.  You may find the Matlab/Octave function setdiff useful.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
      
  if length(D.card) == 1 % binary decision, no parents
    
    Utilities = [0; 0];
    
    D1 = D;
    D1.val = [1 0];
    temp = FactorProduct(EUF, D1);
    Utilities(1) = sum(temp.val);
    
    D2 = D;
    D2.val = [0 1];
    temp = FactorProduct(EUF, D2);
    Utilities(2) = sum(temp.val);
    
    if Utilities(1) > Utilities(2)
      MEU = Utilities(1);
      OptimalDecisionRule = D1;
    else
      MEU = Utilities(2);
      OptimalDecisionRule = D2;
    end
    
  else
    
    n = prod(D.card);
    N = 2^n;
    Utilities = zeros(N,1);
    
    for k = 1:N
      temp = dec2bin(k - 1, n);
      for j = 1:n
        D.val(j) = str2num(temp(j));
      end
      temp = FactorProduct(EUF, D);
      Utilities(k) = sum(temp.val);
    end
    
    [MEU, index] = max(Utilities);
    
    temp = dec2bin(index - 1, n);
    for j = 1:n
      D.val(j) = str2num(temp(j));
    end
    OptimalDecisionRule = D;
    
  end

end
