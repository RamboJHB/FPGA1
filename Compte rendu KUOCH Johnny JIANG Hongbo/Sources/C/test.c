/*
 * test.c
 *
 *  Created on: 20 févr. 2017
 *      Author: 3502859
 */

#include "xgpio.h"
#include "xparameters.h"

int main()
{
	u32 data;		// Déclaration d'une variable qui contiendra l'état des interrupteurs
	XGpio my_led;		// Déclaration d'une structure GPIO
	XGpio *ledPtr = &my_led;		// Déclaration d'un pointeur vers cette structure

	XGpio_Initialize(ledPtr, XPAR_LED_SWITCH_DEVICE_ID);		// Appel d'une fonction configurant le GPIO en l'associant au périphérique LED de la carte

	XGpio_SetDataDirection(ledPtr,1,1);		// Appel d'une fonction pour fixer la direction du port 1 en entrée
	XGpio_SetDataDirection(ledPtr,2,0);		// Appel d'une fonction pour fixer la direction du port 2 en entrée

		// Exécution des fonctions de lecture écriture une première fois pour voir si l'on rentre bien dans la boucle
	
	data = XGpio_DiscreteRead(ledPtr,1);		// Appel d'une fonction pour lire l'état des interrupteurs

	XGpio_DiscreteWrite(ledPtr,2,data);		// Appel d'une fonction pour écrire sur les LEDs

	while(1)
	{
		data = XGpio_DiscreteRead(ledPtr,1);

		XGpio_DiscreteWrite(ledPtr,2,data);
	}
	
	return 0;
}