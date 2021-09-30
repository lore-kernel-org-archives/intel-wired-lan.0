From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 30 Sep 2021 09:04:27 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 2/9] ice: manage profiles
 and field vectors
In-Reply-To: <1628239746-17380-3-git-send-email-wojciech.drewek@intel.com>
References: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
 <1628239746-17380-3-git-send-email-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB4554D15C5FE3BF668C826DFE9CAA9@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v6 2/9] ice: manage profiles and
>field vectors
>
>From: Dan Nowlin <dan.nowlin@intel.com>
>
>Implement functions to manage profiles and field vectors in hardware.
>
>In hardware, there are up to 256 profiles and each of these profiles can have
>48 field vector words. Each field vector word is described by protocol id and
>offset in the packet. To add a new recipe all used profiles need to be
>searched. If the profile contains all required protocol ids and offsets from the
>recipe it can be used. The driver has to add this profile to recipe association to
>tell hardware that newly added recipe is going to be associated with this
>profile.
>
>The amount of used profiles depend on the package. To avoid searching
>across not used profile, max profile id value is calculated at init flow.
>The profile is considered as unused when all field vector words in the profile
>are invalid (protocol id 0xff and offset 0x1ff).
>
>Profiles are read from the package section ICE_SID_FLD_VEC_SW. Empty field
>vector words can be used for recipe results. Store all unused field vector
>words in prof_res_bm. It is a 256 elements array (max number of
>profiles) each element is a 48 bit bitmap (max number of field vector words).
>
>For now, support only non-tunnel profiles type.
>
>Co-developed-by: Grishma Kotecha <grishma.kotecha@intel.com>
>Signed-off-by: Grishma Kotecha <grishma.kotecha@intel.com>
>Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 245
>+++++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_flex_pipe.h |   8 +
> drivers/net/ethernet/intel/ice/ice_flex_type.h |  13 ++
> drivers/net/ethernet/intel/ice/ice_switch.c    |   3 +-
> drivers/net/ethernet/intel/ice/ice_type.h      |   3 +
> 5 files changed, 271 insertions(+), 1 deletion(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
