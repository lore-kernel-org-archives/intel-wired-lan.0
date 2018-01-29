From: Benjamin Poirier <bpoirier@suse.com>
Date: Mon, 29 Jan 2018 16:20:36 +0900
Subject: [Intel-wired-lan] [PATCH 1/3] Partial revert "e1000e: Avoid
 receiver overrun interrupt bursts"
In-Reply-To: <CAKgT0Uf0w65SgPJoEJ8KchBTF8z7gyVbLWRo34gpib-ayDaGtQ@mail.gmail.com>
References: <20180126091236.13044-1-bpoirier@suse.com>
 <20180126091236.13044-2-bpoirier@suse.com>
 <CAKgT0Uf0w65SgPJoEJ8KchBTF8z7gyVbLWRo34gpib-ayDaGtQ@mail.gmail.com>
Message-ID: <20180129072036.jninnfmjzcxnpput@f1.synalogic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/01/26 08:50, Alexander Duyck wrote:
> On Fri, Jan 26, 2018 at 1:12 AM, Benjamin Poirier <bpoirier@suse.com> wrote:
> > This reverts commit 4aea7a5c5e940c1723add439f4088844cd26196d.
> >
> > We keep the fix for the first part of the problem (1) described in the log
> > of that commit however we use the implementation of e1000_msix_other() from
> > before commit 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt").
> > We remove the fix for the second part of the problem (2).
> >
> > Bursts of "Other" interrupts may once again occur during rxo (receive
> > overflow) traffic conditions. This is deemed acceptable in the interest of
> > reverting driver code back to its previous state. The e1000e driver should
> > be in "maintenance" mode and we want to avoid unforeseen fallout from
> > changes that are not strictly necessary.
> >
> > Link: https://www.spinics.net/lists/netdev/msg480675.html
> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> 
> Thanks for doing this.
> 
> Only a few minor tweaks I would recommend. Otherwise it looks good.
> 
> > ---
> >  drivers/net/ethernet/intel/e1000e/defines.h |  1 -
> >  drivers/net/ethernet/intel/e1000e/netdev.c  | 32 +++++++++++------------------
> >  2 files changed, 12 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
> > index afb7ebe20b24..0641c0098738 100644
> > --- a/drivers/net/ethernet/intel/e1000e/defines.h
> > +++ b/drivers/net/ethernet/intel/e1000e/defines.h
> > @@ -398,7 +398,6 @@
> >  #define E1000_ICR_LSC           0x00000004 /* Link Status Change */
> >  #define E1000_ICR_RXSEQ         0x00000008 /* Rx sequence error */
> >  #define E1000_ICR_RXDMT0        0x00000010 /* Rx desc min. threshold (0) */
> > -#define E1000_ICR_RXO           0x00000040 /* Receiver Overrun */
> >  #define E1000_ICR_RXT0          0x00000080 /* Rx timer intr (ring 0) */
> >  #define E1000_ICR_ECCER         0x00400000 /* Uncorrectable ECC Error */
> >  /* If this bit asserted, the driver should claim the interrupt */
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> > index 9f18d39bdc8f..398e940436f8 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -1914,30 +1914,23 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
> >         struct net_device *netdev = data;
> >         struct e1000_adapter *adapter = netdev_priv(netdev);
> >         struct e1000_hw *hw = &adapter->hw;
> > -       u32 icr;
> > -       bool enable = true;
> > -
> > -       icr = er32(ICR);
> > -       if (icr & E1000_ICR_RXO) {
> > -               ew32(ICR, E1000_ICR_RXO);
> > -               enable = false;
> > -               /* napi poll will re-enable Other, make sure it runs */
> > -               if (napi_schedule_prep(&adapter->napi)) {
> > -                       adapter->total_rx_bytes = 0;
> > -                       adapter->total_rx_packets = 0;
> > -                       __napi_schedule(&adapter->napi);
> > -               }
> > -       }
> > -       if (icr & E1000_ICR_LSC) {
> > -               ew32(ICR, E1000_ICR_LSC);
> > +       u32 icr = er32(ICR);
> > +
> > +       if (icr & adapter->eiac_mask)
> > +               ew32(ICS, (icr & adapter->eiac_mask));
> 
> I'm not sure about this bit as it includes queue interrupts if I am
> not mistaken. What we should be focusing on are the bits that are not
> auto-cleared so this should probably be icr & ~adapter->eiac_mask.
> Actually what you might do is something like:
>     icr &= ~adapter->eiac_mask;
>     if (icr)
>         ew32(ICS, icr);
> 
> Also a comment explaining that we have to clear the bits that are not
> automatically cleared by other interrupt causes might be useful.

I've re-read your comment many times and I think you misunderstood what
that code is doing.

This:
> > +       if (icr & adapter->eiac_mask)
> > +               ew32(ICS, (icr & adapter->eiac_mask));

re-raises the queue interrupts in case the txq or rxq bits were set in
icr and the Other interrupt handler read and cleared icr before the
queue interrupt was raised. It's not about "clear the bits that are not
automatically cleared". It's a write to ICS, not ICR.

> 
> > +       if (icr & E1000_ICR_OTHER) {
> > +               if (!(icr & E1000_ICR_LSC))
> > +                       goto no_link_interrupt;
> 
> I wouldn't bother with the jump tag. Let's just make this one if
> statement checking both OTHER && LSC.
> 
> >                 hw->mac.get_link_status = true;
> >                 /* guard against interrupt when we're going down */
> >                 if (!test_bit(__E1000_DOWN, &adapter->state))
> >                         mod_timer(&adapter->watchdog_timer, jiffies + 1);
> >         }
> >
> > -       if (enable && !test_bit(__E1000_DOWN, &adapter->state))
> > -               ew32(IMS, E1000_IMS_OTHER);
> > +no_link_interrupt:
> 
> If you just combine the if statement logic the code naturally flows to
> this point anyway without the jump label being needed.

After this patch, the implementation of e1000_msix_other() is what it
was before commit 16ecba59bc33 ("e1000e: Do not read ICR in Other
interrupt"), verbatim.

I agree with your comment though and the binary code is the same.
Changed for the next version.

> 
> > +       if (!test_bit(__E1000_DOWN, &adapter->state))
> > +               ew32(IMS, E1000_IMS_LSC | E1000_IMS_OTHER);
> >
> >         return IRQ_HANDLED;
> >  }
> > @@ -2707,8 +2700,7 @@ static int e1000e_poll(struct napi_struct *napi, int weight)
> >                 napi_complete_done(napi, work_done);
> >                 if (!test_bit(__E1000_DOWN, &adapter->state)) {
> >                         if (adapter->msix_entries)
> > -                               ew32(IMS, adapter->rx_ring->ims_val |
> > -                                    E1000_IMS_OTHER);
> > +                               ew32(IMS, adapter->rx_ring->ims_val);
> >                         else
> >                                 e1000_irq_enable(adapter);
> >                 }
> > --
> > 2.15.1
> >
> 
