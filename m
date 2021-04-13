From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 13 Apr 2021 08:25:01 -0700
Subject: [Intel-wired-lan] [PATCH RFC net] igb: Fix XDP with PTP enabled
In-Reply-To: <20210412162846.42706d99@carbon>
References: <20210412101713.15161-1-kurt@linutronix.de>
 <20210412162846.42706d99@carbon>
Message-ID: <CAKgT0UekqPNQxV6PzpEeis69z3e3YNcaFyot=nD7w26hLxPX2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Apr 12, 2021 at 7:29 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
>
> On Mon, 12 Apr 2021 12:17:13 +0200
> Kurt Kanzenbach <kurt@linutronix.de> wrote:
>
> > When using native XDP with the igb driver, the XDP frame data doesn't point to
> > the beginning of the packet. It's off by 16 bytes. Everything works as expected
> > with XDP skb mode.
> >
> > Actually these 16 bytes are used to store the packet timestamps. Therefore, pull
> > the timestamp before executing any XDP operations and adjust all other code
> > accordingly. The igc driver does it like that as well.
>
> (Cc. Alexander Duyck)
>
> Do we have enough room for the packet page-split tricks when these 16
> bytes are added?
>
> AFAIK this driver like ixgbe+i40e split the page in two 2048 bytes packets.
>
>  The XDP headroom is reduced to 192 bytes.
>  The skb_shared_info is 320 bytes in size.
>
> 2048-192-320 = 1536 bytes
>
>  MTU(L3) 1500
>  Ethernet (L2) headers 14 bytes
>  VLAN 4 bytes, but Q-in-Q vlan 8 bytes.
>
> Single VLAN: 1536-1500-14-4 = 18 bytes left
> Q-in-q VLAN: 1536-1500-14-8 = 14 bytes left

So the Q-in-q case should kick us over to jumbo frames since we have
to add the extra size into the final supported frame size. So the size
itself should work.

> > diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> > index 86a576201f5f..0cbdf48285d3 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> > @@ -863,23 +863,22 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
> >   * igb_ptp_rx_pktstamp - retrieve Rx per packet timestamp
> >   * @q_vector: Pointer to interrupt specific structure
> >   * @va: Pointer to address containing Rx buffer
> > - * @skb: Buffer containing timestamp and packet
> >   *
> >   * This function is meant to retrieve a timestamp from the first buffer of an
> >   * incoming frame.  The value is stored in little endian format starting on
> >   * byte 8
> >   *
> > - * Returns: 0 if success, nonzero if failure
> > + * Returns: 0 on failure, timestamp on success
> >   **/
> > -int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
> > -                     struct sk_buff *skb)
> > +ktime_t igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va)
> >  {
> >       struct igb_adapter *adapter = q_vector->adapter;
> > +     struct skb_shared_hwtstamps ts;
> >       __le64 *regval = (__le64 *)va;
> >       int adjust = 0;
> >
> >       if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
> > -             return IGB_RET_PTP_DISABLED;
> > +             return 0;
> >
> >       /* The timestamp is recorded in little endian format.
> >        * DWORD: 0        1        2        3
> > @@ -888,10 +887,9 @@ int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
> >
> >       /* check reserved dwords are zero, be/le doesn't matter for zero */
> >       if (regval[0])
> > -             return IGB_RET_PTP_INVALID;
> > +             return 0;
> >

One thing that needs to be cleaned up in the patch is that if it is
going to drop these return values it should probably drop the defines
for them since I don't think they are used anywhere else.
