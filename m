From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Apr 2019 18:14:49 +0000
Subject: [Intel-wired-lan] [PATCH S20 07/15] ice: Refactor interrupt
 tracking
In-Reply-To: <20190416173052.28928-8-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
 <20190416173052.28928-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AC98@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S20 07/15] ice: Refactor interrupt tracking
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we have two MSI-x (IRQ) trackers, one for OS requested MSI-x
> entries (sw_irq_tracker) and one for hardware MSI-x vectors
> (hw_irq_tracker). Generally the sw_irq_tracker has less entries than the
> hw_irq_tracker because the hw_irq_tracker has entries equal to the max
> allowed MSI-x per PF and the sw_irq_tracker is mainly the minimum (non SR-
> IOV portion of the vectors, kernel granted IRQs). All of the non SR-IOV
> portions of the driver (i.e. LAN queues, RDMA queues, OICR, etc.) take at
> least one of each type of tracker resource. SR-IOV only grabs entries from
> the hw_irq_tracker. There are a few issues with this approach that can be
> seen when doing any kind of device reconfiguration (i.e.
> ethtool -L, SR-IOV, etc.). One of them being, any time the driver creates an
> ice_q_vector and associates it to a LAN queue pair it will grab and use one
> entry from the hw_irq_tracker and one from the sw_irq_tracker.
> If the indices on these does not match it will cause a Tx timeout, which will
> cause a reset and then the indices will match up again and traffic will resume.
> The mismatched indices come from the trackers not being the same size
> and/or the search_hint in the two trackers not being equal.
> Another reason for the refactor is the co-existence of features with SR-IOV.
> If SR-IOV is enabled and the interrupts are taken from the end of the
> sw_irq_tracker then other features can no longer use this space because the
> hardware has now given the remaining interrupts to SR-IOV.
> 
> This patch reworks how we track MSI-x vectors by removing the
> hw_irq_tracker completely and instead MSI-x resources needed for SR-IOV
> are determined all at once instead of per VF. This can be done because when
> creating VFs we know how many are wanted and how many MSI-x vectors
> each VF needs. This also allows us to start using MSI-x resources from the
> end of the PF's allowed MSI-x vectors so we are less likely to use entries
> needed for other features (i.e. RDMA, L2 Offload, etc).
> 
> This patch also reworks the ice_res_tracker structure by removing the
> search_hint and adding a new member - "end". Instead of having a
> search_hint we will always search from 0. The new member, "end", will be
> used to manipulate the end of the ice_res_tracker (specifically
> sw_irq_tracker) during runtime based on MSI-x vectors needed by SR-IOV.
> In the normal case, the end of ice_res_tracker will be equal to the
> ice_res_tracker's num_entries.
> 
> The sriov_base_vector member was added to the PF structure. It is used to
> represent the starting MSI-x index of all the needed MSI-x vectors for all SR-
> IOV VFs. Depending on how many MSI-x are needed, SR-IOV may have to
> take resources from the sw_irq_tracker. This is done by setting the
> sw_irq_tracker->end equal to the pf->sriov_base_vector. When all SR-IOV
> VFs are removed then the sw_irq_tracker->end is reset back to
> sw_irq_tracker->num_entries. The sriov_base_vector, along with the VF's
> number of MSI-x (pf->num_vf_msix), vf_id, and the base MSI-x index on the
> PF (pf->hw.func_caps.common_cap.msix_vector_first_id), is used to
> calculate the first HW absolute MSI-x index for each VF, which is used to
> write to the VPINT_ALLOC[_PCI] and GLINT_VECT2FUNC registers to
> program the VFs MSI-x PCI configuration bits. Also, the sriov_base_vector is
> used along with VF's num_vf_msix, vf_id, and q_vector->v_idx to determine
> the MSI-x register index (used for writing to GLINT_DYN_CTL) within the PF's
> space.
> 
> Interrupt changes removed any references to hw_base_vector,
> hw_oicr_idx, and hw_irq_tracker. Only sw_base_vector, sw_oicr_idx, and
> sw_irq_tracker variables remain. Change all of these by removing the "sw_"
> prefix to help avoid confusion with these variables and their use.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  21 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   5 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 179 +++++------------
>  drivers/net/ethernet/intel/ice/ice_main.c     |  82 +++-----
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 186 ++++++++++++++++--
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   8 +
>  6 files changed, 263 insertions(+), 218 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


