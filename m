From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 22 Jun 2020 20:13:28 +0000
Subject: [Intel-wired-lan] [PATCH v2 5/5] ice: add switch rule
 management for DCF
In-Reply-To: <20200619171022.9539-6-haiyue.wang@intel.com>
References: <20200619045711.16055-1-haiyue.wang@intel.com>
 <20200619171022.9539-1-haiyue.wang@intel.com>
 <20200619171022.9539-6-haiyue.wang@intel.com>
Message-ID: <BN6PR1101MB21457263930B3EC0DE7A16088C970@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Haiyue Wang
> Sent: Friday, June 19, 2020 10:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Xiao <xiao.zhang@intel.com>; Xing, Beilei <beilei.xing@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 5/5] ice: add switch rule management
> for DCF
> 
> The PF shall track all the outstanding switch filters (filter IDs to be
> precise) added by the DCF.
> 
> Upon a VF reset event, the PF shall clear all outstanding switch filters for the
> given VF. Upon completion of either VF or PF reset, the PF shall skip replay of
> filters that were added by the DCF. The PF shall however continue to replay
> the filters that were not added by DCF for the VF(s).
> 
> If the trust mode of the DCF is taken away without the DCF gracefully
> relinquishing the DCF functionality (by way appropriate virtchnl message
> exchanges), then the PF shall remove all switch filters that were added by
> the DCF. The PF shall transition back from DCF mode to regular mode, the VF
> shall be treated as any other untrusted VF, and the PF will reset the VF.
> 
> If a designated DCF requests AVF functionality from the same VF (VF-ID)
> without the DCF gracefully relinquishing the DCF functionality first (by way
> appropriate virtchnl message exchanges), the PF shall remove all the switch
> filters that were added by the DCF.
> 
> Signed-off-by: Xiao Zhang <xiao.zhang@intel.com>
> Signed-off-by: Beilei Xing <beilei.xing@intel.com>
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcf.c      | 713 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_dcf.h      |  41 +
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  24 +-
>  drivers/net/ethernet/intel/ice/ice_switch.h   |  35 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   9 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  40 +
>  6 files changed, 829 insertions(+), 33 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


