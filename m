From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 22:02:46 +0000
Subject: [Intel-wired-lan] [next S66 v2 11/11] i40e/i40evf: Use
 build_skb to	build frames
In-Reply-To: <20170405115103.67374-11-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
 <20170405115103.67374-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B1BD@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 5, 2017 4:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S66 v2 11/11] i40e/i40evf: Use build_skb to
> build frames
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch is meant to improve the performance of the Rx path.
> Specifically by using build_skb we have several distinct advantages.
> 
> In the case of small frames we were previously using a copy-break approach.
> This means that we were allocating a page fragment to use for skb->head,
> and were having to copy the packet into that region.  Both of those calls are
> now avoided since we just build the skb around the data.
> 
> In the case of large frames the gains are much more significant.
> Specifically we were having to allocate skb->head, and copy the headers as
> before.  However in addition we were having to parse the header using
> eth_get_headlen which could be quite expensive.  All of this is avoided by
> building the frame around the data.  I have seen gains as high as 30% when
> using VXLAN for instance due to just header pulling overhead.
> 
> Finally with all this in place it also sets us up to start looking at enabling XDP.
> Specifically we now have a path in which the data is in the page and the
> frame is built around it.  So if we parse it with XDP before we call build_skb
> we can take care of any necessary processing there.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Id4bdd618e94473d41f892417e5d8019639e421e3
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 47
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 47
> +++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
