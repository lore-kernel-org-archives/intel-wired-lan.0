From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 28 Apr 2017 15:20:53 +0000
Subject: [Intel-wired-lan] [PATCH] net-intel: fix race condition with
 PTP_TX_IN_PROGRESS bits
In-Reply-To: <CACJTkKHigpjhksUkh=rx9LfTvYr5nupih4Zom82tU5UkQVVwNQ@mail.gmail.com>
References: <20170427235553.24803-1-jacob.e.keller@intel.com>
 <CACJTkKHigpjhksUkh=rx9LfTvYr5nupih4Zom82tU5UkQVVwNQ@mail.gmail.com>
Message-ID: <1493392848.7849.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2017-04-28 at 11:32 +1000, David Mirabito wrote:
> Thanks Jacob,
> 
> Your patch is pretty much identical, but nicer, to what I am
> currently running which so far seems solid. We've now gone 24 hours
> without loosing a single timestamp when running ptp4l -- a new
> record!

Excellent news!

> 
> Elsewhere you mentioned considering whether the timeout stat should
> be bumped when the tx path knows it failed grab the timestamp slot.
> IMHO, some way to for users to confirm that something happened from
> the driver's perspective would be most useful. Seeing a counter
> rising in correlation to observing problems in some application could
> help narrow down on the root cause.? Currently I just have a
> dev_debug for when the test-and-set fails whilst I keep an eye on
> things.
> 

So there's two failure cases. First is that the PTP_TX_IN_PROGRESS lock
is already set, so when you enter xmit_frame() you simply don't even
request the timestamp at all. This case is what we're fixing now.

The second case is if you attempt to hardware timestamp but somehow you
never get a response. This really shouldn't ever happen, but we have
detection in case it does.

> On a somewhat related note, in igb at least - should the error cases
> after acquiring that lock (i.e dma mapping or tso failure)??clear it
> and free the stashed skb? The existing timeout & clear mechanism
> seems to only work on 82576 which polls - other chips seem to rely on
> the TX_TS interrupt arriving in order to notice that a tx timestamp
> hasn't been received in a while. Unless there are cases where HW
> raises the interrupt, but then does not make the timestamp available
> this doesn't look like it does what was intended - there's no
> catchall to clean things up if the interrupt never arrives in the
> first place.
> Or are those particular TX errors hard enough that a more general
> reset occurs which could clear this up? It seems the only other way
> TX_IN_PROGRESS might be cleared from adapter->state is suspend
> related.
> 

We definitely should clear this during out-drop, and additionally I
suspect we should have a check in the watchdog for the event incase it
fails to complete in some reasonable time. I'd guess these failures are
quite rare so we never noticed them before.

I thought the ptp_tx_work was running in the watchdog already, but it
appears not to be.

I can probably try to work up a patch to this end.

> Either way, this is more academic for now (and possibly quite rare,
> if not impossible to achieve in practice), whereas the problems
> addressed in the patch were directly hurting us so we're already
> ahead.

Yea, this definitely isn't a high priority to fix, however it can cause
a complete stop of Tx timestamps since nothing ever clears it. I'll
take a look and see if I can find a good fix.

Thanks,
Jake
