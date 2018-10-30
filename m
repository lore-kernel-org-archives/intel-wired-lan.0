From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 21:58:54 +0000
Subject: [Intel-wired-lan] [PATCH S8 09/16] ice: Fix tx_timeout in PF
 driver
In-Reply-To: <20181026174105.11628-10-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
 <20181026174105.11628-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328D08@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S8 09/16] ice: Fix tx_timeout in PF driver
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Prior to this commit the driver was running into tx_timeouts when a queue
> was stressed enough. This was happening because the HW tail and SW tail
> (NTU) were incorrectly out of sync. Consequently this was causing the HW
> head to collide with the HW tail, which to the hardware means that all
> descriptors posted for Tx have been processed.
> 
> Due to the Tx logic used in the driver SW tail and HW tail are allowed to be
> out of sync. This is done as an optimization because it allows the driver to
> write HW tail as infrequently as possible, while still updating the SW tail index
> to keep track. However, there are situations where this results in the tail
> never getting updated, resulting in Tx timeouts.
> 
> Tx HW tail write condition:
> 	if (netif_xmit_stopped(txring_txq(tx_ring) || !skb->xmit_more)
> 		writel(sw_tail, tx_ring->tail);
> 
> An issue was found in the Tx logic that was causing the aformentioned
> condition for updating HW tail to never happen, causing tx_timeouts.
> 
> In ice_xmit_frame_ring we calculate how many descriptors we need for the
> Tx transaction based on the skb the kernel hands us. This is then passed into
> ice_maybe_stop_tx along with some extra padding to determine if we have
> enough descriptors available for this transaction. If we don't then we return -
> EBUSY to the stack, otherwise we move on and eventually prepare the Tx
> descriptors accordingly in ice_tx_map and set next_to_watch. In ice_tx_map
> we make another call to ice_maybe_stop_tx with a value of
> MAX_SKB_FRAGS + 4. The key here is that this value is possibly less than the
> value we sent in the first call to ice_maybe_stop_tx in ice_xmit_frame_ring.
> Now, if the number of unused descriptors is between MAX_SKB_FRAGS + 4
> and the value used in the first call to ice_maybe_stop_tx in
> ice_xmit_frame_ring then we do not update the HW tail because of the "Tx
> HW tail write condition" above. This is because in ice_maybe_stop_tx we
> return success from ice_maybe_stop_tx instead of calling
> __ice_maybe_stop_tx and subsequently calling netif_stop_subqueue, which
> sets the __QUEUE_STATE_DEV_XOFF bit. This bit is then checked in the "Tx
> HW tail write condition" by calling netif_xmit_stopped and subsequently
> updating HW tail if the aformentioned bit is set.
> 
> In ice_clean_tx_irq, if next_to_watch is not NULL, we end up cleaning the
> descriptors that HW sets the DD bit on and we have the budget. The HW
> head will eventuallly run into the HW tail in response to the description in the
> paragraph above.
> 
> The next time through ice_xmit_frame_ring we make the initial call to
> ice_maybe_stop_tx with another skb from the stack. This time we do not
> have enough descriptors available and we return NETDEV_TX_BUSY to the
> stack and end up setting next_to_watch to NULL.
> 
> This is where we are stuck. In ice_clean_tx_irq we never clean anything
> because next_to_watch is always NULL and in ice_xmit_frame_ring we
> never update HW tail because we already return NETDEV_TX_BUSY to the
> stack and eventually we hit a tx_timeout.
> 
> This issue was fixed by making sure that the second call to
> ice_maybe_stop_tx in ice_tx_map is passed a value that is >= the value that
> was used on the initial call to ice_maybe_stop_tx in ice_xmit_frame_ring.
> This was done by adding the following defines to make the logic more clear
> and to reduce the chance of mucking this up
> again:
> 
> ICE_CACHE_LINE_BYTES		64
> ICE_DESCS_PER_CACHE_LINE	(ICE_CACHE_LINE_BYTES / \
> 				 sizeof(struct ice_tx_desc))
> ICE_DESCS_FOR_CTX_DESC		1
> ICE_DESCS_FOR_SKB_DATA_PTR	1
> 
> The ICE_CACHE_LINE_BYTES being 64 is an assumption being made so we
> don't have to figure this out on every pass through the Tx path. Instead I
> added a sanity check in ice_probe to verify cache line size and print a
> message if it's not 64 Bytes. This will make it easier to file issues if they are
> seen when the cache line size is not 64 Bytes when reading from the
> GLPCI_CNF2 register.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  2 ++
>  drivers/net/ethernet/intel/ice/ice_main.c       | 18 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c       |  9 +++++----
>  drivers/net/ethernet/intel/ice/ice_txrx.h       | 17 +++++++++++++++--
>  4 files changed, 40 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


