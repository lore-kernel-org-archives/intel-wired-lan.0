Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F07CDB470
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jun 2026 10:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65FD6607FF;
	Tue, 23 Jun 2026 10:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LkDTRtsdZH-I; Tue, 23 Jun 2026 10:18:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB7C360898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782209919;
	bh=adlgMuLZU9orARuzmJXHQQ/r4/TXqlabG4ZF1JkIW0E=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/v2Z3nv81daqZq7bOZ1cedmCVOj5qRmbL2AYV47CJQyQQxOmJqTMNViJocB+nXf7
	 2bg/DlDLr6FJy8VyrxH4ksCHJ8l2RaMoumzdJ3qbtpVOGvE0SBa3hEUdz7NIlsUwZN
	 vz0GrQKlnSs14YQAbzFs+XOYoFqRzu/6lzQ/hlLcZKuSkF38310i4cSawGGHYDms6p
	 iUFJXamp3kZ1+spkM61rINn3L89ZM3N3MchRtEC9xqi0LeyUUJbsz2PYGFtTsDGCYA
	 35LdTKakdhOPFwBFjYq9GDL7y8QmCjk7tFvEpPrYNlBXZW/2geodiNcdI+CpzBDubB
	 b5V98ZgbUXDLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB7C360898;
	Tue, 23 Jun 2026 10:18:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4AE1256
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AD5A8175F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:18:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oV26-pUSPai5 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jun 2026 10:18:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8229E81750
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8229E81750
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8229E81750
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jun 2026 10:18:37 +0000 (UTC)
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-9dpBrLQHOmaA4s2fMz7x_w-1; Tue,
 23 Jun 2026 06:18:33 -0400
X-MC-Unique: 9dpBrLQHOmaA4s2fMz7x_w-1
X-Mimecast-MFC-AGG-ID: 9dpBrLQHOmaA4s2fMz7x_w_1782209911
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BBAE19540E7; Tue, 23 Jun 2026 10:18:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2EC71800593; Tue, 23 Jun 2026 10:18:27 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, jacob.e.keller@intel.com, horms@kernel.org,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date: Tue, 23 Jun 2026 12:18:00 +0200
Message-ID: <20260623101800.991293-5-jtornosm@redhat.com>
In-Reply-To: <20260623101800.991293-1-jtornosm@redhat.com>
References: <20260623101800.991293-1-jtornosm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: EX8TxguHBglbFSjHURL2MrSJXcl5Bho3WZdoBULiS3M_1782209911
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1782209916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=adlgMuLZU9orARuzmJXHQQ/r4/TXqlabG4ZF1JkIW0E=;
 b=XVI+XY2obl3Nv47bLWRmmrz4J81SgPNHJ4fhdi/sNBc1rX/9amqO/4Q9XhIzl2K9wfgOVC
 M/CtP5li+S5tyjpdjRo3HZ2nUgd5j7YuZpQcvKAAigf+WSI6H8jPxBSkszPRlPVqXdBs0c
 svzIGoZuL66yyD5sm75nZFKibkKZaPk=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XVI+XY2o
Subject: [Intel-wired-lan] [PATCH net v7 4/4] ice: skip unnecessary VF reset
 when setting trust
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

Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
ice_reset_vf() when the trust setting changes. While the delay is smaller
than i40e, this reset is still unnecessary in most cases.

When granting trust, no reset is needed - we can just set the capability
flag to allow privileged operations.

When revoking trust, we only need to reset (conservative approach) if
the VF has actually configured advanced features that require cleanup
(MAC LLDP filters, promiscuous mode). For VFs in a clean state, we can
safely change the trust setting without the disruptive reset.

When we do reset, we maintain the original ice pattern that has been
reliable in production: cleanup LLDP filters first, then set vf->trusted,
then reset. This ensures the privilege capability bit is handled correctly
during reset rebuild.

When we don't reset, we manually handle the capability flag via helper
function, eliminating the delay.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v7: Rebase on current net tree (no code changes from v6)
v6: https://lore.kernel.org/all/20260619061321.8554-5-jtornosm@redhat.com/

 drivers/net/ethernet/intel/ice/ice_sriov.c | 33 +++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e091756d..XXXXXXXXXXXXXXXX 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1364,6 +1364,23 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	return __ice_set_vf_mac(ice_netdev_to_pf(netdev), vf_id, mac);
 }

+/**
+ * ice_setup_vf_trust - Enable/disable VF trust mode without reset
+ * @vf: VF to configure
+ * @setting: trust setting
+ *
+ * Update VF flags when changing trust without performing a VF reset.
+ * This is only called when it's safe to skip the reset (VF has no advanced
+ * features configured that need cleanup).
+ */
+static void ice_setup_vf_trust(struct ice_vf *vf, bool setting)
+{
+	if (setting)
+		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	else
+		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+}
+
 /**
  * ice_set_vf_trust
  * @netdev: network interface device structure
@@ -1399,11 +1416,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)

 	mutex_lock(&vf->cfg_lock);

-	while (!trusted && vf->num_mac_lldp)
-		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
-
+	/* Reset only if revoking trust and VF has advanced features configured */
+	if (!trusted &&
+	    (vf->num_mac_lldp > 0 ||
+	     test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
+	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))) {
+		while (vf->num_mac_lldp)
+			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
+		vf->trusted = trusted;
+		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+	} else {
+		vf->trusted = trusted;
+		ice_setup_vf_trust(vf, trusted);
+	}
-	vf->trusted = trusted;
-	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");

--
2.43.0

