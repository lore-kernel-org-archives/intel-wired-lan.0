From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Wed, 23 Nov 2016 19:19:38 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbevf: restore hw_addr on resume
 or	error
In-Reply-To: <20161123181131.11570.85615.stgit@localhost6.localdomain6>
References: <20161123181131.11570.85615.stgit@localhost6.localdomain6>
Message-ID: <B1C1DF2ACD01FD4881736AA51731BAB2A48F5B@ORSMSX107.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, November 23, 2016 10:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ixgbevf: restore hw_addr on resume or
> error
> 
> Restore adapter->hw.hw_addr after handling an error, or a resume operation to
> make sure we can access the registers.
> 
> v2 - restore hw_addr pnly if pci_enable_device_mem() succeeds in
> ixgbevf_io_slot_reset()
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 88c5352..1093b41 100644
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

So this piece needs the same change that we made below. You need to reset hw_addr after pci_enable_device_mem() and before we call smp_mb__before_atomic()

> @@ -4289,6 +4290,7 @@ static pci_ers_result_t ixgbevf_io_slot_reset(struct
> pci_dev *pdev)
>  		return PCI_ERS_RESULT_DISCONNECT;
>  	}
> 
> +	adapter->hw.hw_addr = adapter->io_addr;
>  	smp_mb__before_atomic();
>  	clear_bit(__IXGBEVF_DISABLED, &adapter->state);
>  	pci_set_master(pdev);
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
