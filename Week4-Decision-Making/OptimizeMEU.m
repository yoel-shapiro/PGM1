% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeMEU(I, EUF)

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
  verbose = false;
  
  if nargin == 1
    if numel(D.var) == 1 % no parents
      
      EUF = CalculateExpectedUtilityFactor(I);
      
    else % observe evidence of D values, and merge EUF of different cases
      
      EUF = ExpectedUtilityFactorWithDecisionParents(I);
                  
    end % if_else, EUF
  end
  
  EUF = matchVarOrder(EUF, D);
  
  if verbose
    disp('EUF')
    PrintFactor(EUF)
  end
  
  % set optimal decision values
  n_D = D.card(1);
  n_comb = int32(length(D.val) / n_D);
  d_values = 0:(n_D - 1);
  for k = 1:n_comb
    start = (k - 1) * n_D + 1;
    stop = k * n_D;
    euf_vals = EUF.val(start:stop);
    [v, order] = sort(euf_vals);
    D.val(start:stop) = d_values(order);
  end
  
  OptimalDecisionRule = D;  
  temp = FactorProduct(EUF, D);
  MEU = sum(temp.val);

  if verbose
    disp('Optimal Decision Rule')  
    PrintFactor(D)
  end
  
  temp = OptimalDecisionRule;
  temp.var = sort(temp.var);
  OptimalDecisionRule = matchVarOrder(OptimalDecisionRule, temp);
  
end
