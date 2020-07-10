From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:26:11 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 16/16] ice: Check FDIR program
 status for AVF
In-Reply-To: <20200710010644.33817-17-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-17-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB2145A56E6BBF78FADA77EB658C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S48 v5 16/16] ice: Check FDIR program
> status for AVF
> 
> Enables returning FDIR completion status by checking the ctrl_vsi Rx queue
> descriptor value.
> 
> To enable returning FDIR completion status from ctrl_vsi Rx queue,
> COMP_Queue and COMP_Report of FDIR filter programming descriptor
> needs to be properly configured. After program request sent to ctrl_vsi Tx
> queue, ctrl_vsi Rx queue interrupt will be triggered and completion status
> will be returned.
> 
> Driver will first issue request in ice_vc_fdir_add_fltr(), then pass FDIR context
> to the background task in interrupt service routine
> ice_vc_fdir_irq_handler() and finally deal with them in ice_flush_fdir_ctx().
> ice_flush_fdir_ctx() will check the descriptor's value, fdir context, and then
> send back virtual channel message to VF by calling
> ice_vc_add_fdir_fltr_post(). An additional timer will be setup in case of
> hardware interrupt timeout.
> 
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h               |   1 +
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |   3 +
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |  20 +
>  drivers/net/ethernet/intel/ice/ice_main.c          |   2 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c          |   5 +
>  drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 494
> ++++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h |  27 +-
>  7 files changed, 536 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


