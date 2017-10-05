From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Thu, 5 Oct 2017 18:31:56 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 04/11] i40e/i40evf: always
 set	the CLEARPBA flag when re-enabling interrupts
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA0C8@ORSMSX104.amr.corp.intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
 <20170907120556.45699-4-alice.michael@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA0C8@ORSMSX104.amr.corp.intel.com>
Message-ID: <1507228314.2098.53.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2017-09-12 at 20:46 +0000, Bowers, AndrewX wrote:
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Alice Michael
> > Sent: Thursday, September 7, 2017 5:06 AM
> > To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> > lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [next PATCH S80-V3 04/11] i40e/i40evf: always set
> > the CLEARPBA flag when re-enabling interrupts
> > 
> > From: Jacob Keller <jacob.e.keller@intel.com>
> > 
> > In the past we changed driver behavior to not clear the PBA when re-
> > enabling interrupts. This change was motivated by the flawed belief that
> > clearing the PBA would cause a lost interrupt if a receive interrupt occurred
> > while interrupts were disabled.
> > 
> > According to empirical testing this isn't the case. Additionally, the data sheet
> > specifically says that we should set the CLEARPBA bit when re-enabling
> > interrupts in a polling setup.
> > 
> > This reverts commit 40d72a509862 ("i40e/i40evf: don't lose interrupts")
> > 
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e.h             |  5 +----
> >  drivers/net/ethernet/intel/i40e/i40e_main.c        | 11 +++++------
> >  drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  6 ++----
> >  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  2 +-
> >  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  4 +---
> >  5 files changed, 10 insertions(+), 18 deletions(-)
> 
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
> 

This patch just got pointed out to me in a hallway conversation.

I am pretty sure this _will_ cause you to lose interrupts. Specifically
you shouldn't be clearing the PBA bit at the end of the polling routine
unless you know you are going to poll again.

The PBA bit should only be cleared if:
1. You are at the start of your clean-up routine and want to clear it
in case any additional work has come in since the original vector
fired. (currently handled via an auto-clear function for MSI-X)
2. You are at the end of your polling routine and you know you are
going to be polling again.

The original patch was more aggressive than it needed to be. For
example you could probably go ahead and clear the PBA in the
i40e_intr()q interrupt routine itself since all it is doing is
scheduling the polling routine which will run after the interrupt
routine has completed. You shouldn't be clearing the PBA at the end of
NAPI poll unless you know you are not going to be exiting polling.

I hope this helps to clarify things.

- Alex
