#include <stdio.h>
#include <iostream>
#include <cstring>
#include <bits/stdc++.h>

#include "did.h"

void DID::setContext(char* context)
{
	this->context = context;
}

void DID::setId(char* id)
{
	this->id = id;
}

char* DID::getContext()
{
	return this->context;
}

char* DID::getId()
{
	return this->id;
}

std::string DID::toString()
{
	std::hash<char*> ptr_hash;
	size_t i_hash = ptr_hash(this->getId());

	std::stringstream ss;
	ss << std::hex << i_hash;

	return ss.str();
}
