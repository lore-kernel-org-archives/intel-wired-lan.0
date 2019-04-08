From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Apr 2019 16:52:01 -0700
Subject: [Intel-wired-lan] [PATCH 4/5] ixgbe: use 'cc' instead of 'hw_cc'
 for local variable
In-Reply-To: <20190408235202.10676-1-jacob.e.keller@intel.com>
References: <20190408235202.10676-1-jacob.e.keller@intel.com>
Message-ID: <20190408235202.10676-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ixgbe_ptp.c file sometimes uses hw_cc as the local variable for the
cycle counter in ixgbe_ptp_read_X550. However, we use just 'cc' as
a local variable for this by convention else where in the file.

Convert this lone usage of 'hw_cc' into just the shorter 'cc' name to
match the other read functions in the file.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 41d75d60753a..8f8cb0a1bea0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -321,7 +321,7 @@ static void ixgbe_ptp_setup_sdp_X550(struct ixgbe_adapter *adapter)
 
 /**
  * ixgbe_ptp_read_X550 - read cycle counter value
- * @hw_cc: cyclecounter structure
+ * @cc: cyclecounter structure
  *
  * This function reads SYSTIME registers. It is called by the cyclecounter
  * structure to convert from internal representation into nanoseconds. We need
@@ -329,10 +329,10 @@ static void ixgbe_ptp_setup_sdp_X550(struct ixgbe_adapter *adapter)
  * result of SYSTIME is 32bits of "billions of cycles" and 32 bits of
  * "cycles", rather than seconds and nanoseconds.
  */
-static u64 ixgbe_ptp_read_X550(const struct cyclecounter *hw_cc)
+static u64 ixgbe_ptp_read_X550(const struct cyclecounter *cc)
 {
 	struct ixgbe_adapter *adapter =
-			container_of(hw_cc, struct ixgbe_adapter, hw_cc);
+		container_of(cc, struct ixgbe_adapter, hw_cc);
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct timespec64 ts;
 
-- 
2.21.0.564.g2d7e7e4d310b

