From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 6 Aug 2021 09:51:43 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 02/12] ice: Move devlink
 port to PF/VF struct
In-Reply-To: <20210625024501.6126-3-michal.swiatkowski@linux.intel.com>
References: <20210625024501.6126-1-michal.swiatkowski@linux.intel.com>
 <20210625024501.6126-3-michal.swiatkowski@linux.intel.com>
Message-ID: <MW3PR11MB4554370241CD07260EE5BA149CF39@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Michal Swiatkowski
>Sent: Friday, June 25, 2021 8:15 AM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v3 02/12] ice: Move devlink port to
>PF/VF struct
>
>From: Wojciech Drewek <wojciech.drewek@intel.com>
>
>Keeping devlink port inside VSI data structure causes some issues.
>Since VF VSI is released during reset that means that we have to unregister
>devlink port and register it again every time reset is triggered. With the new
>changes in devlink API it might cause deadlock issues. After calling
>devlink_port_register/devlink_port_unregister devlink API is going to lock
>rtnl_mutex. It's an issue when VF reset is triggered in netlink operation
>context (like setting VF MAC address or VLAN), because rtnl_lock is already
>taken by netlink. Another call of rtnl_lock from devlink API results in dead-
>lock.
>
>By moving devlink port to PF/VF we avoid creating/destroying it during reset.
>Since this patch, devlink ports are created during ice_probe, destroyed during
>ice_remove for PF and created during ice_repr_add, destroyed during
>ice_repr_rem for VF.
>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice.h          |   7 +-
> drivers/net/ethernet/intel/ice/ice_devlink.c  | 106 +++++++++++++-----
> drivers/net/ethernet/intel/ice/ice_devlink.h  |   6 +-
> drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +-
> drivers/net/ethernet/intel/ice/ice_main.c     |   4 +-
> .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   2 +-
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   9 ++
> 7 files changed, 100 insertions(+), 37 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
