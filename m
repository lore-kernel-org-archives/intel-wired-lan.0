From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 19 Oct 2021 04:44:45 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Refactor PR ethtool ops
In-Reply-To: <20211008084403.6075-1-wojciech.drewek@intel.com>
References: <20211008084403.6075-1-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB45546F215FB67F287F3002039CBD9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Wojciech Drewek
>Sent: Friday, October 8, 2021 2:14 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Refactor PR ethtool ops
>
>This patch improves a few things:
>
>- it fixes issue where ethtool -i reports that PR supports
>  priv-flags and tests when in fact it does not support them
>- instead of using the same functions for both PF and PR ethtool ops,
>  this patch introduces separate ops for both cases and internal
>  functions with core logic.
>- prevent accessing VF VSI while VF is not ready by calling
>  ice_check_vf_ready_for_cfg
>- all PR specific functions in ethtool.c were moved to one place in
>  file
>- instead overwriting n_priv_flags in ice_repr_get_drvinfo,
>  priv-flags code was moved from __ice_get_drvinfo to ice_get_drvinfo
>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 99 +++++++++++++++-----
> 1 file changed, 74 insertions(+), 25 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
