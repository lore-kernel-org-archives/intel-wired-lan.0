From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Mon, 15 Mar 2021 08:17:36 +0000
Subject: [Intel-wired-lan] [Patch v5 05/18] ice: Enhanced IPv4 and IPv6
 flow filter
In-Reply-To: <20210309030815.5299-6-haiyue.wang@intel.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-6-haiyue.wang@intel.com>
Message-ID: <BN8PR11MB37950F0CA25E18DFD462BBE5F76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Haiyue Wang
> Sent: Tuesday, March 9, 2021 11:08
> To: intel-wired-lan at lists.osuosl.org
> Cc: Nowlin, Dan <dan.nowlin@intel.com>; Liang, Cunming <cunming.liang@intel.com>; Zhang, Qi Z
> <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [Patch v5 05/18] ice: Enhanced IPv4 and IPv6 flow filter
> 
> From: Qi Zhang <qi.z.zhang@intel.com>
> 
> Separate IPv4 and IPv6 ptype bit mask table into 2 tables:
> With or without L4 protocols.
> 
> When a flow filter without any l4 type is specified, the
> ICE_FLOW_SEG_HDR_IPV_OTHER flag can be used to describe if user
> want to create a IP rule target for all IP packet or just IP
> packet without l4 header.
> 
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c | 54 ++++++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_flow.h |  4 ++
>  2 files changed, 53 insertions(+), 5 deletions(-)
> 

Re-send to Bo, as a new member.

> --
> 2.30.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
