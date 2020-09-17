From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 17 Sep 2020 13:13:33 -0700
Subject: [Intel-wired-lan] [PATCH S53 01/15] virtchnl: Use pad byte in
 virtchnl_ether_addr to specify MAC type
Message-ID: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently, there is no way for a VF driver to specify that it wants to
change its device/primary unicast MAC address. This makes it
difficult/impossible for the PF driver to track the VF's device/primary
unicast MAC address, which is used for VM/VF reboot and displaying on
the host. Fix this by using 2 bits of a pad byte in the
virtchnl_ether_addr structure so the VF can specify what type of MAC
it's adding/deleting.

Below are the values that should be used by all VF drivers going
forward.

VIRTCHNL_ETHER_ADDR_LEGACY(0):
	- The type should only ever be 0 for legacy AVF drivers (i.e.
	  drivers that don't support the new type bits). The PF drivers
	  will track VF's device/primary unicast MAC, but this will only
	  be a best effort.

VIRTCHNL_ETHER_ADDR_PRIMARY(1):
	- This type should only be used when the VF is changing their
	  device/primary unicast MAC. It should be used for both delete
	  and add cases related to the device/primary unicast MAC.

VIRTCHNL_ETHER_ADDR_EXTRA(2):
	- This type should be used when the VF is adding and/or deleting
	  MAC addresses that are not the device/primary unicast MAC. For
	  example, extra unicast addresses and multicast addresses
	  assuming the PF supports "extra" addresses at all.

If a PF is parsing the type field of the virtchnl_ether_addr, then it
should use the VIRTCHNL_ETHER_ADDR_TYPE_MASK to mask the first two bits
of the type field since 0, 1, and 2 are the only valid values.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 include/linux/avf/virtchnl.h | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 40bad71865ea..e49a063d0f14 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -403,9 +403,36 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_queue_select);
  * PF removes the filters and returns status.
  */
 
+/* VIRTCHNL_ETHER_ADDR_LEGACY
+ * Prior to adding the @type member to virtchnl_ether_addr, there were 2 pad
+ * bytes. Moving forward all VF drivers should not set type to
+ * VIRTCHNL_ETHER_ADDR_LEGACY. This is only here to not break previous/legacy
+ * behavior. The control plane function (i.e. PF) can use a best effort method
+ * of tracking the primary/device unicast in this case, but there is no
+ * guarantee and functionality depends on the implementation of the PF.
+ */
+
+/* VIRTCHNL_ETHER_ADDR_PRIMARY
+ * All VF drivers should set @type to VIRTCHNL_ETHER_ADDR_PRIMARY for the
+ * primary/device unicast MAC address filter for VIRTCHNL_OP_ADD_ETH_ADDR and
+ * VIRTCHNL_OP_DEL_ETH_ADDR. This allows for the underlying control plane
+ * function (i.e. PF) to accurately track and use this MAC address for
+ * displaying on the host and for VM/function reset.
+ */
+
+/* VIRTCHNL_ETHER_ADDR_EXTRA
+ * All VF drivers should set @type to VIRTCHNL_ETHER_ADDR_EXTRA for any extra
+ * unicast and/or multicast filters that are being added/deleted via
+ * VIRTCHNL_OP_DEL_ETH_ADDR/VIRTCHNL_OP_ADD_ETH_ADDR respectively.
+ */
 struct virtchnl_ether_addr {
 	u8 addr[ETH_ALEN];
-	u8 pad[2];
+	u8 type;
+#define VIRTCHNL_ETHER_ADDR_LEGACY	0
+#define VIRTCHNL_ETHER_ADDR_PRIMARY	1
+#define VIRTCHNL_ETHER_ADDR_EXTRA	2
+#define VIRTCHNL_ETHER_ADDR_TYPE_MASK	3 /* first two bits of type are valid */
+	u8 pad;
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_ether_addr);
-- 
2.20.1

