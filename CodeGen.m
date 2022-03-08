
%% Immediate 

Int = 0:63;

for i = 1:length(Int)
Int_2_8Bit = reverse(dec2bin(Int(i),8));

File = "Code/Immediate/IMMEDIATE_"+Int(i)+".m";

FID = fopen(File,"w");

fprintf(FID,"function [CMD] = IMMEDIATE_%i() \n",Int(i));
fprintf(FID,"CMD = [%c %c %c %c %c %c %c %c] ; \n",Int_2_8Bit(:) ) ;
fprintf(FID,"end");

fclose(FID);

end 


%% Compute
CodeArray = [
"[0 0 0 0 0 0 1 0]" "OR"
"[1 0 0 0 0 0 1 0]" "NAND"
"[0 1 0 0 0 0 1 0]" "NOR"
"[1 1 0 0 0 0 1 0]" "AND"
"[0 0 1 0 0 0 1 0]" "ADD"
"[1 0 1 0 0 0 1 0]" "SUB"
];


for i = 1:size(CodeArray,1)
File = "Code/Compute/COMPUTE_"+CodeArray(i,2)+".m";

FID = fopen(File,"w");

fprintf(FID,"function [CMD] = COMPUTE_%s() \n",CodeArray(i,2));
fprintf(FID,"CMD = %s ;\n",CodeArray(i,1) ) ;
fprintf(FID,"end");

fclose(FID);
end 

%% COPY
%   128   64    32   16    8      4    2    1  
%   copy    |       FROM     |       TO 
%[   1    0 |   0    0    0  |    0    0    0]

% Written Reverse
% 1 2 4 6 8 16 32 64 128
Copy = "0 1";

From = [
       "0 0 0"  , "REG0"
       "1 0 0"  , "REG1"
       "0 1 0"  , "REG2"
       "1 1 0"  , "REG3"
       "0 0 1"  , "REG4"
       "1 0 1"  , "REG5"
       "0 1 1"  , "INPUT"
];

To= [
       "0 0 0"  , "REG0"
       "1 0 0"  , "REG1"
       "0 1 0"  , "REG2"
       "1 1 0"  , "REG3"
       "0 0 1"  , "REG4"
       "1 0 1"  , "REG5"
       "0 1 1"  , "OUTPUT"
];
       

for iFrom = 1:size(From,1)
    for iTo = 1:size(To,1)

        File = "Code/Copy/COPY_"+From(iFrom,2) +"_TO_"+To(iTo,2)+ ".m";

        FID = fopen(File,"w");

        fprintf(FID,"function [CMD] = COPY_%s_TO_%s()\n",From(iFrom,2),To(iTo,2));
        fprintf(FID,"CMD = [%s %s %s]; \n",To(iTo,1), From(iFrom,1),Copy) ;
        fprintf(FID,"end");

        fclose(FID);
    end
end
%% Conditionals 
Conditions = [
"0 0 0" "NEVER"
"1 0 0" "EQUAL_ZERO"
"0 1 0" "LESS_THAN_ZERO"
"1 1 0" "LESS_THAN_OR_EQUAL_ZERO"
"0 0 1" "ALWAYS_ON"
"1 0 1" "NOT_ZERO"
"0 1 1" "GREATER_THAN_OR_EQUAL_ZERO"
"1 1 1" "GREATER_THAN_ZERO"
];

Cond = "0 0 0 1 1";

for i = 1:size(Conditions,1)
File = "Code/Conditions/COND_"+Conditions(i,2)+".m";

FID = fopen(File,"w");

fprintf(FID,"function [CMD] = COND_%s() \n",Conditions(i,2));
fprintf(FID,"CMD = [ %s %s ] ;\n",Conditions(i,1),Cond ) ;
fprintf(FID,"end");

fclose(FID);
end 




