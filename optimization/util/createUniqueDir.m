% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti, 2011

function newSimName = createUniqueDir(dir,simName)
%CREATEUNIQUEDUMPDIR Creates a unique directory within the main directory

variants = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n', ...
            'o','p','q','r','s','t','u','v','w','x','y','z'];

newSimName = simName;
folderName = [ dir '/' simName ];

i=1;
while (exist(folderName,'dir')~=0 )
    newSimName = [simName '-' variants(i)];
    folderName = [ dir '/' newSimName];
    i=i+1;
    
    if (i==length(variants))
        error('Too Many dump directories under the same name');
    end
end

mkdir(folderName);
%fprintf('Created dump dir: %s\n',folderName);

end