From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Mon, 04 Jun 2018 16:51:15 -0400
Subject: [Intel-wired-lan] [net-queue PATCH v2 0/2] ixgbe: ipsec fixes
Message-ID: <20180604204931.5474.94068.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is v2 of the patch I submitted earlier today to address issues
reported on a 1GBaseT x553 connection.

This new patch addresses the issue much the same way but also fixs a couple
of minor issues including unnecessary bits being there for XFRM vs
XFRM_OFFLOAD and the fact that we wanted the bits set in hw_features, not
hw_enc_features.

---

Alexander Duyck (2):
      ixgbe: Use CONFIG_XFRM_OFFLOAD instead of CONFIG_XFRM
      ixgbe: Move ipsec init function to before reset call


 drivers/net/ethernet/intel/ixgbe/ixgbe.h       |    4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c |    7 -------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   13 ++++++++++---
 3 files changed, 12 insertions(+), 12 deletions(-)

--
