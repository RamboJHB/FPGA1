/*
 * test_2.c
 *
 *  Created on: 27 fÈvr. 2018
 *      Author: 3602103
 */

#include "xgpio.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xil_exception.h"
#include "xintc.h"

static int cpt =0 ;
/* The Instance of the GPIO Driver */
XGpio butt,led_sw;
u16 IntrMask = 1;

void GpioHandler(void *CallbackRef );


int main(){
    
    /* The Instance of the Interrupt Controller Driver */
    XIntc Intc;
    u32 data_butt, data_sw;
    int i;
    
    //init gpio
    XGpio_Initialize(&butt, XPAR_BOUTONS_DEVICE_ID);
    XGpio_Initialize(&led_sw, XPAR_LED_SWITCH_DEVICE_ID);
    XGpio_SetDataDirection(&led_sw, 1, 0xF);
    XGpio_SetDataDirection(&led_sw, 2, 0);
    
    XGpio_DiscreteWrite(&led_sw, 2, 0xFFFF);
    
    XIntc_Initialize(&Intc, XPAR_INTC_0_DEVICE_ID);
    XIntc_Connect(&Intc, XPAR_MICROBLAZE_0_AXI_INTC_BOUTONS_IP2INTC_IRPT_INTR,
            (Xil_ExceptionHandler)GpioHandler, &butt);
    XIntc_Enable(&Intc, XPAR_MICROBLAZE_0_AXI_INTC_BOUTONS_IP2INTC_IRPT_INTR);
    
    XIntc_Start(&Intc, XIN_REAL_MODE);

    XGpio_InterruptEnable(&butt, IntrMask);
    XGpio_InterruptGlobalEnable(&butt);
    
    Xil_ExceptionInit();
    
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
                                 (Xil_ExceptionHandler)XIntc_InterruptHandler, &Intc);
    
    Xil_ExceptionEnable();
    return 0;
};


void GpioHandler(void *CallbackRef ){
    
    XGpio *but = (XGpio *)CallbackRef;
    
    
    //application of button
    u32 data = XGpio_DiscreteRead(but, 1);
    //center
    if (data == 0x00000002 ){
        if ( cpt == 15 ) cpt = 0;
        cpt++;
    }
    XGpio_DiscreteWrite(&led_sw, 2, cpt);
    
    // Clear the Interrupt
    XGpio_InterruptClear(but, IntrMask);
};


