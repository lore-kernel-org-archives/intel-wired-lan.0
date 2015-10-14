From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 14 Oct 2015 17:57:12 +0000
Subject: [Intel-wired-lan] [next-queue 15/17] fm10k: change default Tx
 ITR to 25usec
In-Reply-To: <561E8176.8050803@gmail.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-15-git-send-email-jacob.e.keller@intel.com>
 <561E7195.2010605@gmail.com> <1444838391.26286.11.camel@intel.com>
 <561E8176.8050803@gmail.com>
Message-ID: <1444845432.26286.29.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-10-14 at 09:23 -0700, Alexander Duyck wrote:
> The 36Gb/s number is pretty impressive and may be pushing you into
> other 
> limits.  What does the CPU utilization look like for your test?  Do
> you 
> see the thread handling the workload get fully utilized?  Also have
> you 
> tried enabling XPS to see if maybe you could squeeze a bit more out
> of 
> the core that is doing the test by improving locality?
> 
> - Alex

Hello,

So what I am getting now with a few things. First, I set rx-usecs and
tx-usecs to both 25, and disabled adaptive mode for now...

TCP_STREAM => 33Gb/s, but sometimes drops to 27Gb/s, I believe this is
a result of no rx_flow_steering (Flow director / ATR) support in the
host interface. So sometimes the queue we pick is more local other
times it is not. If I reduce the number of queues and ensure only CPUs
local to the one I am running netperf, I get 33Gb/s pretty straight. I
have not been able to reproduce the 36Gb/s test above, so I may re-word
the commit message...

I used:

./netperf -T0,5 -t TCP_STREAM -f m -c -C  -H 192.168.21.2 -- -m 64K  

So this is with rather large messages that can be run through TSO.

CPU utilization here tops says: 10% local, 10% remote, but if I look at
top on both ends, it shows ~80% CPU utilization on receiver, and about
50% on the transmit end.

I've got a weird issue right now where sometimes it seems to drop to
half and I haven't determined exactly why yet. But I am pretty sure
it's due to queue assignment

I've been getting pretty inconsistent performance results over the last
few tests.

I tried these tests with interrupt moderation disabled completely and I
generally got less performance.

Interestingly, I just set both rx and tx to 10, and got one test
through to report 39Gb/s... But I am definitely not able to
consistently hit this value.

I generally seem to range pretty wide over tests.

For UDP I used:

./netperf -T0,5 -t UDP_STREAM -f m -c -C  -H 192.168.21.2 -- -m 64k  

For this test, I see 80% CPU utilization on the sender, and 50% on the
receiver, when bound as above.

I seem to get ~16Gb/s send and receive here, with no variance... 

I suspect part of this is due to the fact that TCP can do hardware TSO,
which we don't have in UDP? I'm not sure here..

UDP is significantly more stable than TCP was. but it doesn't seem to
ever go above 16Gb/s for a single stream.

I'm still a bit concerned over the instability produced by TCP_STREAM,
but it should be noted that my test setup is far from ideal:

I currently only have a single host interface, and have used network
namespacing to separate the two devices so that it routes over the
physical hardware. So it's a single system test which impacts irq to
CPU binding, as well as queue to CPU binding, and so on. There are a
lot of issues here that impact, but I'm happy to be able to get much
better than 2-3Gb/s like I was before.

Any further suggestions would be appreciated.

Regards,
Jake

