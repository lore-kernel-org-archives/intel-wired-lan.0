From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 3 Mar 2022 17:02:26 +0000
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix error with handling
 of bonding MTU
In-Reply-To: <20220218203925.1890573-1-david.m.ertman@intel.com>
References: <20220218203925.1890573-1-david.m.ertman@intel.com>
Message-ID: <BYAPR11MB3367FCD501B3B6E891080398FC049@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Dave Ertman
> Sent: Saturday, February 19, 2022 2:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix error with handling of
> bonding MTU
> 
> When a bonded interface is destroyed, .ndo_change_mtu can be called
> during the tear-down process while the RTNL lock is held.  This is a problem
> since the auxiliary driver linked to the LAN driver needs to be notified of the
> MTU change, and this requires grabbing a device_lock on the
> auxiliary_device's dev.  Currently this is being attempted in the same
> execution context as the call to .ndo_change_mtu which is causing a dead-
> lock.
> 
> Move the notification of the changed MTU to a separate execution context
> (watchdog service task) and eliminate the "before" notification.
> 
> Fixes: 348048e724a0e ("ice: Implement iidc operations")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
> v2: target change from net-next to net
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  1 +
>  drivers/net/ethernet/intel/ice/ice_main.c | 29 +++++++++++------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
