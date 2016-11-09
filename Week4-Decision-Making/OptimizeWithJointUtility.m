% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeWithJointUtility( I )
  % Inputs: An influence diagram I with a single decision node and one or more utility nodes.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: the maximum expected utility of I and an optimal decision rule 
  % (represented again as a factor) that yields that expected utility.
  % You may assume that there is a unique optimal decision.
    
  % This is similar to OptimizeMEU except that we must find a way to 
  % combine the multiple utility factors.  Note: This can be done with very
  % little code.
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  verbose = false;
  
  n_U = length(I.UtilityFactors);
  
  if verbose
    for k = 1:n_U
      PrintFactor(I.UtilityFactors(k))
    end
  end
  
  U_joint = I.UtilityFactors(1);
  for k = 2:n_U
    
    vars = U_joint.var;
    cards = U_joint.card;
      
    [v_xor, i_joint, i_k] = setxor(U_joint.var, I.UtilityFactors(k).var);
    if ~isempty(i_k)
      vars = [vars I.UtilityFactors(k).var(sort(i_k))];
      cards = [cards I.UtilityFactors(k).card(sort(i_k))];
    end
    
    U_new = struct();
    U_new.var = vars;
    U_new.card = cards;
    
    [~, cols_old] = intersect(U_new.var, U_joint.var);
    cols_old = sort(cols_old);
    [~, cols_k] = intersect(U_new.var, I.UtilityFactors(k).var);
    cols_k = sort(cols_k);
    
    n_vals = prod(U_new.card);
    vals = zeros(1, n_vals);
    assignments = IndexToAssignment(1:n_vals, U_new.card);
    for k_v = 1:n_vals
      index_old = AssignmentToIndex( ...
        assignments(k_v, cols_old), U_joint.card);
      index_k = AssignmentToIndex( ...
        assignments(k_v, cols_k), I.UtilityFactors(k).card);
      vals(k_v) = U_joint.val(index_old) + I.UtilityFactors(k).val(index_k);
    end
    
    U_new.val = vals;
    U_joint = U_new;
    
  end
    
  I2 = I;
  I2.UtilityFactors = U_joint;
  
  if verbose 
    disp('Joint Utility')
    PrintFactor(I2.UtilityFactors)
  end
  
  [MEU OptimalDecisionRule] = OptimizeMEU(I2);
  
end
