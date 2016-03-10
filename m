From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Mar 2016 18:35:17 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v3] fm10k: Avoid crashing
 the	kernel
In-Reply-To: <804857E1F29AAC47BF68C404FC60A18490D8AC61@ORSMSX105.amr.corp.intel.com>
References: <20160309202557.137597.51678.stgit@bwallan-cwp1.jf.intel.com>
 <804857E1F29AAC47BF68C404FC60A18490D8AC61@ORSMSX105.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99CCBD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


No idea why this is the case, but with this patch applied I can't pass traffic over i40e devices. Revert the patch and I can pass traffic just fine. 

I don't know why it'd affect it though, I don't even have any fm10k devices in my system (I do have an ixgbe card) 

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Allan, Bruce W
> Sent: Wednesday, March 09, 2016 12:29 PM
> To: Allan, Bruce W <bruce.w.allan@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [next-queue PATCH v3] fm10k: Avoid crashing
> the kernel
> 
> > -----Original Message-----
> > From: Intel-wired-lan
> > [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Bruce
> > Allan
> > Sent: Wednesday, March 09, 2016 12:26 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [next-queue PATCH v3] fm10k: Avoid crashing
> > the kernel
> >
> > Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a
> > compile error rather than crash the kernel.
> >
> > Unfortunately, BUILD_BUG_ON() cannot be used to replace the second
> > instance of BUG_ON() as it will generate a compiletime assert when the
> > compiler flag -fsanitize=signed-integer-overflow is used (e.g. when
> > UBSAN is enabled).
> > Instead, put in additional checks to prevent buffer overflow from
> > occuring and WARN if the code is ever mistakenly changed to get
> > additional register values without also updating the value of
> FM10K_REGS_LEN_VSI.
> >
> > Also, replace associated magic numbers with existing defined constants
> > and correct an applicable comment.
> >
> > Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> > ---
> > v3: changes described in 2nd and 3rd paragraphs in updated description
> >  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |   22
> +++++++++++++-
> > --------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> This version supersedes Jake's patch with the same title (which is really a v2
> of the original one I sent) that is currently applied to next-queue/dev-queue.
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
