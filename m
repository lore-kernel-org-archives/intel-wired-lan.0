Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FE3C531C9
	for <intel-wired-lan@archiver.kernel.org>; Sat, 25 Jul 2026 15:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7E496066F;
	Sat, 25 Jul 2026 15:11:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BrEuavSW2qDH; Sat, 25 Jul 2026 15:11:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC9A860664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784992287;
	bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xuc6Pxy4aYLSUuJCYFq7zX1yK1XPuHnu6CE8JNTDPRc/nNwUIVs69nJwnNHqsZQ16
	 zMPjYmTI8tS5eJb0p5He4+N+gvfwycPM3hM3Za6S7XAg4gBERUeotKLhpC/Snl98Eo
	 dP3Z8I5yE3WVVuRvqCD36Jomswd6wzTKm+3Al54x0hsAiYIDjEQAH6qtFHseazBXV+
	 6y9zqeuqogPTkqEDVKBjqtZlngOz8PMMlfT+Ectzr+XFAwvJLnuvX3MZSBQ/dsT73D
	 Z53uLG46DLJpKcQjNKyzt76gp9VTUa6ZecOmcFjzYhjfLqudVTUSaBT1s5xboTqmFe
	 SoCQaS9s75CGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC9A860664;
	Sat, 25 Jul 2026 15:11:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 964D8EB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 15:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 879A560664
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 15:11:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q41lnvD8_0ny for <intel-wired-lan@lists.osuosl.org>;
 Sat, 25 Jul 2026 15:11:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=ekffu200098@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CB0BD60653
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB0BD60653
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB0BD60653
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 15:11:24 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso1927270a91.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 25 Jul 2026 08:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784992284; x=1785597084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
 b=Pe3GuLDX3VfQ9vgCy1zsYW69QF6cda6uAshVnFjQrLDPdQqZkFl4Fgs0cqyv/ng83k
 wL/MLqTRjhdga4l5gpksCX+qSrbLpSmOMk3VsXKsXURrR9rOM+HdYlmz7xouPiHAw49Q
 pL2ngwZ+36XI/ZPMSVop5yCi7Daen/21T9SqK2Y55p+4Db3/QEyXj3uj3ugq/ooTMexU
 CJPNUfxxf/VdJgGSNEQvkeyujCAYO9MmThwdAuFq9klBy5UMSqGbxMSSa9C1R0HlnDil
 sYO08eY6FNiKeUmCVEBWTYAXKlZDdx6SCB7Yn/pBBoNMQO7vQZLSAMZUtkEoMfdUSomB
 BIbg==
X-Gm-Message-State: AOJu0Yypy79rUDUrwJtze9OufNH9GXulPsFGxvS6wlZvsCpNTJWPDIAK
 31v9zoyC5YAefdlIX5z9SrWH9xSH8i8HGRXMInBxmvVv1XkYD2bCrgsP
X-Gm-Gg: AR+sD10IqCi9T8pFUikn90+/MYVB4fSltS0RCBE+OBSxxCJaaHvjEMVK2NRjAiDrWf2
 PBxYI28sH3uCk8tk92D8a0rfXbDhX5VJmKtEHnOlZOEW+U5Bsy8g6v9AbPrk0A7kIpEOw/BVDdo
 AZE5Asa4r+Q7KK/AI+GKZDKM9rRF4Zkjq0/3UZxLOx42wqpYuf5cCJ73nNtDVVXF1lZ3sDmkhyw
 EL5J7R+TDLkkCOjbRPQsqG2ujmEBhCkrp2rTByQ7K8w1YydnU5krDmzicH5AnlHqKtxIjTgS5Ww
 PfzPDeoYbAN2QUygRo5+hrrZGUVt5QT55D4DTD1BR+dNwwWqJuanucy7BLiswb2rxarYs3ccsdh
 CeR5nMa+PGSylzK9w2OHxSgMaoomSFxpQBktYwEPECQoKVtxYjGzFqsIS4G0veREZJ/Z6++1D5A
 guY9DE+Sc=
X-Received: by 2002:a17:90b:4c8f:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-38f294f144fmr2785423a91.17.1784992284028; 
 Sat, 25 Jul 2026 08:11:24 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f031d1d6csm2907665a91.0.2026.07.25.08.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 08:11:23 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: kuba@kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Sun, 26 Jul 2026 00:08:52 +0900
Message-ID: <20260725150852.859188-5-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725150852.859188-1-ekffu200098@gmail.com>
References: <20260725150852.859188-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784992284; x=1785597084; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kxRvmx1wxGvV8pBQOXsif8sDMDGk8D/ZvwH0veNhWow=;
 b=Nb3gdioXCvxPBzDR0ckBinoLJ1Brp0sEvFcRjsD3tSOq1QBKBhE+HoH6OmJTVxdBTU
 cfLi0QzNAFmigFWdAvXLXNcoWtnlSQ6XyBxWCRHRtpl6cCece1sAd2QUFRbfp4jr17jx
 BQqVTYfrjzv5F2ihOArsaZPTz3ZfDqgiOSBSfvPlptpcmygHII+GBACNpR1tV1ZYn26X
 JncxjDybgtt5aclHSgLuda8ru0GHLrnMFWigAeVy1ih6/MCKPI6E0vDMzGugTRmksqxw
 oXMYQ91xnc9Hh63mhYRS188HfIKWs5EDqJOXekgsMmWNIXur8cgatTLDqwCR0HAdp5ap
 D/wQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Nb3gdioX
Subject: [Intel-wired-lan] [PATCH net-next v2 4/4] net: intel: remove
 conditional return with no effect
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

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +-------
 drivers/net/ethernet/intel/igb/e1000_i210.c | 6 +-----
 drivers/net/ethernet/intel/igc/igc_phy.c    | 6 +-----
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a56..0cd0e5597c90 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4864,16 +4864,10 @@ static void i40e_control_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
  **/
 int i40e_control_wait_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
 {
-	int ret = 0;
-
 	i40e_control_rx_q(pf, pf_q, enable);
 
 	/* wait for the change to finish */
-	ret = i40e_pf_rxq_wait(pf, pf_q, enable);
-	if (ret)
-		return ret;
-
-	return ret;
+	return i40e_pf_rxq_wait(pf, pf_q, enable);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 9db29b231d6a..784f9a7bcbed 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -756,11 +756,7 @@ static s32 __igb_access_xmdio_reg(struct e1000_hw *hw, u16 address,
 		return ret_val;
 
 	/* Recalibrate the device back to 0 */
-	ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
-	if (ret_val)
-		return ret_val;
-
-	return ret_val;
+	return hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 4cf737fb3b21..b758a7e0f013 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -675,11 +675,7 @@ static s32 __igc_access_xmdio_reg(struct igc_hw *hw, u16 address,
 		return ret_val;
 
 	/* Recalibrate the device back to 0 */
-	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
-	if (ret_val)
-		return ret_val;
-
-	return ret_val;
+	return hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
 }
 
 /**
-- 
2.43.0

