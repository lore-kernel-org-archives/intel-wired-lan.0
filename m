Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA78C46467
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Jan 2023 08:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E95AD81551;
	Tue, 10 Jan 2023 08:00:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E95AD81551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673337649;
	bh=Ig5enXlf2+ZXdZ3fxZaW0KY/XyiHRAfax4fVkF/MyMA=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=KsbTcJw7KxvZXRLPiD1kZqMFPOIAP1ddLqqjWs0ET7/2mK6btjnbM122r/5iby7hh
	 PlI+DwZ/xqfUKE+ywbukguiMZwopORnpj59pnrMtQ9YOSopqQEpQcCfRDQYNQgdehm
	 GGUNODOGNWBD7j9oWORwf2dGC/A0i9bkCUz/ZbgHtUEkF0G98dco6eEeU6oxHI5vLG
	 EI8srjKQl98VsQ7RCgPeprrbF7ui0krSbGiAwoxmmeQrVMow5Sht4R4ifE0CvMNWG7
	 B34KqQtlzJLZGrMbOfnGsi4QfZCtJEaTDewIeW0kVashlu3VvkBHav8YcgxAiPNio3
	 1dKyYr23bIH0w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MtT9-RHjg0l2; Tue, 10 Jan 2023 08:00:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 037C081417;
	Tue, 10 Jan 2023 08:00:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 037C081417
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 696A41BF284
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Jan 2023 08:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 439354023B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Jan 2023 08:00:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 439354023B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qj7g6uKB6xQK for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Jan 2023 08:00:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D1B04018A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7D1B04018A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Jan 2023 08:00:45 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-pOTG5Lg-PH-Bf9xfhBrWlg-1; Tue, 10 Jan 2023 03:00:39 -0500
X-MC-Unique: pOTG5Lg-PH-Bf9xfhBrWlg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 763AE1C07581;
 Tue, 10 Jan 2023 08:00:39 +0000 (UTC)
Received: from p1.redhat.com (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D068240C2064;
 Tue, 10 Jan 2023 08:00:37 +0000 (UTC)
From: Stefan Assmann <sassmann@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 10 Jan 2023 09:00:18 +0100
Message-Id: <20230110080018.2838769-1-sassmann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1673337644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VbV+3mBuPRg5iwF3LHk2SJLW0Ekjn5LgQSo5mIGhQwE=;
 b=jWT5ROaKeH3FhzchNL0GA+n1Qver0tLoij7CO7NZew5vQ2GelePPfS+Q5lvVB2UNC6/2+B
 ayVnHTPDy8WA06V4kP+lIh7fF1oV0PGFjprq0ZywkB9973wOcQoUsTord6mbzQIHYyR5US
 wqvUrJZdn2PQ+p3V+W/iDS9/1bQCnwM=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jWT5ROaK
Subject: [Intel-wired-lan] [PATCH net-queue] iavf: schedule watchdog
 immediately when changing primary MAC
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
Cc: netdev@vger.kernel.org, patryk.piotrowski@intel.com,
 anthony.l.nguyen@intel.com, sassmann@kpanic.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Stefan Assmann <sassmann@kpanic.de>

iavf_replace_primary_mac() utilizes queue_work() to schedule the
watchdog task but that only ensures that the watchdog task is queued
to run. To make sure the watchdog is executed asap use
mod_delayed_work().

Without this patch it may take up to 2s until the watchdog task gets
executed, which may cause long delays when setting the MAC address.

Fixes: a3e839d539e0 ("iavf: Add usage of new virtchnl format to set default MAC")
Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
Depends on net-queue patch
ca7facb6602f iavf: fix temporary deadlock and failure to set MAC address

 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index fff06f876c2c..1d3aa740caea 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1033,7 +1033,7 @@ int iavf_replace_primary_mac(struct iavf_adapter *adapter,
 
 	/* schedule the watchdog task to immediately process the request */
 	if (f) {
-		queue_work(adapter->wq, &adapter->watchdog_task.work);
+		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
 		return 0;
 	}
 	return -ENOMEM;
-- 
2.38.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
