Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E108109C02F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Mar 2026 15:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C0E28221D;
	Wed, 25 Mar 2026 15:11:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DDsAvjNFjGfq; Wed, 25 Mar 2026 15:11:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4862821F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774451488;
	bh=jbo0Ad/kP5wlt8QZq7dLLcRaxS2hXarbNY4mrADEEb4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=uPqtUsqA3p+6uTgAdKJFeVUlLbHeNjFb54yowXVknKCfwq7e2fDECNUd7JHiYkpnM
	 ayd5DKqKXNEx7bWwyYHrqME20CAgXCbRn6gsxI7kms7VMyOdJmXwRCBxvUI6T05UCr
	 N8C/3YWhsVhnLajSMrbONZmAKLVIBLUj5634JZB0KPuPd/A4I0Far2rDtx0jD+Lg1+
	 Ym4sOZVv4uGIL/f/n8HQkF9VhKyuX3/YAWnb6JjCwEg7ulfxaKpw7txFeyAX7jwB0M
	 PG1SPSgmh70SUtwX99sUC9baDOOOX/DQGwKxG2DMoipGUm2Fv/02US9W5+81NNMoRV
	 Bo6wNwjGXhvSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4862821F7;
	Wed, 25 Mar 2026 15:11:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F97D1D3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E79D4094A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:11:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k6uVGSQ91AUH for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Mar 2026 15:11:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 229D2407EA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 229D2407EA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 229D2407EA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:11:25 +0000 (UTC)
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-xN6BkXvYN_6RTTSwpmcFdA-1; Wed,
 25 Mar 2026 11:11:19 -0400
X-MC-Unique: xN6BkXvYN_6RTTSwpmcFdA-1
X-Mimecast-MFC-AGG-ID: xN6BkXvYN_6RTTSwpmcFdA_1774451475
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C04B180894D; Wed, 25 Mar 2026 15:11:11 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.224.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C72C43000223; Wed, 25 Mar 2026 15:11:06 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Date: Wed, 25 Mar 2026 16:10:50 +0100
Message-ID: <20260325151050.2081977-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: HgaG6XmigYSJYfXCw4E_wJj4imKrrHp9jG7hyylGsRM_1774451475
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1774451484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jbo0Ad/kP5wlt8QZq7dLLcRaxS2hXarbNY4mrADEEb4=;
 b=GYMQwIi8oObxlivsekOGftb+0cxyPlhZdl2xCaOPvwA8oH1krIkrrKZqWKTahPYTuW9lq+
 6jLtRArWwk5lxO2rUkii2fugjRO1vMvTu12Ht+5OKby6LWvTceQP6vouG3Ehpibe8Wcvam
 Z3ND+W+WwRtHD55L4KnTeaQmCASx6mo=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GYMQwIi8
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix U.FL pin state set
 affecting paired SMA pin
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
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Michal Michalik <michal.michalik@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Milena Olech <milena.olech@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

When setting a U.FL pin to disconnected state, ice_dpll_ufl_pin_state_set()
blindly modifies SMA control register bits and disables the shared
underlying output/input pin without checking whether the U.FL pin is
currently active.

SMA1 and U.FL1 share the same physical output pin, controlled by
ICE_SMA1_DIR_EN and ICE_SMA1_TX_EN bits. When SMA1 is in output mode
(DIR_EN=1, TX_EN=0), U.FL1 is already inactive. Disconnecting U.FL1
sets TX_EN=1, which combined with DIR_EN=1 causes
ice_dpll_sw_pins_update() to mark SMA1 as inactive too. The subsequent
ice_dpll_pin_disable() then disables the shared output pin entirely,
breaking SMA1's connection.

Fix by checking whether U.FL1/U.FL2 is already inactive before
proceeding with the disconnect. If the pin is not currently controlling
the shared output/input, return success immediately without modifying
the SMA control register or disabling the underlying pin.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 5cfa19da099bfc..76c68f54a1cc97 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1253,6 +1253,14 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			data &= ~ICE_SMA1_MASK;
 			enable = true;
 		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			/* Skip if U.FL1 is not active, setting TX_EN
+			 * while DIR_EN is set would also deactivate
+			 * the paired SMA1 output.
+			 */
+			if (data & (ICE_SMA1_DIR_EN | ICE_SMA1_TX_EN)) {
+				ret = 0;
+				goto unlock;
+			}
 			data |= ICE_SMA1_TX_EN;
 			enable = false;
 		} else {
@@ -1267,6 +1275,15 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 			data &= ~ICE_SMA2_UFL2_RX_DIS;
 			enable = true;
 		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			/* Skip if U.FL2 is not active, setting
+			 * UFL2_RX_DIS could also disable the paired
+			 * SMA2 input.
+			 */
+			if (!(data & ICE_SMA2_DIR_EN) ||
+			    (data & ICE_SMA2_UFL2_RX_DIS)) {
+				ret = 0;
+				goto unlock;
+			}
 			data |= ICE_SMA2_UFL2_RX_DIS;
 			enable = false;
 		} else {
-- 
2.52.0

