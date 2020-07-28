From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Tue, 28 Jul 2020 09:41:53 +0800
Subject: [Intel-wired-lan] [PATCH net-next] ice: mark PM functions as
 __maybe_unused
Message-ID: <20200728014153.44834-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In certain configurations without power management support, the
following warnings happen:

drivers/net/ethernet/intel/ice/ice_main.c:4214:12: warning:
 'ice_resume' defined but not used [-Wunused-function]
 4214 | static int ice_resume(struct device *dev)
      |            ^~~~~~~~~~
drivers/net/ethernet/intel/ice/ice_main.c:4150:12: warning:
 'ice_suspend' defined but not used [-Wunused-function]
 4150 | static int ice_suspend(struct device *dev)
      |            ^~~~~~~~~~~

Mark these functions as __maybe_unused to make it clear to the
compiler that this is going to happen based on the configuration,
which is the standard for these types of functions.

Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d6981ba34b27..6edf018c4940 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4147,7 +4147,7 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
  * Power Management callback to quiesce the device and prepare
  * for D3 transition.
  */
-static int ice_suspend(struct device *dev)
+static int __maybe_unused ice_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ice_pf *pf;
@@ -4211,7 +4211,7 @@ static int ice_suspend(struct device *dev)
  * ice_resume - PM callback for waking up from D3
  * @dev: generic device information structure
  */
-static int ice_resume(struct device *dev)
+static int __maybe_unused ice_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	enum ice_reset_req reset_type;

