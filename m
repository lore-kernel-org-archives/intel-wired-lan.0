Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F835C982D2
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 19:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04A9760B7B;
	Thu, 17 Sep 2026 19:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zYfOh0lwHBs8; Thu, 17 Sep 2026 19:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BCA3960B8E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789671801;
	b=eTmwb6e+Az273oSkLWvOszS2lRSKQiQ2VRGn+sm96//s4AXYYQirMujXOjcgkvBk25Gs
	 I+h238wDr48bR/QRh5FjW0LrQE8rASfwPjmRkPCd26hlBbJL0KCyn7DOrevhpBpOxCa0/
	 fnuLUL1nYbVffwBtyzn8rEAoyCMFhDHcKQ5w/I9Nf+m33Gr+yrI6Ckwf3h6DX3HDtEk0w
	 7cw9FoJ/4p80CLe3/P8+iEaM0XOD/LUngETWDc0uoZpFWDhlIhlBwnCQWJS2T3e1QbHt3
	 rZMJHDapx+8Vgs7P9HXRXyZpVZeg8EvsET5Krqb/Xp8iWE39PsdiamIrEhqXR+wmJkQ==
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
	bh=6EB1T0pXKzjvsuv215L9ed3awL8vEMvUzqiYASmBEWw=;
	b=jW9B2RzejpcpsGByMtLf+Hf4Pt5orwhmZ9gUiYMlbuQAM0KHjXlbDbdPymE8ZIL+lrhO
	 bmlW21ogaIfFlyzeH8bM1CzPvFWk8/cAj+sgH45fcYoBcKm/fRYxJCvwu9DbEvUE9FxQT
	 IzlTMJyAiDFeb6jtkwlM/C+poIBPizpVOclETsLFm5U3FbidM+7G3OsWwMV6Pk6KE3M90
	 vjDup0MzLEbviIwASqGafgxPCUQETPSN8f+TI0i0e3A4sWKFga0giHSJ/uY0ea8ht7i3g
	 SzY5PKR6ljv1hNPgVph7A6L3oqh42Xo5fRN1EGHLZTWNhUQQCFfqQl3rLW8LJYKcd0A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I6bM4Nw8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789671801;
	bh=6EB1T0pXKzjvsuv215L9ed3awL8vEMvUzqiYASmBEWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XKcDcrcUbQqCoxmtRRB8GjrdvSRsq3t5916x9LarxKhglrDLWr4kioqv8vVedbu/L
	 ZdNWlSJuAqSRwqFiRTxPJKcP8+gF5jEp+V/KvCBfqxxTVA4HnZlGt9OctVPCurZC/D
	 UPedI+kPoamJSJ1ZIucqPJ3OubttkFScghjLPVY9hJdnCpSCm2Im3Ud1APOAaQwbDE
	 TSivqqAOaC6I+2tqLMoU4lgFSi1eiSJOEPQd8FIY654aA0ZDLRc8A1ccA9m9FmOBot
	 8kFnGjoyRSs4KjrFF2uT8nOjAdTeQyAivcQcmgRkxrzGPIKk4NuizfHN4U9YfYe5bA
	 VUpbU3VbCiUqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCA3960B8E;
	Thu, 17 Sep 2026 19:03:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC24E3AF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DECA60B8E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ZsGGdJ-_VoM for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 19:03:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B138060B7B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789671800;
 b=gHN3HNUy73DOk4eeG/q+20OCW+TEe1MMxsJozwBlPR7tUH4vLCwJTY3cyoQZ5QMhTSIC
 wTcvzuBV8L2xT1ml8zQonia+UPGBNXNpo1wjLtJStSq5Ogoti2Pn1eh8SJx6uF3PbqcBU
 bCBjSvHf38Cflxs5zxsU1b+rZXp51zeh26lHaiq5xPrD7+CWrdd1i2Rr+QTRjZBLk1E53
 qsSEj9dylTMWdEEzVAmuD3sHeoUOAPWySmKH+fVf8gkvxjr3Axf+UzfRZ7nsDatytx5cK
 cM4NmeUG3hz9IE8R5j8V3f6d1SYZhHT2zhi0w9Ftip/YS7aIWcLPEnAHEQTpEZpXsJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789671800;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=6EB1T0pXKzjvsuv215L9ed3awL8vEMvUzqiYASmBEWw=;
 b=Ruq7Usy2rZIZlzgKHNHVaTaxYYXrG5705ep6IUxlJIeLscQnwsW40k6gVX5UqUnvrSfw
 CndjqgIllcKuQ5s2g2apdz7VZIpjuXoQZD4loPZyA+AWEGVc7ReTBt4e9Cbe/2g8WgppH
 lsCa2kjcljKdI+HGkrhRJ2scrVVy5pmmXmyBU+bhcs5s82A0qqbMaNCGqWWQ3Scq3s97I
 UZGQ9+cagUuczEsXxqVd8nN6AMSBx1BwczQdYXJclG7Ow3ibGQv1t5+vzrJBmPVJ+qTb7
 CvOCyjqTkRlk9bW/kolqFoi0GbfAtuWYwGq3x2AXvHDz8aOB9wXsA4tgmBglBJGLHXg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=I6bM4Nw8; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=I6bM4Nw8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id B138060B7B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6EB1T0pXKzjvsuv215L9ed3awL8vEMvUzqiYASmBEWw=;
 b=I6bM4Nw8ekL56JJgzgltkntQqXNM6bE10+ZXeFq+E4WsztJ7XDl7mgX+7keiMwaU9fVQ+h
 bjKOtBsUX7IYuyBzKUaex8SnRA5BVpToTS5h2bVLDlUWV0luo2/G6hYq75bjfRQPOWTNlz
 UC81fFxIEXsL76su40P6yAA5i9FNB3s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-iatIkS3sOwWgx1D4V012qQ-1; Thu,
 17 Sep 2026 15:03:15 -0400
X-MC-Unique: iatIkS3sOwWgx1D4V012qQ-1
X-Mimecast-MFC-AGG-ID: iatIkS3sOwWgx1D4V012qQ_1789671793
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B47861912C6A; Thu, 17 Sep 2026 19:03:12 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CEC719AC047; Thu, 17 Sep 2026 19:03:08 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 2/2] ice: skip the SW pin description on boards with
 generic DPLL pins
Date: Thu, 17 Sep 2026 21:02:58 +0200
Message-ID: <20260917190258.3239282-3-poros@redhat.com>
In-Reply-To: <20260917190258.3239282-1-poros@redhat.com>
References: <20260917190258.3239282-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 2h3Rez30xS-Rmd4RNf-UVwwS1Xt3JYuNctVMBnH1K2A_1789671793
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

ice_dpll_init_info_sw_pins() describes the SMA and U.FL wrappers by
pointing them at fixed positions of the input and output arrays, inputs
4 and 5 and outputs 0 and 1 on an E810-C SFP, and reads the ref-sync
partner of the input it picked. The arrays are sized by the pin counts
firmware reports. On a board that does not match the Intel reference
layout the driver has already fallen back to generic pins, and when
such a board reports fewer pins than the reference the reads run past
the end of the arrays.

The wrappers are never registered on a generic board, but
ice_dpll_init_pins() still calls ice_dpll_pin_ref_sync_register() on
them, so a stray nonzero partner from the out of bounds read would pair
NULL pins.

Describe the wrappers only when the static pin table is in use and keep
their ref-sync registration under the same condition. The default
programming of the PCA9575 clock mux stays on the generic path, a board
that has the mux still needs its SMA connectors switched to inputs.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index e0362b6bf332e5..81bb32d2b23012 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -4124,15 +4124,15 @@ static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
 			if (ret)
 				goto deinit_sma;
 			count += ICE_DPLL_PIN_SW_NUM;
+			ret = ice_dpll_pin_ref_sync_register(pf->dplls.sma,
+							     ICE_DPLL_PIN_SW_NUM);
+			if (ret)
+				goto deinit_ufl;
 		}
 		ret = ice_dpll_pin_ref_sync_register(pf->dplls.inputs,
 						     pf->dplls.num_inputs);
 		if (ret)
 			goto deinit_ufl;
-		ret = ice_dpll_pin_ref_sync_register(pf->dplls.sma,
-						     ICE_DPLL_PIN_SW_NUM);
-		if (ret)
-			goto deinit_ufl;
 	} else {
 		count += pf->dplls.num_outputs + 2 * ICE_DPLL_PIN_SW_NUM;
 	}
@@ -4501,6 +4501,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 	int i, ret;
 	u8 data;
 
+	if (d->generic)
+		goto init_sma_ctrl;
 	if (pf->hw.device_id == ICE_DEV_ID_E810C_QSFP)
 		input_idx_offset = ICE_E810_RCLK_PINS_NUM;
 	phase_adj_max = max(d->input_phase_adj_max, d->output_phase_adj_max);
@@ -4566,6 +4568,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
 	}
 
+init_sma_ctrl:
 	if (!ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
 		return 0;
 
@@ -4584,7 +4587,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 	if (ret)
 		return ret;
 
-	ret = ice_dpll_pin_state_update(pf, pin, ICE_DPLL_PIN_TYPE_SOFTWARE,
+	ret = ice_dpll_pin_state_update(pf, d->sma, ICE_DPLL_PIN_TYPE_SOFTWARE,
 					NULL);
 	if (ret)
 		return ret;
-- 
2.55.0

