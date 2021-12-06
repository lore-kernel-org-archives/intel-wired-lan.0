From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Mon, 6 Dec 2021 09:15:28 +0000
Subject: [Intel-wired-lan] [PATCH v4 net-next 2/4] ethtool: Add ability
 to configure recovered clock for SyncE feature
In-Reply-To: <YayvaIFw8obrUHs4@shredder>
References: <20211201180208.640179-1-maciej.machnikowski@intel.com>
 <20211201180208.640179-3-maciej.machnikowski@intel.com>
 <Yai/e5jz3NZAg0pm@shredder>
 <MW5PR11MB5812455176BC656BABCFF1B0EA699@MW5PR11MB5812.namprd11.prod.outlook.com>
 <Yaj13pwDKrG78W5Y@shredder>
 <PH0PR11MB583105F8678665253A362797EA699@PH0PR11MB5831.namprd11.prod.outlook.com>
 <Yao7r4DF7NmobEdp@shredder>
 <MW5PR11MB5812AB9B6E0CAEB6F9A84ABAEA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
 <YayvaIFw8obrUHs4@shredder>
Message-ID: <MW5PR11MB581288D11A5FB7CEEE0D4E3CEA6D9@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Ido Schimmel <idosch@idosch.org>
> Sent: Sunday, December 5, 2021 1:24 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH v4 net-next 2/4] ethtool: Add ability to configure
> recovered clock for SyncE feature


OK I see where the misunderstanding comes from. The subsystem we'll
Develop will NOT be EEC subsystem, but the DPLL subsystem. The EEC is only 
one potential use of the DPLL, but there are many more.
By principle all DPLL chips have configurable inputs, configurable PLL block,
and configurable outputs - that's what the new subsystem will configure
and expose. And the input block is shared between multiple DPLLs internally.

Unfortunately, we have no way of representing all connections to a given
DPLL and we have to rely on manual/labels anyway - just like we do with
PTP pins. We control them, but have no idea where they are connected
physically.

My assumption is that the DPLL block will follow the same principle and 
will expose a set of inputs and set of outputs that uAPI will configure.

Now with that in mind:


> > My argument was never "it's hard" - the answer is we need both APIs.
> 
> We are discussing whether two APIs are actually necessary or whether EEC
> source configuration can be done via the EEC. The answer cannot be "the
> answer is we need both APIs".

We need both APIs because a single recovered clock can be connected to:
- Multiple DPLLs - either internal to the chip, or via fanouts to different chips
- a FPGA
- a RF HW that may not expose any DPLL

Given that - we cannot hook control over recovered clocks to a DPLL subsystem,
as it's not the only consumer of that output.

> >
> > > In addition, without a representation of the EEC, these patches have no
> > > value for user space. They basically allow user space to redirect the
> > > recovered frequency from a netdev to an object that does not exist.
> > > User space doesn't know if the object is successfully tracking the
> > > frequency (the EEC state) and does not know which other components
> are
> > > utilizing this recovered frequency as input (e.g., other netdevs, PHC).
> >
> > That's also not true - the proposed uAPI lets you enable recovered
> frequency
> > output pins and redirect the right clock to them. In some implementations
> > you may not have anything else.
> 
> What isn't true? That these patches have no value for user space? This
> is 100% true. You admitted that this is incomplete work. There is no
> reason to merge one API without the other. At the very least, we need to
> see an explanation of how the two APIs work together. This is missing
> from the patchset, which prompted these questions:
> 
> https://lore.kernel.org/netdev/Yai%2Fe5jz3NZAg0pm at shredder/

That's what I try to explain. A given DPLL will have multiple reference frequencies
to choose from, but the sources of them will be configured independently.
With the sources like:
- 1PPS/10MHz from the GNSS
- 1PPS/10MHz  from external source
- 1PPS from the PTP block
- Recovered clock

Additionally, a given DPLL chip may have many (2, 4, 6, 8 +) DPLLs inside,
each one using the same reference signals for different purposes.

Also there is a reason to merge this without DPLL subsystem for all devices
that use recovered clocks for a purpose other than SyncE.

[...]
> > > >
> > > > They belong to different devices. EEC registers are physically in the DPLL
> > > > hanging over I2C and recovered clocks are in the PHY/integrated PHY in
> > > > the MAC. Depending on system architecture you may have control over
> > > > one piece only
> > >
> > > These are implementation details of a specific design and should not
> > > influence the design of the uAPI. The uAPI should be influenced by the
> > > logical task that it is trying to achieve.
> >
> > There are 2 logical tasks:
> > 1. Enable clocks that are recovered from a specific netdev
> 
> I already replied about this here:
> 
> https://lore.kernel.org/netdev/Yao+nK40D0+u8UKL at shredder/
> 
> If the recovered clock outputs are only meaningful as EEC inputs, then
> there is no reason not to configure them through the EEC object. The
> fact that you think that the *internal* kernel plumbing (that can be
> improved over time) will be "hard" is not a reason to end up with a
> *user* API (that cannot be changed) where the *Ethernet* Equipment Clock
> is ignorant of its *Ethernet* ports.

Like I mentioned above - it won?t be EEC subsystem. Also the signal is relevant
to other devices - not only EEC and not even only to DPLLs.

> With your proposal where the EEC is only aware of pins, how does user
> space answer the question of what is the source of the EEC? It needs to
> issue RCLK_GET dump? How does it even know that the source is a netdev
> and not an external one? And if the EEC object knows that the source is
> a netdev, how come it does not know which netdev?

This needs to be addressed by the DPLL subsystem - I'd say using labels would be
a good way to manage it - in the same way we use them in the PTP subsystem

> > 2. Control the EEC
> >
> > They are both needed to get to the full solution, but are independent from
> > each other. You can't put RCLK redirection to the EEC as it's one to many
> > relation and you will need to call the netdev to enable it anyway.
> 
> So what if I need to call the netdev? The EEC cannot be so disjoint from
> the associated netdevs. After all, EEC stands for *Ethernet* Equipment
> Clock. In the common case, the EEC will transfer the frequency from one
> netdev to another. In the less common case, it will transfer the
> frequency from an external source to a netdev.

Again - the DPLLs linked to the netdev is just one of many use cases. Other
DPLLs not linked to netdevs will also exist and use the PHY recovered clock.

> >
> > Also, when we tried to add EEC state to PTP subsystem the answer was
> > that we can't mix subsystems.
> 
> SyncE doesn't belong in PTP because PTP can work without SyncE and SyncE
> can work without PTP. The fact that the primary use case for SyncE might
> be PTP doesn't mean that SyncE belongs in PTP subsystem.
> 
> > The proposal to configure recovered clocks  through EEC would mix
> > netdev with EEC.
> 
> I don't believe that *Ethernet* Equipment Clock and *Ethernet* ports
> should be so disjoint so that the EEC doesn't know about:
> 
> a. The netdev from which it is recovering its frequency
> b. The netdevs that it is controlling
> 
> If the netdevs are smart enough to report the EEC input pins and EEC
> association to user space, then they are also smart enough to register
> themselves internally in the kernel with the EEC. They can all appear as
> virtual input/output pins of the EEC that can be enabled/disabled by
> user space. In addition, you can have physical (named) pins for external
> sources / outputs and another virtual output pin towards the PHC.

Netdevs needs to know which DPLL is used as its source.
If we want to make a DPLL aware of who's driving the signal we can create
internal plumbing between PHY output pins and some/all DPLL references
that are linked to it - if that connection is known.

If such plumbing is known we can add registration of a netdev that's using
the recovered clock output to the reference inputs. That way the DPLL would
see which netdev (or other device) is the source from its reference input 
system.

Hope this clarifies why we need both uAPIs.
