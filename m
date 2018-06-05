From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 05 Jun 2018 11:11:03 -0400
Subject: [Intel-wired-lan] [net-queue PATCH 0/2] More fixes for ipsec
Message-ID: <20180605150520.3359.94409.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This set addresses a few more issues for ipsec.

1. We fix the bit definitions for the SECTXSTAT and SECRXSTAT registers.
2. Use those new definitions to test if fuse or strapping disabled ipsec.
3. Fix boolean logic testing for if we disabled it correctly in software.
4. Add additional test to avoid loopback and wait if it isn't needed.

---

Alexander Duyck (2):
      ixgbe: Avoid loopback and fix boolean logic in ipsec_stop_data
      ixgbe: Fix bit definitions and add support for testing for ipsec support


 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c |   27 +++++++++++++++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |    6 ++++-
 2 files changed, 28 insertions(+), 5 deletions(-)

--
