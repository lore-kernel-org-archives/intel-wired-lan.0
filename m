From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Mon, 15 Mar 2021 08:21:56 +0000
Subject: [Intel-wired-lan] [Patch v5 13/18] ice: Check FDIR program
 status for AVF
In-Reply-To: <20210309030815.5299-14-haiyue.wang@intel.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-14-haiyue.wang@intel.com>
Message-ID: <BN8PR11MB3795861D59A4116898AAA8ABF76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Haiyue Wang
> Sent: Tuesday, March 9, 2021 11:08
> To: intel-wired-lan at lists.osuosl.org
> Cc: Liang, Cunming <cunming.liang@intel.com>; Cao, Yahui <yahui.cao@intel.com>; Zhang, Qi Z
> <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [Patch v5 13/18] ice: Check FDIR program status for AVF
> 
> From: Qi Zhang <qi.z.zhang@intel.com>
> 
> Enables returning FDIR completion status by checking the
> ctrl_vsi Rx queue descriptor value.
> 
> To enable returning FDIR completion status from ctrl_vsi Rx queue,
> COMP_Queue and COMP_Report of FDIR filter programming descriptor
> needs to be properly configured. After program request sent to ctrl_vsi
> Tx queue, ctrl_vsi Rx queue interrupt will be triggered and
> completion status will be returned.
> 
> Driver will first issue request in ice_vc_fdir_add_fltr(), then
> pass FDIR context to the background task in interrupt service routine
> ice_vc_fdir_irq_handler() and finally deal with them in
> ice_flush_fdir_ctx(). ice_flush_fdir_ctx() will check the descriptor's
> value, fdir context, and then send back virtual channel message to VF
> by calling ice_vc_add_fdir_fltr_post(). An additional timer will be
> setup in case of hardware interrupt timeout.
> 
> Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---

Re-send to Bo, as a new member.

> --
> 2.30.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
