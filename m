From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 24 Oct 2018 12:55:14 +0300
Subject: [Intel-wired-lan] [PATCH net-next] igc: Remove set but not used
 variable 'pci_using_dac'
In-Reply-To: <1539953291-189201-1-git-send-email-yuehaibing@huawei.com>
References: <1539953291-189201-1-git-send-email-yuehaibing@huawei.com>
Message-ID: <3fd978fe-73c7-503b-c6f6-8e1096199aba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/19/2018 15:48, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/intel/igc/igc_main.c: In function 'igc_probe':
> drivers/net/ethernet/intel/igc/igc_main.c:3535:11: warning:
>   variable 'pci_using_dac' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in commit
> d89f88419f99 ("igc: Add skeletal frame for Intel(R) 2.5G Ethernet Controller support")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 9d85707..06a4afbe 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -3532,19 +3532,16 @@ static int igc_probe(struct pci_dev *pdev,
>   	struct net_device *netdev;
>   	struct igc_hw *hw;
>   	const struct igc_info *ei = igc_info_tbl[ent->driver_data];
> -	int err, pci_using_dac;
> +	int err;
>   
>   	err = pci_enable_device_mem(pdev);
>   	if (err)
>   		return err;
>   
> -	pci_using_dac = 0;
>   	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
>   	if (!err) {
>   		err = dma_set_coherent_mask(&pdev->dev,
>   					    DMA_BIT_MASK(64));
> -		if (!err)
> -			pci_using_dac = 1;
>   	} else {
>   		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
>   		if (err) {
> 
Thanks for the patch. Good.

Acked-by: Sasha Neftin <sasha.neftin@intel.com>

