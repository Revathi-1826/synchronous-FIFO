module fifo_tb();
reg clk,rst,we,re;
reg[7:0]data_in;
wire empty,full;
wire [7:0]data_out;
integer i;
fifo dut(clk,rst,we,re,data_in,data_out,empty,full);

always
begin
#5;clk=1'b0;
#5;clk=~clk;
end

task initialize();
{we,re,data_in}=0;
endtask

task reset();
begin
@(negedge clk);
rst=1'b1;
@(negedge clk);
rst=1'b0;
end
endtask

task write(input w,input [7:0]d);
begin
@(negedge clk);
we=w;
data_in=d;
end
endtask

task read(input r);
begin
@(negedge clk);
re=r;
end
endtask

initial begin
initialize();
reset();
/*fork
for(i=0;i<32;i=i+1)
 begin
  write(1,i);
 end
 read(1);
join*/
write(1,2);
write(1,4);
write(1,6);
write(1,8);
write(1,10);
write(1,12);
write(1,14);
write(0,2);
read(1);
read(1);
read(1);
read(1);
read(1);
read(1);
read(1);
#1000;
$finish;
end
initial
$monitor("rst=%b,we=%b,re=%b,data=%d,empty=%b,full=%b,data_out=%b",rst,we,re,data_in,empty,full,data_out);
endmodule
