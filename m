From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Sun, 19 Aug 2018 00:22:42 +0000
Subject: [Intel-wired-lan] [PATCH] ethernet: Use dma_zalloc_coherent to
 replace dma_alloc_coherent + memset
In-Reply-To: <1534603699-10120-1-git-send-email-zhongjiang@huawei.com>
References: <1534603699-10120-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <8E050A97-6745-4CC9-A3CD-B30DC7A34DEF@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Please send ALL patches against drivers I maintain to the Intel-wired-lan at lists.osuosl.org.  Your repeated refusal to do so, makes me think you are trying to circumvent the maintainer (me) and the correct kernel patch process.

Sent from my iPhone

> On Aug 18, 2018, at 08:00, zhong jiang <zhongjiang@huawei.com> wrote:
> 
> dma_zalloc_coherent has implemented the dma_alloc_coherent() + memset (),
> We prefer to dma_zalloc_coherent instead of open-codeing.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
> drivers/net/ethernet/intel/ixgb/ixgb_main.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_main.c b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
> index 43664ad..d3e72d0 100644
> --- a/drivers/net/ethernet/intel/ixgb/ixgb_main.c
> +++ b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
> @@ -771,14 +771,13 @@ static pci_ers_result_t ixgb_io_error_detected (struct pci_dev *pdev,
>    rxdr->size = rxdr->count * sizeof(struct ixgb_rx_desc);
>    rxdr->size = ALIGN(rxdr->size, 4096);
> 
> -    rxdr->desc = dma_alloc_coherent(&pdev->dev, rxdr->size, &rxdr->dma,
> -                    GFP_KERNEL);
> +    rxdr->desc = dma_zalloc_coherent(&pdev->dev, rxdr->size, &rxdr->dma,
> +                     GFP_KERNEL);
> 
>    if (!rxdr->desc) {
>        vfree(rxdr->buffer_info);
>        return -ENOMEM;
>    }
> -    memset(rxdr->desc, 0, rxdr->size);
> 
>    rxdr->next_to_clean = 0;
>    rxdr->next_to_use = 0;
> -- 
> 1.7.12.4
> 
