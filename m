From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Tue, 21 Dec 2021 22:12:44 +0000
Subject: [Intel-wired-lan] [PATCH v5 net-next 0/4] Add ethtool interface
 for RClocks
In-Reply-To: <YcCKLnrvbu9RBlR8@shredder>
References: <20211210134550.1195182-1-maciej.machnikowski@intel.com>
 <YbXhXstRpzpQRBR8@shredder>
 <MW5PR11MB5812E5A30C05E2F1EAB2D9D5EA769@MW5PR11MB5812.namprd11.prod.outlook.com>
 <YcCKLnrvbu9RBlR8@shredder>
Message-ID: <MW5PR11MB58127387AC887DFF43140697EA7C9@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Ido Schimmel <idosch@idosch.org>
> Sent: Monday, December 20, 2021 2:51 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH v5 net-next 0/4] Add ethtool interface for RClocks
> 
> On Wed, Dec 15, 2021 at 12:13:47PM +0000, Machnikowski, Maciej wrote:
> > > -----Original Message-----
> > > From: Ido Schimmel <idosch@idosch.org>
> > > Sent: Sunday, December 12, 2021 12:48 PM
> > > To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> > > Subject: Re: [PATCH v5 net-next 0/4] Add ethtool interface for RClocks
> > >
> > > On Fri, Dec 10, 2021 at 02:45:46PM +0100, Maciej Machnikowski wrote:
> > > > Synchronous Ethernet networks use a physical layer clock to syntonize
> > > > the frequency across different network elements.
> > > >
> > > > Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
> > > > Equipment Clock (EEC) and have the ability to synchronize to reference
> > > > frequency sources.
> > > >
> > > > This patch series is a prerequisite for EEC object and adds ability
> > > > to enable recovered clocks in the physical layer of the netdev object.
> > > > Recovered clocks can be used as one of the reference signal by the EEC.
> > >
> > > The dependency is the other way around. It doesn't make sense to add
> > > APIs to configure the inputs of an object that doesn't exist. First add
> > > the EEC object, then we can talk about APIs to configure its inputs from
> > > netdevs.
> >
> > This API configures frequency outputs of the PTY layer of
> > a PHY/integrated MAC. It does not configure any inputs nor it interacts
> > with the EEC. The goal of it is to expose the clock to the piece that
> > requires it as a reference one (a DPLL/FPGA/anything else).
> 
> My fundamental issue with these patches is that instead of abstracting
> the hardware from user space they give user space direct control over
> it.

Unfortunately, I don't see any other way to address the use cases that I listed
otherwise. I'm a big fan of simple solutions, but only when they address
all use cases that are known at the time of defining them.

> This approach has the advantage of keeping the kernel relatively simple
> and fitting more use cases than just EEC, but these are also its
> disadvantages. Complexity needs to live somewhere and if this complexity
> is related to the abstraction of hardware, then it should live in the
> kernel and not in user space. We should strive to come up with an API
> that does the same thing regardless of the underlying hardware
> implementation.
> 
> Look at the proposed API, it basically says "Make the clock recovered
> from eth0 available on pin 1". If user space issues this command on
> different systems, it will mean different things, based on the
> underlying design of the hardware and the connection of the pin: To
> "DPLL/FPGA/anything else".

The link to the right DPLL input can be easily added later by adding
the new attribute to those commands. This has a big advantage
over the other model, as it is scalable to multiple different devices
serviced by different drivers, as it doesn't have the issue we have with
linking objects in kernel...

> Contrast that with an API that says "Set the source of EEC X to the
> clock recovered from eth0". This API is well defined and does the same
> thing across different systems.
> 
> Lets assume that these patches are merged as-is and tomorrow we get
> another implementation of these two ethtool operations in a different
> driver. We can't tell if these are used to feed the recovered clock into
> an EEC like ice does or enable some other use case that we never
> intended to enable.

...that issue is caused by the randomness and scalability of that 
infrastructure. At the time system boots it enumerates devices and
initializes them in  "random" order depending on the current system 
configuration which makes it impossible to code any co-driver 
dependencies, as it's impossible to guess what identifier the kernel
assigned to the other device that's connected to the same DPLL.

> Even if all the implementations use this API to feed the EEC, consider
> how difficult it is going to be for user space to use it. Ideally, user
> space should be able to query the state of the EEC and its source via an
> EEC object in a single command. With the current approach in which we
> have some amorphic object called "DPLL" that is only aware of pins and
> not netdevs, it's going to be very hard. User space will see that the
> DPLL is locked to the clock fed via pin 1. How user space is supposed to
> understand what is the source of this clock? Issue RCLK_GET dump and
> check for matching pin index that is enabled? User space has no reason
> to do it given that it doesn't even know that the source is a netdev.

Userspace tool will always know what ports it works with - it will come
from the config file, as - even if you have a dozen ports linked to a single
DPLL you may decide that you don't want to send ESMC messages
on some of them - just like we do with ptp4l.

The amorphic DPLL device has much more uses that a dedicated EEC
object and if we know what pin the DPLL uses and what is the link
between the RCLK output and the DPLL input it'll be very easy to
figure out what's going on.

The dump will also not be needed, as we know who we set as the best
source after receiving the ESMC packets from neighbors.

> >
> > I don't agree with the statement that we must have EEC object first,
> > as we can already configure different frequency sources using different
> > subsystems.
> 
> Regardless of all the above technical arguments, I think that these
> patches should not be merged now based on common sense alone. Not only
> these patches are of very limited use without an EEC object, they also
> prevent us from making changes to the API when such an object is
> introduced.

And I see a big value of merging them in as that would enable upstreaming
of the userspace tools that will explain a lot and close many gaps.

> > The source of signal should be separated from its consumer.
> 
> If it is completely separated (despite being hardwired on the board),
> then user space does not know how the signal is used when it issues the
> command. Is this signal fed into an EEC that controls that transmission
> rate of other netdev? Is this signal fed into an FPGA that blinks a led?

It's the same thing with frequency pins of the PTP subsystem. Userspace
tool can enable them, but has no idea what's on the other end of them.

> >
> > > With these four patches alone, user space doesn't know how many EECs
> > > there are in the system, it doesn't know the mapping from netdev to EEC,
> > > it doesn't know the state of the EEC, it doesn't know which source is
> > > chosen in case more than one source is enabled. Patch #3 tries to work
> > > around it by having ice print to kernel log, when the information should
> > > really be exposed via the EEC object.
> >
> > The goal of them is to add API for recovered clocks - not for EECs.
> 
> What do you mean by "not for EECs"? The file is called
> "net/ethtool/synce.c", if the signal is not being fed into an EEC then
> into what? It is unclear what kind of back doors this API will open.

Can be a DPLL of the radio part of the device, or different devices that
expects frequency reference.
If it makes it better we can move that to net/ethtool/rclk.c.

> > This part is there for observability and will still be there when EEC
> > is in place.  Those will need to be addressed by the DPLL subsystem.
> 
> If it is it only meant for observability, then why these messages are
> emitted as warnings to the kernel log? Regardless, the user API should
> be designed with observability in mind so that you wouldn't need to rely
> on prints to the kernel log.

You're right - need to change that to dev_info.
And yes - in the final form userspace tools will pull EEC's info from the DPLL
subsystem - this prints the state of 2 DPLLs and is designed for debuggability.

> >
> > > +		dev_warn(ice_pf_to_dev(pf),
> > > +			 "<DPLL%i> state changed to: %d, pin %d",
> > > +			 ICE_CGU_DPLL_SYNCE,
> > > +			 pf->synce_dpll_state,
> > > +			 pin);
> > >
> > > >
> > > > Further work is required to add the DPLL subsystem, link it to the
> > > > netdev object and create API to read the EEC DPLL state.
> > >
> > > When the EEC object materializes, we might find out that this API needs
> > > to be changed / reworked / removed, but we won't be able to do that
> > > given it's uAPI. I don't know where the confidence that it won't happen
> > > stems from when there are so many question marks around this new
> > > object.
> >
> > This API follows the functionality of other frequency outputs that exist
> > in the kernel, like PTP period file for frequency output of PTP clock
> > or other GPIOs. I highly doubt it'll change - we may extend it to add
> mapping
> > between pins, but like I indicated - this will not always be known to SW.
> >
> > Regards
> > Maciek
