**----------------------------------------------------------
* Inverter SPICE deck
**----------------------------------------------------------
* Parameters and models
**----------------------------------------------------------
.include mosistsmc180.sp.txt
.options post list scale=1n

**----------------------------------------------------------
* Simulation netlist
**----------------------------------------------------------
Vdd Vdd 0 1.8V
*Vin in 0 PWL(0 0 10ns 0 11ns 1.8 20ns 1.8)
Vin in  0 PULSE 0 1.8V 0.5ns 0.1ns 0.1ns 10ns 20ns

m0 out Vdd in Vdd NMOS W=180 L=180
*m1 out  0  in  0  PMOS W=180 L=180

*Cload out 0 0.01pF

.tran 1ns 40ns
.measure tran tr TRIG v(out) val=0.36 RISE=1 TARG v(out) val=1.44 RISE=1
.measure tran tf TRIG v(out) val=1.44 FALL=1 TARG v(out) val=0.36 FALL=1
.measure tran tpdr TRIG v(in) val=0.9 FALL=1 TARG v(out) val=0.9 RISE=1
.measure tran tpdf TRIG v(in) val=0.9 RISE=1 TARG v(out) val=0.9 FALL =1

***  Output Statements
.plot V(in) V(out)
.end




