From: Ido Schimmel <idosch@idosch.org>
Date: Tue, 21 Sep 2021 17:58:05 +0300
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <PH0PR11MB4951E98FCEC0F1EA230BA1DAEAA19@PH0PR11MB4951.namprd11.prod.outlook.com>
References: <20210903151436.529478-1-maciej.machnikowski@intel.com>
 <20210903151436.529478-2-maciej.machnikowski@intel.com>
 <YUnbCzBOPP9hWQ5c@shredder>
 <PH0PR11MB4951E98FCEC0F1EA230BA1DAEAA19@PH0PR11MB4951.namprd11.prod.outlook.com>
Message-ID: <YUny/edqnbdTFnBS@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Sep 21, 2021 at 01:37:37PM +0000, Machnikowski, Maciej wrote:
> > -----Original Message-----
> > From: Ido Schimmel <idosch@idosch.org>
> > Sent: Tuesday, September 21, 2021 3:16 PM
> > To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> > Subject: Re: [PATCH net-next 1/2] rtnetlink: Add new RTM_GETEECSTATE
> > message to get SyncE status
> > 
> > On Fri, Sep 03, 2021 at 05:14:35PM +0200, Maciej Machnikowski wrote:
> > > diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> > > index eebd3894fe89..78a8a5af8cd8 100644
> > > --- a/include/uapi/linux/if_link.h
> > > +++ b/include/uapi/linux/if_link.h
> > > @@ -1273,4 +1273,35 @@ enum {
> > >
> > >  #define IFLA_MCTP_MAX (__IFLA_MCTP_MAX - 1)
> > >
> > > +/* SyncE section */
> > > +
> > > +enum if_eec_state {
> > > +	IF_EEC_STATE_INVALID = 0,
> > > +	IF_EEC_STATE_FREERUN,
> > > +	IF_EEC_STATE_LOCKACQ,
> > > +	IF_EEC_STATE_LOCKREC,
> > > +	IF_EEC_STATE_LOCKED,
> > > +	IF_EEC_STATE_HOLDOVER,
> > > +	IF_EEC_STATE_OPEN_LOOP,
> > > +	__IF_EEC_STATE_MAX,
> > 
> > Can you document these states? I'm not clear on what LOCKACQ, LOCKREC
> > and OPEN_LOOP mean. I also don't see ice using them and it's not really
> > a good practice to add new uAPI without any current users.
> > 
> 
> I'll fix that enum to use generic states defined in G.781 which are limited to:
> - Freerun
> - LockedACQ (locked, acquiring holdover memory)
> - Locked (locked with holdover acquired)
> - Holdover

Thanks, it is good to conform to a standard.

Can ice distinguish between LockedACQ and Locked? From G.781 I
understand that the former is a transient state. Is the distinction
between the two important for user space / the selection operation? If
not, maybe we only need Locked?

> 
> > From v1 I understand that these states were copied from commit
> > 797d3186544f ("ptp: ptp_clockmatrix: Add wait_for_sys_apll_dpll_lock.")
> > from Renesas.
> > 
> > Figure 11 in the following PDF describes the states, but it seems
> > specific to the particular device and probably shouldn't be exposed to
> > user space as-is:
> > https://www.renesas.com/us/en/document/dst/8a34041-datasheet
> > 
> > I have a few questions about this being a per-netdev attribute:
> > 
> > 1. My understanding is that in the multi-port adapter you are working
> > with you have a single EEC that is used to set the Tx frequency of all
> > the ports. Is that correct?
> 
> That's correct.
>  
> > 2. Assuming the above is correct, is it possible that one port is in
> > LOCKED state and another (for some reason) is in HOLDOVER state? If yes,
> > then I agree about this being a per-netdev attribute. The interface can
> > also be extended with another attribute specifying the HOLDOVER reason.
> > For example, netdev being down.
> 
> All ports driven by a single EEC will report the same state.

So maybe we just need to report via ethtool the association between the
EEC and the netdev and expose the state as an attribute of the EEC
(along with the selected source and other info)?

This is similar to how PHC/netdev association is queried via ethtool.
For a given netdev, TSINFO_GET will report the PTP hw clock index via
ETHTOOL_A_TSINFO_PHC_INDEX. See Documentation/networking/ethtool-netlink.rst

> 
> > Regardless, I agree with previous comments made about this belonging in
> > ethtool rather than rtnetlink.
> 
> Will take a look at it - as it will require support in linuxptp as well.
> 
> > > +};
> > > +
> > > +#define IF_EEC_STATE_MAX	(__IF_EEC_STATE_MAX - 1)
> > > +#define EEC_SRC_PORT		(1 << 0) /* recovered clock from the
> > port is
> > > +					  * currently the source for the EEC
> > > +					  */
> > 
> > I'm not sure about this one. If we are going to expose this as a
> > per-netdev attribute (see more below), any reason it can't be added as
> > another state (e.g., IF_EEC_STATE_LOCKED_SRC)?
> 
> OK! That's a great idea! Yet we'll need LOCKED_SRC and LOCKED_ACQ_SRC,
> but still sounds good.
> 
> > IIUC, in the common case of a simple NE the source of the EEC is always
> > one of the ports, but in the case of a PRC the source is most likely
> > external (e.g., GPS).
> 
> True
> 
> > If so, I think we need a way to represent the EEC as a separate object
> > with the ability to set its source and report it via the same interface.
> > I'm unclear on how exactly an external source looks like, but for the
> > netdev case maybe something like this:
> > 
> > devlink clock show [ dev clock CLOCK ]
> > devlink clock set DEV clock CLOCK [ { src_type SRC_TYPE } ]
> > SRC_TYPE : = { port DEV/PORT_INDEX }
> 
> Unfortunately, EEC lives in 2 worlds - it belongs to a netdev (in very simple
> deployments the EEC may be a part of the PHY and only allow synchronizing
> the TX frequency to a single lane/port), but also can go outside of netdev
> and be a boar-wise frequency source.
> 
> > The only source type above is 'port' with the ability to set the
> > relevant port, but more can be added. Obviously, 'devlink clock show'
> > will give you the current source in addition to other information such
> > as frequency difference with respect to the input frequency.
> 
> We considered devlink interface for configuring the clock/DPLL, but a
> new concept was born at the list to add a DPLL subsystem that will
> cover more use cases, like a TimeCard.

The reason I suggested devlink is that it is suited for device-wide
configuration and it is already used by both MAC drivers and the
TimeCard driver. If we have a good reason to create a new generic
netlink family for this stuff, then OK.

> 
> > Finally, can you share more info about the relation to the PHC? My
> > understanding is that one of the primary use cases for SyncE is to drive
> > all the PHCs in the network using the same frequency. How do you imagine
> > this configuration is going to look like? Can the above interface be
> > extended for that?
> 
> That would be a configurable parameter/option of the PTP program.
> Just like it can check the existence of link on a given port, it'll also be
> able to check if we use EEC and it's locked. If it is, and is a source of
> PHC frequency - the ptp tool can decide to not apply frequency corrections
> to the PHC, just like the ptp4l does when nullf servo is used, but can do that
> dynamically.

The part I don't understand is "is a source of PHC frequency". How do we
configure / query that?
