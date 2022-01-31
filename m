From: Maurice Baijens (Ellips B.V.) <maurice.baijens@ellips.com>
Date: Mon, 31 Jan 2022 16:46:18 +0000
Subject: [Intel-wired-lan] [External] ixgbe driver link down causes 100%
 load in ksoftirqd/x
In-Reply-To: <YffcB2YZ1h5SRyEP@boxer>
References: <VI1PR02MB4142A638EC38107B262DB32F885A9@VI1PR02MB4142.eurprd02.prod.outlook.com>
 <YfQMQWsFqCIPBBqO@boxer>
 <VI1PR02MB41424341E3E7BA3166E043BD88229@VI1PR02MB4142.eurprd02.prod.outlook.com>
 <YffcB2YZ1h5SRyEP@boxer>
Message-ID: <VI1PR02MB4142FB875F3C3D5714DB988188259@VI1PR02MB4142.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>




> -----Original Message-----
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Sent: Monday, January 31, 2022 1:55 PM
> To: Maurice Baijens (Ellips B.V.) <maurice.baijens@ellips.com>
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: Re: [External] ixgbe driver link down causes 100% load in ksoftirqd/x
> 
> On Fri, Jan 28, 2022 at 03:53:25PM +0000, Maurice Baijens (Ellips B.V.) wrote:
> > Hello,
> >
> >
> > > -----Original Message-----
> > > From: Maciej Fijalkowski <https://urldefense.proofpoint.com/v2/url?u=http-
> 3A__maciej.fijalkowski-
> 40intel.com&d=DwICAg&c=euGZstcaTDllvimEN8b7jXrwqOf-
> v5A_CdpgnVfiiMM&r=NxLR614ZckGV5qreAH7T-
> KBzf9aH_cn2IL_xVeWucP8&m=PDk-
> KhtpjXSlUONxhTse4JFtYC9S6TMfLfPVM4OnaAw&s=XqggXdJZq9zUpID-
> n7f0x7GlFkQ3g1pw5Tnj5-12K6U&e=>
> > > Sent: Friday, January 28, 2022 4:31 PM
> > > To: Maurice Baijens (Ellips B.V.)
> <https://urldefense.proofpoint.com/v2/url?u=http-3A__maurice.baijens-
> 40ellips.com&d=DwICAg&c=euGZstcaTDllvimEN8b7jXrwqOf-
> v5A_CdpgnVfiiMM&r=NxLR614ZckGV5qreAH7T-
> KBzf9aH_cn2IL_xVeWucP8&m=PDk-
> KhtpjXSlUONxhTse4JFtYC9S6TMfLfPVM4OnaAw&s=x60OZ4vNqH_9ek3VtAj2kivB
> bhhEHHk2LbxW5Kf4Ngs&e=>
> > > Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> > > Subject: Re: [External] ixgbe driver link down causes 100% load in ksoftirqd/x
> > >
> > > On Thu, Jan 20, 2022 at 09:23:06AM +0000, Maurice Baijens (Ellips B.V.)
> wrote:
> > > > Hello,
> > > >
> > > >
> > > > I have an issue with the ixgbe driver and X550Tx network adapter.
> > > > When I disconnect the network cable I end up with 100% load in
> ksoftirqd/x. I am running the adapter in
> > > > xdp mode (XDP_FLAGS_DRV_MODE). Problem seen in linux kernel 5.15.x
> and also 5.16.0+ (head).
> > >
> > > Hello,
> > >
> > > a stupid question - why do you disconnect the cable when running traffic? :)
> >
> > The answer is even more stupid. Due to supply problems we sometimes have
> to use
> > dual adapters instead of single once, and if one by accident enables the wrong
> port,
> > the bug is triggered.
> >
> > > If you plug this back in then what happens?
> >
> > Then everything works normal again.
> >
> > >
> > > >
> > > > I traced the problem down to function ixgbe_xmit_zc in ixgbe_xsk.c:
> > > >
> > > > if (unlikely(!ixgbe_desc_unused(xdp_ring)) ||
> > > >     !netif_carrier_ok(xdp_ring->netdev)) {
> > > >             work_done = false;
> > > >             break;
> > > > }
> > >
> > > This was done in commit c685c69fba71 ("ixgbe: don't do any AF_XDP
> > > zero-copy transmit if netif is not OK") - it was addressing the transient
> > > state when configuring the xsk pool on particular queue pair.
> > >
> > > >
> > > > This function is called from ixgbe_poll() function via
> ixgbe_clean_xdp_tx_irq(). It sets
> > > > work_done to false if netif_carrier_ok() returns false (so if link is down).
> Because work_done
> > > > is always false, ixgbe_poll keeps on polling forever.
> > > >
> > > > I made a fix by checking link in ixgbe_poll() function and if no link exiting
> polling mode:
> > > >
> > > > /* If all work not completed, return budget and keep polling */
> > > > if ((!clean_complete) && netif_carrier_ok(adapter->netdev))
> > > >             return budget;
> > >
> > > Not sure about the correctness of this. Question is how should we act for
> > > link down - should we say that we are done with processing or should we
> > > wait until the link gets back?
> > >
> > > Instead of setting the work_done to false immediately for
> > >!netif_carrier_ok(), I'd rather break out the checks that are currently
> > > combined into the single statement, something like this:
> > >
> > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > index b3fd8e5cd85b..6a5e9cf6b5da 100644
> > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > @@ -390,12 +390,14 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring
> *xdp_ring, unsigned int budget)
> > >  	u32 cmd_type;
> > >
> > >  	while (budget-- > 0) {
> > > -		if (unlikely(!ixgbe_desc_unused(xdp_ring)) ||
> > > -		    !netif_carrier_ok(xdp_ring->netdev)) {
> > > +		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
> > >  			work_done = false;
> > >  			break;
> > >  		}
> > >
> > > +		if (!netif_carrier_ok(xdp_ring->netdev))
> > > +			break;
> > > +
> > >  		if (!xsk_tx_peek_desc(pool, &desc))
> > >  			break;
> > >
> > >
> > > >
> > > > This is probably fine for our application as we only run in xdpdrv mode,
> however I am not sure this
> > >
> > > By xdpdrv I would understand that you're running XDP in standard native
> > > mode, however you refer to the AF_XDP Zero Copy implementation in the
> > > driver. But I don't think it changes anything in this thread.
> > >
> > > In the end I see some outstanding issues with ixgbe_xmit_zc(), so this
> > > probably might need some attention.
> > >
> > > Thanks!
> > > Maciej
> >
> > Your suggestion for a fix sounds ok. (I have not tested it). Is someone going to
> fix it in the next version of the kernel,
> > so we don't have to apply a patch here forever? Or how should we proceed to
> get it fixed in the kernel?
> 
> Could you test it then? If it's fine then I'll send it as a fix. I just
> don't currently have ixgbe HW around me.

Tested it and seems to work fine, so please send it as a fix.

Thanks,
	Maurice


P.S. I used following patch as you suggested:

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index b3fd8e5cd85b..6a5e9cf6b5da 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -390,12 +390,14 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	u32 cmd_type;
 
 	while (budget-- > 0) {
-		if (unlikely(!ixgbe_desc_unused(xdp_ring)) ||
-		    !netif_carrier_ok(xdp_ring->netdev)) {
+		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
 			work_done = false;
 			break;
 		}
 
+		if (!netif_carrier_ok(xdp_ring->netdev))
+			break;
+
 		if (!xsk_tx_peek_desc(pool, &desc))
 			break;


