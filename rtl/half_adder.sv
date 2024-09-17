module half_adder(x,y,s,c_out);
   input x,y,c_in;
   output s,c_out;
   assign s = x^y;
   assign c_out = x&y;
endmodule