From: Petr Machata <petrm@nvidia.com>
Date: Tue, 16 Nov 2021 12:52:42 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <MW5PR11MB5812E733ED2BB621A3249CD5EA989@MW5PR11MB5812.namprd11.prod.outlook.com>
References: <20211110114448.2792314-1-maciej.machnikowski@intel.com>
 <20211110114448.2792314-7-maciej.machnikowski@intel.com>
 <87tugic17a.fsf@nvidia.com>
 <MW5PR11MB5812E733ED2BB621A3249CD5EA989@MW5PR11MB5812.namprd11.prod.outlook.com>
Message-ID: <87fsrwtj05.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:

>> - Reporting pins through the netdevices that use them allows for
>>   configurations that are likely invalid, like disjoint "frequency
>>   bridges".
>
> Not sure if I understand that comment. In target application a given
> netdev will receive an ESMC message containing the quality of the
> clock that it has on the receive side. The upper layer software will
> see QL_PRC on one port and QL_EEC on other and will need to enable
> clock output from the port that received QL_PRC, as it's the higher clock
> class. Once the EEC reports Locked state all other ports that are traceable
> to a given EEC (either using the DPLL subsystem, or the config file)
> will start reporting QL_PRC to downstream devices.

I think I had the reading of the UAPI wrong. So RTM_SETRCLKSTATE means,
take the clock recovered from ifindex, and send it to pins that I have
marked with the ENA flag.

But that still does not work well for multi-port devices. I can set it
up to forward frequency from swp1 to swp2 and swp3, from swp4 to swp5
and swp6, etc. But in reality I only have one underlying DPLL and can't
support this. So yeah, obviously, I bounce it in the driver. It also
means that when I want to switch tracking from swp1 to swp2, I first
need to unset all the swp1 pins (64 messages or whaveter) and then set
it up at swp2 (64 more messages). As a user I still don't know which of
my ports share DPLL. It's just not a great interface for multi-port
devices.

Having this stuff at a dedicated DPLL object would make the issue go
away completely. A driver then instantiates one DPLL, sets it up with
RCLK pins and TX pins. The DPLL can be configured with which pin to take
the frequency from, and which subset of pins to forward it to. There are
as many DPLL objects as there are DPLL circuits in the system.

This works for simple port devices as well as switches, as well as
non-networked devices.

The in-driver LOC overhead is a couple of _init / _fini calls and an ops
structure that the DPLL subsystem uses to talk to the driver. Everything
else remains the same.

>> - It's not clear what enabling several pins means, and it's not clear
>>   whether this genericity is not going to be an issue in the future when
>>   we know what enabling more pins means.
>
> It means that the recovered frequency will appear on 2 or more physical
> pins of the package.

Yes, agreed now.
