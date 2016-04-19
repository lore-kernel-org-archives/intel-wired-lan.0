From: K. Y. Srinivasan <kys@microsoft.com>
Date: Tue, 19 Apr 2016 13:12:02 -0700
Subject: [Intel-wired-lan] [PATCH net-next V4 1/2] ethernet: intel: Add the
	device ID's presented while running on Hyper-V
In-Reply-To: <1461096698-26430-1-git-send-email-kys@microsoft.com>
References: <1461096698-26430-1-git-send-email-kys@microsoft.com>
Message-ID: <1461096723-26471-1-git-send-email-kys@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Intel SR-IOV cards present different ID when running on Hyper-V.
Add the device IDs presented while running on Hyper-V.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
	V4: No change from V1

 drivers/net/ethernet/intel/ixgbevf/defines.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index 5843458..1306a0d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -33,6 +33,11 @@
 #define IXGBE_DEV_ID_X550_VF		0x1565
 #define IXGBE_DEV_ID_X550EM_X_VF	0x15A8
 
+#define IXGBE_DEV_ID_82599_VF_HV	0x152E
+#define IXGBE_DEV_ID_X540_VF_HV		0x1530
+#define IXGBE_DEV_ID_X550_VF_HV		0x1564
+#define IXGBE_DEV_ID_X550EM_X_VF_HV	0x15A9
+
 #define IXGBE_VF_IRQ_CLEAR_MASK		7
 #define IXGBE_VF_MAX_TX_QUEUES		8
 #define IXGBE_VF_MAX_RX_QUEUES		8
-- 
1.7.4.1

