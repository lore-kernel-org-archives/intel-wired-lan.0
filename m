From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:49:06 +0200
Subject: [Intel-wired-lan] [patch 20/35] net: usb: kaweth: Replace
 kaweth_control() with usb_control_msg()
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194921.839848434@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

kaweth_control() is almost the same as usb_control_msg() except for the
memory allocation mode (GFP_ATOMIC vs GFP_NOIO) and the in_interrupt()
check.

All the invocations of kaweth_control() are within the probe function in
fully preemtible context so there is no reason to use atomic allocations,
GFP_NOIO which is used by usb_control_msg() is perfectly fine.

Replace kaweth_control() invocations from probe with usb_control_msg().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-usb at vger.kernel.org
Cc: netdev at vger.kernel.org

---
 drivers/net/usb/kaweth.c |   93 +++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 63 deletions(-)

--- a/drivers/net/usb/kaweth.c
+++ b/drivers/net/usb/kaweth.c
@@ -282,19 +282,13 @@ static int kaweth_control(struct kaweth_
  ****************************************************************/
 static int kaweth_read_configuration(struct kaweth_device *kaweth)
 {
-	int retval;
-
-	retval = kaweth_control(kaweth,
-				usb_rcvctrlpipe(kaweth->dev, 0),
+	return usb_control_msg(kaweth->dev, usb_rcvctrlpipe(kaweth->dev, 0),
 				KAWETH_COMMAND_GET_ETHERNET_DESC,
 				USB_TYPE_VENDOR | USB_DIR_IN | USB_RECIP_DEVICE,
-				0,
-				0,
-				(void *)&kaweth->configuration,
+				0, 0,
+				&kaweth->configuration,
 				sizeof(kaweth->configuration),
 				KAWETH_CONTROL_TIMEOUT);
-
-	return retval;
 }
 
 /****************************************************************
@@ -302,21 +296,14 @@ static int kaweth_read_configuration(str
  ****************************************************************/
 static int kaweth_set_urb_size(struct kaweth_device *kaweth, __u16 urb_size)
 {
-	int retval;
-
 	netdev_dbg(kaweth->net, "Setting URB size to %d\n", (unsigned)urb_size);
 
-	retval = kaweth_control(kaweth,
-				usb_sndctrlpipe(kaweth->dev, 0),
-				KAWETH_COMMAND_SET_URB_SIZE,
-				USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
-				urb_size,
-				0,
-				(void *)&kaweth->scratch,
-				0,
-				KAWETH_CONTROL_TIMEOUT);
-
-	return retval;
+	return usb_control_msg(kaweth->dev, usb_sndctrlpipe(kaweth->dev, 0),
+			       KAWETH_COMMAND_SET_URB_SIZE,
+			       USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
+			       urb_size, 0,
+			       &kaweth->scratch, 0,
+			       KAWETH_CONTROL_TIMEOUT);
 }
 
 /****************************************************************
@@ -324,21 +311,14 @@ static int kaweth_set_urb_size(struct ka
  ****************************************************************/
 static int kaweth_set_sofs_wait(struct kaweth_device *kaweth, __u16 sofs_wait)
 {
-	int retval;
-
 	netdev_dbg(kaweth->net, "Set SOFS wait to %d\n", (unsigned)sofs_wait);
 
-	retval = kaweth_control(kaweth,
-				usb_sndctrlpipe(kaweth->dev, 0),
-				KAWETH_COMMAND_SET_SOFS_WAIT,
-				USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
-				sofs_wait,
-				0,
-				(void *)&kaweth->scratch,
-				0,
-				KAWETH_CONTROL_TIMEOUT);
-
-	return retval;
+	return usb_control_msg(kaweth->dev, usb_sndctrlpipe(kaweth->dev, 0),
+			       KAWETH_COMMAND_SET_SOFS_WAIT,
+			       USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
+			       sofs_wait, 0,
+			       &kaweth->scratch, 0,
+			       KAWETH_CONTROL_TIMEOUT);
 }
 
 /****************************************************************
@@ -347,22 +327,15 @@ static int kaweth_set_sofs_wait(struct k
 static int kaweth_set_receive_filter(struct kaweth_device *kaweth,
 				     __u16 receive_filter)
 {
-	int retval;
-
 	netdev_dbg(kaweth->net, "Set receive filter to %d\n",
 		   (unsigned)receive_filter);
 
-	retval = kaweth_control(kaweth,
-				usb_sndctrlpipe(kaweth->dev, 0),
-				KAWETH_COMMAND_SET_PACKET_FILTER,
-				USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
-				receive_filter,
-				0,
-				(void *)&kaweth->scratch,
-				0,
-				KAWETH_CONTROL_TIMEOUT);
-
-	return retval;
+	return usb_control_msg(kaweth->dev, usb_sndctrlpipe(kaweth->dev, 0),
+			       KAWETH_COMMAND_SET_PACKET_FILTER,
+			       USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
+			       receive_filter, 0,
+			       &kaweth->scratch, 0,
+			       KAWETH_CONTROL_TIMEOUT);
 }
 
 /****************************************************************
@@ -407,14 +380,11 @@ static int kaweth_download_firmware(stru
 		   kaweth->firmware_buf, kaweth);
 	netdev_dbg(kaweth->net, "Firmware length: %d\n", data_len);
 
-	return kaweth_control(kaweth,
-		              usb_sndctrlpipe(kaweth->dev, 0),
+	return usb_control_msg(kaweth->dev, usb_sndctrlpipe(kaweth->dev, 0),
 			      KAWETH_COMMAND_SCAN,
 			      USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
-			      0,
-			      0,
-			      (void *)kaweth->firmware_buf,
-			      data_len,
+			      0, 0,
+			      kaweth->firmware_buf, data_len,
 			      KAWETH_CONTROL_TIMEOUT);
 }
 
@@ -433,15 +403,12 @@ static int kaweth_trigger_firmware(struc
 	kaweth->firmware_buf[6] = 0x00;
 	kaweth->firmware_buf[7] = 0x00;
 
-	return kaweth_control(kaweth,
-			      usb_sndctrlpipe(kaweth->dev, 0),
-			      KAWETH_COMMAND_SCAN,
-			      USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
-			      0,
-			      0,
-			      (void *)kaweth->firmware_buf,
-			      8,
-			      KAWETH_CONTROL_TIMEOUT);
+	return usb_control_msg(kaweth->dev, usb_sndctrlpipe(kaweth->dev, 0),
+			       KAWETH_COMMAND_SCAN,
+			       USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
+			       0, 0,
+			       (void *)kaweth->firmware_buf, 8,
+			       KAWETH_CONTROL_TIMEOUT);
 }
 
 /****************************************************************

