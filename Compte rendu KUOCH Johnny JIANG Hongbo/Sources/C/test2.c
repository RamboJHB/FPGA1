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
	u32 data_switch;		// Déclaration d'une variable qui contiendra l'état des interrupteurs
	u32 data_button;		// Déclaration d'une variable qui contiendra l'état des boutons
	XGpio my_led;		// Déclaration d'une structure GPIO associés aux leds
	XGpio *ledPtr = &my_led;		// Déclaration d'un pointeur vers cette structure
	XGpio my_button;		// Déclaration d'une structure GPIO associée aux boutons
	XGpio *buttonPtr;		// Déclaration d'un pointeur vers cette structure
	
	int counter = 0;		// Déclaration d'une variable de temporisation
	const int limit = 5000000;		// Déclaration d'une constante pour définir la fréquence de clignotement
	int antirebound_counter = 0;		// Déclaration d'une variable pour gérer le rebond
	const int antirebound_limit = 2000000;		// Déclaration d'une constante de temporisation pour gérer les rebonds
	u32 data_led = 0;		// Déclaration d'un variable qui contient l'état des leds
	
	XGpio_Initialize(ledPtr, XPAR_LED_SWITCH_DEVICE_ID);		// Appel d'une fonction configurant le GPIO en l'associant au périphérique LED de la carte
	XGpio_Initialize(ledPtr, XPAR_BOUTONS_DEVICE_ID);		// Appel d'une fonction associent le GPIO aux boutons de la carte
	
	XGpio_SetDataDirection(ledPtr,1,1);		// Appel d'une fonction pour fixer la direction du port 1 du GPIO my_led en entrée
	XGpio_SetDataDirection(ledPtr,2,0);		// Appel d'une fonction pour fixer la direction du port 2 du GPIO my_led en sortie
	XGpio_SetDataDirection(buttonPtr,1,1);		// Appel d'une fonction pour fixer la direction du port 2 du GPIO my_button en entrée
		// Exécution des fonctions de lecture écriture une première fois pour voir si l'on rentre bien dans la boucle
	
	data_switch = XGpio_DiscreteRead(ledPtr,1);		// Appel d'une fonction pour lire l'état des interrupteurs
	data_button = XGpio_DiscreteRead(buttonPtr,1):		// Appel d'une fonction pour lire l'état des boutons
	
	while(1)
	{
		if(data_switch == 1)		// Si l'interrupteur 0 est relevé, alors les leds doivent clignoter
		{
			counter++;		// On démarre le compteur
			
			if(counter < limit/2)		// Si le compteur est plus petit que sa valeur limite divisée par 2
			{
				XGpio_DiscreteWrite(ledPtr,2,0);		// On éteint les leds
				data_led = 0;		// On sauvegarde l'état des leds
			}
			else		// Sinon, elles s'allument
			{
				XGpio_DiscreteWrite(ledPtr,2,15);		// 1111 en binaire vaut 15 en décimal
				data_led = 15;
			}
			
			if(counter == limit)		// Si le compteur atteint sa valeur limite, 
			{
				counter = 0;		// On le remet à 0
			}
		}
		
		if(data_switch == 0)		// Si aucun interrupteur n'est relevé
		{
			XGpio_DiscreteWrite(ledPtr,2,2 + 8);		// On affiche un motif fixe
			data_led = 2 + 8;
		}
		
		if(data_switch == 2)		// Si l'interrupteur 1 est relevé
		{
			data_button = XGpio_DiscreteRead(buttonPtr,1);		// On lit l'état des boutons
			
			if(data_button == 4)		// Si on appuie sur le bouton gauche
			{
				XGpio_DiscreteWrite(ledPtr,2,15);		// Les leds s'allument
				data_led = 15;
			}
			
			if(data_button == 1)		// Si on appuie sur le bouton droit
			{
				XGpio_DiscreteWrite(ledPtr,2,0);		// Les leds s'éteignent
				data_led = 0;
			}
			
			if((data_button == 2) && (antirebound_counter == 0))		// Si on appuie sur le bouton central et que le compteur anti-rebond est à 0
			{
				antirebound_counter++;		// On incrémente le compteur anti-rebond
				
				if(data_led == 15)		// Si toutes les leds sont allumées
				{
					data_led = 0;		// On les éteint
				}
				
				if(data_led < 15)		// Sinon
				{
					data_led++;		// On incrémente l'état du compteur formé par les leds
				}
				
				XGpio_DiscreteWrite(ledPtr,2,data_led);		// On écrit sur les leds
			}
			
			if( (antirebound_counter > 0) && (antirebound_counter < antirebound_limit) )		// Si le compteur anti-rebond est plus petit que sa valeur limite
			{
				antirebound_counter++;		// On l'incrémente
			}
			else
			{
				antirebound_counter = 0;		// Sinon on le remet à 0
			}
		}
		
		data_switch = XGpio_DiscreteRead(ledPtr,1);		// Mise à jour de l'état des interrupteurs
	}
	
	return 0;
}