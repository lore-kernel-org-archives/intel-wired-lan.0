Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5BCC25B47
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Oct 2023 09:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F272F4000B;
	Fri, 27 Oct 2023 09:51:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F272F4000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1698400276;
	bh=brMTlKqBhNTvLDBH654ZjQSsXjSNrjsw4r7SlO0jikE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=S/6MlSJCMzfgq5R3EWPsPqv7skIW2EQC+L/duR8wYHGtkYPW9RSnsMwK3daU52kZM
	 sIrDRFr1oFXsvx28bXVHgIMKHfI+dusrqJpK6xCw1t1OXe6glUo8EOsNKLqglIqobQ
	 MIogMgDfRV2YR4ur9PwZ7tPRjeCwb9aS9DHL/RZccuOq3gwBvfYN/BoPX2YiyfQ8GW
	 SgpxPEAoh1K1FRRVJ2NaUt/oASgmWj/HrY6qPvTlXMtl5KicSulH6O1doTioEVkHtW
	 X/MvHdagcUHHykamEzvDWJlQUFJPMVvElLK/qv2qX699QjujI8n2bT5xWBgUqgbOfn
	 T/pfC0VMay6tw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nHoXwNEkGWPf; Fri, 27 Oct 2023 09:51:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E5BB4336C;
	Fri, 27 Oct 2023 09:51:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E5BB4336C
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 234EF1BF2F0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Oct 2023 09:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06EC9704AA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Oct 2023 09:51:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06EC9704AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6YJbCR2jx2rh for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Oct 2023 09:51:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF2BB70499
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Oct 2023 09:51:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF2BB70499
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-qMx7CWhYOj-b3VPNPguuOg-1; Fri,
 27 Oct 2023 05:51:05 -0400
X-MC-Unique: qMx7CWhYOj-b3VPNPguuOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D95163822E92;
 Fri, 27 Oct 2023 09:51:04 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.225.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C5CB40C6F79;
 Fri, 27 Oct 2023 09:51:03 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Fri, 27 Oct 2023 11:51:02 +0200
Message-ID: <20231027095102.499914-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1698400270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+J+pIKdzOxPew/Qi1A1+iGlEwJIRobC+pGNP7AL8MAg=;
 b=UJlsj2+w+G3g8hCpdzNx6AroDV3WE+RC5PikKvfDIoWXOI2M02qcpHAIja2pweDOTzgvJp
 4mZVeBL+T5wHp5ReSDRnRCPpmveZ4NFujKhXUAzGOBz8+Za7ZRdp22QA6lR+MqfdwK4rJA
 1WCFRp7SpAvLtVR3PtObCS6YQCC0Vwk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UJlsj2+w
Subject: [Intel-wired-lan] [PATCH net-next] iavf: use
 iavf_schedule_aq_request() helper
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
Cc: intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Use the iavf_schedule_aq_request() helper when we need to
schedule a watchdog task immediately. No functional change.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 10 +++-------
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 15 +++++----------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 90397293525f71..fc8d75a30602cd 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1447,10 +1447,9 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	iavf_fdir_list_add_fltr(adapter, fltr);
 	adapter->fdir_active_fltr++;
 	fltr->state = IAVF_FDIR_FLTR_ADD_REQUEST;
-	adapter->aq_required |= IAVF_FLAG_AQ_ADD_FDIR_FILTER;
 	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_FDIR_FILTER);
 
 ret:
 	if (err && fltr)
@@ -1481,7 +1480,6 @@ static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	if (fltr) {
 		if (fltr->state == IAVF_FDIR_FLTR_ACTIVE) {
 			fltr->state = IAVF_FDIR_FLTR_DEL_REQUEST;
-			adapter->aq_required |= IAVF_FLAG_AQ_DEL_FDIR_FILTER;
 		} else {
 			err = -EBUSY;
 		}
@@ -1491,7 +1489,7 @@ static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
 	if (fltr && fltr->state == IAVF_FDIR_FLTR_DEL_REQUEST)
-		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_FDIR_FILTER);
 
 	return err;
 }
@@ -1660,7 +1658,6 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 			rss_old->hash_flds = hash_flds;
 			memcpy(&rss_old->cfg_msg, &rss_new->cfg_msg,
 			       sizeof(rss_new->cfg_msg));
-			adapter->aq_required |= IAVF_FLAG_AQ_ADD_ADV_RSS_CFG;
 		} else {
 			err = -EEXIST;
 		}
@@ -1670,12 +1667,11 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 		rss_new->packet_hdrs = hdrs;
 		rss_new->hash_flds = hash_flds;
 		list_add_tail(&rss_new->list, &adapter->adv_rss_list_head);
-		adapter->aq_required |= IAVF_FLAG_AQ_ADD_ADV_RSS_CFG;
 	}
 	spin_unlock_bh(&adapter->adv_rss_lock);
 
 	if (!err)
-		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_ADV_RSS_CFG);
 
 	mutex_unlock(&adapter->crit_lock);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index b3434dbc90d6fe..7217ba018f6bbf 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1060,13 +1060,12 @@ static int iavf_replace_primary_mac(struct iavf_adapter *adapter,
 	 */
 	new_f->is_primary = true;
 	new_f->add = true;
-	adapter->aq_required |= IAVF_FLAG_AQ_ADD_MAC_FILTER;
 	ether_addr_copy(hw->mac.addr, new_mac);
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	/* schedule the watchdog task to immediately process the request */
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_MAC_FILTER);
 	return 0;
 }
 
@@ -1284,10 +1283,9 @@ static void iavf_up_complete(struct iavf_adapter *adapter)
 
 	iavf_napi_enable_all(adapter);
 
-	adapter->aq_required |= IAVF_FLAG_AQ_ENABLE_QUEUES;
 	if (CLIENT_ENABLED(adapter))
 		adapter->flags |= IAVF_FLAG_CLIENT_NEEDS_OPEN;
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ENABLE_QUEUES);
 }
 
 /**
@@ -1439,8 +1437,7 @@ void iavf_down(struct iavf_adapter *adapter)
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_ADV_RSS_CFG;
 	}
 
-	adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DISABLE_QUEUES);
 }
 
 /**
@@ -2340,10 +2337,8 @@ iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
 		}
 	}
 
-	if (aq_required) {
-		adapter->aq_required |= aq_required;
-		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
-	}
+	if (aq_required)
+		iavf_schedule_aq_request(adapter, aq_required);
 }
 
 /**
-- 
2.42.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
