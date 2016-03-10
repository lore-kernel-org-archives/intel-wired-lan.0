From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 10 Mar 2016 00:19:45 +0000
Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: update driver	summary	and
 reduce code duplication
In-Reply-To: <804857E1F29AAC47BF68C404FC60A18490D8B06D@ORSMSX105.amr.corp.intel.com>
References: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
 <1455144351-14758-4-git-send-email-jacob.e.keller@intel.com>
 <EF50CC0C76A53A44BAD798C58E0A157E2734A972@ORSMSX103.amr.corp.intel.com>
 <804857E1F29AAC47BF68C404FC60A18490D70BA6@ORSMSX104.amr.corp.intel.com>
 <804857E1F29AAC47BF68C404FC60A18490D8B06D@ORSMSX105.amr.corp.intel.com>
Message-ID: <1457569185.5545.7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-03-09 at 23:51 +0000, Allan, Bruce W wrote:
> > 
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.
> > org] On
> > Behalf Of Allan, Bruce W
> > Sent: Thursday, February 25, 2016 1:46 PM
> > To: Singh, Krishneil K <krishneil.k.singh@intel.com>; Keller, Jacob
> > E
> > <jacob.e.keller@intel.com>; Intel Wired LAN <intel-wired-
> > lan at lists.osuosl.org>
> > Subject: Re: [Intel-wired-lan] [PATCH 4/6] fm10k: update driver
> > summary
> > and reduce code duplication
> > 
> > > 
> > > -----Original Message-----
> > > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuos
> > > l.org]
> > On
> > > 
> > > Behalf Of Singh, Krishneil K
> > > Sent: Thursday, February 25, 2016 12:30 PM
> > > To: Keller, Jacob E; Intel Wired LAN
> > > Subject: Re: [Intel-wired-lan] [PATCH 4/6] fm10k: update driver
> > > summary
> > > and reduce code duplication
> > > 
> > > -----Original Message-----
> > > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuos
> > > l.org]
> > On
> > > 
> > > Behalf Of Jacob Keller
> > > Sent: Wednesday, February 10, 2016 2:46 PM
> > > To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> > > Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: update driver
> > > summary and
> > > reduce code duplication
> > > 
> > > Use DRV_SUMMARY, similar to DRV_VERSION so that we don't have to
> > > duplicate the driver summary. Also update summary to more
> > > accurately
> > > describe the driver.
> > > 
> > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > ---
> > > Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>
> > Please hold off on submitting this patch to netdev...the driver
> > summary
> > might not be
> > correct based on recent events.
> The driver summary/module description should not be changed to what
> is in this
> patch.??Expect a v2 from Jake.
> 
> Bruce.

Isn't there a replacement in the queue already? I'll rework this if so,
but I was pretty sure I already did.

Thanks,
Jake
