From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 29 Jan 2018 09:22:53 -0800
Subject: [Intel-wired-lan] [PATCH 3/3] Revert "e1000e: Do not read ICR
 in Other interrupt"
In-Reply-To: <20180129072805.7ifsjr3r6eziwp7a@f1.synalogic.ca>
References: <20180126091236.13044-1-bpoirier@suse.com>
 <20180126091236.13044-4-bpoirier@suse.com>
 <CAKgT0Ue+JNL91jr08Ks3+Oj21fNApwuQH=bDEs2o3BKPigpyEA@mail.gmail.com>
 <20180129072805.7ifsjr3r6eziwp7a@f1.synalogic.ca>
Message-ID: <CAKgT0Ucozb6kyFavZUo=enjhpJkkiHDz-bZYG=KcCLoD=ByqoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Jan 28, 2018 at 11:28 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> On 2018/01/26 13:01, Alexander Duyck wrote:
>> On Fri, Jan 26, 2018 at 1:12 AM, Benjamin Poirier <bpoirier@suse.com> wrote:
>> > This reverts commit 16ecba59bc333d6282ee057fb02339f77a880beb.
>> >
>> > It was reported that emulated e1000e devices in vmware esxi 6.5 Build
>> > 7526125 do not link up after commit 4aea7a5c5e94 ("e1000e: Avoid receiver
>> > overrun interrupt bursts"). Some tracing shows that after
>> > e1000e_trigger_lsc() is called, ICR reads out as 0x0 in e1000_msix_other()
>> > on emulated e1000e devices. In comparison, on real e1000e 82574 hardware,
>> > icr=0x80000004 (_INT_ASSERTED | _LSC) in the same situation.
>> >
>> > Some experimentation showed that this flaw in vmware e1000e emulation can
>> > be worked around by not setting Other in EIAC. This is how it was before
>> > commit 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt").
>> >
>> > Since the ICR read in the Other interrupt handler has already been
>> > restored, this patch effectively reverts the remainder of commit
>> > 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt").
>> >
>> > Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
>> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
>> > ---
>> >  drivers/net/ethernet/intel/e1000e/netdev.c | 10 ++++++++--
>> >  1 file changed, 8 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> > index ed103b9a8d3a..fffc1f0e3895 100644
>> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> > @@ -1916,6 +1916,13 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>> >         struct e1000_hw *hw = &adapter->hw;
>> >         u32 icr = er32(ICR);
>> >
>> > +       /* Certain events (such as RXO) which trigger Other do not set
>> > +        * INT_ASSERTED. In that case, read to clear of icr does not take
>> > +        * place.
>> > +        */
>> > +       if (!(icr & E1000_ICR_INT_ASSERTED))
>> > +               ew32(ICR, E1000_ICR_OTHER);
>> > +
>>
>> This piece doesn't make sense to me. Why are we clearing OTHER if
>> ICR_INT_ASSERTED is not set?
>
> Datasheet ?10.2.4.1 ("Interrupt Cause Read Register") says that ICR read
> to clear only occurs if INT_ASSERTED is set. This corresponds to what I
> observed.
>
> However, while working on these issues, I noticed that when there is an rxo
> event, INT_ASSERTED is not always set even though the interrupt is raised. I
> think this is a hardware flaw.

I agree. I need to check with our silicon team to see what we can determine.

> For example, if doing
> ew32(ICS, E1000_ICS_LSC | E1000_ICS_OTHER);
> we enter e1000_msix_other() and two consecutive reads of ICR result in
> 0x81000004
> 0x00000000
>
> If doing
> ew32(ICS, E1000_ICS_RXO | E1000_ICS_OTHER);
> we enter e1000_msix_other() and two consecutive reads of ICR result in
> 0x01000041
> 0x01000041

This is interesting. So the ICR is doing the clear on read, so that
answers the question I had about the earlier patch.

One thought on this.. Is there any reason why you are limiting this to
only the OTHER bit? It seems like RXO and the other causes that aren't
supposed to be included in the mask should probably be cleared as
well, are they auto-cleared, ignored, or is there some advantage to
leaving them set?

> Consequently, we must clear OTHER manually from ICR, otherwise the
> interrupt is immediately re-raised after exiting the handler.
>
> These observations are the same whether the interrupt is triggered via a
> write to ICS or in hardware.
>
> Furthermore, I tested that this behavior is the same for other Other
> events (MDAC, SRPD, ACK, MNG). Those were tested via a write to ICS
> only, not in hardware.
>
> This is a version of the test patch that I used to trigger lsc and rxo in
> software and hardware. It applies over this patch series.

I plan to look into this some more over the next few days. Ideally if
we could mask these "OTHER" interrupts besides the LSC we could comply
with all the needed bits for MSI-X. My concern is that we are still
stuck reading the ICR at this point because of this and it is going to
make dealing with MSI-X challenging on 82574 since it seems like the
intention was that you weren't supposed to be reading the ICR when
MSI-X is enabled based on the list of current issues and HW errata.

At this point it seems like the interrupts is firing and the
INT_ASSERTED is all we really need to be checking for if I understand
this all correctly. Basically if LSC is set it will trigger OTHER and
INT_ASSERTED, if any of the other causes are set they are only setting
OTHER.

> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
> index 0641c0098738..f54e7ac9c934 100644
> --- a/drivers/net/ethernet/intel/e1000e/defines.h
> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
> @@ -398,6 +398,7 @@
>  #define E1000_ICR_LSC           0x00000004 /* Link Status Change */
>  #define E1000_ICR_RXSEQ         0x00000008 /* Rx sequence error */
>  #define E1000_ICR_RXDMT0        0x00000010 /* Rx desc min. threshold (0) */
> +#define E1000_ICR_RXO           0x00000040 /* rx overrun */
>  #define E1000_ICR_RXT0          0x00000080 /* Rx timer intr (ring 0) */
>  #define E1000_ICR_ECCER         0x00400000 /* Uncorrectable ECC Error */
>  /* If this bit asserted, the driver should claim the interrupt */
> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index 003cbd605799..4933c1beac74 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -1802,98 +1802,20 @@ static void e1000_diag_test(struct net_device *netdev,
>                             struct ethtool_test *eth_test, u64 *data)
>  {
>         struct e1000_adapter *adapter = netdev_priv(netdev);
> -       u16 autoneg_advertised;
> -       u8 forced_speed_duplex;
> -       u8 autoneg;
> -       bool if_running = netif_running(netdev);
> +       struct e1000_hw *hw = &adapter->hw;
>
>         pm_runtime_get_sync(netdev->dev.parent);
>
>         set_bit(__E1000_TESTING, &adapter->state);
>
> -       if (!if_running) {
> -               /* Get control of and reset hardware */
> -               if (adapter->flags & FLAG_HAS_AMT)
> -                       e1000e_get_hw_control(adapter);
> -
> -               e1000e_power_up_phy(adapter);
> -
> -               adapter->hw.phy.autoneg_wait_to_complete = 1;
> -               e1000e_reset(adapter);
> -               adapter->hw.phy.autoneg_wait_to_complete = 0;
> -       }
> -
>         if (eth_test->flags == ETH_TEST_FL_OFFLINE) {
> -               /* Offline tests */
> -
> -               /* save speed, duplex, autoneg settings */
> -               autoneg_advertised = adapter->hw.phy.autoneg_advertised;
> -               forced_speed_duplex = adapter->hw.mac.forced_speed_duplex;
> -               autoneg = adapter->hw.mac.autoneg;
> -
> -               e_info("offline testing starting\n");
> -
> -               if (if_running)
> -                       /* indicate we're in test mode */
> -                       e1000e_close(netdev);
> -
> -               if (e1000_reg_test(adapter, &data[0]))
> -                       eth_test->flags |= ETH_TEST_FL_FAILED;
> -
> -               e1000e_reset(adapter);
> -               if (e1000_eeprom_test(adapter, &data[1]))
> -                       eth_test->flags |= ETH_TEST_FL_FAILED;
> -
> -               e1000e_reset(adapter);
> -               if (e1000_intr_test(adapter, &data[2]))
> -                       eth_test->flags |= ETH_TEST_FL_FAILED;
> -
> -               e1000e_reset(adapter);
> -               if (e1000_loopback_test(adapter, &data[3]))
> -                       eth_test->flags |= ETH_TEST_FL_FAILED;
> -
> -               /* force this routine to wait until autoneg complete/timeout */
> -               adapter->hw.phy.autoneg_wait_to_complete = 1;
> -               e1000e_reset(adapter);
> -               adapter->hw.phy.autoneg_wait_to_complete = 0;
> -
> -               if (e1000_link_test(adapter, &data[4]))
> -                       eth_test->flags |= ETH_TEST_FL_FAILED;
> -
> -               /* restore speed, duplex, autoneg settings */
> -               adapter->hw.phy.autoneg_advertised = autoneg_advertised;
> -               adapter->hw.mac.forced_speed_duplex = forced_speed_duplex;
> -               adapter->hw.mac.autoneg = autoneg;
> -               e1000e_reset(adapter);
> -
> -               clear_bit(__E1000_TESTING, &adapter->state);
> -               if (if_running)
> -                       e1000e_open(netdev);
> +               // LSC, RXO, MDAC, SRPD, ACK, MNG
> +               ew32(ICS, E1000_ICR_RXO | E1000_ICR_OTHER);
>         } else {
> -               /* Online tests */
> -
> -               e_info("online testing starting\n");
> -
> -               /* register, eeprom, intr and loopback tests not run online */
> -               data[0] = 0;
> -               data[1] = 0;
> -               data[2] = 0;
> -               data[3] = 0;
> -
> -               if (e1000_link_test(adapter, &data[4]))
> -                       eth_test->flags |= ETH_TEST_FL_FAILED;
> -
> -               clear_bit(__E1000_TESTING, &adapter->state);
> -       }
> -
> -       if (!if_running) {
> -               e1000e_reset(adapter);
> -
> -               if (adapter->flags & FLAG_HAS_AMT)
> -                       e1000e_release_hw_control(adapter);
> +               ew32(ICS, E1000_ICR_LSC | E1000_ICR_OTHER);
>         }
>
> -       msleep_interruptible(4 * 1000);
> +       clear_bit(__E1000_TESTING, &adapter->state);
>
>         pm_runtime_put_sync(netdev->dev.parent);
>  }
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index fffc1f0e3895..5b3a0feaf052 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -46,6 +46,10 @@
>
>  #include "e1000.h"
>
> +DEFINE_RATELIMIT_STATE(rx_ratelimit_state, 2 * HZ, 1);
> +DEFINE_RATELIMIT_STATE(other_ratelimit_state, 2 * HZ, 1);
> +DEFINE_RATELIMIT_STATE(other_ratelimit_state2, 2 * HZ, 1);
> +
>  #define DRV_EXTRAVERSION "-k"
>
>  #define DRV_VERSION "3.2.6" DRV_EXTRAVERSION
> @@ -936,6 +940,9 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>         int cleaned_count = 0;
>         bool cleaned = false;
>         unsigned int total_rx_bytes = 0, total_rx_packets = 0;
> +       static unsigned int count;
> +
> +       mdelay(10);
>
>         i = rx_ring->next_to_clean;
>         rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
> @@ -1067,6 +1074,16 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>
>         adapter->total_rx_bytes += total_rx_bytes;
>         adapter->total_rx_packets += total_rx_packets;
> +
> +       count++;
> +       if (__ratelimit(&rx_ratelimit_state)) {
> +               static unsigned int max;
> +               max = max(max, total_rx_packets);
> +               trace_printk("rx %u now, max %u, %u rounds\n",
> +                            total_rx_packets, max, count);
> +               count = 0;
> +       }
> +
>         return cleaned;
>  }
>
> @@ -1914,14 +1931,30 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>         struct net_device *netdev = data;
>         struct e1000_adapter *adapter = netdev_priv(netdev);
>         struct e1000_hw *hw = &adapter->hw;
> -       u32 icr = er32(ICR);
> +       static unsigned int count;
> +       u32 icr2, icr = er32(ICR);
>
>         /* Certain events (such as RXO) which trigger Other do not set
>          * INT_ASSERTED. In that case, read to clear of icr does not take
>          * place.
>          */
> +       /*
>         if (!(icr & E1000_ICR_INT_ASSERTED))
>                 ew32(ICR, E1000_ICR_OTHER);
> +       */
> +
> +       icr2 = er32(ICR);
> +
> +       count++;
> +       if (__ratelimit(&other_ratelimit_state)) {
> +               trace_printk("icr 0x%08x icr2 0x%08x count %u\n", icr, icr2,
> +                            count);
> +               count = 0;
> +       }
> +       if (icr & E1000_ICR_RXO && icr & E1000_ICR_INT_ASSERTED &&
> +           __ratelimit(&other_ratelimit_state2)) {
> +               trace_printk("special icr 0x%08x icr2 0x%08x\n", icr, icr2);
> +       }
>
>         if (icr & adapter->eiac_mask)
>                 ew32(ICS, (icr & adapter->eiac_mask));
