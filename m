From: Karol Kolacinski <karol.kolacinski@intel.com>
Date: Tue, 26 Apr 2022 14:35:56 +0200
Subject: [Intel-wired-lan] [PATCH v3 intel-next 3/3] ice: add write
 functionality for GNSS TTY
In-Reply-To: <20220426123556.3041070-1-karol.kolacinski@intel.com>
References: <20220426123556.3041070-1-karol.kolacinski@intel.com>
Message-ID: <20220426123556.3041070-3-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the possibility to write raw bytes to the GNSS module through the
first TTY device. This allows user to configure the module using the
publicli available u-blox UBX protocol (version 29) commands.

Create a second read-only TTY device.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V2 -> V3: Added write_work and queue in gnss_serial struct
V1 -> V2: Reworked write algorithm and fixed minor issues

 drivers/net/ethernet/intel/ice/ice.h      |   4 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c | 243 +++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_gnss.h |  27 ++-
 3 files changed, 242 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 17fb1ddea7b0..41bd0c7c7da5 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -558,8 +558,8 @@ struct ice_pf {
 	u32 msg_enable;
 	struct ice_ptp ptp;
 	struct tty_driver *ice_gnss_tty_driver;
-	struct tty_port gnss_tty_port;
-	struct gnss_serial *gnss_serial;
+	struct tty_port *gnss_tty_port[ICE_GNSS_TTY_MINOR_DEVICES];
+	struct gnss_serial *gnss_serial[ICE_GNSS_TTY_MINOR_DEVICES];
 	u16 num_rdma_msix;		/* Total MSIX vectors for RDMA driver */
 	u16 rdma_base_vector;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index ff52082a3c26..d7a4ceb0ebcf 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -1,10 +1,102 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2018-2021, Intel Corporation. */
+/* Copyright (C) 2021-2022, Intel Corporation. */
 
 #include "ice.h"
 #include "ice_lib.h"
 #include <linux/tty_driver.h>
 
+/**
+ * ice_gnss_do_write - Write data to internal GNSS
+ * @pf: board private structure
+ * @buf: command buffer
+ * @size: command buffer size
+ *
+ * Write UBX command data to the GNSS receiver
+ */
+static unsigned int
+ice_gnss_do_write(struct ice_pf *pf, unsigned char *buf, unsigned int size)
+{
+	struct ice_aqc_link_topo_addr link_topo;
+	struct ice_hw *hw = &pf->hw;
+	unsigned int offset = 0;
+	int err = 0;
+
+	memset(&link_topo, 0, sizeof(struct ice_aqc_link_topo_addr));
+	link_topo.topo_params.index = ICE_E810T_GNSS_I2C_BUS;
+	link_topo.topo_params.node_type_ctx |=
+		ICE_AQC_LINK_TOPO_NODE_CTX_OVERRIDE <<
+		ICE_AQC_LINK_TOPO_NODE_CTX_S;
+
+	/* It's not possible to write a single byte to u-blox.
+	 * Write all bytes in a loop until there are 6 or less bytes left. If
+	 * there are exactly 6 bytes left, the last write would be only a byte.
+	 * In this case, do 4+2 bytes writes instead of 5+1. Otherwise, do the
+	 * last 2 to 5 bytes write.
+	 */
+	while (size - offset > ICE_GNSS_UBX_WRITE_BYTES + 1) {
+		err = ice_aq_write_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
+				       cpu_to_le16(buf[offset]),
+				       ICE_MAX_I2C_WRITE_BYTES,
+				       &buf[offset + 1], NULL);
+		if (err)
+			goto exit;
+
+		offset += ICE_GNSS_UBX_WRITE_BYTES;
+	}
+
+	/* Single byte would be written. Write 4 bytes instead of 5. */
+	if (size - offset == ICE_GNSS_UBX_WRITE_BYTES + 1) {
+		err = ice_aq_write_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
+				       cpu_to_le16(buf[offset]),
+				       ICE_MAX_I2C_WRITE_BYTES - 1,
+				       &buf[offset + 1], NULL);
+		if (err)
+			goto exit;
+
+		offset += ICE_GNSS_UBX_WRITE_BYTES - 1;
+	}
+
+	/* Do the last write, 2 to 5 bytes. */
+	err = ice_aq_write_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
+			       cpu_to_le16(buf[offset]), size - offset - 1,
+			       &buf[offset + 1], NULL);
+	if (!err)
+		offset = size;
+
+exit:
+	if (err)
+		dev_err(ice_pf_to_dev(pf), "GNSS failed to write, offset=%u, size=%u, err=%d\n",
+			offset, size, err);
+
+	return offset;
+}
+
+/**
+ * ice_gnss_write_pending - Write all pending data to internal GNSS
+ * @work: GNSS write work structure
+ */
+static void ice_gnss_write_pending(struct kthread_work *work)
+{
+	struct gnss_serial *gnss = container_of(work, struct gnss_serial,
+						write_work);
+	struct ice_pf *pf = gnss->back;
+
+	if (!list_empty(&gnss->queue)) {
+		struct gnss_write_buf *write_buf = NULL;
+		unsigned int bytes;
+
+		write_buf = list_first_entry(&gnss->queue,
+					     struct gnss_write_buf, queue);
+
+		bytes = ice_gnss_do_write(pf, write_buf->buf, write_buf->size);
+		dev_dbg(ice_pf_to_dev(pf), "%u bytes written to GNSS\n", bytes);
+
+		list_del(&write_buf->queue);
+		kfree(write_buf->buf);
+		kfree(write_buf);
+	}
+}
+
 /**
  * ice_gnss_read - Read data from internal GNSS module
  * @work: GNSS read work structure
@@ -74,7 +166,7 @@ static void ice_gnss_read(struct kthread_work *work)
 
 	/* Read received data */
 	for (i = 0; i < data_len; i += bytes_read) {
-		u32 bytes_left = data_len - i;
+		unsigned int bytes_left = data_len - i;
 
 		bytes_read = min_t(typeof(bytes_left), bytes_left,
 				   ICE_MAX_I2C_DATA_SIZE);
@@ -104,8 +196,9 @@ static void ice_gnss_read(struct kthread_work *work)
 /**
  * ice_gnss_struct_init - Initialize GNSS structure for the TTY
  * @pf: Board private structure
+ * @index: TTY device index
  */
-static struct gnss_serial *ice_gnss_struct_init(struct ice_pf *pf)
+static struct gnss_serial *ice_gnss_struct_init(struct ice_pf *pf, int index)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct kthread_worker *kworker;
@@ -118,9 +211,11 @@ static struct gnss_serial *ice_gnss_struct_init(struct ice_pf *pf)
 	mutex_init(&gnss->gnss_mutex);
 	gnss->open_count = 0;
 	gnss->back = pf;
-	pf->gnss_serial = gnss;
+	pf->gnss_serial[index] = gnss;
 
 	kthread_init_delayed_work(&gnss->read_work, ice_gnss_read);
+	INIT_LIST_HEAD(&gnss->queue);
+	kthread_init_work(&gnss->write_work, ice_gnss_write_pending);
 	/* Allocate a kworker for handling work required for the GNSS TTY
 	 * writes.
 	 */
@@ -156,10 +251,10 @@ static int ice_gnss_tty_open(struct tty_struct *tty, struct file *filp)
 	tty->driver_data = NULL;
 
 	/* Get the serial object associated with this tty pointer */
-	gnss = pf->gnss_serial;
+	gnss = pf->gnss_serial[tty->index];
 	if (!gnss) {
 		/* Initialize GNSS struct on the first device open */
-		gnss = ice_gnss_struct_init(pf);
+		gnss = ice_gnss_struct_init(pf, tty->index);
 		if (!gnss)
 			return -ENOMEM;
 	}
@@ -212,25 +307,100 @@ static void ice_gnss_tty_close(struct tty_struct *tty, struct file *filp)
 }
 
 /**
- * ice_gnss_tty_write - Dummy TTY write function to avoid kernel panic
+ * ice_gnss_tty_write - Write GNSS data
  * @tty: pointer to the tty_struct
  * @buf: pointer to the user data
- * @cnt: the number of characters that was able to be sent to the hardware (or
- *       queued to be sent at a later time)
+ * @count: the number of characters queued to be sent to the HW
+ *
+ * The write function call is called by the user when there is data to be sent
+ * to the hardware. First the tty core receives the call, and then it passes the
+ * data on to the tty driver?s write function. The tty core also tells the tty
+ * driver the size of the data being sent.
+ * If any errors happen during the write call, a negative error value should be
+ * returned instead of the number of characters queued to be written.
  */
 static int
-ice_gnss_tty_write(struct tty_struct *tty, const unsigned char *buf, int cnt)
+ice_gnss_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
-	return 0;
+	struct gnss_write_buf *write_buf;
+	struct gnss_serial *gnss;
+	unsigned char *cmd_buf;
+	struct ice_pf *pf;
+	int err = count;
+
+	/* We cannot write a single byte using our I2C implementation. */
+	if (count <= 1 || count > ICE_GNSS_TTY_WRITE_BUF)
+		return -EINVAL;
+
+	gnss = tty->driver_data;
+	if (!gnss)
+		return -EFAULT;
+
+	pf = (struct ice_pf *)tty->driver->driver_state;
+	if (!pf)
+		return -EFAULT;
+
+	/* Only allow to write on TTY 0 */
+	if (gnss != pf->gnss_serial[0])
+		return -EIO;
+
+	mutex_lock(&gnss->gnss_mutex);
+
+	if (!gnss->open_count) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	cmd_buf = kzalloc(sizeof(*buf) * count, GFP_KERNEL);
+	if (!cmd_buf) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	memcpy(cmd_buf, buf, count);
+
+	/* Send the data out to a hardware port */
+	write_buf = kzalloc(sizeof(*write_buf), GFP_KERNEL);
+	if (!write_buf) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	write_buf->buf = cmd_buf;
+	write_buf->size = count;
+	INIT_LIST_HEAD(&write_buf->queue);
+	list_add_tail(&write_buf->queue, &gnss->queue);
+	kthread_queue_work(gnss->kworker, &gnss->write_work);
+exit:
+	mutex_unlock(&gnss->gnss_mutex);
+	return err;
 }
 
 /**
- * ice_gnss_tty_write_room - Dummy TTY write_room function to avoid kernel panic
+ * ice_gnss_tty_write_room - Returns the numbers of characters to be written.
  * @tty: pointer to the tty_struct
+ *
+ * This routine returns the numbers of characters the tty driver will accept
+ * for queuing to be written or 0 if either the TTY is not open or user
+ * tries to write to the TTY other than the first.
  */
 static unsigned int ice_gnss_tty_write_room(struct tty_struct *tty)
 {
-	return 0;
+	struct gnss_serial *gnss = tty->driver_data;
+
+	/* Only allow to write on TTY 0*/
+	if (!gnss || gnss != gnss->back->gnss_serial[0])
+		return 0;
+
+	mutex_lock(&gnss->gnss_mutex);
+
+	if (!gnss->open_count) {
+		mutex_unlock(&gnss->gnss_mutex);
+		return 0;
+	}
+
+	mutex_unlock(&gnss->gnss_mutex);
+	return ICE_GNSS_TTY_WRITE_BUF;
 }
 
 static const struct tty_operations tty_gps_ops = {
@@ -250,11 +420,13 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
 	const int ICE_TTYDRV_NAME_MAX = 14;
 	struct tty_driver *tty_driver;
 	char *ttydrv_name;
+	unsigned int i;
 	int err;
 
-	tty_driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW);
+	tty_driver = tty_alloc_driver(ICE_GNSS_TTY_MINOR_DEVICES,
+				      TTY_DRIVER_REAL_RAW);
 	if (IS_ERR(tty_driver)) {
-		dev_err(ice_pf_to_dev(pf), "Failed to allocate memory for GNSS TTY\n");
+		dev_err(dev, "Failed to allocate memory for GNSS TTY\n");
 		return NULL;
 	}
 
@@ -284,23 +456,32 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
 	tty_driver->driver_state = pf;
 	tty_set_operations(tty_driver, &tty_gps_ops);
 
-	pf->gnss_serial = NULL;
+	for (i = 0; i < ICE_GNSS_TTY_MINOR_DEVICES; i++) {
+		pf->gnss_tty_port[i] = kzalloc(sizeof(*pf->gnss_tty_port[i]),
+					       GFP_KERNEL);
+		pf->gnss_serial[i] = NULL;
 
-	tty_port_init(&pf->gnss_tty_port);
-	tty_port_link_device(&pf->gnss_tty_port, tty_driver, 0);
+		tty_port_init(pf->gnss_tty_port[i]);
+		tty_port_link_device(pf->gnss_tty_port[i], tty_driver, i);
+	}
 
 	err = tty_register_driver(tty_driver);
 	if (err) {
-		dev_err(ice_pf_to_dev(pf), "Failed to register TTY driver err=%d\n",
-			err);
+		dev_err(dev, "Failed to register TTY driver err=%d\n", err);
 
-		tty_port_destroy(&pf->gnss_tty_port);
+		for (i = 0; i < ICE_GNSS_TTY_MINOR_DEVICES; i++) {
+			tty_port_destroy(pf->gnss_tty_port[i]);
+			kfree(pf->gnss_tty_port[i]);
+		}
 		kfree(ttydrv_name);
 		tty_driver_kref_put(pf->ice_gnss_tty_driver);
 
 		return NULL;
 	}
 
+	for (i = 0; i < ICE_GNSS_TTY_MINOR_DEVICES; i++)
+		dev_info(dev, "%s%d registered\n", ttydrv_name, i);
+
 	return tty_driver;
 }
 
@@ -328,17 +509,25 @@ void ice_gnss_init(struct ice_pf *pf)
  */
 void ice_gnss_exit(struct ice_pf *pf)
 {
+	unsigned int i;
+
 	if (!test_bit(ICE_FLAG_GNSS, pf->flags) || !pf->ice_gnss_tty_driver)
 		return;
 
-	tty_port_destroy(&pf->gnss_tty_port);
+	for (i = 0; i < ICE_GNSS_TTY_MINOR_DEVICES; i++) {
+		if (pf->gnss_tty_port[i]) {
+			tty_port_destroy(pf->gnss_tty_port[i]);
+			kfree(pf->gnss_tty_port[i]);
+		}
 
-	if (pf->gnss_serial) {
-		struct gnss_serial *gnss = pf->gnss_serial;
+		if (pf->gnss_serial[i]) {
+			struct gnss_serial *gnss = pf->gnss_serial[i];
 
-		kthread_cancel_delayed_work_sync(&gnss->read_work);
-		kfree(gnss);
-		pf->gnss_serial = NULL;
+			kthread_cancel_work_sync(&gnss->write_work);
+			kthread_cancel_delayed_work_sync(&gnss->read_work);
+			kfree(gnss);
+			pf->gnss_serial[i] = NULL;
+		}
 	}
 
 	tty_unregister_driver(pf->ice_gnss_tty_driver);
diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.h b/drivers/net/ethernet/intel/ice/ice_gnss.h
index 9211adb2372c..3c042fa741f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.h
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2018-2021, Intel Corporation. */
+/* Copyright (C) 2021-2022, Intel Corporation. */
 
 #ifndef _ICE_GNSS_H_
 #define _ICE_GNSS_H_
@@ -8,14 +8,31 @@
 #include <linux/tty_flip.h>
 
 #define ICE_E810T_GNSS_I2C_BUS		0x2
+#define ICE_GNSS_TIMER_DELAY_TIME	(HZ / 10) /* 0.1 second per message */
+#define ICE_GNSS_TTY_MINOR_DEVICES	2
+#define ICE_GNSS_TTY_WRITE_BUF		250
+#define ICE_MAX_I2C_DATA_SIZE		FIELD_MAX(ICE_AQC_I2C_DATA_SIZE_M)
+#define ICE_MAX_I2C_WRITE_BYTES		4
+
+/* u-blox specific deifinitions */
 #define ICE_GNSS_UBX_I2C_BUS_ADDR	0x42
 /* Data length register is big endian */
 #define ICE_GNSS_UBX_DATA_LEN_H		0xFD
 #define ICE_GNSS_UBX_DATA_LEN_WIDTH	2
 #define ICE_GNSS_UBX_EMPTY_DATA		0xFF
-#define ICE_GNSS_TIMER_DELAY_TIME	(HZ / 10) /* 0.1 second per message */
-#define ICE_MAX_I2C_DATA_SIZE		FIELD_MAX(ICE_AQC_I2C_DATA_SIZE_M)
+/* For u-blox writes are performed without address so the first byte to write is
+ * passed as I2C addr parameter.
+ */
+#define ICE_GNSS_UBX_WRITE_BYTES	(ICE_MAX_I2C_WRITE_BYTES + 1)
 #define ICE_MAX_UBX_READ_TRIES		255
+#define ICE_MAX_UBX_ACK_READ_TRIES	4095
+
+struct gnss_write_buf {
+	struct list_head queue;
+	unsigned int size;
+	unsigned char *buf;
+};
+
 
 /**
  * struct gnss_serial - data used to initialize GNSS TTY port
@@ -25,6 +42,8 @@
  * @gnss_mutex: gnss_mutex used to protect GNSS serial operations
  * @kworker: kwork thread for handling periodic work
  * @read_work: read_work function for handling GNSS reads
+ * @write_work: write_work function for handling GNSS writes
+ * @queue: write buffers queue
  */
 struct gnss_serial {
 	struct ice_pf *back;
@@ -33,6 +52,8 @@ struct gnss_serial {
 	struct mutex gnss_mutex; /* protects GNSS serial structure */
 	struct kthread_worker *kworker;
 	struct kthread_delayed_work read_work;
+	struct kthread_work write_work;
+	struct list_head queue;
 };
 
 #if IS_ENABLED(CONFIG_TTY)
-- 
2.34.1

