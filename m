From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 26 Feb 2016 01:15:10 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: Avoid crashing the kernel
In-Reply-To: <1456449096.12253.11.camel@intel.com>
References: <1455668365-30782-1-git-send-email-jacob.e.keller@intel.com>
 <1455668365-30782-2-git-send-email-jacob.e.keller@intel.com>
 <EF50CC0C76A53A44BAD798C58E0A157E2734A923@ORSMSX103.amr.corp.intel.com>
 <804857E1F29AAC47BF68C404FC60A18490D70BBE@ORSMSX104.amr.corp.intel.com>
 <1456449096.12253.11.camel@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A18490D71299@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Keller, Jacob E
> Sent: Thursday, February 25, 2016 5:12 PM
> To: Singh, Krishneil K; Allan, Bruce W; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH 2/2] fm10k: Avoid crashing the kernel
> 
> On Thu, 2016-02-25 at 21:46 +0000, Allan, Bruce W wrote:
> > >
> > > -----Original Message-----
> > > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.
> > > org] On
> > > Behalf Of Singh, Krishneil K
> > > Sent: Thursday, February 25, 2016 12:27 PM
> > > To: Keller, Jacob E; Intel Wired LAN
> > > Subject: Re: [Intel-wired-lan] [PATCH 2/2] fm10k: Avoid crashing
> > > the kernel
> > >
> > >
> > > -----Original Message-----
> > > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.
> > > org] On
> > > Behalf Of Jacob Keller
> > > Sent: Tuesday, February 16, 2016 4:19 PM
> > > To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> > > Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: Avoid crashing the
> > > kernel
> > >
> > > Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a
> > > compile error rather than crash the kernel.
> > >
> > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > ---
> > > Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>
> > Please hold off on submitting this patch to netdev.
> 
> What's the reasoning here for holding submission?
> 
> Thanks,
> Jake

I want to look into this further.
