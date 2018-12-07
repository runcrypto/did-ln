#!/usr/bin/python3

# use the following command with modified hsmd to export the private key
# (see https://github.com/ElementsProject/lightning/issues/1762)#

from subprocess import run, Popen, PIPE
import logging
import os
import sys
import json

logging.basicConfig(level=logging.DEBUG)

lightning_node = "lightning1"

node_dir = "/home/clightning/.{}".format(lightning_node)
hsm_secret = "{}/hsm_secret".format(node_dir)

hsmd = "/home/clightning/lightning/lightningd/lightning_hsmd"
cli = "/usr/local/bin/lightning-cli"

did_document = "/home/clightning/did-ln/examples/simple-did.json"



def getNodeId():

	# return the nodeinfo from lightning cli
	logging.info("Retrieving node info from: {}".format(lightning_node))
	process = Popen([cli,"--lightning-dir={}".format(node_dir), "getinfo"],stdout=PIPE)
	nodeinfo, err = process.communicate()

	# parse the command output as json
	node_json = json.loads(nodeinfo.decode("utf-8").strip())
	logging.debug("Node id: {}".format(node_json['id']))
	return node_json['id']


def getPrivKey(secret):
	
	# extract private key from lightning node
	logging.info("Retrieving public key from: {}".format(hsm_secret))
	process = Popen([hsmd,"--dump-xpriv",secret],stdout=PIPE)
	bprivkey, err = process.communicate()

	# convert byte array to string and remove newline
	privkey = bprivkey.decode("utf-8").strip()
	logging.debug("Private Key: {}".format(privkey))
	
	return privkey



def getPubKeysFromDidDoc(did_doc):
	
	logging.info("Retrieving public key from did document: {}".format(did_doc))

	# read the did document as json
	f = open(did_doc)
	did_json = json.loads(f.read())
	logging.debug("DID content: {}".format(did_json))

	# extract owners and public keys
	keys = {}
	for keydata in did_json['publicKey']:
		logging.debug("extracting key for: {}".format(keydata['owner']))
		keys[keydata['owner']] = keydata['publicKeyPem']
	
	logging.debug("extracted {} keys: {}".format(len(keys),keys))
	return keys


if __name__ == "__main__":
	
	nodeid = getNodeId()
	privkey = getPrivKey(hsm_secret)
	pubkey = getPubKeysFromDidDoc(did_document)
