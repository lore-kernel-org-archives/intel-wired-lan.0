Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465ACC79F99
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 21:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C7AB6068A;
	Mon,  7 Sep 2026 21:54:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eQGirvrqsE7B; Mon,  7 Sep 2026 21:54:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 80AB9606A3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788818090;
	b=fAVUX/pdVYDATxQ5sObbkmcDXH511aOm9Rxx1LKgWxyolKzfcuuytuP7mhxbgANPswC6
	 B4/+Sr5zqf95PjzwOVydHMgKbuf5ULF59cxu8jRGmNoQJ8r41BXPhZwYqWjxYKqQqm6Hc
	 pbrm/uomLXcKrL1pCPok1kcltxiQH4l7ZI3h71v9Vs98SOgaLVJ6nI0B/1c5DPlT1KamV
	 BYt3i8jodvQMjlS8smvYQR62Uf496LIQMFNrIo17Iar0AQEb263Qvhm+FUAvxbgG8EYGs
	 NshKUb+95NahLPSvGP1vPou6SUr9isEyCIzi9Dejwyr5o/gtG3HAW8VIFd7fBcNSDMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788818090;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+yLPkFJQmuAEoKFXhrbZigHnjiojakFwcy+wMysCsSc=;
	b=QNxd8qzCJaJLtlWFbOjNHj5cWZwMqs5v7akAfErupo9V068bChKb+cunb92oOwLrC0/M
	 n6LANCyxS2VxhGpM4dJLy4q8llHPSNPaCm0H4EWOYmBrlmqk53TjPK2DwxUtRpgmSoCNU
	 u07fM1ht3iVkGv4L45HTrWsQbzvMFfNs+9/c/6oHzJMP8PkRvQD43+ANATARQcyLl8pFg
	 nkDvrZTp6DB4JCFRzR8nCImlXFbUkM6DKjDmZ083drJHVfBlLSlZbHqbNbi7ZVZ7Sc3jD
	 v9LREpMUpRvwQgpaUD8j4m5ju6AXjpc2Cys7HxhXb7bavNlhV/0sXAjyjBG4i86VQoQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788818090;
	bh=+yLPkFJQmuAEoKFXhrbZigHnjiojakFwcy+wMysCsSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8we4HmFW2sFIIi2kDthSyS/AKx5SBHjDBz+PtgZtlmbXaOfN2PpHKohBhojSESKa6
	 35lIoD0JqfRgUJply+lyq8vwevpxPrLnkvWt3Eh6RQuwxVW2tvByfFpaM/pSkpjK83
	 FnnZvuNqx3AK6zhhdNQPM2j4vjD3SgbUhfqWLYsKh5tm2E8zlNTo6qqtb0IOyg3A1N
	 3y+v/MwkQ3VNFVOGP4NXJDgY+Ovwu+QA21GT64PbGjcDbxE32I8KA09/dKX8DQvO8B
	 pW3yZVUOK9gjwUEx5TWlhOQCWkeO/XqKqHMLbsdQDIhYdETIOwWuAgBCA7j32+Ko+X
	 IKQPErmnlSBAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80AB9606A3;
	Mon,  7 Sep 2026 21:54:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C821D230
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9EE540099
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SnKoH7ymAriY for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 21:54:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E7A004005A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788818087;
 b=sQO21WeU9qjjWdCjVAHL2F2XiWp3Ks+/7TI9jD2ZWadOMVD93UjE/MNNNax0TDHJi+6X
 13vrm5JZ2albPtfloE9iImatriNJdm89Xiv9n/VrM2EtXDW+UKMqkUDhAU4QPkXxcGmRt
 KzXOipTW/3tXVOWxIEJzf2o6TQuT10iyl1trzqppPnrq69JA4dc5bHqDnhBim59HbBY9S
 x4u0hAZa1lRrDzoI62s9WwEiQbjDGynAg5FF79rmfCPXUN80HbnFsWyz4C+D/iytZG3de
 2SgzdHK0QBtWGCmkjHR4hKRHfIwIyeyvcCOVYyeYyGtpNFhT2nooa9X8jhVTD9QC5dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788818087;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=+yLPkFJQmuAEoKFXhrbZigHnjiojakFwcy+wMysCsSc=;
 b=pAREKk5k1BeY7xOPC1gRgh9UbqfiMla9939ZpXG3Dy7Wl1GyqmccvacSeEWBdNR5Oaw8
 XvTP8SgFa+V/MRVlsnhhDg30i+ocGI6EaInaBfTdsESfmHCbl9rut6OR+jfFcBCCcKEvq
 y3whlymaDWTHl+BFws7COWMAPbY06hNb+j6REFSTtvAioWNkt+hu+a4bq2Z/qOzUZR6Y4
 dujskv9eyJHmatw9oa3aCUQ0S4Vs9IZWTtIXdx+mU2ACzV9jjMAo2pLOWMDgXeSApPO1Z
 AOJ00iuVW/XtXAJZ5Sk9wPfKQKQ6J9ZFMuVSdwk3Ldmuohv3YNPINiHKEqM5+2ZfZYw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PbwGj3Vf; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PbwGj3Vf
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7A004005A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:46 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8726acc5eadso26725907b3.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788818085; x=1789422885; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+yLPkFJQmuAEoKFXhrbZigHnjiojakFwcy+wMysCsSc=;
 b=PbwGj3VfpH3sprHls+XYgABP7qLcFr4IvIhPLbgayoJ4d4qTIbuyp5UzjR32GkvdCV
 yee1W/bweliu6Tje2d1dnQPjp1ZJxsIIeObKbOgftvJXLNEkLa6KwXqbqSIPR/GLuIuF
 qvrAAgCFCkAbSXQbquq49fbx6+6h0nN8EEwzo9CFikzThMMYCApFhjmkPiZkXPMfhr3x
 glwfjQvHw266JccIamFTG8xFcQGurwIA2NVf9bDfZRmIul1mCBT/GnoZz0FmMrwSmTQr
 a/1BwbkAI2c5iKKqZfa7R+XEYBR/ElPUiFnpRsVGpOCemUYL1xTsxIMzR6HxXyUXqGKX
 1y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788818085; x=1789422885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+yLPkFJQmuAEoKFXhrbZigHnjiojakFwcy+wMysCsSc=;
 b=WON+EbcMxQNgdUu39Fy8gHqXi3eIBAdR8i2pZ39+mn0uYpOJS+jMYHnkeSYsCdimE8
 2fOrc5IR7Mug8Ow3hJv4YzOeoHlO8aWUZ+v/xoHwGf8zlxdAJ4kyia5Mu8mE5eA6H+oe
 /Sww6E8XQ+b2ndSapoWhb7rhFx701IDaZ41FBdX52aGlTrm07el9L9RfKTZJgfv77aZu
 g4X2SsXChX57/OFzO6XzadfzFIwZq/MKEnF264ZY8mSlqjgb0ooA8XJ9pvrxfHR97i/p
 eGJJkAG9zX2AaU/H/LY9dEww2R346RBJ1orks8w+fOuk4KJSr6PXZeMpaHzRA0VCwz2Q
 8vpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwVA3eiyXaZsvomBth1bK9jU1+/DGcr7rDe6PmRi69/ldkgmDXt91/UunWlg4hZiV00tt0mIGZn1UrNfZipg4=@lists.osuosl.org
X-Gm-Message-State: AFuF++nWW9VxwnxZJ2n1qYwpC1cIjBGpRrmlnkpmLIF5kWzhiLGcThKv
 BJlac+Rdm/3pqf0wu/IMA4m+ZfiJC2mrvRCgSZx0/XCBUI6K1Q41Tzew
X-Gm-Gg: AYBFou2BWEH7er+rURSOcFL2/78gaN+rEN6OxuKmEziaVX5nisrPLgPpSdYndeiNOn/
 3Py5egABBZajQi+7lNQkycY+KZCD0t9JyUQkXMfcXLwJYEAzTtb2L4dDH5/VLkxFOt+niPg6wdR
 kYupJJY8MSyztYha53Jn27Ob3nlBawh2tHlelEJewUTXOQ/NnXDThykIumOp2fnoqhvtN9MhRFN
 sm3QrkCVlI8La0n7dUKXWMmnhZ5y9fUMB67FiYFMPjbGtOLW0jLi0JkpxleiyRkZNilaoynV2vq
 XeRbhDfRO16kMmlAMpnDNHHsx7MeAvilJwN0RKQQl9PjgbLNieVaJfy5UKhMSTyEQ7PCGatLuAf
 4THC8VHS+gWCM8gu7jhJ+FPdjY+Hbp4SmhVRZ/xbaIaB6TUWMoycnPQy1dNF6HHkUPD1gLoDZhS
 rbNBlzZRp1/+4u3ec7yKtTXDUFHeSke+tFBHBpSpPcGzOBlN/Ms1f2ThJ7x5PBh2j4cFTE6IKgb
 IsdLQvyxn5K85FR0g==
X-Received: by 2002:a05:690c:698f:b0:81d:6af3:b9b5 with SMTP id
 00721157ae682-87125a1c600mr104053797b3.9.1788818085373; 
 Mon, 07 Sep 2026 14:54:45 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-87149315127sm78135637b3.10.2026.09.07.14.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:54:45 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Raju Rangoju <Raju.Rangoju@amd.com>,
 Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-usb@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/9] ixgbe: use linkmode_and() return value in
 ixgbe_get_eee_fw()
Date: Mon,  7 Sep 2026 17:54:33 -0400
Message-ID: <20260907215439.409858-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907215439.409858-1-ynorov@nvidia.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use the return value of linkmode_and() to determine whether EEE is
active instead of scanning the common link mode bitmap separately.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 36e43b5e88d1..a7b7f89f29e4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3751,8 +3751,7 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 	edata->eee_enabled = !linkmode_empty(edata->advertised);
 	edata->tx_lpi_enabled = edata->eee_enabled;
 
-	linkmode_and(common, edata->advertised, edata->lp_advertised);
-	edata->eee_active = !linkmode_empty(common);
+	edata->eee_active = linkmode_and(common, edata->advertised, edata->lp_advertised);
 
 	return 0;
 }
-- 
2.53.0

