%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODULES BELOW: Load and save each step; makes it easy to re-run any step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function std_mod   % if modular

% Initialize the ALLERP structure and CURRENTERP

disp('Module Working...')

ALLERP = buildERPstruct([]);
CURRENTERP = 0;

fprintf('\n+++++++++++++++\n+ Modules: done! ... \n+++++++++++++++\n\n');