From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 21 Feb 2022 16:53:40 +0100
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Add restoration of VF
 MSI-X state during PCI reset
In-Reply-To: <20220221151329.27346-1-mateusz.palczewski@intel.com>
References: <20220221151329.27346-1-mateusz.palczewski@intel.com>
Message-ID: <770c2232-b19c-a831-1e37-69b9c1271493@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Slawomir, dear Mateusz,


Am 21.02.22 um 16:13 schrieb Mateusz Palczewski:
> From: Slawomir Laba <slawomirx.laba@intel.com>

Thank you for your patch. To shorten the commit message summary, maybe 
just use: i40e Restore VF MSI-X state during PCI reset

> During a PCI FLR the MSI-X Enable flag in the VF PCI MSI-X capability
> register will be cleared. This can lead to issues when a VF is
> assigned to a VM because in these cases the VF driver receives no
> indication of the PF PCI error/reset and additionally it is incapable
> of restoring the cleared flag in the hypervisor configuration space
> without fully reinitializing the driver interrupt functionality.

For the record, can you please document the exact test environment to 
reproduce the issue, and what error is seen.

> Since the VF driver is unable to easily resolve this condition on its own,
> restore the VF MSI-X flag during the PF PCI reset handling.
> 
> Fixes: 19b7960b2da1 ("i40e: implement split PCI error reset handler")
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>   v2: Fixed compilation error
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 ++
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 32 +++++++++++++++++++
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  1 +
>   3 files changed, 35 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 2f8ddfa..442b68a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -16151,6 +16151,8 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
>   		return;
>   
>   	i40e_reset_and_rebuild(pf, false, false);
> +
> +	i40e_restore_all_vfs_msi_state(pdev);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 2606e8f..5aaa669 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -152,6 +152,38 @@ void i40e_vc_notify_reset(struct i40e_pf *pf)
>   			     (u8 *)&pfe, sizeof(struct virtchnl_pf_event));
>   }
>   
> +/**
> + * i40e_restore_all_vfs_msi_state - restore VF MSI state after PF FLR
> + * @pdev: pointer to a pci_dev structure
> + *
> + * Called when recovering from a PF FLR to restore interrupt capability to
> + * the VFs.
> + */
> +void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev)
> +{
> +	struct pci_dev *vfdev;
> +	u16 vf_id;
> +	int pos;

Use u16 to match pci_find_ext_capability() signature?

> +
> +	/* Continue only if this is a PF */
> +	if (!pdev->is_physfn)
> +		return;
> +
> +	if (!pci_num_vf(pdev))
> +		return;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
> +	if (pos) {
> +		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_id);
> +		vfdev = pci_get_device(pdev->vendor, vf_id, NULL);
> +		while (vfdev) {
> +			if (vfdev->is_virtfn && vfdev->physfn == pdev)
> +				pci_restore_msi_state(vfdev);
> +			vfdev = pci_get_device(pdev->vendor, vf_id, vfdev);

Move that in the while condition (and initialize vfdev with NULL to 
follow the pattern in `Documentation/PCI/pci.rst`?

     struct pci_dev *dev = NULL;
     while (dev = pci_get_device(VENDOR_ID, DEVICE_ID, dev))
     	configure_device(dev);

> +		}
> +	}
> +}
> +
>   /**
>    * i40e_vc_notify_vf_reset
>    * @vf: pointer to the VF structure
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> index a554d0a..7c5f166 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> @@ -134,6 +134,7 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable);
>   
>   void i40e_vc_notify_link_state(struct i40e_pf *pf);
>   void i40e_vc_notify_reset(struct i40e_pf *pf);
> +void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev);
>   int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
>   		      struct ifla_vf_stats *vf_stats);
>   


Kind regards,

Paul
