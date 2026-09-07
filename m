Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5BDC79F9E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 21:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4073E402FF;
	Mon,  7 Sep 2026 21:54:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ysr54qvtAH8U; Mon,  7 Sep 2026 21:54:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6A11D4030F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788818091;
	b=kKg3jG2dvbdeiCSMoKzPLkQIGiJEVTdxZaiGaZIABxTrT4ig0Me8hCRnTEWmBcZuZUiS
	 SQ8pHetaY8PjDKCJpC4abM54u6vXV+lr2xK+GYKZ9rNAXuqoW1rLCc09pI78MMGOXf1Cw
	 cySa5VNAhsYxLcbUb/NqbAgyiMRRuBVrg4lE+BYnjpydVPAHWzcM/SmQL8hFSMqarHpWF
	 aOxHTR63yyleCTDscd3QFB1lqIUmuIL4xLXiOclAigfuQiLBqfRZ73OgUuAJXMVQY5vj+
	 pe7qq0EDJnxe+oBESZ7lT+u3qGlcqqGxQx3YV7rEZEJQEZLXUgHu59L5dKELoW87O1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788818091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pUuTL8RKq8zctKFBGR36Xkq0F1NHQ5YoR0hZaul99pw=;
	b=emkt+m/HeDYQyq9Ue9y1xVsTa6eBUggyj2OR3v7NPzCfqp9ewGZqrfD3hyy5KZKaHnfj
	 X6KtjiPbVmiHs6xUjEsr0HuIH9GdT5lAM5hQ/26A5zbGZ5RfWuUWGwgU7NjoLPb+5L0lC
	 i0yCVCDLh5nIy8ZHSIAh1tLx9/fo37aJe12xqVTobh8a4blUYt+cenvodwToc0HAcNZ4o
	 gX+PKzoN/1X/7IbU+drUCzdgGFqGpxFbahiurYR75ysC1JaZb6c+Ntj+O1MEO3h5MieDA
	 ZMlsWdvz3vZ2l/v8IYbVKrsKgESaNt0OWTMRdfa+H9tCTM2KmyfLIF7kOH53e6jPAnw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788818091;
	bh=pUuTL8RKq8zctKFBGR36Xkq0F1NHQ5YoR0hZaul99pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z3+smAED+JynuM1g5eiPEXGfUs1cp6rDC6PvgF7ihZ+8wfHPbjXqzEJlgj2ecTuYV
	 aEp34PvbHhRBsiv5Plq4SOBwQii64Kb7Ucb7+Fu8x51f7yKgq1cksq3tibCNmtprFP
	 rF/PvphBAXnYg7e3qiMrmH8g/q+ApsWjx1HxKtTqPaYnPmxApCRPrI9iWGAgxEdLGb
	 liDleixwxC8evvlY2HgVHEexkauz2m0+SxS4Mzu7ZPFmOd+LrCDX7EVpJggJM31Z+0
	 EXSE9SnQjcgKvC9uYYn7fGRhVAVTF5sSVA7cafu9ln1yjSdbXIatZlxgv0k3ML6M8I
	 wYIxSea7HaS7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A11D4030F;
	Mon,  7 Sep 2026 21:54:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4697349D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CE8B400A4
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BXbB317q_7ev for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 21:54:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7774240099
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788818088;
 b=IWv8k1vl0J75BTS9lAG3UGZP2Q6RzCLp+1AkFSph676Q4O0LF35S228X1pmfYdavaRMI
 HdzB+NjlK39KpbRJdP4wV4B0Om1g1HrS7DVb007aYwRxNWw5V75NyabrxWcK3XaA46U1v
 MXQxzWUac6Xi0uz/LGdXjzTYxxOf/Nktdn30N03GIMQaXmnv4ZhxNkC6/ZWPDur06+q/5
 X6ijxWmaK+SKiks8OMeXdWOckapUqXVZJY2ETlV7yhi7vXNTCZJ8OLzPO3dTlsefSgUiO
 Ps081ArCekB6BM92g7RpUwoabvg42wzTglmCyrxhwsYwksb+0pagB3fxvIhaaTWE17w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788818088;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=pUuTL8RKq8zctKFBGR36Xkq0F1NHQ5YoR0hZaul99pw=;
 b=VPskFhrJAgdJPpODTOQrBnrzL+vl2YRwsVuKsMuLF/vaIlx/UWmAv3JrP8f8KcNsMt5Q
 HzM0eicylcCkGpzHp7yxyLf9CVGXZdGFa8mAm7ZbI5YAYK+ZZQnkCVaXsFOIFq5WdeJww
 QHR8WuDspYp5xAL8miMGvy4i0sp0nfZlvExQz4g8zyOFfG9zgnWYyhgxD+7MlPQHqk+qv
 ltiYCLtDDuoTyQXF1NK1QQrWrWg4I8haKofaKSNt8l9BSQXde2dtnbRGB/PjOpSdguZg/
 jBoPWzdu+TR9YTzZX2l8x/doZAHyU1MJF9mePljJA1ssF/IuwAhIR/hWRV8jk4SmRgQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="mQK4/m9c"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mQK4/m9c
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7774240099
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:48 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-836c4474028so35195247b3.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788818087; x=1789422887; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pUuTL8RKq8zctKFBGR36Xkq0F1NHQ5YoR0hZaul99pw=;
 b=mQK4/m9c/5FwVNVMGEWX3alCX1M8YBhfpLqNsIOPS5rYi1Lrrwt35oUJ00XdfypqVI
 CPNb4eCKwu3olD0So7gKlojcOae5i8cF7t4w4UJK3CvLxDxJ2M9+QH/e7k+hRy1Go10w
 b/zs8FX55RdXHHNNcUHNutDk+EsHNXscaQQdJEnqps+IgJN3Ezmrr0CpPcopGNzan3Oy
 lTOQ/fLkoSbEhrBzh8Bsff5PJuRZeY/cNFdxPBotMvyW+YversTrj22h45qXn5ViVDYs
 KaBAnpd0zn23NpULP2brVhfDT4EETpnZcC4T3r1O/6S2ViuI+GAKF/lG29R+oR2Gnu2z
 586A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788818087; x=1789422887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pUuTL8RKq8zctKFBGR36Xkq0F1NHQ5YoR0hZaul99pw=;
 b=qlXlwH4Tbv7hDz5OZd6vp2uKp5RHb9GwM6o6ku3gG/GMXU2s/7BzAchbnBJGDLV0TM
 WBWi4sUiROqY33jR7XinuXTRg1/PM562MwBhS6xPUbzZ2lLp4tZ7Y3yotku6/U0wjv69
 i5zTUIPc7vaeKs3rC98//bkqdGu38unQvV+yOsJFve/fMzfKue9dYwQ0A5B5qeFJvZVV
 xIzYSwNtFLvR1mJFVhr+DpFpSPP7l21bZCrUwKAfGrXYMLbzXLfBA+KYu+EnqwsFYMhW
 aHHZiZGOdHfarlYGRjOj2wLtOyiVqSnHaojAedUoNVShnBdWlO5twxSGeDTtFT7C0Id5
 8UEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMQo8w2Zw9+wwEBLfFF48MmkJ4DglNCGpN5Inf4r2x9f0PdOMOFirdOwaTFdf4/n3wuyAT64NA1LVRYKJwm0s=@lists.osuosl.org
X-Gm-Message-State: AFuF++kqdRDc7Me9JQe27Ep2VWHwCLp6/MYz7Dw4FvQTVy04I2ZANbp4
 nzq0/V33wdvEfuqH7HUY1xbGjyAZjszTECtGGq9eqnOGCop5mfNR96GE
X-Gm-Gg: AYBFou0t9s9t2KovO/+A1XHreRQSbfi9rzNmJOslaBF5aTTveOvjdImiO7iKdtUfXEx
 rCP/Jw3Z0lThtf8enNVdDyKMS1hxESsdiE/kL4sj/OGO6Ghh5/4LN1eK+j0X10bTGBIN1LRddMY
 ZREh2ibeFdRMKW2Fc9w4C0TqJsFixNKFKwZJeOc5kD/5Y2guCu0Zhl0Py/lbQnNQ7e4BtPwR/Yd
 rFo5zdZ88gGBQOeqr75Avr1YRephCmSjt2d8WiCP5vSSkaegi3imzXGRcP0HpWi7CmLgPsCodX1
 uJKqxUGDSL4YMVUXWFN6etFP8ul0797qbbF6bVDcSDmFnshMTFvGnoXtdNHt1lOZES543rZTWEx
 aP7uhJopDtgTkRTUM7fZkg1gawDcm5HM21kgkDeIhe5luXgTDxVFQoAp+q5kSenIA/yAnxNgHrV
 E4ETa3p/BrTdwOjQeLhTrpWnqa8HNQ5M7Gh9BKDrUGKRTModAOdGwEqur7UpfWnhXCP/F+2u2KZ
 z8cWkdMLy25d6OwfA==
X-Received: by 2002:a05:690c:7685:b0:873:5bb2:6c08 with SMTP id
 00721157ae682-8735bb26eb3mr43482417b3.50.1788818083523; 
 Mon, 07 Sep 2026 14:54:43 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-87149315162sm78079637b3.12.2026.09.07.14.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:54:43 -0700 (PDT)
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
Subject: [PATCH 2/9] linkmode: make linkmode_and() return boolean
Date: Mon,  7 Sep 2026 17:54:31 -0400
Message-ID: <20260907215439.409858-3-ynorov@nvidia.com>
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

bitmap_and() returns true if the resulting bitmap is not empty.
Propagate that return value through linkmode_and() so callers can use
it where applicable.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/linkmode.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index 3b9de09871f6..c08632c10c3d 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -20,10 +20,10 @@ static inline void linkmode_copy(unsigned long *dst, const unsigned long *src)
 	bitmap_copy(dst, src, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
-static inline void linkmode_and(unsigned long *dst, const unsigned long *a,
+static inline bool linkmode_and(unsigned long *dst, const unsigned long *a,
 				const unsigned long *b)
 {
-	bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
+	return bitmap_and(dst, a, b, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
 static inline void linkmode_or(unsigned long *dst, const unsigned long *a,
-- 
2.53.0

