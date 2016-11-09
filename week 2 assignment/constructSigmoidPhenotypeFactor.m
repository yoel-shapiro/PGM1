function phenotypeFactor = constructSigmoidPhenotypeFactor( ...
  alleleWeights, geneCopyVarOneList, geneCopyVarTwoList, phenotypeVar)
% This function takes a cell array of alleles' weights and constructs a 
% factor expressing a sigmoid CPD.
%
% You can assume that there are only 2 genes involved in the CPD.
%
% In the factor, for each gene, each allele assignment maps to the allele
% whose weight is at the corresponding location.  For example, for gene 1,
% allele assignment 1 maps to the allele whose weight is at
% alleleWeights{1}(1) (same as w_1^1), allele assignment 2 maps to the
% allele whose weight is at alleleWeights{1}(2) (same as w_2^1),....  
% 
% You may assume that there are 2 possible phenotypes.
% For the phenotypes, assignment 1 maps to having the physical trait, and
% assignment 2 maps to not having the physical trait.
%
% THE VARIABLE TO THE LEFT OF THE CONDITIONING BAR MUST BE THE FIRST
% VARIABLE IN THE .var FIELD FOR GRADING PURPOSES
%
% Input:
%   alleleWeights: Cell array of weights, where each entry is an 1 x n 
%   of weights for the alleles for a gene (n is the number of alleles for
%   the gene)
%   geneCopyVarOneList: m x 1 vector (m is the number of genes) of variable 
%   numbers that are the variable numbers for each of the first parent's 
%   copy of each gene (numbers in this list go in the .var part of the
%   factor)
%   geneCopyVarTwoList: m x 1 vector (m is the number of genes) of variable 
%   numbers that are the variable numbers for each of the second parent's 
%   copy of each gene (numbers in this list go in the .var part of the
%   factor) -- Note that both copies of each gene are from the same person,
%   but each copy originally came from a different parent
%   phenotypeVar: Variable number corresponding to the variable for the 
%   phenotype (goes in the .var part of the factor)
%
% Output:
%   phenotypeFactor: Factor in which the values are the probabilities of 
%   having each phenotype for each allele combination (note that this is 
%   the FULL CPD with no evidence observed)

phenotypeFactor = struct('var', [], 'card', [], 'val', []);

phenotypeFactor.var = [ ...
  phenotypeVar, geneCopyVarOneList(:)', geneCopyVarTwoList(:)'];

n_genes = length(alleleWeights);
n_alleles_per_gene = zeros(n_genes,1);
for k = 1:n_genes
  n_alleles_per_gene(k) = length(alleleWeights{k});
end

n_phenotypes = 2; % kinda hard-coded for 2 phenotypes

n_copies = 2;
phenotypeFactor.card = [n_phenotypes];
for k = 1:n_genes
  phenotypeFactor.card = [phenotypeFactor.card, n_alleles_per_gene(k) * [1 1]];
end

% 1st parent
indexes = 1:n_alleles_per_gene(1);
vals = alleleWeights{1}(indexes(:))';
for k = 2:n_genes
  temp = 1:n_alleles_per_gene(k);  
  indexes = kron(temp(:), ones(size(vals,1), 1));
  vals = [ ...
    repmat(vals, n_alleles_per_gene(k), 1) ...
    alleleWeights{k}(indexes)'];
end

% 2nd parent
for k = 1:n_genes
  temp = 1:n_alleles_per_gene(k);  
  indexes = kron(temp(:), ones(size(vals,1), 1));
  vals = [ ...
    repmat(vals, n_alleles_per_gene(k), 1) ...
    alleleWeights{k}(indexes)'];
end

n_vals = size(vals,1);
phenotypeFactor.val = zeros(1, n_vals * n_phenotypes);
for k = 1:n_vals 
  j = (n_phenotypes * k) - 1;
  phenotypeFactor.val(j) = computeSigmoid(sum(vals(k, :)));
  phenotypeFactor.val(j + 1) = 1 - phenotypeFactor.val(j);
end
