From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 14 Jan 2022 04:08:02 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Remove useless DMA-32 fallback
 configuration
In-Reply-To: <869bbf806431086683c64ad32594ff96e85b6aa2.1641749374.git.christophe.jaillet@wanadoo.fr>
References: <869bbf806431086683c64ad32594ff96e85b6aa2.1641749374.git.christophe.jaillet@wanadoo.fr>
Message-ID: <BYAPR11MB3367C34AB2311D81468B457DFC549@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Sunday, January 9, 2022 11:00 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>
> Cc: linux-kernel at vger.kernel.org; kernel-janitors at vger.kernel.org;
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>; Christoph Hellwig
> <hch@lst.de>; Lobakin, Alexandr <alexandr.lobakin@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [PATCH] i40e: Remove useless DMA-32 fallback configuration
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
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
