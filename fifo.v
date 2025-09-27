module fifo(clk,rst,we,re,data_in,data_out,empty,full);
input clk,rst,we,re;
input [7:0]data_in;
output reg[7:0]data_out;
output  empty,full;
reg [4:0]wr_ptr,rd_ptr;
reg [7:0]mem[0:15];
integer i;
//write operation
always@(posedge clk)
begin
if(rst)
begin
for(i=0;i<=15;i=i+1)
  begin
    mem[i]<=0;
  end
wr_ptr<=0;
rd_ptr<=0;
end
else
begin
   if(we && !full)
      begin
      mem[wr_ptr[3:0]]<=data_in;
      wr_ptr<=wr_ptr+1;
      end
 else
     wr_ptr<=wr_ptr;
end
end

//READ OPERATION

always@(posedge clk)
begin
if(rst)
  data_out<=0;
else
begin
    if(re && !empty)
       begin
       data_out<=mem[rd_ptr[3:0]];
       rd_ptr<=rd_ptr+1;
       end
    else
       rd_ptr<=rd_ptr;
end
end

//EMPTY CONDITION
assign empty=(wr_ptr == rd_ptr)?1'b1:1'b0;
//FULL CONDITION
assign full=((wr_ptr[4]!=rd_ptr[4])&& (wr_ptr[3:0] == rd_ptr[3:0]))?1'b1:1'b0;
endmodule
