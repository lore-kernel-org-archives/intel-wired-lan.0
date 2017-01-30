From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Jan 2017 21:36:17 +0000
Subject: [Intel-wired-lan] [next-queue v5 PATCH 4/7] net:
	store	port/representator id in metadata_dst
In-Reply-To: <1485392057-3261-5-git-send-email-sridhar.samudrala@intel.com>
References: <1485392057-3261-1-git-send-email-sridhar.samudrala@intel.com>
 <1485392057-3261-5-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D4F7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Wednesday, January 25, 2017 4:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Subject: [Intel-wired-lan] [next-queue v5 PATCH 4/7] net: store
> port/representator id in metadata_dst
> 
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> 
> Switches and modern SR-IOV enabled NICs may multiplex traffic from Port
> representators and control messages over single set of hardware queues.
> Control messages and muxed traffic may need ordered delivery.
> 
> Those requirements make it hard to comfortably use TC infrastructure today
> unless we have a way of attaching metadata to skbs at the upper device.
> Because single set of queues is used for many netdevs stopping TC/sched
> queues of all of them reliably is impossible and lower device has to retreat to
> returning NETDEV_TX_BUSY and usually has to take extra locks on the
> fastpath.
> 
> This patch attempts to enable port/representative devs to attach metadata
> to skbs which carry port id.  This way representatives can be queueless and
> all queuing can be performed at the lower netdev in the usual way.
> 
> Traffic arriving on the port/representative interfaces will be have metadata
> attached and will subsequently be queued to the lower device for
> transmission.
> The lower device should recognize the metadata and translate it to HW
> specific format which is most likely either a special header inserted before
> the network headers or descriptor/metadata fields.
> 
> Metadata is associated with the lower device by storing the netdev pointer
> along with port id so that if TC decides to redirect or mirror the new netdev
> will not try to interpret it.
> 
> This is mostly for SR-IOV devices since switches don't have lower netdevs
> today.
> 
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  include/net/dst_metadata.h     | 41
> ++++++++++++++++++++++++++++++++---------
>  net/core/dst.c                 | 15 ++++++++++-----
>  net/core/filter.c              |  1 +
>  net/ipv4/ip_tunnel_core.c      |  6 ++++--
>  net/openvswitch/flow_netlink.c |  4 +++-
>  5 files changed, 50 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Does not break i40e/i40evf
