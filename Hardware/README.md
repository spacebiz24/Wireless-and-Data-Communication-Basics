## Optical Fibre Kit Procedure

1. ### Analog:
	1. Initialisation:
		- Toggle to analog mode
		- Set Signal generator to 1V @ 1KHz (Sine)
		- Connect Signal generator to IO1 which is connected to Analog In
		- Tap Analog IN to IO3 which is connected to the CRO
		- Connect the OFC from 850 nm LED (Tx) to the input of the op-amp (Rx)
		- Output of the op-amp is connected to IO2 which is connected to the CRO
		- Start the Signal generator to check if the input & output waves are in-phase
		- Remove all the connections at IO3 & turn off channel 2 of the CRO
	
 	1. Bending Loss:
		- Measure $V_{1_{pk-pk}}$ of a fully straight 1m OFC
		- Bend the OFC in steps & take 2 readings at different diameters
	
 	1. Propagation Loss:
    		- Measure $V_{3_{pk-pk}}$ of a fully straight 3m OFC
		- Use the following relation to measure propagation loss

		$$\frac{V_3}{V_1} = e^{-\alpha(l_3-l_1)}$$

	1. Coupling Loss:
		- Connect a 1m OFC to a 3m OFC via a coupler
		- Measure $V_{4_{pk-pk}}$ of the (1+3)m OFC
		- Compute the coupling loss using the following formula

		$$\eta = -10\log_{10}({V_4\over V_1}) - \alpha ' (l_3+l_1)$$
		$$\alpha ' = 4.343\times\alpha$$

	1. Numerical Aperture:
    	- Insert one end of the fibre to 650nm LED
		- Insert the other end into the Numerical Aperture Measurement Unit
		- Measure the radius of the spot ($r$) & height from the ground ($d$)
		- Find the Numerical aperture from the following relation
		
  		$$NA = \sin\theta = \frac{r}{\sqrt{d^2+r^2}}$$
		
1. ### Digital:
   	1. Initialisation:
   		- Toggle to digital mode
   	   	- Turn off the signal generator & remove all existing connections
   
	1. Time Division Multiplexing:
    	- Connect the OFC from 850 nm LED (Tx) to the op-amp (Rx)
		- Remove S4's jumper
		- Output of the op-amp is connected to the upper pin of S4
		- The other pin is connected to IO2 which is connected to the CRO
		- Flip the 8-bit data transmit switches

	 	$$1 ~ frame ~ time = 125\mu ~ s$$
		
		$$1 ~ slot ~ time = {frame ~ time\over 12} ~ s$$
		
		$$1 ~ bit ~ time(t_b) = {frame ~ time\over 8} ~ s$$
		
		$$1~ bit ~ rate = {1\over t_b} ~ bps$$
