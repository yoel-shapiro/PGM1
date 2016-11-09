function word = ci2word(codes)
    
    % examples: 
    % codes = [factors.val]
    % codes = [allWords{i}.groundTruth]
    
    word = '';
    for k = 1:length(codes)
        word = [word char(codes(k) + 96)]; %#ok<AGROW>
    end
        
end