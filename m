From: PJ Waskiewicz <pwaskiewicz@jumptrading.com>
Date: Thu, 26 Aug 2021 14:26:41 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] i40e: Avoid double IRQ free on
 error path in probe()
In-Reply-To: <20210826080349.GA32032@ranger.igk.intel.com>
References: <20210825192321.32784-1-pwaskiewicz@jumptrading.com>
 <20210826080349.GA32032@ranger.igk.intel.com>
Message-ID: <MW4PR14MB47964089AAC74D802220F462A1C79@MW4PR14MB4796.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Sent: Thursday, August 26, 2021 1:04 AM
> To: PJ Waskiewicz <pwaskiewicz@jumptrading.com>
> Cc: David S . Miller <davem@davemloft.net>; Jesse Brandeburg
> <jesse.brandeburg@intel.com>; netdev at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; PJ Waskiewicz <pjwaskiewicz@gmail.com>
> Subject: Re: [PATCH 1/1] i40e: Avoid double IRQ free on error path in probe()
>
> This message has originated from an EXTERNAL SENDER
>
> On Wed, Aug 25, 2021 at 02:23:21PM -0500, PJ Waskiewicz wrote:
> > This fixes an error path condition when probe() fails due to the
> > default VSI not being available or online yet in the firmware. If that
> > happens, the previous teardown path would clear the interrupt scheme,
> > which also freed the IRQs with the OS. Then the error path for the
> > switch setup (pre-VSI) would attempt to free the OS IRQs as well.
>
> Nice to hear from you PJ.
> Looks like a 'net' candidate, so we need a Fixes: tag.

Likewise, nice to be submitting patches again.

I'll respin and send to net.

> Also, you probably should send it to iwl with cc to netdev and Tony will pick
> and combine it into his pull request.

Roger that, I'll rearrange the To: and Cc: members.

> Patch LGTM.
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Thanks.

[...snip...]

> > @@ -4865,7 +4865,8 @@ static void i40e_reset_interrupt_capability(struct
> i40e_pf *pf)
> >   * @pf: board private structure
> >   *
> >   * We go through and clear interrupt specific resources and reset the
> > structure
> > - * to pre-load conditions
> > + * to pre-load conditions.  OS interrupt teardown must be done
> > + separately due
> > + * to VSI vs. PF instantiation, and different teardown path requirements.
>
> Small nit: no need for a dot in 'vs.' ?

Apparently this is different between British English and American English (no dot in the former).  Who would have thought...I'll update and drop the '.'.

> >   **/
> >  static void i40e_clear_interrupt_scheme(struct i40e_pf *pf)  { @@
> > -4880,7 +4881,6 @@ static void i40e_clear_interrupt_scheme(struct
> i40e_pf *pf)
> >         for (i = 0; i < pf->num_alloc_vsi; i++)
> >                 if (pf->vsi[i])
> >                         i40e_vsi_free_q_vectors(pf->vsi[i]);
> > -       i40e_reset_interrupt_capability(pf);
> >  }
> >
> >  /**
> > @@ -10526,6 +10526,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool
> reinit, bool lock_acquired)
> >                          */
> >                         free_irq(pf->pdev->irq, pf);
> >                         i40e_clear_interrupt_scheme(pf);
> > +                       i40e_reset_interrupt_capability(pf);
> >                         if (i40e_restore_interrupt_scheme(pf))
> >                                 goto end_unlock;
> >                 }
> > @@ -15928,6 +15929,7 @@ static void i40e_remove(struct pci_dev *pdev)
> >         /* Clear all dynamic memory lists of rings, q_vectors, and VSIs */
> >         rtnl_lock();
> >         i40e_clear_interrupt_scheme(pf);
> > +       i40e_reset_interrupt_capability(pf);
> >         for (i = 0; i < pf->num_alloc_vsi; i++) {
> >                 if (pf->vsi[i]) {
> >                         if (!test_bit(__I40E_RECOVERY_MODE,
> > pf->state)) @@ -16150,6 +16152,7 @@ static void i40e_shutdown(struct
> pci_dev *pdev)
> >          */
> >         rtnl_lock();
> >         i40e_clear_interrupt_scheme(pf);
> > +       i40e_reset_interrupt_capability(pf);
> >         rtnl_unlock();
> >
> >         if (system_state == SYSTEM_POWER_OFF) { @@ -16202,6 +16205,7
> > @@ static int __maybe_unused i40e_suspend(struct device *dev)
> >          * to CPU0.
> >          */
> >         i40e_clear_interrupt_scheme(pf);
> > +       i40e_reset_interrupt_capability(pf);
> >
> >         rtnl_unlock();
> >
> > --
> > 2.27.0
> >
> >
>
> And probably talk to your IT dep to get rid of the footer :P

I know, that is something I've been working on.  Not sure I have much control over that unfortunately.

-PJ

> > ________________________________
> >
> > Note: This email is for the confidential use of the named addressee(s) only
> and may contain proprietary, confidential, or privileged information and/or
> personal data. If you are not the intended recipient, you are hereby notified
> that any review, dissemination, or copying of this email is strictly prohibited,
> and requested to notify the sender immediately and destroy this email and
> any attachments. Email transmission cannot be guaranteed to be secure or
> error-free. The Company, therefore, does not make any guarantees as to
> the completeness or accuracy of this email or any attachments. This email is
> for informational purposes only and does not constitute a recommendation,
> offer, request, or solicitation of any kind to buy, sell, subscribe, redeem, or
> perform any type of transaction of a financial product. Personal data, as
> defined by applicable data protection and privacy laws, contained in this
> email may be processed by the Company, and any of its affiliated or related
> companies, for legal, compliance, and/or business-related purposes. You
> may have rights regarding your personal data; for information on exercising
> these rights or the Company?s treatment of personal data, please email
> datarequests at jumptrading.com.

________________________________

Note: This email is for the confidential use of the named addressee(s) only and may contain proprietary, confidential, or privileged information and/or personal data. If you are not the intended recipient, you are hereby notified that any review, dissemination, or copying of this email is strictly prohibited, and requested to notify the sender immediately and destroy this email and any attachments. Email transmission cannot be guaranteed to be secure or error-free. The Company, therefore, does not make any guarantees as to the completeness or accuracy of this email or any attachments. This email is for informational purposes only and does not constitute a recommendation, offer, request, or solicitation of any kind to buy, sell, subscribe, redeem, or perform any type of transaction of a financial product. Personal data, as defined by applicable data protection and privacy laws, contained in this email may be processed by the Company, and any of its affiliated or related companies, for legal, compliance, and/or business-related purposes. You may have rights regarding your personal data; for information on exercising these rights or the Company?s treatment of personal data, please email datarequests at jumptrading.com.
