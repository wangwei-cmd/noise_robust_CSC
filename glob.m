function file=glob(doc,type)
global filename;
if isempty(filename)
    filename={};
end
    
name=dir(doc);
L=length(name);
for i=3:L
    if name(i).isdir
        docc=[name(i).folder,'/',name(i).name];
        filename=glob(docc,type);
    else
        [~,~,ext]=fileparts(name(i).name);
        if strcmp(ext,type)
           filename1=[name(i).folder,'/',name(i).name];
           filename{end+1}=filename1;
        end
    end
end
file=filename;
clear global filename;
end

