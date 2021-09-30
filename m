From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 30 Sep 2021 04:54:00 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 9/9] ice: ndo_setup_tc
 implementation for PR
In-Reply-To: <1628239746-17380-10-git-send-email-wojciech.drewek@intel.com>
References: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
 <1628239746-17380-10-git-send-email-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB45547D182875AECAED3952099CAA9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Wojciech Drewek
>Sent: Friday, August 6, 2021 2:19 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v6 9/9] ice: ndo_setup_tc
>implementation for PR
>
>From: Michal Swiatkowski <michal.swiatkowski@intel.com>
>
>Add tc-flower support for VF port representor devices.
>
>Implement ndo_setup_tc callback for TC HW offload on VF port representors
>devices. Implemented both methods: add and delete tc-flower flows.
>
>Mark NETIF_F_HW_TC bit in net device's feature set to enable offload TC
>infrastructure for port representor.
>
>Implement TC filters replay function required to restore filters settings while
>switchdev configuration is rebuilt.
>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_eswitch.c |  3 ++
> drivers/net/ethernet/intel/ice/ice_repr.c    | 53
>++++++++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_tc_lib.c  | 17 +++++++++
>drivers/net/ethernet/intel/ice/ice_tc_lib.h  |  1 +
> 4 files changed, 74 insertions(+)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
