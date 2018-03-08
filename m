From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Thu, 8 Mar 2018 15:58:59 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 00/18] Time based packet
 transmission
In-Reply-To: <20180308225436.6ipei445l5eug3q6@icarus.home.austad.us>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180308140904.GA28001@sisyphus.home.austad.us>
 <2a8f5476-0236-c379-f180-68c5b956dea3@intel.com>
 <20180308225436.6ipei445l5eug3q6@icarus.home.austad.us>
Message-ID: <0307c7bd-5208-9c8b-9eb0-4c4b7fdaeb31@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,


On 03/08/2018 02:54 PM, Henrik Austad wrote:
> Just looking at the timestamp when the frames were received. They should be 
> sent at regular intervals if I read udp_tai.c correctly, so the assumption 
> was that the timestamp from tcpdump should give an inkling to how well it 
> worked.
> 
> I set it up to send a frame every 10ms and computed the diff between each 
> UDP packet received. Nothing fancy, just tcpdump and grep for the 
> timestamp and look at the distribution.

Ok, I see it now. Just as a reference, this is how I've been running tcpdump on
my tests:

$ tcpdump -i enp3s0 -w foo.pcap -j adapter_unsynced \
	-tt --time-stamp-precision=nano udp port 7788 -c 10000


> 
>>> I have to dig more into why this is happening, a lot frames delayed much 
>>> more than I'd expect, but at this stage I'm pretty sure this is pebkac. One 
>>> obvious fix is move some hw around and do a direct link, but I didn't have 
>>> time for that right now.
>>>
>>> I'm very interested in doing what Richard's original test was when he used 
>>> ptp-synched clocks and also used hw receive-time and compared with expected 
>>> tx-time. So, while I'm getting that up and running, I thought I should 
>>> share the early results.
>>
>> Sure, thanks. Which delta and clockid are you using, please?
> 
> I used the example provided in -00,
> 
> tc qdisc replace dev eth2 parent root handle 100 mqprio num_tc 3 \
>  map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
> 
> tc qdisc add dev eth2 parent 100:1 tbs offload delta 100000 clockid \
>  CLOCK_REALTIME sorting


The delta value is highly dependent on the system. I recommend playing around
with it a bit before running long tests. On my KabyLake desktop I noticed that
150us is quite reliable value, for example. (same kernel as yours, and no
preempt-rt applied) But that is not the issue here it seems.



> 
>> Also, was this clock synchronized to the PHC? You need that for hw offload with
>> sorting enabled.
> 
> Hmm, good point, no, NIC clock was not synchronized, I'll do that in the 
> next round for both sender and receiver!

Oh, then you need to get that setup first. Here I synchronize both PHCs over the
network first with ptp4l:

Rx) $ ptp4l --summary_interval=3 -i enp3s0 -m -2
Tx) $ ptp4l --summary_interval=3 -i enp3s0 -s -m -2 &

My Rx is the PTP master and the Tx is the PTP slave.
Then I synchronize the PHC to the system clock on the Tx side only:

Tx) $ phc2sys -a -r -r -u 8 &


And udp_tai is using CLOCK_REALTIME. The UTC vs TAI 37s offset makes no
difference for this test specifically because I compensate for it when
calculating the offsets on the Rx side.

For the next patchset version I will be providing a more complete set of testing
instructions. I hope that helps for now.


Thanks,
Jesus




