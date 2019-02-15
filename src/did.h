#ifndef DID_H
#define DID_H
#include <stdio.h>
#include <iostream>
#include <cstring>

class DID
{

	private:

		//hash value of the DID instance
		char* context;
		char* id;

	public:
	
		/*
		*	Set the context attribute of the instance
		*/
		void setContext(char* context);

		/*
		*
		*/
		void setId(char* id);

		/*
		*	Get the value of the instances context attribute
		*/
		char* getContext();

		/*
		*	Get the value of the instances Id attribute
		*/
		char* getId();

		/*
		*	Get a hash value of the instance
		*/
		std::string toString();


};

#endif
