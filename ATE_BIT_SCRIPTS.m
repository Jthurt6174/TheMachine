%% Script 1
 %{
Load in integer 10 to reg 0
copy to reg 1
lod in integer 23 
copy to reg 2
add /  always reg 1 and 2 for calculations and result goes to reg 2
send result from reg 3 to output 
 %}

CODE = [
IMMEDIATE_10
COPY_REG0_TO_REG1
IMMEDIATE_23
COPY_REG0_TO_REG2
COMPUTE_ADD
COPY_REG3_TO_OUTPUT
]