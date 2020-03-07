From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Fri, 6 Mar 2020 20:07:36 -0800
Subject: [Intel-wired-lan] [PATCH] igc: Fix NFC queue redirection support
In-Reply-To: <20200306235403.18751-1-andre.guedes@intel.com>
References: <20200306235403.18751-1-andre.guedes@intel.com>
Message-ID: <66f9198b-9cdb-441b-b2e1-1a4254971274@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/6/2020 15:54, Andre Guedes wrote:
> The support for ethtool Network Flow Classification (NFC) queue
> redirection based on destination MAC address is currently broken in IGC.
> For instance, if we add the following rule, matching frames aren't
> enqueued on the expected rx queue.
> 
> $ ethtool -N IFNAME flow-type ether dst 3c:fd:fe:9e:7f:71 queue 2
> 
> The issue here is due to the fact that igc_rar_set_index() is missing
> code to enable the queue selection feature from Receive Address High
> (RAH) register. This patch adds the missing code and fixes the issue.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h |  5 ++++-
>   drivers/net/ethernet/intel/igc/igc_main.c    | 11 ++++++++---
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index e5116337b68d..63d3d34763da 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -63,8 +63,11 @@
>    * (RAR[15]) for our directed address used by controllers with
>    * manageability enabled, allowing us room for 15 multicast addresses.
>    */
> +#define IGC_RAH_QSEL_MASK	0x000C0000
> +#define IGC_RAH_QSEL_SHIFT	18
> +#define IGC_RAH_QSEL_ENABLE	BIT(28)
>   #define IGC_RAH_AV		0x80000000 /* Receive descriptor valid */
> -#define IGC_RAH_POOL_1		0x00040000
> +
>   #define IGC_RAL_MAC_ADDR_LEN	4
>   #define IGC_RAH_MAC_ADDR_LEN	2
>   
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 025f2e439aef..49a0d0bff727 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -780,13 +780,18 @@ static void igc_rar_set_index(struct igc_adapter *adapter, u32 index)
>   	rar_low = le32_to_cpup((__le32 *)(addr));
>   	rar_high = le16_to_cpup((__le16 *)(addr + 4));
>   
> +	if (adapter->mac_table[index].state & IGC_MAC_STATE_QUEUE_STEERING) {
> +		u8 queue = adapter->mac_table[index].queue;
> +		u32 qsel = IGC_RAH_QSEL_MASK & (queue << IGC_RAH_QSEL_SHIFT);
> +
> +		rar_high |= qsel;
> +		rar_high |= IGC_RAH_QSEL_ENABLE;
> +	}
> +
>   	/* Indicate to hardware the Address is Valid. */
>   	if (adapter->mac_table[index].state & IGC_MAC_STATE_IN_USE) {
>   		if (is_valid_ether_addr(addr))
>   			rar_high |= IGC_RAH_AV;
> -
> -		rar_high |= IGC_RAH_POOL_1 <<
> -			adapter->mac_table[index].queue;
>   	}
>   
>   	wr32(IGC_RAL(index), rar_low);
> 
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
