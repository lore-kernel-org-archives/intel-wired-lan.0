From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 11 Feb 2021 01:55:47 +0100
Subject: [Intel-wired-lan] [PATCH net-next v3 8/9] igc: Enable RX via
 AF_XDP zero-copy
In-Reply-To: <20210209024243.23406-9-vedang.patel@intel.com>
References: <20210209024243.23406-1-vedang.patel@intel.com>
 <20210209024243.23406-9-vedang.patel@intel.com>
Message-ID: <20210211005547.GB44042@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Feb 08, 2021 at 06:42:42PM -0800, Vedang Patel wrote:
> From: Andre Guedes <andre.guedes@intel.com>
> 
> Add support for receiving packets via AF_XDP zero-copy mechanism.
> 
> A new flag is added to 'enum igc_ring_flags_t' to indicate the ring has
> AF_XDP zero-copy enabled so proper ring setup is carried out during ring
> configuration in igc_configure_rx_ring().

I'm still stubborn when it comes to imperative mood usage in commit
messages :P so a kind reminder to apply that.

'A new flag is added' -> 'Add a new flag'

Not a big deal though.

> 
> RX buffers can now be allocated via the shared pages mechanism (default
> behavior of the driver) or via xsk pool (when AF_XDP zero-copy is
> enabled) so a union is added to the 'struct igc_rx_buffer' to cover both
> cases.
> 
> When AF_XDP zero-copy is enabled, rx buffers are allocated from the xsk
> pool using the new helper igc_alloc_rx_buffers_zc() which is the
> counterpart of igc_alloc_rx_buffers().
> 
> Likewise other Intel drivers that support AF_XDP zero-copy, in igc we
> have a dedicated path for cleaning up rx irqs when zero-copy is enabled.
> This avoids adding too many checks within igc_clean_rx_irq(), resulting
> in a more readable and efficient code since this function is called from
> the hot-path of the driver.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  22 +-
>  drivers/net/ethernet/intel/igc/igc_base.h |   1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 336 +++++++++++++++++++++-
>  drivers/net/ethernet/intel/igc/igc_xdp.c  |  98 +++++++
>  drivers/net/ethernet/intel/igc/igc_xdp.h  |   2 +
>  5 files changed, 440 insertions(+), 19 deletions(-)
> 

[...]

> +
> +static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
> +{
> +	struct igc_adapter *adapter = q_vector->adapter;
> +	struct igc_ring *ring = q_vector->rx.ring;
> +	u16 cleaned_count = igc_desc_unused(ring);
> +	int total_bytes = 0, total_packets = 0;
> +	struct bpf_prog *prog;
> +	bool failure = false;
> +	int xdp_status = 0;
> +
> +	rcu_read_lock();
> +
> +	prog = READ_ONCE(adapter->xdp_prog);
> +
> +	while (likely(total_packets < budget)) {
> +		union igc_adv_rx_desc *desc;
> +		struct igc_rx_buffer *bi;
> +		ktime_t timestamp = 0;
> +		unsigned int size;
> +		int res;
> +
> +		desc = IGC_RX_DESC(ring, ring->next_to_clean);

I think we've seen some minor optimization happening from working on local
ring->next_to_clean value, IOW maybe do:

u16 ntc = ring->next_to_clean;

and store it back to ring after the main while () loop

> +		size = le16_to_cpu(desc->wb.upper.length);
> +		if (!size)
> +			break;
> +
> +		/* This memory barrier is needed to keep us from reading
> +		 * any other fields out of the rx_desc until we know the
> +		 * descriptor has been written back
> +		 */
> +		dma_rmb();
> +
> +		bi = &ring->rx_buffer_info[ring->next_to_clean];
> +
> +		if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
> +			timestamp = igc_ptp_rx_pktstamp(q_vector->adapter,
> +							bi->xdp->data);
> +
> +			bi->xdp->data += IGC_TS_HDR_LEN;
> +			size -= IGC_TS_HDR_LEN;
> +		}
> +
> +		bi->xdp->data_end = bi->xdp->data + size;
> +		xsk_buff_dma_sync_for_cpu(bi->xdp, ring->xsk_pool);
> +
> +		res = igc_xdp_do_run_prog(adapter, prog, bi->xdp);
> +		switch (res) {
> +		case IGC_XDP_PASS:
> +			igc_dispatch_skb_zc(q_vector, desc, bi->xdp, timestamp);
> +			fallthrough;
> +		case IGC_XDP_CONSUMED:
> +			xsk_buff_free(bi->xdp);
> +			break;
> +		case IGC_XDP_TX:
> +		case IGC_XDP_REDIRECT:
> +			xdp_status |= res;
> +			break;
> +		}
> +
> +		bi->xdp = NULL;
> +		total_bytes += size;
> +		total_packets++;
> +		cleaned_count++;
> +		ring->next_to_clean++;
> +		if (ring->next_to_clean == ring->count)
> +			ring->next_to_clean = 0;
> +	}
> +
> +	rcu_read_unlock();
> +
> +	if (cleaned_count >= IGC_RX_BUFFER_WRITE)
> +		failure = !igc_alloc_rx_buffers_zc(ring, cleaned_count);
> +
> +	if (xdp_status)
> +		igc_finalize_xdp(adapter, xdp_status);
> +
> +	igc_update_rx_stats(q_vector, total_packets, total_bytes);
> +
> +	if (xsk_uses_need_wakeup(ring->xsk_pool)) {
> +		if (failure || ring->next_to_clean == ring->next_to_use)
> +			xsk_set_rx_need_wakeup(ring->xsk_pool);
> +		else
> +			xsk_clear_rx_need_wakeup(ring->xsk_pool);
> +		return total_packets;
> +	}
> +
> +	return failure ? budget : total_packets;
> +}
