close all
clear all
fprintf('\n starting main \n')

if isempty(regexp(computer, 'linux'))
  folder = 'C:\Users\YoelS\Desktop\PA-Markov-Networks-for-OCR-Release\';
else
  folder = ['/home/yoel/Desktop/Data/', ...
    'Probabalistic-Graphical-Models-Coursera/', ...
    'Week3-PA-Markov-Networks-for-OCR-Release/'];
end

load([folder, 'PA3Data.mat']) % allWords
load([folder, 'PA3Models.mat']) % imageModel, pairwiseModel, tripletList
% Visualize Pair-Wise weights
%{
figure
imagesc(pairwiseModel)
axis equal
axis tight
let = cell(26,1);
for k =1:26
    let{k,1} = char(k+96);
end
set(gca,'XTick', 1:26, 'XTickLabel', let)
set(gca,'YTick', 1:26, 'YTickLabel', let) % flipud(let))
%}
% Visualize triplet list
%{
for k = 1:300
    temp = {char(tripletList(k).chars + 96)};
    fprintf('%s \n', temp{1})
end
%}

% PartXSampleImagesInput, PartXSampleFactorsOutput, X = 1-6
load([folder, 'PA3SampleCases.mat']) 

% ComputeSingletonFactors 
%{
factors = ComputeSingletonFactors(allWords{1}, imageModel);
temp = [factors.val];
[~, index] = max(temp, [], 1);
ci2word(index)
ci2word([allWords{1}.groundTruth])
wordImage = showWord(allWords{1});
%}

temp = {};
for k = 1:3
  temp{k} = allWords{k};
end

pm = pairwiseModel;
tl = tripletList;
% imageModel.ignoreSimilarity = 1;

[charAcc, wordAcc] = ScoreModel(allWords, imageModel, pm, tl);

