From: PJ Waskiewicz <pwaskiewicz@jumptrading.com>
Date: Mon, 13 Sep 2021 19:37:34 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] i40e: Avoid double IRQ free on
 error path in probe()
In-Reply-To: <20210831205831.GA115243@chidv-pwl1.w2k.jumptrading.com>
References: <20210826221916.127243-1-pwaskiewicz@jumptrading.com>
 <50c21a769633c8efa07f49fc8b20fdfb544cf3c5.camel@intel.com>
 <20210831205831.GA115243@chidv-pwl1.w2k.jumptrading.com>
Message-ID: <MW4PR14MB4796AE05A868B47FE4F6E12AA1D99@MW4PR14MB4796.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Tony,

> -----Original Message-----
> From: PJ Waskiewicz <pwaskiewicz@jumptrading.com>
> Sent: Tuesday, August 31, 2021 1:59 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; pjwaskiewicz at gmail.com; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Dziedziuch, SylwesterX
> <sylwesterx.dziedziuch@intel.com>; davem at davemloft.net; Brandeburg,
> Jesse <jesse.brandeburg@intel.com>; netdev at vger.kernel.org; PJ
> Waskiewicz <pwaskiewicz@jumptrading.com>
> Subject: Re: [PATCH 1/1] i40e: Avoid double IRQ free on error path in probe()
>
> On Mon, Aug 30, 2021 at 08:52:41PM +0000, Nguyen, Anthony L wrote:
> > On Thu, 2021-08-26 at 17:19 -0500, PJ Waskiewicz wrote:
> > > This fixes an error path condition when probe() fails due to the
> > > default VSI not being available or online yet in the firmware. If
> > > that happens, the previous teardown path would clear the interrupt
> > > scheme, which also freed the IRQs with the OS. Then the error path
> > > for the switch setup (pre-VSI) would attempt to free the OS IRQs as
> > > well.
> >
> > Hi PJ,
>
> Hi Tony,
>
> >
> > These comments are from the i40e team.
> >
> > Yes in case we fail and go to err_vsis label in i40e_probe() we will
> > call i40e_reset_interrupt_capability twice but this is not a problem.
> > This is because pci_disable_msi/pci_disable_msix will be called only
> > if appropriate flags are set on PF and if this function is called ones
> > it will clear those flags. So even if we call
> > i40e_reset_interrupt_capability twice we will not disable msi vectors
> > twice.
> >
> > The issue here is different however. It is failing in free_irq because
> > we are trying to free already free vector. This is because setup of
> > misc irq vectors in i40e_probe is done after i40e_setup_pf_switch. If
> > i40e_setup_pf_switch fails then we will jump to err_vsis and call
> > i40e_clear_interrupt_scheme which will try to free those misc irq
> > vectors which were not yet allocated. We should have the proper fix
> > for this ready soon.
>
> Yes, I'm aware of what's happening here and why it's failing. Sadly, I am
> pretty sure I wrote this code back in like 2011 or 2012, and being an error
> path, it hasn't really been tested.
>
> I don't really care how this gets fixed to be honest. We hit this in production
> when our LOM, for whatever reason, failed to initialize the internal switch on
> host boot. We escalated to our distro vendor, they did escalate to Intel, and
> it wasn't really prioritized. So I sent a patch that does fix the issue.
>
> If the team wants to respin this somehow, go ahead. But this does fix the
> immediate issue that when bailing out in probe() due to the main VSI not
> being online for whatever reason, the driver blindly attempts to clean up the
> misc MSI-X vector twice. This change fixes that behavior. I'd like this to not
> languish waiting for a different fix, since I'd like to point our distro vendor to
> this (or another) patch to cherry-pick, so we can get this into production.
> Otherwise our platform rollout hitting this problem is going to be quite
> bumpy, which is very much not ideal.

It's been 2 weeks since I replied.  Any update on this?  Maciej had already reviewed the patch, so hoping we can just move along with it, or get something else out soon?

I'd really like this to not just fall into a void waiting for a different patch when this fixes the issue.

-PJ

________________________________

Note: This email is for the confidential use of the named addressee(s) only and may contain proprietary, confidential, or privileged information and/or personal data. If you are not the intended recipient, you are hereby notified that any review, dissemination, or copying of this email is strictly prohibited, and requested to notify the sender immediately and destroy this email and any attachments. Email transmission cannot be guaranteed to be secure or error-free. The Company, therefore, does not make any guarantees as to the completeness or accuracy of this email or any attachments. This email is for informational purposes only and does not constitute a recommendation, offer, request, or solicitation of any kind to buy, sell, subscribe, redeem, or perform any type of transaction of a financial product. Personal data, as defined by applicable data protection and privacy laws, contained in this email may be processed by the Company, and any of its affiliated or related companies, for legal, compliance, and/or business-related purposes. You may have rights regarding your personal data; for information on exercising these rights or the Company?s treatment of personal data, please email datarequests at jumptrading.com.
