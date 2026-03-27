Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7B210BA432
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E08261289;
	Fri, 27 Mar 2026 07:47:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bAPKQeKNWUSf; Fri, 27 Mar 2026 07:47:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C188661284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774597640;
	bh=+Ya0OKIOhrl1q5883EggLqKidONP4W3BL2eswWDJDRg=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Mkon+We1riNcLHisDJx88ElNMAgy2Hi9xo3/7FolsiQnTsg9D3TmqCJ63Q0U6FiU5
	 wU+D+FKd1zobdKLRx9A8SUdWF0hDKFDxC/Vx+0mqTSu1H9fYyBKmfv/V65vZWcqRX4
	 r4CoICDR7siBBee/uxvd5K3H8Icsb9dXsJErXC7Rgv9+Vi7ll2d+4HOs6++04MqyF3
	 tiEZunm2Am/GJYVfdqh1HyZIJGtMNk+IK7aItmQ4SmBgfgu5lUG5FtrzyIcVBMZyei
	 JGBW2h8ZWcv/3I31ofe6cFJrZSNh0Oas/aVB5tElWw2OJR17rc4QMwHZ7Xf2tlPGYM
	 2ZfvyTxx7ANiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C188661284;
	Fri, 27 Mar 2026 07:47:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 313932D5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B35240BA7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V76nQb3CTEC3 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:47:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EEE1740B9E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEE1740B9E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EEE1740B9E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:47:18 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-LCiNJ1KkO36QsokeeGwf6A-1; Fri,
 27 Mar 2026 03:47:11 -0400
X-MC-Unique: LCiNJ1KkO36QsokeeGwf6A-1
X-Mimecast-MFC-AGG-ID: LCiNJ1KkO36QsokeeGwf6A_1774597629
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CACD318002CF; Fri, 27 Mar 2026 07:47:08 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.224.50])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F2B11800671; Fri, 27 Mar 2026 07:47:03 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Fri, 27 Mar 2026 08:46:58 +0100
Message-ID: <20260327074658.2963328-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: TIrfLNm46LOZzNQQZPicR2qLWLNUQ44ylBl7KIVqgHc_1774597629
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1774597636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+Ya0OKIOhrl1q5883EggLqKidONP4W3BL2eswWDJDRg=;
 b=RDc1VrqoO45G3FRc8WGjRKGT9nd7AM1QmI8bvm39D9cMCOudlHq5YX0SHot1hCroZT5XBA
 VPzGqnkIhHN1PBApIxSGfVvGTthXnw6dEZzFyakk32WbfhMHmm6IJSec554OL9HVFFuFm8
 ALvngfcv0IshEPstXegimPm3cNoI924=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=RDc1Vrqo
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix PTP timestamping broken
 by SyncE code on E825C
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
Cc: Ivan Vecera <ivecera@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>,
 stable@vger.kernel.org, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The E825C SyncE support added in commit ad1df4f2d591 ("ice: dpll:
Support E825-C SyncE and dynamic pin discovery") introduced a SyncE
reconfiguration block in ice_ptp_link_change() that prevents
ice_ptp_port_phy_restart() from being called in several error paths.
Without the PHY restart, PTP timestamps stop working after any link
change event.

There are three ways the PHY restart gets blocked:

1. When DPLL initialization fails (e.g. missing ACPI firmware node
   properties), ICE_FLAG_DPLL is not set and the function returns early
   before reaching the PHY restart.

2. When ice_tspll_bypass_mux_active_e825c() fails to read the CGU
   register, WARN_ON_ONCE fires and the function returns early.

3. When ice_tspll_cfg_synce_ethdiv_e825c() fails to configure the
   clock divider for an active pin, same early return.

SyncE and PTP are independent features. SyncE reconfiguration failures
must not prevent the PTP PHY restart that is essential for timestamp
recovery after link changes.

Fix by making the entire SyncE block conditional on ICE_FLAG_DPLL
without an early return, and replacing the WARN_ON_ONCE + return error
handling inside the loop with dev_err_once + break. The function always
proceeds to ice_ptp_port_phy_restart() regardless of SyncE errors.

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 094e96219f4565..60bc47099432a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1296,12 +1296,10 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	if (pf->hw.reset_ongoing)
 		return;
 
-	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825) {
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
+	    test_bit(ICE_FLAG_DPLL, pf->flags)) {
 		int pin, err;
 
-		if (!test_bit(ICE_FLAG_DPLL, pf->flags))
-			return;
-
 		mutex_lock(&pf->dplls.lock);
 		for (pin = 0; pin < ICE_SYNCE_CLK_NUM; pin++) {
 			enum ice_synce_clk clk_pin;
@@ -1314,15 +1312,19 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 								port_num,
 								&active,
 								clk_pin);
-			if (WARN_ON_ONCE(err)) {
-				mutex_unlock(&pf->dplls.lock);
-				return;
+			if (err) {
+				dev_err_once(ice_pf_to_dev(pf),
+					     "Failed to read SyncE bypass mux for pin %d, err %d\n",
+					     pin, err);
+				break;
 			}
 
 			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
-			if (active && WARN_ON_ONCE(err)) {
-				mutex_unlock(&pf->dplls.lock);
-				return;
+			if (active && err) {
+				dev_err_once(ice_pf_to_dev(pf),
+					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
+					     pin, err);
+				break;
 			}
 		}
 		mutex_unlock(&pf->dplls.lock);
-- 
2.52.0

