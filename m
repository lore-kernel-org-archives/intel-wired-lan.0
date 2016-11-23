From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Wed, 23 Nov 2016 15:54:58 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: restore hw_addr on resume
	or	error
In-Reply-To: <20161122233059.31775.78519.stgit@localhost6.localdomain6>
References: <20161122233059.31775.78519.stgit@localhost6.localdomain6>
Message-ID: <B1C1DF2ACD01FD4881736AA51731BAB2A48A3F@ORSMSX107.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Tuesday, November 22, 2016 3:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: restore hw_addr on resume or error
> 
> Restore adapter->hw.hw_addr after handling an error, or a resume operation to
> make sure we can access the registers.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 88c5352..d94ab8c 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -3840,6 +3840,7 @@ static int ixgbevf_resume(struct pci_dev *pdev)
>  	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
>  	u32 err;
> 
> +	adapter->hw.hw_addr = adapter->io_addr;
>  	pci_restore_state(pdev);
>  	/* pci_restore_state clears dev->state_saved so call
>  	 * pci_save_state to restore it.
> @@ -4283,6 +4284,7 @@ static pci_ers_result_t ixgbevf_io_slot_reset(struct
> pci_dev *pdev)
>  	struct net_device *netdev = pci_get_drvdata(pdev);
>  	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
> 
> +	adapter->hw.hw_addr = adapter->io_addr;
>  	if (pci_enable_device_mem(pdev)) {
>  		dev_err(&pdev->dev,
>  			"Cannot re-enable PCI device after reset.\n");
> 

It might be better if you reset this after completing the call to pci_enable_device_mem instead of before.  That way you don't re-enable the device when it isn't actually working.

- Alex
