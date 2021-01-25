From: Alexander Lobakin <alobakin@pm.me>
Date: Mon, 25 Jan 2021 18:27:33 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/3] net: constify
 page_is_pfmemalloc() argument at call sites
In-Reply-To: <85978330-9753-f7a-f263-7a1cfd95b851@google.com>
References: <20210125164612.243838-1-alobakin@pm.me>
 <20210125164612.243838-3-alobakin@pm.me>
 <85978330-9753-f7a-f263-7a1cfd95b851@google.com>
Message-ID: <20210125182702.247232-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: David Rientjes <rientjes@google.com>
Date: Mon, 25 Jan 2021 10:19:48 -0800 (PST)

> On Mon, 25 Jan 2021, Alexander Lobakin wrote:
> 
> > Constify "page" argument for page_is_pfmemalloc() users where applicable.
> >
> > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > ---
> >  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   | 2 +-
> >  drivers/net/ethernet/intel/fm10k/fm10k_main.c     | 2 +-
> >  drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 2 +-
> >  drivers/net/ethernet/intel/iavf/iavf_txrx.c       | 2 +-
> >  drivers/net/ethernet/intel/ice/ice_txrx.c         | 2 +-
> >  drivers/net/ethernet/intel/igb/igb_main.c         | 2 +-
> >  drivers/net/ethernet/intel/igc/igc_main.c         | 2 +-
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 2 +-
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
> >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   | 2 +-
> >  include/linux/skbuff.h                            | 4 ++--
> >  11 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> > index 512080640cbc..0f8e962b5010 100644
> > --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> > @@ -2800,7 +2800,7 @@ static void hns3_nic_alloc_rx_buffers(struct hns3_enet_ring *ring,
> >  	writel(i, ring->tqp->io_base + HNS3_RING_RX_RING_HEAD_REG);
> >  }
> >
> > -static bool hns3_page_is_reusable(struct page *page)
> > +static bool hns3_page_is_reusable(const struct page *page)
> >  {
> >  	return page_to_nid(page) == numa_mem_id() &&
> >  		!page_is_pfmemalloc(page);
> 
> Hi Alexander,

Hi David!

> All of these functions appear to be doing the same thing, would it make
> sense to simply add this to a header file and remove all the code
> duplication as well?

That's an interesting idea. I'll be glad to do this if drivers'
maintainers agree it's okay for them.

Thanks,
Al

