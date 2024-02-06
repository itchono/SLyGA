function corrected_vector = make_monotonically_increasing(vector)
% MAKE_MONOTONICALLY_INCREASING Adjusts a vector to ensure monotonically increasing values.
%
%   corrected_vector = MAKE_MONOTONICALLY_INCREASING(vector) takes a vector
%   containing values between 0 and 2*pi, where the values increase
%   monotonically, except when the value exceeds 2*pi, at which point it wraps
%   back to zero. This function adjusts the vector to ensure that the values
%   are monotonically increasing, by adding multiples of 2*pi to the subsequent
%   values after each discontinuity.
%
%   Parameters:
%       vector - Input vector containing values between 0 and 2*pi.
%
%   Returns:
%       corrected_vector - Vector with monotonically increasing values.
%

% Find the indices where the vector wraps around
wrap_indices = find(diff(vector) < 0);

% Initialize the corrected vector
corrected_vector = vector;

% Add multiples of 2*pi to the elements after each wrap-around
for i = 1:length(wrap_indices)
    
    % index immediately before the wrap-around
    wrap_index = wrap_indices(i);
    if i == length(wrap_indices)
        end_index = length(vector);
    else
        end_index = wrap_indices(i+1);
    end
    
    % Calculate the multiples of 2*pi needed to make the subsequent elements monotonically increasing
    n = floor((corrected_vector(wrap_index) - corrected_vector(wrap_index+1)) / (2*pi)) + 1;
    
    % Add multiples of 2*pi to the subsequent elements
    corrected_vector(wrap_index+1:end_index) = corrected_vector(wrap_index+1:end_index) + n * (2*pi);
end
end