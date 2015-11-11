From: Jesse Gross <jesse@nicira.com>
Date: Wed, 11 Nov 2015 01:27:40 -0800
Subject: [Intel-wired-lan] [PATCH v4 6/6] net: Add a generic
 udp_offload_get_port function
In-Reply-To: <1447178205-99510-6-git-send-email-anjali.singhai@intel.com>
References: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
 <1447178205-99510-6-git-send-email-anjali.singhai@intel.com>
Message-ID: <CAEP_g=8EpxmGcSvtyCijF7dYRx8aNkjsTBTEkVLWenkeCpmGQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Nov 10, 2015 at 9:56 AM, Anjali Singhai Jain
<anjali.singhai@intel.com> wrote:
> The new function udp_offload_get_port replaces vxlan_get_rx_port().
> This is a generic function that will help replay all udp tunnel ports irrespective of tunnel type.
> This way when new udp tunnels get added this function need not change.
>
> Note: Drivers besides i40e are compile tested with this change.
>
> v2: fix a compile issue with redefinition of the function.
>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>

I don't think that the locking is safe in the patch. The original
vxlan_get_rx_port() held vn->sock_lock while calling into drivers but
the new udp_offload_get_port() doesn't hold anything except for RCU.
i40e is protected because you introduced a new spinlock but I don't
think the same thing hold true for other drivers, even if they are
only handling VXLAN. There's no guarantee that they are in a safe
context when they call this function vs. calls from adding new tunnel
ports. Based on our previous conversation about RTNL, I think there
are existing drivers that don't meet this so we would have to add new
locks to every driver supporting this.

I believe that is really quite simple to just call
ndo_add_udp_tunnel_port() from udp_add_offload() while
udp_offload_lock() is held (and the opposite on delete). We could also
hold this instead of RCU in udp_offload_get_port(). At that point, we
wouldn't need any new locking in drivers so I think that this would be
simplest and cleanest path forward.

> index f938616..30aa84c 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -290,6 +290,31 @@ unlock:
>  }
>  EXPORT_SYMBOL(udp_del_offload);
>
> +void udp_offload_get_port(struct net_device *dev)
> +{
> +#if IS_ENABLED(CONFIG_VXLAN) || IS_ENABLED(CONFIG_GENEVE)

I think it is better to not check for VXLAN or Geneve here. This is
generic code so it shouldn't make any assumptions about what protocols
it is supporting.
