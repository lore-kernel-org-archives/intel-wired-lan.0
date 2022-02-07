From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Mon, 7 Feb 2022 04:51:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Add slow path offload
 stats on port representor in switchdev
In-Reply-To: <20220127150426.368315-1-marcin.szycik@linux.intel.com>
References: <20220127150426.368315-1-marcin.szycik@linux.intel.com>
Message-ID: <MW3PR11MB45547ABB8B318C324E1297429C2C9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Marcin Szycik
>Sent: Thursday, January 27, 2022 8:34 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Add slow path offload stats on
>port representor in switchdev
>
>Implement callbacks to check for stats and fetch port representor stats.
>Stats are taken from RX/TX ring corresponding to port representor and show
>the number of bytes/packets that were not offloaded.
>
>To see slow path stats run:
>ifstat -x cpu_hits -a
>
>Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice.h      |  3 ++
> drivers/net/ethernet/intel/ice/ice_main.c |  6 +--
>drivers/net/ethernet/intel/ice/ice_repr.c | 55 +++++++++++++++++++++++
> 3 files changed, 61 insertions(+), 3 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
