From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Thu, 20 Jan 2022 08:03:52 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: Remove useless DMA-32 fallback
 configuration
In-Reply-To: <afb3317bc87677096e55fc96f317df29f2ff3408.1641752631.git.christophe.jaillet@wanadoo.fr>
References: <afb3317bc87677096e55fc96f317df29f2ff3408.1641752631.git.christophe.jaillet@wanadoo.fr>
Message-ID: <DM8PR11MB56216BAE634CBAB39F0F88E2AB5A9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: niedziela, 9 stycznia 2022 19:24
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>
> Cc: linux-kernel at vger.kernel.org; kernel-janitors at vger.kernel.org;
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>; Christoph Hellwig
> <hch@lst.de>; Lobakin, Alexandr <alexandr.lobakin@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [PATCH] iavf: Remove useless DMA-32 fallback configuration
> 
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 8125b9120615..b0bd95c85480 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
