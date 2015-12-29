From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Tue, 29 Dec 2015 16:18:36 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: restrict synchronization
 of	link_up and speed
In-Reply-To: <1451356326-2919-3-git-send-email-zyjzyj2000@gmail.com>
References: <1450926752-11392-1-git-send-email-zyjzyj2000@gmail.com>
 <1451356326-2919-1-git-send-email-zyjzyj2000@gmail.com>
 <1451356326-2919-3-git-send-email-zyjzyj2000@gmail.com>
Message-ID: <87618083B2453E4A8714035B62D67992504FB5FF@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>Behalf Of zyjzyj2000 at gmail.com
>Sent: Monday, December 28, 2015 6:32 PM
>To: Kirsher, Jeffrey T; Brandeburg, Jesse; Nelson, Shannon; Wyborny,
>Carolyn; Skidmore, Donald C; Allan, Bruce W; Ronciak, John; Williams, Mitch
>A; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; e1000-
>devel at lists.sourceforge.net
>Cc: Viswanathan, Ven (Wind River); Shteinbock, Boris (Wind River); Bourg,
>Vincent (Wind River)
>Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: restrict synchronization of
>link_up and speed
>
>From: Zhu Yanjun <yanjun.zhu@windriver.com>
>
>When the X540 NIC acts as a slave of some virtual NICs, it is very
>important to synchronize link_up and link_speed, such as a bonding
>driver in 802.3ad mode. When X540 NIC acts as an independent interface,
>it is not necessary to synchronize link_up and link_speed. That is,
>the time span between link_up and link_speed is acceptable.

What exactly do you mean by "time span between link_up and link_speed"?
Where is it you think the de-synchronization occurs?

>Signed-off-by: Zhu Yanjun <yanjun.zhu@windriver.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>index ace21b9..1bb6056 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>@@ -6436,8 +6436,15 @@ static void ixgbe_watchdog_link_is_up(struct
>ixgbe_adapter *adapter)
> 	 * time. To X540 NIC, there is a time span between link_up and
> 	 * link_speed. As such, only continue if link_up and link_speed are
> 	 * ready to X540 NIC.
>+	 * The time span between link_up and link_speed is very important
>+	 * when the X540 NIC acts as a slave in some virtual NICs, such as
>+	 * a bonding driver in 802.3ad mode. When X540 NIC acts as an
>+	 * independent interface, it is not necessary to synchronize link_up
>+	 * and link_speed.
>+	 * In the end, not continue if (X540 NIC && SLAVE && link_speed
>UNKNOWN)

This is a patch on top of your previous patch which I don't think was applied, 
so this is not going to apply cleanly.

> 	 */
>-	if (hw->mac.type == ixgbe_mac_X540)
>+	if ((hw->mac.type == ixgbe_mac_X540) &&
>+	    (netdev->flags & IFF_SLAVE))
> 		if (link_speed == IXGBE_LINK_SPEED_UNKNOWN)
> 			return;

If you were to enter ixgbe_watchdog_link_is_up() with unknown speed, then I would
assume that you also have a dmesg that shows:
"NIC Link is Up unknown speed"

by the interface you use in the bond?

Thanks,
Emil

