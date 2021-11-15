From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Mon, 15 Nov 2021 10:24:46 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <87tugic17a.fsf@nvidia.com>
References: <20211110114448.2792314-1-maciej.machnikowski@intel.com>
 <20211110114448.2792314-7-maciej.machnikowski@intel.com>
 <87tugic17a.fsf@nvidia.com>
Message-ID: <MW5PR11MB5812E733ED2BB621A3249CD5EA989@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Petr Machata <petrm@nvidia.com>
> Sent: Thursday, November 11, 2021 1:43 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH v3 net-next 6/6] docs: net: Add description of SyncE
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
...
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
> reference
> > +		   that is used for the current IFLA_EEC_STATE, i.e.,
> > +		   the index of the pin that the EEC is locked to.
> > +
> > +Will be returned only if the ndo_get_eec_src is implemented.
> > \ No newline at end of file
> 
> Just to be clear, I have much the same objections to this UAPI as I had
> to v2:
> 
> - RTM_GETEECSTATE will become obsolete as soon as DPLL object is added.

Yes for more complex devices and no for simple ones

> - Reporting pins through the netdevices that use them allows for
>   configurations that are likely invalid, like disjoint "frequency
>   bridges".

Not sure if I understand that comment. In target application a given
netdev will receive an ESMC message containing the quality of the
clock that it has on the receive side. The upper layer software will
see QL_PRC on one port and QL_EEC on other and will need to enable
clock output from the port that received QL_PRC, as it's the higher clock
class. Once the EEC reports Locked state all other ports that are traceable
to a given EEC (either using the DPLL subsystem, or the config file)
will start reporting QL_PRC to downstream devices.

> - It's not clear what enabling several pins means, and it's not clear
>   whether this genericity is not going to be an issue in the future when
>   we know what enabling more pins means.

It means that the recovered frequency will appear on 2 or more physical
pins of the package.
 
> - No way as a user to tell whether two interfaces that report the same
>   pins are actually connected to the same EEC. How many EEC's are there,
>   in the system, anyway?

For now we can fix that with the config file, for future we will be able to
trace them to the same EEC. It's like BC in PTP - you can rely on automated
mode, but can also override it with the config file.

> In particular, I think that the proposed UAPIs should belong to a DPLL
> object. That object must know about the pins, so have it enumerate them.
> That object needs to know about which pin/s to track, so configure it
> there. That object has the state, so have it report it. Really, it looks
> basically 1:1 vs. the proposed API, except the object over which the
> UAPIs should be defined is a DPLL, not a netdev.

RCLK pin API does not belong to the DPLL and never will. That part
will always belong to the netdev.
