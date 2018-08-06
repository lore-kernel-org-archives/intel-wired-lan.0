From: Camille Bordignon <camille.bordignon@easymile.com>
Date: Mon, 6 Aug 2018 13:59:13 +0200
Subject: [Intel-wired-lan] e1000e driver stuck at 10Mbps after reconnection
Message-ID: <20180806115913.GA21556@super_plancton>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

Recently we experienced some issues with intel NIC (I219-LM and I219-V).
It seems that after a wire reconnection, auto-negotation "fails" and
link speed drips to 10 Mbps.

From kernel logs:
[17616.346150] e1000e: enp0s31f6 NIC Link is Down
[17627.003322] e1000e: enp0s31f6 NIC Link is Up 10 Mbps Full Duplex, Flow Control: None
[17627.003325] e1000e 0000:00:1f.6 enp0s31f6: 10/100 speed: disabling TSO


$ethtool enp0s31f6
Settings for enp0s31f6:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: No
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: 10Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        MDI-X: on (auto)
        Supports Wake-on: pumbg
        Wake-on: g
        Current message level: 0x00000007 (7)
                               drv probe link
        Link detected: yes


Notice that if disconnection last less than about 5 seconds,
nothing wrong happens.
And if after last failure, disconnection / connection occurs again and
last less than 5 seconds, link speed is back to 1000 Mbps.

[18075.350678] e1000e: enp0s31f6 NIC Link is Down
[18078.716245] e1000e: enp0s31f6 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None

The following patch seems to fix this issue.
However I don't clearly understand why.

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 3ba0c90e7055..763c013960f1 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5069,7 +5069,7 @@ static bool e1000e_has_link(struct e1000_adapter *adapter)
 	case e1000_media_type_copper:
 		if (hw->mac.get_link_status) {
 			ret_val = hw->mac.ops.check_for_link(hw);
-			link_active = !hw->mac.get_link_status;
+			link_active = false;
 		} else {
 			link_active = true;
 		}

Maybe this is related to watchdog task.

I've found out this fix by comparing with last commit that works fine :
commit 0b76aae741abb9d16d2c0e67f8b1e766576f897d.
However I don't know if this information is relevant.

Thank you.
Camille Bordignon
