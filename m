From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 13 Jan 2022 16:47:56 -0800
Subject: [Intel-wired-lan] [PATCH net-queue v1] igc: Fix trying to
 register an already registered xdp_rxq
In-Reply-To: <20220113120346.9349-1-alexandr.lobakin@intel.com>
References: <YdxZr0wMxvsDCpbV@wantstofly.org>
 <20220113004015.449460-1-vinicius.gomes@intel.com>
 <20220113120346.9349-1-alexandr.lobakin@intel.com>
Message-ID: <87k0f36t37.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Lobakin <alexandr.lobakin@intel.com> writes:

> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Date: Wed, 12 Jan 2022 16:40:15 -0800
>
>> When changing the number of RX descriptors, for example, by doing
>> 
>>  $ ethtool -G enp3s0 rx 1024
>> 
>> the XDP RX queue information (xdp_rxq) may be already registered, if
>> it's registered there's no need to do any thing in relation to
>> xdp_rxq, none of it's parameters will change if we change the number
>> of descriptors, for example.
>> 
>> Fixes: 4609ffb9f615 ("igc: Refactor XDP rxq info registration")
>> Reported-by: Lennert Buytenhek <buytenh@wantstofly.org>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>> Lennert, I added your name and email to the Reported-by tag, please
>> see if you are ok with it.
>> 
>>  drivers/net/ethernet/intel/igc/igc_main.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index e29aadbc6744..d163139161fc 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  /* Copyright (c)  2018 Intel Corporation */
>>  
>> +#include "net/xdp.h"
>>  #include <linux/module.h>
>>  #include <linux/types.h>
>>  #include <linux/if_vlan.h>
>> @@ -499,12 +500,14 @@ int igc_setup_rx_resources(struct igc_ring *rx_ring)
>>  	u8 index = rx_ring->queue_index;
>>  	int size, desc_len, res;
>>  
>> -	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, index,
>> -			       rx_ring->q_vector->napi.napi_id);
>> -	if (res < 0) {
>> -		netdev_err(ndev, "Failed to register xdp_rxq index %u\n",
>> -			   index);
>> -		return res;
>> +	if (!xdp_rxq_info_is_reg(&rx_ring->xdp_rxq)) {
>> +		res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, index,
>> +				       rx_ring->q_vector->napi.napi_id);
>> +		if (res < 0) {
>> +			netdev_err(ndev, "Failed to register xdp_rxq index %u\n",
>> +				   index);
>> +			return res;
>> +		}
>>  	}
>
> While the fix itself is correct, I don't really like the setup flow
> in igc_ethtool_set_ringparam() (here: [0]).
>
> Instead of unregistering/freeing Rx rings at first and then
> allocating/registering the new ones, driver registers the new ones
> at first and then unregister the olds.
> It may cause other issues apart from this one. E.g. driver performs
> Rxq info unregistering at the end, so netdevice may end up with no
> Rxq info registered after changing the number of descriptors (Rxq
> info is enumerated by queue index).
>
> To me, the righteous approach would be changing this flow to more
> common, i.e. do unregistering/freeing at first and then register
> and allocate.

Agreed. I was not that familiar with this part of the code, it seems to
be more complicated than it needs. i.e. doing something similar to what
ice does would be better. But I was a bit sleep deprived yesterday to do
that :-)


Cheers,
-- 
Vinicius
