%% SLyGA Init Script

% Fun welcome message :)
fprintf(" ________  ___           ___    ___ ________  ________     \n|\\   ____\\|\\  \\         |\\  \\  /  /|\\   ____\\|\\   __  \\    \n\\ \\  \\___|\\ \\  \\        \\ \\  \\/  / | \\  \\___|\\ \\  \\|\\  \\   \n \\ \\_____  \\ \\  \\        \\ \\    / / \\ \\  \\  __\\ \\   __  \\  \n  \\|____|\\  \\ \\  \\____    \\/  /  /   \\ \\  \\|\\  \\ \\  \\ \\  \\ \n    ____\\_\\  \\ \\_______\\__/  / /      \\ \\_______\\ \\__\\ \\__\\\n   |\\_________\\|_______|\\___/ /        \\|_______|\\|__|\\|__|\n   \\|_________|        \\|___|/                             \n                                                           \n                                                           \nSolar Lyapunov Guidance Algorithm\n")

% 1) Add all subfolders to path
base_path = fileparts(which(mfilename));
subdir_names = ["postprocessing", "scripts", "sim", "steering", "utils"];
for subdir = subdir_names
    path_to_add = genpath(fullfile(base_path, subdir));
    fprintf("Adding path: %s\n", path_to_add);
    addpath(path_to_add);
end


% 2) DONE, clean up
disp("INIT DONE - SLyGA Initialized!")
clearvars