From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Thu, 24 Dec 2015 06:17:34 +0000
Subject: [Intel-wired-lan] [V2 PATCH 1/1] ixgbe: force to synchronize
 reporting "link on" and
In-Reply-To: <567B7E61.3070207@gmail.com>
References: <1450868046.3316.11.camel@intel.com>
 <1450926752-11392-1-git-send-email-zyjzyj2000@gmail.com>
 <567B7E61.3070207@gmail.com>
Message-ID: <87618083B2453E4A8714035B62D67992504EC996@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>Behalf Of zhuyj
>Sent: Wednesday, December 23, 2015 9:11 PM
>To: Kirsher, Jeffrey T; Brandeburg, Jesse; Nelson, Shannon; Wyborny,
>Carolyn; Skidmore, Donald C; Allan, Bruce W; Ronciak, John; Williams, Mitch
>A; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; e1000-
>devel at lists.sourceforge.net
>Cc: Viswanathan, Ven (Wind River); Shteinbock, Boris (Wind River); Bourg,
>Vincent (Wind River)
>Subject: Re: [Intel-wired-lan] [V2 PATCH 1/1] ixgbe: force to synchronize
>reporting "link on" and
>
>On 12/24/2015 11:12 AM, zyjzyj2000 at gmail.com <mailto:zyjzyj2000@gmail.com>
>wrote:
>
>
>
>	Hi, Jeff
>
>	Thanks for your reply.
>
>	Changes:
>	Since there is a time span between link_up and link_speed to X540
>NIC, it is not appropriate to continue in the function
>ixgbe_watchdog_link_is_up if only link_up is ready.
>
>	Best Regards!
>	Zhu Yanjun
>	--
>	To unsubscribe from this list: send the line "unsubscribe netdev" in
>	the body of a message to majordomo at vger.kernel.org
><mailto:majordomo@vger.kernel.org>
>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>Hi, Jeff
>
>The following logs are from the customer.  From these logs, there is a time
>span between link_up and link_speed.
>This time span sometimes will make bonding in 802.3ad mode not work well.
>
>What I have done in the patch is to prevent this time span in the ixgbe
>driver.
>
>Best Regards!
>Zhu Yanjun
>
>Settings for eth0:
>    Supported ports: [ TP ]
>    Supported link modes:   100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Supported pause frame use: No
>    Supports auto-negotiation: Yes
>    Advertised link modes:  100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Advertised pause frame use: No
>    Advertised auto-negotiation: Yes
>    Speed: Unknown!
>    Duplex: Unknown! (255)
>    Port: Twisted Pair
>    PHYAD: 0
>    Transceiver: external
>    Auto-negotiation: on
>    MDI-X: Unknown
>    Supports Wake-on: d
>    Wake-on: d
>    Current message level: 0x00000007 (7)
>                   drv probe link
>    Link detected: no
>Settings for eth0:
>    Supported ports: [ TP ]
>    Supported link modes:   100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Supported pause frame use: No
>    Supports auto-negotiation: Yes
>    Advertised link modes:  100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Advertised pause frame use: No
>    Advertised auto-negotiation: Yes
>    Speed: Unknown!
>    Duplex: Unknown! (255)
>    Port: Twisted Pair
>    PHYAD: 0
>    Transceiver: external
>    Auto-negotiation: on
>    MDI-X: Unknown
>    Supports Wake-on: d
>    Wake-on: d
>    Current message level: 0x00000007 (7)
>                   drv probe link
>    Link detected: yes
>Settings for eth0:
>    Supported ports: [ TP ]
>    Supported link modes:   100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Supported pause frame use: No
>    Supports auto-negotiation: Yes
>    Advertised link modes:  100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Advertised pause frame use: No
>    Advertised auto-negotiation: Yes
>    Speed: Unknown!
>    Duplex: Unknown! (255)
>    Port: Twisted Pair
>    PHYAD: 0
>    Transceiver: external
>    Auto-negotiation: on
>    MDI-X: Unknown
>    Supports Wake-on: d
>    Wake-on: d
>    Current message level: 0x00000007 (7)
>                   drv probe link
>    Link detected: yes
>Settings for eth0:
>    Supported ports: [ TP ]
>    Supported link modes:   100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Supported pause frame use: No
>    Supports auto-negotiation: Yes
>    Advertised link modes:  100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Advertised pause frame use: No
>    Advertised auto-negotiation: Yes
>    Speed: Unknown!
>    Duplex: Unknown! (255)
>    Port: Twisted Pair
>    PHYAD: 0
>    Transceiver: external
>    Auto-negotiation: on
>    MDI-X: Unknown
>    Supports Wake-on: d
>    Wake-on: d
>    Current message level: 0x00000007 (7)
>                   drv probe link
>    Link detected: yes
>Settings for eth0:
>    Supported ports: [ TP ]
>    Supported link modes:   100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Supported pause frame use: No
>    Supports auto-negotiation: Yes
>    Advertised link modes:  100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Advertised pause frame use: No
>    Advertised auto-negotiation: Yes
>    Speed: Unknown!
>    Duplex: Unknown! (255)
>    Port: Twisted Pair
>    PHYAD: 0
>    Transceiver: external
>    Auto-negotiation: on
>    MDI-X: Unknown
>    Supports Wake-on: d
>    Wake-on: d
>    Current message level: 0x00000007 (7)
>                   drv probe link
>    Link detected: yes
>Settings for eth0:
>    Supported ports: [ TP ]
>    Supported link modes:   100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Supported pause frame use: No
>    Supports auto-negotiation: Yes
>    Advertised link modes:  100baseT/Full
>                            1000baseT/Full
>                            10000baseT/Full
>    Advertised pause frame use: No
>    Advertised auto-negotiation: Yes
>    Speed: 10000Mb/s
>    Duplex: Full
>    Port: Twisted Pair
>    PHYAD: 0
>    Transceiver: external
>    Auto-negotiation: on
>    MDI-X: Unknown
>    Supports Wake-on: d
>    Wake-on: d
>    Current message level: 0x00000007 (7)
>                   drv probe link
>    Link detected: yes

Can you provide the related dmesg output? 
What did the driver report in the "Link Up" messages?

Thanks,
Emil
