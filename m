From: Ertman, David M <david.m.ertman@intel.com>
Date: Tue, 22 Feb 2022 22:30:49 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix error with handling
 of bonding MTU
In-Reply-To: <6b531cbb-76c0-3c9f-fd20-f0e3b5fd12ed@redhat.com>
References: <20220218190604.1888716-1-david.m.ertman@intel.com>
 <6b531cbb-76c0-3c9f-fd20-f0e3b5fd12ed@redhat.com>
Message-ID: <MW5PR11MB5811BFA8616F2CDB01105426DD3B9@MW5PR11MB5811.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Jonathan Toppins <jtoppins@redhat.com>
> Sent: Sunday, February 20, 2022 7:51 PM
> To: Ertman, David M <david.m.ertman@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: Fix error with handling of
> bonding MTU
> 
> On 2/18/22 14:06, Dave Ertman wrote:
> > When a bonded interface is destroyed, .ndo_change_mtu can be called
> > during the tear-down process while the RTNL lock is held.  This is a
> > problem since the auxiliary driver linked to the LAN driver needs to be
> > notified of the MTU change, and this requires grabbing a device_lock on
> > the auxiliary_device's dev.  Currently this is being attempted in the
> > same execution context as the call to .ndo_change_mtu which is causing a
> > dead-lock.
> >
> > Move the notification of the changed MTU to a separate execution context
> > (watchdog service task) and eliminate the "before" notification.
> 
> It would seem all net notifiers for the aux driver could suffer from
> this architectural design. Is there any effort to look at the design and
> move all notifications to a delayed work queue to avoid this recursive
> lock problem? I do not think ndo_change_mtu is the only net device
> operation that takes or expects RTNL to be held. Additionally what
> requirements does the auxiliary driver have that require the
> notification to be immediately processed?
> 
> Just trying to think of how to avoid this class of bugs all together
> instead of finding them one-by-one.
> 
> Regards,
> -Jon
> 

Hi Jon,

Thanks for the feedback.  I took a look at what contexts that IDC events could be generated in.

The first (which was the original issue) is with the interface entering or leaving a link aggregate.
The only other one that I see now is with the ndo_change_mtu callback being accessed with the
RTNL lock being held.

All of the other events that would need to be sent to the auxiliary driver(s) are things that should
not be generated in a lock-held context.  They also need to act as blocking calls that stop the flow
of the thread until the auxiliary driver has dealt with the event and returned.

The basic concept of holding the device_lock on the auxiliary device while accessing the auxiliary driver's
event handler is to avoid a race condition where the auxiliary driver is unloaded.  The only time that the
PCI LAN driver can be assured that the state of the auxiliary driver will not change is between the
device_lock and device_unlock.

I believe that with this change we should be ok for now.  I do have some work progressing in providing
support for co-existence between RDMA and LAG that I will definitely have to account for this issue for.


> >
> > Fixes: 348048e724a0e ("ice: Implement iidc operations")
> > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice.h      |  1 +
> >   drivers/net/ethernet/intel/ice/ice_main.c | 29 +++++++++++------------
> >   2 files changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> > index 8f40f6f9b8eb..219b7c9d230e 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -487,6 +487,7 @@ enum ice_pf_flags {
> >   	ICE_FLAG_VF_VLAN_PRUNING,
> >   	ICE_FLAG_LINK_LENIENT_MODE_ENA,
> >   	ICE_FLAG_PLUG_AUX_DEV,
> > +	ICE_FLAG_MTU_CHANGED,
> >   	ICE_PF_FLAGS_NBITS		/* must be last */
> >   };
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> > index cff476f735ef..f81b4732b8b2 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -2259,6 +2259,17 @@ static void ice_service_task(struct work_struct
> *work)
> >   	if (test_and_clear_bit(ICE_FLAG_PLUG_AUX_DEV, pf->flags))
> >   		ice_plug_aux_dev(pf);
> >
> > +	if (test_and_clear_bit(ICE_FLAG_MTU_CHANGED, pf->flags)) {
> > +		struct iidc_event *event;
> > +
> > +		event = kzalloc(sizeof(*event), GFP_KERNEL);
> > +		if (event) {
> > +			set_bit(IIDC_EVENT_AFTER_MTU_CHANGE, event-
> >type);
> > +			ice_send_event_to_aux(pf, event);
> > +			kfree(event);
> > +		}
> > +	}
> > +
> >   	ice_clean_adminq_subtask(pf);
> >   	ice_check_media_subtask(pf);
> >   	ice_check_for_hang_subtask(pf);
> > @@ -7016,7 +7027,6 @@ static int ice_change_mtu(struct net_device
> *netdev, int new_mtu)
> >   	struct ice_netdev_priv *np = netdev_priv(netdev);
> >   	struct ice_vsi *vsi = np->vsi;
> >   	struct ice_pf *pf = vsi->back;
> > -	struct iidc_event *event;
> >   	u8 count = 0;
> >   	int err = 0;
> >
> > @@ -7051,14 +7061,6 @@ static int ice_change_mtu(struct net_device
> *netdev, int new_mtu)
> >   		return -EBUSY;
> >   	}
> >
> > -	event = kzalloc(sizeof(*event), GFP_KERNEL);
> > -	if (!event)
> > -		return -ENOMEM;
> > -
> > -	set_bit(IIDC_EVENT_BEFORE_MTU_CHANGE, event->type);
> > -	ice_send_event_to_aux(pf, event);
> > -	clear_bit(IIDC_EVENT_BEFORE_MTU_CHANGE, event->type);
> > -
> >   	netdev->mtu = (unsigned int)new_mtu;
> >
> >   	/* if VSI is up, bring it down and then back up */
> > @@ -7066,21 +7068,18 @@ static int ice_change_mtu(struct net_device
> *netdev, int new_mtu)
> >   		err = ice_down(vsi);
> >   		if (err) {
> >   			netdev_err(netdev, "change MTU if_down err
> %d\n", err);
> > -			goto event_after;
> > +			return err;
> >   		}
> >
> >   		err = ice_up(vsi);
> >   		if (err) {
> >   			netdev_err(netdev, "change MTU if_up err %d\n",
> err);
> > -			goto event_after;
> > +			return err;
> >   		}
> >   	}
> >
> >   	netdev_dbg(netdev, "changed MTU to %d\n", new_mtu);
> > -event_after:
> > -	set_bit(IIDC_EVENT_AFTER_MTU_CHANGE, event->type);
> > -	ice_send_event_to_aux(pf, event);
> > -	kfree(event);
> > +	set_bit(ICE_FLAG_MTU_CHANGED, pf->flags);
> >
> >   	return err;
> >   }

