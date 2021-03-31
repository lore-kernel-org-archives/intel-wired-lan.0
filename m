From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 31 Mar 2021 20:55:32 +0000
Subject: [Intel-wired-lan] [PATCH S57 03/14] ice: Align macro names to
 the specification
In-Reply-To: <20210325223517.17722-3-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-3-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105573AAAB057C322DB7266FA7C9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, March 25, 2021 3:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S57 03/14] ice: Align macro names to the
> specification
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> For get PHY abilities AQ, the specification defines "report modes"
> as "with media", "without media" and "active configuration". For clarity,
> rename macros to align with the specification.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 10 +++++-----
>  drivers/net/ethernet/intel/ice/ice_common.c     | 13 +++++++------
>  drivers/net/ethernet/intel/ice/ice_ethtool.c    | 12 ++++++------
>  drivers/net/ethernet/intel/ice/ice_main.c       | 12 ++++++------
>  4 files changed, 24 insertions(+), 23 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


