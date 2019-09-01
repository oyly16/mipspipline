module top(reset,sysclk,keyclk,leds,digi,debug,showaddr,AN,ramdigi);
    input sysclk,reset,keyclk;
    input [6:0] showaddr;
    output [7:0] leds,debug;
    output [11:0] digi;
    output [3:0] AN;
    output [7:0] ramdigi;
    wire [31:0] ramshowdata;
    
    //wire resetd,keyclkd;
    //debounce d1(sysclk,reset,resetd);
    wire keyclkd;
    debounce d2(sysclk,keyclk,keyclkd);
    
    CPU CPU(.reset(reset),.clk(sysclk),.digi(digi),.showaddr(showaddr),.ramshowdata(ramshowdata),.leds(leds));
    assign debug=CPU.PCIF[9:2];
    
    ramshow ramshow(.ramdata(ramshowdata),.sysclk(sysclk),.AN(AN),.digi(ramdigi));
    
endmodule
