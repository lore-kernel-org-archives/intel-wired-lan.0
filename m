From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 12 Apr 2022 16:36:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/6] ice: add newline to
 dev_dbg in ice_vf_fdir_dump_info
In-Reply-To: <aa858f43-a62b-4ce8-c307-882e0ef90134@molgen.mpg.de>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
 <20220411232907.1022602-2-jacob.e.keller@intel.com>
 <aa858f43-a62b-4ce8-c307-882e0ef90134@molgen.mpg.de>
Message-ID: <CO1PR11MB5089109C48F3F58ECA332F3DD6ED9@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Monday, April 11, 2022 10:11 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH net-next 1/6] ice: add newline to dev_dbg in
> ice_vf_fdir_dump_info
> 
> Dear Jacob,
> 
> 
> Am 12.04.22 um 01:29 schrieb Jacob Keller:
> > The debug print in ice_vf_fdir_dump_info don't end in newlines. This can
> 
> Singular? does not
> 

Ah, yep.

> > look confusing when reading the kernel log, as the next print will
> > immediately continue on the same line.
> >
> > Fix this.
> >
> 
> Add a Fixes tag?
> 
> Maybe also add *forgotten* to the commit message summary:
> 
> Add forgotten newline ?
> 

Makes sense.

> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> > index 8e38ee2faf58..dbc1965c0609 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> > @@ -1349,7 +1349,7 @@ static void ice_vf_fdir_dump_info(struct ice_vf *vf)
> >
> >   	fd_size = rd32(hw, VSIQF_FD_SIZE(vsi_num));
> >   	fd_cnt = rd32(hw, VSIQF_FD_CNT(vsi_num));
> > -	dev_dbg(dev, "VF %d: space allocated: guar:0x%x, be:0x%x, space
> consumed: guar:0x%x, be:0x%x",
> > +	dev_dbg(dev, "VF %d: space allocated: guar:0x%x, be:0x%x, space
> consumed: guar:0x%x, be:0x%x\n",
> >   		vf->vf_id,
> >   		(fd_size & VSIQF_FD_CNT_FD_GCNT_M) >>
> VSIQF_FD_CNT_FD_GCNT_S,
> >   		(fd_size & VSIQF_FD_CNT_FD_BCNT_M) >>
> VSIQF_FD_CNT_FD_BCNT_S,
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
