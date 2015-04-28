From: Vlad Zolotarov <vladz@cloudius-systems.com>
Date: Tue, 28 Apr 2015 10:54:54 +0300
Subject: [Intel-wired-lan] [net-next PATCH] ixgbevf: add support for
 reporting RSS key and hash table for X550
In-Reply-To: <20150427203614.32710.54668.stgit@localhost6.localdomain6>
References: <20150427203614.32710.54668.stgit@localhost6.localdomain6>
Message-ID: <553F3CCE.10201@cloudius-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 04/27/15 23:36, Emil Tantilov wrote:
> This patch extends the reporting of the RSS key and hash table by
> adding support for X550 VFs. The difference is that X550 VFs have
> their own registers for RSS key and indirection table, so there is
> no need to query the PF.

Although the patch itself looks correct, there is a minor remark below.

The description is missing the mentioning that u have reworked the RSS 
hash table and RSS key initialization
flow for x550 VFs. U've added the caching the corresponding values in 
the ixgbevf_adapter struct and set the HW from these caches.
Then u've added some new macros which are clearly not a functional change.
U've also changed the indirection table content layout (to match the 
actual index of the HW entry with the index in the rss_indir_tbl[]).

All the above are not functional changes but are rather 
cleanup/refactoring. IMHO these changes deserves to be a separate patch 
from the
extending the RSS query (as the current patch description states) which 
is a functional change.

thanks,
vlad

>
> Reported-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbevf/ethtool.c      |   51 ++++++++++++---------
>   drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |    9 +++-
>   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   21 +++++----
>   3 files changed, 47 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> index b2f5b16..d3e5f5b 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
> @@ -813,22 +813,15 @@ static u32 ixgbevf_get_rxfh_indir_size(struct net_device *netdev)
>   {
>   	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
>   
> -	/* We support this operation only for 82599 and x540 at the moment */
> -	if (adapter->hw.mac.type < ixgbe_mac_X550_vf)
> -		return IXGBEVF_82599_RETA_SIZE;
> +	if (adapter->hw.mac.type >= ixgbe_mac_X550_vf)
> +		return IXGBEVF_X550_VFRETA_SIZE;
>   
> -	return 0;
> +	return IXGBEVF_82599_RETA_SIZE;
>   }
>   
>   static u32 ixgbevf_get_rxfh_key_size(struct net_device *netdev)
>   {
> -	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
> -
> -	/* We support this operation only for 82599 and x540 at the moment */
> -	if (adapter->hw.mac.type < ixgbe_mac_X550_vf)
> -		return IXGBEVF_RSS_HASH_KEY_SIZE;
> -
> -	return 0;
> +	return IXGBEVF_RSS_HASH_KEY_SIZE;
>   }
>   
>   static int ixgbevf_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
> @@ -840,21 +833,33 @@ static int ixgbevf_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
>   	if (hfunc)
>   		*hfunc = ETH_RSS_HASH_TOP;
>   
> -	/* If neither indirection table nor hash key was requested - just
> -	 * return a success avoiding taking any locks.
> -	 */
> -	if (!indir && !key)
> -		return 0;
> +	if (adapter->hw.mac.type >= ixgbe_mac_X550_vf) {
> +		if (key)
> +			memcpy(key, adapter->rss_key, sizeof(adapter->rss_key));
>   
> -	spin_lock_bh(&adapter->mbx_lock);
> -	if (indir)
> -		err = ixgbevf_get_reta_locked(&adapter->hw, indir,
> -					      adapter->num_rx_queues);
> +		if (indir) {
> +			int i;
>   
> -	if (!err && key)
> -		err = ixgbevf_get_rss_key_locked(&adapter->hw, key);
> +			for (i = 0; i < IXGBEVF_X550_VFRETA_SIZE; i++)
> +				indir[i] = adapter->rss_indir_tbl[i];
> +		}
> +	} else {
> +		/* If neither indirection table nor hash key was requested
> +		 *  - just return a success avoiding taking any locks.
> +		 */
> +		if (!indir && !key)
> +			return 0;
>   
> -	spin_unlock_bh(&adapter->mbx_lock);
> +		spin_lock_bh(&adapter->mbx_lock);
> +		if (indir)
> +			err = ixgbevf_get_reta_locked(&adapter->hw, indir,
> +						      adapter->num_rx_queues);
> +
> +		if (!err && key)
> +			err = ixgbevf_get_rss_key_locked(&adapter->hw, key);
> +
> +		spin_unlock_bh(&adapter->mbx_lock);
> +	}
>   
>   	return err;
>   }
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> index 775d089..04c7ec8 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> @@ -144,9 +144,11 @@ struct ixgbevf_ring {
>   
>   #define MAX_RX_QUEUES IXGBE_VF_MAX_RX_QUEUES
>   #define MAX_TX_QUEUES IXGBE_VF_MAX_TX_QUEUES
> -#define IXGBEVF_MAX_RSS_QUEUES	2
> -#define IXGBEVF_82599_RETA_SIZE	128
> +#define IXGBEVF_MAX_RSS_QUEUES		2
> +#define IXGBEVF_82599_RETA_SIZE		128	/* 128 entries */
> +#define IXGBEVF_X550_VFRETA_SIZE	64	/* 64 entries */
>   #define IXGBEVF_RSS_HASH_KEY_SIZE	40
> +#define IXGBEVF_VFRSSRK_REGS		10	/* 10 registers for RSS key */
>   
>   #define IXGBEVF_DEFAULT_TXD	1024
>   #define IXGBEVF_DEFAULT_RXD	512
> @@ -447,6 +449,9 @@ struct ixgbevf_adapter {
>   
>   	spinlock_t mbx_lock;
>   	unsigned long last_reset;
> +
> +	u32 rss_key[IXGBEVF_VFRSSRK_REGS];
> +	u8 rss_indir_tbl[IXGBEVF_X550_VFRETA_SIZE];
>   };
>   
>   enum ixbgevf_state_t {
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index e480708..8a73514 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -1669,22 +1669,25 @@ static void ixgbevf_setup_vfmrqc(struct ixgbevf_adapter *adapter)
>   {
>   	struct ixgbe_hw *hw = &adapter->hw;
>   	u32 vfmrqc = 0, vfreta = 0;
> -	u32 rss_key[10];
>   	u16 rss_i = adapter->num_rx_queues;
> -	int i, j;
> +	u8 i, j;
>   
>   	/* Fill out hash function seeds */
> -	netdev_rss_key_fill(rss_key, sizeof(rss_key));
> -	for (i = 0; i < 10; i++)
> -		IXGBE_WRITE_REG(hw, IXGBE_VFRSSRK(i), rss_key[i]);
> +	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
> +	for (i = 0; i < IXGBEVF_VFRSSRK_REGS; i++)
> +		IXGBE_WRITE_REG(hw, IXGBE_VFRSSRK(i), adapter->rss_key[i]);
>   
> -	/* Fill out redirection table */
> -	for (i = 0, j = 0; i < 64; i++, j++) {
> +	for (i = 0, j = 0; i < IXGBEVF_X550_VFRETA_SIZE; i++, j++) {
>   		if (j == rss_i)
>   			j = 0;
> -		vfreta = (vfreta << 8) | (j * 0x1);
> -		if ((i & 3) == 3)
> +
> +		adapter->rss_indir_tbl[i] = j;
> +
> +		vfreta |= j << (i & 0x3) * 8;
> +		if ((i & 3) == 3) {
>   			IXGBE_WRITE_REG(hw, IXGBE_VFRETA(i >> 2), vfreta);
> +			vfreta = 0;
> +		}
>   	}
>   
>   	/* Perform hash on these packet types */
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

