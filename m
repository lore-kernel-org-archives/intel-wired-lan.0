From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Mon, 25 Apr 2022 10:40:27 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: return ENOSPC when
 exceeding ICE_MAX_CHAIN_WORDS
In-Reply-To: <20220420105541.275957-1-wojciech.drewek@intel.com>
References: <20220420105541.275957-1-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB455413EBF8BCAB080BED1E399CF89@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Wojciech Drewek
>Sent: Wednesday, April 20, 2022 4:26 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next v2] ice: return ENOSPC when
>exceeding ICE_MAX_CHAIN_WORDS
>
>When number of words exceeds ICE_MAX_CHAIN_WORDS, -ENOSPC should
>be returned not -EINVAL. Do not overwrite this error code in
>ice_add_tc_flower_adv_fltr.
>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Suggested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
>---
>v2: change title as Paul suggested
>---
> drivers/net/ethernet/intel/ice/ice_switch.c | 5 ++++-
>drivers/net/ethernet/intel/ice/ice_tc_lib.c | 1 -
> 2 files changed, 4 insertions(+), 2 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
