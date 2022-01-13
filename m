From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 13 Jan 2022 17:53:38 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Remove useless DMA-32 fallback
 configuration
In-Reply-To: <abb2371cc7fabfa26d96abc1ff1b80ac038448b1.1641753678.git.christophe.jaillet@wanadoo.fr>
References: <abb2371cc7fabfa26d96abc1ff1b80ac038448b1.1641753678.git.christophe.jaillet@wanadoo.fr>
Message-ID: <BYAPR11MB33676ED44BB4F86B6FF4A366FC539@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Christophe JAILLET
> Sent: Monday, January 10, 2022 12:12 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>; intel-wired-
> lan at lists.osuosl.org; kernel-janitors at vger.kernel.org; linux-
> kernel at vger.kernel.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] igb: Remove useless DMA-32 fallback
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
> ---
> This patch was not part of the 1st serie I've sent. So there is no Reviewed-by
> tag.
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
