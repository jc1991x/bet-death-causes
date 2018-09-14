// 这些代码是9月12号前 用get code 拉下来的。所以，我只是还原了作案现场。事情不是我干的。是大神v5。

cleos -u http://api1.eosasia.one  get code  -a betdice.abi -c betdice.wast eosbetdice11
cleos -u http://api1.eosasia.one  get code  -a safetransfer.abi -c safetransfer.wast safetransfer

// create account 
cleos create account eosio eosbetdice11 EOS6kSHM2DbVHBAZzPk7UjpeyesAGsQvoUKyPeMxYpv1ZieBgPQNi EOS6kSHM2DbVHBAZzPk7UjpeyesAGsQvoUKyPeMxYpv1ZieBgPQNi
cleos create account eosio safetransfer EOS6kSHM2DbVHBAZzPk7UjpeyesAGsQvoUKyPeMxYpv1ZieBgPQNi EOS6kSHM2DbVHBAZzPk7UjpeyesAGsQvoUKyPeMxYpv1ZieBgPQNi
cleos create account eosio eosbetcasino EOS6kSHM2DbVHBAZzPk7UjpeyesAGsQvoUKyPeMxYpv1ZieBgPQNi EOS6kSHM2DbVHBAZzPk7UjpeyesAGsQvoUKyPeMxYpv1ZieBgPQNi

// set code
cleos set code eosbetdice11 /Users/joe/Workspace/eos-project/eos-bet-dice/betdice.wast
cleos set abi eosbetdice11 /Users/joe/Workspace/eos-project/eos-bet-dice/betdice.abi

cleos set code safetransfer /Users/joe/Workspace/eos-project/eos-bet-dice/safetransfer.wast
cleos set abi safetransfer /Users/joe/Workspace/eos-project/eos-bet-dice/safetransfer.abi

// set permission
cleos set account permission eosbetdice11 active '{"threshold": 1,"keys": [{"key": "EOS6kSHM2DbVHBAZzPk7UjpeyesAGsQvoUKyPeMxYpv1ZieBgPQNi","weight": 1}],"accounts":[{"permission":{"actor":"eosbetdice11","permission":"eosio.code"},"weight":1}]}' owner -p eosbetdice11@owner
cleos set account permission safetransfer active '{"threshold": 1,"keys": [{"key": "EOS6kSHM2DbVHBAZzPk7UjpeyesAGsQvoUKyPeMxYpv1ZieBgPQNi","weight": 1}],"accounts":[{"permission":{"actor":"safetransfer","permission":"eosio.code"},"weight":1}]}' owner -p safetransfer@owner
cleos set account permission safetransfer active '{"threshold": 1,"keys": [{"key": "EOS6kSHM2DbVHBAZzPk7UjpeyesAGsQvoUKyPeMxYpv1ZieBgPQNi","weight": 1}],"accounts":[{"permission":{"actor":"eosbetdice11","permission":"eosio.code"},"weight":1}]}' owner -p safetransfer@owner

cleos set account permission eosbetcasino random '{"threshold": 1,"keys": [{"key": "EOS6kSHM2DbVHBAZzPk7UjpeyesAGsQvoUKyPeMxYpv1ZieBgPQNi","weight": 1}],"accounts":[]}' owner -p eosbetcasino@owner


// initcontract 
cleos push action eosbetdice11 initcontract '{"randomness_key":"EOS6kSHM2DbVHBAZzPk7UjpeyesAGsQvoUKyPeMxYpv1ZieBgPQNi"}' -p eosbetcasino

// test
cleos push action eosbetdice11 transfer '{"from":"joetothemoon","to":"eosbetdice11","quantity":"10.0000 EOS","memo":"88-okbtozhemoon-"}' -p joetothemoon

// result 
cleos get actions joetothemoon

// table data
cleos get table eosbetdice11 eosbetdice11 activebets

// try resolvebet (先用 get table eosbetdice11 eosbetdice11 activebets 获取 bet_id, 签名替换为你的私钥对应生成签名。
cleos push action eosbetdice11 resolvebet '{"bet_id":"13268895739635552667", "sig":"SIG_K1_JyLrnpivQrsrmfaFqpk8168zS3sAxVi91KWb3MCkU5uBNrj52h7GPp5HMSxxdA3y9yMPHpQSWw1PNn4kJojMAHK2kK9fRY"}' -p eosbetcasino@random

