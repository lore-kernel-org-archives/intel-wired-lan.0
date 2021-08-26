From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 26 Aug 2021 09:18:16 -0700
Subject: [Intel-wired-lan] [PATCH v4] ixgbe: let the xdpdrv work with
 more than 64 cpus
In-Reply-To: <20210826141623.8151-1-kerneljasonxing@gmail.com>
References: <20210826141623.8151-1-kerneljasonxing@gmail.com>
Message-ID: <00890ff4-3264-337a-19cc-521a6434d1d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 8/26/21 7:16 AM, kerneljasonxing at gmail.com wrote:
> From: Jason Xing <xingwanli@kuaishou.com>
> 
> Originally, ixgbe driver doesn't allow the mounting of xdpdrv if the
> server is equipped with more than 64 cpus online. So it turns out that
> the loading of xdpdrv causes the "NOMEM" failure.
> 
> Actually, we can adjust the algorithm and then make it work through
> mapping the current cpu to some xdp ring with the protect of @tx_lock.
> 
> v4:
> - Update the wrong commit messages. (Jason)
> 
> v3:
> - Change nr_cpu_ids to num_online_cpus() (Maciej)

I suspect this is wrong.

> - Rename MAX_XDP_QUEUES to IXGBE_MAX_XDP_QS (Maciej)
> - Rename ixgbe_determine_xdp_cpu() to ixgbe_determine_xdp_q_idx() (Maciej)
> - Wrap ixgbe_xdp_ring_update_tail() with lock into one function (Maciej)
> 
> v2:
> - Adjust cpu id in ixgbe_xdp_xmit(). (Jesper)
> - Add a fallback path. (Maciej)
> - Adjust other parts related to xdp ring.
> 
> Fixes: 33fdc82f08 ("ixgbe: add support for XDP_TX action")
> Co-developed-by: Shujin Li <lishujin@kuaishou.com>
> Signed-off-by: Shujin Li <lishujin@kuaishou.com>
> Signed-off-by: Jason Xing <xingwanli@kuaishou.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h           | 15 ++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c       |  9 ++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 64 ++++++++++++++++------
>  .../net/ethernet/intel/ixgbe/ixgbe_txrx_common.h   |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |  9 +--
>  5 files changed, 73 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index a604552..5f7f181 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -82,6 +82,8 @@
>  #define IXGBE_2K_TOO_SMALL_WITH_PADDING \
>  ((NET_SKB_PAD + IXGBE_RXBUFFER_1536) > SKB_WITH_OVERHEAD(IXGBE_RXBUFFER_2K))
>  
> +DECLARE_STATIC_KEY_FALSE(ixgbe_xdp_locking_key);
> +
>  static inline int ixgbe_compute_pad(int rx_buf_len)
>  {
>  	int page_size, pad_size;
> @@ -351,6 +353,7 @@ struct ixgbe_ring {
>  	};
>  	u16 rx_offset;
>  	struct xdp_rxq_info xdp_rxq;
> +	spinlock_t tx_lock;	/* used in XDP mode */
>  	struct xsk_buff_pool *xsk_pool;
>  	u16 ring_idx;		/* {rx,tx,xdp}_ring back reference idx */
>  	u16 rx_buf_len;
> @@ -375,7 +378,7 @@ enum ixgbe_ring_f_enum {
>  #define IXGBE_MAX_FCOE_INDICES		8
>  #define MAX_RX_QUEUES			(IXGBE_MAX_FDIR_INDICES + 1)
>  #define MAX_TX_QUEUES			(IXGBE_MAX_FDIR_INDICES + 1)
> -#define MAX_XDP_QUEUES			(IXGBE_MAX_FDIR_INDICES + 1)
> +#define IXGBE_MAX_XDP_QS		(IXGBE_MAX_FDIR_INDICES + 1)
>  #define IXGBE_MAX_L2A_QUEUES		4
>  #define IXGBE_BAD_L2A_QUEUE		3
>  #define IXGBE_MAX_MACVLANS		63
> @@ -629,7 +632,7 @@ struct ixgbe_adapter {
>  
>  	/* XDP */
>  	int num_xdp_queues;
> -	struct ixgbe_ring *xdp_ring[MAX_XDP_QUEUES];
> +	struct ixgbe_ring *xdp_ring[IXGBE_MAX_XDP_QS];
>  	unsigned long *af_xdp_zc_qps; /* tracks AF_XDP ZC enabled rings */
>  
>  	/* TX */
> @@ -772,6 +775,14 @@ struct ixgbe_adapter {
>  #endif /* CONFIG_IXGBE_IPSEC */
>  };
>  
> +static inline int ixgbe_determine_xdp_q_idx(int cpu)
> +{
> +	if (static_key_enabled(&ixgbe_xdp_locking_key))
> +		return cpu % IXGBE_MAX_XDP_QS;
> +	else
> +		return cpu;

Even if num_online_cpus() is 8, the returned cpu here could be

0, 32, 64, 96, 128, 161, 197, 224

Are we sure this will still be ok ?

> +}
> +
>  static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
>  {
>  	switch (adapter->hw.mac.type) {
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> index 0218f6c..884bf99 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
> @@ -299,7 +299,10 @@ static void ixgbe_cache_ring_register(struct ixgbe_adapter *adapter)
>  
>  static int ixgbe_xdp_queues(struct ixgbe_adapter *adapter)
>  {
> -	return adapter->xdp_prog ? nr_cpu_ids : 0;
> +	int queues;
> +
> +	queues = min_t(int, IXGBE_MAX_XDP_QS, num_online_cpus());

num_online_cpus() might change later...




> +	return adapter->xdp_prog ? queues : 0;
>  }
>  
>  #define IXGBE_RSS_64Q_MASK	0x3F
> @@ -947,6 +950,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
>  		ring->count = adapter->tx_ring_count;
>  		ring->queue_index = xdp_idx;
>  		set_ring_xdp(ring);
> +		spin_lock_init(&ring->tx_lock);
>  
>  		/* assign ring to adapter */
>  		WRITE_ONCE(adapter->xdp_ring[xdp_idx], ring);
> @@ -1032,6 +1036,9 @@ static void ixgbe_free_q_vector(struct ixgbe_adapter *adapter, int v_idx)
>  	adapter->q_vector[v_idx] = NULL;
>  	__netif_napi_del(&q_vector->napi);
>  
> +	if (static_key_enabled(&ixgbe_xdp_locking_key))
> +		static_branch_dec(&ixgbe_xdp_locking_key);
> +
>  	/*
>


