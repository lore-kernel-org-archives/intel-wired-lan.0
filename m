From: Ido Schimmel <idosch@idosch.org>
Date: Mon, 8 Nov 2021 18:29:50 +0200
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <MW5PR11MB58120F585A5CF1BCA1E7E958EA919@MW5PR11MB5812.namprd11.prod.outlook.com>
References: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
 <20211105205331.2024623-7-maciej.machnikowski@intel.com>
 <YYfd7DCFFtj/x+zQ@shredder>
 <MW5PR11MB58120F585A5CF1BCA1E7E958EA919@MW5PR11MB5812.namprd11.prod.outlook.com>
Message-ID: <YYlQfm3eW/jRS4Ra@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 08, 2021 at 08:35:17AM +0000, Machnikowski, Maciej wrote:
> > -----Original Message-----
> > From: Ido Schimmel <idosch@idosch.org>
> > Sent: Sunday, November 7, 2021 3:09 PM
> > To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> > Subject: Re: [PATCH v2 net-next 6/6] docs: net: Add description of SyncE
> > interfaces
> > 
> > On Fri, Nov 05, 2021 at 09:53:31PM +0100, Maciej Machnikowski wrote:
> > > +Interface
> > > +=========
> > > +
> > > +The following RTNL messages are used to read/configure SyncE recovered
> > > +clocks.
> > > +
> > > +RTM_GETRCLKRANGE
> > > +-----------------
> > > +Reads the allowed pin index range for the recovered clock outputs.
> > > +This can be aligned to PHY outputs or to EEC inputs, whichever is
> > > +better for a given application.
> > 
> > Can you explain the difference between PHY outputs and EEC inputs? It is
> > no clear to me from the diagram.
> 
> PHY is the source of frequency for the EEC, so PHY produces the reference
> And EEC synchronizes to it.
> 
> Both PHY outputs and EEC inputs are configurable. PHY outputs usually are
> configured using PHY registers, and EEC inputs in the DPLL references
> block
>  
> > How would the diagram look in a multi-port adapter where you have a
> > single EEC?
> 
> That depends. It can be either a multiport PHY - in this case it will look
> exactly like the one I drawn. In case we have multiple PHYs their recovered
> clock outputs will go to different recovered clock inputs and each PHY
> TX clock inputs will be driven from different EEC's synchronized outputs
> or from a single one through  clock fan out.
> 
> > > +Will call the ndo_get_rclk_range function to read the allowed range
> > > +of output pin indexes.
> > > +Will call ndo_get_rclk_range to determine the allowed recovered clock
> > > +range and return them in the IFLA_RCLK_RANGE_MIN_PIN and the
> > > +IFLA_RCLK_RANGE_MAX_PIN attributes
> > 
> > The first sentence seems to be redundant
> > 
> > > +
> > > +RTM_GETRCLKSTATE
> > > +-----------------
> > > +Read the state of recovered pins that output recovered clock from
> > > +a given port. The message will contain the number of assigned clocks
> > > +(IFLA_RCLK_STATE_COUNT) and an N pin indexes in
> > IFLA_RCLK_STATE_OUT_IDX
> > > +To support multiple recovered clock outputs from the same port, this
> > message
> > > +will return the IFLA_RCLK_STATE_COUNT attribute containing the number
> > of
> > > +active recovered clock outputs (N) and N IFLA_RCLK_STATE_OUT_IDX
> > attributes
> > > +listing the active output indexes.
> > > +This message will call the ndo_get_rclk_range to determine the allowed
> > > +recovered clock indexes and then will loop through them, calling
> > > +the ndo_get_rclk_state for each of them.
> > 
> > Why do you need both RTM_GETRCLKRANGE and RTM_GETRCLKSTATE? Isn't
> > RTM_GETRCLKSTATE enough? Instead of skipping over "disabled" pins in the
> > range IFLA_RCLK_RANGE_MIN_PIN..IFLA_RCLK_RANGE_MAX_PIN, just
> > report the
> > state (enabled / disable) for all
> 
> Great idea! Will implement it.
>  
> > > +
> > > +RTM_SETRCLKSTATE
> > > +-----------------
> > > +Sets the redirection of the recovered clock for a given pin. This message
> > > +expects one attribute:
> > > +struct if_set_rclk_msg {
> > > +	__u32 ifindex; /* interface index */
> > > +	__u32 out_idx; /* output index (from a valid range)
> > > +	__u32 flags; /* configuration flags */
> > > +};
> > > +
> > > +Supported flags are:
> > > +SET_RCLK_FLAGS_ENA - if set in flags - the given output will be enabled,
> > > +		     if clear - the output will be disabled.
> > 
> > In the diagram you have two recovered clock outputs going into the EEC.
> > According to which the EEC is synchronized?
> 
> That will depend on the future DPLL configuration. For now it'll be based
> on the DPLL's auto select ability and its default configuration.
>  
> > How does user space know which pins to enable?
> 
> That's why the RTM_GETRCLKRANGE was invented but I like the suggestion
> you made above so will rework the code to remove the range one and
> just return the indexes with enable/disable bit for each of them. In this
> case youserspace will just send the RTM_GETRCLKSTATE to learn what
> can be enabled.

In the diagram there are multiple Rx lanes, all of which might be used
by the same port. How does user space know to differentiate between the
quality levels of the clock signal recovered from each lane / pin when
the information is transmitted on a per-port basis via ESMC messages?

The uAPI seems to be too low-level and is not compatible with Nvidia's
devices and potentially other vendors. We really just need a logical
interface that says "Synchronize the frequency of the EEC to the clock
recovered from port X". The kernel / drivers should abstract the inner
workings of the device from user space. Any reason this can't work for
ice?

I also want to re-iterate my dissatisfaction with the interface being
netdev-centric. By modelling the EEC as a standalone object we will be
able to extend it to set the source of the EEC to something other than a
netdev in the future. If we don't do it now, we will end up with two
ways to report the source of the EEC (i.e., EEC_SRC_PORT and something
else).

Other advantages of modelling the EEC as a separate object include the
ability for user space to determine the mapping between netdevs and EECs
(currently impossible) and reporting additional EEC attributes such as
SyncE clockIdentity and default SSM code. There is really no reason to
report all of this identical information via multiple netdevs.

With regards to rtnetlink vs. something else, in my suggestion the only
thing that should be reported per-netdev is the mapping between the
netdev and the EEC. Similar to the way user space determines the mapping
from netdev to PHC via ETHTOOL_GET_TS_INFO. If we go with rtnetlink,
this can be reported as a new attribute in RTM_NEWLINK, no need to add
new messages.
