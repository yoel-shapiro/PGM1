% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeLinearExpectations( I )
  % Inputs: An influence diagram I with a single decision node and one or more utility nodes.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: the maximum expected utility of I and an optimal decision rule 
  % (represented again as a factor) that yields that expected utility.
  % You may assume that there is a unique optimal decision.
  %
  % This is similar to OptimizeMEU except that we will have to account for
  % multiple utility factors.  We will do this by calculating the expected
  % utility factors and combining them, then optimizing with respect to that
  % combined expected utility factor.  
  MEU = [];
  OptimalDecisionRule = [];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE
  %
  % A decision rule for D assigns, for each joint assignment to D's parents, 
  % probability 1 to the best option from the EUF for that joint assignment 
  % to D's parents, and 0 otherwise.  Note that when D has no parents, it is
  % a degenerate case we can handle separately for convenience.
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  verbose = false;
  
  n_parents_D = length(I.DecisionFactors(1).var);
  
  EUF = struct();
  I1 = I;
  n_U = length(I.UtilityFactors);
  for k = 1:n_U
    I1.UtilityFactors = I.UtilityFactors(k);
    
    if n_parents_D <= 1
      EUF(k) = CalculateExpectedUtilityFactor(I1);
    else
      EUF(k) = ExpectedUtilityFactorWithDecisionParents(I1);
    end
          
  end
  
  EUF_eq = EUF(1);
  for k = 2:n_U
    EUF_eq.val = EUF_eq.val + EUF(k).val;
  end
  
  I2 = I;
  I2.UtilityFactors = EUF_eq;
  
  if verbose 
    disp('Equivalent EUF')
    PrintFactor(EUF_eq)
  end
  
  [MEU OptimalDecisionRule] = OptimizeMEU(I2, EUF_eq);

end
