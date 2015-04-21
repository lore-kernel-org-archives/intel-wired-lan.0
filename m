From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Apr 2015 03:12:05 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Do not allow CRC stripping to
 be disabled on 82579 w/ jumbo frames
In-Reply-To: <1428548302.2729.9.camel@jtkirshe-mobl>
References: <20150409013554.3231.10427.stgit@ahduyck-vm-fedora22>
 <1428548302.2729.9.camel@jtkirshe-mobl>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DA68B4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, April 08, 2015 7:58 PM
> To: Alexander Duyck
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Do not allow CRC stripping
> to be disabled on 82579 w/ jumbo frames
> 
> On Wed, 2015-04-08 at 18:37 -0700, Alexander Duyck wrote:
> > The driver wasn't allowing jumbo frames to be enabled when CRC
> > stripping
> > was disabled, however it was allowing CRC stripping to be disabled
> > while
> > jumbo frames were enabled.  This fixes that by making it so that the
> > NETIF_F_RXFCS flag cannot be set when jumbo frames are enabled on
> > 82579 and
> > newer parts.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/e1000e/netdev.c |   14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> 
> Thanks Alex, I will add your patch to my queue.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

> --
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue
