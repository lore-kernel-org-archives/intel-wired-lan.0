From: PJ Waskiewicz <pwaskiewicz@jumptrading.com>
Date: Sat, 18 Sep 2021 02:01:43 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] i40e: Avoid double IRQ free on
 error path in probe()
In-Reply-To: <DM6PR11MB3371B4431AD7C46672C7E439E6DB9@DM6PR11MB3371.namprd11.prod.outlook.com>
References: <20210826221916.127243-1-pwaskiewicz@jumptrading.com>
 <50c21a769633c8efa07f49fc8b20fdfb544cf3c5.camel@intel.com>
 <20210831205831.GA115243@chidv-pwl1.w2k.jumptrading.com>
 <MW4PR14MB4796AE05A868B47FE4F6E12AA1D99@MW4PR14MB4796.namprd14.prod.outlook.com>
 <bebb58f34ed68025e95f8bc060af58a24333374b.camel@intel.com>
 <DM6PR11MB3371A3D1F314F3B8541FAF03E6DA9@DM6PR11MB3371.namprd11.prod.outlook.com>
 <MW4PR14MB47960CC778789EEE8E8A54EDA1DA9@MW4PR14MB4796.namprd14.prod.outlook.com>
 <DM6PR11MB3371B4431AD7C46672C7E439E6DB9@DM6PR11MB3371.namprd11.prod.outlook.com>
Message-ID: <MW4PR14MB4796F279908B7E4D11622C66A1DE9@MW4PR14MB4796.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sylwester,

>
> You are right the problem is with misc IRQ vector but as far as I can see this
> patch only moves i40e_reset_interrupt_capability() outside of
> i40e_clear_interrupt_scheme(). It does not fix the problem of
> i40e_free_misc_vector() on unallocated vector in error path. We have a
> proper fix for this that adds additional check for
> __I40E_MISC_IRQ_REQUESTED bit to i40e_free_misc_vector():

It does fix the problem if you call the function when the MISC vector hasn't been allocated.  Yes, I moved reset_interrupt_capability() out so it could be separately called in the probe() error cleanup path.

>         if (pf->flags & I40E_FLAG_MSIX_ENABLED && pf->msix_entries &&
>             test_bit(__I40E_MISC_IRQ_REQUESTED, pf->state)) {
>
> This bit is set only if misc vector was properly allocated. The patch will be on
> intel-wired soon.

This isn't even in the OOT driver from SourceForge.  And even if you used that to guard freeing the vector or not, the first bit of that function is still writing to a register to disable that cause in the hardware:

static void i40e_free_misc_vector(struct i40e_pf *pf)
{
        /* Disable ICR 0 */
        wr32(&pf->hw, I40E_PFINT_ICR0_ENA, 0);
        i40e_flush(&pf->hw);

Would you still want to do that blindly if the vector wasn't allocated in the first place?  Seems excessive, but it'd be harmless.  Seems like not calling this function altogether would be cleaner and generate less MMIO activity if the MISC vector wasn't allocated at all and we're falling out of an error path...

I am really at a loss here.  This is clearly broken.  We have an Oops.  We get these occasionally on boot, and it's really annoying to deal with on production machines.  What is the definition of "soon" here for this new patch to show up?  My distro vendor would love to pull some sort of fix in so we can get it into our build images, and stop having this problem.  My patch fixes the immediate problem.  If you don't like the patch (which it appears you don't; that's fine), then stalling or saying a different fix is coming "soon" is really not a great support model.  This would be great to merge, and then if you want to make it "better" on your schedule, it's open source, and you can submit a patch.  Or I'll be happy to respin the patch, but still calling free_misc_vector() in an error path when the MISC vector was never allocated seems like a bad design decision to me.

-PJ

________________________________

Note: This email is for the confidential use of the named addressee(s) only and may contain proprietary, confidential, or privileged information and/or personal data. If you are not the intended recipient, you are hereby notified that any review, dissemination, or copying of this email is strictly prohibited, and requested to notify the sender immediately and destroy this email and any attachments. Email transmission cannot be guaranteed to be secure or error-free. The Company, therefore, does not make any guarantees as to the completeness or accuracy of this email or any attachments. This email is for informational purposes only and does not constitute a recommendation, offer, request, or solicitation of any kind to buy, sell, subscribe, redeem, or perform any type of transaction of a financial product. Personal data, as defined by applicable data protection and privacy laws, contained in this email may be processed by the Company, and any of its affiliated or related companies, for legal, compliance, and/or business-related purposes. You may have rights regarding your personal data; for information on exercising these rights or the Company?s treatment of personal data, please email datarequests at jumptrading.com.
