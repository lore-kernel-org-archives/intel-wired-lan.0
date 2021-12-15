From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Wed, 15 Dec 2021 12:13:47 +0000
Subject: [Intel-wired-lan] [PATCH v5 net-next 0/4] Add ethtool interface
 for RClocks
In-Reply-To: <YbXhXstRpzpQRBR8@shredder>
References: <20211210134550.1195182-1-maciej.machnikowski@intel.com>
 <YbXhXstRpzpQRBR8@shredder>
Message-ID: <MW5PR11MB5812E5A30C05E2F1EAB2D9D5EA769@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Ido Schimmel <idosch@idosch.org>
> Sent: Sunday, December 12, 2021 12:48 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH v5 net-next 0/4] Add ethtool interface for RClocks
> 
> On Fri, Dec 10, 2021 at 02:45:46PM +0100, Maciej Machnikowski wrote:
> > Synchronous Ethernet networks use a physical layer clock to syntonize
> > the frequency across different network elements.
> >
> > Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
> > Equipment Clock (EEC) and have the ability to synchronize to reference
> > frequency sources.
> >
> > This patch series is a prerequisite for EEC object and adds ability
> > to enable recovered clocks in the physical layer of the netdev object.
> > Recovered clocks can be used as one of the reference signal by the EEC.
> 
> The dependency is the other way around. It doesn't make sense to add
> APIs to configure the inputs of an object that doesn't exist. First add
> the EEC object, then we can talk about APIs to configure its inputs from
> netdevs.

This API configures frequency outputs of the PTY layer of
a PHY/integrated MAC. It does not configure any inputs nor it interacts
with the EEC. The goal of it is to expose the clock to the piece that
requires it as a reference one (a DPLL/FPGA/anything else).

I don't agree with the statement that we must have EEC object first,
as we can already configure different frequency sources using different
subsystems. The source of signal should be separated from its
consumer.
 
> With these four patches alone, user space doesn't know how many EECs
> there are in the system, it doesn't know the mapping from netdev to EEC,
> it doesn't know the state of the EEC, it doesn't know which source is
> chosen in case more than one source is enabled. Patch #3 tries to work
> around it by having ice print to kernel log, when the information should
> really be exposed via the EEC object.

The goal of them is to add API for recovered clocks - not for EECs. This part 
is there for observability and will still be there when EEC is in place.
Those will need to be addressed by the DPLL subsystem.

> +		dev_warn(ice_pf_to_dev(pf),
> +			 "<DPLL%i> state changed to: %d, pin %d",
> +			 ICE_CGU_DPLL_SYNCE,
> +			 pf->synce_dpll_state,
> +			 pin);
> 
> >
> > Further work is required to add the DPLL subsystem, link it to the
> > netdev object and create API to read the EEC DPLL state.
> 
> When the EEC object materializes, we might find out that this API needs
> to be changed / reworked / removed, but we won't be able to do that
> given it's uAPI. I don't know where the confidence that it won't happen
> stems from when there are so many question marks around this new
> object.

This API follows the functionality of other frequency outputs that exist
in the kernel, like PTP period file for frequency output of PTP clock
or other GPIOs. I highly doubt it'll change - we may extend it to add mapping
between pins, but like I indicated - this will not always be known to SW.

Regards
Maciek
