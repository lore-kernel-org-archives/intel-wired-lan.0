Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CE0CD98F6
	for <intel-wired-lan@archiver.kernel.org>; Thu, 18 Jun 2026 15:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B53BB410E9;
	Thu, 18 Jun 2026 15:09:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VrPFMvSmTF5I; Thu, 18 Jun 2026 15:09:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B670941212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781795379;
	bh=LzYZekGzO/AOSypQh+DSKpcUdDPg1Q6wQEiH39OSTDI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=haaAMGiF/MVMpaC5r82SNHqaWIZQ/M5pXSkbW1lECxVt+kBH+oZQ+YvF8ANaICVkd
	 XMz3NAqoY0g3P3WSUzGQKHeg8xFVKikaotFr8inLEuzh+8QTyL1V9MF98RsjBieH7I
	 tVszCEzxkb02TBQSfmfD++c+vw42d+S+6ZC0t/E8j9Klq7yfvzXpsJMgZR86eL95NZ
	 TEPogX8xVGxDCbcpQdhTcjK3QTeVaHhKau7O/b5lX4S2Uq+8LW/gogfOc8MA3LuquY
	 5KCKABSlMqEhrmhiu5KdftUbGXFk4PmF/GkSwIjAEnjrr3V5g75t9RdurqbjvrtHuO
	 LSJXefPZzMuqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B670941212;
	Thu, 18 Jun 2026 15:09:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 527B71F3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jun 2026 15:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5086A612F7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jun 2026 15:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FM_eFPoy4DeO for <intel-wired-lan@lists.osuosl.org>;
 Thu, 18 Jun 2026 15:09:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3276E610D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3276E610D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3276E610D1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jun 2026 15:09:38 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-kM1hXvrUMpuq9N-QMvgNkw-1; Thu,
 18 Jun 2026 11:09:31 -0400
X-MC-Unique: kM1hXvrUMpuq9N-QMvgNkw-1
X-Mimecast-MFC-AGG-ID: kM1hXvrUMpuq9N-QMvgNkw_1781795369
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBE5718011C0; Thu, 18 Jun 2026 15:09:28 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.243])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAB8B1800675; Thu, 18 Jun 2026 15:09:24 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Thu, 18 Jun 2026 17:09:11 +0200
Message-ID: <deef5756e534ef06c12d910c5305d3fd205d30a0.1781786935.git.poros@redhat.com>
In-Reply-To: <cover.1781786935.git.poros@redhat.com>
References: <cover.1781786935.git.poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: OxBYp-YtY9AMbeLSQyyoogbsxYhjkvduFwFMTEV93kU_1781795369
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1781795376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LzYZekGzO/AOSypQh+DSKpcUdDPg1Q6wQEiH39OSTDI=;
 b=WeBJwkh1C+Iyod3OOm6WiV6cQPJQ+lZEiV9l463P8NYZBvTQz7wysIxD/RVocpGXBoHnu0
 alwS2Tg0I3nLg3+JvnHTk1xh2UMwqb5Rt63Bp0vLBmwESVm1PoCrdKS4/jYrpsv8GNGI/P
 tFGYwhQDyo23e5yLuwXiW0wW/YPA4yE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WeBJwkh1
Subject: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: preserve uplink DFLT Rx
 rule on switchdev release
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
Cc: Ivan Vecera <ivecera@redhat.com>, Alice Michael <alice.michael@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

ice_eswitch_setup_env() calls ice_set_dflt_vsi() to install the
ICE_SW_LKUP_DFLT Rx rule on the uplink VSI. The helper returns 0 even
when the rule is already in place, so the call is a no-op if
ice_vsi_sync_fltr() had previously installed the DFLT rule in response
to IFF_PROMISC on the uplink netdev. ice_remove_vsi_fltr() called
earlier in ice_eswitch_setup_env() does not affect this rule because
ice_remove_vsi_lkup_fltr() lacks a case for ICE_SW_LKUP_DFLT and falls
into its default branch which only logs. Switchdev mode then adds an
ICE_FLTR_TX leg via ice_cfg_dflt_vsi() on the same VSI handle.

ice_eswitch_release_env() unconditionally removed both the Rx and Tx
DFLT rules. When the Rx DFLT was installed by ice_vsi_sync_fltr()
before the switchdev session started, this clobbered promisc state the
operator had asked for: the DFLT Rx rule disappeared while IFF_PROMISC
was still set on the netdev, and the IFF_PROMISC sync path was not
retriggered, so the uplink ended the session without the catch-all
rule the netdev flags requested.

Skip the Rx DFLT removal when the uplink is still promiscuous, both in
ice_eswitch_release_env() and in the err_def_tx unwind of
ice_eswitch_setup_env(). The Tx leg installed by switchdev is always
removed since switchdev owns it.

The ena_rx_filtering() call earlier in ice_eswitch_release_env() is
left unconditional: it calls ice_cfg_vlan_pruning(), which returns
without enabling pruning while the netdev is in IFF_PROMISC, so it
cannot re-enable VLAN pruning under the preserved DFLT rule and drop
tagged traffic. Pruning is re-enabled later, when the IFF_PROMISC sync
path runs after promisc is actually cleared.

Use vsi->current_netdev_flags rather than the live netdev->flags for
this test. netdev->flags is written under RTNL by dev_change_flags(),
while ice_eswitch_release_env() runs under devl_lock, so reading it
here would be a TOCTOU against a concurrent promisc change. The
IFF_PROMISC bit of current_netdev_flags is written only under
ICE_CFG_BUSY by ice_vsi_sync_fltr(), and ice_set_rx_mode() gates that
sync off for the uplink while ice_is_switchdev_running() is true. The
bit is therefore frozen for the whole session and stable when
release_env reads it.

Because the sync is gated off during the session, a promisc change the
operator makes while switchdev runs never reaches ice_vsi_sync_fltr():
current_netdev_flags keeps the value captured before the session while
netdev->flags carries the new one. Once switchdev is torn down and
pf->eswitch.is_running is cleared, schedule a filter sync from
ice_eswitch_disable_switchdev() so the suppressed change is replayed
and the DFLT Rx rule is reconciled with the current netdev flags. This
also closes the window where release_env kept the rule based on the
frozen flag but the operator had since cleared IFF_PROMISC.

Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 32 +++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f0969035f77..b6073fc2375019 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -66,8 +66,10 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
 err_def_tx:
-	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
-			 ICE_FLTR_RX);
+	/* keep the Rx DFLT rule if still promiscuous (see release_env) */
+	if (!(uplink_vsi->current_netdev_flags & IFF_PROMISC))
+		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
+				 false, ICE_FLTR_RX);
 err_def_rx:
 	ice_vsi_del_vlan_zero(uplink_vsi);
 err_vlan_zero:
@@ -275,11 +277,23 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 	vlan_ops = ice_get_compat_vsi_vlan_ops(uplink_vsi);
 
 	ice_vsi_update_local_lb(uplink_vsi, false);
+	/* No-op while IFF_PROMISC is set: ice_cfg_vlan_pruning() self-gates on
+	 * it, so this cannot re-enable VLAN pruning under a preserved DFLT rule.
+	 */
 	vlan_ops->ena_rx_filtering(uplink_vsi);
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
-	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
-			 ICE_FLTR_RX);
+
+	/* Keep the Rx DFLT rule if the uplink is still promiscuous; it must
+	 * outlive the session. current_netdev_flags is used because its
+	 * IFF_PROMISC bit only changes under ice_vsi_sync_fltr(), gated off
+	 * during switchdev, so the read cannot race the RTNL netdev->flags.
+	 * Any change made during the session is replayed on teardown.
+	 */
+	if (!(uplink_vsi->current_netdev_flags & IFF_PROMISC))
+		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
+				 false, ICE_FLTR_RX);
+
 	ice_fltr_add_mac_and_broadcast(uplink_vsi,
 				       uplink_vsi->port_info->mac.perm_addr,
 				       ICE_FWD_TO_VSI);
@@ -327,10 +341,20 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
  */
 static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 {
+	struct ice_vsi *uplink_vsi = pf->eswitch.uplink_vsi;
+
 	ice_eswitch_br_offloads_deinit(pf);
 	ice_eswitch_release_env(pf);
 
 	pf->eswitch.is_running = false;
+
+	/* ice_set_rx_mode() was gated off during the session; replay a filter
+	 * sync so any suppressed promisc change reconciles the DFLT Rx rule.
+	 */
+	set_bit(ICE_VSI_UMAC_FLTR_CHANGED, uplink_vsi->state);
+	set_bit(ICE_VSI_MMAC_FLTR_CHANGED, uplink_vsi->state);
+	set_bit(ICE_FLAG_FLTR_SYNC, pf->flags);
+	ice_service_task_schedule(pf);
 }
 
 /**
-- 
2.53.0

