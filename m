Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A70EC001B0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Jul 2023 15:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C36281FA2;
	Mon, 24 Jul 2023 15:24:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C36281FA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690212280;
	bh=QMbcu9yBZKYxBhvOQf9UpqVP87P7aTX2um5SLe3Gh4A=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=AV14EH/rryKOW0bFk5PY9XH2v7r2J1x32UouiDbfO9RCU+WnPZIRmcn4oLkmryl8B
	 dKkdUqpDnZD2hBKsnYs4te1UzMbXBJMtPGG/+bfnNODfV1vSKOhBpoCJ0CLRIksbHL
	 94iMwAo2vbAKIvegF3r/HPmUAUdHpitmDlemaugHqgNV8dMEt9kTNl0AYM4OMDa7iP
	 b9lkQj5bv8icjEpJfBcq+JpuvovSW8wQd+sEsjqb0XQoVq3xDj/QejljPuhwC9h0Jv
	 l8CrJZDW3SYAVvPgTf3O4OejFSgqIUpV2RtJNUHqH2+eDiMSZhs7DT0KMWVz2zEEFT
	 SX4gii7Uv889g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U6PfkaV6j1m9; Mon, 24 Jul 2023 15:24:39 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A50D81FAA;
	Mon, 24 Jul 2023 15:24:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A50D81FAA
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id C6AAF1BF3B9
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Jul 2023 11:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4D2840A9B
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Jul 2023 11:38:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4D2840A9B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dr0xjhUW96Fe for <intel-wired-lan@lists.osuosl.org>;
 Sun, 23 Jul 2023 11:38:01 +0000 (UTC)
Received: from bacon.elettra.eu (bacon.elettra.eu [140.105.206.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DBA2400B9
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Jul 2023 11:38:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DBA2400B9
X-Envelope-From: <alessio.bogani@elettra.eu>
Received: from zmp.elettra.eu (zmp.elettra.trieste.it [140.105.206.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by bacon.elettra.eu (Postfix) with ESMTPS id DEF1740435
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Jul 2023 13:37:54 +0200 (CEST)
Received: from zmp.elettra.eu (localhost [127.0.0.1])
 by zmp.elettra.eu (Postfix) with ESMTPS id D4BD7146CE2F;
 Sun, 23 Jul 2023 13:37:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zmp.elettra.eu (Postfix) with ESMTP id BE618146CE31;
 Sun, 23 Jul 2023 13:37:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zmp.elettra.eu
Received: from zmp.elettra.eu ([127.0.0.1])
 by localhost (zmp.elettra.eu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id IFDjTP4L12DS; Sun, 23 Jul 2023 13:37:54 +0200 (CEST)
Received: from pc-bogani.fcs.elettra.trieste.it (pc-bogani.elettra.trieste.it
 [192.168.205.85])
 by zmp.elettra.eu (Postfix) with ESMTP id 96355146CE2F;
 Sun, 23 Jul 2023 13:37:54 +0200 (CEST)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: intel-wired-lan@lists.osuosl.org
Date: Sun, 23 Jul 2023 13:37:52 +0200
Message-Id: <20230723113752.995-1-alessio.bogani@elettra.eu>
X-Mailer: git-send-email 2.17.1
X-elettra-Libra-ESVA-Information: Please contact elettra for more information
X-elettra-Libra-ESVA-ID: DEF1740435.AA842
X-elettra-Libra-ESVA: No virus found
X-elettra-Libra-ESVA-From: alessio.bogani@elettra.eu
X-elettra-Libra-ESVA-Watermark: 1690717075.23021@uT44seFc8QerEj5gdzZWVw
X-Mailman-Approved-At: Mon, 24 Jul 2023 15:24:38 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Stop PTP related workqueues if
 aren't necessary
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Cc: Alessio Igor Bogani <alessio.bogani@elettra.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The workqueues ptp_tx_work and ptp_overflow_work are unconditionally allocated
by igb_ptp_init(). Stop them if aren't necessary (ptp_clock_register() fails
and CONFIG_PTP is disabled).

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 405886ee5261..02276c922ac0 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1406,7 +1406,13 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
+		return;
 	}
+
+	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
+
+	cancel_work_sync(&adapter->ptp_tx_work);
 }
 
 /**
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
