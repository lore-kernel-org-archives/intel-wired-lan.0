From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 30 Sep 2021 09:04:58 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 1/9] ice: implement low
 level recipes functions
In-Reply-To: <1628239746-17380-2-git-send-email-wojciech.drewek@intel.com>
References: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
 <1628239746-17380-2-git-send-email-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB4554696BCE4E7A93674E470C9CAA9@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v6 1/9] ice: implement low level
>recipes functions
>
>From: Grishma Kotecha <grishma.kotecha@intel.com>
>
>Add code to manage recipes and profiles on admin queue layer.
>
>Allow the driver to add a new recipe and update an existing one. Get a recipe
>and get a recipe to profile association is mostly used in update existing recipes
>code.
>
>Only default recipes can be updated. An update is done by reading recipes
>from HW, changing their params and calling add recipe command.
>
>Support following admin queue commands:
>- ice_aqc_opc_add_recipe (0x0290) - create a recipe with protocol header
>information and other details that determine how this recipe filter works
>- ice_aqc_opc_recipe_to_profile (0x0291) - associate a switch recipe to a
>profile
>- ice_aqc_opc_get_recipe (0x0292) - get details of an exsisting recipe
>- ice_aqc_opc_get_recipe_to_profile (0x0293) - get a recipe associated with
>profile ID
>
>Define ICE_AQC_RES_TYPE_RECIPE resource type to hold a switch recipe. It is
>needed when a new switch recipe needs to be created.
>
>Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
>Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
>Signed-off-by: Grishma Kotecha  <grishma.kotecha@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  57 +++++++
> drivers/net/ethernet/intel/ice/ice_switch.c     | 213
>++++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_switch.h     |   9 +
> 3 files changed, 279 insertions(+)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
