From: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
Date: Tue, 8 Dec 2020 12:51:12 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: allow controlling PTP
 external clock features
In-Reply-To: <20201123134934.GA6202@ranger.igk.intel.com>
References: <20201123134656.14911-1-mateusz.palczewski@intel.com>
 <20201123134934.GA6202@ranger.igk.intel.com>
Message-ID: <DM6PR11MB4610B15B372E2B5AB299936EF3CD0@DM6PR11MB4610.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Mon, Nov 23, 2020 at 01:46:56PM +0000, Mateusz Palczewski wrote:
> > From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> > 
> > Provide information what functions are supported by PTP pins and allow 
> > controlling them.
> > Implemented in i40e_ptp_verify() and i40e_pps_configure().
> > Previously it was not possible to control PTP external clock features.
> 
> Why you target that to 'net' tree? it's not a bug fix if you ask me, but a feature implementation.
Thank you for review.
It is intended to go to 'net' tree as all patches related to i40e driver. Isn't it appropriate approach ?
> 
> > 
> > Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c 
> > b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > index 26f583f..6182d42 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > @@ -241,7 +241,15 @@ static void i40_ptp_reset_timing_events(struct 
> > i40e_pf *pf)  static int i40e_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
> >  			   enum ptp_pin_function func, unsigned int chan)
> 
> I don't see i40e_ptp_verify in the upstream code. Am I missing something?
There is another patch "i40e: add support for PTP external synchronization clock" being reviewed on intel-wired-lan. It was posted some time ago.
> 
> It also looks to me that you only make use of 1 out of 4 functions args.
> This will produce compiler warnings.
It depends on compiler options. I cannot see any warnings on my (default) setup. The interface is fixed and just not all arguments are needed. Other drivers use this similarly.
> 
> >  {
> > -	/* TODO: implement pin checking */
> > +	switch (func) {
> > +	case PTP_PF_NONE:
> > +	case PTP_PF_EXTTS:
> > +	case PTP_PF_PEROUT:
> > +		break;
> > +	case PTP_PF_PHYSYNC:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -486,7 +494,11 @@ static int i40e_pps_configure(struct ptp_clock_info *ptp,
> >  			      struct ptp_clock_request *rq,
> >  			      int on)
> >  {
> 
> Again, 'rq' is unused. Also it looks like it could return void.
For 'rq' please see my comment above.
Please be more detailed about 'returning void' scenario - I cannot see this.
> 
> > -	/* TODO: implement PPS events */
> > +	struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
> > +
> > +	if (!!on)
> > +		i40e_ptp_set_1pps_signal_hw(pf);
> > +
> >  	return 0;
> >  }

Best Regards,
Piotr
