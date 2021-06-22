From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 22 Jun 2021 09:50:21 +0300
Subject: [Intel-wired-lan] [PATCH] igc: Fix an error handling path in
 'igc_probe()'
In-Reply-To: <f24ae8234fedd1689fa0116038e10e4d3a033802.1623527947.git.christophe.jaillet@wanadoo.fr>
References: <f24ae8234fedd1689fa0116038e10e4d3a033802.1623527947.git.christophe.jaillet@wanadoo.fr>
Message-ID: <ae67bbc1-3bd9-c64c-b507-d2fd30da08e0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/12/2021 23:00, Christophe JAILLET wrote:
> If an error occurs after a 'pci_enable_pcie_error_reporting()' call, it
> must be undone by a corresponding 'pci_disable_pcie_error_reporting()'
> call, as already done in the remove function.
> 
> Fixes: c9a11c23ceb6 ("igc: Add netdev")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 3f6b6d4543a8..6389a41cacc1 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6057,6 +6057,7 @@ static int igc_probe(struct pci_dev *pdev,
>   err_ioremap:
>   	free_netdev(netdev);
>   err_alloc_etherdev:
> +	pci_disable_pcie_error_reporting(pdev);
>   	pci_release_mem_regions(pdev);
>   err_pci_reg:
>   err_dma:
> 
Thanks for this patch.
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
