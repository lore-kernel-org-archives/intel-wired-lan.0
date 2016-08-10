From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 10 Aug 2016 20:08:13 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: napi polling routine must
 return actual work done
In-Reply-To: <02874ECE860811409154E81DA85FBB5857B4D6C3@ORSMSX115.amr.corp.intel.com>
References: <20160620173933.5638-1-jacob.e.keller@intel.com>
 <02874ECE860811409154E81DA85FBB5857B4D6C3@ORSMSX115.amr.corp.intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857B4D7B2@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Keller, Jacob E
> Sent: Wednesday, August 10, 2016 12:50 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; Duyck, Alexander H
> <alexander.h.duyck@intel.com>
> Cc: Paolo Abeni <pabeni@redhat.com>; Venkatesh Srinivas
> <venkateshs@google.com>
> Subject: Re: [Intel-wired-lan] [PATCH 1/2] fm10k: napi polling routine must
> return actual work done
> 
> 
> 
> > -----Original Message-----
> > From: Keller, Jacob E
> > Sent: Monday, June 20, 2016 10:40 AM
> > To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> > Cc: Keller, Jacob E <jacob.e.keller@intel.com>; Paolo Abeni
> > <pabeni@redhat.com>; Venkatesh Srinivas <venkateshs@google.com>;
> > Alexander Duyck <aduyck@mirantis.com>
> > Subject: [PATCH 1/2] fm10k: napi polling routine must return actual work
> > done
> >
> > When fm10k_poll fully cleans rings it returns 0. This is incorrect as it
> > messes up the budget accounting in the core napi code. Fix this by
> > returning actual work done, capped at budget - 1 since the core doesn't
> > expect a return of the full budget when the driver modifies the napi
> > status.
> >
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Venkatesh Srinivas <venkateshs@google.com>
> > Cc: Alexander Duyck <aduyck@mirantis.com>
> > ---
> >  drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > index 682a372bdb20..79d5093d83d1 100644
> > --- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > +++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > @@ -1484,7 +1484,7 @@ static int fm10k_poll(struct napi_struct *napi,
> int
> > budget)
> >  	/* re-enable the q_vector */
> >  	fm10k_qv_enable(q_vector);
> >
> > -	return 0;
> > +	return min(work_done, budget - 1);
> 
> 
> This patch potentially appears to be caused Tx hangs in the napi routines in
> the stack, when under heavy traffic pressure. It appears that other drivers
> (i40e, and ixgbe) don't do this either, so I am not sure which is correct...
> 

This patch is fine and should remain.

Thanks,
Jake

