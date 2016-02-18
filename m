From: David Miller <davem@davemloft.net>
Date: Thu, 18 Feb 2016 10:22:37 -0500 (EST)
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
 using a device tree blob V4
In-Reply-To: <97579B9E-E7C6-4DBE-B1A2-027C2EA7F754@gmail.com>
References: <56C506FD.5040408@gmail.com>
 <20160217.212910.1758016077144502307.davem@davemloft.net>
 <97579B9E-E7C6-4DBE-B1A2-027C2EA7F754@gmail.com>
Message-ID: <20160218.102237.2040974178950445305.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: John Holland <jotihojr@gmail.com>
Date: Thu, 18 Feb 2016 08:53:07 +0100

> The PCI path in eth_platform_get_mac_address() didn't return a devicetree node...

Then fix your platform such that pci_device_to_OF_node() works
properly instead of adding localized hacks to device drivers.

Jeff, do not apply this patch.
