From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Thu, 1 Oct 2015 21:40:29 +0000
Subject: [Intel-wired-lan] [next PATCH S18 3/8] i40e: Fix VEB/VEPA
 bridge	mode mismatch issue
In-Reply-To: <CFEEE81102D91947B9CC368106979EBA61F2B92E@ORSMSX105.amr.corp.intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
 <1443724661-92168-4-git-send-email-catherine.sullivan@intel.com>
 <FC41C24E35F18A40888AACA1A36F3E418AF91A28@fmsmsx115.amr.corp.intel.com>
 <CFEEE81102D91947B9CC368106979EBA61F2B92E@ORSMSX105.amr.corp.intel.com>
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AF91BEE@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > index d341f56..a56aefe 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > @@ -8758,12 +8758,22 @@ int i40e_is_vsi_uplink_mode_veb(struct
> > > i40e_vsi
> > > *vsi)
> > >  		return 1;
> > >
> > >  	veb = pf->veb[vsi->veb_idx];
> > > +	if (!veb) {
> > > +		dev_info(&pf->pdev->dev,
> > > +			 "There is no veb associated with the bridge\n");
> > > +		return -ENOENT;
> > > +	}
> > > +
> >
> > This introduces a subtle bug into the code - the caller of
> > i40e_is_vsi_uplink_mode_veb() is looking for 0/non-0, not looking for an
> > error condition.
> >
> > sln
> 
> So, we need to make sure that caller knows how to handle instance of non-
> existence of VEB or we are guaranteed there is always going to be VEB,
> then we can just forget checking for error? Please, let me know...
> 
> Thanks,
> ~Akeem

Since it's already returning 1 in the veb_idx==NO_VEB case, I suppose you can use similar reasoning to return 1 in the !veb case.  I would think that neither case should actually ever get hit.

sln

