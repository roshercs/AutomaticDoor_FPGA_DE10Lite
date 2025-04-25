# AutomaticDoor_FPGA_DE10Lite
This projects implement a system for automatic opening with a Ultrasonic sensor and a Stepper motor. Developed with a FPGA card (DE-10 Lite) using VHDL code.


The objetive of this project is develop an automatic door model that opens and closes independently, taking into account that people may take more or less time to pass through the door. For this, we use the ultrasonic sensor not only for the opening start, also for check if someone stills on the door. This feature is particularly useful for individuals with limited mobility. A stepper motor controls the automatic opening when the sensor detects someone approaching, and it closes only after the sensor no longer detects any person within the specified range.
