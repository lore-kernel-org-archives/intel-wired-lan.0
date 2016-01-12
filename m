From: David Miller <davem@davemloft.net>
Date: Mon, 11 Jan 2016 23:43:54 -0500 (EST)
Subject: [Intel-wired-lan] [next PATCH 0/4] Add support for generic Tx
 checksums to igb, ixgbe, igbvf, ixgbevf
In-Reply-To: <20160111173724.4101.35798.stgit@localhost.localdomain>
References: <20160111173724.4101.35798.stgit@localhost.localdomain>
Message-ID: <20160111.234354.379572319999796564.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 11 Jan 2016 09:53:50 -0800

> It turns out we were doing far more than we needed to in the Tx checksum
> functions for the drivers.  As a result it hid the fact that the hardware
> is actually much more capable of handling generic offloads then previously
> realized.
> 
> This patch series enables generic Tx checksum support for igb and ixgbe
> based Intel server adapters.  In addition it adds a number of other items
> such as:
>   Inner checksum support for MPLS
>   Encapsulated checksum support for igb, igbvf, and ixgbevf
>   SCTP CRC offload support for VLAN tunnels, and VFs
>   IPv6 extension header support for igb and igbvf

I like this series, nice work!

This can go in when net-next opens back up, and I assume I'll get
it via Jeff K.
