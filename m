From: Mekala, SunithaX D <sunithax.d.mekala@intel.com>
Date: Tue, 5 Oct 2021 16:33:43 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-next 1/4] ice: Refactor
 ice_aqc_link_topo_addr
In-Reply-To: <20210817110918.1937113-2-maciej.machnikowski@intel.com>
References: <20210817110918.1937113-1-maciej.machnikowski@intel.com>
 <20210817110918.1937113-2-maciej.machnikowski@intel.com>
Message-ID: <CO1PR11MB5028CE4DB70C1DBFF5FA2E3FA0AF9@CO1PR11MB5028.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej Machnikowski
> Sent: Tuesday, August 17, 2021 4:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 intel-next 1/4] ice: Refactor ice_aqc_link_topo_addr
>
> Separate link topo parameters and move to the ice_aqc_link_topo_params in the ice_aqc_link_topo_addr.
>
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> ---
 > drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 6 +++++-
 > drivers/net/ethernet/intel/ice/ice_common.c     | 8 +++++---
 > 2 files changed, 10 insertions(+), 4 deletions(-)
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel) 

