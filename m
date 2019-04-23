From: Joseph Yasi <joe.yasi@gmail.com>
Date: Mon, 22 Apr 2019 20:51:09 -0400
Subject: [Intel-wired-lan] [PATCH 1/2] Revert "e1000e: fix cyclic resets
 at link up with active tx"
In-Reply-To: <155548879651.3454.13167784936351314661.stgit@buzz>
References: <155548879651.3454.13167784936351314661.stgit@buzz>
Message-ID: <CADzA9o=6gUg4xrsqOKhgSXfXWiAtD6BbD4PsN4gf4H4GYyvvHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Apr 17, 2019 at 4:13 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> This reverts commit 0f9e980bf5ee1a97e2e401c846b2af989eb21c61.
>
> That change cased false-positive warning about hardware hang:
>
> e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> e1000e 0000:00:1f.6 eth0: Detected Hardware Unit Hang:
>    TDH                  <0>
>    TDT                  <1>
>    next_to_use          <1>
>    next_to_clean        <0>
> buffer_info[next_to_clean]:
>    time_stamp           <fffba7a7>
>    next_to_watch        <0>
>    jiffies              <fffbb140>
>    next_to_watch.status <0>
> MAC Status             <40080080>
> PHY Status             <7949>
> PHY 1000BASE-T Status  <0>
> PHY Extended Status    <3000>
> PCI Status             <10>
> e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
>
> Besides warning everything works fine.
> Original issue will be fixed property in following patch.
>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Reported-by: Joseph Yasi <joe.yasi@gmail.com>
Tested-by: Joseph Yasi <joe.yasi@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203175
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 7acc61e4f645..ba96e52aa8d1 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5309,13 +5309,8 @@ static void e1000_watchdog_task(struct work_struct *work)
>                         /* 8000ES2LAN requires a Rx packet buffer work-around
>                          * on link down event; reset the controller to flush
>                          * the Rx packet buffer.
> -                        *
> -                        * If the link is lost the controller stops DMA, but
> -                        * if there is queued Tx work it cannot be done.  So
> -                        * reset the controller to flush the Tx packet buffers.
>                          */
> -                       if ((adapter->flags & FLAG_RX_NEEDS_RESTART) ||
> -                           e1000_desc_unused(tx_ring) + 1 < tx_ring->count)
> +                       if (adapter->flags & FLAG_RX_NEEDS_RESTART)
>                                 adapter->flags |= FLAG_RESTART_NOW;
>                         else
>                                 pm_schedule_suspend(netdev->dev.parent,
> @@ -5338,6 +5333,14 @@ static void e1000_watchdog_task(struct work_struct *work)
>         adapter->gotc_old = adapter->stats.gotc;
>         spin_unlock(&adapter->stats64_lock);
>
> +       /* If the link is lost the controller stops DMA, but
> +        * if there is queued Tx work it cannot be done.  So
> +        * reset the controller to flush the Tx packet buffers.
> +        */
> +       if (!netif_carrier_ok(netdev) &&
> +           (e1000_desc_unused(tx_ring) + 1 < tx_ring->count))
> +               adapter->flags |= FLAG_RESTART_NOW;
> +
>         /* If reset is necessary, do it outside of interrupt context. */
>         if (adapter->flags & FLAG_RESTART_NOW) {
>                 schedule_work(&adapter->reset_task);
>
