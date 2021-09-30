From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 30 Sep 2021 05:01:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 6/9] ice: cleanup rules
 info
In-Reply-To: <1628239746-17380-7-git-send-email-wojciech.drewek@intel.com>
References: <1628239746-17380-1-git-send-email-wojciech.drewek@intel.com>
 <1628239746-17380-7-git-send-email-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB45546F59CD4B9D4C43F8AAE29CAA9@MW3PR11MB4554.namprd11.prod.outlook.com>
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
>Subject: [Intel-wired-lan] [PATCH net-next v6 6/9] ice: cleanup rules info
>
>From: Victor Raj <victor.raj@intel.com>
>
>Change ICE_SW_LKUP_LAST to ICE_MAX_NUM_RECIPES as for now there also
>can be recipes other than the default.
>
>Free all structures created for advanced recipes in cleanup function.
>Write a function to clean allocated structures on advanced rule info.
>
>Signed-off-by: Victor Raj <victor.raj@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_common.c | 41
>+++++++++++++++++++++++------  drivers/net/ethernet/intel/ice/ice_switch.c |
>28 ++++++++++++++++++--
> 2 files changed, 59 insertions(+), 10 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
