From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 15 Feb 2022 04:45:17 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Match on all profiles
 in slow-path
In-Reply-To: <20211217113625.31128-1-wojciech.drewek@intel.com>
References: <20211217113625.31128-1-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB45546CF36D516F8D5F0C3A2E9C349@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Wojciech Drewek
>Sent: Friday, December 17, 2021 5:06 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Match on all profiles in slow-
>path
>
>In switchdev mode, slow-path rules need to match all protocols, in order to
>correctly redirect unfiltered or missed packets to the uplink. To set this up for
>the virtual function to uplink flow, the rule that redirects packets to the
>control VSI must have the tunnel type set to ICE_SW_TUN_AND_NON_TUN. As
>a result of that new tunnel type being set, ice_get_compat_fv_bitmap will
>select ICE_PROF_ALL. At that point all profiles would be selected for this rule,
>resulting in the desired behavior. Without this change slow-path would not
>work with tunnel protocols.
>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_eswitch.c       | 1 +
> drivers/net/ethernet/intel/ice/ice_protocol_type.h | 1 +
> drivers/net/ethernet/intel/ice/ice_switch.c        | 4 +++-
> 3 files changed, 5 insertions(+), 1 deletion(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
