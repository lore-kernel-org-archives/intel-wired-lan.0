From: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
Date: Tue, 26 Jul 2016 01:53:45 +0000
Subject: [Intel-wired-lan] [next PATCH S40 05/13] i40e: Increase minimum
 number of allocated VSI
In-Reply-To: <c78b8708-ef3c-3682-3182-f70b8669aa66@onemain.com>
References: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
 <1469488555-28187-6-git-send-email-bimmy.pujari@intel.com>
 <c78b8708-ef3c-3682-3182-f70b8669aa66@onemain.com>
Message-ID: <CFEEE81102D91947B9CC368106979EBA740FA575@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Shannon!

Sure, we might not need to mention VMDq for upstream, Linux patch - since VMDq is not supported.
Yes, original patch contains comment about 64 VFs, not sure how it got lost on the way here...  

Regards,
~Akeem

> -----Original Message-----
> From: Shannon Nelson [mailto:sln at onemain.com]
> Sent: Monday, July 25, 2016 4:47 PM
> To: Pujari, Bimmy <bimmy.pujari@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
> Subject: Re: [Intel-wired-lan] [next PATCH S40 05/13] i40e: Increase minimum
> number of allocated VSI
> 
> 
> 
> On 07/25/2016 04:15 PM, Bimmy Pujari wrote:
> > From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> >
> > This patch increases minimum number of allocated VSIs, so as to
> > resolve failure adding VSI for VF when 64-VFs assigned to a PF. The
> > driver supports up to 128 VFs per device, users can decide to enable
> > up to 64-VFs on a single PF, especially 2 X 40 devices. In that
> > scenario, with VMDq co-existence, there would be starvation of VSIs -
> > with this patch, supported features would have enough VSIs for configuration
> now.
> >
> > Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> > Change-ID: If084f4cd823667af8fe7fdc11489c705b32039d5
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> > b/drivers/net/ethernet/intel/i40e/i40e.h
> > index 2a88291..06e1835 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e.h
> > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> > @@ -74,7 +74,7 @@
> >   #define I40E_MIN_NUM_DESCRIPTORS      64
> >   #define I40E_MIN_MSIX                 2
> >   #define I40E_DEFAULT_NUM_VMDQ_VSI     8 /* max 256 VSIs */
> > -#define I40E_MIN_VSI_ALLOC            51 /* LAN, ATR, FCOE, 32 VF, 16 VMDQ
> */
> > +#define I40E_MIN_VSI_ALLOC            83 /* LAN, ATR, FCOE, 32 VF, 16 VMDQ
> */
> 
> You should update the comment here to reflect 64 VFs.
> 
> Since VMDq is not really supported, perhaps you can remove those 16 from this
> calculation?
> 
> sln
> 
> >   /* max 16 qps */
> >   #define i40e_default_queues_per_vmdq(pf) \
> >   		(((pf)->flags & I40E_FLAG_RSS_AQ_CAPABLE) ? 4 : 1)

