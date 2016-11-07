From: Ray Bellis <ray@isc.org>
Date: Mon, 7 Nov 2016 20:16:15 +0000
Subject: [Intel-wired-lan] i40e performance regression after 1.3.9 ?
In-Reply-To: <CAKgT0Uc9W_tvMEoKzLzBG-pK7Sjznr3B+xgjne0tUuTX17d+Hg@mail.gmail.com>
References: <9f9f62ec-fbce-534a-d2bd-e918a03a3899@isc.org>
 <CAKgT0Uc9W_tvMEoKzLzBG-pK7Sjznr3B+xgjne0tUuTX17d+Hg@mail.gmail.com>
Message-ID: <fe40bb83-d28c-8fc4-148a-37ff7ad5c7aa@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 07/11/2016 18:42, Alexander Duyck wrote:

> Do you know if the packets are being dropped in the Rx path or is the
> bottleneck on the Tx side?  

None were being dropped AFAICR (from looking at the interface stats) and
I can't tell which side is the bottleneck.

> It looks like this could be one of a few
> things.  Doing a quick git log and git diff between v4.3 and v4.4 the
> two things that jump out at me are changes to the Tx tail bumping code
> and changes to the interrupt moderation code.
> 
> To narrow this down you might try manually configuring both the 1.3.9
> and 1.3.38 drivers to the same interrupt moderation values using a
> command like:
> ethtool -C <iface> adaptive-rx off adaptive-tx off rx-usecs 25 tx-usecs 25
> 
> That would default the interrupt moderation to somewhere around 40K
> interrupts per second.  If you run this command on both drivers and
> they give you the same performance than we would know that the issue
> is likely due to changes in the dynamic interrupt moderation.

I had noticed last week that the rx-usecs and tx-usecs values were
different between 4.3 and 4.4, but when I changed the 25/25 that 4.4
uses to the 62/122 that 4.3 uses it made no difference.

However that's not quite what you've asked, so I shall repeat the test
tomorrow, and also see whether your suggestion of changing 4.3 to the
4.4 values causes the same drop.

I also didn't turn off adaptive rx or tx, so I shall try that too.

Also if it helps, I've got flame graphs of "before" and "after":

http://users.isc.org/~ray/graph-fast.svg   (1.3.9)
http://users.isc.org/~ray/graph-slow.svg   (1.3.38+)

These both represent 30 seconds of dnsperf hammering my UDP echo server,
although I suspect that compiler inlining may have interfered with the
stack traces.

thanks,

Ray


