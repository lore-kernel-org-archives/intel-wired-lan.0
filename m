From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 13 Jan 2016 07:31:04 -0800
Subject: [Intel-wired-lan] [next PATCH v2 0/4] Add support for generic Tx
 checksums to igb, ixgbe, igbvf, ixgbevf
Message-ID: <20160113153001.4527.91152.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It turns out we were doing far more than we needed to in the Tx checksum
functions for the drivers.  As a result it hid the fact that the hardware
is actually much more capable of handling generic offloads then previously
realized.

This patch series enables generic Tx checksum support for igb and ixgbe
based Intel server adapters.  In addition it adds a number of other items
such as:
  Inner checksum support for MPLS
  Encapsulated checksum support for igb, igbvf, and ixgbevf
  SCTP CRC offload support for VLAN tunnels, and VFs
  IPv6 extension header support for igb and igbvf

v2: Fixed whitespace errors in igbvf patch.
    Updated patch descriptions to wrap lines at 75 characters.

---

Alexander Duyck (4):
      ixgbe: Add support for generic Tx checksums
      ixgbevf: Add support for generic Tx checksums
      igb: Add support for generic Tx checksums
      igbvf: Add support for generic Tx checksums


 drivers/net/ethernet/intel/igb/igb_main.c         |  114 ++++++---------
 drivers/net/ethernet/intel/igbvf/netdev.c         |  142 ++++++++++--------
 drivers/net/ethernet/intel/igbvf/vf.h             |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  163 ++++++++-------------
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  104 ++++++-------
 5 files changed, 231 insertions(+), 293 deletions(-)

--
