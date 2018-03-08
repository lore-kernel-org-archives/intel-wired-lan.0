From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Thu, 8 Mar 2018 10:06:46 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 00/18] Time based packet
 transmission
In-Reply-To: <20180308140904.GA28001@sisyphus.home.austad.us>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180308140904.GA28001@sisyphus.home.austad.us>
Message-ID: <2a8f5476-0236-c379-f180-68c5b956dea3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,


On 03/08/2018 06:09 AM, Henrik Austad wrote:

(...)

> 
> A lot of new knobs, I see the need, I would've like to have fewer, but 
> you've documented them pretty well. Perhaps we should add something to 
> Documentation/ at one stage?

Sure. The idea is working on that once the interfaces have been accepted.


> 
> Anyways, the patches applied cleanly so I gave them a (very) quick spin. 
> Using udp_tai and tcpdump in the other end to grab the frames
> 
> Setting up with hw offload and sorting in qdisc.
> 
> Sender (every 10ms) (4.16-rc4 on a core2duo 1.8Ghz w/i210 and max_rss 
> bypass as dual-core and i210 is not friends):
> 
> udp_tai -c1 -i eth2 -p 20 -P 10000000
> 
> Receiver (imx7, kernel 4.9.11):
> chrt -r 20 tcpdump -i eth0 ether host a0:36:9f:3f:c0:b8 | grep "UDP, length 256" > tai_imx7.log
> 
> Note: this involves 2 swtiches and a somewhat hackish kernel running on the 
> receiver, so these numbers can only improve.
> 
> count    2340.000000
> mean        0.043770
> std         0.047784
> min         0.009025
> 25%         0.010003
> 50%         0.010010
> 75%         0.109998
> max         0.120060
> 

Thanks for giving it a shot.

But I'm not sure I follow the numbers above, sorry :/
Are you computing the packet's Rx timestamp offset from the (expected) Tx time?


> I have to dig more into why this is happening, a lot frames delayed much 
> more than I'd expect, but at this stage I'm pretty sure this is pebkac. One 
> obvious fix is move some hw around and do a direct link, but I didn't have 
> time for that right now.
> 
> I'm very interested in doing what Richard's original test was when he used 
> ptp-synched clocks and also used hw receive-time and compared with expected 
> tx-time. So, while I'm getting that up and running, I thought I should 
> share the early results.


Sure, thanks. Which delta and clockid are you using, please?
Also, was this clock synchronized to the PHC? You need that for hw offload with
sorting enabled.

Thanks,
Jesus

(...)

