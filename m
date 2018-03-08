From: Henrik Austad <henrik@austad.us>
Date: Thu, 8 Mar 2018 23:54:36 +0100
Subject: [Intel-wired-lan] [RFC v3 net-next 00/18] Time based packet
 transmission
In-Reply-To: <2a8f5476-0236-c379-f180-68c5b956dea3@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180308140904.GA28001@sisyphus.home.austad.us>
 <2a8f5476-0236-c379-f180-68c5b956dea3@intel.com>
Message-ID: <20180308225436.6ipei445l5eug3q6@icarus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 08, 2018 at 10:06:46AM -0800, Jesus Sanchez-Palencia wrote:
> Hi,
> 
> 
> On 03/08/2018 06:09 AM, Henrik Austad wrote:
> 
> (...)
> 
> > 
> > A lot of new knobs, I see the need, I would've like to have fewer, but 
> > you've documented them pretty well. Perhaps we should add something to 
> > Documentation/ at one stage?
> 
> Sure. The idea is working on that once the interfaces have been accepted.

Yeah, probably a good idea.

> > Anyways, the patches applied cleanly so I gave them a (very) quick spin. 
> > Using udp_tai and tcpdump in the other end to grab the frames
> > 
> > Setting up with hw offload and sorting in qdisc.
> > 
> > Sender (every 10ms) (4.16-rc4 on a core2duo 1.8Ghz w/i210 and max_rss 
> > bypass as dual-core and i210 is not friends):
> > 
> > udp_tai -c1 -i eth2 -p 20 -P 10000000
> > 
> > Receiver (imx7, kernel 4.9.11):
> > chrt -r 20 tcpdump -i eth0 ether host a0:36:9f:3f:c0:b8 | grep "UDP, length 256" > tai_imx7.log
> > 
> > Note: this involves 2 swtiches and a somewhat hackish kernel running on the 
> > receiver, so these numbers can only improve.
> > 
> > count    2340.000000
> > mean        0.043770
> > std         0.047784
> > min         0.009025
> > 25%         0.010003
> > 50%         0.010010
> > 75%         0.109998
> > max         0.120060
> > 
> 
> Thanks for giving it a shot.
> 
> But I'm not sure I follow the numbers above, sorry :/
> Are you computing the packet's Rx timestamp offset from the (expected) Tx time?

Just looking at the timestamp when the frames were received. They should be 
sent at regular intervals if I read udp_tai.c correctly, so the assumption 
was that the timestamp from tcpdump should give an inkling to how well it 
worked.

I set it up to send a frame every 10ms and computed the diff between each 
UDP packet received. Nothing fancy, just tcpdump and grep for the 
timestamp and look at the distribution.

> > I have to dig more into why this is happening, a lot frames delayed much 
> > more than I'd expect, but at this stage I'm pretty sure this is pebkac. One 
> > obvious fix is move some hw around and do a direct link, but I didn't have 
> > time for that right now.
> > 
> > I'm very interested in doing what Richard's original test was when he used 
> > ptp-synched clocks and also used hw receive-time and compared with expected 
> > tx-time. So, while I'm getting that up and running, I thought I should 
> > share the early results.
> 
> Sure, thanks. Which delta and clockid are you using, please?

I used the example provided in -00,

tc qdisc replace dev eth2 parent root handle 100 mqprio num_tc 3 \
 map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0

tc qdisc add dev eth2 parent 100:1 tbs offload delta 100000 clockid \
 CLOCK_REALTIME sorting

> Also, was this clock synchronized to the PHC? You need that for hw offload with
> sorting enabled.

Hmm, good point, no, NIC clock was not synchronized, I'll do that in the 
next round for both sender and receiver!

-henrik
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180308/c4066803/attachment-0001.asc>
