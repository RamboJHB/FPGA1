/*****************************************************************************/
/**
* @file xgpio_intr_tapp_example.c
*
* This file contains a design example using the GPIO driver (XGpio) in an
* interrupt driven mode of operation. This example does assume that there is
* an interrupt controller in the hardware system and the GPIO device is
* connected to the interrupt controller.
*
* Push buttons are connected on a channel of the GPIO device.
*
******************************************************************************/

/***************************** Include Files *********************************/

#include "xparameters.h"
#include "xgpio.h"
#include "xil_exception.h"
#include "xintc.h"
#include <stdio.h>

/************************** Constant Definitions *****************************/
/*
 * The following constants map to the names of the hardware instances that
 * were created in the Vivado system.  They are only defined here such that
 * a user can easily change all the needed device IDs in one place.
 */
#define GPIO_DEVICE_ID		XPAR_PUSH_BUTTONS_4BITS_DEVICE_ID
#define INTC_GPIO_INTERRUPT_ID	XPAR_INTC_0_GPIO_2_VEC_ID
#define GPIO_CHANNEL1		1

#define INTC_DEVICE_ID	XPAR_INTC_0_DEVICE_ID

/* Max delay to generate an interrupt (see GpioIntrExample() function */
#define INTR_DELAY	0x00FFFFFF

#define INTC_HANDLER	XIntc_InterruptHandler

/************************** Function Prototypes ******************************/
void GpioHandler(void *CallBackRef);

int GpioIntrExample(XIntc *IntcInstancePtr, XGpio *InstancePtr,
			u16 DeviceId, u16 IntrId,
			u16 IntrMask, u32 *DataRead);

int GpioSetupIntrSystem(XIntc *IntcInstancePtr, XGpio *InstancePtr,
			u16 DeviceId, u16 IntrId, u16 IntrMask);

void GpioDisableIntr(XIntc *IntcInstancePtr, XGpio *InstancePtr,
			u16 IntrId, u16 IntrMask);

/********************** Global Variable Definitions **************************/

XGpio Gpio; /* The Instance of the GPIO Driver */

XIntc Intc; /* The Instance of the Interrupt Controller Driver */


static u16 GlobalIntrMask; /* GPIO channel mask that is needed by
			    * the Interrupt Handler */

static volatile u32 IntrFlag; /* Interrupt Handler Flag */

/****************************************************************************/
/**
* This function is the main function of the GPIO example.  It is responsible
* for initializing the GPIO device, setting up interrupts and providing a
* foreground loop such that interrupt can occur in the background.
*
* If an interrupt occurs, the DataRead variable will be set to 1, otherwise it
* will remain set to 0.
*
*****************************************************************************/
int main(void)
{
	u32 DataRead;

	print(" Press button to Generate Interrupt\r\n");

	/* Launch GPIO interrupt application */			   
	GpioIntrExample(&Intc, &Gpio,				// Interrupt controller & GPIO devices
				   GPIO_DEVICE_ID,				// ID of the GPIO device
				   INTC_GPIO_INTERRUPT_ID,		// ID of the GPIO interrupt
				   GPIO_CHANNEL1, 				// GPIO channel used in the application
				   &DataRead);					// Return value (will be 0 or 1)

	/* If no interrupt has occured */			   
	if(DataRead == 0)
			print("No button pressed. \r\n");
	/* If no interrupt has occured */			   
	else
			print("Gpio Interrupt Test PASSED. \r\n");
	return 0;
}

/******************************************************************************/
/**
*
* This is the entry function from the GPIO interrupt test application
*
* @param	IntcInstancePtr is a reference to the Interrupt Controller
*			driver Instance
* @param	InstancePtr is a reference to the GPIO driver Instance
* @param	DeviceId is the XPAR_<GPIO_instance>_DEVICE_ID value from
*			xparameters.h
* @param	IntrId is XPAR_<INTC_instance>_<GPIO_instance>_IP2INTC_IRPT_INTR
*			value from xparameters.h
* @param	IntrMask is the GPIO channel mask
* @param	DataRead is the pointer where the data read from GPIO Input is
*			returned
*
* @note		None.
*
******************************************************************************/
void GpioIntrExample(XIntc *IntcInstancePtr, XGpio* InstancePtr, u16 DeviceId,
			u16 IntrId, u16 IntrMask, u32 *DataRead)
{
	u32 delay;	// Time counter

	/* Initialize the GPIO driver */
	XGpio_Initialize(InstancePtr, DeviceId);

	/* Interrupt configuration in the GPIO and the interrupt controller */
	GpioSetupIntrSystem(IntcInstancePtr, 	// Interrupt controller device
						InstancePtr, 		// GPIO device
						DeviceId,			// ID of the GPIO device
						IntrId, 			// ID of the GPIO interrupt
						IntrMask);			// GPIO channel used in the application
	
	IntrFlag = 0;
	delay = 0;

	/* Wait while no interrupt has occured and max delay has not yet been reached... */
	while(!IntrFlag && (delay < INTR_DELAY)) {
		delay++;
	}

	/* Return value of the interrupt flag */
	*DataRead = IntrFlag;	

}


/******************************************************************************/
/**
*
* This function performs the GPIO set up for Interrupts
*
* @param	IntcInstancePtr is a reference to the Interrupt Controller
*			driver Instance
* @param	InstancePtr is a reference to the GPIO driver Instance
* @param	DeviceId is the XPAR_<GPIO_instance>_DEVICE_ID value from
*			xparameters.h
* @param	IntrId is XPAR_<INTC_instance>_<GPIO_instance>_IP2INTC_IRPT_INTR
*			value from xparameters.h
* @param	IntrMask is the GPIO channel mask
*
******************************************************************************/
void GpioSetupIntrSystem(XIntc *IntcInstancePtr, XGpio *InstancePtr,
			u16 DeviceId, u16 IntrId, u16 IntrMask)
{
	/* Mask is the number of the GPIO channel that generates the interruption */
	GlobalIntrMask = IntrMask;

	/*
	 * Initialize the interrupt controller driver so that it's ready to use.
	 * specify the device ID that was generated in xparameters.h
	 */
	XIntc_Initialize(IntcInstancePtr, INTC_DEVICE_ID);

	/* 
	 * Link the GPIO instance to an interrupt channel in the controller 
	 * and to an ISR program called GpioHandler
	*/
	XIntc_Connect(IntcInstancePtr, IntrId,
		      (Xil_ExceptionHandler)GpioHandler, InstancePtr);

	/* Enable the interrupt vector at the interrupt controller */
	XIntc_Enable(IntcInstancePtr, IntrId);

	/*
	 * Start the interrupt controller such that interrupts are recognized
	 * and handled by the processor
	 */
	XIntc_Start(IntcInstancePtr, XIN_REAL_MODE);
	
	/*
	 * Enable the GPIO channel interrupts so that push buttons can be
	 * detected and enable interrupts for the GPIO device
	 */
	XGpio_InterruptEnable(InstancePtr, IntrMask);
	XGpio_InterruptGlobalEnable(InstancePtr);

	/*
	 * Initialize the exception table and register the interrupt
	 * controller handler with the exception table
	 */
	Xil_ExceptionInit();

	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			 (Xil_ExceptionHandler)INTC_HANDLER, IntcInstancePtr);

	/* Enable non-critical exceptions */
	Xil_ExceptionEnable();
}

/******************************************************************************/
/**
*
* This is the interrupt handler routine for the GPIO for this example.
*
* @param	CallbackRef is the Callback reference for the handler.
*
******************************************************************************/
void GpioHandler(void *CallbackRef)
{
	XGpio *GpioPtr = (XGpio *)CallbackRef;

	/* Set the interrupt flag */
	IntrFlag = 1;
	
	/* Clear the Interrupt */
	XGpio_InterruptClear(GpioPtr, GlobalIntrMask);

}
