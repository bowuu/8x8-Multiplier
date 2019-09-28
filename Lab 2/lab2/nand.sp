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
Vin1 in1 0 PWL(0 0 5ns 2 10ns 2 15ns 0 20ns 0 R) 
Vin2 in2 0 PWL(0 0 5ns 2 10ns 2 15ns 0 20ns 0 R)

m1 out in1 Vdd Vdd PMOS W=180 L=180
m2 out in2 Vdd Vdd PMOS W=180 L=180
m3 out in1  X   0  NMOS W=180 L=180
m4  X  in2  0   0  NMOS W=180 L=180

Cload out 0 0.1pF

.tran 1n 40n
*.measure tran tr TRIG v(out) val=0.36 RISE=1 TARG v(out) val=1.44 RISE=1
*.measure tran tf TRIG v(out) val=1.44 FALL=1 TARG v(out) val=0.36 FALL=1
*.measure tran tpdr TRIG v(in) val=0.9 FALL=1 TARG v(out) val=0.9 RISE=1
*.measure tran tpdf TRIG v(in) val=0.9 RISE=1 TARG v(out) val=0.9 FALL =1

***  Output Statements
.plot V(in1) V(in2) V(out)
.end




