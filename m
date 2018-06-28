From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 28 Jun 2018 14:39:57 +0300
Subject: [Intel-wired-lan] [RFC PATCH] igc: igc_xmit_frame_ring() can be
 static
In-Reply-To: <20180624150542.GA143916@lkp-hsx03>
References: <20180624084511.10198-1-sasha.neftin@intel.com>
 <20180624150542.GA143916@lkp-hsx03>
Message-ID: <de826662-68ee-1faa-328d-829e561c1283@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/24/2018 18:05, kbuild test robot wrote:
> 
> Fixes: 3e307bfcafb2 ("igc: Add transmit and receive fastpath and interrupt handlers")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> ---
>   igc_main.c |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 6782604..37358dc 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -948,8 +948,8 @@ static int igc_tx_map(struct igc_ring *tx_ring,
>   	return -1;
>   }
>   
> -netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
> -				struct igc_ring *tx_ring)
> +static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
> +				       struct igc_ring *tx_ring)
>   {
>   	struct igc_tx_buffer *first;
>   	u32 tx_flags = 0;
> @@ -1841,7 +1841,7 @@ void igc_down(struct igc_adapter *adapter)
>   	igc_clean_all_rx_rings(adapter);
>   }
>   
> -void igc_reinit_locked(struct igc_adapter *adapter)
> +static void igc_reinit_locked(struct igc_adapter *adapter)
>   {
>   	WARN_ON(in_interrupt());
>   	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
> @@ -3525,8 +3525,8 @@ static struct pci_driver igc_driver = {
>   	.remove   = igc_remove,
>   };
>   
> -void igc_set_flag_queue_pairs(struct igc_adapter *adapter,
> -			      const u32 max_rss_queues)
> +static void igc_set_flag_queue_pairs(struct igc_adapter *adapter,
> +				     const u32 max_rss_queues)
>   {
>   	/* Determine if we need to pair queues. */
>   	/* If rss_queues > half of max_rss_queues, pair the queues in
> @@ -3538,7 +3538,7 @@ void igc_set_flag_queue_pairs(struct igc_adapter *adapter,
>   		adapter->flags &= ~IGC_FLAG_QUEUE_PAIRS;
>   }
>   
> -unsigned int igc_get_max_rss_queues(struct igc_adapter *adapter)
> +static unsigned int igc_get_max_rss_queues(struct igc_adapter *adapter)
>   {
>   	unsigned int max_rss_queues;
>   
> 
good. will be applied to v4.
Thanks,
Sasha
