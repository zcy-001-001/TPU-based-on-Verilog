module function_lib1();
    function automatic [1:0] full_adder(input a, input b, input cin);
        reg sum, carry;
        begin
            sum = a ^ b ^ cin;           // sum = a XOR b XOR carry_in
            carry = (a & b) | (b & cin) | (a & cin); // carry = ab + bc_in + ac_in
            full_adder = {carry, sum};   // 返回carry和sum
        end
    endfunction
endmodule

