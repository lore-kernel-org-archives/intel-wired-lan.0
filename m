From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 17 May 2017 15:17:36 -0700
Subject: [Intel-wired-lan] [PATCH 0/5] ixgbe: fixes for configuring link on
	x550a
Message-ID: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following series introduces small fixes needed to address issues
with setting up link on SFP+ based x550a parts.

---

Emil Tantilov (5):
      ixgbe: correct CS4223/7 PHY identification
      ixgbe: add write flush when configuring CS4223/7
      ixgbe: always call setup_mac_link for multispeed fiber
      ixgbe: add missing configuration for rate select 1
      ixgbe: fix incorrect status check


 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   37 ++++++++++++-----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h    |    5 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |   30 ++++++++++++++-----
 3 files changed, 45 insertions(+), 27 deletions(-)

--
