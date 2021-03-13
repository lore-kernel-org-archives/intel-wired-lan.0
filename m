From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Sat, 13 Mar 2021 00:12:22 +0000
Subject: [Intel-wired-lan] [PATCH S56 09/13] ice: Add new VSI states to
 track netdev alloc/registration
In-Reply-To: <20210302181545.51822-9-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
 <20210302181545.51822-9-anthony.l.nguyen@intel.com>
Message-ID: <SA2PR11MB5114FD24C2F7DDD1ACB4B37BFA6E9@SA2PR11MB5114.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, March 2, 2021 10:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S56 09/13] ice: Add new VSI states to track
> netdev alloc/registration
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Add two new VSI states, one to track if a netdev for the VSI has been
> allocated and the other to track if the netdev has been registered.
> Call unregister_netdev/free_netdev only when the corresponding state bits
> are set.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  2 ++
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 21 +++++++++++++++------
> drivers/net/ethernet/intel/ice/ice_main.c |  5 +++++
>  3 files changed, 22 insertions(+), 6 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


