From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 10 Jun 2020 22:25:47 +0000
Subject: [Intel-wired-lan] [PATCH 1/4] iavf: fix speed reporting over
 virtchnl
In-Reply-To: <20200605170946.23494-1-anthony.l.nguyen@intel.com>
References: <20200605170946.23494-1-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21459BC2FD2B5E51006D15B98C830@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, June 5, 2020 10:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/4] iavf: fix speed reporting over virtchnl
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Link speeds are communicated over virtchnl using an enum
> virtchnl_link_speed. Currently, the highest link speed is 40Gbps which leaves
> us unable to reflect some speeds that an ice VF is capable of.
> This causes link speed to be misreported on the iavf driver.
> 
> Allow for communicating link speeds using Mbps so that the proper speed
> can be reported for an ice VF. Moving away from the enum allows us to
> communicate future speed changes without requiring a new enum to be
> added.
> 
> In order to support communicating link speeds over virtchnl in Mbps the
> following functionality was added:
>     - Added u32 link_speed_mbps in the iavf_adapter structure.
>     - Added the macro ADV_LINK_SUPPORT(_a) to determine if the VF
>       driver supports communicating link speeds in Mbps.
>     - Added the function iavf_get_vpe_link_status() to fill the
>       correct link_status in the event_data union based on the
>       ADV_LINK_SUPPORT(_a) macro.
>     - Added the function iavf_set_adapter_link_speed_from_vpe()
>       to determine whether or not to fill the u32 link_speed_mbps or
>       enum virtchnl_link_speed link_speed field in the iavf_adapter
>       structure based on the ADV_LINK_SUPPORT(_a) macro.
>     - Do not free vf_res in iavf_init_get_resources() as vf_res will be
>       accessed in iavf_get_link_ksettings(); memset to 0 instead. This
>       memory is subsequently freed in iavf_remove().
> 
> Fixes: 7c710869d64e ("ice: Add handlers for VF netdevice operations")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        | 14 +++
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 14 ++-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 25 ++++--
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 88 ++++++++++++++++---
>  4 files changed, 120 insertions(+), 21 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


