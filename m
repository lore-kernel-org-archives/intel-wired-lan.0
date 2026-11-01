Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68A606A327
	for <intel-wired-lan@archiver.kernel.org>; Sun,  1 Nov 2026 23:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=cmqA1UML;
	dkim=pass (2048-bit key, unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=JS2D3Juj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 156B9405CC;
	Sun,  1 Nov 2026 23:47:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ygSk7RKrMgOU; Sun,  1 Nov 2026 23:47:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA022405CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793576859;
	b=LuKKX9b/Ege1cnKmWzK7MM5BBzKJRPvuY0yFpucMxsaPKV1MRB23LSQjpgT0a+XEYyUE
	 twnTZqpr79AGPP2T4eRjG57ocX6x70weviIsthvnPyVnEvJ41TzpFpJi8+HLjsjv8sWkk
	 J0jpBhDFFLus649KBKUDRNpvsWR9IUNX8ouB7s5cLXegDecnbvUy91CbwPZJe94DYykkK
	 x8E7E5+I+DMhIk3Ltpy6A3yYSM4P00AhkrYhy5jvVYvEBb+kOk15p1XGIocMJ8CpJU7Ki
	 /RvlfHYZEB3reUBJCRURnQzw0jraJxtxR+leWKdEWCccVKkcZNKIZBFeNWTKakfTN0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793576859;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VjEByB41Ih4tgNv6S4Ay7vXpDo2JBFqNUNi+LJeYuq8=;
	b=fnoRz0wcMRPMiW/Mj/Y4jeMAexXzwjvJQ7Z7rMm7Z1781ZqmdEtPCPRMNEo3d2RiXb25
	 29mOV5aCTPVu3b4R4lJ0yDLKFqgMQVl8q50xQ9x1eLt+J/K1QBHsTZv/4NHI/qkrM+Rfd
	 H+E3ZFEHXF2/aAZ7t1f95uBSUjOH3VCZd04qQrWhYVUgEAZH4TNw87duiYqo0SlavrnQX
	 gZcvM7yt0YI3h6r1CY6LAsBdENGq2+Sg8Qv1rKcRNwh06/mBDduW5kfbjLPXZxzTI6DUh
	 gmcPYjfSGcYfuIkuHrU6McxUconndBdik1BSHQX37LjmBI3iFg/aMJPCNG9PzaRu4Pw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=korea.ac.kr;
	dkim=pass header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=JS2D3Juj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793576859;
	bh=VjEByB41Ih4tgNv6S4Ay7vXpDo2JBFqNUNi+LJeYuq8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cmqA1UMLBKSGUrm53eyaI+9HjSaGTc4wh6MTJ6G1fLjqGpq/u4+Shvra9RP373W2Y
	 WhwH57T7rgavJyQ0DEXf3EPvb/eqf9xCaNnyJ29By137Ke6XwPve5Ci5NupY2bw6oT
	 kITIeVLUa7cps3n2uf2LM97kUj+zOoFuP99MO1NYnP/oaHDUKeGhALIQP8Vh7xGYzF
	 0H4ONi+z2gqKl/O0R0VwDbD3HpDoPynsGVX0eCqRh5jBLFchJ+VogBv/PVxoYFOvif
	 E98OZiycqB050zE6ECdXqclxeP70PQXM2o1jx8fgB1o/LE93BEOzsDhjIVq9YtkopU
	 tanlUdw636ggA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA022405CF;
	Sun,  1 Nov 2026 23:47:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 940D4435
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 23:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85663405CF
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 23:47:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4DeNdCqhlcl for <intel-wired-lan@lists.osuosl.org>;
 Sun,  1 Nov 2026 23:47:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 727FE405CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793576855;
 b=RlrcgoWsRr2tl7F6qZltcj1ACaiRvxLrKcmycsX9c+vs8tScKWmlBWzqMx1fQkQCVy2M
 TA9qeAhdpTGMunKuFR25ShZnQzLaeyU0p7+POPLMnfY9GkMDKmnss2uB+QvwdRGeghpFY
 5+Zmi5rqMiHbBhoAe+Wj2XJ5Fgfm2w4W1E6KRFBoJDAibkEDTyrdfKnMmLOKAJX1fBFMv
 34uEm3h1rk9/14G2JBHK48GVYWiiie/vUImtj+6Ld2a35zzlzr1Ulsv4ifqzHQTwg1d7k
 f7dLWZ6VJ+zqB6dY6Ald69L2pY9PnWmU8CtkYBkdbhngLze/lRk1yQRsLvumvNiXwDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793576855;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=VjEByB41Ih4tgNv6S4Ay7vXpDo2JBFqNUNi+LJeYuq8=;
 b=hMV7dIYw3B0lVNKcytWhsZTUkbH0bZeR2+jGROXKJVcTY0w73+uB5ST029yDovEFdJwX
 jg1NI/xzCEyQ5JCnerRehwie7fIIlorc1eI2nyekOxxeDDevW0wo+brXYCrnqFLnY/OE9
 f4Dvno2uH177Mj2woPBRVLFUmjqLXMLZLJBZt+OYoWx+C7I+p4MymtgzaIKG2yIoAvC8h
 A6u/UHs6O6rBRHkU6qyYWEABPxfWyXNLvxwwrTZHAeo5yXgb6n4ax+ZttuLmDiupa5GFh
 NqTXm4MxBIKq+tJM/IYwUJbH5Oa69GEV/HnR/OhkvGviFf4hdTYy9HTVxbB6/+EcZuA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=korea.ac.kr;
 dkim=pass header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256
 header.s=google header.b=JS2D3Juj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=ingyujang25@korea.ac.kr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256
 header.s=google header.b=JS2D3Juj
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 727FE405CC
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 23:47:32 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso26352567b3.0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 01 Nov 2026 15:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=korea.ac.kr; s=google; t=1793576851; x=1794181651; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VjEByB41Ih4tgNv6S4Ay7vXpDo2JBFqNUNi+LJeYuq8=;
 b=JS2D3Juj3IWdlZhh3y1S8ycMNyOTplN8qpmA+WUISeSODMsg1bypMSTGeWwoqIMY1D
 bKUpvmxFSxzQT1u4XAZEKJhzaovWGvPObOSCCyMbyC8gL64s+qsRkS5n1309mEeQQ6Yu
 IKbAb6haiziYjAuAZvq5doiBWzIbufVxkXr0Ggi175Q3pLyonL83z/6JNaYhIe8jJ59P
 Pcxe3jEclQBKz+ZY2jIXua4qCKf5Qy3/W2NXyydscq1YeSEZmwDqiaouilPHhuk2KQmA
 4u7GelbTg56ckfMjCS52HgnXV8klOQ0Rot894M3CO2D4UbAoNEmnH6ygxcTpXvFT4z/Z
 sbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793576851; x=1794181651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VjEByB41Ih4tgNv6S4Ay7vXpDo2JBFqNUNi+LJeYuq8=;
 b=wTne4MgKfT5K9YPv4zrPd29rBPpXZjVlM+mcsTXZpLbKoaQseSr1sYQtpN65PIi7NB
 drE+PcCP3b00GStffvGtKR5AfWoBAAa3nOUH7tj7OxnWQUpwQCfNprKJr/fKzDw1kG8p
 8B05i6mBqgwSdAysbNibPLnRq0/2L9EiaCCppCxPzz0YwFJvIW7qcpmjHbC8KdPrdapj
 KbVACxAFkVnJerv8R2RekfPOsqguRU/OyMmvlEfSbF/+h27W4WC/5k3MBywTOqDoXIBI
 qfvD3X6UBOoMy9C7NZWFVhmB5R3mCxtEEdLXgVMFlNVbnb7Kx++0jARVusBQldsN4w4o
 0lIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSFTJ2qfBnD/msodm63pHieKm7yFHkdPEcnKOgTTrdKQIzMq46QKzSO42bzl+9A3MPG7rHPC/RnYidEXGXF+o=@lists.osuosl.org
X-Gm-Message-State: AFq9FYIKhuBUj8HiG1X+KCWti8eyrXCZnj396hIxQz4ZmeZOpndrA8lq
 InRMQwkDliwea5XLhakcOibCvaLUD+isCz4K241ECUjwyl3n/keLBuGc9jcFGOfjYQ==
X-Gm-Gg: AYBFou0B0wXnJTrCDElz91/5Jn2NdrtaIvaW84k0DrVdFD0uPsF6SgxqMhsu/eJitxN
 9YuvzfcmyX+KCeyrwrHRUiRAoouIEer0vDLOiAGcLZg2WZ1y5dq44ojk7a6yBb4aXo0MGWb9NGa
 OTAuLUreIW0T0O0YP4g9qEp7qzmaGg6lWXxUDNUx5m2dmNGVI404wh6LPJ6ItW7uEvJ6wZq17CD
 HDQAzuVNIL6JWHpR/nNH87SMVfbmsbAtDOTZfoanrVWLNa8YxPS7VuXK2U4aT7X8cGuHJoHVtdN
 RqMFMttjpnVHNALHnjwRJntyYwvtRXAVO7EZRy/ZkokvzAJmd2KJRbbv0ngQx3tvgmYeo35ysCf
 RXpSTAyFs5lQFEOvwsOW1EXUOXlkZYGGacJ66lIX7b+PvHoN6HNR9Js0LyiDpXrnObuJ02FTk7O
 yyRRNaR9oV76E9N6Ci0f0FBCA8QKy3AFsfmzeQytfK2JHIGY6kAR2KuWvxAZ10Fl7ZA0TLsVlaW
 Tdj5K0RegCMwoGrTnBDX2wXEfMH29METjCIVo7kC+Ova1yovhoG9zt/DNPOwiOsGhAolwOZ
X-Received: by 2002:a05:690c:e1cd:20b0:873:5c7b:c13a with SMTP id
 00721157ae682-8b1c68bc542mr54116897b3.34.1793576851220; 
 Sun, 01 Nov 2026 15:47:31 -0800 (PST)
Received: from s2lab05.. ([163.152.163.130]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71bd543sm43987527b3.45.2026.11.01.15.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 15:47:30 -0800 (PST)
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [PATCH iwl-next] ixgbe: make EEPROM init_params() return void
Date: Mon,  2 Nov 2026 08:47:25 +0900
Message-Id: <20261101234725.1414173-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All implementations of the EEPROM init_params() operation always
return 0, so the error checks on its return value in ixgbe_sw_init()
and the E610 NVM helpers never trigger.

Make init_params() return void and remove the dead checks.

Link: https://lore.kernel.org/all/8524c812-b659-4670-b370-35682aba2d2f@intel.com
Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |  4 +--
 .../net/ethernet/intel/ixgbe/ixgbe_common.h   |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 29 +++++--------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 +---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  4 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |  4 +--
 9 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 3ea6765f9c5d8..ab2c0818f2417 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -857,7 +857,7 @@ int ixgbe_led_off_generic(struct ixgbe_hw *hw, u32 index)
  *  Initializes the EEPROM parameters ixgbe_eeprom_info within the
  *  ixgbe_hw struct in order to set up EEPROM access.
  **/
-int ixgbe_init_eeprom_params_generic(struct ixgbe_hw *hw)
+void ixgbe_init_eeprom_params_generic(struct ixgbe_hw *hw)
 {
 	struct ixgbe_eeprom_info *eeprom = &hw->eeprom;
 	u32 eec;
@@ -895,8 +895,6 @@ int ixgbe_init_eeprom_params_generic(struct ixgbe_hw *hw)
 		hw_dbg(hw, "Eeprom params: type = %d, size = %d, address bits: %d\n",
 		       eeprom->type, eeprom->word_size, eeprom->address_bits);
 	}
-
-	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
index 6639069ad5283..8d4fd9074938b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
@@ -25,7 +25,7 @@ int ixgbe_led_on_generic(struct ixgbe_hw *hw, u32 index);
 int ixgbe_led_off_generic(struct ixgbe_hw *hw, u32 index);
 int ixgbe_init_led_link_act_generic(struct ixgbe_hw *hw);
 
-int ixgbe_init_eeprom_params_generic(struct ixgbe_hw *hw);
+void ixgbe_init_eeprom_params_generic(struct ixgbe_hw *hw);
 int ixgbe_write_eeprom_generic(struct ixgbe_hw *hw, u16 offset, u16 data);
 int ixgbe_write_eeprom_buffer_bit_bang_generic(struct ixgbe_hw *hw, u16 offset,
 					       u16 words, u16 *data);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 4d8ae5b56145a..eb20ef11f890b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -2267,17 +2267,15 @@ int ixgbe_enter_lplu_e610(struct ixgbe_hw *hw)
  *
  * Initialize the EEPROM parameters ixgbe_eeprom_info within the ixgbe_hw
  * struct in order to set up EEPROM access.
- *
- * Return: the operation exit code.
  */
-int ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw)
+void ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw)
 {
 	struct ixgbe_eeprom_info *eeprom = &hw->eeprom;
 	u32 gens_stat;
 	u8 sr_size;
 
 	if (eeprom->type != ixgbe_eeprom_uninitialized)
-		return 0;
+		return;
 
 	eeprom->type = ixgbe_flash;
 
@@ -2289,8 +2287,6 @@ int ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw)
 
 	hw_dbg(hw, "Eeprom params: type = %d, size = %d\n", eeprom->type,
 	       eeprom->word_size);
-
-	return 0;
 }
 
 /**
@@ -3681,11 +3677,8 @@ int ixgbe_read_ee_aci_e610(struct ixgbe_hw *hw, u16 offset, u16 *data)
 {
 	int err;
 
-	if (hw->eeprom.type == ixgbe_eeprom_uninitialized) {
-		err = hw->eeprom.ops.init_params(hw);
-		if (err)
-			return err;
-	}
+	if (hw->eeprom.type == ixgbe_eeprom_uninitialized)
+		hw->eeprom.ops.init_params(hw);
 
 	err = ixgbe_acquire_nvm(hw, LIBIE_AQC_RES_ACCESS_READ);
 	if (err)
@@ -3714,11 +3707,8 @@ int ixgbe_read_ee_aci_buffer_e610(struct ixgbe_hw *hw, u16 offset,
 {
 	int err;
 
-	if (hw->eeprom.type == ixgbe_eeprom_uninitialized) {
-		err = hw->eeprom.ops.init_params(hw);
-		if (err)
-			return err;
-	}
+	if (hw->eeprom.type == ixgbe_eeprom_uninitialized)
+		hw->eeprom.ops.init_params(hw);
 
 	err = ixgbe_acquire_nvm(hw, LIBIE_AQC_RES_ACCESS_READ);
 	if (err)
@@ -3747,11 +3737,8 @@ int ixgbe_validate_eeprom_checksum_e610(struct ixgbe_hw *hw, u16 *checksum_val)
 {
 	int err;
 
-	if (hw->eeprom.type == ixgbe_eeprom_uninitialized) {
-		err = hw->eeprom.ops.init_params(hw);
-		if (err)
-			return err;
-	}
+	if (hw->eeprom.type == ixgbe_eeprom_uninitialized)
+		hw->eeprom.ops.init_params(hw);
 
 	err = ixgbe_nvm_validate_checksum(hw);
 	if (err)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 2cb76a3d30ae6..2bc1210756fe1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -58,7 +58,7 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw);
 int ixgbe_setup_eee_e610(struct ixgbe_hw *hw, bool enable_eee);
 int ixgbe_set_phy_power_e610(struct ixgbe_hw *hw, bool on);
 int ixgbe_enter_lplu_e610(struct ixgbe_hw *hw);
-int ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw);
+void ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw);
 int ixgbe_aci_get_netlist_node(struct ixgbe_hw *hw,
 			       struct ixgbe_aci_cmd_get_link_topo *cmd,
 			       u8 *node_part_number, u16 *node_handle);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f91856498eb2d..b337e2d4cf1c3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7058,10 +7058,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	adapter->tx_work_limit = IXGBE_DEFAULT_TX_WORK;
 
 	/* initialize eeprom parameters */
-	if (hw->eeprom.ops.init_params(hw)) {
-		e_dev_err("EEPROM initialization failed\n");
-		return -EIO;
-	}
+	hw->eeprom.ops.init_params(hw);
 
 	/* PF holds first pool slot */
 	set_bit(0, adapter->fwd_bitmask);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index a461b6542f96b..48a74c89a799c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3476,7 +3476,7 @@ struct ixgbe_hw;
 
 /* Function pointer table */
 struct ixgbe_eeprom_operations {
-	int (*init_params)(struct ixgbe_hw *);
+	void (*init_params)(struct ixgbe_hw *hw);
 	int (*read)(struct ixgbe_hw *, u16, u16 *);
 	int (*read_buffer)(struct ixgbe_hw *, u16, u16, u16 *);
 	int (*write)(struct ixgbe_hw *, u16, u16);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index e67e2feb045b3..d77c6efd800f2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -191,7 +191,7 @@ int ixgbe_start_hw_X540(struct ixgbe_hw *hw)
  *  Initializes the EEPROM parameters ixgbe_eeprom_info within the
  *  ixgbe_hw struct in order to set up EEPROM access.
  **/
-int ixgbe_init_eeprom_params_X540(struct ixgbe_hw *hw)
+void ixgbe_init_eeprom_params_X540(struct ixgbe_hw *hw)
 {
 	struct ixgbe_eeprom_info *eeprom = &hw->eeprom;
 
@@ -210,8 +210,6 @@ int ixgbe_init_eeprom_params_X540(struct ixgbe_hw *hw)
 		hw_dbg(hw, "Eeprom params: type = %d, size = %d\n",
 		       eeprom->type, eeprom->word_size);
 	}
-
-	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
index 6ed360c5b605b..282d10b7d4733 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h
@@ -19,6 +19,6 @@ int ixgbe_blink_led_stop_X540(struct ixgbe_hw *hw, u32 index);
 int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask);
 void ixgbe_release_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask);
 void ixgbe_init_swfw_sync_X540(struct ixgbe_hw *hw);
-int ixgbe_init_eeprom_params_X540(struct ixgbe_hw *hw);
+void ixgbe_init_eeprom_params_X540(struct ixgbe_hw *hw);
 
 #endif /* _IXGBE_X540_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 4a0ccbf448a2a..a8d300e3f471a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -629,7 +629,7 @@ static int ixgbe_fc_autoneg_fw(struct ixgbe_hw *hw)
  *  Initializes the EEPROM parameters ixgbe_eeprom_info within the
  *  ixgbe_hw struct in order to set up EEPROM access.
  **/
-static int ixgbe_init_eeprom_params_X550(struct ixgbe_hw *hw)
+static void ixgbe_init_eeprom_params_X550(struct ixgbe_hw *hw)
 {
 	struct ixgbe_eeprom_info *eeprom = &hw->eeprom;
 
@@ -648,8 +648,6 @@ static int ixgbe_init_eeprom_params_X550(struct ixgbe_hw *hw)
 		hw_dbg(hw, "Eeprom params: type = %d, size = %d\n",
 		       eeprom->type, eeprom->word_size);
 	}
-
-	return 0;
 }
 
 /**
-- 
2.34.1

