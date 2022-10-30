Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84F7FA3743
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Oct 2022 04:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 80500401FB;
	Sun, 30 Oct 2022 04:55:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80500401FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1667105744;
	bh=fyrTdd//ys0nl6MGtSz5W5OL8kjaF3DZQcJUPa8LgHo=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=O8YYinkOJ0Yk3G8xEk8tg983SuYF86nOo+nQ5lhPTllWaUl9DLS3leg7PlQyEW+Bj
	 7kL2tfmy41xfrwVyYnv8tmf30bmEo0RJazbQTlFhWCsHD9LSFEfObbOm5NINvoo4wQ
	 8mkaDydGuDlFElAWDseKIhIQN7d7jZ5XhGCnpxXo+v4tyPVM3o8G6HPjOe1UCdRqDj
	 KiFiystZ+IxVHy2rOkRhJToZtudVyK97tUhnZ5hWl91IEaR6UaoMRRe4SyUv0gNst0
	 iEV5BanqFg6IiMLKSIb6uQu7vIGKlvKDfEZmJ7bEvLYmxrQzqAYQmjzqQs26WInyHU
	 PrxHkGndYSMpw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IZLfwcXgUZPM; Sun, 30 Oct 2022 04:55:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A67C4040D;
	Sun, 30 Oct 2022 04:55:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A67C4040D
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1DB001BF36A
 for <intel-wired-lan@osuosl.org>; Sun, 30 Oct 2022 04:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0E92404F5
 for <intel-wired-lan@osuosl.org>; Sun, 30 Oct 2022 04:55:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0E92404F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6l9vcc6kE9aw for <intel-wired-lan@osuosl.org>;
 Sun, 30 Oct 2022 04:55:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0454A4046A
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0454A4046A
 for <intel-wired-lan@osuosl.org>; Sun, 30 Oct 2022 04:55:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="335367896"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; d="scan'208";a="335367896"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2022 21:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="635707897"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; d="scan'208";a="635707897"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.82])
 by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2022 21:55:15 -0700
From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To: intel-wired-lan@osuosl.org
Date: Sun, 30 Oct 2022 12:53:22 +0800
Message-Id: <20221030045324.25207-4-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221030045324.25207-1-muhammad.husaini.zulkifli@intel.com>
References: <20221030045324.25207-1-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667105737; x=1698641737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references;
 bh=AnZcd6iUXpGNJmg06Q9USZmJ1S79SOIaD3NVMOksIyU=;
 b=FQdawXDwbp08SxzspKwH8Y7s9t16bcmjZuhvbXvTav2+CsQS93QwQBOa
 gV1W0va3n0AeeRSlsE8AUvpXrRKZGVPw9sLvHfDoXyHSNA6cDPc0mQ0bw
 BstVDn+QtJ0nYt56d7ZaQ2aj2hGrd0xEwuRAnJPZUb7C08yfQbEIwfRve
 ukpzEaRxjVLX02l2NkYHNFOXQEgjaWcjZEg8EyqnKNavjl1sxr5LNfChE
 k0CbJpsvvN01fuiilVcZZm7qyFmHUnMX7AMfvIkpgZvKHpxiiyS9OkaY8
 im7BMScE+XnXDvaVzZZhoivA8SRLjVYfhv/XAWUpjx3Z0II32KTMDRdNw
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FQdawXDw
Subject: [Intel-wired-lan] [PATCH 3/5] igc: recalculate Qbv end_time by
 considering cycle time
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
Cc: muhammad.husaini.zulkifli@intel.com, tee.min.tan@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Tan Tee Min <tee.min.tan@linux.intel.com>

Qbv users can specify a cycle time that is not equal to the total GCL
intervals. Hence, recalculation is necessary here to exclude the time
interval that exceeds the cycle time. As those GCL which exceeds the
cycle time will be truncated.

According to IEEE Std. 802.1Q-2018 section 8.6.9.2, once the end of
the list is reached, it will switch to the END_OF_CYCLE state and
leave the gates in the same state until the next cycle is started.

Signed-off-by: Tan Tee Min <tee.min.tan@linux.intel.com>
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b321e0b2ddbd..9784af3afc57 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5948,6 +5948,21 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 
 		end_time += e->interval;
 
+		/* If any of the conditions below are true, we need to manually
+		 * control the end time of the cycle.
+		 * 1. Qbv users can specify a cycle time that is not equal
+		 * to the total GCL intervals. Hence, recalculation is
+		 * necessary here to exclude the time interval that
+		 * exceeds the cycle time.
+		 * 2. According to IEEE Std. 802.1Q-2018 section 8.6.9.2,
+		 * once the end of the list is reached, it will switch
+		 * to the END_OF_CYCLE state and leave the gates in the
+		 * same state until the next cycle is started.
+		 */
+		if (end_time > adapter->cycle_time ||
+		    n + 1 == qopt->num_entries)
+			end_time = adapter->cycle_time;
+
 		for (i = 0; i < adapter->num_tx_queues; i++) {
 			struct igc_ring *ring = adapter->tx_ring[i];
 
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
