From: Jesse Gross <jesse@nicira.com>
Date: Thu, 10 Sep 2015 20:01:49 -0700
Subject: [Intel-wired-lan] [PATCH v2 2/5] vxlan: Generalize udp based
 tunnel offload
In-Reply-To: <C40BE8378EF49C44B9184714DBC8EF2992F0CF58@ORSMSX110.amr.corp.intel.com>
References: <1441749356-92927-1-git-send-email-anjali.singhai@intel.com>
 <1441749356-92927-2-git-send-email-anjali.singhai@intel.com>
 <CAEP_g=_K-nR2qmsNXCeQQRXHHt3GB7pJ9HsGRUztv7cvHQ6wxA@mail.gmail.com>
 <C40BE8378EF49C44B9184714DBC8EF2992F0CF58@ORSMSX110.amr.corp.intel.com>
Message-ID: <CAEP_g=9QmuNLyfL+nPadyc+2Pt=KD+MJZqvifDR+NLn4=2PzVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 10, 2015 at 10:36 AM, Singhai, Anjali
<anjali.singhai@intel.com> wrote:
>> -----Original Message-----
>> From: Jesse Gross [mailto:jesse at nicira.com]
>> Sent: Wednesday, September 09, 2015 2:30 PM
>> To: Singhai, Anjali
>> Cc: intel-wired-lan
>> Subject: Re: [Intel-wired-lan] [PATCH v2 2/5] vxlan: Generalize udp based
>> tunnel offload
>>
>> I believe we also need a generalization of vxlan_get_rx_port().
>> Otherwise, there's no way for drivers to get the non-VXLAN tunnels that
>> were created when they weren't up.
>>
> I plan to send this out as a separate patch.

I would probably suggest doing it as part of this series.

By the way - I do support this series and I'm not trying to add more
work to your plate. I'm slightly worried about this being
controversial though and so the more complete the patch is, the better
off you'll be. Plus, I guess you probably need it in order for the
later patches to work correctly in all circumstances.

>> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> > index c69072b..b6f6beb 100644
>> > --- a/include/linux/netdevice.h
>> > +++ b/include/linux/netdevice.h
>> > + * void (*ndo_add_tunnel_port)(struct  net_device *dev,
>> > + *                           sa_family_t sa_family, __be16 port, u32 type);
>> > + *     Called by UDP based tunnel modules to notify a driver about a UDP
>> > + *     port and socket address family that the tunnel is listening to. It is
>> > + *     called only when a new port starts listening. The operation is
>> > + *     protected by tunnel socket sock_lock.
>>
>> This locking doesn't look safe to me. Each type of tunnel will have its own
>> socket lock but the data structures that are used in drivers implementing
>> these functions may be shared (such as in your i40e patch). I believe that
>> RTNL is currently held by both VXLAN and Geneve when calling this with the
>> possible exception of vxlan_get_rx_port().
>> In practice, my guess is that it is likely held then too, so it might only require
>> checking this and documenting/asserting it.
>>
> ASSERT_RTNL happens in dev.c for both, so do you suggest I just document in the code that we have a common data structure and is being guarded by RTNL acquired by the stack.

I think mostly yes. The part that I would be concerned about is that
vxlan_get_rx_port() also uses this function and that could be called
from different places in drivers. In practice though, I think they are
mostly also protected by RTNL. So I would check the callsites and
assuming they are OK, also document the requirement for
vxlan_get_rx_port() and maybe add an ASSERT_RTNL there.

>> > diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h index
>> > c491c12..328f3ab 100644
>> > --- a/include/net/udp_tunnel.h
>> > +++ b/include/net/udp_tunnel.h
>> [...]
>> > +enum udp_tunnel_type {
>> > +       UDP_TUNNEL_NONE,
>> > +       UDP_TUNNEL_VXLAN,
>> > +       UDP_TUNNEL_GENEVE,
>> > +};
>>
>> What does UDP_TUNNEL_NONE mean?
> It's a way to avoid 0 based

Sorry, what's the significance of it being zero? These aren't flags so
I'm not sure why zero isn't a valid value.
