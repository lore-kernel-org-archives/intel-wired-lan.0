From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:31 +0200
Subject: [Intel-wired-lan] [patch V2 22/36] net: usb: kaweth: Remove last
 user of kaweth_control()
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203501.695494860@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

kaweth_async_set_rx_mode() invokes kaweth_contol() and has two callers:

- kaweth_open() which is invoked from preemptible context
.
- kaweth_start_xmit() which holds a spinlock and has bottom halfs disabled.

If called from kaweth_start_xmit() kaweth_async_set_rx_mode() obviously
cannot block, which means it can't call kaweth_control(). This is detected
with an in_interrupt() check.

Replace the in_interrupt() check in kaweth_async_set_rx_mode() with an
argument which is set true by the caller if the context is safe to sleep,
otherwise false.

Now kaweth_control() is only called from preemptible context which means
there is no need for GFP_ATOMIC allocations anymore. Replace it with
usb_control_msg(). Cleanup the code a bit while at it.

Finally remove kaweth_control() since the last user is gone.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/net/usb/kaweth.c |  168 ++++-------------------------------------------
 1 file changed, 17 insertions(+), 151 deletions(-)

--- a/drivers/net/usb/kaweth.c
+++ b/drivers/net/usb/kaweth.c
@@ -103,10 +103,6 @@ static int kaweth_probe(
 		const struct usb_device_id *id	/* from id_table */
 	);
 static void kaweth_disconnect(struct usb_interface *intf);
-static int kaweth_internal_control_msg(struct usb_device *usb_dev,
-				       unsigned int pipe,
-				       struct usb_ctrlrequest *cmd, void *data,
-				       int len, int timeout);
 static int kaweth_suspend(struct usb_interface *intf, pm_message_t message);
 static int kaweth_resume(struct usb_interface *intf);
 
@@ -236,48 +232,6 @@ struct kaweth_device
 };
 
 /****************************************************************
- *     kaweth_control
- ****************************************************************/
-static int kaweth_control(struct kaweth_device *kaweth,
-			  unsigned int pipe,
-			  __u8 request,
-			  __u8 requesttype,
-			  __u16 value,
-			  __u16 index,
-			  void *data,
-			  __u16 size,
-			  int timeout)
-{
-	struct usb_ctrlrequest *dr;
-	int retval;
-
-	if(in_interrupt()) {
-		netdev_dbg(kaweth->net, "in_interrupt()\n");
-		return -EBUSY;
-	}
-
-	dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_ATOMIC);
-	if (!dr)
-		return -ENOMEM;
-
-	dr->bRequestType = requesttype;
-	dr->bRequest = request;
-	dr->wValue = cpu_to_le16(value);
-	dr->wIndex = cpu_to_le16(index);
-	dr->wLength = cpu_to_le16(size);
-
-	retval = kaweth_internal_control_msg(kaweth->dev,
-					     pipe,
-					     dr,
-					     data,
-					     size,
-					     timeout);
-
-	kfree(dr);
-	return retval;
-}
-
-/****************************************************************
  *     kaweth_read_configuration
  ****************************************************************/
 static int kaweth_read_configuration(struct kaweth_device *kaweth)
@@ -531,7 +485,8 @@ static int kaweth_resubmit_rx_urb(struct
 	return result;
 }
 
-static void kaweth_async_set_rx_mode(struct kaweth_device *kaweth);
+static void kaweth_async_set_rx_mode(struct kaweth_device *kaweth,
+				     bool may_sleep);
 
 /****************************************************************
  *     kaweth_usb_receive
@@ -661,7 +616,7 @@ static int kaweth_open(struct net_device
 
 	netif_start_queue(net);
 
-	kaweth_async_set_rx_mode(kaweth);
+	kaweth_async_set_rx_mode(kaweth, true);
 	return 0;
 
 err_out:
@@ -749,7 +704,7 @@ static netdev_tx_t kaweth_start_xmit(str
 
 	spin_lock_irq(&kaweth->device_lock);
 
-	kaweth_async_set_rx_mode(kaweth);
+	kaweth_async_set_rx_mode(kaweth, false);
 	netif_stop_queue(net);
 	if (IS_BLOCKED(kaweth->status)) {
 		goto skip;
@@ -826,36 +781,31 @@ static void kaweth_set_rx_mode(struct ne
 /****************************************************************
  *     kaweth_async_set_rx_mode
  ****************************************************************/
-static void kaweth_async_set_rx_mode(struct kaweth_device *kaweth)
+static void kaweth_async_set_rx_mode(struct kaweth_device *kaweth,
+				     bool may_sleep)
 {
-	int result;
+	int ret;
 	__u16 packet_filter_bitmap = kaweth->packet_filter_bitmap;
 
 	kaweth->packet_filter_bitmap = 0;
 	if (packet_filter_bitmap == 0)
 		return;
 
-	if (in_interrupt())
+	if (!may_sleep)
 		return;
 
-	result = kaweth_control(kaweth,
-				usb_sndctrlpipe(kaweth->dev, 0),
-				KAWETH_COMMAND_SET_PACKET_FILTER,
-				USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
-				packet_filter_bitmap,
-				0,
-				(void *)&kaweth->scratch,
-				0,
-				KAWETH_CONTROL_TIMEOUT);
-
-	if(result < 0) {
+	ret = usb_control_msg(kaweth->dev, usb_sndctrlpipe(kaweth->dev, 0),
+			      KAWETH_COMMAND_SET_PACKET_FILTER,
+			      USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
+			      packet_filter_bitmap, 0,
+			      &kaweth->scratch, 0,
+			      KAWETH_CONTROL_TIMEOUT);
+	if (ret < 0)
 		dev_err(&kaweth->intf->dev, "Failed to set Rx mode: %d\n",
-			result);
-	}
-	else {
+			ret);
+	else
 		netdev_dbg(kaweth->net, "Set Rx mode to %d\n",
 			   packet_filter_bitmap);
-	}
 }
 
 /****************************************************************
@@ -1163,88 +1113,4 @@ static void kaweth_disconnect(struct usb
 }
 
 
-// FIXME this completion stuff is a modified clone of
-// an OLD version of some stuff in usb.c ...
-struct usb_api_data {
-	wait_queue_head_t wqh;
-	int done;
-};
-
-/*-------------------------------------------------------------------*
- * completion handler for compatibility wrappers (sync control/bulk) *
- *-------------------------------------------------------------------*/
-static void usb_api_blocking_completion(struct urb *urb)
-{
-        struct usb_api_data *awd = (struct usb_api_data *)urb->context;
-
-	awd->done=1;
-	wake_up(&awd->wqh);
-}
-
-/*-------------------------------------------------------------------*
- *                         COMPATIBILITY STUFF                       *
- *-------------------------------------------------------------------*/
-
-// Starts urb and waits for completion or timeout
-static int usb_start_wait_urb(struct urb *urb, int timeout, int* actual_length)
-{
-	struct usb_api_data awd;
-        int status;
-
-        init_waitqueue_head(&awd.wqh);
-        awd.done = 0;
-
-        urb->context = &awd;
-        status = usb_submit_urb(urb, GFP_ATOMIC);
-        if (status) {
-                // something went wrong
-                usb_free_urb(urb);
-                return status;
-        }
-
-	if (!wait_event_timeout(awd.wqh, awd.done, timeout)) {
-                // timeout
-                dev_warn(&urb->dev->dev, "usb_control/bulk_msg: timeout\n");
-                usb_kill_urb(urb);  // remove urb safely
-                status = -ETIMEDOUT;
-        }
-	else {
-                status = urb->status;
-	}
-
-        if (actual_length) {
-                *actual_length = urb->actual_length;
-	}
-
-        usb_free_urb(urb);
-        return status;
-}
-
-/*-------------------------------------------------------------------*/
-// returns status (negative) or length (positive)
-static int kaweth_internal_control_msg(struct usb_device *usb_dev,
-				       unsigned int pipe,
-				       struct usb_ctrlrequest *cmd, void *data,
-				       int len, int timeout)
-{
-        struct urb *urb;
-        int retv;
-        int length = 0; /* shut up GCC */
-
-	urb = usb_alloc_urb(0, GFP_ATOMIC);
-        if (!urb)
-                return -ENOMEM;
-
-        usb_fill_control_urb(urb, usb_dev, pipe, (unsigned char*)cmd, data,
-			 len, usb_api_blocking_completion, NULL);
-
-        retv = usb_start_wait_urb(urb, timeout, &length);
-        if (retv < 0) {
-                return retv;
-	}
-        else {
-                return length;
-	}
-}
-
 module_usb_driver(kaweth_driver);


