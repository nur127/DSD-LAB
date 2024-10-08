module half_adder(sum,cout,a,b);
input a,b;
output sum,cout;

xor(sum,a,b);
and(cout,a,b);

endmodule

module full_adder(sum,cout,a,b,cin);
input a,b,cin;
output cout ,sum ;

wire w1,w2,w3;

half_adder h1(w1,w2,a,b);
half_adder h2(sum,w3,w1,cin);

or(cout,w2,w3);

endmodule

module adder_subtractor(sum,cout,a,b,cin);

input [3:0] a,b;
output [3:0] sum;
input cin;
output cout ;

wire [3:0] w;
wire c1,c2,c3;

xor(w[0],b[0],cin);
xor(w[1],b[1],cin);
xor(w[2],b[2],cin);
xor(w[3],b[3],cin);

full_adder f1(sum[0],c1,a[0],w[0],cin);
full_adder f2(sum[1],c2,a[1],w[1],c1);
full_adder f3(sum[2],c3,a[2],w[2],c2);
full_adder f4(sum[3],cout,a[3],w[3],c3);

endmodule

module testadder();
reg [3:0] a,b;
wire [3:0] sum;
reg cin;
wire cout ;

adder_subtractor as (sum,cout,a,b,cin);

initial 
begin
 a = 4'b1010 ;b 4'b0100;cin = 1'b0;
 #40
 a = 4'b1110 ;b 4'b1100;cin = 1'b0;
 #40
 a = 4'b0111 ;b 4'b0101;cin = 1'b1;
end


endmodule
