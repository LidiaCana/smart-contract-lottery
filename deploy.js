require("dotenv").config();
const HDWalletProvider = require("@truffle/hdwallet-provider");
const { Web3 } = require("web3");
//updated web3 and hdwallet-provider imports added for convenience
const { abi, bytecode } = require("./compile");
// deploy code will go here

const mnemonic = process.env.MNEMONIC_PHRASE,
  infuraKey = process.env.PROVIDER_URL;

const provider = new HDWalletProvider(mnemonic, infuraKey);

const web3 = new Web3(provider);
const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  const result = await new web3.eth.Contract(abi)
    .deploy({
      data: bytecode,
    })
    .send({ from: accounts[0], gas: "1000000" });
  provider.engine.stop();
};
deploy();
