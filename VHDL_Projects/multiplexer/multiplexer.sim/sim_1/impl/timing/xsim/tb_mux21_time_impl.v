// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
// Date        : Wed Nov 10 13:35:02 2021
// Host        : aidin-HP-Laptop-15-bs1xx running 64-bit Ubuntu 21.10
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               /home/aidin/Documents/University/Management_and_Analysis_of_Physics_Datasets/Laboratory/VHDL_Projects/multiplexer/multiplexer.sim/sim_1/impl/timing/xsim/tb_mux21_time_impl.v
// Design      : mux21
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "a1307ea5" *) 
(* NotValidForBitStream *)
module mux21
   (a_in,
    b_in,
    sel_in,
    y_out);
  input a_in;
  input b_in;
  input sel_in;
  output y_out;

  wire a_in;
  wire a_in_IBUF;
  wire b_in;
  wire b_in_IBUF;
  wire sel_in;
  wire sel_in_IBUF;
  wire y_out;
  wire y_out_OBUF;

initial begin
 $sdf_annotate("tb_mux21_time_impl.sdf",,,,"tool_control");
end
  IBUF a_in_IBUF_inst
       (.I(a_in),
        .O(a_in_IBUF));
  IBUF b_in_IBUF_inst
       (.I(b_in),
        .O(b_in_IBUF));
  IBUF sel_in_IBUF_inst
       (.I(sel_in),
        .O(sel_in_IBUF));
  OBUF y_out_OBUF_inst
       (.I(y_out_OBUF),
        .O(y_out));
  LUT3 #(
    .INIT(8'hAC)) 
    y_out_OBUF_inst_i_1
       (.I0(b_in_IBUF),
        .I1(a_in_IBUF),
        .I2(sel_in_IBUF),
        .O(y_out_OBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
