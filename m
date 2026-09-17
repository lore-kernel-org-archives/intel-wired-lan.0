Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C896C88E72
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 19:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17024810D9;
	Thu, 17 Sep 2026 19:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qCqIydrtGdhW; Thu, 17 Sep 2026 19:10:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 38D79810F9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789672207;
	b=TGobWNleHqDNxtu0qZ3zY4CdXkxaNkqgkhD0mwm4TMCxNBn4bYWPwbGHBarxw2gTlGR8
	 KwR/VTHEpJzepSeVdRg2eOXd/IjHvCPbbAoHvqx0TG0+5iXdXb6bC19XdV4sjH5KLZGOD
	 wTT9mkEuQ35Bx4E9VsWP87jYsszk570ecsV9TpCTW/BLll2ORRUgTafU2FlJxUO4p+16B
	 VLM9nHbIfqUdSuK1d9iVRTGKIngzSDgnLTv4EjGAM0U2h4VNvQtD/lT+xKJ0jhBnXqx4I
	 p/18yQIprmwcOG5mkyar6ld2HyvGyNB9/UQtBB+7EVrSYvgDpApJEwvCt8piYNn/4tA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789672207;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kd7ve/ETXrtuVxH9TgTAu12Pa3xhhvP5Wd1l1AlHCZQ=;
	b=Hp1nFr8bnptFoDzUQW7e8BQmmWlnOjv/1SSZVibt5IzoYYHDxRtKEkM6WFSj44shV9Xo
	 N4qj5wUAdrVbEU/fx/vLUdQM2VcdV7usgG1PaG9sEpoIQnEKLHVccvOwQrlvlszGpGBFh
	 u1r7ixKw2reLlJk98hReTqdYqQ3cHc82fKGaO/NvvI/n7vuun+r5UdJJ7Y5hHLnGifAEC
	 ZS59/8KJS/U3eqPm+cwfFeBK1t9GTPUkV/1T6vNpSLPfaq2ZaQmzLCGMJIRs3vwATE1Gz
	 U7JcgaF2hV8qIGH1VALAmB74hU7hpQRrpmLzuhHMgnXJl1LYi2yEr1SuO8zP6BUxQkQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KdYvBCHH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789672207;
	bh=kd7ve/ETXrtuVxH9TgTAu12Pa3xhhvP5Wd1l1AlHCZQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vLEcsBjxl/KsmwS3Ud/0A7x+ojxPLogUFsUuxeXbaNtPoJDvo4fW+ZPqfVt+yfpa8
	 tmFZ7FZA69lonADuEjZ70C1woGxweZTb8UG9wHhyOd0R6a1FEHHJcnTx+YD5ckxIJ7
	 H7CrU6b4tTH5WAJ2zjQsRWg0rih9v5Jui5Im3NkbAOWI5kgcVFFdEav0qRXqFvy+W0
	 wW2CFeqssfRFCZWmGCw4WVMIWjvuowqBq9fKdXMySf8oc6ooxbe0OtKIuBiTPbCVic
	 ueGI0YvgVID2ASjjX9l1RgLpCeC8u+wxKpq0aytF/Lp1P6vPJ9JhPKYsJIGcCEPp4n
	 RE1ruxqJTvwDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38D79810F9;
	Thu, 17 Sep 2026 19:10:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A13A9362
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9329B810F9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hJpbXEjUlBxN for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 19:10:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 09B3A810D9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789672204;
 b=CUWVtlkXvoJzBEyekpt/letMitNJDqQa8oGyxtxFzQ2EgoYjS5hh5bVbP8pYAWPn9T5V
 Q0rboI+pmmL7C/xzM61/gm3N3TOtWo9onD9qt891aQSzj2OVMigSwZw7jiVXDSbH48wJH
 iJf2/yTQsda2XgjAZNWCEnLRQGDLM4SMwJxl0exqCfJ8Uc3RA0XslLAOmtAaMFbQ3sUU2
 INcqQxPoF3yV+Q0Z6VFYRaR6wFMj93N4WLSUdFAH8PrkbDbM91cVfTzvt7MTEgRAFYfHu
 1K/I2wpa94piVFfrdgRoeglMHw4t6BRbXIbt7quSS/MsxxdGDKu6u37k6nGH2ogSeGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789672204;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
 bh=kd7ve/ETXrtuVxH9TgTAu12Pa3xhhvP5Wd1l1AlHCZQ=;
 b=kC1Cmdw01q+c1Bhuwxy26DRdzJsdjqU9SMDXKRABYbuSzLzEOqUis+ryE/BUuyvp5f1a
 NPUYo8EEwNI9LLOjBXzUNzkz+yC9LkiNUtlHPpf+4FycoaHhiAwoE4GEe3ymETf26c9b0
 WQDpR7Dt+5RjWVc8JcBegfKWxhkKCd9+KuE5d2b6Hhui0iFSHj+n+Tdqct8KOcUietSRC
 OIHHilD0iIfhoLCjz58TKb4zegHyn5AyCzuAItReOactthPBh/2BFjX1V4ZUMeu4jLS0T
 +V7uXkGOqmpA0J02aFzfDgOkIWvMbp+++G9inGr3TXP4asz6ixPOt+oQyfQPXti2Yrg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=KdYvBCHH; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KdYvBCHH
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09B3A810D9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789672201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kd7ve/ETXrtuVxH9TgTAu12Pa3xhhvP5Wd1l1AlHCZQ=;
 b=KdYvBCHHdtJpqxTbflnEgjouRtp5myWbepOhwCmlS1u9Ls5mnl+CE8iccl+4Higi3EfEQE
 ONRuJBkQUVTM3HqRDD99ge7/yFatL8m8qujv6pf2Tjph05vbyFqhdlI4kjbQpI6MJ6GscJ
 u1qQb7Bm0j3jPSkD3+shtax3v6lwXY4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-_a3_3AhVM029upCQa8ESvg-1; Thu,
 17 Sep 2026 15:03:51 -0400
X-MC-Unique: _a3_3AhVM029upCQa8ESvg-1
X-Mimecast-MFC-AGG-ID: _a3_3AhVM029upCQa8ESvg_1789671829
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 180BF18052E5; Thu, 17 Sep 2026 19:03:49 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B55D430001A2; Thu, 17 Sep 2026 19:03:45 +0000 (UTC)
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
Subject: [PATCH iwl-next] ice: describe generic DPLL pins from firmware pin
 classification
Date: Thu, 17 Sep 2026 21:03:39 +0200
Message-ID: <20260917190339.3239476-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: dyRiSp5Fw5Dkac4qggGKohdG1ndTiWJ_BGICi9r9bsw_1789671829
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

When the number of CGU pins reported by firmware does not match the
static pin table for the device, the driver falls back to the generic
pins added by commit 6e58c33106220c ("ice: fix crash on probe for DPLL
enabled E810 LOM"), named "0" to "15". The same labels are used for
inputs and outputs, so a PIN_ID_GET lookup by board label fails with
"multiple matches" for any index present on both sides and userspace
such as synce4l cannot address the pin at all. The pin type is guessed
from the current frequency and no supported frequency list is exposed.

Firmware already classifies every input pin. Get CGU Input Config
(0x0C63) returns a type field marking GPS, PHY recovered clock and
external inputs, and a capability field with the supported 1PPS and
10 MHz frequencies. The driver discards both, ice_dpll_pin_state_update()
passes NULL for them.

Use them in the generic path. Inputs become GNSS-<n>, RCLK-<n>, EXT-<n>,
or IN-<n> when firmware reports no kind, with the matching dpll pin type
and frequency list. An external input flagged as accepting any frequency
advertises the standard 1PPS and 10 MHz pair. Outputs become OUT-<n>.
Labels are unique across both directions and the 16 pin limit, which
existed only because of the static label table, is gone. Labels that
happened to be unique before, indexes above the smaller of the two pin
counts, change as well.

On an E810-C timing board firmware reports the C827 recovered clock
inputs as PHY, the SMA inputs as external with 1PPS and 10 MHz, and the
GNSS input as GPS with 1PPS, matching the static table for that board.
A vendor board with 8 inputs and 15 outputs, which takes the generic
path today, gets addressable and correctly typed pins instead of
ambiguous numbers. The DPLL registration on such boards is fixed by
"ice: DPLL init fixes for E810 timing boards" on iwl-net, this patch
is independent of it.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c   | 72 +++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_dpll.h   |  2 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 31 +++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
 4 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 81bb32d2b23012..6e3e8fa94a3823 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -4284,10 +4284,60 @@ static void ice_dpll_phase_range_set(struct dpll_pin_phase_adjust_range *range,
 	range->max = phase_adj;
 }
 
+/**
+ * ice_dpll_init_info_pin_generic_input - describe a generic input pin
+ * @pf: board private structure
+ * @pin: pin to describe
+ *
+ * Derive the pin type, board label and supported frequencies from the pin
+ * classification reported by firmware.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - AQ failure
+ */
+static int
+ice_dpll_init_info_pin_generic_input(struct ice_pf *pf, struct ice_dpll_pin *pin)
+{
+	u8 type, caps, num;
+	const char *kind;
+	int ret;
+
+	ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, NULL, &type, &caps,
+				       NULL, NULL, NULL);
+	if (ret)
+		return ret;
+
+	if (type & ICE_AQC_GET_CGU_IN_CFG_TYPE_GPS) {
+		pin->prop.type = DPLL_PIN_TYPE_GNSS;
+		kind = "GNSS";
+	} else if (type & ICE_AQC_GET_CGU_IN_CFG_TYPE_PHY) {
+		pin->prop.type = DPLL_PIN_TYPE_MUX;
+		kind = "RCLK";
+	} else if (type & ICE_AQC_GET_CGU_IN_CFG_TYPE_EXTERNAL) {
+		pin->prop.type = DPLL_PIN_TYPE_EXT;
+		kind = "EXT";
+		if (caps & ICE_AQC_GET_CGU_IN_CFG_FLG1_ANYFREQ)
+			caps |= ICE_AQC_GET_CGU_IN_CFG_FLG1_1PPS_SUPP |
+				ICE_AQC_GET_CGU_IN_CFG_FLG1_10MHZ_SUPP;
+	} else {
+		pin->prop.type = pin->freq == ICE_DPLL_PIN_GEN_RCLK_FREQ ?
+				 DPLL_PIN_TYPE_MUX : DPLL_PIN_TYPE_EXT;
+		kind = "IN";
+	}
+	snprintf(pin->label, sizeof(pin->label), "%s-%u", kind, pin->idx);
+	pin->prop.board_label = pin->label;
+	pin->prop.freq_supported =
+		ice_cgu_get_pin_freq_supp_by_caps(caps, &num);
+	pin->prop.freq_supported_num = num;
+
+	return 0;
+}
+
 /**
  * ice_dpll_init_info_pins_generic - initializes generic pins info
  * @pf: board private structure
- * @input: if input pins initialized
+ * @input: if we are initializing input pins
  *
  * Init information for generic pins, cache them in PF's pins structures.
  *
@@ -4298,13 +4348,10 @@ static void ice_dpll_phase_range_set(struct dpll_pin_phase_adjust_range *range,
 static int ice_dpll_init_info_pins_generic(struct ice_pf *pf, bool input)
 {
 	struct ice_dpll *de = &pf->dplls.eec, *dp = &pf->dplls.pps;
-	static const char labels[][sizeof("99")] = {
-		"0", "1", "2", "3", "4", "5", "6", "7", "8",
-		"9", "10", "11", "12", "13", "14", "15" };
 	u32 cap = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
 	enum ice_dpll_pin_type pin_type;
-	int i, pin_num, ret = -EINVAL;
 	struct ice_dpll_pin *pins;
+	int i, pin_num, ret = 0;
 	u32 phase_adj_max;
 
 	if (input) {
@@ -4319,12 +4366,9 @@ static int ice_dpll_init_info_pins_generic(struct ice_pf *pf, bool input)
 		phase_adj_max = pf->dplls.output_phase_adj_max;
 		pin_type = ICE_DPLL_PIN_TYPE_OUTPUT;
 	}
-	if (pin_num > ARRAY_SIZE(labels))
-		return ret;
 
 	for (i = 0; i < pin_num; i++) {
 		pins[i].idx = i;
-		pins[i].prop.board_label = labels[i];
 		ice_dpll_phase_range_set(&pins[i].prop.phase_range,
 					 phase_adj_max);
 		pins[i].prop.capabilities = cap;
@@ -4332,12 +4376,16 @@ static int ice_dpll_init_info_pins_generic(struct ice_pf *pf, bool input)
 		ret = ice_dpll_pin_state_update(pf, &pins[i], pin_type, NULL);
 		if (ret)
 			break;
-		if (input && pins[i].freq == ICE_DPLL_PIN_GEN_RCLK_FREQ)
-			pins[i].prop.type = DPLL_PIN_TYPE_MUX;
-		else
+		if (!input) {
+			snprintf(pins[i].label, sizeof(pins[i].label),
+				 "OUT-%u", pins[i].idx);
+			pins[i].prop.board_label = pins[i].label;
 			pins[i].prop.type = DPLL_PIN_TYPE_EXT;
-		if (!input)
 			continue;
+		}
+		ret = ice_dpll_init_info_pin_generic_input(pf, &pins[i]);
+		if (ret)
+			break;
 		ret = ice_aq_get_cgu_ref_prio(&pf->hw, de->dpll_idx, i,
 					      &de->input_prio[i]);
 		if (ret)
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 103ba3e490682c..2360d920eb9ed8 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -6,6 +6,7 @@
 
 #include "ice.h"
 
+#define ICE_DPLL_PIN_LABEL_LEN		16
 #define ICE_DPLL_RCLK_NUM_MAX	4
 #define ICE_DPLL_TXCLK_NUM_MAX	2
 #define E825_EXT_EREF_PIN_IDX	0
@@ -83,6 +84,7 @@ struct ice_dpll_pin {
 	bool active;
 	bool hidden;
 	enum ice_e825c_ref_clk tx_ref_src;
+	char label[ICE_DPLL_PIN_LABEL_LEN];
 };
 
 /** ice_dpll - store info required for DPLL control
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751b5..2ee6a720bd8929 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -6059,6 +6059,37 @@ ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8 *num)
 	return t[pin].freq_supp;
 }
 
+/**
+ * ice_cgu_get_pin_freq_supp_by_caps - get supported frequencies from pin caps
+ * @caps: input pin capability flags from Get CGU Input Config
+ * @num: number of returned frequencies
+ *
+ * Return: array of supported frequencies, NULL if no fixed frequency is
+ * advertised.
+ */
+struct dpll_pin_frequency *
+ice_cgu_get_pin_freq_supp_by_caps(u8 caps, u8 *num)
+{
+	bool pps = caps & ICE_AQC_GET_CGU_IN_CFG_FLG1_1PPS_SUPP;
+	bool mhz = caps & ICE_AQC_GET_CGU_IN_CFG_FLG1_10MHZ_SUPP;
+
+	if (pps && mhz) {
+		*num = ARRAY_SIZE(ice_cgu_pin_freq_common);
+		return ice_cgu_pin_freq_common;
+	}
+	if (pps) {
+		*num = ARRAY_SIZE(ice_cgu_pin_freq_1_hz);
+		return ice_cgu_pin_freq_1_hz;
+	}
+	if (mhz) {
+		*num = ARRAY_SIZE(ice_cgu_pin_freq_10_mhz);
+		return ice_cgu_pin_freq_10_mhz;
+	}
+	*num = 0;
+
+	return NULL;
+}
+
 /**
  * ice_cgu_get_pin_name - get pin's name
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 16b1988e993d2f..c59d9488b52220 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -367,6 +367,8 @@ int ice_cgu_get_num_pins(struct ice_hw *hw, bool input);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
 struct dpll_pin_frequency *
 ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8 *num);
+struct dpll_pin_frequency *
+ice_cgu_get_pin_freq_supp_by_caps(u8 caps, u8 *num);
 const char *ice_cgu_get_pin_name(struct ice_hw *hw, u8 pin, bool input);
 int ice_get_cgu_state(struct ice_hw *hw, u8 dpll_idx,
 		      enum dpll_lock_status last_dpll_state, u8 *pin,
-- 
2.55.0

