From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 10 Mar 2022 09:43:28 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Add support for double
 vlan in switchdev
In-Reply-To: <20220223003830.25565-1-martyna.szapar-mudlaw@intel.com>
References: <20220223003830.25565-1-martyna.szapar-mudlaw@intel.com>
Message-ID: <MW3PR11MB45544E7AF02934C98D7C017F9C0B9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Martyna Szapar-Mudlaw
>Sent: Wednesday, February 23, 2022 6:09 AM
To: intel-wired-lan@lists.osuosl.org
>Cc: Szapar-Mudlaw, Martyna <martyna.szapar-mudlaw@intel.com>; Wiktor
>Pilarczyk <wiktor.pilarczyk@intel.com>
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Add support for double vlan in
>switchdev
>
>Enable support for adding TC rules with both C-tag and S-tag that can filter on
>the inner and outer VLAN in QinQ for basic packets (not tunneled cases).
>
>Signed-off-by: Wiktor Pilarczyk <wiktor.pilarczyk@intel.com>
>Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@intel.com>
>---
> .../ethernet/intel/ice/ice_protocol_type.h    |   2 +
> drivers/net/ethernet/intel/ice/ice_switch.c   | 230 +++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  43 +++-
> drivers/net/ethernet/intel/ice/ice_tc_lib.h   |   2 +
> 4 files changed, 274 insertions(+), 3 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
