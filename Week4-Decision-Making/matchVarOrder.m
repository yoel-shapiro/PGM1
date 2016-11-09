function [V_tag] = matchVarOrder(V, Template)
  
  if ~all(sort(V.var) == sort(Template.var))
    error('variable id mismatch betweem input factors')
  end
  
  V_tag = Template;
  
  n = length(V_tag.var);
  orderV2T = zeros(n,1);
  for k = 1:n
    order2tag(k) = find(V.var == Template.var(k));
  end
  
  n = length(V_tag.val);
  assignments = IndexToAssignment(1:n, V_tag.card);
  for k_V = 1:n
    assign_tag = assignments(k_V, order2tag);
    index_tag = AssignmentToIndex(assign_tag, V_tag.card);
    V_tag.val(index_tag) = V.val(k_V);
  end
  
end
