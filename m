From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jul 2020 23:57:34 +0000
Subject: [Intel-wired-lan] [PATCH S48 v6 09/16] ice: Add support for per
 VF ctrl VSI enabling
In-Reply-To: <20200716133938.46921-10-qi.z.zhang@intel.com>
References: <20200716133938.46921-1-qi.z.zhang@intel.com>
 <20200716133938.46921-10-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB21458CCFBDFBE67A1CB0E7E68C770@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 16, 2020 6:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v6 09/16] ice: Add support for per VF
> ctrl VSI enabling
> 
> We are going to enable FDIR configure for AVF through virtual channel.
> The first step is to add helper functions to support control VSI setup.
> A control VSI will be allocated for a VF when AVF creates its first FDIR rule
> through ice_vf_ctrl_vsi_setup().
> The patch will also allocate FDIR rule space for VF's control VSI.
> If a VF asks for flow director rules, then those should come entirely from the
> best effort pool and not from the guaranteed pool. The patch allow a VF VSI
> to have only space in the best effort rules.
> 
> Signed-off-by: Xiaoyun Li <xiaoyun.li@intel.com>
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h             |  4 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c         | 64
> +++++++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_main.c        |  9 +++-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 62
> +++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  2 +
>  5 files changed, 130 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


