From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Fri, 29 Oct 2021 20:57:10 +0000
Subject: [Intel-wired-lan] [PATCH S59 07/13] ice: Remove boolean
 vlan_promisc flag from function
In-Reply-To: <20210506154008.12880-7-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
 <20210506154008.12880-7-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB422485960A253AEE71E7F67B82879@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Thursday, May 6, 2021 8:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S59 07/13] ice: Remove boolean
> vlan_promisc flag from function
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently, the vlan_promisc flag is used exclusively by VF VSI to determine
> whether or not to toggle VLAN pruning along with trusted/true-promiscuous
> mode. This is not needed for a couple of reasons. First, trusted/true-
> promiscuous mode is only supposed to allow all MAC filters within VLANs
> that a VF has added filters for, so VLAN pruning should not be disabled.
> Second, the boolean argument makes the function confusing and
> unintuitive. Remove this flag.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c         |  7 ++-----
>  drivers/net/ethernet/intel/ice/ice_lib.h         |  2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c        | 12 ++++++------
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  9 ++++++---
>  4 files changed, 15 insertions(+), 15 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


