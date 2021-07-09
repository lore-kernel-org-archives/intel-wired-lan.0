From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  9 Jul 2021 14:07:26 -0700
Subject: [Intel-wired-lan] [PATCH] ice: fix build issue if
 CONFIG_1588_PTP_CLOCk=m
Message-ID: <20210709210726.224848-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If the CONFIG_1588_PTP_CLOCK symbol is set to m, then the driver will
not compile ice_ptp.o and ice_ptp_hw.o because it adds them to ice-m
instead of ice-y, and nothing includes ice-m into the final kernel
objects.

Fix this by using the ':m=y' so that we always compile the files and
link them to ice.o when CONFIG_1588_PTP_CLOCK is a module or a builtin.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
This fixes the compilation errors that have appeared from lkp on Tony's
dev-queue. The lkp complains about other patches, but the root cause is this
issue. If we apply this, it should fix all of the lkp issues I've seen so
far.

 drivers/net/ethernet/intel/ice/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 1866be50095d..928572dfb3c2 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -30,7 +30,7 @@ ice-y := ice_main.o	\
 	 ice_repr.o
 ice-$(CONFIG_PCI_IOV) += ice_virtchnl_allowlist.o
 ice-$(CONFIG_PCI_IOV) += ice_virtchnl_pf.o ice_sriov.o ice_virtchnl_fdir.o
-ice-$(CONFIG_PTP_1588_CLOCK) += ice_ptp.o ice_ptp_hw.o
+ice-$(CONFIG_PTP_1588_CLOCK:m=y) += ice_ptp.o ice_ptp_hw.o
 ice-$(CONFIG_DCB) += ice_dcb.o ice_dcb_nl.o ice_dcb_lib.o
 ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
 ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
-- 
2.31.1.331.gb0c09ab8796f

