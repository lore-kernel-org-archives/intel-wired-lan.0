From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Mon, 28 Nov 2016 10:42:18 -0500
Subject: [Intel-wired-lan] [net PATCH 0/2] Don't use lco_csum to compute
	IPv4 checksum
Message-ID: <20161128153927.15466.99193.stgit@ahduyck-blue-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When I implemented the GSO partial support in the Intel drivers I was using
lco_csum to compute the checksum that we needed to plug into the IPv4
checksum field in order to cancel out the data that was not a part of the
IPv4 header.  However this didn't take into account that the transport
offset might be pointing to the inner transport header.

Instead of using lco_csum I have just coded around it so that we can use
the outer IP header plus the IP header length to determine where we need to
start our checksum and then just call csum_partial ourselves.

This should fix the SIT issue reported on igb interfaces as well as simliar
issues that would pop up on other Intel NICs.

---

Alexander Duyck (2):
      igb/igbvf: Don't use lco_csum to compute IPv4 checksum
      ixgbe/ixgbevf: Don't use lco_csum to compute IPv4 checksum


 drivers/net/ethernet/intel/igb/igb_main.c         |    8 ++++++--
 drivers/net/ethernet/intel/igbvf/netdev.c         |    8 ++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |    8 ++++++--
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    8 ++++++--
 4 files changed, 24 insertions(+), 8 deletions(-)

--
