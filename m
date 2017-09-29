From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Fri, 29 Sep 2017 10:55:42 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix crash when injecting AER after
	failed reset
Message-ID: <20170929175542.17801.97091.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In case where AER recovery fails the device is left in a down state.
Consecutive AER error injection can lead to a double IRQ free.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f854ce2..0c3f9c8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10890,6 +10890,9 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
 	if (!test_bit(__IXGBE_SERVICE_INITED, &adapter->state))
 		return PCI_ERS_RESULT_DISCONNECT;
 
+	if (!netif_device_present(netdev))
+		return PCI_ERS_RESULT_DISCONNECT;
+
 	rtnl_lock();
 	netif_device_detach(netdev);
 

