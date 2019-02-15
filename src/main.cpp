#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <secp256k1.h>
#include <key.h>

int main(int argc, char * argv[])
{
	printf("Generating a new private key\n");

	CKey secret;
	secret.MakeNewKey(true);
	CPubKey pub = secret.GetPubKey();
	uint256 hash = pub.GetHash();
	std::cout << hash << std::endl;
	return 0;
}
