From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 22:55:13 +0000
Subject: [Intel-wired-lan] [PATCH S38 02/15] ice: Refactor port vlan
 configuration for the VF
In-Reply-To: <20200122152138.41585-2-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-2-anthony.l.nguyen@intel.com>
Message-ID: <536509ab50604d9ea09df3afa575ba5c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S38 02/15] ice: Refactor port vlan
> configuration for the VF
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently ice_vsi_manage_pvid() calls
> ice_vsi_[set|kill]_pvid_fill_ctxt() when enabling/disabling a port VLAN on a
> VSI respectively. These two functions have some duplication so just move
> their unique pieces inline in ice_vsi_manage_pvid() and then the duplicate
> code can be reused for both the enabling/disabling paths.
> 
> Before this patch the info.pvid field was not being written correctly via
> ice_vsi_kill_pvid_fill_ctxt() so it was being hardcoded to 0 in
> ice_set_vf_port_vlan(). Fix this by setting the info.pvid field to 0 before
> calling ice_vsi_update() in ice_vsi_manage_pvid().
> 
> We currently use vf->port_vlan_id to keep track of the port VLAN ID and
> QoS, which is a bit misleading. Fix this by renaming it to
> vf->port_vlan_info. Also change the name of the argument for
> ice_vsi_manage_pvid() from vid to pvid_info.
> 
> In ice_vsi_manage_pvid() only save the fields that were modified in the VSI
> properties structure on success instead of the entire thing.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 86 ++++++++-----------
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  2 +-
>  2 files changed, 37 insertions(+), 51 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


