From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 31 Mar 2021 21:58:45 +0000
Subject: [Intel-wired-lan] [PATCH S57 14/14] ice: Remove unnecessary
 checks in add/kill_vid ndo ops
In-Reply-To: <20210325223517.17722-14-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-14-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105169B0A49056943BE3A99FA7C9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, March 25, 2021 3:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S57 14/14] ice: Remove unnecessary
> checks in add/kill_vid ndo ops
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the driver is doing two unnecessary checks. First both ops are
> checking if the VLAN ID passed in is less than VLAN_N_VID and second both
> ops are checking to see if a port VLAN is configured on the VSI.
> 
> The first check is already handled by the 8021q driver so this is an
> unnecessary check. The second check is unnecessary because the PF VSI is
> never put into a port VLAN.
> 
> Remove these checks.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 12 ------------
>  1 file changed, 12 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


