#include <stdio.h>
#include <iostream>
#include <cstring>
// #include <secp256k1>
#include "did.h"

int main(int argc, char * argv[])
{
	std::string s_id = "did:ln:523226:1367:0";
	std::string s_context = "https://w3id.org/did/v1";

	char* c_id = new char[s_id.length() + 1];
	char* c_context = new char[s_context.length() + 1];

	std::strcpy(c_id, s_id.c_str());
	std::strcpy(c_context, s_context.c_str());

	// create a DID instance
	DID mydid;
	// populate instance attributes
	mydid.id = c_id;
	mydid.context = c_context;

	std::cout << mydid.context << std::endl;
	return 0;
}
