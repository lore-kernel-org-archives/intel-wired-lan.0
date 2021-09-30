From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 30 Sep 2021 04:53:20 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 8/9] ice: ndo_setup_tc
 implementation for PF
In-Reply-To: <1628239746-17380-9-git-send-email-wojciech.drewek@intel.com>
References: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
 <1628239746-17380-9-git-send-email-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB455490F3AAE421C28582A3F29CAA9@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v6 8/9] ice: ndo_setup_tc
>implementation for PF
>
>From: Kiran Patil <kiran.patil@intel.com>
>
>Implement ndo_setup_tc net device callback for TC HW offload on PF device.
>
>ndo_setup_tc provides support for HW offloading various TC filters.
>Add support for configuring the following filter with tc-flower:
>- default L2 filters (src/dst mac addresses, ethertype, VLAN)
>- variations of L3, L3+L4, L2+L3+L4 filters using advanced filters (including ipv4
>and ipv6 addresses).
>
>Allow for adding/removing TC flows when PF device is configured in eswitch
>switchdev mode. Two types of actions are supported at the
>moment: FLOW_ACTION_DROP and FLOW_ACTION_REDIRECT.
>
>Co-developed-by: Priyalee Kushwaha <priyalee.kushwaha@intel.com>
>Signed-off-by: Priyalee Kushwaha <priyalee.kushwaha@intel.com>
>Signed-off-by: Kiran Patil <kiran.patil@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/Makefile     |   3 +-
> drivers/net/ethernet/intel/ice/ice.h        |   4 +
> drivers/net/ethernet/intel/ice/ice_main.c   |  68 +++
> drivers/net/ethernet/intel/ice/ice_tc_lib.c | 838
>++++++++++++++++++++++++++++  drivers/net/ethernet/intel/ice/ice_tc_lib.h
>| 129 +++++
> 5 files changed, 1041 insertions(+), 1 deletion(-)  create mode 100644
>drivers/net/ethernet/intel/ice/ice_tc_lib.c
> create mode 100644 drivers/net/ethernet/intel/ice/ice_tc_lib.h
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
