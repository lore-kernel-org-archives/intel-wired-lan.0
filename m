From: Jesse Gross <jesse@kernel.org>
Date: Sun, 15 Nov 2015 20:12:16 -0800
Subject: [Intel-wired-lan] [PATCH v5 4/7] net: Generalize udp based
	tunnel offload
In-Reply-To: <1447632175-9477-4-git-send-email-anjali.singhai@intel.com>
References: <1447632175-9477-1-git-send-email-anjali.singhai@intel.com>
 <1447632175-9477-4-git-send-email-anjali.singhai@intel.com>
Message-ID: <CAEh+42j+UoHBMwyEkDfa-UuQTgzRUy+jSk=2RSvwYXir0cQH9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Nov 15, 2015 at 4:02 PM, Anjali Singhai Jain
<anjali.singhai@intel.com> wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 2b78a36..cfe6201 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
[...]
> + * void (*ndo_add_udp_tunnel_port)(struct  net_device *dev,
> + *                           sa_family_t sa_family, __be16 port, u32 type);
> + *     Called by UDP based tunnel modules to notify a driver about a UDP
> + *     port and socket address family that the tunnel is listening to. It is
> + *     called only when a new port starts listening. The operation is
> + *     protected by tunnel socket sock_lock which is per tunnel type.
> + *     If the driver implementation shares resources between different types
> + *     of tunnels, it should implement it's own locking to safeguard against
> + *     simultaneous access.
> + *
> + * void (*ndo_del_udp_tunnel_port)(struct  net_device *dev,
> + *                           sa_family_t sa_family, __be16 port, u32 type);
> + *     Called by UDP based tunnel modules to notify the driver about a UDP port
> + *     and socket address family that tunnel is not listening to anymore.
> + *     The operation is protected protected by tunnel socket sock_lock which
> + *     is per tunnel type. If the driver implementation shares resources
> + *     between different types of tunnels, it should implement it's own locking
> + *     to safeguard against simultaneous access.

I think these comment about locking is no longer up to date - we can
now say that access is protected by udp_offload_lock.

> diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
> index cb2f89f..eb44d5f 100644
> --- a/include/net/udp_tunnel.h
> +++ b/include/net/udp_tunnel.h
> @@ -9,6 +9,11 @@
>  #include <net/addrconf.h>
>  #endif
>
> +enum udp_tunnel_type {
> +       UDP_TUNNEL_VXLAN,
> +       UDP_TUNNEL_GENEVE,
> +};

This one is my fault but I now understand why you were trying to avoid
having a zero based enum - tunnels without a type (such as FOU later
on) will end up trying to offload as VXLAN. I think we can define an
UNSPEC type and then check for it before we call into the driver.
