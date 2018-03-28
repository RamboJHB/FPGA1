/*
 * test.c
 *
 *  Created on: 20 f�vr. 2017
 *      Author: 3502859
 */

#include "xgpio.h"
#include "xparameters.h"

int main()
{
	u32 data;
	XGpio my_led;
	XGpio *ledPtr = &my_led;

	int count = 0;

	XGpio_Initialize(ledPtr, XPAR_LED_SWITCH_DEVICE_ID);

	XGpio_SetDataDirection(ledPtr,1,1);
	XGpio_SetDataDirection(ledPtr,2,0);

	data = XGpio_DiscreteRead(ledPtr,1);

	XGpio_DiscreteWrite(ledPtr,2,data);

	while(1)
	{
		data = XGpio_DiscreteRead(ledPtr,1);

		if(data == 0x0001)
		{
			if(count < 100000) XGpio_DiscreteWrite(ledPtr,2,0x1111);
			else XGpio_DiscreteWrite(ledPtr,2,0x0000);

			count++;

			if(count == 200000) count = 0;
		}
	}
}
