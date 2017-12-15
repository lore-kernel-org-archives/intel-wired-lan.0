From: Peter Bergin <peter@berginkonsult.se>
Date: Fri, 15 Dec 2017 14:31:14 +0100
Subject: [Intel-wired-lan] ixgbe driver - Link Modes
Message-ID: <02f03d55-67f9-c0e3-068a-4863629894ae@berginkonsult.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I'm currently working with a kernel upgrade in a system using Intel 
82599EB 10Gb NIC. The kernel will be changed from version 3.4 to 4.1. 
When looking into the details with 'ethtool' I see a difference in the 
'Supported link modes:' and 'Advertised link modes:' fields between the 
kernels on same hardware. Can anyone help me understand this difference 
and if it is critical or not?

Thanks,
/Peter

With kernel 3.4:

~ # ethtool eth6
Settings for eth6:
Supported ports: [ FIBRE ]
*Supported link modes: 1000baseT/Full**
**10000baseT/Full*
Supports auto-negotiation: Yes
*Advertised link modes: 1000baseT/Full**
**10000baseT/Full*
Advertised pause frame use: No
Advertised auto-negotiation: Yes
Speed: 10000Mb/s
Duplex: Full
Port: Other
PHYAD: 0
Transceiver: external
Auto-negotiation: on
Supports Wake-on: umbg
Wake-on: g
Current message level: 0x00000007 (7)
drv probe link
Link detected: yes

~ # ethtool -i eth6
driver: ixgbe
version: 3.8.21-k
firmware-version: 0x800000c9
bus-info: 0000:05:00.1



With kernel 4.1:

~ # ethtool eth6
Settings for eth6:
Supported ports: [ FIBRE ]
*Supported link modes: 1000baseT/Full*
Supports auto-negotiation: Yes
*Advertised link modes: 1000baseT/Full**
*Advertised pause frame use: No
Advertised auto-negotiation: Yes
Speed: 10000Mb/s
Duplex: Full
Port: Other
PHYAD: 0
Transceiver: external
Auto-negotiation: on
Supports Wake-on: umbg
Wake-on: g
Current message level: 0x00000007 (7)
drv probe link
Link detected: yes

~ # ethtool -i eth6
driver: ixgbe
version: 4.4.0-k
firmware-version: 0x800000c9
bus-info: 0000:05:00.1


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171215/57f90ce3/attachment.html>
