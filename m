From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 3 Mar 2022 16:59:20 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix error with handling
 of bonding MTU
In-Reply-To: <20220218190604.1888716-1-david.m.ertman@intel.com>
References: <20220218190604.1888716-1-david.m.ertman@intel.com>
Message-ID: <BYAPR11MB3367662CCCFEA4E85CBD0926FC049@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Dave Ertman
> Sent: Saturday, February 19, 2022 12:36 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix error with handling of
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
>  drivers/net/ethernet/intel/ice/ice.h      |  1 +
>  drivers/net/ethernet/intel/ice/ice_main.c | 29 +++++++++++------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
