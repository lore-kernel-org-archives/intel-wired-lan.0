From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 14 Aug 2019 16:59:49 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next v4 3/8] i40e: add support for
 AF_XDP need_wakeup feature
In-Reply-To: <3B2C7C21-4AAC-4126-A31D-58A61D941709@gmail.com>
References: <1565767643-4908-1-git-send-email-magnus.karlsson@intel.com>
 <1565767643-4908-4-git-send-email-magnus.karlsson@intel.com>
 <3B2C7C21-4AAC-4126-A31D-58A61D941709@gmail.com>
Message-ID: <CAJ8uoz0Tnb=i-LkGqLU87be9BuYqxmu2pN1Mte0UEWA2+f8bTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Aug 14, 2019 at 4:48 PM Jonathan Lemon <jonathan.lemon@gmail.com> wrote:
>
>
>
> On 14 Aug 2019, at 0:27, Magnus Karlsson wrote:
>
> > This patch adds support for the need_wakeup feature of AF_XDP. If the
> > application has told the kernel that it might sleep using the new bind
> > flag XDP_USE_NEED_WAKEUP, the driver will then set this flag if it has
> > no more buffers on the NIC Rx ring and yield to the application. For
> > Tx, it will set the flag if it has no outstanding Tx completion
> > interrupts and return to the application.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index d0ff5d8..42c9012 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -626,6 +626,15 @@ int i40e_clean_rx_irq_zc(struct i40e_ring
> > *rx_ring, int budget)
> >
> >       i40e_finalize_xdp_rx(rx_ring, xdp_xmit);
> >       i40e_update_rx_stats(rx_ring, total_rx_bytes, total_rx_packets);
> > +
> > +     if (xsk_umem_uses_need_wakeup(rx_ring->xsk_umem)) {
> > +             if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
> > +                     xsk_set_rx_need_wakeup(rx_ring->xsk_umem);
> > +             else
> > +                     xsk_clear_rx_need_wakeup(rx_ring->xsk_umem);
> > +
> > +             return (int)total_rx_packets;
> > +     }
> >       return failure ? budget : (int)total_rx_packets;
>
> Can you elaborate why we're not returning the total budget on failure
> for the wakeup case?

In the non need_wakeup case (the old behavior), when allocation fails
from the fill queue we want to retry right away basically busy
spinning on the fill queue until we find at least one entry and then
go on processing packets. Works well when the app and the driver are
on different cores, but a lousy strategy when they execute on the same
core. That is why in the need_wakeup feature case, we do not return
the total budget if there is a failure. We will just come back at a
later point in time from a syscall since the need_wakeup flag will
have been set and check the fill queue again. We do not want a
busy-spinning behavior in this case.

Thanks: Magnus
