Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E380DF4644D
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF2918227B;
	Mon, 16 Mar 2026 10:42:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OkKmQ2Ffiogd; Mon, 16 Mar 2026 10:42:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E36C08223D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773657764;
	bh=TcCvlNKS2FtWNY/zDB/0qSw6naZ8LMZekz/Sa7hhVBQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=5AXzCinyDpYuWNvS9PNZPLoIib93IR8kbXe73jp5kA6mpFNv3pjaWMRy4gFMica7+
	 nbT2HcS20FKTrUiQPVeXKuYh3U4nvvCK+57NQMK4SC34qyL0tifr99Udk3UbgHjFwx
	 5nli3MJ4uNrsBu320agZ3DTka9cc69SjryuzNoB4iOEPZJo2oADCvIVEs2we3V40q7
	 LShnv6CNbaTUE30ZIcJeUfRmKHIC43sGiZ2tRvp89o+iqneqQugh59Au/YHawduGaR
	 Lrba1YW6bJh7UF2RDuRQh1TKc01IOWnoFQsbG5XatKmfiOGKxyog5CChi+5WPzsdOw
	 kOyjZF0/P6Xkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E36C08223D;
	Mon, 16 Mar 2026 10:42:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EB5C1B4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 10:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 208DC60E3E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 10:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HCdesku_B8g6 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 16 Mar 2026 10:42:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ED6C960DEA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED6C960DEA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED6C960DEA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 16 Mar 2026 10:42:40 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-54-iBjSePL26S8rctg4q0A-1; Mon,
 16 Mar 2026 06:42:36 -0400
X-MC-Unique: 54-iBjSePL26S8rctg4q0A-1
X-Mimecast-MFC-AGG-ID: 54-iBjSePL26S8rctg4q0A_1773657754
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98A7D180AA95; Mon, 16 Mar 2026 10:42:31 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.224.235])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 116131800351; Mon, 16 Mar 2026 10:42:27 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Mon, 16 Mar 2026 11:42:09 +0100
Message-ID: <20260316104209.1285962-5-poros@redhat.com>
In-Reply-To: <20260316104209.1285962-1-poros@redhat.com>
References: <20260316104209.1285962-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Fv0ZFxJ-8JN6LJRn0pugArUdPKDXL0svkaa7uQX-EHE_1773657754
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1773657759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcCvlNKS2FtWNY/zDB/0qSw6naZ8LMZekz/Sa7hhVBQ=;
 b=S75+5bYgh7GeuQUeMSXnAfl6iqAcO09i4IaJI5vej6uDHxQiqaYjtSfGG3IL5mLuaqMw/e
 B8wThpmMDYJQl5g5TxE9Id3gVuEfXtgLd/Oj4T0QogBIIY1eiRt4tEJsXlhC7puwF0iXQp
 yViE3rTSK81SmkwIz95ST4NEr1juTFM=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=S75+5bYg
Subject: [Intel-wired-lan] [PATCH iwl-next 4/4] iavf: harden VLAN filter
 state machine race handling
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Address remaining race windows in the VLAN filter state machine that
were identified during cross-state analysis of ADD and DEL paths.

1. Add VIRTCHNL_OP_ADD_VLAN to the success completion handler.

   The V1 ADD_VLAN opcode had no success handler -- filters sent via V1
   stayed in ADDING state permanently.  Add a fallthrough case so V1
   filters also transition ADDING -> ACTIVE on PF confirmation.

   Critically, add an `if (v_retval) break` guard: the error switch
   in iavf_virtchnl_completion() does NOT return after handling errors,
   it falls through to the success switch.  Without this guard, a
   PF-rejected ADD would incorrectly mark ADDING filters as ACTIVE,
   creating a driver/HW mismatch where the driver believes the filter
   is installed but the PF never accepted it.

   For V2, this is harmless: iavf_vlan_add_reject() in the error
   block already kfree'd all ADDING filters, so the success handler
   finds nothing to transition.

2. Skip DEL on filters already in REMOVING state.

   In iavf_del_vlan(), if a filter is in IAVF_VLAN_REMOVING (DEL
   already sent to PF, waiting for response), do not overwrite to
   REMOVE and schedule a redundant DEL.  The pending DEL's
   completion handler will either kfree the filter (PF confirms)
   or revert to ACTIVE (PF rejects).

   Without this, the sequence DEL(pending) -> user-del -> second DEL
   could result in PF returning an error for the second DEL (filter
   already gone), causing the completion handler to incorrectly revert
   a deleted filter back to ACTIVE.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 5 ++++-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 89e5aae20d5573..1ffc0ce3f35602 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -816,11 +816,14 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 			list_del(&f->list);
 			kfree(f);
 			adapter->num_vlan_filters--;
-		} else {
+		} else if (f->state != IAVF_VLAN_REMOVING) {
 			f->state = IAVF_VLAN_REMOVE;
 			iavf_schedule_aq_request(adapter,
 						 IAVF_FLAG_AQ_DEL_VLAN_FILTER);
 		}
+		/* If REMOVING, DEL is already sent to PF; completion
+		 * handler will free the filter when PF confirms.
+		 */
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index d0b7b810679399..147adb76f64141 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2877,9 +2877,13 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		spin_unlock_bh(&adapter->adv_rss_lock);
 		}
 		break;
+	case VIRTCHNL_OP_ADD_VLAN:
 	case VIRTCHNL_OP_ADD_VLAN_V2: {
 		struct iavf_vlan_filter *f;
 
+		if (v_retval)
+			break;
+
 		spin_lock_bh(&adapter->mac_vlan_list_lock);
 		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 			if (f->state == IAVF_VLAN_ADDING)
-- 
2.52.0

