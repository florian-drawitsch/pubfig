function path_hashes = getGitHashes(paths)
%getGitHashes retrieves git commit and blob hashes for the specified
% filepaths. Evidently, the respective folder must be under git version
% control for this to work.
%   INPUT:  paths: str or cell array of str
%                   Full filepaths for which git hashes shall be retrieved
%   OUTPUT: path_hashes: table
%                   Table containing paths, commit hashes and blob hashes 
%   Usage example:
%       path_hashes = getGitHashes({'/foo1/bar1.m', '/foo2/bar2.xml' })
% Author: Florian Drawitsch <florian.drawitsch@gmail.com>

commitHashes = cell(numel(paths),1);
blobHashes = cell(numel(paths),1);

for i = 1:numel(paths)
    
    if ~ischar(paths)
        path = paths{i};
    end
    
    % Get path components
    [directory, fname, ext] = fileparts(path);
    
    % Change into directory
    currentDir = pwd;
    if exist(directory, 'dir') > 0
        cd(directory);
    end
    
    try
        % Query current commit hash of the git repository
        [status, git_status] = system('git rev-parse HEAD');
        if status
            warning(['Commit hash could not be retrieved for ', directory])
            commitHashes{i} = '';
        else
            commitHashes{i} = git_status(1:end-1);
        end
        
        % Query blob hash of file
        [status, git_status] = system('git ls-tree HEAD');
        
        if status
            warning(['Git blob hashes could not be retrieved for ', fname, ext])
            blobHashes{i} = '';
        else
            c = textscan(git_status, '%u %s %s %s');
            idx = strcmp(c{4}, [fname, ext]);
            blobHashes{i} = c{3}{idx};
        end
        
    catch
        warning(...
            ['Error getting retrieving hashes for ...', directory, '... ', ...
            'Make sure you have git installed, the specified paths are inside a valid repository ',...
            'and you have staged and commited them before invoking this function'])
    end
    
    cd(currentDir);
    
end

paths = reshape(paths, numel(paths), 1);
path_hashes = cell2table([paths, commitHashes, blobHashes], 'VariableNames', {'paths', 'commitHashes', 'blobHashes'});

end

