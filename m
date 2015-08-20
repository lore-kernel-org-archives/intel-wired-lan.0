From: Singhai, Anjali <anjali.singhai@intel.com>
Date: Thu, 20 Aug 2015 23:03:17 +0000
Subject: [Intel-wired-lan] [PATCH 2/4] geneve: Add geneve udp port
 offload for ethernet devices
In-Reply-To: <1440102733.28850.4.camel@intel.com>
References: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
 <1440096383-8915-2-git-send-email-anjali.singhai@intel.com>
 <1440102733.28850.4.camel@intel.com>
Message-ID: <C40BE8378EF49C44B9184714DBC8EF2992EFAD00@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Keller, Jacob E
> Sent: Thursday, August 20, 2015 1:32 PM
> To: intel-wired-lan at lists.osuosl.org; Singhai, Anjali
> Subject: Re: [Intel-wired-lan] [PATCH 2/4] geneve: Add geneve udp port
> offload for ethernet devices
> 
> On Thu, 2015-08-20 at 11:46 -0700, Anjali Singhai Jain wrote:
> > Add ndo_ops to add/del UDP ports to a device that supports geneve
> > offload.
> >
> > v2:Added comments for new ndo_ops and minor format fix.
> >
> > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> > ---
> >  include/linux/netdevice.h | 20 +++++++++++++++++++-
> >  net/ipv4/geneve_core.c    | 22 ++++++++++++++++++++++
> >  2 files changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index f3bb290..d6f00c7 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1016,6 +1016,19 @@ typedef u16 (*select_queue_fallback_t)(struct
> > net_device *dev,
> >   *	address family that vxlan is not listening to anymore. The
> > operation
> >   *	is protected by the vxlan_net->sock_lock.
> >   *
> > + * void (*ndo_add_geneve_port)(struct net_device *dev,
> > + *			      sa_family_t sa_family, __be16 port);
> > + *	Called by geneve to notiy a driver about the UDP port and
> > socket
> > + *	address family that geneve is listnening to. It is called
> > only when
> > + *	a new port starts listening. The operation is protected by
> > the
> > + *	geneve_net->sock_lock.
> > + *
> > + * void (*ndo_del_geneve_port)(struct net_device *dev,
> > + *			      sa_family_t sa_family, __be16 port);
> > + *	Called by geneve to notify the driver about a UDP port and
> > socket
> > + *	address family that geneve is not listening to anymore.
> > The operation
> > + *	is protected by the geneve_net->sock_lock.
> > + *
> 
> 
> Would it make more sense to generalize the ndo op for future protocol
> extension instead of continuing to add separate tunnel offload functions for
> each one?
> 
> 
> ie: generalize ndo_add_vxlan_port into "ndo_add_tunnel_port"?
> 
> Maybe it's not worth it though..?
> 

Not worth it at this point,  should be done as a separate refactor patch involving cleaning up both vxlan and geneve modules plus all the drivers that use them.


> Regards,
> Jake
