From: Petr Machata <petrm@nvidia.com>
Date: Tue, 16 Nov 2021 12:07:55 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <MW5PR11MB5812E733ED2BB621A3249CD5EA989@MW5PR11MB5812.namprd11.prod.outlook.com>
References: <20211110114448.2792314-1-maciej.machnikowski@intel.com>
 <20211110114448.2792314-7-maciej.machnikowski@intel.com>
 <87tugic17a.fsf@nvidia.com>
 <MW5PR11MB5812E733ED2BB621A3249CD5EA989@MW5PR11MB5812.namprd11.prod.outlook.com>
Message-ID: <87k0h8tl2s.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Machnikowski, Maciej <maciej.machnikowski@intel.com> writes:

>> -----Original Message-----
>> From: Petr Machata <petrm@nvidia.com>
>> Sent: Thursday, November 11, 2021 1:43 PM
>> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
>> Subject: Re: [PATCH v3 net-next 6/6] docs: net: Add description of SyncE
>> interfaces
>> 
>> 
>> Maciej Machnikowski <maciej.machnikowski@intel.com> writes:
>> 
>> > Add Documentation/networking/synce.rst describing new RTNL messages
>> > and respective NDO ops supporting SyncE (Synchronous Ethernet).
>> >
>> > Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
>> > ---
> ...
>> > +RTM_GETEECSTATE
>> > +----------------
>> > +Reads the state of the EEC or equivalent physical clock synchronizer.
>> > +This message returns the following attributes:
>> > +IFLA_EEC_STATE - current state of the EEC or equivalent clock generator.
>> > +		 The states returned in this attribute are aligned to the
>> > +		 ITU-T G.781 and are:
>> > +		  IF_EEC_STATE_INVALID - state is not valid
>> > +		  IF_EEC_STATE_FREERUN - clock is free-running
>> > +		  IF_EEC_STATE_LOCKED - clock is locked to the reference,
>> > +		                        but the holdover memory is not valid
>> > +		  IF_EEC_STATE_LOCKED_HO_ACQ - clock is locked to the
>> reference
>> > +		                               and holdover memory is valid
>> > +		  IF_EEC_STATE_HOLDOVER - clock is in holdover mode
>> > +State is read from the netdev calling the:
>> > +int (*ndo_get_eec_state)(struct net_device *dev, enum if_eec_state
>> *state,
>> > +			 u32 *src_idx, struct netlink_ext_ack *extack);
>> > +
>> > +IFLA_EEC_SRC_IDX - optional attribute returning the index of the
>> reference
>> > +		   that is used for the current IFLA_EEC_STATE, i.e.,
>> > +		   the index of the pin that the EEC is locked to.
>> > +
>> > +Will be returned only if the ndo_get_eec_src is implemented.
>> > \ No newline at end of file
>> 
>> Just to be clear, I have much the same objections to this UAPI as I had
>> to v2:
>> 
>> - RTM_GETEECSTATE will become obsolete as soon as DPLL object is added.
>
> Yes for more complex devices and no for simple ones

If we have an interface suitable for more complex netdevices, the
simpler ones can use it as well. Should in fact. There should not be two
interfaces for the same thing. For reasons of maintenance,
documentation, tool support, user experience.
