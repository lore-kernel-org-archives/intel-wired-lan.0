From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Tue, 14 Apr 2020 12:16:33 +0200
Subject: [Intel-wired-lan] [PATCH RFC v2 26/33] i40e: add XDP frame size
 to driver
In-Reply-To: <20200408.144845.783523592365109446.davem@davemloft.net>
References: <158634658714.707275.7903484085370879864.stgit@firesoul>
 <158634676645.707275.7536684877295305696.stgit@firesoul>
 <20200408.144845.783523592365109446.davem@davemloft.net>
Message-ID: <20200414121633.0461ece4@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 08 Apr 2020 14:48:45 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Jesper Dangaard Brouer <brouer@redhat.com>
> Date: Wed, 08 Apr 2020 13:52:46 +0200
> 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > index b8496037ef7f..1fb6b1004dcb 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > @@ -1507,6 +1507,23 @@ static inline unsigned int i40e_rx_offset(struct i40e_ring *rx_ring)
> >  	return ring_uses_build_skb(rx_ring) ? I40E_SKB_PAD : 0;
> >  }
> >  
> > +static inline unsigned int i40e_rx_frame_truesize(struct i40e_ring *rx_ring,
> > +						  unsigned int size)  
> 
> Please don't use inline in foo.c files.  I noticed you properly elided this in
> the ice changes so I wonder why it showed up here :-)

Yes, I know I should not do this.  It got here by copy-paste accident,
as I first had ixgbe function in a header file, and later I decided to
move this into the ixgbe C-file, but I had already copy-pasted this
into i40e driver ;-)

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

