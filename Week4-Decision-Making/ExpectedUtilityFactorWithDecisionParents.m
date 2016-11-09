function [EUF] = ExpectedUtilityFactorWithDecisionParents(I)
  
  D = I.DecisionFactors(1);
  
  var_D = D.var(1);
  n_D = D.card(1);
  normalize = true;
  
  EUF_k = struct();
  for k_d = 1:n_D
    I1 = I;
    E = [var_D k_d];
    I1.RandomFactors = ObserveEvidence(I1.RandomFactors, E, normalize);
    EUF_k(k_d) = CalculateExpectedUtilityFactor(I1);
  end
  
  EUF = EUF_k(1);
  col = find(EUF.var == var_D);
  for k_d = 2:n_D
    index = 1:length(EUF.val);
    assignments = IndexToAssignment(index, EUF.card);
    mask = assignments(:,col) == k_d;
    EUF.val(mask) = EUF_k(k_d).val(mask);
  end

end
