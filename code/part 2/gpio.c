/*
 * test_1.c
 *
 *  Created on: 27 févr. 2018
 *      Author: 3602103
 */

#include "xgpio.h"
#include "xparameters.h"

int main(){

	XGpio led_sw, butt;
	//XGpio *ledPtr = &led_sw;
	//XGpio *buttPtr = &butt;

	u32 data_butt, data_sw;
	int i,cpt = 0;
	//init
	XGpio_Initialize(&led_sw, XPAR_LED_SWITCH_DEVICE_ID);
	XGpio_Initialize(&butt, XPAR_BOUTONS_DEVICE_ID);

	//set io
	XGpio_SetDataDirection(&led_sw, 1, 0xF);
	XGpio_SetDataDirection(&led_sw, 2, 0);


	while(1){
		//read
		data_butt = XGpio_DiscreteRead(&butt, 1);
		data_sw   = XGpio_DiscreteRead(&led_sw, 1);

		if (data_sw == 0x00000001) {
			XGpio_DiscreteWrite(&led_sw, 2, 0xFFFF);
			for (i = 0; i < 1000000; i ++){}
			XGpio_DiscreteWrite(&led_sw, 2, 0x0);
			for (i = 0; i < 1000000; i ++){}

		}else if (data_sw == 0x00000002){

			//right butt
			if (data_butt == 0x00000001)
				XGpio_DiscreteWrite(&led_sw, 2, 0x0000000f);
			//center
			while (data_butt == 0x00000002 ){
				data_butt = XGpio_DiscreteRead(&butt, 1);
				data_sw   = XGpio_DiscreteRead(&led_sw, 1);

				if ((data_butt == 0x00000004) || (data_butt == 0x00000001) || (data_sw != 0x00000002)  ){
					XGpio_DiscreteWrite(&led_sw, 2, 0);
					data_butt = 0;
				}else{
					data_butt =0x00000002;
				}

				XGpio_DiscreteWrite(&led_sw, 2, cpt);
				for (i = 0; i < 1000000; i ++){}
				if ( cpt == 15 ) cpt = 0;
					cpt++;
			}

			//left butt
			if (data_butt == 0x00000004)
				XGpio_DiscreteWrite(&led_sw, 2, 0x0000f000);

		}
	}

	return 0;
}
