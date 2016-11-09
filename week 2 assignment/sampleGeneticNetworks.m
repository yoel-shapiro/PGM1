% This script contains the solutions for the code for some simple examples.
% There is also a call to each of the functions that you should create that
% is commented out.  WHEN YOU HAVE FINISHED WRITING A FUNCTION, COMMENT OUT 
% THE SOLUTION, UNCOMMENT THE CALL TO YOUR CODE, AND USE THIS SCRIPT TO 
% TO TEST YOUR FUNCTION.  Check that this script runs to completion and 
% that your answer matches the solution.  Once your function seems to be
% working, submit it for the unit test.

% Testing phenotypeGivenGenotypeMendelianFactor:
isDominant = 1;
genotypeVar = 1;
phenotypeVar = 3;
phenotypeFactor = phenotypeGivenGenotypeMendelianFactor(isDominant, genotypeVar, phenotypeVar);
% phenotypeFactor = struct('var', [3,1], 'card', [2,3], 'val', [1,0,1,0,0,1]); % Comment out this line for testing

% Testing phenotypeGivenGenotypeFactor:
alphaList = [0.8; 0.6; 0.1];
genotypeVar = 1;
phenotypeVar = 3;
phenotypeFactorAlpha = phenotypeGivenGenotypeFactor(alphaList, genotypeVar, phenotypeVar);
% phenotypeFactorAlpha = struct('var', [3,1], 'card', [2,3], 'val', [0.8,0.2,0.6,0.4,0.1,0.9]); % Comment out this line for testing

% Testing genotypeGivenAlleleFreqsFactor:
alleleFreqs = [0.1; 0.9];
genotypeVar = 1;
genotypeFactor = genotypeGivenAlleleFreqsFactor(alleleFreqs, genotypeVar);
% genotypeFactor = struct('var', [1], 'card', [3], 'val', [0.01,0.18,0.81]); % Comment out this line for testing

% Testing genotypeGivenParentsGenotypesFactor:
numAlleles = 2;
genotypeVarChild = 3;
genotypeVarParentOne = 1;
genotypeVarParentTwo = 2;
genotypeFactorPar = genotypeGivenParentsGenotypesFactor(numAlleles, genotypeVarChild, genotypeVarParentOne, genotypeVarParentTwo);
% genotypeFactorPar = struct('var', [3,1,2], 'card', [3,3,3], 'val', [1,0,0,0.5,0.5,0,0,1,0,0.5,0.5,0,0.25,0.5,0.25,0,0.5,0.5,0,1,0,0,0.5,0.5,0,0,1]); % Comment out this line for testing

% Testing constructGeneticNetwork:
pedigree = struct('parents', [0,0;1,3;0,0]);
pedigree.names = {'Ira','James','Robin'};
alleleFreqs = [0.1; 0.9];
alphaList = [0.8; 0.6; 0.1];
alleleFreqs = [0.1; 0.7; 0.2];
alphaList = [0.8; 0.6; 0.1; 0.5; 0.05; 0.01];
sampleFactorList = constructGeneticNetwork(pedigree, alleleFreqs, alphaList);
% sampleFactorList = load('sampleFactorList.mat'); % Comment out this line for testing


% Parts 3 and 4

% Testing phenotypeGivenCopiesFactor:
alphaListThree = [0.8; 0.6; 0.1; 0.5; 0.05; 0.01];
numAllelesThree = 3;
genotypeVarMotherCopy = 1;
genotypeVarFatherCopy = 2;
phenotypeVar = 3;
phenotypeFactorPar = phenotypeGivenCopiesFactor(alphaListThree, numAllelesThree, genotypeVarMotherCopy, genotypeVarFatherCopy, phenotypeVar);
% phenotypeFactorPar = struct('var', [3,1,2], 'card', [2,3,3], 'val', [0.8,0.2,0.6,0.4,0.1,0.9,0.6,0.4,0.5,0.5,0.05,0.95,0.1,0.9,0.05,0.95,0.01,0.99]); % Comment out this line for testing

% Testing constructDecoupledGeneticNetwork:
pedigree = struct('parents', [0,0;1,3;0,0]);
pedigree.names = {'Ira','James','Robin'};
alleleFreqsThree = [0.1; 0.7; 0.2];
alleleListThree = {'F', 'f', 'n'};
alphaListThree = [0.8; 0.6; 0.1; 0.5; 0.05; 0.01];
sampleFactorListDecoupled = constructDecoupledGeneticNetwork(pedigree, alleleFreqsThree, alphaListThree);
% sampleFactorListDecoupled = load('sampleFactorListDecoupled.mat'); % Comment out this line for testing

% Testing constructSigmoidPhenotypeFactor:
alleleWeights = {[3, -3], [0.9, -0.8]};
geneCopyVarParentOneList = [1; 2];
geneCopyVarParentTwoList = [4; 5];
phenotypeVar = 3;
phenotypeFactorSigmoid = constructSigmoidPhenotypeFactor(alleleWeights, geneCopyVarParentOneList, geneCopyVarParentTwoList, phenotypeVar);
% phenotypeFactorSigmoid = struct('var', [3,1,2,4,5], 'card', [2,2,2,2,2], 'val', [0.999590432835014,0.000409567164986080,0.858148935099512,0.141851064900488,0.997762151478724,0.00223784852127629,0.524979187478940,0.475020812521060,0.858148935099512,0.141851064900488,0.0147740316932731,0.985225968306727,0.524979187478940,0.475020812521060,0.00273196076301106,0.997268039236989,0.997762151478724,0.00223784852127629,0.524979187478940,0.475020812521060,0.987871565015726,0.0121284349842742,0.167981614866076,0.832018385133925,0.524979187478940,0.475020812521060,0.00273196076301106,0.997268039236989,0.167981614866076,0.832018385133925,0.000500201107079564,0.999499798892920]);  % Comment out this line for testing