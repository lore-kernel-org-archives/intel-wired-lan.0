From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 3 Jul 2018 11:42:50 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 0/7] Add
 support for L2 Fwd Offload w/o ndo_select_queue
In-Reply-To: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
References: <20180612151322.86792.97587.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <CAL3LdT6s2fe5Reby5-d1PHSCjfDEgGu_v9Eu-BS-sN9YjOHiaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 12, 2018 at 8:18 AM, Alexander Duyck
<alexander.h.duyck@intel.com> wrote:
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

Alex, there were recent changes to Dave's net-next which caused a
conflict with one or more of your patches.  So I have removed this
series from my tree for now, and will work with you on updating the
series to work with the latest net-next tree.
