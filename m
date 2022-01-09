From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun, 9 Jan 2022 18:30:55 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: Remove useless DMA-32 fallback
 configuration
In-Reply-To: <5549ec8837b3a6fab83e92c5206cc100ffd23d85.1641748468.git.christophe.jaillet@wanadoo.fr>
References: <5549ec8837b3a6fab83e92c5206cc100ffd23d85.1641748468.git.christophe.jaillet@wanadoo.fr>
Message-ID: <29f3c7d1-f3ca-4a13-a9fb-7425e0941c37@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Le 09/01/2022 ? 18:14, Christophe JAILLET a ?crit?:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> So, if dma_set_mask_and_coherent() succeeds, 'pci_using_dac' is known to be
> 1.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)

NAK, wrong subject

CJ
