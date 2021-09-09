From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 9 Sep 2021 03:57:12 +0000
Subject: [Intel-wired-lan] [PATCH net-next 4/7] ice: Add feature bitmap,
 helpers and a check for DSCP
In-Reply-To: <BYAPR11MB33678EAAB258C5CF310FC4E8FCD39@BYAPR11MB3367.namprd11.prod.outlook.com>
References: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
 <20210716221644.45946-5-anthony.l.nguyen@intel.com>
 <BYAPR11MB33678EAAB258C5CF310FC4E8FCD39@BYAPR11MB3367.namprd11.prod.outlook.com>
Message-ID: <BYAPR11MB33676B1EFF86E6DC70FE94E8FCD59@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Tony Nguyen
> Sent: Saturday, July 17, 2021 3:47 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 4/7] ice: Add feature
> bitmap, helpers and a check for DSCP
>
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
>
> DSCP a.k.a L3 QoS is only supported on certain devices. To enforce
> this, this patch introduces a bitmap of features and helper functions.
>
> The feature bitmap is set based on device IDs on driver init.
> Currently, DSCP is the only feature in this bitmap, but there will be
> more in the future. In the DCB netlink flow, check if the feature bit is set
before exercising DSCP.
>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h        |  6 +++
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c |  8 +++-
>  drivers/net/ethernet/intel/ice/ice_lib.c    | 47 +++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h    |  2 +
>  drivers/net/ethernet/intel/ice/ice_main.c   |  2 +
>  5 files changed, 63 insertions(+), 2 deletions(-)
>

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker> at Intel)
