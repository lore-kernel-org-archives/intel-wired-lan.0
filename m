From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 22 Apr 2015 22:43:21 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix IOSF SB access issues
In-Reply-To: <1428706516.2729.126.camel@jtkirshe-mobl>
References: <20150410173626.9380.1335.stgit@mdrustad-wks.jf.intel.com>
 <1428706516.2729.126.camel@jtkirshe-mobl>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F8214BD@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Friday, April 10, 2015 3:55 PM
> To: Rustad, Mark D
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: Fix IOSF SB access issues
> 
> On Fri, 2015-04-10 at 10:36 -0700, Mark D Rustad wrote:
> > IOSF is the Intel On-chip System Fabric used in SOCs. IOSF SB is the
> > IOSF SideBand message interface. This patch serializes IOSF SB access
> > using both phy bits in the SWFW_SEMAPHORE register. It also adds a
> > helper function to wait for IOSF SB accesses to complete.
> > Use the new function to perform this wait before each access, as
> > specified in the datasheet, in addition to using it to wait for IOSF
> > SB read/write completion.
> >
> > Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> 
> Thanks Mark, I have applied your patch to my queue.
> --
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
