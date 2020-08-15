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

*Vname N1 N2 PWL(T1 V1 T2 V2 T3 V3)
*Vin   in 0  PWL(0 0 10ns 0 11ns 1.8 20ns 1.8)

*Vname N1 N2 PULSE V1 V2 td tr tf pw per
Vin  in  0 PULSE 0 1.8V 0.5ns 0.1ns 0.1ns 10ns 20ns
Vin1 in1 0 PULSE 0 1.8V 0.5ns 0.1ns 0.1ns  5ns 10ns
Vin2 in2 0 PULSE 0 1.8V 3.0ns 0.1ns 0.1ns  5ns 10ns

*m# drain gate source body XMOS W=#nm L=#nm

*Transmission gate D0
m0 out N  in1 Vdd NMOS W=180 L=180
m1 out in in1  0  PMOS W=180 L=180

*Transmission gate D1
m2 out in in2 Vdd NMOS W=180 L=180
m3 out N  in2  0  PMOS W=180 L=180

*Inverter for input
m4  N  in Vdd Vdd PMOS W=180 L=180
m5  N  in  0   0  NMOS W=180 L=180

*Cload out 0 0.01pF

.tran 1ns 40ns
.measure tran tr TRIG v(out) val=0.36 RISE=1 TARG v(out) val=1.44 RISE=1
.measure tran tf TRIG v(out) val=1.44 FALL=1 TARG v(out) val=0.36 FALL=1
.measure tran tpdr TRIG v(in) val=0.9 FALL=1 TARG v(out) val=0.9 RISE=1
.measure tran tpdf TRIG v(in) val=0.9 RISE=1 TARG v(out) val=0.9 FALL =1

***  Output Statements
.plot V(in) V(out)
.end




