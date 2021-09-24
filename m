From: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>
Date: Fri, 24 Sep 2021 07:04:11 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] i40e: Avoid double IRQ free on
 error path in probe()
In-Reply-To: <MW4PR14MB479687DDEC1EB0C4AA5F5CF1A1A39@MW4PR14MB4796.namprd14.prod.outlook.com>
References: <20210826221916.127243-1-pwaskiewicz@jumptrading.com>
 <50c21a769633c8efa07f49fc8b20fdfb544cf3c5.camel@intel.com>
 <20210831205831.GA115243@chidv-pwl1.w2k.jumptrading.com>
 <MW4PR14MB4796AE05A868B47FE4F6E12AA1D99@MW4PR14MB4796.namprd14.prod.outlook.com>
 <bebb58f34ed68025e95f8bc060af58a24333374b.camel@intel.com>
 <DM6PR11MB3371A3D1F314F3B8541FAF03E6DA9@DM6PR11MB3371.namprd11.prod.outlook.com>
 <MW4PR14MB47960CC778789EEE8E8A54EDA1DA9@MW4PR14MB4796.namprd14.prod.outlook.com>
 <DM6PR11MB3371B4431AD7C46672C7E439E6DB9@DM6PR11MB3371.namprd11.prod.outlook.com>
 <MW4PR14MB4796F279908B7E4D11622C66A1DE9@MW4PR14MB4796.namprd14.prod.outlook.com>
 <DM6PR11MB3371A285032A583A73BA62E0E6A09@DM6PR11MB3371.namprd11.prod.outlook.com>
 <MW4PR14MB47967810D43031FF8C4C2265A1A19@MW4PR14MB4796.namprd14.prod.outlook.com>
 <MW4PR14MB479687DDEC1EB0C4AA5F5CF1A1A39@MW4PR14MB4796.namprd14.prod.outlook.com>
Message-ID: <DM6PR11MB33714CF524A9F210152A9221E6A49@DM6PR11MB3371.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello PJ,

Sorry for the late response. I am applying your suggestions to the patch. The updated version will be on IWL in a moment.

> -----Original Message-----
> From: PJ Waskiewicz <pwaskiewicz@jumptrading.com>
> Sent: Thursday, September 23, 2021 5:17 PM
> To: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>
> Cc: davem at davemloft.net; pjwaskiewicz at gmail.com; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; netdev at vger.kernel.org; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; intel-wired-lan at lists.osuosl.org;
> Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: RE: [PATCH 1/1] i40e: Avoid double IRQ free on error path in probe()
> 
> > > Hello PJ,
> >
> > Hello,
> 
> Hi Tony and Sylwester,
> 
> Any updates/comments on my reply from a few days ago on this?
> 
> -PJ
> 
> > >
> > > > static void i40e_free_misc_vector(struct i40e_pf *pf) {
> > > >         /* Disable ICR 0 */
> > > >         wr32(&pf->hw, I40E_PFINT_ICR0_ENA, 0);
> > > >         i40e_flush(&pf->hw);
> > > >
> > > > Would you still want to do that blindly if the vector wasn't
> > > > allocated in the first place?  Seems excessive, but it'd be
> > > > harmless.  Seems like not calling this function altogether would
> > > > be cleaner and generate less MMIO activity if the MISC vector
> > > > wasn't allocated at all and
> > > we're falling out of an error path...
> > > >
> > > > I am really at a loss here.  This is clearly broken.  We have an Oops.
> > > > We get these occasionally on boot, and it's really annoying to
> > > > deal with on production machines.  What is the definition of
> > > > "soon" here for this new patch to show up?  My distro vendor would
> > > > love to pull some sort of fix in so we can get it into our build
> > > > images, and stop having this problem.  My patch fixes the
> > > > immediate problem.  If you don't like the patch (which it appears
> > > > you don't; that's fine), then stalling or saying a different fix
> > > > is coming "soon" is really not a great support model.  This would
> > > > be great to merge, and then if you want to make it "better" on
> > > > your schedule, it's open source, and you can submit a patch.  Or
> > > > I'll be happy to respin the patch, but still calling
> > > > free_misc_vector() in an error path when the MISC vector was
> > > never allocated seems like a bad design decision to me.
> > > >
> > > > -PJ
> > >
> > > I totally agree that we shouldn?t call free_misc_vector if misc
> > > vector wasn't allocated yet but to me this is not what your patch is doing.
> > > free_misc_vector() is called in clear_interrupt_scheme not
> > > reset_interrupt_capability(). In your patch clear_interrupt_scheme()
> > > will still be called when pf switch setup fails in i40e_probe() and
> > > it will still call free_misc_vector on unallocated misc IRQ. Other
> > > proper way to fix this would be moving free_misc_vector() out of
> > > clear_interrupt_scheme() and calling it separately when misc vector
> > > was really allocated. As for the hw register being written in our
> > > patch as you said it's harmless. The patch we've prepared should be
> > > on iwl
> > today.
> > >
> >
> > Ok, I see the patch on IWL....let's discuss....
> >
> > Just above, I pointed out that if the MISC vector hasn't been
> > allocated at all, then we don't want to call free_misc_vector() at
> > all.  That would also mean the suggestion to check the atomic state
> > bit to avoid the actual free would
> > *still* have the code call free_misc_vector(), and only skip the
> > actual free (after doing an unnecessary MMIO write and then read to
> > flush).  I pointed out that wouldn't be ideal, and you, just above,
> > agreed.  Yet, the fix you guys submitted to IWL does exactly that.  So
> > are we just saying things to bury this thread and hope it goes away, or just
> willfully not doing what we agreed on?
> > It's pretty disheartening to consider feedback, agree to it, then
> > completely ignore it.  That's not how open source works...
> >
> > Also, regardless how you guys want the code to work, it's usually good
> > form to include a "Reported-by:" in a patch if you're deciding not to
> > take a proposed patch.  It's even better form to include the Oops that
> > was reported in the first patch, since that makes things like
> > ${SEARCH_ENGINE} work for people running into the same issue have a
> > chance to find a solution.  Not doing either of these when someone
> > else has done work to identify an issue, test a fix, and propose it,
> > is not a good way to attract more people to work on this driver in the future.
> >
> > If we wanted to do something where free_misc_vector() isn't called if
> > the state flag isn't set, then why not something like this, which
> > would keep in the spirit of what we agreed on above:
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index 1d1f52756a93..a40193bcc7b7 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -4868,7 +4868,9 @@ static void i40e_clear_interrupt_scheme(struct
> > i40e_pf *pf)  {
> >         int i;
> >
> > -       i40e_free_misc_vector(pf);
> > +       /* Only attempt to free the misc vector if it's already allocated */
> > +       if (test_bit(__I40E_MISC_IRQ_REQUESTED, pf->state))
> > +               i40e_free_misc_vector(pf);
> >
> >         i40e_put_lump(pf->irq_pile, pf->iwarp_base_vector,
> >                       I40E_IWARP_IRQ_PILE_ID);
> >
> > -PJ
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
