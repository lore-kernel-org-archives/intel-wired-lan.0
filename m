From: Petr Machata <petrm@nvidia.com>
Date: Mon, 6 Dec 2021 15:40:43 +0100
Subject: [Intel-wired-lan] [PATCH v4 net-next 2/4] ethtool: Add ability
 to configure recovered clock for SyncE feature
In-Reply-To: <MW5PR11MB5812AA2C625AC00616F94A2AEA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
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
Message-ID: <87czm9okyc.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:

>> -----Original Message-----
>> From: Petr Machata <petrm@nvidia.com>
>> 
>> Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:
>> 
>> > Additionally, the EEC device may be instantiated by a totally
>> > different driver, in which case the relation between its pins and
>> > netdevs may not even be known.
>> 
>> Like an EEC, some PHYs, but the MAC driver does not know about both
>> pieces? Who sets up the connection between the two? The box admin
>> through some cabling? SoC designer?
>> 
>> Also, what does the external EEC actually do with the signal from the
>> PHY? Tune to it and forward to the other PHYs in the complex?
>
> Yes - it can also apply HW filters to it.

Sounds like this device should have an EEC instance of its own then.

Maybe we need to call it something else than "EEC". PLL? Something that
does not have the standardization connotations, because several
instances would be present in a system with several NICs.

> The EEC model will not work when you have the following system:
> SoC with some ethernet ports with driver A
> Switch chip with N ports with driver B
> EEC/DPLL with driver C
> Both SoC and Switch ASIC can recover clock and use the cleaned
> clock from the DPLL.
>
> In that case you can't create any relation between EEC and recover
> clock pins that would enable the EEC subsystem to control
> recovered clocks, because you have 3 independent drivers.

I think that in that case you have several EEC instances. Those are
connected by some wiring that is external to the devices themselves. I
am not sure who should be in charge of describing the wiring. Device
tree? Config file?

> The model you proposed assumes that the MAC/Switch is in
> charge of the DPLL, but that's not always true.

The EEC-centric model does not in fact assume that. It lets anyone to
set up an EEC object.

The netdev-centric UAPI assumes that the driver behind the netdev knows
about how many RCLK out pins there are. So it can certainly instantiate
a DPLL object instead, with those pins as external pins, and leave the
connection of the external pins to the EEC proper implicit.

That gives userspace exactly the same information as the netdev-centric
UAPI, but now userspace doesn't need to know about netdevs, and
synchronously-spinning drives, and GPS receivers, each of which is
handled through a dedicated set of netlink messages / sysctls / what
have you. The userspace needs to know about EEC subsystem, and that's
it.

> The model where recovered clock outputs are controlled independently
> can support both models and is more flexible. It can also address the

- Anyone can instantiate EEC objects
- Only things with ports instantiate netdevs

How is the latter one more flexible?

> mode where you want to use the recovered clock as a source for RF part
> of your system and don't have any EEC to control from the netdev side.
