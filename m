From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 11 Sep 2017 14:21:36 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: fix the FWSM.PT check in
	ixgbe_mng_present()
In-Reply-To: <20170911212131.27262.52988.stgit@localhost6.localdomain6>
References: <20170911212131.27262.52988.stgit@localhost6.localdomain6>
Message-ID: <20170911212136.27262.78426.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bits other than FWSM.PT can be set in IXGBE_SWFW_MODE_MASK making the
previous check invalid.

Change the check for MNG present to be only based on FWSM.PT bit.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 041940c..4e5c92d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -4100,8 +4100,8 @@ bool ixgbe_mng_present(struct ixgbe_hw *hw)
 		return false;
 
 	fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
-	fwsm &= IXGBE_FWSM_MODE_MASK;
-	return fwsm == IXGBE_FWSM_FW_MODE_PT;
+
+	return !!(fwsm & IXGBE_FWSM_FW_MODE_PT);
 }
 
 /**

