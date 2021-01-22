From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 22 Jan 2021 18:34:53 +0000
Subject: [Intel-wired-lan] [PATCH net 2/2] ice: Fix MSI-X vector
 fallback logic
In-Reply-To: <20210121183806.23030-2-brett.creeley@intel.com>
References: <20210121183806.23030-1-brett.creeley@intel.com>
 <20210121183806.23030-2-brett.creeley@intel.com>
Message-ID: <CO1PR11MB5105059157EA22D0915D0379FAA09@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Brett Creeley
Sent: Thursday, January 21, 2021 10:38 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH net 2/2] ice: Fix MSI-X vector fallback logic

The current MSI-X enablement logic tries to enable best-case MSI-X vectors and if that fails we only support a bare-minimum set. This includes a single MSI-X for 1 Tx and 1 Rx queue and a single MSI-X for the OICR interrupt. Unfortunately, the driver fails to load when we don't get as many MSI-X as requested for a couple reasons.

First, the code to allocate MSI-X in the driver tries to allocate
num_online_cpus() MSI-X for LAN traffic without caring about the number of MSI-X actually enabled/requested from the kernel for LAN traffic.
So, when calling ice_get_res() for the PF VSI, it returns failure because the number of available vectors is less than requested. Fix this by not allowing the PF VSI to allocation  more than
pf->num_lan_msix MSI-X vectors and pf->num_lan_msix Rx/Tx queues.
Limiting the number of queues is done because we don't want more than
1 Tx/Rx queue per interrupt due to performance conerns.

Second, the driver assigns pf->num_lan_msix = 2, to account for LAN traffic and the OICR. However, pf->num_lan_msix is only meant for LAN MSI-X. This is causing a failure when the PF VSI tries to allocate/reserve the minimum pf->num_lan_msix because the OICR MSI-X has already been reserved, so there may not be enough MSI-X vectors left.
Fix this by setting pf->num_lan_msix = 1 for the failure case. Then the ICE_MIN_MSIX accounts for the LAN MSI-X and the OICR MSI-X needed for the failure case.

Update the related defines used in ice_ena_msix_range() to align with the above behavior and remove the unused RDMA defines because RDMA is currently not supported. Also, remove the now incorrect comment.

Fixes: 152b978a1f90 ("ice: Rework ice_ena_msix_range")
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  4 +++-
 drivers/net/ethernet/intel/ice/ice_lib.c  | 14 +++++++++-----  drivers/net/ethernet/intel/ice/ice_main.c |  8 ++------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 6efafe7d8a62..619d93f8b54c 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
