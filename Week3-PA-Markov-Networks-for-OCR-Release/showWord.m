function wordImage = showWord(imageStruct)
   
    n = length(imageStruct);
    h = size(imageStruct(1).img,1) + 2;
    w = size(imageStruct(1).img,2);
    
    wordImage = zeros(h, n*(w + 1) + 1);
    for k = 1:n
        
        col1 = 1 + (k-1) * w + k;
        col2 = k * (w + 1);
        wordImage(2:end-1, col1:col2) = imageStruct(k).img; 
        
    end

    fig = figure;
    imagesc(wordImage)
    colormap('gray')
    axis equal
    axis tight
    set(gca, 'XTick', [])
    set(gca, 'YTick', [])
    
end
