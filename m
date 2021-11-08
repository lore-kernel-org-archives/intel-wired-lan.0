From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Mon, 8 Nov 2021 08:35:17 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <YYfd7DCFFtj/x+zQ@shredder>
References: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
 <20211105205331.2024623-7-maciej.machnikowski@intel.com>
 <YYfd7DCFFtj/x+zQ@shredder>
Message-ID: <MW5PR11MB58120F585A5CF1BCA1E7E958EA919@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Ido Schimmel <idosch@idosch.org>
> Sent: Sunday, November 7, 2021 3:09 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH v2 net-next 6/6] docs: net: Add description of SyncE
> interfaces
> 
> On Fri, Nov 05, 2021 at 09:53:31PM +0100, Maciej Machnikowski wrote:
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
> 
> Can you explain the difference between PHY outputs and EEC inputs? It is
> no clear to me from the diagram.

PHY is the source of frequency for the EEC, so PHY produces the reference
And EEC synchronizes to it.

Both PHY outputs and EEC inputs are configurable. PHY outputs usually are
configured using PHY registers, and EEC inputs in the DPLL references
block
 
> How would the diagram look in a multi-port adapter where you have a
> single EEC?

That depends. It can be either a multiport PHY - in this case it will look
exactly like the one I drawn. In case we have multiple PHYs their recovered
clock outputs will go to different recovered clock inputs and each PHY
TX clock inputs will be driven from different EEC's synchronized outputs
or from a single one through  clock fan out.

> > +Will call the ndo_get_rclk_range function to read the allowed range
> > +of output pin indexes.
> > +Will call ndo_get_rclk_range to determine the allowed recovered clock
> > +range and return them in the IFLA_RCLK_RANGE_MIN_PIN and the
> > +IFLA_RCLK_RANGE_MAX_PIN attributes
> 
> The first sentence seems to be redundant
> 
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
> Why do you need both RTM_GETRCLKRANGE and RTM_GETRCLKSTATE? Isn't
> RTM_GETRCLKSTATE enough? Instead of skipping over "disabled" pins in the
> range IFLA_RCLK_RANGE_MIN_PIN..IFLA_RCLK_RANGE_MAX_PIN, just
> report the
> state (enabled / disable) for all

Great idea! Will implement it.
 
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
> In the diagram you have two recovered clock outputs going into the EEC.
> According to which the EEC is synchronized?

That will depend on the future DPLL configuration. For now it'll be based
on the DPLL's auto select ability and its default configuration.
 
> How does user space know which pins to enable?

That's why the RTM_GETRCLKRANGE was invented but I like the suggestion
you made above so will rework the code to remove the range one and
just return the indexes with enable/disable bit for each of them. In this
case youserspace will just send the RTM_GETRCLKSTATE to learn what
can be enabled.

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
> > \ No newline at end of file
> > --
> > 2.26.3
> >
