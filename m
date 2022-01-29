From: Mekala, SunithaX D <sunithax.d.mekala@intel.com>
Date: Sat, 29 Jan 2022 00:19:40 +0000
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix KASAN error in LAG
 NETDEV_UNREGISTER handler
In-Reply-To: <20220118210820.1055792-1-david.m.ertman@intel.com>
References: <20220118210820.1055792-1-david.m.ertman@intel.com>
Message-ID: <CO1PR11MB50284CB7082E8CBB289111A2A0239@CO1PR11MB5028.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Dave Ertman
> Sent: Tuesday, January 18, 2022 1:08 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix KASAN error in LAG NETDEV_UNREGISTER handler
>
> Currently, the same handler is called for both a NETDEV_BONDING_INFO LAG unlink notification as for a NETDEV_UNREGISTER call.  This is causing a problem though, since the netdev_notifier_info passed has a different structure depending on which event is passed.  The problem manifests as a call trace from a BUG: KASAN stack-out-of-bounds error.
> 
> Fix this by creating a handler specific to NETDEV_UNREGISTER that only is passed valid elements in the netdev_notifier_info struct for the NETDEV_UNREGISTER event.

> Also included is the removal of an unbalanced dev_put on the peer_netdev and related braces.
>
> Fixes: 6a8b357278f5 ("ice: Respond to a NETDEV_UNREGISTER event for LAG")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
>
> ---
>
> v2: also remove unneeded if block
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 34 +++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel) 
