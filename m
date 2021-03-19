From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 19 Mar 2021 22:43:29 +0000
Subject: [Intel-wired-lan] [PATCH S55 07/14] ice: use kernel definitions
 for IANA protocol ports and ether-types
In-Reply-To: <20210302181213.51718-7-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
 <20210302181213.51718-7-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105B8247DCA9B3AECBD25BEFA689@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, March 2, 2021 10:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S55 07/14] ice: use kernel definitions for
> IANA protocol ports and ether-types
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> The well-known IANA protocol port 3260 (iscsi-target 0x0cbc) and the ether-
> types 0x8906 (ETH_P_FCOE) and 0x8914 (ETH_P_FIP) are already defined in
> kernel header files.  Use those definitions instead of open-coding the same.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         | 3 +++
>  drivers/net/ethernet/intel/ice/ice_dcb.c     | 8 ++++----
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 2 +-
>  drivers/net/ethernet/intel/ice/ice_type.h    | 3 ---
>  4 files changed, 8 insertions(+), 8 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


