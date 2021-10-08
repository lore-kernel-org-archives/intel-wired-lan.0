From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Fri, 8 Oct 2021 04:11:04 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix switchdev
 environment cleanup
In-Reply-To: <20211001211115.2647-1-wojciech.drewek@intel.com>
References: <20211001211115.2647-1-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB455421EC4CD8798409A0A8B89CB29@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Drewek, Wojciech
>Sent: Saturday, October 2, 2021 2:41 AM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix switchdev environment
>cleanup
>
>ice_vsi_release should be called after ice_eswitch_release_reprs because we
>are referring to the switchdev control VSI in ice_eswitch_release_reprs.
>
>Suggested-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>Reported-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
