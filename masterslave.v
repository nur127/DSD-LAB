module jk(q,qbar,j,k,clear,clock);
input j,k,clear,clock ; 
output q,qbar ;
wire a,b,y,ybar,c,d,cbar ;

nand(a,j,clock,clear,qbar);
nand(b,clock,k,q);
nand(y,a,ybar);
nand(ybar,clear,y,b);

not(cbar,clock);

nand(c,y,cbar);
nand(d,cbar,ybar);
nand(q,c,qbar);
nand(qbar,clear,d,q);

endmodule 

module updown(q,m,clear,clock);

input m,clear,clock ;
output [2:0] q ;
wire [2:0]qbar ;
wire x,y;

//jk(q,qbar,j,k,clear,clock);

jk JK1 (q[0] , qbar[0],1'b1,1'b1,clear,clock);
xor(x,q[0],m);

jk JK2 (q[1] , qbar[1],1'b1,1'b1,clear,x);
xor(y,q[1],m);

jk JK3 (q[2] , qbar[2],1'b1,1'b1,clear,y);


endmodule

module UP_DOWN_SIMULATION;
	reg m,clear,clock;
    wire [2:0] q ;
    wire [2:0]qbar ;
    wire x,y;

    updown ud (q,m,clear,clock);

    initial 
    clock = 0;
    always #10 clock = ~clock ;

    initial
    begin
       // clear = 1 ;
        #5 clear = 0;
        #15 clear = 1 ;
    end

    initial
    begin
        m = 1'b0 ;

        #500 m=1'b1 ;
        #500 m = 1'b0 ;
    end
endmodule

module asyn (q ,clear,clock);
input clear , clock ;
output [3:0]q ;
wire [3:0]qbar ;

//jk(q,qbar,j,k,clear,clock);

jk JK1(q[0],qbar[0],1'b1 , 1'b1,clear,clock);
jk JK2(q[1],qbar[1],1'b1 , 1'b1,clear,q[0]);
jk JK3(q[2],qbar[2],1'b1 , 1'b1,clear,q[1]);
jk JK4(q[3],qbar[3],1'b1 , 1'b1,clear,q[2]);

 endmodule

 module modtentest ;

 reg clear ,clock ;
 wire [3:0]q ;
wire [3:0]qbar ;

asyn as (q ,clear,clock);

initial
begin
clear = 0 ;
#5 clear = 1;
end

initial
clock = 0 ;
always #40 clock = ~clock;

always @(negedge clock)
begin
    if(q == 4'b1010)
    begin
        clear = 0 ;
        #20 clear = 1 ;
    end   

end    

 endmodule

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
 a = 4'b1010 ;b = 4'b0100;cin = 1'b0;
 #40
 a = 4'b1110 ;b = 4'b1100;cin = 1'b0;
 #40
 a = 4'b0111 ;b = 4'b0101;cin = 1'b1;
end


endmodule


module upspractice(q,m,clear,clock);
input m,clear,clock ;
output [2:0]q;
wire[2:0]qbar , w;


//jk(q,qbar,j,k,clear,clock);
jk JK1 (q[0],qbar[0],1'b1,1'b1,clear,clock);
xor(w[0],q[0],m);
jk JK2 (q[1],qbar[1],1'b1,1'b1,clear,w[0]);
xor(w[1],q[1],m);
jk JK3 (q[2],qbar[2],1'b1,1'b1,clear,w[1]);
 

endmodule

module upstestbanch ();

reg m,clear,clock ;
wire [2:0]q;
wire[2:0]qbar; 

upspractice goribs (q,m,clear,clock);

initial
clock = 0;
always #10 clock = ~clock ;

initial
begin
    clear = 0 ;
    #10 clear = 1;
end

initial
begin
     m = 1'b0 ;

     #250 m = 1'b1 ;
     #250 m = 1'b0 ;
end

endmodule