From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:15:29 +0000
Subject: [Intel-wired-lan] [PATCH S35 02/15] ice: Fix VF spoofchk
In-Reply-To: <20191212111307.33566-2-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-2-anthony.l.nguyen@intel.com>
Message-ID: <21882071588b4cbbb08aa1b259c9eeba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 02/15] ice: Fix VF spoofchk
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> There are many things wrong with the function ice_set_vf_spoofchk().
> 
> 1. The VSI being modified is the PF VSI, not the VF VSI.
> 2. We are enabling Rx VLAN pruning instead of Tx VLAN anti-spoof.
> 3. The spoofchk setting for each VF is not initialized correctly
>    or re-initialized correctly on reset.
> 
> To fix [1] we need to make sure we are modifying the VF VSI.
> This is done by using the vf->lan_vsi_idx to index into the PF's VSI array.
> 
> To fix [2] replace setting Rx VLAN pruning in ice_set_vf_spoofchk() with
> setting Tx VLAN anti-spoof.
> 
> To Fix [3] we need to make sure the initial VSI settings match what is done in
> ice_set_vf_spoofchk() for spoofchk=on. Also make sure this also works for
> VF reset. This was done by modifying ice_vsi_init() to account for the current
> spoofchk state of the VF VSI.
> 
> Because of these changes, Tx VLAN anti-spoof needs to be removed from
> ice_cfg_vlan_pruning(). This is okay for the VF because this is now controlled
> from the admin enabling/disabling spoofchk. For the PF, Tx VLAN anti-spoof
> should not be set. This change requires us to call ice_set_vf_spoofchk()
> when configuring promiscuous mode for the VF which requires
> ice_set_vf_spoofchk() to move in order to prevent a forward declaration
> prototype.
> 
> Also, add VLAN 0 by default when allocating a VF since the PF is unaware if
> the guest OS is running the 8021q module. Without this, MDD events will
> trigger on untagged traffic because spoofcheck is enabled by default. Due to
> this change, ignore add/delete messages for VLAN 0 from VIRTCHNL since
> this is added/deleted during VF initialization/teardown respectively and
> should not be modified.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   1 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  34 +--
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 207 +++++++++++-------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   1 -
>  4 files changed, 146 insertions(+), 97 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


