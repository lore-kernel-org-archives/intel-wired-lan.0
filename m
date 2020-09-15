From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 15 Sep 2020 10:11:24 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 00/10] make
 drivers/net/ethernet W=1 clean
In-Reply-To: <a28498acdf87f11e81d3282d63f18dbe1a3d5329.camel@kernel.org>
References: <20200915014455.1232507-1-jesse.brandeburg@intel.com>
 <a28498acdf87f11e81d3282d63f18dbe1a3d5329.camel@kernel.org>
Message-ID: <20200915101124.00004146@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Saeed Mahameed wrote:
> Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>

Thanks! In all fairness, Jakub reviewed this in v1 too but I made enough
changes in v2 that I felt I had to drop the previous review ACKs.

> Hi Jesse, 
> What was the criteria to select which drivers to enable in your .config
> ?

As Jakub said, I'm using allmodconfig on x86_64, but just yesterday
discovered there was much more to fix because I ran the kernel-doc
script directly on the source (those other things come from different
ARCH= builds which limit allmodconfig)
 
> I think we need some automation here and have a well known .config that
> enables as many drivers as we can for static + compilation testing,
> otherwise we are going to need to repeat this patch every 2-3 months.

Totally agree! Jakub already has some cobbled together and is regularly
running W=1 C=1 builds on all new patches. I found I could cross compile
different ARCH targets to get (some of) the other warnings, or better
yet just run the scripts/kernel-doc script directly in automation.
 
> I know Jakub and Dave do some compilation testing before merging but i
> don't know how much driver coverage they have and if they use a
> specific .config or they just manually create one on demand..
> 
> bottom line, we need a bot after this series is applied.
> All we need is to daily apply all ongoing patches to some testing
> branch and let 0-DAY kernel test [1] run on it with whatever make
> command we define and with all drivers enabled.

Yes, that's the end goal and I think this moves us closer to that. A
little more work remains before we go and turn all warnings on - as
Andrew suggested in another reply. (it's also sometimes a losing game
fighting against many compiler versions, etc).  However, the zero-day
bot reporting more results from W=1 compiles would *really* help (I
looked at , but am having some troubles verifying that)

> [1] https://lists.01.org/pipermail/kbuild-all 
> 
> > ---
> > 
> > Q: Maybe I can fix the remaining warnings in a followup patch? If
> > I try to put it on this series it will make it much larger
> > (double).
