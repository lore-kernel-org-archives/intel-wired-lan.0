Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71183ED7BBE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 11:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F7B261CDA;
	Tue, 14 Apr 2026 11:00:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOqK3-UqVxqS; Tue, 14 Apr 2026 11:00:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7408661CCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776164437;
	bh=9mJAFR2P64r9/LOJtwiqZN1rPSkz3fb8OpCJmbM7VKg=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3RVExYwXZTcCjSnjLAtu4XEG7/LSY7J4crj3ZjbdK2VoxwPCokQgAr25Odzj002Z
	 aU7U0JBdm3JeeoU74PoFffFWkjfMIOBm2z1fnRr+EQ1z0yAFhuLeUP9x1SY42MqG9R
	 +Pe+TXydyxDmV8noZfYaXYZsvIMAOBQJ2mgSpOruz5ukN2Ty9vTxGIbKvksgNZtjVB
	 EHtAsH6q1JYZKj1rDDoVs9Y7iVwZLpHHitD8WgEcjE4DvBzg/U/lWVUNTHeOziXt4H
	 MWvo/NaddU0KWAj504UTLiFz7tmJzF5o7Jdb+TIPR8pf3/seOCZy2rkuF2s50Wes2Z
	 +1SPVcUYJAzLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7408661CCC;
	Tue, 14 Apr 2026 11:00:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BCD56283
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 11:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF47240F14
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 11:00:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mjSskYr8yfZl for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 11:00:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A47FD40ED1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A47FD40ED1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A47FD40ED1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 11:00:34 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-P7JwzLljMfODu4ttQZpyWA-1; Tue,
 14 Apr 2026 07:00:30 -0400
X-MC-Unique: P7JwzLljMfODu4ttQZpyWA-1
X-Mimecast-MFC-AGG-ID: P7JwzLljMfODu4ttQZpyWA_1776164426
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FE74180086F; Tue, 14 Apr 2026 11:00:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E81903000C20; Tue, 14 Apr 2026 11:00:22 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date: Tue, 14 Apr 2026 13:00:03 +0200
Message-ID: <20260414110006.124286-3-jtornosm@redhat.com>
In-Reply-To: <20260414110006.124286-1-jtornosm@redhat.com>
References: <20260414110006.124286-1-jtornosm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: yAEOstBIb4nYfTrws0pqd154fkm8W29jtl2RHRjM4_I_1776164426
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1776164433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9mJAFR2P64r9/LOJtwiqZN1rPSkz3fb8OpCJmbM7VKg=;
 b=DGHfb19ids/+Kpp8UEKHyp7DjtwwL0Q+vFCHbjP4IZx778o9Jq3ZoSqpHd3QuId+1Q8F4z
 DMha4s5CE2ADxBRdV9eCF4X0/DXAhhoynExxQP9keRHoIwtLnDl8VV7b4hDz/NRLpUXzpo
 wCS9jOAXING5YlsfyOxP/Fu/gCzdJ2U=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DGHfb19i
Subject: [Intel-wired-lan] [PATCH net v3 2/5] i40e: skip unnecessary VF
 reset when setting trust
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

When VF trust is changed, i40e_ndo_set_vf_trust() always calls
i40e_vc_reset_vf() to sync MAC/VLAN filters. However, this reset is
only necessary when trust is removed from a VF that has ADQ (advanced
queue) filters, which need to be deleted

In all other cases, the reset causes a ~10 second delay during which:
- VF must reinitialize completely
- Any in-progress operations (like bonding enslave) fail with timeouts
- VF is unavailable

The MAC/VLAN filter sync will happen naturally through the normal VF
operations and doesn't require a forced reset.

Fix by only resetting when actually needed: when removing trust from a
VF that has ADQ cloud filters. For all other trust changes, just update
the trust flag and let normal operation continue.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a26c3d47ec15..fea267af7afe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4987,16 +4987,21 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
 	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
 
-	i40e_vc_reset_vf(vf, true);
 	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
 		 vf_id, setting ? "" : "un");
 
+	/* Only reset VF if we're removing trust and it has ADQ cloud filters.
+	 * Cloud filters can only be added when trusted, so they must be
+	 * removed when trust is revoked. Other trust changes don't require
+	 * reset - MAC/VLAN filter sync happens through normal operation.
+	 */
 	if (vf->adq_enabled) {
 		if (!vf->trusted) {
 			dev_info(&pf->pdev->dev,
 				 "VF %u no longer Trusted, deleting all cloud filters\n",
 				 vf_id);
 			i40e_del_all_cloud_filters(vf);
+			i40e_vc_reset_vf(vf, true);
 		}
 	}
 
-- 
2.53.0

