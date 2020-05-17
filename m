From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 17 May 2020 22:04:23 +0300
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <20200517184514.GD606317@lunn.ch>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <20200516.133739.285740119627243211.davem@davemloft.net>
 <CA+h21hoNW_++QHRob+NbWC2k7y7sFec3kotSjTL6s8eZGGT+2Q@mail.gmail.com>
 <20200516.151932.575795129235955389.davem@davemloft.net>
 <CA+h21hrg_CeD2-zT+7v3b3hPRFaeggmZC9NqPp+soedCYwG63A@mail.gmail.com>
 <20200517184514.GD606317@lunn.ch>
Message-ID: <CA+h21hqi0dX349dxXz8vrWUGLoHrk-er77S4rvUrj7jM3QAXWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Andrew,

On Sun, 17 May 2020 at 21:45, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, May 17, 2020 at 01:51:19PM +0300, Vladimir Oltean wrote:
> > On Sun, 17 May 2020 at 01:19, David Miller <davem@davemloft.net> wrote:
> > >
> > > From: Vladimir Oltean <olteanv@gmail.com>
> > > Date: Sun, 17 May 2020 00:03:39 +0300
> > >
> > > > As to why this doesn't go to tc but to ethtool: why would it go to tc?
> > >
> > > Maybe you can't %100 duplicate the on-the-wire special format and
> > > whatever, but the queueing behavior ABSOLUTELY you can emulate in
> > > software.
> > >
> > > And then you have the proper hooks added for HW offload which can
> > > do the on-the-wire stuff.
> > >
> > > That's how we do these things, not with bolted on ethtool stuff.
> >
> > When talking about frame preemption in the way that it is defined in
> > 802.1Qbu and 802.3br, it says or assumes nothing about queuing. It
> > describes the fact that there are 2 MACs per interface, 1 MAC dealing
> > with some traffic classes and the other dealing with the rest.
>
> I did not follow the previous discussion, but i assume you talked
> about modelling it in Linux as two MACs? Why was that approach not
> followed?
>
>    Andrew

I don't recall having discussed that option, but I guess that you can
see why, if I quote this portion from IEEE 802.1Q-2018:

6.7.1 Support of the ISS by IEEE Std 802.3 (Ethernet)
Mapping between M_CONTROL.requests/indications and IEEE 802.3
MA_CONTROL.requests/indications is performed as specified in IEEE Std
802.1AC. If the MAC supports IEEE 802.3br (TM) Interspersing Express
Traffic, then PFC M_CONTROL.requests are mapped onto the MAC control
interface associated with the express MAC (eMAC).
If frame preemption (6.7.2) is supported on a Port, then the IEEE
802.3 MAC provides the following two MAC service interfaces (99.4 of
IEEE Std 802.3br (TM)-2016 [B21]):
a) A preemptible MAC (pMAC) service interface
b) An express MAC (eMAC) service interface
For priority values that are identified in the frame preemption status
table (6.7.2) as preemptible, frames that are selected for
transmission shall be transmitted using the pMAC service instance, and
for priority values that are identified in the frame preemption status
table as express, frames that are selected for transmission shall be
transmitted using the eMAC service instance.

_In all other respects, the Port behaves as if it is supported by a
single MAC service interface_ (emphasis mine). In particular, all
frames received by the Port are treated as if they were received on a
single MAC service interface regardless of whether they were received
on the eMAC service interface or the pMAC service interface, except
with respect to frame preemption.

Thanks,
-Vladimir
