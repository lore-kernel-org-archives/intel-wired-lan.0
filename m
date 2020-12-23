From: Xing, Beilei <beilei.xing@intel.com>
Date: Wed, 23 Dec 2020 01:37:27 +0000
Subject: [Intel-wired-lan] X710 NIC can't do IPv6 VXLAN TSO offload
In-Reply-To: <c38c0e82b9314dff9ae59c10ca5292e8@inspur.com>
References: <c38c0e82b9314dff9ae59c10ca5292e8@inspur.com>
Message-ID: <MN2PR11MB38071BE26150EDE0F0C3FF95F7DE0@MN2PR11MB3807.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

+Guanghua.

Hi Yi,

Could you please detail your test steps?

BR,
Beilei

From: Yi Yang (??)-????? <yangyi01@inspur.com>
Sent: Wednesday, December 23, 2020 9:29 AM
To: intel-wired-lan@lists.osuosl.org
Cc: Yi Yang (??)-????? <yangyi01@inspur.com>; Xing, Beilei <beilei.xing@intel.com>
Subject: X710 NIC can't do IPv6 VXLAN TSO offload
Importance: High

Hi, folks

Anybody can tell me why IPv6 VXLAN TSO offload can?t work for me? I have tried OVS DPDK and Linux kernel, the result is same, how can we fix it? By firmware update or other ways?

BTW,  IPv4 VXLAN TSO is ok no matter inner packet is IPv4 or IPv6.

07:00.0 Ethernet controller: Intel Corporation Ethernet Controller X710 for 10GbE SFP+ (rev 02)

$ ethtool -i enp7s0f0
driver: i40e
version: 2.1.14-k
firmware-version: 6.01 0x80003d3b 1.1862.0
expansion-rom-version:
bus-info: 0000:07:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201223/af5c3244/attachment.html>
