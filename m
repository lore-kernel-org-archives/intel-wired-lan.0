From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 17 May 2021 23:25:40 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add restoration of
 VF MSI-X state during PCI reset
In-Reply-To: <20210517142818.288238-1-karen.sornek@intel.com>
References: <20210517142818.288238-1-karen.sornek@intel.com>
Message-ID: <f74cf9ffad279a30308eae3d2805d9f33479f745.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-05-17 at 16:28 +0200, Karen Sornek wrote:
> During a PCI FLR the MSI-X Enable flag in the VF PCI MSI-X capability
> register will be cleared. This can lead to issues when a VF is
> assigned to a VM because in these cases the VF driver receives no
> indication of the PF PCI error/reset and additionally it is incapable
> of restoring the cleared flag in the hypervisor configuration space
> without fully reinitializing the driver interrupt functionality.
> 
> Since the VF driver is unable to easily resolve this condition on its
> own,
> restore the VF MSI-X flag during the PF PCI reset handling.
> 
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---

<snip>
 
> +/**
> + * i40_restore_all_vfs_msi_state - restore VF MSI state after PF FLR
> + * @pdev: pointer to a pci_dev structure
> + *
> + * Called when recovering from a PF FLR to restore interrupt
> capability to
> + * the VFs.
> + */
> +void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev)

Header function name doesn't match:
./drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:163: warning:
expecting prototype for i40_restore_all_vfs_msi_state(). Prototype was
for i40e_restore_all_vfs_msi_state() instead

