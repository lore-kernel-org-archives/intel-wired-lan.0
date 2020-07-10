From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:25:47 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 10/16] ice: Support FDIR
 configure for AVF
In-Reply-To: <20200710010644.33817-11-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-11-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB2145EC1BEA3796A9006784E08C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S48 v5 10/16] ice: Support FDIR configure
> for AVF
> 
> Add virtual channel support for iAVF FDIR add/validate/delete filter.
> iAVF FDIR is Flow Director for Intel Adaptive Virtual Function which can direct
> Ethernet packets to the queues of the Network Interface Card.
> Add/delete command is adding or deleting one rule for each virtual channel
> message, while validate command is just verifying if this rule is valid without
> any other operations.
> 
> To add or delete one rule, driver needs to config TCAM and Profile, build
> training packets which contains the input set value, and send the training
> packets through FDIR Tx queue. In addition, driver needs to manage the
> software context to avoid adding duplicated rules, deleting non-existent
> rule, input set conflicts and other invalid cases.
> 
> NOTE:
> Supported pattern/actions and their parse functions are not be included in
> this patch, they will be added in a separate one.
> 
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Simei Su <simei.su@intel.com>
> Signed-off-by: Beilei Xing <beilei.xing@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile            |    2 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |    4 +
>  drivers/net/ethernet/intel/ice/ice_fdir.c          |    6 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.h          |    6 +
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |    2 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 1035
> ++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h |   24 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c   |   17 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h   |    6 +
>  include/linux/avf/virtchnl.h                       |  120 +++
>  10 files changed, 1216 insertions(+), 6 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


