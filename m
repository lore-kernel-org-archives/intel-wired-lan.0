From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 14 Dec 2020 16:07:40 +0100
Subject: [Intel-wired-lan] [PATCH net-next 5/8] ice: move skb pointer
 from rx_buf to rx_ring
In-Reply-To: <20201211202315.570b6605@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201211164956.59628-1-maciej.fijalkowski@intel.com>
 <20201211164956.59628-6-maciej.fijalkowski@intel.com>
 <20201211202315.570b6605@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <20201214150740.GA15222@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Dec 11, 2020 at 08:23:15PM -0800, Jakub Kicinski wrote:
> On Fri, 11 Dec 2020 17:49:53 +0100 Maciej Fijalkowski wrote:
> > @@ -864,14 +865,12 @@ ice_reuse_rx_page(struct ice_ring *rx_ring, struct ice_rx_buf *old_buf)
> >   * for use by the CPU.
> >   */
> >  static struct ice_rx_buf *
> > -ice_get_rx_buf(struct ice_ring *rx_ring, struct sk_buff **skb,
> > -	       const unsigned int size)
> > +ice_get_rx_buf(struct ice_ring *rx_ring, const unsigned int size)
> >  {
> 
> FWIW I think you missed adjusting kdoc here.

How ironic :) sorry for that.
