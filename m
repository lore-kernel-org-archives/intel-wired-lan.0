From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 10 Mar 2021 23:44:21 +0000
Subject: [Intel-wired-lan] [PATCH S55 04/14] ice: Delay netdev
 registration
In-Reply-To: <20210302181213.51718-4-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
 <20210302181213.51718-4-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105FE8E1D7FB8A90ACD0DEAFA919@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, March 2, 2021 10:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S55 04/14] ice: Delay netdev registration
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Once a netdev is registered, the corresponding network interface can be
> immediately used by userspace utilities (like say NetworkManager).
> This can be problematic if the driver technically isn't fully up yet.
> 
> Move netdev registration to the end of probe, as by this time the driver data
> structures and device will be initialized as expected.
> 
> However, delaying netdev registration causes a failure in the aRFS flow
> where netdev->reg_state == NETREG_REGISTERED condition is checked. It's
> not clear why this check was added to begin with, so remove it.
> Local testing didn't indicate any issues with this change.
> 
> The state bit check in ice_open was put in as a stop-gap measure to prevent
> a premature interface up operation. This is no longer needed, so remove it.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_arfs.c |  6 +-
> drivers/net/ethernet/intel/ice/ice_main.c | 93 +++++++++++------------
>  2 files changed, 47 insertions(+), 52 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


