From: Jesse Gross <jesse@kernel.org>
Date: Wed, 15 Jun 2016 16:51:04 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 03/17] net: Merge VXLAN
 and GENEVE push notifiers into a single notifier
In-Reply-To: <20160615220735.15575.36973.stgit@localhost.localdomain>
References: <20160615220449.15575.17031.stgit@localhost.localdomain>
 <20160615220735.15575.36973.stgit@localhost.localdomain>
Message-ID: <CAEh+42hRJwqgD1wBxVq-SaqmJ5drteUrB4YV5pUCCgKpyqiz2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jun 15, 2016 at 3:07 PM, Alexander Duyck <aduyck@mirantis.com> wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d101e4d904ba..7f45e96967ce 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1050,6 +1052,19 @@ struct tc_to_netdev {
>   *     address family that vxlan is not listening to anymore. The operation
>   *     is protected by the vxlan_net->sock_lock.
>   *
> + * void (*ndo_udp_tunnel_add)(struct net_device *dev,
> + *                           struct udp_tunnel_info *ti);
> + *     Called by UDP tunnel to notify a driver about the UDP port and socket
> + *     address family that a UDP tunnel is listnening to. It is called only
> + *     when a new port starts listening. The operation is protected by the
> + *     tunnel socket lock.
> + *
> + * void (*ndo_udp_tunnel_del)(struct net_device *dev,
> + *                           struct udp_tunnel_info *ti);
> + *     Called by UDP tunnel to notify the driver about a UDP port and socket
> + *     address family that the UDP tunnel is not listening to anymore. The
> + *     operation is protected by the tunnel socket lock.

I think these comments are out of date - these operations are now
protected by RTNL instead of individual tunnel locks. Having
individual locks doesn't really work because drivers likely share
information for different tunnel types in the same data structures.
