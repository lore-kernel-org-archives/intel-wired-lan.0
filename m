Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D6BC88E72
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 19:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D96940822;
	Thu, 17 Sep 2026 19:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNLIZqOc_ryg; Thu, 17 Sep 2026 19:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E127940824
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789671801;
	b=ovjEC2OEYdDfeFhx339aXWB+vJ+sE7y8Q0WwWI2Z3PStVuvWc18AlvcrA68i0a0mPQ0Z
	 R80m4ovRO9P9R0jdtenx8pVjNyp8VMcDpie4EMs2LsbTDDhT6+3kJSM2hg6M9H9G5u/J+
	 BA1+k5gMCEGJxQT8Hqg1G03Do383MmCPXvm7DAa3iwaWly+zdirIuqpooAkKOkd9pCfmm
	 fMmKRFUqyhmWCWBUInT4ZxGgHaS5FM5dNMJFtSdMAC6ZumfYXE8EZl3wVVyYotaBxr0Tn
	 c5vnPd8BevPYnnwB9BZSO35Da1fFAT9nTlIiQGUia6ZYe+pGt//AOR6MGHM6VDrfATQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789671801;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oUesHNqg+ZVQdyp3TqOiMgGR4RIEF42DCBqJOEUMffo=;
	b=kSmx7KhWvarlwqyQ8psKTatbJ7A7T8I0yFAaJ12Mg4fP8QV/BMnTLoQBDw/8chR894KD
	 75QuFH93cKUdycBWWQiXwZA8/dOgDRMQMyH/iG4U4I+3Af3cDKw2K+YE1CrM72DRf5Uqc
	 +if58xxCoO6XmZFOzPwhZ5RBXozi0VTS2zhfEO6bDghdXGpTgL1rlfrmvz8RwdrtDcfWg
	 /5RqTW5NfNo3UB9AEhqczIipUSxrHnIdDVO6yEl/vel6mAeLy9CIuT2w99cCtnRO66c4P
	 OxzNb5yTd+ox+WrdcEP+mz1T52MpmET/YwcakceISS2sk1KHP19qgWVQLV58zEQZcZw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789671800;
	bh=oUesHNqg+ZVQdyp3TqOiMgGR4RIEF42DCBqJOEUMffo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d0BBWaH10olSNoyAt2G/myP5PJ8PAUtTLACzXZuDLhVg7zaHxdHhyL3LReSElQAHh
	 MfViXSqtpXQ+zj8girIvPHgL8L97oKu0d+btF6YoPtxehUbJso5i3QpXxHwWCc8+5z
	 qvLyIyplfF7C/CuklccNvrPF7lcp34nL+1LZ5p2camecNpmIU1b2iTp8fEDN/A8PJf
	 sv3J690XyzZRJPwtUF9PIgmQ+u3LQvF0gmRvgWdxiyec1c/SvVco14VGrVx0JNZ97T
	 0Ce73nhYu6z1Tl21QqBgcjUNDVYAcfvnisfFOZtfxd27YiTjca+cESWlOoKiEGpdaO
	 7xQMKxFJD+U/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E127940824;
	Thu, 17 Sep 2026 19:03:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6ED0F29B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54FEA4044A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:03:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id llqwbm7hHoIM for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 19:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8F39A40427
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789671798;
 b=Vqsh9dTPMatF97ZRgDuCApBurJaLmUz/ebhfcIBXSMfLJEt0+9Zq2HkDLZjyqAG80GIw
 HUrZvplF7sLS0H3AyudrxqsaxUQi/UcVvd9yub4mJHRcnajshNERjFhhnvAA5Wirj6ppU
 rQiqT+lB0qFSrsHH95cv4a0urXBzSOW7FZKrNHrV54+9RIAv0wJ2Wmd6p5LKMqQOQOAPm
 gCQsZij2A6tgFsYBUTmtoigvf/edupgJAyoszEb5kc8I9ntgKLiH3hIgQfYqWuAiIQMjF
 xv56/jM32oKPlAwvtqpwywIWSiqzoRoInA+PzMX3tE7IyXgyRSHwVWAlevPqzVS95ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789671798;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=oUesHNqg+ZVQdyp3TqOiMgGR4RIEF42DCBqJOEUMffo=;
 b=q9Zeil2WZCHIFrrwk+uWOd96toKo2otBjx+ze79gFesO6eqnjzY5hPV6DyiU9uPfD9yH
 gnidF653smsKUB8z1fj10RKD+52CNCKpQsuQ59sDZ9Hd1slM9bviXtYDp0ibMDgIzyktJ
 tnomCQtpYgA72MO8EcOswV5f36llz2J9mtQXzAYIjhMP0M4byCG3mZ1AKGeshNEM6gChi
 DTGTFMD6ONZQzC/S9VClJwX3vYYmA/F31kHGa7TyVm+535crYmtmxSKeCy0vLcPBPCF6P
 p9QnVT552XZoOVQbJmQWZo7ICR5jZmAlo0LxGi/tSQXewDHQTSZNZPkGOPldUlEAtRQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=AxbhfdpQ; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AxbhfdpQ
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F39A40427
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUesHNqg+ZVQdyp3TqOiMgGR4RIEF42DCBqJOEUMffo=;
 b=AxbhfdpQRBc+F3QX8/r1F9It3XF6EYTwlfc0LIJVysBoFEDzHNF3JkGX+bbwcqS8ZYtOHy
 8T9/QIzhPaq0CHBDd71Yl8m+VrIsIX20Bb4CUZ6y+9bTa3DFenm4YqzvjGGsceglbYSbXH
 7myGWqE8z2jyDSrYLNBJV5LqlLClUw0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-iDK-JP4kO3WRna3BMUBTAQ-1; Thu,
 17 Sep 2026 15:03:11 -0400
X-MC-Unique: iDK-JP4kO3WRna3BMUBTAQ-1
X-Mimecast-MFC-AGG-ID: iDK-JP4kO3WRna3BMUBTAQ_1789671789
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F4A4195C26B; Thu, 17 Sep 2026 19:03:08 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF81819AC047; Thu, 17 Sep 2026 19:03:04 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, stable@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 1/2] ice: fix DPLL registration on boards without the
 SMA clock mux
Date: Thu, 17 Sep 2026 21:02:57 +0200
Message-ID: <20260917190258.3239282-2-poros@redhat.com>
In-Reply-To: <20260917190258.3239282-1-poros@redhat.com>
References: <20260917190258.3239282-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: UnS1z3EACl-FEAgLtC8LutEjSCv1LjHj__Y2Z7h4X-k_1789671789
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The SMA and U.FL connectors of an E810-C timing board are routed by a
PCA9575 GPIO expander, and ice_dpll_init_info_sw_pins() reaches it
through ice_read_sma_ctrl(). On a board that carries a CGU but no such
expander the netlist lookup fails with -ENXIO, which aborts
ice_dpll_init_info() and with it the whole DPLL registration:

  ice 0000:cc:00.0: ice_dpll_init_info - fail: d->inputs:...
  ice 0000:cc:00.0: DPLLs init failure err:-6

Userspace loses the EEC and PPS devices, every CGU pin and the recovered
clock pin.

The netlist describes the mux with a clock mux node, which
ice_init_feature_support() already turns into ICE_F_SMA_CTRL. Key the
software controlled pins on that flag. Without the mux the SMA wrappers
stay inputs, the state the mux path programs at init anyway, and do not
advertise DIRECTION_CAN_CHANGE. The U.FL pins are the other leg of the
mux, so they are hidden, and the outgoing CGU pins stay visible as
REF-SMA1 and REF-SMA2/U.FL2.

The layout is not exotic, the E810_C827_SyncE_SFP_SEC configuration in
Intel's 4.80 NVM package has no clock mux node either. Such boards
worked until the SMA and U.FL redesign moved the expander access into
the DPLL init path.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Cc: stable@vger.kernel.org
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 85a74cd6ea1f3e..e0362b6bf332e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -107,6 +107,9 @@ static const struct dpll_pin_frequency ice_esync_range[] = {
  */
 static bool ice_dpll_is_sw_pin(struct ice_pf *pf, u8 index, bool input)
 {
+	if (!input && !ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
+		return false;
+
 	if (input && pf->hw.device_id == ICE_DEV_ID_E810C_QSFP)
 		index -= ICE_DPLL_SW_PIN_INPUT_BASE_QSFP -
 			 ICE_DPLL_SW_PIN_INPUT_BASE_SFP;
@@ -1213,6 +1216,8 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 
 	if (p->direction == direction && p->active)
 		return 0;
+	if (!ice_is_feature_supported(p->pf, ICE_F_SMA_CTRL))
+		return -EOPNOTSUPP;
 	ret = ice_read_sma_ctrl(&p->pf->hw, &data);
 	if (ret)
 		return ret;
@@ -4510,9 +4515,14 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 						  true, &freq_supp_num);
 		pin->prop.freq_supported_num = freq_supp_num;
 		pin->prop.capabilities =
-			(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE |
-			 DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
-			 caps);
+			(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE | caps);
+		if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
+			pin->prop.capabilities |=
+				DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE;
+		} else {
+			pin->active = true;
+			pin->direction = DPLL_PIN_DIRECTION_INPUT;
+		}
 		pin->pf = pf;
 		pin->prop.board_label = ice_dpll_sw_pin_sma[i];
 		pin->input = &d->inputs[pin_abs_idx];
@@ -4526,6 +4536,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		pin->idx = i;
 		pin->prop.type = DPLL_PIN_TYPE_EXT;
 		pin->prop.capabilities = caps;
+		pin->hidden = !ice_is_feature_supported(pf, ICE_F_SMA_CTRL);
 		pin->pf = pf;
 		pin->prop.board_label = ice_dpll_sw_pin_ufl[i];
 		if (i == ICE_DPLL_PIN_SW_1_IDX) {
@@ -4555,6 +4566,9 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
 	}
 
+	if (!ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
+		return 0;
+
 	/* Initialize the SMA control register to a known-good default state.
 	 * Without this write the PCA9575 GPIO expander retains its power-on
 	 * default (all outputs high) which makes all SW pins appear inactive.
-- 
2.55.0

