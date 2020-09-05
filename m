From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 5 Sep 2020 03:13:23 +0000
Subject: [Intel-wired-lan] [net 5/6] ice: fix memory leak if
 register_netdev_fails
In-Reply-To: <20200902155347.16972-5-anthony.l.nguyen@intel.com>
References: <20200902155347.16972-1-anthony.l.nguyen@intel.com>
 <20200902155347.16972-5-anthony.l.nguyen@intel.com>
Message-ID: <DM6PR11MB2890A421017DDAB67C7C4F99BC2A0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, September 2, 2020 8:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net 5/6] ice: fix memory leak if
> register_netdev_fails
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_setup_pf_sw function can cause a memory leak if register_netdev
> fails, due to accidentally failing to free the VSI rings. Fix the memory
> leak by using ice_vsi_release, ensuring we actually go through the full
> teardown process.
> 
> This should be safe even if the netdevice is not registered because we
> will have set the netdev pointer to NULL, ensuring ice_vsi_release won't
> call unregister_netdev.
> 
> An alternative fix would be moving management of the PF VSI netdev into
> the main VSI setup code. This is complicated and likely requires
> significant refactor in how we manage VSIs
> 
> Fixes: 3a858ba392c3 ("ice: Add support for VSI allocation and deallocation")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  |  6 +++---
>  drivers/net/ethernet/intel/ice/ice_lib.h  |  6 ------
>  drivers/net/ethernet/intel/ice/ice_main.c | 13 +++----------
>  3 files changed, 6 insertions(+), 19 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
