From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 13 Jan 2022 18:33:36 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Remove useless DMA-32 fallback
 configuration
In-Reply-To: <5549ec8837b3a6fab83e92c5206cc100ffd23d85.1641748468.git.christophe.jaillet@wanadoo.fr>
References: <5549ec8837b3a6fab83e92c5206cc100ffd23d85.1641748468.git.christophe.jaillet@wanadoo.fr>
Message-ID: <BYAPR11MB3367FFB4154822E9D881C8ACFC539@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Christophe JAILLET
> Sent: Sunday, January 9, 2022 10:45 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; linux-
> kernel at vger.kernel.org; Christophe JAILLET
> <christophe.jaillet@wanadoo.fr>; intel-wired-lan at lists.osuosl.org; Christoph
> Hellwig <hch@lst.de>
> Subject: [Intel-wired-lan] [PATCH] i40e: Remove useless DMA-32 fallback
> configuration
> 
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> So, if dma_set_mask_and_coherent() succeeds, 'pci_using_dac' is known to
> be 1.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
