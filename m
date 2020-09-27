From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:49:08 +0200
Subject: [Intel-wired-lan] [patch 22/35] net: usb: net1080: Remove
 in_interrupt() comment
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194922.057018859@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The comment above nc_vendor_write() suggests that the function could become
async so that is usable in `in_interrupt()' context or that it already is
safe to be called from such a context.

Eitherway: The function did not become async since v2.4.9.2 (2002) and it
must be not be called from `in_interrupt()' context because it sleeps on
mutltiple occations.

Remove the misleading comment.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
Cc: netdev at vger.kernel.org

---
 drivers/net/usb/net1080.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/usb/net1080.c
+++ b/drivers/net/usb/net1080.c
@@ -113,7 +113,6 @@ nc_register_read(struct usbnet *dev, u8
 	return nc_vendor_read(dev, REQUEST_REGISTER, regnum, retval_ptr);
 }
 
-// no retval ... can become async, usable in_interrupt()
 static void
 nc_vendor_write(struct usbnet *dev, u8 req, u8 regnum, u16 value)
 {

