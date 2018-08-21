From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:14:09 +0000
Subject: [Intel-wired-lan] [PATCH v3 07/15] ice: Refactor VSI allocation,
 deletion and rebuild flow
In-Reply-To: <20180809132958.23036-8-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-8-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD261954594D@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 07/15] ice: Refactor VSI allocation,
> deletion and rebuild flow
> 
> This patch refactors aspects of the VSI allocation, deletion and rebuild flow.
> Some of the more noteworthy changes are described below.
> 
> 1) On reset, all switch filters applied in the hardware are lost. In
>    the rebuild flow, only MAC and broadcast filters are being restored.
>    Instead, use a new function ice_replay_all_fltr to restore all the
>    filters that were previously added. To do this, remove calls to
>    ice_remove_vsi_fltr to prevent cleaning out the internal bookkeeping
>    structures that ice_replay_all_fltr uses to replay filters.
> 
> 2) Introduce a new state bit __ICE_PREPARED_FOR_RESET to distinguish the
>    PF that requested the reset (and consequently prepared for it) from
>    the rest of the PFs. These other PFs will prepare for reset only
>    when they receive an interrupt from the firmware.
> 
> 3) Use new functions ice_add_vsi and ice_free_vsi to create and destroy
>    VSIs respectively. These functions accept a handle to uniquely
>    identify a VSI. This same handle is required to rebuild the VSI post
>    reset. To prevent confusion, the existing ice_vsi_add was renamed to
>    ice_vsi_init.
> 
> 4) Enhance ice_vsi_setup for the upcoming SR-IOV changes and expose a
>    new wrapper function ice_pf_vsi_setup to create PF VSIs. Rework the
>    error handling path in ice_setup_pf_sw.
> 
> 5) Introduce a new function ice_vsi_release_all to release all PF VSIs.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 371 +++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 353 +++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_switch.h   |  14 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   8 +-
>  7 files changed, 580 insertions(+), 171 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


