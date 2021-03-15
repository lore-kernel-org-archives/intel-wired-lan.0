From: Wang, Haiyue <haiyue.wang@intel.com>
Date: Mon, 15 Mar 2021 08:17:08 +0000
Subject: [Intel-wired-lan] [Patch v5 04/18] ice: Support to separate
 GTP-U uplink and downlink
In-Reply-To: <20210309030815.5299-5-haiyue.wang@intel.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-5-haiyue.wang@intel.com>
Message-ID: <BN8PR11MB379543076ACA37D78FF48E18F76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [Patch v5 04/18] ice: Support to separate GTP-U uplink and downlink
> 
> From: Qi Zhang <qi.z.zhang@intel.com>
> 
> To apply different input set for GTP-U packet with or without extend
> header as well as GTP-U uplink and downlink, we need to add TCAM mask
> matching capability. This allows comprehending different PTYPE
> attributes by examining flags from the parser. Using this method,
> different profiles can be used by examining flag values from the parser.
> 
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 106 +++++++++++++++---
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |   1 +
>  .../net/ethernet/intel/ice/ice_flex_type.h    |  61 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.c     |  88 ++++++++++++++-
>  4 files changed, 241 insertions(+), 15 deletions(-)
> 

Re-send to Bo, as a new member.

> --
> 2.30.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
