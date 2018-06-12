From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 12 Jun 2018 15:47:32 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 0/7] Add
 support for L2 Fwd Offload w/o ndo_select_queue
In-Reply-To: <20180612105029.77b40381@xeon-e3>
References: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
 <20180612105029.77b40381@xeon-e3>
Message-ID: <CAKgT0Ue4b6+QRKX4DiyqVGNgqXd=k8U7LsBcZx3Vbo95yz-9NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 12, 2018 at 10:50 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Tue, 12 Jun 2018 11:18:25 -0400
> Alexander Duyck <alexander.h.duyck@intel.com> wrote:
>
>> This patch series is meant to allow support for the L2 forward offload, aka
>> MACVLAN offload without the need for using ndo_select_queue.
>>
>> The existing solution currently requires that we use ndo_select_queue in
>> the transmit path if we want to associate specific Tx queues with a given
>> MACVLAN interface. In order to get away from this we need to repurpose the
>> tc_to_txq array and XPS pointer for the MACVLAN interface and use those as
>> a means of accessing the queues on the lower device. As a result we cannot
>> offload a device that is configured as multiqueue, however it doesn't
>> really make sense to configure a macvlan interfaced as being multiqueue
>> anyway since it doesn't really have a qdisc of its own in the first place.
>>
>> I am submitting this as an RFC for the netdev mailing list, and officially
>> submitting it for testing to Jeff Kirsher's next-queue in order to validate
>> the ixgbe specific bits.
>>
>> The big changes in this set are:
>>   Allow lower device to update tc_to_txq and XPS map of offloaded MACVLAN
>>   Disable XPS for single queue devices
>>   Replace accel_priv with sb_dev in ndo_select_queue
>>   Add sb_dev parameter to fallback function for ndo_select_queue
>>   Consolidated ndo_select_queue functions that appeared to be duplicates
>>
>> v2: Implement generic "select_queue" functions instead of "fallback" functions.
>>     Tweak last two patches to account for changes in dev_pick_tx_xxx functions.
>>
>> ---
>>
>> Alexander Duyck (7):
>>       net-sysfs: Drop support for XPS and traffic_class on single queue device
>>       net: Add support for subordinate device traffic classes
>>       ixgbe: Add code to populate and use macvlan tc to Tx queue map
>>       net: Add support for subordinate traffic classes to netdev_pick_tx
>>       net: Add generic ndo_select_queue functions
>>       net: allow ndo_select_queue to pass netdev
>>       net: allow fallback function to pass netdev
>>
>>
>>  drivers/infiniband/hw/hfi1/vnic_main.c            |    2
>>  drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c |    4 -
>>  drivers/net/bonding/bond_main.c                   |    3
>>  drivers/net/ethernet/amazon/ena/ena_netdev.c      |    5 -
>>  drivers/net/ethernet/broadcom/bcmsysport.c        |    6 -
>>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   |    6 +
>>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |    3
>>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c   |    5 -
>>  drivers/net/ethernet/hisilicon/hns/hns_enet.c     |    5 -
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   62 ++++++--
>>  drivers/net/ethernet/lantiq_etop.c                |   10 -
>>  drivers/net/ethernet/mellanox/mlx4/en_tx.c        |    7 +
>>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h      |    3
>>  drivers/net/ethernet/mellanox/mlx5/core/en.h      |    3
>>  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c   |    5 -
>>  drivers/net/ethernet/renesas/ravb_main.c          |    3
>>  drivers/net/ethernet/sun/ldmvsw.c                 |    3
>>  drivers/net/ethernet/sun/sunvnet.c                |    3
>>  drivers/net/ethernet/ti/netcp_core.c              |    9 -
>>  drivers/net/hyperv/netvsc_drv.c                   |    6 -
>>  drivers/net/macvlan.c                             |   10 -
>>  drivers/net/net_failover.c                        |    7 +
>>  drivers/net/team/team.c                           |    3
>>  drivers/net/tun.c                                 |    3
>>  drivers/net/wireless/marvell/mwifiex/main.c       |    3
>>  drivers/net/xen-netback/interface.c               |    4 -
>>  drivers/net/xen-netfront.c                        |    3
>>  drivers/staging/netlogic/xlr_net.c                |    9 -
>>  drivers/staging/rtl8188eu/os_dep/os_intfs.c       |    3
>>  drivers/staging/rtl8723bs/os_dep/os_intfs.c       |    7 -
>>  include/linux/netdevice.h                         |   34 ++++-
>>  net/core/dev.c                                    |  156 ++++++++++++++++++---
>>  net/core/net-sysfs.c                              |   36 ++++-
>>  net/mac80211/iface.c                              |    4 -
>>  net/packet/af_packet.c                            |    7 +
>>  35 files changed, 312 insertions(+), 130 deletions(-)
>>
>> --
>
> This makes sense. I thought you were hoping to get rid of select queue in future?

That would be nice, however there are still a bunch of corner cases
that are not handled that have been dumped into select queue. For
example in the case of ixgbe the issue is FCoE. There are a number of
other places that are using it as well as I seem to recall netvsc and
bonding both use it to store off the original Rx->Tx queue mapping
when passing through the interface.

For now I figure we can take this one hill at a time and I am just
making it so we don't have to use ndo_select_queue in order to make
vmdq work for macvlan offload.

- Alex
