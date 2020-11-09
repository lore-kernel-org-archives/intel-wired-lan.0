From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 09 Nov 2020 13:06:33 -0800
Subject: [Intel-wired-lan] [PATCH bpf-next 5/6] xsk: introduce batched
 Tx descriptor interfaces
In-Reply-To: <1604498942-24274-6-git-send-email-magnus.karlsson@gmail.com>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
 <1604498942-24274-6-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <5fa9af59a5f89_8c0e208b1@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Introduce batched descriptor interfaces in the xsk core code for the
> Tx path to be used in the driver to write a code path with higher
> performance. This interface will be used by the i40e driver in the
> next patch. Though other drivers would likely benefit from this new
> interface too.
> 
> Note that batching is only implemented for the common case when
> there is only one socket bound to the same device and queue id. When
> this is not the case, we fall back to the old non-batched version of
> the function.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  include/net/xdp_sock_drv.h |  7 ++++
>  net/xdp/xsk.c              | 43 ++++++++++++++++++++++
>  net/xdp/xsk_queue.h        | 89 +++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 126 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 5b1ee8a..4e295541 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -13,6 +13,7 @@
>  
>  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
> +u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_desc *desc, u32 max);
>  void xsk_tx_release(struct xsk_buff_pool *pool);
>  struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
>  					    u16 queue_id);
> @@ -128,6 +129,12 @@ static inline bool xsk_tx_peek_desc(struct xsk_buff_pool *pool,
>  	return false;
>  }
>  
> +static inline u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_desc *desc,
> +						 u32 max)
> +{
> +	return 0;
> +}
> +
>  static inline void xsk_tx_release(struct xsk_buff_pool *pool)
>  {
>  }
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index b71a32e..dd75b5f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -332,6 +332,49 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
>  }
>  EXPORT_SYMBOL(xsk_tx_peek_desc);
>  
> +u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_desc *descs,
> +				   u32 max_entries)
> +{
> +	struct xdp_sock *xs;
> +	u32 nb_pkts;
> +
> +	rcu_read_lock();
> +	if (!list_is_singular(&pool->xsk_tx_list)) {
> +		/* Fallback to the non-batched version */
> +		rcu_read_unlock();
> +		return xsk_tx_peek_desc(pool, &descs[0]) ? 1 : 0;
> +	}
> +
> +	xs = list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock, tx_list);

I'm not seeing how we avoid the null check here? Can you add a comment on why this
is safe? I see the bind/unbind routines is it possible to unbind while this is
running or do we have some locking here.

> +
> +	nb_pkts = xskq_cons_peek_desc_batch(xs->tx, descs, pool, max_entries);
> +	if (!nb_pkts) {
> +		xs->tx->queue_empty_descs++;
> +		goto out;
> +	}
> +
> +	/* This is the backpressure mechanism for the Tx path. Try to
> +	 * reserve space in the completion queue for all packets, but
> +	 * if there are fewer slots available, just process that many
> +	 * packets. This avoids having to implement any buffering in
> +	 * the Tx path.
> +	 */
> +	nb_pkts = xskq_prod_reserve_addr_batch(pool->cq, descs, nb_pkts);
> +	if (!nb_pkts)
> +		goto out;
> +
> +	xskq_cons_release_n(xs->tx, nb_pkts);
> +	__xskq_cons_release(xs->tx);
> +	xs->sk.sk_write_space(&xs->sk);

Can you move the out label here? Looks like nb_pkts = 0 in all cases
where goto out is used.

> +	rcu_read_unlock();
> +	return nb_pkts;
> +
> +out:
> +	rcu_read_unlock();
> +	return 0;
> +}
> +EXPORT_SYMBOL(xsk_tx_peek_release_desc_batch);
> +
>  static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
>  {
>  	struct net_device *dev = xs->dev;

[...]

Other than above question LGTM.

Thanks,
John
