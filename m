From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 11 Aug 2021 05:52:38 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix crash in switchdev
 mode during VFR
In-Reply-To: <1626694079-4328-1-git-send-email-wojciech.drewek@intel.com>
References: <1626694079-4328-1-git-send-email-wojciech.drewek@intel.com>
Message-ID: <MW3PR11MB4554C3E41F397A72D371F0B49CF89@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Wojciech Drewek
>Sent: Monday, July 19, 2021 4:58 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix crash in switchdev mode
>during VFR
>
>During VF reset VF VSI is released, because of that there was a risk of calling
>ice_repr_get_stats64 or ice_get_drvinfo when VF VSI was NULL. The solution is
>to use ice_check_vf_ready_for_cfg function.
>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_ethtool.c     | 27 ++++++++++++++++++++---
>-
> drivers/net/ethernet/intel/ice/ice_repr.c        |  6 +++++-
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  2 +-
>drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  6 ++++++
> 4 files changed, 35 insertions(+), 6 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
