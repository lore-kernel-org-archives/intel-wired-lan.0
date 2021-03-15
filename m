From: Chen, BoX C <box.c.chen@intel.com>
Date: Mon, 15 Mar 2021 08:21:41 +0000
Subject: [Intel-wired-lan] [Patch v5 12/18] ice: Add more FDIR filter
 type for AVF
In-Reply-To: <BN8PR11MB3795A3D1D3751B0BE0CCB47AF76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
References: <20210309030815.5299-1-haiyue.wang@intel.com>
 <20210309030815.5299-13-haiyue.wang@intel.com>
 <BN8PR11MB3795A3D1D3751B0BE0CCB47AF76C9@BN8PR11MB3795.namprd11.prod.outlook.com>
Message-ID: <DM6PR11MB3099045BD668417BC5C4065CD96C9@DM6PR11MB3099.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Wang, Haiyue <haiyue.wang@intel.com>
> Sent: March 15, 2021 16:21
> To: intel-wired-lan at lists.osuosl.org
> Cc: Liang, Cunming <cunming.liang@intel.com>; Cao, Yahui
> <yahui.cao@intel.com>; Zhang, Qi Z <qi.z.zhang@intel.com>; Chen, BoX C
> <box.c.chen@intel.com>
> Subject: RE: [Intel-wired-lan] [Patch v5 12/18] ice: Add more FDIR filter type
> for AVF
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Haiyue Wang
> > Sent: Tuesday, March 9, 2021 11:08
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Liang, Cunming <cunming.liang@intel.com>; Cao, Yahui
> > <yahui.cao@intel.com>; Zhang, Qi Z <qi.z.zhang@intel.com>
> > Subject: [Intel-wired-lan] [Patch v5 12/18] ice: Add more FDIR filter
> > type for AVF
> >
> > From: Qi Zhang <qi.z.zhang@intel.com>
> >
> > FDIR for AVF can forward
> > - L2TPV3 packets by matching session id.
> > - IPSEC ESP packets by matching security parameter index.
> > - IPSEC AH packets by matching security parameter index.
> > - NAT_T ESP packets by matching security parameter index.
> > - Any PFCP session packets(s field is 1).
> >
> > Signed-off-by: Yahui Cao <yahui.cao@intel.com>
> > Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_fdir.c     | 254 ++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_fdir.h     |  15 +
> >  drivers/net/ethernet/intel/ice/ice_type.h     |  13 +
> >  .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 281 ++++++++++++++++--
> >  4 files changed, 545 insertions(+), 18 deletions(-)
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
