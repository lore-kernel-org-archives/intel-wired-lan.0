From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 4 Sep 2020 09:54:41 +0200
Subject: [Intel-wired-lan] [PATCH v2 net-next 2/9] xdp: initialize
 xdp_buff mb bit to 0 in all XDP drivers
In-Reply-To: <20200904093542.4dc43682@carbon>
References: <cover.1599165031.git.lorenzo@kernel.org>
 <05822dfe200c5d581d6a6cad89c1b63bb7a1c566.1599165031.git.lorenzo@kernel.org>
 <20200904093542.4dc43682@carbon>
Message-ID: <20200904075441.GD2884@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Thu,  3 Sep 2020 22:58:46 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > index 0b675c34ce49..20c8fd3cd4a3 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > @@ -2298,6 +2298,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
> >  #if (PAGE_SIZE < 8192)
> >  	xdp.frame_sz = ixgbe_rx_frame_truesize(rx_ring, 0);
> >  #endif
> > +	xdp.mb = 0;
> >  
> >  	while (likely(total_rx_packets < budget)) {
> >  		union ixgbe_adv_rx_desc *rx_desc;
> 
> In this ixgbe driver you are smart and init the xdp.mb bit outside the
> (like xdp.frame_sz, when frame_sz is constant).   This is a nice
> optimization, but the driver developer that adds XDP multi-buffer
> support must remember to reset it.  The patch itself is okay, it is
> just something to keep in-mind when reviewing/changing drivers.

yes, I have just decided to avoid unnecessary instructions for the moment.

Regards,
Lorenzo

> 
> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200904/63778957/attachment-0001.asc>
