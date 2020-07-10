From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:29:01 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 12/16] ice: Add new actions
 support for VF FDIR
In-Reply-To: <20200710010644.33817-13-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-13-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB2145393440A943943790D95E8C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 9, 2020 6:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v5 12/16] ice: Add new actions support
> for VF FDIR
> 
> Add two new actions support for VF FDIR:
> 
> A passthrough action does not specify the destination queue, but just allow
> the packet go to next pipeline stage, a typical use cases is combined with a
> software mark (FDID) action.
> 
> Allow specify a 2^n continuous queues as the destination of a FDIR rule.
> Packet distribution is based on current RSS configure.
> 
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fdir.c          | 12 +++++++++++-
>  drivers/net/ethernet/intel/ice/ice_fdir.h          |  4 ++++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 10 ++++++++++
>  include/linux/avf/virtchnl.h                       |  2 ++
>  4 files changed, 27 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


