From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 23 Jun 2016 13:31:01 -0700
Subject: [Intel-wired-lan] [PATCH v2] fm10k: don't continue probe if PCI
	device not in normal IO state
In-Reply-To: <20160623203103.30528-1-jacob.e.keller@intel.com>
References: <20160623203103.30528-1-jacob.e.keller@intel.com>
Message-ID: <20160623203103.30528-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In the event of an uncorrectable AER error occuring when the driver has
not loaded, the recovery routines are not done. This is done because
future loads of the driver may not be aware of the IO state and may not
be able to recover at all. In this case, when we next load the driver it
fails due to what appears to be a surprise remove event. Instead, add
a check to ensure that the device is in the normal IO state before
continuing to probe. This allows us to give a more descriptive message
of what is wrong.

Without this change, the driver will attempt to probe up to our first
call of .reset_hw() which will be unable to read registers and act as if
a surprise remove event occurred.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 552268292ac8..0293eed5005b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1950,6 +1950,12 @@ static int fm10k_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct fm10k_intfc *interface;
 	int err;
 
+	if (pdev->error_state != pci_channel_io_normal) {
+		dev_err(&pdev->dev,
+			"PCI device still in an error state. Unable to load...\n");
+		return -EIO;
+	}
+
 	err = pci_enable_device_mem(pdev);
 	if (err) {
 		dev_err(&pdev->dev,
-- 
2.9.0.rc1.405.g81f467e

