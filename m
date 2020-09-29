From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:14 +0200
Subject: [Intel-wired-lan] [patch V2 05/36] net: atheros: Remove
 WARN_ON(in_interrupt())
References: <20200929202509.673358734@linutronix.de>
Message-ID: <20200929203459.967800092@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Thomas Gleixner <tglx@linutronix.de>

in_interrupt() is ill defined and does not provide what the name
suggests. The usage especially in driver code is deprecated and a tree wide
effort to clean up and consolidate the (ab)usage of in_interrupt() and
related checks is happening.

In this case the check covers only parts of the contexts in which these
functions cannot be called. It fails to detect preemption or interrupt
disabled invocations.

As the functions which are invoked from at*_reinit_locked() contain a broad
variety of checks (always enabled or debug option dependent) which cover
all invalid conditions already, there is no point in having inconsistent
warnings in those drivers.

Just remove them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c |    1 -
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c |    2 --
 drivers/net/ethernet/atheros/atlx/atl2.c        |    1 -
 3 files changed, 4 deletions(-)

--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -220,7 +220,6 @@ static void atl1c_phy_config(struct time
 
 void atl1c_reinit_locked(struct atl1c_adapter *adapter)
 {
-	WARN_ON(in_interrupt());
 	atl1c_down(adapter);
 	atl1c_up(adapter);
 	clear_bit(__AT_RESETTING, &adapter->flags);
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -127,8 +127,6 @@ static void atl1e_phy_config(struct time
 
 void atl1e_reinit_locked(struct atl1e_adapter *adapter)
 {
-
-	WARN_ON(in_interrupt());
 	while (test_and_set_bit(__AT_RESETTING, &adapter->flags))
 		msleep(1);
 	atl1e_down(adapter);
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1086,7 +1086,6 @@ static int atl2_up(struct atl2_adapter *
 
 static void atl2_reinit_locked(struct atl2_adapter *adapter)
 {
-	WARN_ON(in_interrupt());
 	while (test_and_set_bit(__ATL2_RESETTING, &adapter->flags))
 		msleep(1);
 	atl2_down(adapter);

