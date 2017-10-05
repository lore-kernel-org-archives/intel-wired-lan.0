From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 5 Oct 2017 23:25:43 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 04/11] i40e/i40evf: always
 set the CLEARPBA flag when re-enabling interrupts
In-Reply-To: <20171005160129.0000606a@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
 <20170907120556.45699-4-alice.michael@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA0C8@ORSMSX104.amr.corp.intel.com>
 <1507228314.2098.53.camel@intel.com>
 <02874ECE860811409154E81DA85FBB5882ABC495@ORSMSX115.amr.corp.intel.com>
 <20171005160129.0000606a@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5882ABC937@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Brandeburg, Jesse
> Sent: Thursday, October 05, 2017 4:01 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Duyck, Alexander H <alexander.h.duyck@intel.com>; intel-wired-
> lan at lists.osuosl.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Subject: Re: [Intel-wired-lan] [next PATCH S80-V3 04/11] i40e/i40evf: always set
> the CLEARPBA flag when re-enabling interrupts
> 
> On Thu, 5 Oct 2017 22:24:19 +0000
> "Keller, Jacob E" <jacob.e.keller@intel.com> wrote:
> 
> > > The original patch was more aggressive than it needed to be. For
> > > example you could probably go ahead and clear the PBA in the
> > > i40e_intr()q interrupt routine itself since all it is doing is
> > > scheduling the polling routine which will run after the interrupt
> > > routine has completed. You shouldn't be clearing the PBA at the end of
> > > NAPI poll unless you know you are not going to be exiting polling.
> > >
> > > I hope this helps to clarify things.
> > >
> > > - Alex
> >
> > Ok so only clear it if we're continuing to poll. I'll cook up a patch for that.
> 
> Hi Jake, we may just need to cook up a better test for this instead of
> generating further patches.  I believe based on updated understanding
> of the hardware functionality that this patch is correct, but it is
> difficult to prove and we should probably spend more time doing the
> actual proof.
> 
> At least this patch follow the actual directions in the hardware
> manual, so I think we should stick with it.
> 
> Jesse

Ok. Lets continue the discussion in person to make sure everyone's on the same page and understanding.

I think I agree that we should keep this patch as is since it's based on the directions in our hardware manual.

Regards,
Jake
