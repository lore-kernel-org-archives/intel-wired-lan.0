From: Chen, BoX C <box.c.chen@intel.com>
Date: Mon, 15 Mar 2021 08:20:21 +0000
Subject: [Intel-wired-lan] [Patch v5 08/18] ice: Add FDIR pattern action
 parser for VF
In-Reply-To: <BN8PR11MB37959E6CB9A88E2DE3F40403F76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-9-haiyue.wang@intel.com>
 <BN8PR11MB37959E6CB9A88E2DE3F40403F76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
Message-ID: <DM6PR11MB3099349448C54828E89DA901D96C9@DM6PR11MB3099.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Wang, Haiyue <haiyue.wang@intel.com>
> Sent: March 15, 2021 16:19
> To: intel-wired-lan at lists.osuosl.org
> Cc: Liang, Cunming <cunming.liang@intel.com>; Cao, Yahui
> <yahui.cao@intel.com>; Zhang, Qi Z <qi.z.zhang@intel.com>; Chen, BoX C
> <box.c.chen@intel.com>
> Subject: RE: [Intel-wired-lan] [Patch v5 08/18] ice: Add FDIR pattern action
> parser for VF
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Haiyue Wang
> > Sent: Tuesday, March 9, 2021 11:08
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Liang, Cunming <cunming.liang@intel.com>; Cao, Yahui
> > <yahui.cao@intel.com>; Zhang, Qi Z <qi.z.zhang@intel.com>
> > Subject: [Intel-wired-lan] [Patch v5 08/18] ice: Add FDIR pattern
> > action parser for VF
> >
> > From: Qi Zhang <qi.z.zhang@intel.com>
> >
> > Add basic FDIR flow list and pattern / action parse functions for VF.
> >
> > Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> > Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> > ---
> >  .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 348 +++++++++++++++++-
> >  1 file changed, 346 insertions(+), 2 deletions(-)
> >
> 
> Re-send to Bo, as a new member.
> 

Tested-by: Chen Bo <BoX.C.Chen@intel.com>

BRs,
Chen Bo

> > --
> > 2.30.1
> >
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
