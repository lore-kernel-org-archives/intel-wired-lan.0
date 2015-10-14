From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 14 Oct 2015 23:44:11 +0000
Subject: [Intel-wired-lan] [next-queue 15/17] fm10k: change default Tx
 ITR to 25usec
In-Reply-To: <561EE4C8.9060502@gmail.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-15-git-send-email-jacob.e.keller@intel.com>
 <561E7195.2010605@gmail.com> <1444838391.26286.11.camel@intel.com>
 <561E8176.8050803@gmail.com> <1444845432.26286.29.camel@intel.com>
 <561EE4C8.9060502@gmail.com>
Message-ID: <1444866251.26286.54.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-10-14 at 16:27 -0700, Alexander Duyck wrote:
> Sounds reasonable.  With TCP loss can also play a huge factor,
> although 
> I would assume you probably have no dropped packets correct?
> 

No drops for UDP, but with TCP I see drops on the receiving partner...
no more than about 200 total though.

> > I've been getting pretty inconsistent performance results over the
> > last
> > few tests.
> > 
> > I tried these tests with interrupt moderation disabled completely
> > and I
> > generally got less performance.
> 
> Completely disabling it will usually do that.  The problem is the
> rates 
> for 50Gbs are insane.  You are looking at 4Mpps even with 1514 byte
> packets.

Ok that makes sense, yea. Too much wakeup causes us to waste a lot.

> 
> > Interestingly, I just set both rx and tx to 10, and got one test
> > through to report 39Gb/s... But I am definitely not able to
> > consistently hit this value.
> 
> The 10us range should be excessive.  I would expect you would see the
> best performance right around the amount of time it should take to 
> almost fill the ring or socket buffers without actually ever filling 
> them.  Basically it is a game of get as close as you can without
> going 
> over in order to get the fewest interrupts possible.
> 

I am not sure what is best, but 10 so far as been I will try a few
others...

> > I generally seem to range pretty wide over tests.
> 
> CPU affinity along with everything else can always make these kind of
> tests pretty messy.  I'm assuming you have power management also 
> disabled?  If not that could also cause some pretty wide swings due
> to 
> processor C states and P states.
> 
> > For UDP I used:
> > 
> > ./netperf -T0,5 -t UDP_STREAM -f m -c -C  -H 192.168.21.2 -- -m 64k
> > 
> > For this test, I see 80% CPU utilization on the sender, and 50% on
> > the
> > receiver, when bound as above.
> > 
> > I seem to get ~16Gb/s send and receive here, with no variance...
> 
> The fact that there is no variance likely means something is 
> bottlenecking this somewhere early on in the Tx.
> 
> > I suspect part of this is due to the fact that TCP can do hardware
> > TSO,
> > which we don't have in UDP? I'm not sure here..
> 
> TCP will also allow you to have significantly more data in flight in 
> many cases.  UDP is normally confined to a fairly small window.
> 

Makes sense.

> > UDP is significantly more stable than TCP was. but it doesn't seem
> > to
> > ever go above 16Gb/s for a single stream.
> 
> I'd be interested in seeing the actual numbers.  I know for some 
> UDP_STREAM tests I have run it ends up being that one side is 
> transmitting a significant amount, while the receiving side is only 
> getting a fraction of it because packets are being dropped due to 
> overrunning the socket.
> 

According to netperf, it doesn't have any dropped packets doing UDP,
ethtool agrees:

MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.21.2 () port 0 AF_INET : cpu bind
Socket  Message  Elapsed      Messages                   CPU      Service
Size    Size     Time         Okay Errors   Throughput   Util     Demand
bytes   bytes    secs            #      #   10^6bits/sec % SS     us/KB

212992   64000   10.00      319414      0    16349.8     9.57     0.959 
212992           10.00      319407           16349.4     9.57     0.959 



So this looks quite low comapred to TCP, but it has no variance.

> > I'm still a bit concerned over the instability produced by
> > TCP_STREAM,
> > but it should be noted that my test setup is far from ideal:
> 
> Agreed.
> 

I can't really get a better one at present because we don't have
hardware with multiple host interfaces on different boxes that is
available to me for long term usage for test case here..

> > I currently only have a single host interface, and have used
> > network
> > namespacing to separate the two devices so that it routes over the
> > physical hardware. So it's a single system test which impacts irq
> > to
> > CPU binding, as well as queue to CPU binding, and so on. There are
> > a
> > lot of issues here that impact, but I'm happy to be able to get
> > much
> > better than 2-3Gb/s like I was before.
> > 
> > Any further suggestions would be appreciated.
> > 
> > Regards,
> > Jake
> 
> 
> The only other thing I can think of is to check flow control, but as
> I 
> recall that is disabled by default with fm10k.
> 
> - Alex
> 


There is no hardware ethernet flow control at all for the fm10k
interface.

Regards,
Jake
