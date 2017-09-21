function x = emailFeatures(word_indices)
%EMAILFEATURES takes in a word_indices vector and produces a feature vector
%from the word indices
%   x = EMAILFEATURES(word_indices) takes in a word_indices vector and 
%   produces a feature vector from the word indices. 

  % Total number of words in the dictionary
  n = 1899;

  % You need to return the following variables correctly.
  x = zeros(n, 1);
  
  % Build a feature vector indicating which features (i.e. words from our 
  % dictionary) are present in the word_indices.
  for i = 1 : size(word_indices)
    x(word_indices(i)) = 1;
  endfor       

end


%!test
%! file_contents = readFile('emailSample1.txt');
%! word_indices  = processEmail(file_contents);
%! features      = emailFeatures(word_indices);
%! assert(nnz(features), 45);