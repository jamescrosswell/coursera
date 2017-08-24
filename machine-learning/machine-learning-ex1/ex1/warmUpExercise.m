function A = warmUpExercise()
% Returns the 5x5 identity matrix
  A = eye(5);
end

%!assert (all(all(warmUpExercise() == eye(5))'))
