From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 14 Feb 2019 23:58:48 +0000
Subject: [Intel-wired-lan] [PATCH S11 07/16] ice: fix issue where host
 reboots on unload when iommu=on
In-Reply-To: <20190208205043.11975-8-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366262@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 07/16] ice: fix issue where host reboots
> on unload when iommu=on
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently if the kernel has the intel_iommu=on parameter set, on some
> platforms removing the driver causes a system reboot. In initialization we
> associate the control queue interrupts with the pf->hw_oicr_idx and enable
> the interrupts by setting the CAUSE_ENA bit. The problem comes on
> teardown because we are not clearing the CAUSE_ENA bit for the control
> queues, but the vector at pf->hw_oicr_idx (miscellaneous interrupt vector)
> gets disabled.
> 
> Fix this by clearing the CAUSE_ENA bit in the appropriate control queue
> registers on when freeing the misceallaneous interrupt vector. Also, move
> the call to ice_free_irq_msix_misc() to after ice_deinit_sw() in
> ice_remove() because ice_deinit_sw() makes an AQ call, but
> ice_free_irq_msix_misc() disables the miscellaneous vector and it's
> associated interrupts.
> 
> Also, create two small helper functions to enable and disable the control
> queue interrupts respectively.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 71
> +++++++++++++++++++++++--------
>  1 file changed, 54 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


