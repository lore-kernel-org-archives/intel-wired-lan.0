From: Chen, BoX C <box.c.chen@intel.com>
Date: Mon, 15 Mar 2021 08:18:07 +0000
Subject: [Intel-wired-lan] [Patch v5 03/18] ice: Add more advanced
 protocol support in flow filter
In-Reply-To: <BN8PR11MB3795B1E52DF1CE8056E7CB37F76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-4-haiyue.wang@intel.com>
 <BN8PR11MB3795B1E52DF1CE8056E7CB37F76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
Message-ID: <DM6PR11MB3099167C93D61DC92BCD67FAD96C9@DM6PR11MB3099.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Wang, Haiyue <haiyue.wang@intel.com>
> Sent: March 15, 2021 16:16
> To: intel-wired-lan at lists.osuosl.org; Chen, BoX C <box.c.chen@intel.com>
> Cc: Liang, Cunming <cunming.liang@intel.com>; Xu, Ting
> <ting.xu@intel.com>; Cao, Yahui <yahui.cao@intel.com>; Zhang, Qi Z
> <qi.z.zhang@intel.com>
> Subject: RE: [Intel-wired-lan] [Patch v5 03/18] ice: Add more advanced
> protocol support in flow filter
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Haiyue Wang
> > Sent: Tuesday, March 9, 2021 11:08
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Liang, Cunming <cunming.liang@intel.com>; Xu, Ting
> > <ting.xu@intel.com>; Cao, Yahui <yahui.cao@intel.com>; Zhang, Qi Z
> > <qi.z.zhang@intel.com>
> > Subject: [Intel-wired-lan] [Patch v5 03/18] ice: Add more advanced
> > protocol support in flow filter
> >
> > From: Qi Zhang <qi.z.zhang@intel.com>
> >
> > The patch add more protocol support in flow filter, these include
> > PPPoE, L2TPv3, GTP, PFCP, ESP and AH.
> >
> > Signed-off-by: Ting Xu <ting.xu@intel.com>
> > Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> > Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_flow.c     | 270 +++++++++++++++++-
> >  drivers/net/ethernet/intel/ice/ice_flow.h     | 128 ++++++++-
> >  .../ethernet/intel/ice/ice_protocol_type.h    |   4 +
> >  3 files changed, 396 insertions(+), 6 deletions(-)
> >
> 
> Re-send to Bo, as a new member.
> 

Tested-by: Chen Bo <BoX.C.Chen@intel.com>

BRs,
Chen Bo

> > 2.30.1
> >
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
