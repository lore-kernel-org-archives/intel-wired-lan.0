From: Corinna Vinschen <vinschen@redhat.com>
Date: Fri, 23 Jun 2017 14:26:30 +0200
Subject: [Intel-wired-lan] [PATCH] igb: Remove incorrect ""unexpected SYS
	WRAP" log message
Message-ID: <20170623122630.27074-1-vinschen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

TSAUXC.DisableSystime is never set, so SYSTIM runs into a SYS WRAP
every 1100 secs on 80580/i350/i354 (40 bit SYSTIM) and every 35000
secs on 80576 (45 bit SYSTIM).

This wrap event sets the TSICR.SysWrap bit unconditionally.

However, checking TSIM at interrupt time shows that this event does not
actually cause the interrupt.  Rather, it's just bycatch while the
actual interrupt is caused by, for instance, TSICR.TXTS.

The conclusion is that the SYS WRAP is actually expected, so the
"unexpected SYS WRAP" message is entirely bogus and just helps to
confuse users.  Drop it.

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 3558ad8..394e77e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5746,8 +5746,6 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
 			ptp_clock_event(adapter->ptp_clock, &event);
-		else
-			dev_err(&adapter->pdev->dev, "unexpected SYS WRAP");
 		ack |= TSINTR_SYS_WRAP;
 	}
 
-- 
2.9.4

