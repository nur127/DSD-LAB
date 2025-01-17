module bcd_to_xs3(w,x,y,z,a,b,c,d);
input a,b,c,d ;
output w,x,y,z;

wire w1,w2,w3,w4,w5,w6,w7,bn,cn,dn,s1,s2;

and(w1,b,c);
and(w2,b,d);
or(s1,w1,w2);
or(w,b,s1);

not(bn,b);
not(cn,c);
not(dn,d);

and(w3,bn,c);
and(w4,bn,d);
or(s2,w3,w4);
and(w5,b,dn);
and(w6,w5,cn);
or(x,s2,w6);

xor(w7,c,d);
not(y,w7);

not(z,d);


endmodule