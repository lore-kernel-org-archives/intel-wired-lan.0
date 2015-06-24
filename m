From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 24 Jun 2015 13:34:48 -0700
Subject: [Intel-wired-lan] [PATCH net-next rc1 08/10] fm10k: re-enable VF
	after a full reset on detection of a Malicious event
In-Reply-To: <1435178090-25422-1-git-send-email-jacob.e.keller@intel.com>
References: <1435178090-25422-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1435178090-25422-9-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Modify behavior of Malicious Driver Detection events. Presently, the
hardware disables the VF queues and re-assigns them to the PF. This
causes the VF in question to continuously Tx hang, because it assumes
that it can transmit over the queues in question. For transient events,
this results in continuous logging of malicious events.

New behavior is to reset the LPORT and VF state, so that the VF will
have to reset and re-enable itself. This does mean that malicious VFs
will possibly be able to continue and attempt malicious events again.
However, it is expected that system administrators will step in and
manually remove or disable the VF in question.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 30 ++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 989981ea3c64..1d788085b57a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -896,10 +896,12 @@ void fm10k_netpoll(struct net_device *netdev)
 
 #endif
 #define FM10K_ERR_MSG(type) case (type): error = #type; break
-static void fm10k_print_fault(struct fm10k_intfc *interface, int type,
+static void fm10k_handle_fault(struct fm10k_intfc *interface, int type,
 			      struct fm10k_fault *fault)
 {
 	struct pci_dev *pdev = interface->pdev;
+	struct fm10k_hw *hw = &interface->hw;
+	struct fm10k_iov_data *iov_data = interface->iov_data;
 	char *error;
 
 	switch (type) {
@@ -953,6 +955,30 @@ static void fm10k_print_fault(struct fm10k_intfc *interface, int type,
 		 "%s Address: 0x%llx SpecInfo: 0x%x Func: %02x.%0x\n",
 		 error, fault->address, fault->specinfo,
 		 PCI_SLOT(fault->func), PCI_FUNC(fault->func));
+
+	/* For VF faults, clear out the respective LPORT, reset the queue
+	 * resources, and then reconnect to the mailbox. This allows the
+	 * VF in question to resume behavior. For transient faults that are
+	 * the result of non-malicious behavior this will log the fault and
+	 * allow the VF to resume functionality. Obviously for malicious VFs
+	 * they will be able to attempt malicious behavior again. In this
+	 * case, the system administrator will need to step in and manually
+	 * remove or disable the VF in question.
+	 */
+	if (fault->func && iov_data) {
+		int vf = fault->func - 1;
+		struct fm10k_vf_info *vf_info = &iov_data->vf_info[vf];
+
+		hw->iov.ops.reset_lport(hw, vf_info);
+		hw->iov.ops.reset_resources(hw, vf_info);
+
+		/* reset_lport disables the VF, so re-enable it */
+		hw->iov.ops.set_lport(hw, vf_info, vf,
+				      FM10K_VF_FLAG_MULTI_CAPABLE);
+
+		/* reset_resources will disconnect from the mbx  */
+		vf_info->mbx.ops.connect(hw, &vf_info->mbx);
+	}
 }
 
 static void fm10k_report_fault(struct fm10k_intfc *interface, u32 eicr)
@@ -976,7 +1002,7 @@ static void fm10k_report_fault(struct fm10k_intfc *interface, u32 eicr)
 			continue;
 		}
 
-		fm10k_print_fault(interface, type, &fault);
+		fm10k_handle_fault(interface, type, &fault);
 	}
 }
 
-- 
2.4.3

