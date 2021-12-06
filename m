From: Petr Machata <petrm@nvidia.com>
Date: Mon, 6 Dec 2021 17:00:26 +0100
Subject: [Intel-wired-lan] [PATCH v4 net-next 2/4] ethtool: Add ability
 to configure recovered clock for SyncE feature
In-Reply-To: <MW5PR11MB58121BF596AB9C501F900887EA6D9@MW5PR11MB5812.namprd11.prod.outlook.com>
References: <20211201180208.640179-1-maciej.machnikowski@intel.com>
 <20211201180208.640179-3-maciej.machnikowski@intel.com>
 <Yai/e5jz3NZAg0pm@shredder>
 <MW5PR11MB5812455176BC656BABCFF1B0EA699@MW5PR11MB5812.namprd11.prod.outlook.com>
 <Yaj13pwDKrG78W5Y@shredder>
 <PH0PR11MB583105F8678665253A362797EA699@PH0PR11MB5831.namprd11.prod.outlook.com>
 <87pmqdojby.fsf@nvidia.com>
 <MW5PR11MB581202E2A601D34E30F1E5AEEA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87lf11odsv.fsf@nvidia.com>
 <MW5PR11MB5812A86416E3100444894879EA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87fsr9o7di.fsf@nvidia.com>
 <MW5PR11MB5812AA2C625AC00616F94A2AEA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
 <87czm9okyc.fsf@nvidia.com>
 <MW5PR11MB58121BF596AB9C501F900887EA6D9@MW5PR11MB5812.namprd11.prod.outlook.com>
Message-ID: <877dchoh9h.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:

>> -----Original Message-----
>> From: Petr Machata <petrm@nvidia.com>
>> Sent: Monday, December 6, 2021 3:41 PM
>> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
>> Subject: Re: [PATCH v4 net-next 2/4] ethtool: Add ability to configure
>> recovered clock for SyncE feature
>> 
>> 
>> Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:
>> 
>> >> -----Original Message-----
>> >> From: Petr Machata <petrm@nvidia.com>
>> >>
>> >> Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:
>> >>
>> >> > Additionally, the EEC device may be instantiated by a totally
>> >> > different driver, in which case the relation between its pins
>> >> > and netdevs may not even be known.
>> >>
>> >> Like an EEC, some PHYs, but the MAC driver does not know about
>> >> both pieces? Who sets up the connection between the two? The box
>> >> admin through some cabling? SoC designer?
>> >>
>> >> Also, what does the external EEC actually do with the signal from
>> >> the PHY? Tune to it and forward to the other PHYs in the complex?
>> >
>> > Yes - it can also apply HW filters to it.
>> 
>> Sounds like this device should have an EEC instance of its own then.
>> 
>> Maybe we need to call it something else than "EEC". PLL? Something
>> that does not have the standardization connotations, because several
>> instances would be present in a system with several NICs.
>
> There will be no EEC/EEC subsystem, but the DPLL. Every driver would
> be able to create a DPLL object so that we can easily use it from
> non-netdev devices as well. See the other mail for more details.

Yes, this makes sense to me.

>> > The EEC model will not work when you have the following system:
>> > SoC with some ethernet ports with driver A
>> > Switch chip with N ports with driver B
>> > EEC/DPLL with driver C
>> > Both SoC and Switch ASIC can recover clock and use the cleaned
>> > clock from the DPLL.
>> >
>> > In that case you can't create any relation between EEC and recover
>> > clock pins that would enable the EEC subsystem to control
>> > recovered clocks, because you have 3 independent drivers.
>> 
>> I think that in that case you have several EEC instances. Those are
>> connected by some wiring that is external to the devices themselves. I
>> am not sure who should be in charge of describing the wiring. Device
>> tree? Config file?
>
> In some complex systems you'll need to create a relation between
> netdevs and DPLLs in a config file, so it is the only way to describe
> all possible scenarios. We can't assume any connections between them,
> as that's design specific, just like PTP pins are. They have labels,
> but it's up to the system integrator to define how they are used. We
> can consider creating some of them if they are known to the driver and
> belong to the same driver.

Agreed.

>> > The model you proposed assumes that the MAC/Switch is in
>> > charge of the DPLL, but that's not always true.
>> 
>> The EEC-centric model does not in fact assume that. It lets anyone to
>> set up an EEC object.
>> 
>> The netdev-centric UAPI assumes that the driver behind the netdev
>> knows about how many RCLK out pins there are. So it can certainly
>> instantiate a DPLL object instead, with those pins as external pins,
>> and leave the connection of the external pins to the EEC proper
>> implicit.
>
> Netdev will know how many RCLK outputs are there, as that's the
> function of a given MAC/PHY/Retimer.

So... spawn a DPLL with that number of virtual pins?

>> That gives userspace exactly the same information as the
>> netdev-centric UAPI, but now userspace doesn't need to know about
>> netdevs, and synchronously-spinning drives, and GPS receivers, each
>> of which is handled through a dedicated set of netlink messages /
>> sysctls / what have you. The userspace needs to know about EEC
>> subsystem, and that's it.
>
> I believe the direction is to make the connection between a netdev and
> its related DPLL that's serving as EEC in a similar way the link to a
> PTP device is created. Userspace app will need to go to DPLL subsystem
> to understand what's the current frequency source for a given netdev.

But the way PTP and netdevs are linked is that PTP clock is instantiated
independently, and then this clock is referenced by the netdevice. I do
not object to that at all, in fact I believe I mentioned this a couple
times already.

I'm objecting to accessing the PTP clock _through_ the netdev UAPI.
Because, how will non-NIC-bound DPLLs be represented? Well, through some
other UAPI, obviously. So userspace will need to know about all classes
of devices that can carry frequency signal.

Alternatively, both NIC drivers and other drivers can instantiate some
common type of DPLL-related object. Then any userspace tool that knows
how to work with objects of that type automatically knows how to handle
NICs, and GPSs, and whatever craziness someone dreams up.

> That's still independent uAPI from the one defined by those patches.
>
>> > The model where recovered clock outputs are controlled independently
>> > can support both models and is more flexible. It can also address the
>> 
>> - Anyone can instantiate EEC objects
>> - Only things with ports instantiate netdevs
>> 
>> How is the latter one more flexible?
>
> - Everything can instantiate DPLL object,
> - Only a netdev can instantiate recovered clock outputs, which can be
>   connected to any other part of the system - not only a DPLL.

If the frequency source devices are truly so different from the general
DPLL circuits that thay cannot possibly be expressed as the same type of
object, then by all means, represent them as something else. DPLL
frequency source, whatever.

But don't hide the API behind netdevs just because some NICs carry
DPLLs. Non-NIC frequency sources do exist, and the subsystem should
support them _in the same way_ as the NIC ones.
