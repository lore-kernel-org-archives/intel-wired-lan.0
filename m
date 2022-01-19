From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 19 Jan 2022 12:54:40 +0000
Subject: [Intel-wired-lan] [PATCH] igbvf: Remove useless DMA-32 fallback
 configuration
In-Reply-To: <dc75b24883381a060eaad21cb0deffb5a027b05f.1641753812.git.christophe.jaillet@wanadoo.fr>
References: <dc75b24883381a060eaad21cb0deffb5a027b05f.1641753812.git.christophe.jaillet@wanadoo.fr>
Message-ID: <DM8PR11MB56214F1217ED05D3EDAF7968AB599@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Christophe JAILLET
> Sent: niedziela, 9 stycznia 2022 19:44
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>; intel-wired-
> lan at lists.osuosl.org; kernel-janitors at vger.kernel.org; linux-
> kernel at vger.kernel.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] igbvf: Remove useless DMA-32 fallback
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
>  drivers/net/ethernet/intel/igbvf/netdev.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c
> b/drivers/net/ethernet/intel/igbvf/netdev.c
> index b78407289741..43ced78c3a2e 100644
> --- a/drivers/net/ethernet/intel/igbvf/netdev.c
> +++ b/drivers/net/ethernet/intel/igbvf/netdev.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
