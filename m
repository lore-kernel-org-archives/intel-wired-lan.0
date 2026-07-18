Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D45C44520
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 15:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5458180CED;
	Mon, 20 Jul 2026 15:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9KGh2LtE54h; Mon, 20 Jul 2026 15:21:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8345F80D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784560916;
	bh=XIwRmPJyHTglY/geaE+jR8d2MvoV2i3YMT3lvluIPbw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=3SotUCivOA+MA0DNZQICheOV9vgsmh8mOad0AlDalOOZKeXzyT1J4FnFzS8pQGMGt
	 v8GPoLi4amCa3sAv+p7rmvW+Na6Y0qs3aSFA8jpzUjNaMxjPyL+eKGnYDgutkdQ3vN
	 2iYM1X5nIYNe/3jse21F7a9Y4+1BJ4WsMmPwMIAspF1iYQ3jWytapwGjL/vDXf99Ey
	 PVktu3rNdRW6sbYNtTiShsSjr97HkO2wGplX3sxOgVbzr0qaON+TLFj0FIT3y7WXFQ
	 EikPK/AdAT2c1BtRWSlZ7pGKfHoIshwLH6fxDBd4VO0gfSEqZmQXRdZu+p8n17o+w4
	 Q6usTL2IM24Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8345F80D21;
	Mon, 20 Jul 2026 15:21:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2376E206
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 16:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C0CC4008C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 16:53:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ST3zvqe7ylw for <intel-wired-lan@lists.osuosl.org>;
 Sat, 18 Jul 2026 16:53:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=paweldembicki@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0F2EC40076
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F2EC40076
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F2EC40076
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 16:53:40 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so583736766b.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jul 2026 09:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784393619; x=1784998419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XIwRmPJyHTglY/geaE+jR8d2MvoV2i3YMT3lvluIPbw=;
 b=ePA7O63BWODe0SFBDVFmOZ6SZuoONZczQ08/Qc2ULztuA+Y7vR2ttG49Ss4isZ6fEb
 evYgxnozkKk5c0bztiVI12SLH8F5FYF1bmjD5VY5uN5+8iYgVG51VxFH6vjbjj58xzsH
 yOj7JJfooNlSJXkoVudcDqo5T+WUIM0rR+Y4QdNP9RYp2+lwiJgGPpnZnCQQxlqoqGvK
 2ChSX+5HOXSGFDpIjxPRf/a7OkAxsPA6+YPwjo1N/VvlvHH5AltTYJpwssTpF6n/cfs1
 p5V1WiyVoXvw3oytKYjDtgKvIO+qQ6jCx1O9QVTTHIZEpQ/ulsMMFL7cWdXWHLyPvsCX
 oGFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTSJ+l+QJ4rmlyeRWKskSXU4aBsBGkzfG2tHTmiKJJqkBYIBauLaZH9J3tBqKEK4sXNpzdYcStuK4mKOWnhdA=@lists.osuosl.org
X-Gm-Message-State: AOJu0YxLcYNuvH9Ky7O0tbIncTJC9+jYedA7eiVwgWwrRDfJhm5x8NFs
 IG03QZdQSU7F5YpifcHRvM2K/asNbQC2QAQLu7k0pBL2XgqNeFsHOUyy
X-Gm-Gg: AfdE7cmTuKExWUgyq9JNrrglrEjUWgR/fFvyox1rGeKchrPbxP7auajTCDw61vpdovJ
 UxUEoP3mp0OKIZsubqedMMRgek3Zz+bc9w2qsFOOhYOLHJPuLQzPah4+01G2mvU5rfXkM4RfwkH
 H3jR4v+jeUi4b4f327FjFRjqQSkkb9NmfeZxTxr/HYvNirTEwpTJWTAx3l5ejbvqcffSwTbDB7d
 2Ma5PiZ31+V7sg+RKnoYvF104RN/ZkEquQYjJlMDJjo1yFnFEFPhthMK2ySBhHFx4M7fXMLJDD0
 3TiFlejYkAB91b1G4zFykn1AYm/OutxTooBFGFNQyCyFaEXelOFi0DGiY0gYKkSiOe0m85NuQD9
 l7bBFvNd5ZLNGvOS9k6Yt+NP95qh3vwsjXjVBQP16YFVayPeAqFv1CtLpAJHpspnQ/4QDC+EGJf
 AxW8FgaapR8/h6Lw+uaFAw+wWLRS8=
X-Received: by 2002:a17:907:6d0e:b0:c16:89e0:dce0 with SMTP id
 a640c23a62f3a-c16920d90f1mr566250066b.11.1784393618513; 
 Sat, 18 Jul 2026 09:53:38 -0700 (PDT)
Received: from tempest2.110.lan (xt27d7.stansat.pl. [83.243.39.215])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c19457d6f0fsm192197766b.36.2026.07.18.09.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 09:53:38 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Date: Sat, 18 Jul 2026 18:52:04 +0200
Message-ID: <20260718165213.3620511-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 15:21:55 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784393619; x=1784998419; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XIwRmPJyHTglY/geaE+jR8d2MvoV2i3YMT3lvluIPbw=;
 b=VOuVOncW56LhgRUZpvfsTviyYBD35DTkMTshgOmh+cECq63o9UJJywe0xeVxPpJbSC
 nbJtr0O/iOGhTLjJnwoJu/CftO7ZDMz75pgTMAIXX/e6sn8phM+Iaai8stdu7UNAffi2
 4emEBW/4nDuIPlGLmrcAe6uVZzMmYIZXlWyt0Hju2PgiCEFmPPhlxrY4QC3LnSlrl0gq
 mrOoTsWL0GmfWglXtfPLvkiUhIiXBo2STVd3WMQSms1VZItDXfO05FcXJMzatT9/vrrY
 AhD7E9l5tahW4slUzIne5XrM9d1szNaFEdnnyxnkF9IxTKREvU2Bisgqe02tDbNIGh7A
 xw/w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VOuVOncW
Subject: [Intel-wired-lan] [PATCH net-next 1/2] igb: detect M88E1112
 100BASE-FX SGMII mode
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

The M88E1112 can be strapped or EEPROM-configured to bridge SGMII
to 100BASE-FX. In this mode the driver still needs the SGMII PHY
register access path to identify the external PHY, but the MAC link
setup must follow the SERDES media path rather than copper setup.

Decode the M88E1112 MAC Control 1 mode field and switch the I210
media type and physical interface setup callback when the PHY reports
100BASE-FX mode.

The driver only observes the Marvell mode. It does not program the
88E1112 registers or its EEPROM. The board must configure it
through firmware or straps before probe.

Assisted-by: Codex:GPT-5
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c   | 12 +++++++++++-
 drivers/net/ethernet/intel/igb/e1000_defines.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 44a85ad749a4..72c42d9d6f47 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -264,9 +264,19 @@ static s32 igb_init_phy_params_82575(struct e1000_hw *hw)
 			data = FIELD_GET(E1000_M88E1112_MAC_CTRL_1_MODE_MASK,
 					 data);
 			if (data == E1000_M88E1112_AUTO_COPPER_SGMII ||
-			    data == E1000_M88E1112_AUTO_COPPER_BASEX)
+			    data == E1000_M88E1112_AUTO_COPPER_BASEX) {
 				hw->mac.ops.check_for_link =
 						igb_check_for_link_media_swap;
+			} else if (data == E1000_M88E1112_100BASE_FX) {
+				/* The driver only detects this strap/EEPROM
+				 * mode. 88E1112 register and EEPROM setup must
+				 * be done outside igb before probe/reset.
+				 */
+				hw->phy.media_type =
+					e1000_media_type_internal_serdes;
+				hw->mac.ops.setup_physical_interface =
+					igb_setup_serdes_link_82575;
+			}
 		}
 		if (phy->id == M88E1512_E_PHY_ID) {
 			ret_val = igb_initialize_M88E1512_phy(hw);
diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 7e6f9aa2d57b..25104328eae6 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -615,6 +615,7 @@
 
 #define E1000_MEDIA_PORT_COPPER			1
 #define E1000_MEDIA_PORT_OTHER			2
+#define E1000_M88E1112_100BASE_FX		0x0
 #define E1000_M88E1112_AUTO_COPPER_SGMII	0x2
 #define E1000_M88E1112_AUTO_COPPER_BASEX	0x3
 #define E1000_M88E1112_STATUS_LINK		0x0004 /* Interface Link Bit */
-- 
2.43.0

