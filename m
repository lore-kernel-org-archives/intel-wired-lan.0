From: Mukesh Ojha <mojha@codeaurora.org>
Date: Wed, 27 Mar 2019 13:52:11 +0530
Subject: [Intel-wired-lan] [PATCH v2] e1000: remove extern declarations
 in .c file.
In-Reply-To: <20190326213917.GA24133@jiffies>
References: <20190326213917.GA24133@jiffies>
Message-ID: <e4df3bea-3015-0307-7d64-60c7cdcd2601@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 3/27/2019 3:09 AM, Quentin Deslandes wrote:
> This patch fixes the following checkpatch.pl warning:
>
> WARNING: externs should be avoided in .c files
>
> Some of the driver's function declared in e1000.h were declared a second
> time in e1000_main.c, triggering checkpatch.pl warnings.
>
> This patch is v2 as the first one had the wrong subject.

commit text should not have patch version detail this line should be 
after `---`.

Refer Documentation/process/submitting-patches.rst

Take mine Review tag after removing above line in the commit text.

Reviewed-by: Mukesh Ojha <mojha at codeaurora.org 
<mailto:mojha@codeaurora.org>>

Thanks.
Mukesh


>
> Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> ---
>   drivers/net/ethernet/intel/e1000/e1000_main.c | 11 -----------
>   1 file changed, 11 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index 8fe9af0e2ab7..b3d5cd750dca 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -65,14 +65,6 @@ static const struct pci_device_id e1000_pci_tbl[] = {
>   
>   MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
>   
> -int e1000_up(struct e1000_adapter *adapter);
> -void e1000_down(struct e1000_adapter *adapter);
> -void e1000_reinit_locked(struct e1000_adapter *adapter);
> -void e1000_reset(struct e1000_adapter *adapter);
> -int e1000_setup_all_tx_resources(struct e1000_adapter *adapter);
> -int e1000_setup_all_rx_resources(struct e1000_adapter *adapter);
> -void e1000_free_all_tx_resources(struct e1000_adapter *adapter);
> -void e1000_free_all_rx_resources(struct e1000_adapter *adapter);
>   static int e1000_setup_tx_resources(struct e1000_adapter *adapter,
>   				    struct e1000_tx_ring *txdr);
>   static int e1000_setup_rx_resources(struct e1000_adapter *adapter,
> @@ -81,7 +73,6 @@ static void e1000_free_tx_resources(struct e1000_adapter *adapter,
>   				    struct e1000_tx_ring *tx_ring);
>   static void e1000_free_rx_resources(struct e1000_adapter *adapter,
>   				    struct e1000_rx_ring *rx_ring);
> -void e1000_update_stats(struct e1000_adapter *adapter);
>   
>   static int e1000_init_module(void);
>   static void e1000_exit_module(void);
> @@ -89,8 +80,6 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
>   static void e1000_remove(struct pci_dev *pdev);
>   static int e1000_alloc_queues(struct e1000_adapter *adapter);
>   static int e1000_sw_init(struct e1000_adapter *adapter);
> -int e1000_open(struct net_device *netdev);
> -int e1000_close(struct net_device *netdev);
>   static void e1000_configure_tx(struct e1000_adapter *adapter);
>   static void e1000_configure_rx(struct e1000_adapter *adapter);
>   static void e1000_setup_rctl(struct e1000_adapter *adapter);
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190327/47537fe5/attachment.html>
