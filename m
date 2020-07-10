From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:29:19 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 13/16] ice: Add non-IP Layer2
 protocol FDIR filter for AVF
In-Reply-To: <20200710010644.33817-14-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-14-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB2145D83E02DC3BFFE0D96E018C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S48 v5 13/16] ice: Add non-IP Layer2
> protocol FDIR filter for AVF
> 
> Add new filter type that allow forward non-IP Ethernet packets base on its
> ethertype. The filter is only enabled when COMMS DDP package is loaded.
> 
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fdir.c          | 11 +++++++
>  drivers/net/ethernet/intel/ice/ice_fdir.h          |  1 +
>  drivers/net/ethernet/intel/ice/ice_flow.c          | 17 +++++++++-
>  drivers/net/ethernet/intel/ice/ice_flow.h          |  1 +
>  drivers/net/ethernet/intel/ice/ice_type.h          |  1 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 38
> ++++++++++++++++++++--
>  6 files changed, 65 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


