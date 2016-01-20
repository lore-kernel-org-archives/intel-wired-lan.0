From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 20 Jan 2016 14:13:35 -0800
Subject: [Intel-wired-lan] [next, S23,
 06/13] i40e/i40evf: tunnels can be generic
In-Reply-To: <569F04DF.7070102@gmail.com>
References: <1449705033-4968-7-git-send-email-joshua.a.hay@intel.com>
 <569F04DF.7070102@gmail.com>
Message-ID: <1453328015.2958.26.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-01-19 at 19:54 -0800, Alexander Duyck wrote:
> On 12/09/2015 03:50 PM, Hay, Joshua A wrote:
> > From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> >
> > Since the i40e driver now supports VxLAN, GRE, and soon
> > to be Geneve tunnels, the driver can just note that an skb
> > contains a tunneled packet generically, instead of calling
> > out VXLAN specifically.? The tunnel set up we do for hardware
> > is almost always the same for all tunnel types.
> >
> > This specifically enables ATR/Flow Director on GRE packets
> > which increases performance/scaling.? Without this patch
> > GRE RX packets end up on a random RSS assigned queue.
> >
> > Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Change-ID: Ie8e205603654910d2f718592cbef8132ae0719e4
> > Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
> > ---
> >?? drivers/net/ethernet/intel/i40e/i40e_txrx.c?? | 7 ++++---
> >?? drivers/net/ethernet/intel/i40e/i40e_txrx.h?? | 2 +-
> >?? drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 +-
> >?? drivers/net/ethernet/intel/i40evf/i40e_txrx.h | 2 +-
> >?? 4 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > index 28d2943..ba79f67 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > @@ -2005,7 +2005,7 @@ static void i40e_atr(struct i40e_ring
> *tx_ring, struct sk_buff *skb,
> >???????if (!(tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6)))
> >???????????????return;
> >
> > -?????if (!(tx_flags & I40E_TX_FLAGS_VXLAN_TUNNEL)) {
> > +?????if ((tx_flags & I40E_TX_FLAGS_TUNNEL)) {
> >???????????????/* snag network header to get L4 type and address */
> >???????????????hdr.network = skb_network_header(skb);
> >
> 
> So this patch has a major bug right here.? Specifically it is
> disabling?
> ATR for everything since the logic got flipped an you are checking
> the?
> outer headers for tunneled frames, and the inner headers for?
> non-tunneled frames.
> 
> There is another bug a bit further down from here where the variable?
> protocol is used which means it is outer header only and as such
> breaks?
> any cases where you have v4 over v6 or v6 over v4.

Thanks Alex for finding this, Jesse is working on a revised patch right
now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160120/f6e716a6/attachment.asc>
