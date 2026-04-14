Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E753EED7BBE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 11:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A64FB61CDD;
	Tue, 14 Apr 2026 11:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o46hbKY74Mnh; Tue, 14 Apr 2026 11:00:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE23261CD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776164445;
	bh=VAmbrQbBI4SBbRZx1DWmHOcKHdFiGv6B3VCsYo5YKNM=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uPPUfzwxam7YdFto2d9JGmDVMVER/MN1aLGv5e46qG3VN+hEFSJLbuBaM6N5S6InC
	 9PbTFrs8oifJBPgdpbLEPL4Lg0zBBKrl6U0xILUXGneJtk9EHKoBuspUmoYKbMVp8O
	 2K/0S0D20tZA5yXbvA5JEVFB+mht7vA/ZQCd7qL/ja32a+0sQzverqlwzCdc9YTbtS
	 vF/2qLMMZXo6OkvvUC717STAWOaM2Aw/Unj0CzvDG8KLV5l6/U4sGoVpvyGYX5B4e5
	 wKtcgXIdkB8KX1n+t/zdIXtDcLOURT4gCW5w4L2OKOTn9TDJMViGQESmEAT40ph3V7
	 N5d2s8CLH1ktg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE23261CD4;
	Tue, 14 Apr 2026 11:00:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 249B8283
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 11:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15B8761CD4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 11:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jVLbsEliDPN5 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 11:00:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6D0FB61CB8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D0FB61CB8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D0FB61CB8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 11:00:43 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-LDUkDDjlMG2Z7qpSdvqFag-1; Tue,
 14 Apr 2026 07:00:38 -0400
X-MC-Unique: LDUkDDjlMG2Z7qpSdvqFag-1
X-Mimecast-MFC-AGG-ID: LDUkDDjlMG2Z7qpSdvqFag_1776164437
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BF2819560A3; Tue, 14 Apr 2026 11:00:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.43])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EACFA3000C21; Tue, 14 Apr 2026 11:00:33 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date: Tue, 14 Apr 2026 13:00:05 +0200
Message-ID: <20260414110006.124286-5-jtornosm@redhat.com>
In-Reply-To: <20260414110006.124286-1-jtornosm@redhat.com>
References: <20260414110006.124286-1-jtornosm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: zAHQdfVg7paI1g7UMKSpVjRn7zqpEnjEqQsuxH5kCIQ_1776164437
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1776164442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAmbrQbBI4SBbRZx1DWmHOcKHdFiGv6B3VCsYo5YKNM=;
 b=WGdNQbYY0E9HZttsnNrEtqlTMmRYMcLDq9a48AvhfJ0L/whmlk1fsD5iEVlBuLbbFCOgmW
 B9d8m/y6SgjTMn/0WPOwLAN+2htgKtV+4oQa/3ZtCyYWS11lWqHbk1rsJQAO4tTLuzSCLQ
 RfKEdYNK4DVSVIOqBcWEq5+APMXDZPA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WGdNQbYY
Subject: [Intel-wired-lan] [PATCH net v3 4/5] ice: skip unnecessary VF reset
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
ice_reset_vf() when the trust setting changes.

The ice driver already has logic to clean up MAC LLDP filters when
removing trust, which is the only operation that requires filter
synchronization. After this cleanup, the VF reset is only necessary if
there were actually filters to remove.

For all other trust state changes (setting trust, or removing trust
when no filters exist), the reset is unnecessary as filter
synchronization happens naturally through normal VF operations.

Fix by only triggering the VF reset when removing trust AND filters
were actually cleaned up (num_mac_lldp was non-zero).

This saves some time and eliminates unnecessary service disruption when
changing VF trust settings if not necessary.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e091756d..23f692b1e86c 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1399,14 +1399,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	mutex_lock(&vf->cfg_lock);
 
-	while (!trusted && vf->num_mac_lldp)
-		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
-
 	vf->trusted = trusted;
-	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");
 
+	/* Only reset VF if removing trust and there are MAC LLDP filters
+	 * to clean up. Reset is needed to ensure filter removal completes.
+	 */
+	if (!trusted && vf->num_mac_lldp) {
+		while (vf->num_mac_lldp)
+			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
+		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+	}
+
 	mutex_unlock(&vf->cfg_lock);
 
 out_put_vf:
-- 
2.53.0

