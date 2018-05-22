/*
 * tp3.c
 *
 *  Created on: 13 mars 2018
 *      Author: 3602103
 */


#include "xgpio.h"
#include "xparameters.h"
#include "my_led.h"

#define BIT(b,n)   (((n)>>(b))&1)

int main(){

    XGpio sw;
    u32 a, b, c, d, data;

    XGpio_Initialize(&sw, XPAR_SW_DEVICE_ID);

    XGpio_SetDataDirection(&sw, 1, 0xF);


    while (1){
        data = XGpio_DiscreteRead(&sw, 1);
        a = ( BIT(0,data) == 1 )? 1 : 0 ;
        b = ( BIT(1,data) == 1 )? 1 : 0 ;
        c = ( BIT(2,data) == 1 )? 1 : 0 ;
        d = ( BIT(3,data) == 1 )? 1 : 0 ;
        MY_LED_mWriteReg(XPAR_MY_LED_0_S00_AXI_BASEADDR, MY_LED_S00_AXI_SLV_REG0_OFFSET, a);
        MY_LED_mWriteReg(XPAR_MY_LED_0_S00_AXI_BASEADDR, MY_LED_S00_AXI_SLV_REG0_OFFSET+1, b);
        MY_LED_mWriteReg(XPAR_MY_LED_0_S00_AXI_BASEADDR, MY_LED_S00_AXI_SLV_REG1_OFFSET, c);
        MY_LED_mWriteReg(XPAR_MY_LED_0_S00_AXI_BASEADDR, MY_LED_S00_AXI_SLV_REG1_OFFSET+1, d);

    //reg1 = MY_LED_mReadReg(XPAR_MY_LED_0_S00_AXI_BASEADDR, MY_LED_S00_AXI_SLV_REG0_OFFSET);


    }
    return 0;
}
