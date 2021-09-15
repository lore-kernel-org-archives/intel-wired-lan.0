From: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>
Date: Wed, 15 Sep 2021 09:53:54 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] i40e: Avoid double IRQ free on
 error path in probe()
In-Reply-To: <MW4PR14MB47960CC778789EEE8E8A54EDA1DA9@MW4PR14MB4796.namprd14.prod.outlook.com>
References: <20210826221916.127243-1-pwaskiewicz@jumptrading.com>
 <50c21a769633c8efa07f49fc8b20fdfb544cf3c5.camel@intel.com>
 <20210831205831.GA115243@chidv-pwl1.w2k.jumptrading.com>
 <MW4PR14MB4796AE05A868B47FE4F6E12AA1D99@MW4PR14MB4796.namprd14.prod.outlook.com>
 <bebb58f34ed68025e95f8bc060af58a24333374b.camel@intel.com>
 <DM6PR11MB3371A3D1F314F3B8541FAF03E6DA9@DM6PR11MB3371.namprd11.prod.outlook.com>
 <MW4PR14MB47960CC778789EEE8E8A54EDA1DA9@MW4PR14MB4796.namprd14.prod.outlook.com>
Message-ID: <DM6PR11MB3371B4431AD7C46672C7E439E6DB9@DM6PR11MB3371.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello PJ

> -----Original Message-----
> From: PJ Waskiewicz <pwaskiewicz@jumptrading.com>
> Sent: Tuesday, September 14, 2021 11:41 PM
> To: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>
> Cc: davem at davemloft.net; pjwaskiewicz at gmail.com; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; netdev at vger.kernel.org; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; intel-wired-lan at lists.osuosl.org;
> Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: RE: [PATCH 1/1] i40e: Avoid double IRQ free on error path in probe()
> 
> Hi Sylwester,
> 
> > -----Original Message-----
> > From: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>
> > Sent: Tuesday, September 14, 2021 1:24 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; PJ Waskiewicz
> > <pwaskiewicz@jumptrading.com>
> > Cc: davem at davemloft.net; pjwaskiewicz at gmail.com; Fijalkowski, Maciej
> > <maciej.fijalkowski@intel.com>; Loktionov, Aleksandr
> > <aleksandr.loktionov@intel.com>; netdev at vger.kernel.org; Brandeburg,
> > Jesse <jesse.brandeburg@intel.com>; intel-wired-lan at lists.osuosl.org
> > Subject: RE: [PATCH 1/1] i40e: Avoid double IRQ free on error path in
> > probe()
> >
> 
> [snip]
> 
> > > > It's been 2 weeks since I replied.  Any update on this?  Maciej
> > > > had already reviewed the patch, so hoping we can just move along
> > > > with it, or get something else out soon?
> > > >
> > > > I'd really like this to not just fall into a void waiting for a
> > > > different patch when this fixes the issue.
> > >
> > > Hi PJ,
> > >
> > > I haven't seen a recent update on this. I'm asking for an update.
> > > Otherwise, Alex and Sylwester are on this thread; perhaps they have
> > > some info.
> > >
> > > Thanks,
> > > Tony
> > >
> >
> > Hello,
> >
> > The driver does not blindly try to free MSI-X vector twice here. This
> > is guarded by I40E_FLAG_MSIX_ENABLED and I40E_FLAG_MSI_ENABLED
> flags.
> > Only if those flags are set we will try to free MSI/MSI-X vectors in
> > i40e_reset_interrupt_capability(). Additionally
> > i40e_reset_interrupt_capability() clears those flags every time it is
> > called so even if we call it twice in a row the driver will not free
> > the vectors twice. I really can't see how this patch is fixing
> > anything as the issue here is not with MSI vectors but with misc IRQ
> > vectors. We have a proper patch for this ready in OOT and we will
> > upstream it soon. The problem here is that in
> > i40e_clear_interrupt_scheme() driver calls i40e_free_misc_vector() but
> > in case VSI setup fails misc vector is not allocated yet and we get a
> > call trace in free_irq that we are trying to free IRQ that has not been
> allocated yet.
> 
> That's fine.  I do see the guards for the queue vectors.  I saw them before.  The
> point is i40e_clear_interrupt_scheme() tries to free the MISC vector without
> guard, or without any check if it was allocated before.  In the error path, it tries
> to free it.  We get an oops for a double-free of an IRQ (also read: free an
> unallocated interrupt).
> 
> I know how this code works.  I wrote the original reset/clear interrupt scheme
> functions in ixgbe, and ported them to i40e when I wrote the initial driver.  We
> hit a problem in production, and I'm trying to patch it where we don't need to
> call clear_interrupt_scheme() if we fail to bring the main VSI online during
> probe.  I don't see why this needs to be a semantic discussion over how the
> vectors are freed.  We have a valid oops, still have it upstream.
> 
> I've also checked the OOT driver on SourceForge released in July.  It has the
> same problem:
> 
> static void i40e_clear_interrupt_scheme(struct i40e_pf *pf) {
>         int i;
> 
>         i40e_free_misc_vector(pf);
> 
>         i40e_put_lump(pf->irq_pile, pf->iwarp_base_vector,
>                       I40E_IWARP_IRQ_PILE_ID); [...]
> 
> I've also been told by some friends that no fix exists in internal git either.  So
> please, either propose a fix, ask me to change the patch, or merge it.  I'd really
> like to have our OS vendor be able to pick up this fix asap once it hits an
> upstream tree.
> 
> Cheers,
> -PJ Waskiewicz
> 

You are right the problem is with misc IRQ vector but as far as I can see this patch only moves i40e_reset_interrupt_capability() outside of i40e_clear_interrupt_scheme(). It does not fix the problem of i40e_free_misc_vector() on unallocated vector in error path. We have a proper fix for this that adds additional check for __I40E_MISC_IRQ_REQUESTED bit to i40e_free_misc_vector():

	if (pf->flags & I40E_FLAG_MSIX_ENABLED && pf->msix_entries &&
	    test_bit(__I40E_MISC_IRQ_REQUESTED, pf->state)) {

This bit is set only if misc vector was properly allocated. The patch will be on intel-wired soon.

> > Regards
> > Sylwester Dziedziuch
> >
> > > > -PJ
> > > >
> > > > ________________________________
> > > >
> > > > Note: This email is for the confidential use of the named
> > > > addressee(s) only and may contain proprietary, confidential, or
> > > > privileged information and/or personal data. If you are not the
> > > > intended recipient, you are hereby notified that any review,
> > > > dissemination, or copying of this email is strictly prohibited,
> > > > and requested to notify the sender immediately and destroy this
> > > > email and any attachments. Email transmission cannot be guaranteed
> > > > to be secure or error-free. The Company, therefore, does not make
> > > > any guarantees as to the completeness or accuracy of this email or
> > > > any
> > attachments.
> > > > This email is for informational purposes only and does not
> > > > constitute a recommendation, offer, request, or solicitation of
> > > > any kind to buy, sell, subscribe, redeem, or perform any type of
> > > > transaction of a financial product. Personal data, as defined by
> > > > applicable data protection and privacy laws, contained in this
> > > > email may be processed by the Company, and any of its affiliated
> > > > or related companies, for legal, compliance, and/or
> > > > business-related purposes. You may have rights regarding your
> > > > personal data; for information on exercising these rights or the
> > > > Company?s treatment of personal data, please email
> datarequests at jumptrading.com.
> 
> ________________________________
> 
> Note: This email is for the confidential use of the named addressee(s) only and
> may contain proprietary, confidential, or privileged information and/or
> personal data. If you are not the intended recipient, you are hereby notified
> that any review, dissemination, or copying of this email is strictly prohibited,
> and requested to notify the sender immediately and destroy this email and
> any attachments. Email transmission cannot be guaranteed to be secure or
> error-free. The Company, therefore, does not make any guarantees as to the
> completeness or accuracy of this email or any attachments. This email is for
> informational purposes only and does not constitute a recommendation, offer,
> request, or solicitation of any kind to buy, sell, subscribe, redeem, or perform
> any type of transaction of a financial product. Personal data, as defined by
> applicable data protection and privacy laws, contained in this email may be
> processed by the Company, and any of its affiliated or related companies, for
> legal, compliance, and/or business-related purposes. You may have rights
> regarding your personal data; for information on exercising these rights or the
> Company?s treatment of personal data, please email
> datarequests at jumptrading.com.
