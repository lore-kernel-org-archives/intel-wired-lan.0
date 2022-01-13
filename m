From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 13 Jan 2022 17:52:49 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Remove useless DMA-32 fallback
 configuration
In-Reply-To: <6a4df3e0a0849f179f9747f47b9c8cae53b29b59.1641752692.git.christophe.jaillet@wanadoo.fr>
References: <6a4df3e0a0849f179f9747f47b9c8cae53b29b59.1641752692.git.christophe.jaillet@wanadoo.fr>
Message-ID: <BYAPR11MB3367988A2E1F57783A98B083FC539@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Christophe JAILLET
> Sent: Sunday, January 9, 2022 11:55 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; linux-
> kernel at vger.kernel.org; Christophe JAILLET
> <christophe.jaillet@wanadoo.fr>; intel-wired-lan at lists.osuosl.org; Christoph
> Hellwig <hch@lst.de>
> Subject: [Intel-wired-lan] [PATCH] ice: Remove useless DMA-32 fallback
> configuration
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
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
