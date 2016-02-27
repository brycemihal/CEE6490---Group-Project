%% Write water rights data to file
% Bryce Mihalevich
% 2/26/16

%% list of water right numbers for the BRMBR in text file
%% use gui to select file, stores file name and path
[fName,fDir] = uigetfile();

%% open the text file and read store each line
fid = fopen(strcat(fDir,fName),'r');
c = textscan(fid,'%s\n');
fclose(fid);

%% rename variable
WRN = c{1}(:,1);

%% load and save the web pages as txt files
for i = 1:1%length(WRN)
    webPage = strcat('http://www.waterrights.utah.gov/cblapps/wrprint.exe?wrnum=',WRN(i));
    websave(char(strcat('wr_',WRN(i),'.txt')),char(webPage));
end