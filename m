From: Waskiewicz Jr, Peter <peter.waskiewicz.jr@intel.com>
Date: Sun, 27 Aug 2017 23:09:12 +0000
Subject: [Intel-wired-lan] [PATCH] igb: check memory allocation failure
References: <20170827063951.5975-1-christophe.jaillet@wanadoo.fr>
Message-ID: <E0D909EE5BB15A4699798539EA149D7F0779685B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/27/17 2:42 AM, Christophe JAILLET wrote:
> Check memory allocation failures and return -ENOMEM in such cases, as
> already done for other memory allocations in this function.
> 
> This avoids NULL pointers dereference.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index fd4a46b03cc8..837d9b46a390 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3162,6 +3162,8 @@ static int igb_sw_init(struct igb_adapter *adapter)
>   	/* Setup and initialize a copy of the hw vlan table array */
>   	adapter->shadow_vfta = kcalloc(E1000_VLAN_FILTER_TBL_SIZE, sizeof(u32),
>   				       GFP_ATOMIC);
> +	if (!adapter->shadow_vfta)
> +		return -ENOMEM;

Looks reasonable to me.

A larger issue though I see in this function is that if we return 
-ENOMEM here, and if we return -ENOMEM from igb_init_interrupt_scheme() 
below on failure, we leak adapter->mac_table (and adapter->shadow_vfta 
in the latter).  We should add a proper unwind to free up the memory on 
failure.

-PJ
