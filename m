From: Mekala, SunithaX D <sunithax.d.mekala@intel.com>
Date: Thu, 26 Aug 2021 06:23:41 +0000
Subject: [Intel-wired-lan] [PATCH intel-next 1/4] ice: Refactor
 ice_aqc_link_topo_addr
In-Reply-To: <20210816102729.1266522-2-maciej.machnikowski@intel.com>
References: <20210816102729.1266522-1-maciej.machnikowski@intel.com>
 <20210816102729.1266522-2-maciej.machnikowski@intel.com>
Message-ID: <CO1PR11MB50285501AE9176B77D46E379A0C79@CO1PR11MB5028.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej Machnikowski
> Sent: Monday, August 16, 2021 3:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-next 1/4] ice: Refactor ice_aqc_link_topo_addr
>
> Separate link topo parameters and move to the ice_aqc_link_topo_params in the ice_aqc_link_topo_addr.
>
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 6 +++++-
>  drivers/net/ethernet/intel/ice/ice_common.c     | 8 +++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
Tested-by: Mekala, Sunitha D <sunithax.d.mekala@intel.com > (A Contingent worker at Intel)
