Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AFBC531FB
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Feb 2026 14:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F419083EB8;
	Fri, 20 Feb 2026 14:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rIIFM9Y30VbE; Fri, 20 Feb 2026 14:09:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 309B283EB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771596556;
	bh=u9HFZ3wYiKgrM2IQhKwmMk6ouL5om03wQDjATLkkZss=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=HFaSa/siQ6XqYCi40yavgM1G4YMwzypMrif+sdevENGWU2qwxm3S/ojv8N2a3CiPJ
	 OzMZiiM166fXhBBddCiYXRMwH+Ty0obnmze2jIsmzUgCXl9UhBD1WC4QNnuPBkNK9u
	 Mx8sh59yRWn5q/p71VrB52lAWlxkLF/hNVpRaY61EaccL20AtqVfc1VgHJCHyXbcqL
	 dsH3yOtFCQ1cw1y9QrDBwCQhxT458H2bRjBG/vimHZWY1PiMGkWBI+Cizu+Qu3TAaz
	 stz0EI4JwcVQvD2yAqZSZlsFw0Lctz40gTpw+l/P/Sgvu295myr4KHPd2UgPCtz8RG
	 Pbl0ge1VTW7tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 309B283EB0;
	Fri, 20 Feb 2026 14:09:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 40D421CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 14:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26DF14187F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 14:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4WlE2j1igKH4 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Feb 2026 14:09:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0D6AB4187C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D6AB4187C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D6AB4187C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 14:09:13 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-zyhEqfHvMeyU4SFqLpwb3A-1; Fri,
 20 Feb 2026 09:09:08 -0500
X-MC-Unique: zyhEqfHvMeyU4SFqLpwb3A-1
X-Mimecast-MFC-AGG-ID: zyhEqfHvMeyU4SFqLpwb3A_1771596546
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F84119001A4; Fri, 20 Feb 2026 14:08:03 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61B3A1955EA0; Fri, 20 Feb 2026 14:07:43 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Fri, 20 Feb 2026 15:07:00 +0100
Message-ID: <20260220140700.2910174-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 1pEu_YDqMcSpzMZiXpZXrUoKBUd1Aa4_cB4M_Rm6LNo_1771596546
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1771596552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u9HFZ3wYiKgrM2IQhKwmMk6ouL5om03wQDjATLkkZss=;
 b=YXm53Jxplf35Pwto2qScxHstfxPOjoIHEf3C6YLJkWK6iklvaLi3Lj/JTX2vUBNzsvlyrd
 +qXX8HA0wlc7PQ73XkmwELi2WAhs+J7d9n7aQdXY/Xv9PRWbBmmaqddCmbzcurk/ADMGjy
 ovUPglVfw+E27LfgNkvmUauyIU5Lw8g=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YXm53Jxp
Subject: [Intel-wired-lan] [PATCH iwl-net v3] ice: fix missing dpll
 notification for SW pins
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
Cc: ivecera@redhat.com, piotr.kwapulinski@intel.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

ice_dpll_notify_changes() sends dpll_pin_change_ntf() only for the
direct CGU input pin stored in d->active_input. Software-controlled
pins (SMA/U.FL) are separate dpll_pin objects that wrap a backing CGU
input, but they never receive a change notification. As a result,
userspace consumers such as synce4l that monitor SMA pins via dpll
netlink never learn when the pin state transitions (e.g. from
SELECTABLE to CONNECTED), even though 'dpll pin show' reports the
correct state on demand.

When the active input changes, also send dpll_pin_change_ntf() for any
registered SMA/U.FL input pin whose backing CGU input matches the old
or new active input.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602200046.SGwK2tWh-lkp@intel.com/
Signed-off-by: Petr Oros <poros@redhat.com>
---
v3:
- Add kdoc for the helper.
v2:
- Extract ice_dpll_sw_pin_needs_notify() helper for readability,
- Move loop variable into for() scope.

drivers/net/ethernet/intel/ice/ice_dpll.c | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index c2ad39bfe177db..a9db85a1026388 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2462,6 +2462,24 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
 	return pci_get_dsn(pf->pdev);
 }
 
+/**
+ * ice_dpll_sw_pin_needs_notify - check if SW pin needs change notification
+ * @p: pointer to SW pin (SMA or U.FL)
+ * @active: currently active input pin (or NULL)
+ * @old: previously active input pin (or NULL)
+ *
+ * Return: true if the SW pin is an input whose backing CGU pin matches either
+ * the old or new active input, meaning its state has changed.
+ */
+static bool
+ice_dpll_sw_pin_needs_notify(struct ice_dpll_pin *p,
+			     struct dpll_pin *active, struct dpll_pin *old)
+{
+	return p->pin &&
+	       p->direction == DPLL_PIN_DIRECTION_INPUT &&
+	       (p->input->pin == active || p->input->pin == old);
+}
+
 /**
  * ice_dpll_notify_changes - notify dpll subsystem about changes
  * @d: pointer do dpll
@@ -2470,6 +2488,7 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
  */
 static void ice_dpll_notify_changes(struct ice_dpll *d)
 {
+	struct ice_dplls *dplls = &d->pf->dplls;
 	bool pin_notified = false;
 
 	if (d->prev_dpll_state != d->dpll_state) {
@@ -2477,6 +2496,8 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
 		dpll_device_change_ntf(d->dpll);
 	}
 	if (d->prev_input != d->active_input) {
+		struct dpll_pin *old = d->prev_input;
+
 		if (d->prev_input)
 			dpll_pin_change_ntf(d->prev_input);
 		d->prev_input = d->active_input;
@@ -2484,6 +2505,14 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
 			dpll_pin_change_ntf(d->active_input);
 			pin_notified = true;
 		}
+		for (int i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
+			if (ice_dpll_sw_pin_needs_notify(&dplls->sma[i],
+							 d->active_input, old))
+				dpll_pin_change_ntf(dplls->sma[i].pin);
+			if (ice_dpll_sw_pin_needs_notify(&dplls->ufl[i],
+							 d->active_input, old))
+				dpll_pin_change_ntf(dplls->ufl[i].pin);
+		}
 	}
 	if (d->prev_phase_offset != d->phase_offset) {
 		d->prev_phase_offset = d->phase_offset;
-- 
2.52.0

