From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 23:13:28 +0000
Subject: [Intel-wired-lan] [PATCH S38 05/15] ice: Only allow tagged
 bcast/mcast traffic for VF in port VLAN
In-Reply-To: <20200122152138.41585-5-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-5-anthony.l.nguyen@intel.com>
Message-ID: <0358cd1357e449649fd31002b76438d9@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S38 05/15] ice: Only allow tagged
> bcast/mcast traffic for VF in port VLAN
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the VF can see other's broadcast and multicast traffic because it
> always has a VLAN filter for VLAN 0. Fix this by removing/adding the VF's
> VLAN 0 filter when a port VLAN is added/removed respectively.
> 
> This required a few changes.
> 
> 1. Move where we add VLAN 0 by default for the VF into
> ice_alloc_vsi_res() because this is when we determine if a port VLAN is
> present for load and reset.
> 
> 2. Moved where we kill the old port VLAN filter in
> ice_set_vf_port_vlan() to the very end of the function because it allows us
> to save the old port VLAN configuration upon any failure case.
> 
> 3. During adding/removing of a port VLAN via ice_set_vf_port_vlan() we also
> need to remove/add the VLAN 0 filter rule respectively.
> 
> 4. Improve log messages.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 49 ++++++++++++-------
>  1 file changed, 31 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


