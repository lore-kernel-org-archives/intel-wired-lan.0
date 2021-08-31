From: Mekala, SunithaX D <sunithax.d.mekala@intel.com>
Date: Tue, 31 Aug 2021 20:42:48 +0000
Subject: [Intel-wired-lan] [PATCH v3 intel-next] ice: Refactor
 ice_aqc_link_topo_addr
In-Reply-To: <20210830122614.4031053-1-maciej.machnikowski@intel.com>
References: <20210830122614.4031053-1-maciej.machnikowski@intel.com>
Message-ID: <CO1PR11MB502824C5C18C17EC1D733649A0CC9@CO1PR11MB5028.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej Machnikowski
> Sent: Monday, August 30, 2021 5:26 AM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: pmenzel at molgen.mpg.de
> Subject: [Intel-wired-lan] [PATCH v3 intel-next] ice: Refactor ice_aqc_link_topo_addr
>
> Separate link topo parameters in struct ice_aqc_link_topo_addr into new struct ice_aqc_link_topo_params.
> This keeps input parameters for the get_link_topo command in a separate structure and is required by future commands that operate only on link topo params without the node handle.
>
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> ---
> v2: Fix code style errors, Change pca9575_handle type returned by
>    ice_get_pca9575_handle to u16
> v3: Clarified commit message
> ---
> drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 6 +++++-
>  drivers/net/ethernet/intel/ice/ice_common.c     | 8 +++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
