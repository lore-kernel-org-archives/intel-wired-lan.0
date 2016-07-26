From: nick <xerofoify@gmail.com>
Date: Tue, 26 Jul 2016 08:48:50 -0400
Subject: [Intel-wired-lan] [e1000_netpoll] BUG: sleeping function called
 from invalid context at kernel/irq/manage.c:110
In-Reply-To: <alpine.DEB.2.11.1607261149570.19896@nanos>
References: <20160726035003.GA15095@wfg-t540p.sh.intel.com>
 <1469524492.17736.3.camel@edumazet-glaptop3.roam.corp.google.com>
 <20160726093224.GA10339@wfg-t540p.sh.intel.com>
 <alpine.DEB.2.11.1607261149570.19896@nanos>
Message-ID: <8578bb16-cd04-e8a5-c7f4-be061ede95b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 2016-07-26 05:50 AM, Thomas Gleixner wrote:
> On Tue, 26 Jul 2016, Fengguang Wu wrote:
>> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
>> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
>> @@ -3797,7 +3797,7 @@ static irqreturn_t e1000_intr(int irq, void *data)
>> 		hw->get_link_status = 1;
>> 		/* guard against interrupt when we're going down */
>> 		if (!test_bit(__E1000_DOWN, &adapter->flags))
>> -			schedule_delayed_work(&adapter->watchdog_task, 1);
>> +			mod_timer(&adapter->watchdog_timer, jiffies + 1);
> 
> ROTFL ....
> 
Thomas,
Yes it's a pretty funny typo, below is a patch that fixes the build error
 as reported by kbuild robot:
From 013dbc315c452d37d565e9c27b90b02239b5a1bb Mon Sep 17 00:00:00 2001
From: Nicholas Krause <xerofoify@gmail.com>
Date: Tue, 26 Jul 2016 08:43:56 -0400
Subject: [PATCH] use atomic mod timer rather then schedule work

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index f42129d..e1830af 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3797,7 +3797,7 @@ static irqreturn_t e1000_intr(int irq, void *data)
 		hw->get_link_status = 1;
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->flags))
-			schedule_delayed_work(&adapter->watchdog_task, 1);
+			mod_work(&adapter->watchdog_task, jiffies + 1);
 	}
 
 	/* disable interrupts, without the synchronize_irq bit */
-- 
2.7.4
Cheers,
Nick
