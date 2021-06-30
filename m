From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 30 Jun 2021 15:43:48 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add restoration of
 VF MSI-X state during PCI reset
In-Reply-To: <20210524084748.68821-1-karen.sornek@intel.com>
References: <20210524084748.68821-1-karen.sornek@intel.com>
Message-ID: <991e25356e2ac012bda896bd1a36f900bb5a8aae.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-05-24 at 10:47 +0200, Karen Sornek wrote:

<snip>

> +/**
> + * i40e_restore_all_vfs_msi_state - restore VF MSI state after PF
> FLR
> + * @pdev: pointer to a pci_dev structure
> + *
> + * Called when recovering from a PF FLR to restore interrupt
> capability to
> + * the VFs.
> + */
> +void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev)
> +{
> +	struct pci_dev *vfdev;
> +	u16 vf_id;
> +	int pos;
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
> +		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID,
> &vf_id);
> +		vfdev = pci_get_device(pdev->vendor, vf_id, NULL);
> +		while (vfdev) {
> +			if (vfdev->is_virtfn && vfdev->physfn == pdev)
> +				pci_restore_msi_state(vfdev);
> +			vfdev = pci_get_device(pdev->vendor, vf_id,
> vfdev);
> +		}
> +	}

Can you address the issues reported by the kernel test robot[1][2]?

i40e/i40e_virtchnl_pf.c:180:35: error: 'struct pci_dev' has no member
named 'physfn'; did you mean 'is_physfn'? 

I'm going to drop this and wait for a version without this issue.

[1] https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-
20210607/024590.html
[2] https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-
20210628/024868.html
