Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7641C38A02
	for <intel-wired-lan@archiver.kernel.org>; Fri, 28 Oct 2022 13:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74DDE60A9E;
	Fri, 28 Oct 2022 13:52:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74DDE60A9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1666965131;
	bh=STEUHdfn3UPwFwjYEnlFkRTc695p71Oo+Mbenob1OVI=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=6bWS8Dv2xQTMrlMeDEgRCLRjfUogPq7U8sKY6NlS96iJE6CvsMcTMrZcUE4DR6NHh
	 l8RtWnRu7jaAPsBLhP43isTkOHzGXKepRgNcj1jFGoXJm9veejX8skYE8sxZgBQ1AR
	 4t2cAvKZEGmMk5/DQ45UJD4tDEJf/PV9z30hjEnCWc3HNvA20zd3B/8qSYxDU5ExJr
	 /2ajd4PQ67MhgxmQoJ5s5Qg144y90uoF+EmT/Twwg1kgTtH8oNCAK11C2iev0b3N9h
	 +4wQwC0OqsTG4pIIYguF+MJocxF9/3EgnH5DeEGRgLQ0Di9HXVCBGEf1+CQU6c9xCM
	 NWxkbHlC+ls8Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WIjL_BPmw7eG; Fri, 28 Oct 2022 13:52:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7309060ADB;
	Fri, 28 Oct 2022 13:52:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7309060ADB
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id BBCC11BF9AC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Oct 2022 13:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 954AB60A9E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Oct 2022 13:52:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 954AB60A9E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PY1L8GYfKJIa for <intel-wired-lan@lists.osuosl.org>;
 Fri, 28 Oct 2022 13:52:07 +0000 (UTC)
X-Greylist: delayed 00:06:32 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89AA560B11
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89AA560B11
 for <intel-wired-lan@lists.osuosl.org>; Fri, 28 Oct 2022 13:52:07 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-KHC31jlENvC4OZ7p6aimog-1; Fri, 28 Oct 2022 09:45:30 -0400
X-MC-Unique: KHC31jlENvC4OZ7p6aimog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0FBE803D48;
 Fri, 28 Oct 2022 13:45:29 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.39.193.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95C74FD48;
 Fri, 28 Oct 2022 13:45:28 +0000 (UTC)
From: Stefan Assmann <sassmann@kpanic.de>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 28 Oct 2022 15:45:15 +0200
Message-Id: <20221028134515.253022-1-sassmann@kpanic.de>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kpanic.de
Subject: [Intel-wired-lan] [PATCH net-next] iavf: check that state
 transitions happen under lock
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
Cc: netdev@vger.kernel.org, patryk.piotrowski@intel.com, sassmann@kpanic.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add a check to make sure crit_lock is being held during every state
transition and print a warning if that's not the case. For convenience
a wrapper is added that helps pointing out where the locking is missing.

Make an exception for iavf_probe() as that is too early in the init
process and generates a false positive report.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/iavf/iavf.h      | 23 +++++++++++++++------
 drivers/net/ethernet/intel/iavf/iavf_main.c |  2 +-
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 3f6187c16424..28f41bbc9c86 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -498,19 +498,30 @@ static inline const char *iavf_state_str(enum iavf_state_t state)
 	}
 }
 
-static inline void iavf_change_state(struct iavf_adapter *adapter,
-				     enum iavf_state_t state)
+static inline void __iavf_change_state(struct iavf_adapter *adapter,
+				       enum iavf_state_t state,
+				       const char *func,
+				       int line)
 {
 	if (adapter->state != state) {
 		adapter->last_state = adapter->state;
 		adapter->state = state;
 	}
-	dev_dbg(&adapter->pdev->dev,
-		"state transition from:%s to:%s\n",
-		iavf_state_str(adapter->last_state),
-		iavf_state_str(adapter->state));
+	if (mutex_is_locked(&adapter->crit_lock))
+		dev_dbg(&adapter->pdev->dev, "%s:%d state transition %s to %s\n",
+			func, line,
+			iavf_state_str(adapter->last_state),
+			iavf_state_str(adapter->state));
+	else
+		dev_warn(&adapter->pdev->dev, "%s:%d state transition %s to %s without locking!\n",
+			 func, line,
+			 iavf_state_str(adapter->last_state),
+			 iavf_state_str(adapter->state));
 }
 
+#define iavf_change_state(adapter, state) \
+	__iavf_change_state(adapter, state, __func__, __LINE__)
+
 int iavf_up(struct iavf_adapter *adapter);
 void iavf_down(struct iavf_adapter *adapter);
 int iavf_process_config(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3fc572341781..bbc0c9f347a7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4892,7 +4892,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->back = adapter;
 
 	adapter->msg_enable = BIT(DEFAULT_DEBUG_LEVEL_SHIFT) - 1;
-	iavf_change_state(adapter, __IAVF_STARTUP);
+	adapter->state = __IAVF_STARTUP;
 
 	/* Call save state here because it relies on the adapter struct. */
 	pci_save_state(pdev);
-- 
2.37.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
