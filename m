From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 14 Apr 2016 23:25:25 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/2] e1000e: Fix ptp time reset on
 network interruption
In-Reply-To: <20160414224237.GA18429@hobbes.lan20.walshnetwork.net>
References: <1455662685-7231-1-git-send-email-brian@walsh.ws>
 <e943a9f336c2dd089fdc6c1dafbf768bc0983075.1460517387.git.brian@walsh.ws>
 <309B89C4C689E141A5FF6A0C5FB2118B81EEC4DE@ORSMSX101.amr.corp.intel.com>
 <20160414150844.GA29391@hobbes.lan20.walshnetwork.net>
 <1460658069.28210.1.camel@intel.com>
 <20160414224237.GA18429@hobbes.lan20.walshnetwork.net>
Message-ID: <1460676325.28210.18.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-04-14 at 18:42 -0400, Brian Walsh wrote:
> On Thu, Apr 14, 2016 at 06:21:09PM +0000, Keller, Jacob E wrote:
> > 
> > On Thu, 2016-04-14 at 11:08 -0400, Brian Walsh wrote:
> > > 
> > > On Thu, Apr 14, 2016 at 03:11:45AM +0000, Brown, Aaron F wrote:
> > > > 
> > > > 
> > > > > 
> > > > > 
> > > > > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.o
> > > > > suos
> > > > > l.org] On
> > > > > Behalf Of Brian Walsh
> > > > > Sent: Tuesday, April 12, 2016 8:23 PM
> > > > > To: intel-wired-lan at lists.osuosl.org
> > > > > Subject: [Intel-wired-lan] [PATCH v2 2/2] e1000e: Fix ptp
> > > > > time
> > > > > reset on
> > > > > network interruption
> > > > > 
> > > > > Time is resetting on any interruption of network
> > > > > connectivity.
> > > > > This
> > > > > causes the clock to jump around by the leapsecond offset. It
> > > > > should
> > > > > only reset when the device is initialized.
> > > > > 
> > > > > Signed-off-by: Brian Walsh <brian@walsh.ws>
> > > > > ---
> > > > > ?drivers/net/ethernet/intel/e1000e/netdev.c | 22 +++++++++++-
> > > > > ----
> > > > > ------
> > > > > ?1 file changed, 11 insertions(+), 11 deletions(-)
> > > > > 
> > > > This patch introduces a Call Trace and panic for me on a
> > > > handful of
> > > > regression systems.??I am usually seeing this on the e1000e
> > > > driver
> > > > load, but on one system when just under traffic stress.??It
> > > > seems
> > > > to show up mostly on older hardware, the trace has been spotted
> > > > on
> > > > a system with a 82573 LOM, another system with a pair of
> > > > 80003ES2LAN controller's and an add in 82572.??The following
> > > > trace
> > > > is taken via a serial console from a system with an 82574L and
> > > > 82579L LOM on the board after the system had been running
> > > > randomish
> > > > netperf traffic for an hour or so.??The trace on driver load is
> > > > similar to the first call trace of this series, but generally
> > > > did
> > > > not recover enough to get the follow along messages:
> > > > 
> > > This patch seems to be causing issues on other systems. I am
> > > running
> > > it
> > > on about 30 units with all the same card. I also have linuxptp
> > > running
> > > at the same time.
> > > 
> > > Would there be some other way to address the problem that I am
> > > trying
> > > to fix with this patch?
> > > 
> > > Basically if the network connection between the device and the
> > > 1588
> > > clock is interrupted for a period of time the hardware clock was
> > > switching from being on TAI time to thinking that the time is now
> > > UTC
> > > time. This causes the system time to fluctuate by the leapsecond
> > > offset.
> > > 
> > > I was able to reproduce this problem with a 1588 clock source
> > > using
> > > ipv4
> > > udp by temporarily dropping udp traffic on ports 319 and 320
> > > through
> > > iptables.
> > > 
> > > Moving the the clock reset to only in initialization fixed the
> > > problem
> > > for me.
> > > 
> > > Brian
> > Moving the clock reset to initialization seems like the correct
> > behavior to me.
> > 
> > Thanks,
> > Jake
> It looks like reseting the System Time Register SYSTIM base frequency
> has to occur. That is why the divide zero error is happening. The
> timecounter_init should not need to be reset anywhere other than
> initialization.
> 
> I will put together another patch and test it on my equipment and see
> if
> that does any better.
> 
> Brian
> 

I have a patch, I will send you momentarily which should resolve your
issue.

timecounter_init must occur during reset because the hardware SYSTIME
register will have been reset. However, it does NOT need to occur
during the SIOCSHWTSTAMP ioctl as it does now. I have a proposed fix,
if you could test, that would be great.

Thanks,
Jake
