%% script to parse files and save data into single txt file
% Bryce Mihalevich
% 2/27/16
clear; clc;

%% Create new file
Outfile = 'BRMBR_WR.txt';
fid0 = fopen(char(Outfile),'wt'); %creates the index file as a text file
fprintf(fid0, '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n','Name','WR_number','Source','Flow','Use','Service Area','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
fclose(fid0);

%% list of water right numbers for the BRMBR in text file
fDir = '/Users/bryce/Dropbox/GroupProject_CEE6490/WaterRights/';
fName = 'wrn_brmbr.txt';

fid = fopen(strcat(fDir,fName),'r');
c = textscan(fid,'%s\n');
fclose(fid);

WRN = c{1}(:,1);
    
%%     
 for i = 1:length(WRN)   
     %Open File and setup data into row by row table
     delimiter = '';
     formatSpec = '%q%[^\n\r]';
     fileID = fopen(strcat(fDir,'wr_',char(WRN(i)),'.txt'),'r');
     dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
     fclose(fileID);

     %% Create output variable
     tempVar = table(dataArray{1:end-1}, 'VariableNames', {'VarName1'});

     %% Clear temporary variables
     clearvars filename delimiter formatSpec fileID dataArray ans;

%% Parse out data
    %Name
    for j=1:height(tempVar)
       if strfind(char(tempVar{j,:}),'NAME:') >= 1;
           wrName = char(tempVar{j,:});
           wrName = strtrim(wrName(6:length(wrName)));
           break
       end
    end
    %Source
    for j=1:height(tempVar)
       if strfind(char(tempVar{j,:}),'SOURCE:') >= 1;
           wrSource = char(tempVar{j,:});
           wrSource = strtrim(wrSource(8:length(wrSource)));
           break
       end
    end
    %Flow
    for j=1:height(tempVar)
       if strfind(char(tempVar{j,:}),'FLOW:') >= 1;
           wrFlow = char(tempVar{j,:});
           wrFlow = strtrim(wrFlow(6:length(wrFlow)));
           break
       end
    end
    %Use
    for j=1:height(tempVar)
       if strfind(char(tempVar{j,:}),'DIVERSION --') >= 1;
           loc = strfind(char(tempVar{j,:}),'DIVERSION --');
           wrUse = char(tempVar{j,:});
           wrUse = strtok(strtrim(wrUse(loc+13:length(wrUse))),':');
           break
       end
    end
%     %Area
%     for j=1:height(tempVar)
%        if strfind(char(tempVar{j,:}),'ACREAGE TOTAL:') >= 1;
%            loc = strfind(char(tempVar{j,:}),'ACREAGE TOTAL:');
%            wrArea = char(tempVar{j,:});
%            wrArea = strtok(strtrim(wrArea(loc+length('ACREAGE TOTAL:'):length(wrArea))),':');
%            break
%        elseif strfind(char(tempVar{j,:}),'IRRIGATION:') >= 1;
%            loc = strfind(char(tempVar{j,:}),'ACREAGE TOTAL:');
%            wrArea = char(tempVar{j,:});
%            wrArea = strtok(strtrim(wrArea(loc+length('ACREAGE TOTAL:'):length(wrArea))),':');
%            break
%        elseif strfind(char(tempVar{j,:}),'service area is') >= 1;
%            loc = strfind(char(tempVar{j,:}),'service area is');
%            wrArea = char(tempVar{j,:});
%            wrArea = wrArea(loc+length('service area is'):length(wrArea));
%            break
%        end
%     end
    %Right
    wrNumber = char(WRN(i));
%     %Total
%     for j=1:height(tempVar)
%        if strfind(char(tempVar{j,:}),'Total') >= 1;
%            loc = strfind(char(tempVar{j,:}),'Total');
%            wrTotal = char(tempVar{j,:});
%            wrTotal = strtrim(wrTotal(loc+5:length(wrTotal)));
%            break
%        end
%     end
    %Months
    wrMonths = {'January','February','March','April','May','June','July','August','September','October','November','December'};
    wrMonth = {'','','','','','','','','','','',''};
    for k=1:12
        for j=1:height(tempVar)
           if strfind(char(tempVar{j,:}),char(wrMonths(k))) >= 1;
               loc = strfind(char(tempVar{j,:}),char(wrMonths(k)));
               wrMonth{k} = char(tempVar{j,:});
               [t,r] = strtok(wrMonth{k}(loc+length(char(wrMonths(k))):length(wrMonth{k})),',');
               wrMonth{k} = strcat(t,strtok(r,','));
               break
           end
        end
    end

    %% Save to new file
    fidO = fopen(char(Outfile),'a'); %creates the index file as a text file
    fprintf(fidO, '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n',wrName,wrNumber,wrSource,wrFlow,wrUse,char(wrMonth(1)),char(wrMonth(2)),char(wrMonth(3)),char(wrMonth(4)),char(wrMonth(5)),char(wrMonth(6)),char(wrMonth(7)),char(wrMonth(8)),char(wrMonth(9)),char(wrMonth(10)),char(wrMonth(11)),char(wrMonth(12)));
    fclose(fid0);
 end

%     