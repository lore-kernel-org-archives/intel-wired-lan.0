From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 23:04:41 +0000
Subject: [Intel-wired-lan] [PATCH S38 04/15] ice: Fix Port VLAN priority
 bits
In-Reply-To: <20200122152138.41585-4-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-4-anthony.l.nguyen@intel.com>
Message-ID: <1a75ae083a4347fca9ea0c3f11862b2d@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S38 04/15] ice: Fix Port VLAN priority bits
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when configuring a port VLAN for a VF we are only shifting the QoS
> bits by 12. This is incorrect. Fix this by getting rid of the ICE specific VLAN
> defines and use the kernel VLAN defines instead.
> 
> Also, don't assign a value to vlanprio until the VLAN ID and QoS parameters
> have been validated.
> 
> Also, there are many places we do (le16_to_cpu(vsi->info.pvid) &
> VLAN_VID_MASK). Instead do (vf->port_vlan_info & VLAN_VID_MASK)
> because we always save what's stored in vsi->info.pvid to vf->port_vlan_info
> in the CPU's endianness.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 27 +++++++++----------
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  5 ----
>  2 files changed, 13 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


