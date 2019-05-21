From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Date: Tue, 21 May 2019 13:54:56 -0400
Subject: [Intel-wired-lan] i40e X722 RSS problem with NAT-Traversal
 IPsec packets
In-Reply-To: <CAKgT0UfpZ-ve3Hx26gDkb+YTDHvN3=MJ7NZd2NE7ewF5g=kHHw@mail.gmail.com>
References: <20190514163443.glfjva3ofqcy7lbg@csclub.uwaterloo.ca>
 <CAKgT0UdPDyCBsShQVwwE5C8fBKkMcfS6_S5m3T7JP-So9fzVgA@mail.gmail.com>
 <20190516183407.qswotwyjwtjqfdqm@csclub.uwaterloo.ca>
 <20190516183705.e4zflbli7oujlbek@csclub.uwaterloo.ca>
 <CAKgT0UfSa-dM2+7xntK9tB7Zw5N8nDd3U1n4OSK0gbWbkNSKJQ@mail.gmail.com>
 <CAKgT0Ucd0s_0F5_nwqXknRngwROyuecUt+4bYzWvp1-2cNSg7g@mail.gmail.com>
 <20190517172317.amopafirjfizlgej@csclub.uwaterloo.ca>
 <CAKgT0UdM28pSTCsaT=TWqmQwCO44NswS0PqFLAzgs9pmn41VeQ@mail.gmail.com>
 <20190521151537.xga4aiq3gjtiif4j@csclub.uwaterloo.ca>
 <CAKgT0UfpZ-ve3Hx26gDkb+YTDHvN3=MJ7NZd2NE7ewF5g=kHHw@mail.gmail.com>
Message-ID: <20190521175456.zlkiiov5hry2l4q2@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 21, 2019 at 09:51:33AM -0700, Alexander Duyck wrote:
> I think we need to narrow this down a bit more. Let's try forcing the
> lookup table all to one value and see if traffic is still going to
> queue 0.
> 
> Specifically what we need to is run the following command to try and
> force all RSS traffic to queue 8, you can verify the result with
> "ethtool -x":
> ethtool -X <iface> weight 0 0 0 0 0 0 0 0 1
> 
> If that works and the IPSec traffic goes to queue 8 then we are likely
> looking at some sort of input issue, either in the parsing or the
> population of things like the input mask that we can then debug
> further.
> 
> If traffic still goes to queue 0 then that tells us the output of the
> RSS hash and lookup table are being ignored, this would imply either
> some other filter is rerouting the traffic or is directing us to limit
> the queue index to 0 bits.

# ethtool -x eth2
RX flow hash indirection table for eth2 with 12 RX ring(s):
    0:      7     7     7     7     7     7     7     7
    8:      7     7     7     7     7     7     7     7
   16:      7     7     7     7     7     7     7     7
   24:      7     7     7     7     7     7     7     7
   32:      7     7     7     7     7     7     7     7
...
  472:      7     7     7     7     7     7     7     7
  480:      7     7     7     7     7     7     7     7
  488:      7     7     7     7     7     7     7     7
  496:      7     7     7     7     7     7     7     7
  504:      7     7     7     7     7     7     7     7
RSS hash key:
0b:1f:ae:ed:60:04:7d:e5:8a:2b:43:3f:1d:ee:6c:99:89:29:94:b0:25:db:c7:4b:fa:da:4d:3f:e8:cc:bc:00:ad:32:01:d6:1c:30:3f:f8:79:3e:f4:48:04:1f:51:d2:5a:39:f0:90
root at ECA:~# ethtool --show-priv-flags eth2
Private flags for eth2:
MFP              : off
LinkPolling      : off
flow-director-atr: off
veb-stats        : off
hw-atr-eviction  : on
legacy-rx        : off

All ipsec packets are still hitting queue 0.

Seems it is completely ignoring RSS for these packets.  That is
impressively weird.

-- 
Len Sorensen
