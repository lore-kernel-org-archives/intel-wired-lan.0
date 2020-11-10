From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 10 Nov 2020 09:28:21 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next 5/6] xsk: introduce batched
 Tx descriptor interfaces
In-Reply-To: <5fa9af59a5f89_8c0e208b1@john-XPS-13-9370.notmuch>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
 <1604498942-24274-6-git-send-email-magnus.karlsson@gmail.com>
 <5fa9af59a5f89_8c0e208b1@john-XPS-13-9370.notmuch>
Message-ID: <CAJ8uoz2gU+3Va0a4Z1jij-jgN4DCwHb57xbs98SLr58gjVWp1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 9, 2020 at 10:06 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Introduce batched descriptor interfaces in the xsk core code for the
> > Tx path to be used in the driver to write a code path with higher
> > performance. This interface will be used by the i40e driver in the
> > next patch. Though other drivers would likely benefit from this new
> > interface too.
> >
> > Note that batching is only implemented for the common case when
> > there is only one socket bound to the same device and queue id. When
> > this is not the case, we fall back to the old non-batched version of
> > the function.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  include/net/xdp_sock_drv.h |  7 ++++
> >  net/xdp/xsk.c              | 43 ++++++++++++++++++++++
> >  net/xdp/xsk_queue.h        | 89 +++++++++++++++++++++++++++++++++++++++-------
> >  3 files changed, 126 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index 5b1ee8a..4e295541 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> > @@ -13,6 +13,7 @@
> >
> >  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
> >  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
> > +u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_desc *desc, u32 max);
> >  void xsk_tx_release(struct xsk_buff_pool *pool);
> >  struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
> >                                           u16 queue_id);
> > @@ -128,6 +129,12 @@ static inline bool xsk_tx_peek_desc(struct xsk_buff_pool *pool,
> >       return false;
> >  }
> >
> > +static inline u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_desc *desc,
> > +                                              u32 max)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline void xsk_tx_release(struct xsk_buff_pool *pool)
> >  {
> >  }
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index b71a32e..dd75b5f 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -332,6 +332,49 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
> >  }
> >  EXPORT_SYMBOL(xsk_tx_peek_desc);
> >
> > +u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_desc *descs,
> > +                                u32 max_entries)
> > +{
> > +     struct xdp_sock *xs;
> > +     u32 nb_pkts;
> > +
> > +     rcu_read_lock();
> > +     if (!list_is_singular(&pool->xsk_tx_list)) {
> > +             /* Fallback to the non-batched version */
> > +             rcu_read_unlock();
> > +             return xsk_tx_peek_desc(pool, &descs[0]) ? 1 : 0;
> > +     }
> > +
> > +     xs = list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock, tx_list);
>
> I'm not seeing how we avoid the null check here? Can you add a comment on why this
> is safe? I see the bind/unbind routines is it possible to unbind while this is
> running or do we have some locking here.

You are correct. The entry can disappear between list_is_singluar and
list_first_or_null_rcu. There are 3 possibilities at this point:

0 entries: as you point out, we need to test for this and exit since
the socket does not exist anymore.
1 entry: everything is working as expected.
>1 entry: we only process the first socket in the list. This is fine since this can only happen when we add a second socket to the list and the next time we enter this function list_is_singular() will not be true anymore, so we will use the fallback version that will process packets from all sockets. So the only thing that will happen in this rare case is that the start of processing for the second socket is delayed ever so slightly.

In summary, I will add a test for !xs and exit in that case.

> > +
> > +     nb_pkts = xskq_cons_peek_desc_batch(xs->tx, descs, pool, max_entries);
> > +     if (!nb_pkts) {
> > +             xs->tx->queue_empty_descs++;
> > +             goto out;
> > +     }
> > +
> > +     /* This is the backpressure mechanism for the Tx path. Try to
> > +      * reserve space in the completion queue for all packets, but
> > +      * if there are fewer slots available, just process that many
> > +      * packets. This avoids having to implement any buffering in
> > +      * the Tx path.
> > +      */
> > +     nb_pkts = xskq_prod_reserve_addr_batch(pool->cq, descs, nb_pkts);
> > +     if (!nb_pkts)
> > +             goto out;
> > +
> > +     xskq_cons_release_n(xs->tx, nb_pkts);
> > +     __xskq_cons_release(xs->tx);
> > +     xs->sk.sk_write_space(&xs->sk);
>
> Can you move the out label here? Looks like nb_pkts = 0 in all cases
> where goto out is used.

Nice simplification. Will fix.

Thanks: Magnus

> > +     rcu_read_unlock();
> > +     return nb_pkts;
> > +
> > +out:
> > +     rcu_read_unlock();
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(xsk_tx_peek_release_desc_batch);
> > +
> >  static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
> >  {
> >       struct net_device *dev = xs->dev;
>
> [...]
>
> Other than above question LGTM.
>
> Thanks,
> John
