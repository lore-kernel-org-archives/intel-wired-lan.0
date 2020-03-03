From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:05:41 +0000
Subject: [Intel-wired-lan] [PATCH S40 05/15] ice: Fix removing driver
 while bare-metal VFs pass traffic
In-Reply-To: <20200227181505.61720-5-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-5-anthony.l.nguyen@intel.com>
Message-ID: <61f3b1bb1e64437188e201536d753122@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 05/15] ice: Fix removing driver while
> bare-metal VFs pass traffic
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently, if there are bare-metal VFs passing traffic and the ice driver is
> removed, there is a possibility of VFs triggering a Tx timeout right before
> iavf_remove(). This is causing iavf_close() to not be called because there is a
> check in the beginning of iavf_remove() that bails out early if (adapter->state
> < IAVF_DOWN_PENDING). This makes it so some resources do not get
> cleaned up. Specifically, free_irq() is never called for data interrupts, which
> results in the following line of code to trigger:
> 
> pci_disable_msix()
> 	free_msi_irqs()
> 		...
> 		BUG_ON(irq_has_action(entry->irq + i));
> 		...
> 
> To prevent the Tx timeout from occurring on the VF during driver unload for
> ice and the iavf there are a few changes that are needed.
> 
> [1] Don't disable all active VF Tx/Rx queues prior to calling pci_disable_sriov.
> 
> [2] Call ice_free_vfs() before disabling the service task.
> 
> [3] Disable VF resets when the ice driver is being unloaded by setting the pf-
> >state flag __ICE_VF_RESETS_DISABLED.
> 
> Changing [1] and [2] allow each VF driver's remove flow to successfully send
> VIRTCHNL requests, which includes queue disable. This prevents unexpected
> Tx timeouts because the PF driver is no longer forcefully disabling queues.
> 
> Due to [1] and [2] there is a possibility that the PF driver will get a VFLR or
> reset request over VIRTCHNL from a VF during PF driver unload.
> Prevent that by doing [3].
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 19 +++++++++++++++----
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 19 +++++++++++++------
>  3 files changed, 29 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


