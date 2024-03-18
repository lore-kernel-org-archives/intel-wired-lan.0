Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA21C54E58
	for <intel-wired-lan@archiver.kernel.org>; Mon, 18 Mar 2024 14:31:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B40A405D2;
	Mon, 18 Mar 2024 14:31:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQjvszcM8LyR; Mon, 18 Mar 2024 14:31:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77FED405C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1710772289;
	bh=nWwHtoZl1wbbpHMnDuTuwYTm4XvT6TfDawuxJMzon0k=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=V61sJoV8PGnmXJIrPfo/Rd3+RroicX+fcxmSdTvsGQHBum7rn2+uuuWFHoQEhsiv5
	 JvR0hacOr8c3sEdB0whOpfmK2gFnAR+2VXx/kC9kFpUE17SKzGpGyNESXy/17MXDjS
	 BtCdhjPOY/DqM+auqUmz2HpvYQxhEQn3q5Y988iaEtkSR/ASoA5pvpKnl+gdyJ3FJQ
	 g/gsd1YJAMPPzsE/cL6NsWjxUVv3fLxhsyFWbIuSERo57GkZ9VTxui6xp9RXqodiGK
	 bSkDk83T8+k9D0TbwNtUnXCJnLf0tqVLwl3ddJCjs7BpelwDJnSaP8x2R1r8cDyIna
	 sBf4b511au1Aw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77FED405C1;
	Mon, 18 Mar 2024 14:31:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 12D7F1BF5A0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Mar 2024 14:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0052040A14
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Mar 2024 14:31:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hnH01cEI_puu for <intel-wired-lan@lists.osuosl.org>;
 Mon, 18 Mar 2024 14:31:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3B3F940204
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B3F940204
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B3F940204
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Mar 2024 14:31:25 +0000 (UTC)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-_t9FFwtvOZixWHm-wYPoug-1; Mon,
 18 Mar 2024 10:31:20 -0400
X-MC-Unique: _t9FFwtvOZixWHm-wYPoug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D6033802131;
 Mon, 18 Mar 2024 14:31:19 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04DEA112131D;
 Mon, 18 Mar 2024 14:31:17 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 18 Mar 2024 15:30:51 +0100
Message-ID: <20240318143058.287014-8-ivecera@redhat.com>
In-Reply-To: <20240318143058.287014-1-ivecera@redhat.com>
References: <20240318143058.287014-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1710772284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWwHtoZl1wbbpHMnDuTuwYTm4XvT6TfDawuxJMzon0k=;
 b=fgPq13SJn19LbP/ojCjsHqB2LxCPQruqO/r0JLum32MZyDmAr43cV4PLRhkBqvBUbAa4QH
 Bh8IF/Ni1it4iz5NOVHvf9m9yEgoysIpS9IvAmCJPr33n+Nnd1br3g1Hg6llVA4LSXbLGF
 9SVa1iSxKjEjvQ6tZO5EuB0bfPcj9tQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fgPq13SJ
Subject: [Intel-wired-lan] [PATCH iwl-next 7/7] i40e: Add and use helper to
 reconfigure TC for given VSI
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
Cc: "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add helper i40e_vsi_reconfig_tc(vsi) that configures TC
for given VSI using previously stored TC bitmap.

Effectively replaces open-coded patterns:

enabled_tc = vsi->tc_config.enabled_tc;
vsi->tc_config.enabled_tc = 0;
i40e_vsi_config_tc(vsi, enabled_tc);

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 31 +++++++++++++++------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2e1955064abb..6c25d02ea05e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5924,6 +5924,27 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 	return ret;
 }
 
+/**
+ * i40e_vsi_reconfig_tc - Reconfigure VSI Tx Scheduler for stored TC map
+ * @vsi: VSI to be reconfigured
+ *
+ * This reconfigures a particular VSI for TCs that are mapped to the
+ * TC bitmap stored previously for the VSI.
+ *
+ * NOTE:
+ * It is expected that the VSI queues have been quisced before calling
+ * this function.
+ **/
+static int i40e_vsi_reconfig_tc(struct i40e_vsi *vsi)
+{
+	u8 enabled_tc;
+
+	enabled_tc = vsi->tc_config.enabled_tc;
+	vsi->tc_config.enabled_tc = 0;
+
+	return i40e_vsi_config_tc(vsi, enabled_tc);
+}
+
 /**
  * i40e_get_link_speed - Returns link speed for the interface
  * @vsi: VSI to be configured
@@ -14290,7 +14311,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	struct i40e_vsi *main_vsi;
 	u16 alloc_queue_pairs;
 	struct i40e_pf *pf;
-	u8 enabled_tc;
 	int ret;
 
 	if (!vsi)
@@ -14323,10 +14343,8 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	 * layout configurations.
 	 */
 	main_vsi = i40e_pf_get_main_vsi(pf);
-	enabled_tc = main_vsi->tc_config.enabled_tc;
-	main_vsi->tc_config.enabled_tc = 0;
 	main_vsi->seid = pf->main_vsi_seid;
-	i40e_vsi_config_tc(main_vsi, enabled_tc);
+	i40e_vsi_reconfig_tc(main_vsi);
 
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_rm_default_mac_filter(vsi, pf->hw.mac.perm_addr);
@@ -15085,11 +15103,8 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 		}
 	} else {
 		/* force a reset of TC and queue layout configurations */
-		u8 enabled_tc = main_vsi->tc_config.enabled_tc;
-
-		main_vsi->tc_config.enabled_tc = 0;
 		main_vsi->seid = pf->main_vsi_seid;
-		i40e_vsi_config_tc(main_vsi, enabled_tc);
+		i40e_vsi_reconfig_tc(main_vsi);
 	}
 	i40e_vlan_stripping_disable(main_vsi);
 
-- 
2.43.0

