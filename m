From: Guedes, Andre <andre.guedes@intel.com>
Date: Thu, 7 Sep 2017 19:58:53 +0000
Subject: [Intel-wired-lan] [RFC net-next 0/5] TSN: Add qdisc-based
 config interfaces for traffic shapers
In-Reply-To: <20170907053411.GA6580@sisyphus.home.austad.us>
References: <20170901012625.14838-1-vinicius.gomes@intel.com>
 <20170907053411.GA6580@sisyphus.home.austad.us>
Message-ID: <1504814332.2117.3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Henrik,

Thanks for your feedback! I'll address some of your comments below.

On Thu, 2017-09-07 at 07:34 +0200, Henrik Austad wrote:
> > As for the shapers config interface:
> > 
> > ?* CBS (802.1Qav)
> > 
> > ???This patchset is proposing a new qdisc called 'cbs'. Its 'tc' cmd line
> > is:
> > ???$ tc qdisc add dev IFACE parent ID cbs locredit N hicredit M sendslope S
> > \
> > ?????idleslope I
> 
> So this confuses me a bit, why specify sendSlope?
> 
> ????sendSlope = portTransmitRate - idleSlope
> 
> and portTransmitRate is the speed of the MAC (which you get from the?
> driver). Adding sendSlope here is just redundant I think.

Yes, this was something we've spent quite a few time discussing before this RFC
series. After reading the Annex L from 802.1Q-2014 (operation of CBS algorithm)
so many times, we've came up with the rationale explained below.

The rationale here is that sendSlope is just another parameter from CBS
algorithm like idleSlope, hiCredit and loCredit. As such,?its calculation
should be done at the same "layer" as the others parameters (in this case, user
space) in order to keep consistency. Moreover, in this design, the driver layer
is dead simple: all the device driver?has to do is applying CBS parameters to
hardware. Having any CBS parameter calculation in the driver layer means all
device drivers must implement that calculation.

> Also, does this mean that when you create the qdisc, you have locked the?
> bandwidth for the scheduler? Meaning, if I later want to add another?
> stream that requires more bandwidth, I have to close all active streams,?
> reconfigure the qdisc and then restart?

If we want to reserve more bandwidth to "accommodate" a new stream, we don't
need to close all active streams. All we have to do is changing the CBS qdisc
and pass the new CBS parameters. Here is what the command-line would look like:

$ tc qdisc change dev enp0s4 parent 8001:5 cbs locredit -1470 hicredit 30
sendslope -980000 idleslope 20000

No application/stream is interrupted while new CBS parameters are applied.

> > ???Note that the parameters for this qdisc are the ones defined by the
> > ???802.1Q-2014 spec, so no hardware specific functionality is exposed here.
> 
> You do need to know if the link is brought up as 100 or 1000 though - which?
> the driver already knows.

User space knows that information via ethtool or /sys.

> > Testing this RFC
> > ================
> > 
> > For testing the patches of this RFC only, you can refer to the samples and
> > helper script being added to samples/tsn/ and the use the 'mqprio' qdisc to
> > setup the priorities to Tx queues mapping, together with the 'cbs' qdisc to
> > configure the HW shaper of the i210 controller:
> 
> I will test it, feedback will be provided soon! :)

That's great! Please let us know if you find any issue and thanks for you
support.

> > 8) You can also run a Talker for class B (prio 2 here)
> > $ ./talker -i enp3s0 -p 2
> > 
> > ?* The bandwidth displayed on the listener output now should increase to
> > very
> > ???close to the one configured for class A + class B.
> 
> Because you grab both class A *and* B, or because B will eat what A does?
> not use?

Because the listener application grabs both class A and B traffic.

Regards,

Andre
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3262 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170907/84197122/attachment.bin>
