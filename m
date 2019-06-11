From: Max Lapshin <max@flussonic.com>
Date: Wed, 12 Jun 2019 00:01:49 +0300
Subject: [Intel-wired-lan] i350 software defined pins sysfs access
Message-ID: <C0C7FF38-286F-46CA-909D-1A02EFDBBF0C@flussonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi.

Intel i350 nic has software defined pins.  I have a custom hardware where these pins are connected to
some peripheral and I need to enable/disable them.

Here is patch that enables access to them. I can turn off peripheral device by:

echo 0 > /sys/class/net/eth1/device/pin2

and turn on by:

echo 1 > /sys/class/net/eth1/device/pin2

Please, give any corrections and advices if this patch requires any changes.
It is made again  git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git <git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git>  dev-queue



Subject: [PATCH] i350: Add support for Intel i350 software defined pins

NIC i350 with igb driver has software defined pins.
Allow to access them via sysfs files.
---
 drivers/net/ethernet/intel/igb/igb.h      |  28 +++++
 drivers/net/ethernet/intel/igb/igb_main.c | 127 +++++++++++++++++++++-
 2 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index ca54e268d157..2453674464fa 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -79,6 +79,20 @@ struct igb_adapter;
 #define IGB_I210_RX_LATENCY_100		2213
 #define IGB_I210_RX_LATENCY_1000	448
 
+
+/* Software defined pins 0-1 */
+#define IGB_CTRL_SDP0_DATA 0x00040000 /* Value of SW Defineable Pin 0 */
+#define IGB_CTRL_SDP1_DATA 0x00080000 /* Value of SW Defineable Pin 1 */
+#define IGB_CTRL_SDP0_DIR  0x00400000 /* SDP0 Data direction */
+#define IGB_CTRL_SDP1_DIR  0x00800000 /* SDP1 Data direction */
+
+/* Software defined pins 2-3 */
+#define IGB_CTRL_EXT_SDP2_DATA E1000_CTRL_EXT_SDP2_DATA /* Value of SW Defineable Pin 2 */
+#define IGB_CTRL_EXT_SDP3_DATA E1000_CTRL_EXT_SDP3_DATA /* Value of SW Defineable Pin 3 */
+#define IGB_CTRL_EXT_SDP2_DIR  E1000_CTRL_EXT_SDP2_DIR  /* SDP2 Data direction */
+#define IGB_CTRL_EXT_SDP3_DIR  E1000_CTRL_EXT_SDP3_DIR  /* SDP3 Data direction */
+
+
 struct vf_data_storage {
 	unsigned char vf_mac_addresses[ETH_ALEN];
 	u16 vf_mc_hashes[IGB_MAX_VF_MC_ENTRIES];
@@ -380,6 +394,16 @@ static inline int igb_desc_unused(struct igb_ring *ring)
 	return ring->count + ring->next_to_clean - ring->next_to_use - 1;
 }
 
+#define IGB_SDP_COUNT 4
+#define IGB_MAX_SDPS 4
+// Software defined pins
+struct sdp_attr {
+	struct device_attribute dev_attr;
+	u32 pin;
+	struct igb_adapter *adapter;
+	char name[12];
+};
+
 #ifdef CONFIG_IGB_HWMON
 
 #define IGB_HWMON_TYPE_LOC	0
@@ -568,6 +592,10 @@ struct igb_adapter {
 	} perout[IGB_N_PEROUT];
 
 	char fw_version[32];
+
+	u32 n_sdp;
+	struct sdp_attr sdp_attrs[IGB_MAX_SDPS];
+
 #ifdef CONFIG_IGB_HWMON
 	struct hwmon_buff *igb_hwmon_buff;
 	bool ets;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index fc925adbd9fa..447417fb4d3f 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -40,7 +40,7 @@
 
 #define MAJ 5
 #define MIN 6
-#define BUILD 0
+#define BUILD 1
 #define DRV_VERSION __stringify(MAJ) "." __stringify(MIN) "." \
 __stringify(BUILD) "-k"
 
@@ -2484,6 +2484,129 @@ static int igb_set_features(struct net_device *netdev,
 	return 1;
 }
 
+static u32 igb_sdp_direction_bit(u32 pin)
+{
+        return pin == 0 ? IGB_CTRL_SDP0_DIR :
+          pin == 1 ? IGB_CTRL_SDP1_DIR :
+          pin == 2 ? IGB_CTRL_EXT_SDP2_DIR :
+          pin == 3 ? IGB_CTRL_EXT_SDP3_DIR : 0xFFFFFFFF;
+}
+
+static u32 igb_sdp_value_bit(u32 pin)
+{
+        return pin == IGB_CTRL_SDP0_DIR ? 18 :
+          pin == 1 ? IGB_CTRL_SDP1_DIR :
+          pin == 2 ? IGB_CTRL_EXT_SDP2_DIR :
+          pin == 3 ? IGB_CTRL_EXT_SDP3_DIR : 0xFFFFFFFF;
+}
+
+static u32 igb_sdp_register(u32 pin)
+{
+        return pin <= 1 ? E1000_CTRL : E1000_CTRL_EXT;
+}
+
+static ssize_t igb_sdp_get(struct device *dev,
+                                     struct device_attribute *attr,
+                                     char *buf)
+{
+        volatile u32 ctrl_value;
+        struct sdp_attr *igb_attr = container_of(attr, struct sdp_attr,
+                                                     dev_attr);
+        struct e1000_hw *hw = &igb_attr->adapter->hw;
+        u32 reg_number;
+
+        reg_number = igb_sdp_register(igb_attr->pin);
+        ctrl_value = rd32(reg_number);
+        wr32(reg_number, ctrl_value & ~(1 << igb_sdp_direction_bit(igb_attr->pin)));
+        ctrl_value = rd32(reg_number);
+
+        return sprintf(buf, "%d\n", (ctrl_value >> igb_sdp_value_bit(igb_attr->pin)) & 1);
+}
+
+static ssize_t igb_sdp_set(struct device *dev,
+                                     struct device_attribute *attr,
+                                     const char *buf, size_t count)
+{
+        struct sdp_attr *igb_attr = container_of(attr, struct sdp_attr,
+                                                     dev_attr);
+        struct e1000_hw *hw = &igb_attr->adapter->hw;
+        int on = -1;
+        volatile u32 ctrl_value;
+        u32 reg_number;
+        u32 value_bit;
+
+
+        sscanf(buf, "%d", &on);
+        on = on == 0 ? 0 : 1;
+
+        //Software defined pins live on different registers:
+        //0 and 1 live on CTRL, 2 and 3 live on CTRL_EXT
+        reg_number = igb_sdp_register(igb_attr->pin);
+
+        ctrl_value = rd32(reg_number);
+        ctrl_value |= (1 << igb_sdp_direction_bit(igb_attr->pin));
+
+        value_bit = igb_sdp_value_bit(igb_attr->pin);
+        if(on) {
+                ctrl_value |= 1 << value_bit;
+        } else {
+                ctrl_value &= ~(1 << value_bit);
+        }
+
+        wr32(reg_number, ctrl_value);
+        return count;
+}
+
+
+static int igb_add_sdp_attr(struct igb_adapter *adapter, u32 pin)
+{
+
+        struct sdp_attr *igb_attr;
+
+        u32 n_sdp;
+        n_sdp = adapter->n_sdp;
+        if(n_sdp > IGB_MAX_SDPS) {
+                return ENOMEM;
+        }
+
+        igb_attr = &adapter->sdp_attrs[n_sdp];
+        igb_attr->adapter = adapter;
+        igb_attr->pin = pin;
+        snprintf(igb_attr->name, sizeof(igb_attr->name), "pin%d", pin);
+
+        igb_attr->dev_attr.show = igb_sdp_get;
+        igb_attr->dev_attr.store = igb_sdp_set;
+        igb_attr->dev_attr.attr.mode = 0660;
+        igb_attr->dev_attr.attr.name = igb_attr->name;
+        sysfs_attr_init(&igb_attr->dev_attr.attr);
+
+        adapter->n_sdp++;
+        return device_create_file(&adapter->pdev->dev,
+                                &igb_attr->dev_attr);
+}
+
+
+static void igb_sdp_del(struct igb_adapter *adapter)
+{
+        u32 i;
+        for(i = 0; i < adapter->n_sdp; i++) {
+                device_remove_file(&adapter->pdev->dev, &adapter->sdp_attrs[i].dev_attr);
+        }
+}
+
+static int igb_sdp_init(struct igb_adapter *adapter)
+{
+	u32 i;
+	int rc = 0;
+        for(i = 0; i < IGB_SDP_COUNT; i++) {
+                rc = igb_add_sdp_attr(adapter, i);
+                if (rc)
+			return rc;
+        }
+	return 0;
+}
+
+
 static int igb_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 			   struct net_device *dev,
 			   const unsigned char *addr, u16 vid,
@@ -3383,6 +3506,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		adapter->ets = false;
 	}
 #endif
+	igb_sdp_init(adapter);
 	/* Check if Media Autosense is enabled */
 	adapter->ei = *ei;
 	if (hw->dev_spec._82575.mas_capable)
@@ -3642,6 +3766,7 @@ static void igb_remove(struct pci_dev *pdev)
 #ifdef CONFIG_IGB_HWMON
 	igb_sysfs_exit(adapter);
 #endif
+	igb_sdp_del(adapter);
 	igb_remove_i2c(adapter);
 	igb_ptp_stop(adapter);
 	/* The watchdog timer may be rescheduled, so explicitly
-- 
2.17.1

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190612/872c2c28/attachment-0001.html>
