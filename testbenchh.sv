module config_reg_tb();

	logic clk ;
	logic reset;
	logic write ;
	logic [15:0] data_in;
	logic [2:0] address;
	logic [15:0] data_out;
typedef enum bit [15:0] {adc0_reg,adc1_reg,temp_sensor0_reg,temp_sensor1_reg,analog_test,digital_test,amp_gain,digital_config} e_register;

config_reg DUT (clk,reset,write,data_in,address,data_out);

	initial begin 
		clk = 0; 
		forever
			#1 clk = ~clk ;
	end	
e_register my_reg ;
assign address = my_reg;
	// code for reg 1,4,5,7 (error is the reset value)



	// 1 st seed 
	initial begin
		reset =0; #10;
		write = 0 ;
		reset =1; #10;

		my_reg=adc0_reg;#2 			check_answer(16'hFFFF);#10 ;
		my_reg=adc1_reg;#2  		check_answer(16'h0);#10 ;
		my_reg=temp_sensor0_reg;#2  check_answer(16'h0);#10 ;
		my_reg=temp_sensor1_reg;#2  check_answer(16'h0);#10 ;
		my_reg=analog_test;#2 		check_answer(16'hABCD);#10 ;
		my_reg=digital_test;#2 		check_answer(16'h0);#10 ;
		my_reg=amp_gain;#2  		check_answer(16'h0);#10 ;
		my_reg=digital_config;#2    check_answer(16'h1);#10 ;
		$stop;
	end
	
// 2nd seed 
/*
	initial begin
		reset =1; #10;
		reset =0; #10;
		write = 1;#10;// here with write =0
		my_reg=adc0_reg;         data_in=16'h0110;#2 check_answer(16'h0110);#10 ;
		my_reg=adc1_reg;         data_in=16'h0110;#2 check_answer(16'h0110);#10 ;
		my_reg=temp_sensor0_reg; data_in=16'h0110;#2 check_answer(16'h0110);#10 ;
		my_reg=temp_sensor1_reg; data_in=16'h0110;#2 check_answer(16'h0110);#10 ;
		my_reg=analog_test;      data_in=16'h0110;#2 check_answer(16'h0110);#10 ;
		
		my_reg=amp_gain;         data_in=16'hA110;#2 check_answer(16'hA110);#10 ;//6

		my_reg=digital_test;     data_in=16'h0110;#2 check_answer(16'h0110);#10 ;//5

		my_reg=digital_config;   data_in=16'h0110;#2 check_answer(16'h0110);#10 ;

		#500;
			// testing the transition from 0 to 1 for all bits
		my_reg=adc0_reg;         data_in=16'hFFFF;#2 check_answer(16'hFFFF);#10 ;
		my_reg=adc1_reg;         data_in=16'hFFFF;#2 check_answer(16'hFFFF);#10 ;
		my_reg=temp_sensor0_reg; data_in=16'hFFFF;#2 check_answer(16'hFFFF);#10 ;
		my_reg=temp_sensor1_reg; data_in=16'hFFFF;#2 check_answer(16'hFFFF);#10 ;
		my_reg=analog_test;      data_in=16'hFFFF;#2 check_answer(16'hFFFF);#10 ;
		my_reg=digital_test;     data_in=16'hFFFF;#2 check_answer(16'hFFFF);#10 ;
		my_reg=amp_gain;         data_in=16'hFFFF;#2 check_answer(16'hFFFF);#10 ;
		my_reg=digital_config;   data_in=16'hFFFF;#2 check_answer(16'hFFFF);#10 ;

		#500;
			// testing the transition from 1 to 0 for all bits
		my_reg=adc0_reg;         data_in=0;#2 check_answer(0);#10 ;
		my_reg=adc1_reg;         data_in=0;#2 check_answer(0);#10 ;
		my_reg=temp_sensor0_reg; data_in=0;#2 check_answer(0);#10 ;
		my_reg=temp_sensor1_reg; data_in=0;#2 check_answer(0);#10 ;
		my_reg=analog_test;      data_in=0;#2 check_answer(0);#10 ;
		my_reg=digital_test;     data_in=0;#2 check_answer(0);#10 ;
		my_reg=amp_gain;         data_in=0;#2 check_answer(0);#10 ;
		my_reg=digital_config;   data_in=0;#2 check_answer(0);#10 ;

		$stop;

	end
*/





///////////////////////// BUT IT IS BETTER TO USE WALIKING ONES IN BOTH WRITE AND READ OPERATIONS //////////////////






	task check_answer (input logic [15:0] data_out_expected); 
			if (data_out != data_out_expected) 
				$display("error message %t :data_out = %h, data_out_expected = %h ,data_in= %h, address = %d , my_reg %d",$time ,data_out ,data_out_expected,data_in,address,my_reg);
			//else if (data_out != data_out_expected)
				//$display(" correct result %t :C %d, expected C %d , A = %d , B %d",$time ,C ,C_expected,A,B);
		endtask
endmodule