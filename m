From: Wang, Liang-min <liang-min.wang@intel.com>
Date: Wed, 12 Jun 2019 20:26:15 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: add control of skipping PF
 link-status check
In-Reply-To: <d96a913951ec3649171e9d5f1cf7ee8be9d41727.camel@intel.com>
References: <B6CB929FEBC10D4FAC4BCA7EF2298E259DD2F265@FMSMSX110.amr.corp.intel.com>
 <d96a913951ec3649171e9d5f1cf7ee8be9d41727.camel@intel.com>
Message-ID: <B6CB929FEBC10D4FAC4BCA7EF2298E259DD2F83C@FMSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

You ACK the patch, and that's why I manually added reviewed-by. 

Larry

> -----Original Message-----
> From: Kirsher, Jeffrey T
> Sent: Wednesday, June 12, 2019 4:24 PM
> To: Wang, Liang-min <liang-min.wang@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Guilherme Piccoli <gpiccoli@canonical.com>
> Subject: Re: [PATCH] ixgbevf: add control of skipping PF link-status check
> 
> On Tue, 2019-06-11 at 17:55 -0700, Wang, Liang-min wrote:
> > ixgbevf: add control of skipping PF link-status check
> >
> > The ixgbevf link status check always triggers an interrupt on Physical
> > Function (PF) driver because
> > it uses mailbox read to check PF link-status. For any Virtual Network
> > Function (VNF) implementation
> > where periodical link-status check is needed, this interrupt per request
> > becomes a significant
> > performance overhead. Therefore, this change uses the input parameter,
> > autoneg_wait_to_complete, to
> > conditionally skip the PF link-status check. For scenarios where only
> > quick Virtual Function (VF)
> > link status check is required, application could skip the PF interrupt by
> > setting autoneg_wait_to_complete
> > to "0". For cases where deep link status check (include both PF and VF
> > link status check) is required,
> > the application can set the autoneg_wait_to_complete to "1".
> >
> > Signed-off-by: Liang-Min Wang<liang-min.wang@intel.com>
> > Reviewed-by: Jeffrey T Kirsher<jeffrey.t.kirsher@intel.com>
> 
> Interesting, I know I did an initial review, but I do not remember adding
> my reviewed-by to this patch yet.  FYI, I never use my full legal name when
> signing any patch, which tells me you forged my Reviewed-by.
> 
> > ---
> > drivers/net/ethernet/intel/ixgbevf/vf.c | 10 ++++++++++
> > 1 file changed, 10 insertions(+)

