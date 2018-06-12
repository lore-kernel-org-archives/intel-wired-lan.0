From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 12 Jun 2018 10:56:48 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 0/7] Add
 support for L2 Fwd Offload w/o ndo_select_queue
In-Reply-To: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
References: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <be1b5bed-d8b2-244e-167a-1f79bfb5f6e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/12/2018 08:18 AM, Alexander Duyck wrote:
> This patch series is meant to allow support for the L2 forward offload, aka
> MACVLAN offload without the need for using ndo_select_queue.
> 
> The existing solution currently requires that we use ndo_select_queue in
> the transmit path if we want to associate specific Tx queues with a given
> MACVLAN interface. In order to get away from this we need to repurpose the
> tc_to_txq array and XPS pointer for the MACVLAN interface and use those as
> a means of accessing the queues on the lower device. As a result we cannot
> offload a device that is configured as multiqueue, however it doesn't
> really make sense to configure a macvlan interfaced as being multiqueue
> anyway since it doesn't really have a qdisc of its own in the first place.

Interesting, so at some point I had came up with the following for
mapping queues between the DSA slave network devices and the DSA master
network device (doing the actual transmission). The DSA master network
device driver is just a normal network device driver.

The set-up is as follows: 4 external Ethernet switch ports, each with 8
egress queues and the DSA master (bcmsysport.c), aka CPU Ethernet
controller has 32 output queues, so you can do a 1:1 mapping of those,
that's actually what we want. A subsequent hardware generation only
provides 16 output queues, so we can still do 2:1 mapping.

The implementation is done like this:

- DSA slave network devices are always created after the DSA master
network device so we can leverage that

- a specific notifier is running from the DSA core and tells the DSA
master about the switch position in the tree (position 0 = directly
attached), and the switch port number and a pointer to the slave network
device

- we establish the mapping between the queues within the bcmsysport
driver as a simple array

- when transmitting, DSA slave network devices set a specific queue/port
number within the 16-bits that skb->queue_mapping permits

- this gets re-used by bcmsysport.c to extract the correct queue number
during ndo_select_queue such that the appropriate queue number gets used
and congestion works end-to-end.

The reason why we do that is because there is some out of band HW that
monitors the queue depth of the switch port's egress queue and
back-pressure the Ethernet controller directly when trying to transmit
to a congested queue.

I had initially considered establishing the mapping using tc and some
custom "bind" argument of some kind, but ended-up doing things the way
they are which are more automatic though they leave less configuration
to an user. This has a number of caveats though:

- this is made generic within the context of DSA in that nothing is
switch driver or Ethernet MAC driver specific and the notifier
represents the contract between these two seemingly independent subsystems

- the queue indicated between DSA slave and master is unfortunately
switch driver/controller specific (BRCM_TAG_SET_PORT_QUEUE,
BRCM_TAG_GET_PORT, BRCM_TAG_GET_QUEUE)

What I like about your patchset is the mapping establishment, but as you
will read from my reply in patch 2, I think the (upper) 1:N (lower)
mapping might not work for my specific use case.

Anyhow, not intended to be blocking this, as it seems to be going in the
right direction anyway.

> 
> I am submitting this as an RFC for the netdev mailing list, and officially
> submitting it for testing to Jeff Kirsher's next-queue in order to validate
> the ixgbe specific bits.
> 
> The big changes in this set are:
>   Allow lower device to update tc_to_txq and XPS map of offloaded MACVLAN
>   Disable XPS for single queue devices
>   Replace accel_priv with sb_dev in ndo_select_queue
>   Add sb_dev parameter to fallback function for ndo_select_queue
>   Consolidated ndo_select_queue functions that appeared to be duplicates

Interesting, turns out I had a possibly similar use case with DSA with
the slave network devices need to select an outgoing queue number for

> 
> v2: Implement generic "select_queue" functions instead of "fallback" functions.
>     Tweak last two patches to account for changes in dev_pick_tx_xxx functions.
> 
> ---
> 
> Alexander Duyck (7):
>       net-sysfs: Drop support for XPS and traffic_class on single queue device
>       net: Add support for subordinate device traffic classes
>       ixgbe: Add code to populate and use macvlan tc to Tx queue map
>       net: Add support for subordinate traffic classes to netdev_pick_tx
>       net: Add generic ndo_select_queue functions
>       net: allow ndo_select_queue to pass netdev
>       net: allow fallback function to pass netdev
> 
> 
>  drivers/infiniband/hw/hfi1/vnic_main.c            |    2 
>  drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c |    4 -
>  drivers/net/bonding/bond_main.c                   |    3 
>  drivers/net/ethernet/amazon/ena/ena_netdev.c      |    5 -
>  drivers/net/ethernet/broadcom/bcmsysport.c        |    6 -
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   |    6 +
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |    3 
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c   |    5 -
>  drivers/net/ethernet/hisilicon/hns/hns_enet.c     |    5 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   62 ++++++--
>  drivers/net/ethernet/lantiq_etop.c                |   10 -
>  drivers/net/ethernet/mellanox/mlx4/en_tx.c        |    7 +
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h      |    3 
>  drivers/net/ethernet/mellanox/mlx5/core/en.h      |    3 
>  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c   |    5 -
>  drivers/net/ethernet/renesas/ravb_main.c          |    3 
>  drivers/net/ethernet/sun/ldmvsw.c                 |    3 
>  drivers/net/ethernet/sun/sunvnet.c                |    3 
>  drivers/net/ethernet/ti/netcp_core.c              |    9 -
>  drivers/net/hyperv/netvsc_drv.c                   |    6 -
>  drivers/net/macvlan.c                             |   10 -
>  drivers/net/net_failover.c                        |    7 +
>  drivers/net/team/team.c                           |    3 
>  drivers/net/tun.c                                 |    3 
>  drivers/net/wireless/marvell/mwifiex/main.c       |    3 
>  drivers/net/xen-netback/interface.c               |    4 -
>  drivers/net/xen-netfront.c                        |    3 
>  drivers/staging/netlogic/xlr_net.c                |    9 -
>  drivers/staging/rtl8188eu/os_dep/os_intfs.c       |    3 
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c       |    7 -
>  include/linux/netdevice.h                         |   34 ++++-
>  net/core/dev.c                                    |  156 ++++++++++++++++++---
>  net/core/net-sysfs.c                              |   36 ++++-
>  net/mac80211/iface.c                              |    4 -
>  net/packet/af_packet.c                            |    7 +
>  35 files changed, 312 insertions(+), 130 deletions(-)
> 
> --
> 


-- 
Florian
