From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Tue, 9 Nov 2021 10:43:20 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <87r1bqcyto.fsf@nvidia.com>
References: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
 <20211105205331.2024623-7-maciej.machnikowski@intel.com>
 <87r1bqcyto.fsf@nvidia.com>
Message-ID: <MW5PR11MB5812B0A4E6227C6896AC12B5EA929@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Petr Machata <petrm@nvidia.com>
> Sent: Monday, November 8, 2021 7:00 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> richardcochran at gmail.com; abyagowi at fb.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
> linux-kselftest at vger.kernel.org; idosch at idosch.org; mkubecek at suse.cz;
> saeed at kernel.org; michael.chan at broadcom.com
> Subject: Re: [PATCH v2 net-next 6/6] docs: net: Add description of SyncE
> interfaces
> 
> 
> Maciej Machnikowski <maciej.machnikowski@intel.com> writes:
> 
> > Add Documentation/networking/synce.rst describing new RTNL messages
> > and respective NDO ops supporting SyncE (Synchronous Ethernet).
> >
> > Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> > ---
> >  Documentation/networking/synce.rst | 117
> +++++++++++++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >  create mode 100644 Documentation/networking/synce.rst
> >
> > diff --git a/Documentation/networking/synce.rst
> b/Documentation/networking/synce.rst
> > new file mode 100644
> > index 000000000000..4ca41fb9a481
> > --- /dev/null
> > +++ b/Documentation/networking/synce.rst
> > @@ -0,0 +1,117 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +====================
> > +Synchronous Ethernet
> > +====================
> > +
> > +Synchronous Ethernet networks use a physical layer clock to syntonize
> > +the frequency across different network elements.
> > +
> > +Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
> > +Equipment Clock (EEC) and a PHY that has dedicated outputs of recovered
> clocks
> > +and a dedicated TX clock input that is used as to transmit data to other
> nodes.
> > +
> > +The SyncE capable PHY is able to recover the incomning frequency of the
> data
> > +stream on RX lanes and redirect it (sometimes dividing it) to recovered
> > +clock outputs. In SyncE PHY the TX frequency is directly dependent on the
> > +input frequency - either on the PHY CLK input, or on a dedicated
> > +TX clock input.
> > +
> > +      ????????????????????????
> > +      ? RX        ? TX       ?
> > +  1   ? lanes     ? lanes    ? 1
> > +  ????????????    ?          ???????
> > +  2   ?      ?    ?          ? 2
> > +  ????????   ?    ?          ???????
> > +  3   ?  ?   ?    ?          ? 3
> > +  ????????   ?    ?          ???????
> > +      ? ??????    ?          ?
> > +      ? \____/    ?          ?
> > +      ????????????????????????
> > +        1? 2?        ?
> > + RCLK out?  ?        ? TX CLK in
> > +         ?  ?        ?
> > +       ???????????????????
> > +       ?                 ?
> > +       ?       EEC       ?
> > +       ?                 ?
> > +       ???????????????????
> > +
> > +The EEC can synchronize its frequency to one of the synchronization
> inputs
> > +either clocks recovered on traffic interfaces or (in advanced deployments)
> > +external frequency sources.
> > +
> > +Some EEC implementations can select synchronization source through
> > +priority tables and synchronization status messaging and provide
> necessary
> > +filtering and holdover capabilities.
> > +
> > +The following interface can be applicable to diffferent packet network
> types
> > +following ITU-T G.8261/G.8262 recommendations.
> > +
> > +Interface
> > +=========
> > +
> > +The following RTNL messages are used to read/configure SyncE recovered
> > +clocks.
> > +
> > +RTM_GETRCLKRANGE
> > +-----------------
> > +Reads the allowed pin index range for the recovered clock outputs.
> > +This can be aligned to PHY outputs or to EEC inputs, whichever is
> > +better for a given application.
> > +Will call the ndo_get_rclk_range function to read the allowed range
> > +of output pin indexes.
> > +Will call ndo_get_rclk_range to determine the allowed recovered clock
> > +range and return them in the IFLA_RCLK_RANGE_MIN_PIN and the
> > +IFLA_RCLK_RANGE_MAX_PIN attributes
> > +
> > +RTM_GETRCLKSTATE
> > +-----------------
> > +Read the state of recovered pins that output recovered clock from
> > +a given port. The message will contain the number of assigned clocks
> > +(IFLA_RCLK_STATE_COUNT) and an N pin indexes in
> IFLA_RCLK_STATE_OUT_IDX
> > +To support multiple recovered clock outputs from the same port, this
> message
> > +will return the IFLA_RCLK_STATE_COUNT attribute containing the number
> of
> > +active recovered clock outputs (N) and N IFLA_RCLK_STATE_OUT_IDX
> attributes
> > +listing the active output indexes.
> > +This message will call the ndo_get_rclk_range to determine the allowed
> > +recovered clock indexes and then will loop through them, calling
> > +the ndo_get_rclk_state for each of them.
> 
> Let me make sure I understand the model that you propose. Specifically
> from the point of view of a multi-port device, because that's my
> immediate use case.
> 
> RTM_GETRCLKRANGE would report number of "pins" that matches the
> number
> of lanes in the system. So e.g. a 32-port switch, where each port has 4
> lanes, would give a range of [1; 128], inclusive. (Or maybe [0; 128) or
> whatever.)
> 
> RTM_GETRCLKSTATE would then return some subset of those pins,
> depending
> on which lanes actually managed to establish a connection and carry a
> valid clock signal. So, say, [1, 2, 3, 4] if the first port has e.g. a
> 100Gbps established.
> 

Those 2 will be merged into a single RTM_GETRCLKSTATE that will report
the state of all available pins for a given port.

Also lanes here should really be ports - will fix in next revision.

But the logic will be: 
Call the RTM_GETRCLKSTATE. It will return the list of pins and their state
for a given port. Once you read the range you will send the RTM_SETRCLKSTATE
to enable the redirection to a given RCLK output from the PHY. If your DPLL/EEC
is configured to accept it automatically - it's all you need to do and you need to
wait for the right state of the EEC (locked/locked with HO).

> > +
> > +RTM_SETRCLKSTATE
> > +-----------------
> > +Sets the redirection of the recovered clock for a given pin. This message
> > +expects one attribute:
> > +struct if_set_rclk_msg {
> > +	__u32 ifindex; /* interface index */
> > +	__u32 out_idx; /* output index (from a valid range)
> > +	__u32 flags; /* configuration flags */
> > +};
> > +
> > +Supported flags are:
> > +SET_RCLK_FLAGS_ENA - if set in flags - the given output will be enabled,
> > +		     if clear - the output will be disabled.
> 
> OK, so here I set up the tracking. ifindex tells me which EEC to
> configure, out_idx is the pin to track, flags tell me whether to set up
> the tracking or tear it down. Thus e.g. on port 2, track pin 2, because
> I somehow know that lane 2 has the best clock.

It's bound to ifindex to know which PHY port you interact with. It has nothing to
do with the EEC yet.
 
> If the above is broadly correct, I've got some questions.
> 
> First, what if more than one out_idx is set? What are drivers / HW meant
> to do with this? What is the expected behavior?

Expected behavior is deployment specific. You can use different phy recovered
clock outputs to implement active/passive mode of clock failover.

> Also GETRCLKSTATE and SETRCLKSTATE have a somewhat different scope:
> one
> reports which pins carry a clock signal, the other influences tracking.
> That seems wrong. There also does not seems to be an UAPI to retrieve
> the tracking settings.

They don't. Get reads the redirection state and SET sets it - nothing more,
nothing less. In ICE we use EEC pin indexes so that the model translates easier
to the one when we support DPLL subsystem.

> Second, as a user-space client, how do I know that if ports 1 and 2 both
> report pin range [A; B], that they both actually share the same
> underlying EEC? Is there some sort of coordination among the drivers,
> such that each pin in the system has a unique ID?

For now we don't, as we don't have EEC subsystem. But that can be solved
by a config file temporarily.

> Further, how do I actually know the mapping from ports to pins? E.g. as
> a user, I might know my master is behind swp1. How do I know what pins
> correspond to that port? As a user-space tool author, how do I help
> users to do something like "eec set clock eec0 track swp1"?

That's why driver needs to be smart there and return indexes properly.

> Additionally, how would things like external GPSs or 1pps be modeled? I
> guess the driver would know about such interface, and would expose it as
> a "pin". When the GPS signal locks, the driver starts reporting the pin
> in the RCLK set. Then it is possible to set up tracking of that pin.

That won't be enabled before we get the DPLL subsystem ready.
 
> It seems to me it would be easier to understand, and to write user-space
> tools and drivers for, a model that has EEC as an explicit first-class
> object. That's where the EEC state naturally belongs, that's where the
> pin range naturally belongs. Netdevs should have a reference to EEC and
> pins, not present this information as if they own it. A first-class EEC
> would also allow to later figure out how to hook up PHC and EEC.

We have the userspace tool, but can?t upstream it until we define kernel 
Interfaces. It's paragraph 22 :(

Regards
Maciek

> > +
> > +RTM_GETEECSTATE
> > +----------------
> > +Reads the state of the EEC or equivalent physical clock synchronizer.
> > +This message returns the following attributes:
> > +IFLA_EEC_STATE - current state of the EEC or equivalent clock generator.
> > +		 The states returned in this attribute are aligned to the
> > +		 ITU-T G.781 and are:
> > +		  IF_EEC_STATE_INVALID - state is not valid
> > +		  IF_EEC_STATE_FREERUN - clock is free-running
> > +		  IF_EEC_STATE_LOCKED - clock is locked to the reference,
> > +		                        but the holdover memory is not valid
> > +		  IF_EEC_STATE_LOCKED_HO_ACQ - clock is locked to the
> reference
> > +		                               and holdover memory is valid
> > +		  IF_EEC_STATE_HOLDOVER - clock is in holdover mode
> > +State is read from the netdev calling the:
> > +int (*ndo_get_eec_state)(struct net_device *dev, enum if_eec_state
> *state,
> > +			 u32 *src_idx, struct netlink_ext_ack *extack);
> > +
> > +IFLA_EEC_SRC_IDX - optional attribute returning the index of the
> reference that
> > +		   is used for the current IFLA_EEC_STATE, i.e., the index of
> > +		   the pin that the EEC is locked to.
> > +
> > +Will be returned only if the ndo_get_eec_src is implemented.
