From: Legacy, Allain <Allain.Legacy@windriver.com>
Date: Tue, 2 Feb 2016 03:05:09 +0000
Subject: [Intel-wired-lan] anyone aware of problem with 82599ES stuck
 sending TX pause frames?
In-Reply-To: <F6FB0E698C9B3143BDF729DF2228664691E71713@ORSMSX116.amr.corp.intel.com>
References: <56AA60A1.7060408@windriver.com>
 <F6FB0E698C9B3143BDF729DF2228664691E709B9@ORSMSX116.amr.corp.intel.com>
 <56AF744B.1000403@windriver.com>
 <F6FB0E698C9B3143BDF729DF2228664691E71472@ORSMSX116.amr.corp.intel.com>
 <56AFF0BB.1030309@windriver.com>,
 <F6FB0E698C9B3143BDF729DF2228664691E71713@ORSMSX116.amr.corp.intel.com>
Message-ID: <70A7408C6E1BFB41B192A929744D852359114D4E@ALA-MBB.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Don.

We can disable the flow director and see if the issue is still reproducible. 

No, we didn't enable TxFC manually on the adapter.  It seems to be on by default even though auto-negotiation is off. 

Allain



Allain Legacy, Software Developer, Wind River
direct 613.270.2279 fax: 613.492.7870 skype: allain.legacy
350 Terry Fox Drive, Suite 200, Ottawa, Ontario, K2K 2W5

________________________________________
From: Skidmore, Donald C [donald.c.skidmore at intel.com]
Sent: Monday, February 01, 2016 10:01 PM
To: Friesen, Chris; intel-wired-lan at lists.osuosl.org; Legacy, Allain
Subject: RE: [Intel-wired-lan] anyone aware of problem with 82599ES stuck sending TX pause frames?

Hey Chris,

A colleague of mind reminded me of an issue we had years ago with a similar failure symptoms.  It had to do with an erratum related to receiving an Rx packet at the wrong time while we were initializing the flow director table.  The driver in the 3.10 kernel, even though old should have had this fix.  But I am wondering if you could seeing if you could recreate the problem with flow director disabled?

One other quick question.  Since the switch isn't honoring the pause frames can I assume you enabled TxFC on the adapter manually?

Also I'll take a look at the registers to see if anything jumps out at me.

Thanks,
-Don

> -----Original Message-----
> From: Chris Friesen [mailto:chris.friesen at windriver.com]
> Sent: Monday, February 01, 2016 3:57 PM
> To: Skidmore, Donald C; intel-wired-lan at lists.osuosl.org; Legacy, Allain
> (Wind River)
> Subject: Re: [Intel-wired-lan] anyone aware of problem with 82599ES stuck
> sending TX pause frames?
>
> On 02/01/2016 11:54 AM, Skidmore, Donald C wrote:
> > Hey Chris,
> >
> > Like I mentioned earlier the only issue I was aware of anything close to this
> was root caused to switch capability.  If you are seeing the same behavior
> across multiple switch that pretty much rules that out.  Since you don't see
> anything in the system log we may need to get a register dump (with
> something like ethregs) both before the failure occurs and while in the error
> state.  This is assuming once the system enters the error state it remains
> indefinitely.   Couple other things I'm wondering:
> >
> > - Is traffic being received/transmit while in the error state and if so how
> much?
> > - does a reset correct the problem or do you have to do something more
> aggressive (i.e. reload the driver, cycle power)?
> > - Anything else that might have been occurring around the time the system
> enters the error state.
>
> Adding my coworker to the receiver list so he can chime in directly.
>
> The device does report a small number of received packets before it locks up.
> Once it gets into the bad state the rx missed packet count increases but no
> packets appear to be processed by the driver.
>
> The neighbouring switch does not have flow control enabled at all, and it is
> ignoring the XOFF packets coming from the device and continuing to send
> packets
> towards the device. The device is dropping those packets. When we disable
> the
> switch port (and drop carrier) the device does not exit the error state, when
> we
> re-enable the switch port the device still does not exit the error state. The
> issue was resolved by resetting the device via ifdown/ifup.
>
> We don't have ethregs installed, but I've included below an ethtool dump
> from a
> device in the "stuck" state, followed by an ethtool register-only dump from
> the
> same device during "normal" operation.
>
> Thanks,
> Chris
>

