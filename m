From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:32:00 +0000
Subject: [Intel-wired-lan] [PATCH S33 04/15] ice: Don't modify stripping
 for add/del VLANs on VF
In-Reply-To: <20191108142331.10221-4-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-4-anthony.l.nguyen@intel.com>
Message-ID: <fee1b3338e5d4628bd2896eff82d2d4c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, November 8, 2019 6:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S33 04/15] ice: Don't modify stripping for
> add/del VLANs on VF
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when adding/deleting vlans in ice_vc_process_vlan_msg() we are
> calling ice_vsi_manage_vlan_stripping() to enable/disable when adding and
> deleting a VLAN respectively. This is wrong because adding/deleting VLANs
> has nothing to do with configuring VLAN stripping. VLAN stripping is
> configured through the following VIRTCHNL operations:
> 	VIRTCHNL_OP_ENABLE_VLAN_STRIPPING
> 	VIRTCHNL_OP_DISABLE_VLAN_STRIPPING
> 
> Unfortunately we can't just remove this because then stripping will never be
> configured on VF initialization. Fix this by adding a new function that initializes
> (disables/enables) VLAN stripping for the VF based on the device supported
> capabilities.
> This allows us to remove the call to
> ice_vsi_manage_vlan_stripping() in ice_vc_process_vlan_msg().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 39 +++++++++++++++----
>  1 file changed, 31 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


