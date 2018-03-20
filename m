From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 20 Mar 2018 14:35:41 -0700
Subject: [Intel-wired-lan] [E1000-devel] Race in RX configuration
In-Reply-To: <5.1.0.14.2.20180313130209.05a0fe70@pop.netregistry.net>
References: <5.1.0.14.2.20180313130209.05a0fe70@pop.netregistry.net>
Message-ID: <CAKgT0UddYNCMSvySOLGP2O+MvoPPTtS=c-VX_orbEPjJhEuL1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 12, 2018 at 7:02 PM, Sylvia Else <sylviaw79@cryogenic.net> wrote:
> When configuring the rx part of the interface, the e1000_main.c module
> enables receive on the adapter before it has initialised the buffer
> addresses. The resulting race with the arrival of the first packet can lead
> to the adapter and the driver having different ideas about where the next
> packet is meant to go, resulting in the failure of the network to function.
>
> In practice, the window is narrow, and this may rarely if ever cause
> problems with real hardware. However VirtualBox is capable of delivering a
> packet from the virtual adapter is soon as receive is enabled, and this does
> indeed cause the network to fail to work. The situation arises if there are
> broadcast packets in the host network near the time when receive is enabled.
>
> I propose the following patch to address the condition. It moves the task of
> initialising the buffers (done in two places) to the e1000_configure_rx
> function where it can be done before received is enabled. I have confirmed
> that this corrects the problem with VirtualBox, but I do not have the
> required hardware to test it in a non-virtualised environment.

I just noticed this patch on the e1000-devel mailing list. For future
reference you should submit patches to the Intel Wired Lan mailing
list if you want to submit a proposed patch for the driver that is in
the kernel.

In addition you need to add your "Signed-off-by:". For more
information you can read about the developers certificate of origin
here:
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L429

>
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -389,7 +389,6 @@ static void e1000_release_manageability(struct
> e1000_adapter *adapter)
>  static void e1000_configure(struct e1000_adapter *adapter)
>  {
>         struct net_device *netdev = adapter->netdev;
> -       int i;
>
>         e1000_set_rx_mode(netdev);
>
> @@ -399,15 +398,6 @@ static void e1000_configure(struct e1000_adapter
> *adapter)
>         e1000_configure_tx(adapter);
>         e1000_setup_rctl(adapter);
>         e1000_configure_rx(adapter);
> -       /* call E1000_DESC_UNUSED which always leaves
> -        * at least 1 descriptor unused to make sure
> -        * next_to_use != next_to_clean
> -        */
> -       for (i = 0; i < adapter->num_rx_queues; i++) {
> -               struct e1000_rx_ring *ring = &adapter->rx_ring[i];
> -               adapter->alloc_rx_buf(adapter, ring,
> -                                     E1000_DESC_UNUSED(ring));
> -       }
>  }
>
>  int e1000_up(struct e1000_adapter *adapter)
> @@ -1860,6 +1850,7 @@ static void e1000_configure_rx(struct e1000_adapter
> *adapter)
>         u64 rdba;
>         struct e1000_hw *hw = &adapter->hw;
>         u32 rdlen, rctl, rxcsum;
> +       int i;
>
>         if (adapter->netdev->mtu > ETH_DATA_LEN) {
>                 rdlen = adapter->rx_ring[0].count *
> @@ -1916,6 +1907,16 @@ static void e1000_configure_rx(struct e1000_adapter
> *adapter)
>                 ew32(RXCSUM, rxcsum);
>         }
>
> +       /* call E1000_DESC_UNUSED which always leaves
> +        * at least 1 descriptor unused to make sure
> +        * next_to_use != next_to_clean
> +        */
> +       for (i = 0; i < adapter->num_rx_queues; i++) {
> +               struct e1000_rx_ring *ring = &adapter->rx_ring[i];
> +               adapter->alloc_rx_buf(adapter, ring,
> +                                     E1000_DESC_UNUSED(ring));
> +       }
> +
>         /* Enable Receives */
>         ew32(RCTL, rctl | E1000_RCTL_EN);
>  }
> @@ -2187,10 +2188,7 @@ static void e1000_leave_82542_rst(struct
> e1000_adapter *adapter)
>                 e1000_pci_set_mwi(hw);
>
>         if (netif_running(netdev)) {
> -               /* No need to loop, because 82542 supports only 1 queue */
> -               struct e1000_rx_ring *ring = &adapter->rx_ring[0];
>                 e1000_configure_rx(adapter);
> -               adapter->alloc_rx_buf(adapter, ring,
> E1000_DESC_UNUSED(ring));
>         }
>  }
>

As far as the patch itself this isn't going to work on the physical hardware.

The problem is that updating RDT before the RCTL_EN bit is set will
result in an Rx stall. Descriptors will not be fetched until the RDT
is set with the RCTL_EN bit set. Any updates to RDT and RDH before
setting RCTL_EN are meant to be used to initialize the state of the
head and tail. As such filling the ring before setting the RCTL_EN bit
will result in a full ring and now way for us to update the tail since
it will be continually set to 255.

The issue in VirtualBox seems to be this bit of code in
https://www.virtualbox.org/browser/vbox/trunk/src/VBox/Devices/Network/DevE1000.cpp:
3186        /*
3187         * Some drivers advance RDT too far, so that it equals RDH. This
3188         * somehow manages to work with real hardware but not with this
3189         * emulated device. We can work with these drivers if we just
3190         * write 1 less when we see a driver writing RDT equal to RDH,
3191         * see @bugref{7346}.
3192         */
3193        if (value == RDH)
3194        {
3195            if (RDH == 0)
3196                value = (RDLEN / sizeof(E1KRXDESC)) - 1;
3197            else
3198                value = RDH - 1;
3199        }

The more immediate solution would be to limit this so that this only
applies when RCTL_EN is not set. It is standard initialization to set
head and tail to 0. Ignoring that and setting tail to 255 is an issue
since it results in their emulation getting ahead of things. An
alternative way to deal with it would be to disable descriptor
fetching until RDT is set with RCTL_EN being set. In that case it
should have an effect and start processing Rx.

So with the bit identified above as the issue you may want to consider
an alternative. I have attached a copy of a possible workaround patch
and included the code below. The idea is pretty simple. Just move the
head, then set tail, and then move the head back and it seems like it
should then properly reflect RDT == RDH which is an empty queue
instead of implying that it is full by changing it as called out
above.

Thanks.

- Alex

---

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c
b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 0744961..3788bde 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1910,6 +1910,14 @@ static void e1000_configure_rx(struct
e1000_adapter *adapter)
                ew32(RDLEN, rdlen);
                ew32(RDBAH, (rdba >> 32));
                ew32(RDBAL, (rdba & 0x00000000ffffffffULL));
+               /* Workaround for issues in VirtualBox where
+                * if (RDH == RDT && RDH == 0)
+                *      RDT = rdlen / sizeof(e1000_rx_desc) - 1;
+                * The code seems to check for RDT == RDH on tail update
+                * but doesn't perform the same check on a head update
+                * so we just maneuver the head around the tail.
+                */
+               ew32(RDH, 1);
                ew32(RDT, 0);
                ew32(RDH, 0);
                adapter->rx_ring[0].rdh = ((hw->mac_type >= e1000_82543) ?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: e1000-workaround-virtualbox.patch
Type: text/x-patch
Size: 1100 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180320/acea408e/attachment.bin>
