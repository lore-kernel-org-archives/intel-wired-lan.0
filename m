From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 27 Sep 2020 21:48:59 +0200
Subject: [Intel-wired-lan] [patch 13/35] net: mdiobus: Remove
 WARN_ON_ONCE(in_interrupt())
References: <20200927194846.045411263@linutronix.de>
Message-ID: <20200927194921.137019811@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

in_interrupt() is ill defined and does not provide what the name
suggests. The usage especially in driver code is deprecated and a tree wide
effort to clean up and consolidate the (ab)usage of in_interrupt() and
related checks is happening.

In this case the check covers only parts of the contexts in which these
functions cannot be called. It fails to detect preemption or interrupt
disabled invocations.

As the functions which contain these warnings invoke mutex_lock() which
contains a broad variety of checks (always enabled or debug option
dependent) and therefore covers all invalid conditions already, there is no
point in having inconsistent warnings in those drivers. The conditional
return is not really valuable in practice either.

Just remove them.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev at vger.kernel.org

---
 drivers/net/phy/mdio_bus.c |   15 ---------------
 1 file changed, 15 deletions(-)

--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -825,9 +825,6 @@ int mdiobus_read_nested(struct mii_bus *
 {
 	int retval;
 
-	if (WARN_ON_ONCE(in_interrupt()))
-		return -EINVAL;
-
 	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
 	retval = __mdiobus_read(bus, addr, regnum);
 	mutex_unlock(&bus->mdio_lock);
@@ -850,9 +847,6 @@ int mdiobus_read(struct mii_bus *bus, in
 {
 	int retval;
 
-	if (WARN_ON_ONCE(in_interrupt()))
-		return -EINVAL;
-
 	mutex_lock(&bus->mdio_lock);
 	retval = __mdiobus_read(bus, addr, regnum);
 	mutex_unlock(&bus->mdio_lock);
@@ -879,9 +873,6 @@ int mdiobus_write_nested(struct mii_bus
 {
 	int err;
 
-	if (WARN_ON_ONCE(in_interrupt()))
-		return -EINVAL;
-
 	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
 	err = __mdiobus_write(bus, addr, regnum, val);
 	mutex_unlock(&bus->mdio_lock);
@@ -905,9 +896,6 @@ int mdiobus_write(struct mii_bus *bus, i
 {
 	int err;
 
-	if (WARN_ON_ONCE(in_interrupt()))
-		return -EINVAL;
-
 	mutex_lock(&bus->mdio_lock);
 	err = __mdiobus_write(bus, addr, regnum, val);
 	mutex_unlock(&bus->mdio_lock);
@@ -929,9 +917,6 @@ int mdiobus_modify(struct mii_bus *bus,
 {
 	int err;
 
-	if (WARN_ON_ONCE(in_interrupt()))
-		return -EINVAL;
-
 	mutex_lock(&bus->mdio_lock);
 	err = __mdiobus_modify_changed(bus, addr, regnum, mask, set);
 	mutex_unlock(&bus->mdio_lock);

