From: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
Date: Thu, 25 Jul 2019 00:51:54 +0000
Subject: [Intel-wired-lan] [PATCH S23 v3 04/15] ice: Restructure VFs
 initialization flows
In-Reply-To: <804857E1F29AAC47BF68C404FC60A184010968EAED@ORSMSX122.amr.corp.intel.com>
References: <20190723092454.3508-1-anthony.l.nguyen@intel.com>
 <20190723092454.3508-4-anthony.l.nguyen@intel.com>
 <804857E1F29AAC47BF68C404FC60A184010968EAED@ORSMSX122.amr.corp.intel.com>
Message-ID: <CFEEE81102D91947B9CC368106979EBABC809327@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Allan, Bruce W
> Sent: Wednesday, July 24, 2019 5:47 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
> Subject: RE: [Intel-wired-lan] [PATCH S23 v3 04/15] ice: Restructure VFs
> initialization flows
> 
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Tony Nguyen
> > Sent: Tuesday, July 23, 2019 2:25 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
> > Subject: [Intel-wired-lan] [PATCH S23 v3 04/15] ice: Restructure VFs
> > initialization flows
> >
> > From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> >
> > This patch restructures how VFs are configured, and resources allocated.
> > Instead of freeing resources that were never allocated, and resetting
> > empty VFs that have never been created - the new flow will just
> > allocate resources for number of requested VFs based on the availability.
> >
> > During VFs initialization process, global interrupt is disabled, and
> > rearmed after getting MSIX vectors for VFs. This allows immediate
> > mailbox communications, instead of delaying it till later and VFs.
> > PF communications resulted to using polling instead of actual interrupt.
> > The issue manifested when creating higher number of VFs (128 VFs) per PF.
> >
> > Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice.h          |  1 +
> >  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 70
> > +++++++++++++------
> >  2 files changed, 49 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h
> > b/drivers/net/ethernet/intel/ice/ice.h
> > index 07950ac4869f..112bdb662ea2 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -220,6 +220,7 @@ enum ice_state {
> >  	__ICE_CFG_BUSY,
> >  	__ICE_SERVICE_SCHED,
> >  	__ICE_SERVICE_DIS,
> > +	__ICE_OICR_INTR_DIS,		/* Global OICR interrupt disabled */
> >  	__ICE_STATE_NBITS		/* must be last */
> >  };
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> > b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> > index ce01cbe70ea4..4d41877fa06e 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> > @@ -974,6 +974,48 @@ ice_vf_set_vsi_promisc(struct ice_vf *vf, struct
> > ice_vsi *vsi, u8 promisc_m,
> >  	return status;
> >  }
> >
> > +/**
> > + * ice_config_res_vfs - Finalize allocation of VFs resources in one
> > +go
> > + * @pf: pointer to the PF structure
> > + *
> > + * This function is being called as last part of resetting all VFs,
> > +or when
> > + * configuring VFs for the first time, where there is no resource to
> > +be freed
> > + * Returns true if resources were properly allocated for all VFs, and
> > +false
> > + * otherwise.
> > + */
> > +static bool ice_config_res_vfs(struct ice_pf *pf) {
> > +	struct ice_hw *hw = &pf->hw;
> > +	struct ice_vf *vf;
> 
> The scope of vf can be reduced to the for() loop that uses it
I agree with that... Thanks Bruce!

> 
> > +	int v;
> > +
> > +	if (ice_check_avail_res(pf)) {
> > +		dev_err(&pf->pdev->dev,
> > +			"Cannot allocate VF resources, try with fewer
> number
> > of VFs\n");
> > +		return false;
> > +	}
> > +
> > +	/* rearm global interrupts */
> > +	if (test_and_clear_bit(__ICE_OICR_INTR_DIS, pf->state))
> > +		ice_irq_dynamic_ena(hw, NULL, NULL);
> > +
> > +	/* Finish resetting each VF and allocate resources */
> > +	for (v = 0; v < pf->num_alloc_vfs; v++) {
> > +		vf = &pf->vf[v];
> > +
> > +		vf->num_vf_qs = pf->num_vf_qps;
> > +		dev_dbg(&pf->pdev->dev,
> > +			"VF-id %d has %d queues configured\n",
> > +			vf->vf_id, vf->num_vf_qs);
> > +		ice_cleanup_and_realloc_vf(vf);
> > +	}
> > +
> > +	ice_flush(hw);
> > +	clear_bit(__ICE_VF_DIS, pf->state);
> > +
> > +	return true;
> > +}
> > +
> >  /**
> >   * ice_reset_all_vfs - reset all allocated VFs in one go
> >   * @pf: pointer to the PF structure
> > @@ -1066,25 +1108,8 @@ bool ice_reset_all_vfs(struct ice_pf *pf, bool
> > is_vflr)
> >  		dev_err(&pf->pdev->dev,
> >  			"Failed to free MSIX resources used by SR-IOV\n");
> >
> > -	if (ice_check_avail_res(pf)) {
> > -		dev_err(&pf->pdev->dev,
> > -			"Cannot allocate VF resources, try with fewer
> number
> > of VFs\n");
> > +	if (!ice_config_res_vfs(pf))
> >  		return false;
> > -	}
> > -
> > -	/* Finish the reset on each VF */
> > -	for (v = 0; v < pf->num_alloc_vfs; v++) {
> > -		vf = &pf->vf[v];
> > -
> > -		vf->num_vf_qs = pf->num_vf_qps;
> > -		dev_dbg(&pf->pdev->dev,
> > -			"VF-id %d has %d queues configured\n",
> > -			vf->vf_id, vf->num_vf_qs);
> > -		ice_cleanup_and_realloc_vf(vf);
> > -	}
> > -
> > -	ice_flush(hw);
> > -	clear_bit(__ICE_VF_DIS, pf->state);
> >
> >  	return true;
> >  }
> > @@ -1249,7 +1274,7 @@ static int ice_alloc_vfs(struct ice_pf *pf, u16
> > num_alloc_vfs)
> >  	/* Disable global interrupt 0 so we don't try to handle the VFLR. */
> >  	wr32(hw, GLINT_DYN_CTL(pf->oicr_idx),
> >  	     ICE_ITR_NONE << GLINT_DYN_CTL_ITR_INDX_S);
> > -
> > +	set_bit(__ICE_OICR_INTR_DIS, pf->state);
> >  	ice_flush(hw);
> >
> >  	ret = pci_enable_sriov(pf->pdev, num_alloc_vfs); @@ -1278,13
> > +1303,13 @@ static int ice_alloc_vfs(struct ice_pf *pf, u16
> > num_alloc_vfs)
> >  	}
> >  	pf->num_alloc_vfs = num_alloc_vfs;
> >
> > -	/* VF resources get allocated during reset */
> > -	if (!ice_reset_all_vfs(pf, true)) {
> > +	/* VF resources get allocated with initialization */
> > +	if (!ice_config_res_vfs(pf)) {
> >  		ret = -EIO;
> >  		goto err_unroll_sriov;
> >  	}
> >
> > -	goto err_unroll_intr;
> > +	return ret;
> >
> >  err_unroll_sriov:
> >  	pf->vf = NULL;
> > @@ -1296,6 +1321,7 @@ static int ice_alloc_vfs(struct ice_pf *pf, u16
> > num_alloc_vfs)
> >  err_unroll_intr:
> >  	/* rearm interrupts here */
> >  	ice_irq_dynamic_ena(hw, NULL, NULL);
> > +	clear_bit(__ICE_OICR_INTR_DIS, pf->state);
> >  	return ret;
> >  }
> >
> > --
> > 2.20.1
> >
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
