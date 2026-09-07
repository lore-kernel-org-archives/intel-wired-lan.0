Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39673C79FA0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 21:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2A1B60675;
	Mon,  7 Sep 2026 21:54:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pbA2u9DX34S5; Mon,  7 Sep 2026 21:54:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 32B926068A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788818087;
	b=glCTBW+lOSe0tZvraDe4R3QvhhZvEGJ5KIvOZOLGPQpovhOUpqpUsq9GYEOcpUzKMTCW
	 rjDcxjN8WRZEAPr+eOGDK8KGN+PZX0slEob2yt0Wdfszbpv39Szc82hbFcNfnuAH4hsjc
	 1tg+NU9TxAqlHElq/+XM/TUtHCH1UzqHbXZ4afDbZcEUKR30vC2myJ0h/BSAslRM7rT3Q
	 nhGKvg0Qzj9mxo2gS2JRPG4XP1aPEsFJ6FEl28g5AwE1bFf0Nxp5lV2O76laE1+iIDn+Y
	 S096L3o5CKY5T5DKqb1wwwwu7dlY9xk7cXJsjPVqSTdkgg8hSifge095+9Ubpyk3QZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788818087;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kt5vYk7oIJTAvWcYqFLR1526VYebZHALzcXyXv4GXys=;
	b=OBRgYodRRmHCthokd1fA2e044iPok47xb2a567IpcdVPyzTcpWRrDq0Ah+0qOfj/+hqJ
	 zveyrfVbQiLwHDSIf5DKvSsYkDBeJt1pw3rLC5v6iHqHVPQxlo02UmkFIsDbGpGe3O6nV
	 4rtZ7QHTJc5TNDjl5hOxJkZG3ZzvdYedCOfZ1ukjQo4gasinvloha9/CtcL/ESNMKTv3y
	 WXaq92UqOim8jl7XnzF0CgvjOGYYyO+0emDqjYfrD/rlZyfulpvy2JNm2naeZRNeAtpOC
	 X0nA/inNrKGtXQq120Tl3yGI8il5Lsee5mizCdGoSeQd6Rjfi7SGf/uemgHqqYUnk9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MmXN00Zc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788818087;
	bh=kt5vYk7oIJTAvWcYqFLR1526VYebZHALzcXyXv4GXys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tq7Xh64swJgMB9AFr7pEtXZhwGzTQSKSst97/BRs2Gkx7Dz4GMCNrE3Y1Q+Vm4ZUw
	 x49j7raXCJOK5whe/wv8AWRjhst9pA/5Y26bx1AvxTUroTwSNvIcy6DZanO+Mysdyx
	 baduPkqn1JlC8vh4QrwCxWBq4z7FWIhCthlmigWkXdGI69yg5PpKjgxMuoKr8XlwGv
	 djOrbLP2xOWiejtSez2XQqdaSttZAWt6X+X9193bjPfdBettkkRc1L0c0ohVMDekMG
	 Q8TwO1Gkd73QeQPclEWKcRIbC3fPkts+zq3NOjczlafQgtXyzyy3j1XVXBbWK5eW+g
	 asu6XZ43gNpoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32B926068A;
	Mon,  7 Sep 2026 21:54:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 387CC49D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1EC54605CB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id owTwvT5cpFqg for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 21:54:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2B780600C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1135"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788818084;
 b=DN2zIIAggq3IIsrZDlkcQs25k2okW7MNxDDGsSPkAXMaoCOdixTZaOK8HbTXrQWSqiIY
 MngISy3MRqa6h/2cU63CLQzLyC7uvxekitckDPGYwJvHjEb/RlrA34/te0GkUjEn9LMsv
 qCVUd3KUvetSZVcD/UpVnGvRgDkh95RcSo8TMd/Q06B4gjQR+3NwDwzCIfyAWF3Dp5tzt
 jKn3A1nQDCDj77P5bYmxBUA8yO6VjDPwOxZ4kTNc62klv23aInG8aaZxgj4WpaOIwoyZ9
 sjA2dPurAiiIxz669i/0HgjNv51ak/umkJQbO4tZif1kHXmQd+HsJ0flQFdEqhqmMug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788818084;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=kt5vYk7oIJTAvWcYqFLR1526VYebZHALzcXyXv4GXys=;
 b=Oce7gUOIkidE/Qv36G/v80pOIcePR1uYPBC3N2aP/qbqL142uU4v6nGBwT3xk84xTLkm
 K4YS3MC0cn1kAJ6WQ1y5aBcRlz0dlxf5ReCt4YAC570qv4Pi1e4k76scOiAp9fXBP5DDS
 MbLve48cuMTecNZWc7OQIp+xc2bPWcLSW9CVGtwCZs2JON6wGPU6JdDWrJBTdIov0OdaB
 fKHATsOnm/UXPn1M6EBpZ/wjxbMcvsHkWmrSNZ4AqHZ1Kh1smR+ZPVruelxbOH4Sfjyzc
 5llB6Q+8r4wYT3cMD1bCPJLGGzZEp1nqgN9Xf14cJwnpaqgmE/I2oJaP1rRajZImbew==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MmXN00Zc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com;
 envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MmXN00Zc
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B780600C4
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 21:54:43 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-836c8bde2dcso18102377b3.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788818082; x=1789422882; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kt5vYk7oIJTAvWcYqFLR1526VYebZHALzcXyXv4GXys=;
 b=MmXN00Zcfhsl/4x0Ys9iGcWOrKZf0nmUlC8qz6oeqznCxPy6EN6Y2rtga0W/Cy2/4r
 +F9pjQcQtcRbwh/u4XIHLcO/ZHqs21RYkYiljYWl+dPFtD5eWmJCgD5iGhNlsStfGhHx
 r4meyALsfKqGGHhI0+fAxLjYzbSf1YIedNsdaalxJBm1W8GIu+9KyChXJd47NdM8xJpk
 6Q0UhQobvKutLlYmxqziiTOvB657QfuOGguv7GMHgmqTIrccan9IoBHP2cHJeSVzh1Sj
 aeMMYYeVAHEBK8d+Vj466b1zMwKJ6FCk8x8qO+tqHIwAsFopQOQ7lvg3CzWtQpRefrfy
 vWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788818082; x=1789422882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kt5vYk7oIJTAvWcYqFLR1526VYebZHALzcXyXv4GXys=;
 b=mTD25J5Vf6uZ8XzOaGV2/GBZLSpPtioKZsyWXbxPhEoyuxCApSaUZrRxLqEq+A+mm2
 xiJSj+bTA9K3qY1S6O+fP0r70267N4BZkGKWG4gUM7Sto9Mx/J5sYnBcwjWPVZ3zhDCa
 Pyamvcp3pwG2zVVPC23/mhd2aoJopp8fIntdODn8J8Pe49n16cXL/hP7UwKlt6Jh0aiv
 EpU/cjQOtoP9IGkHSNBqU0VvynRTvrjs5r7hNh3gIXig34uZj3D2hksJmi9w+GMCk88d
 o3EU1gKNJ1x+JV+EUpO4VjcY22Q4OOrRWrqqQwXLGEKAxDhU9znMkgYwURRl5babJgaW
 l5lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEaEBMeV88yTA3qr2+HM8YvFZNAGzkw35EFEuHM6yc0ToQXcFGkbWVrnn3tfVEFMgrrUIvaTutYb/nOWvEO1Y=@lists.osuosl.org
X-Gm-Message-State: AFuF++lxhpY2Rc/fwn9xUr89oZhW1XGvTxasrhmSSjw5Y93/i9pC6/qG
 5vdGBJOLrBmfDCiO8oKw4/bPOMXxxWUEG2XcWFnyVej9wfIXCLViUCyy
X-Gm-Gg: AYBFou1rZ6MtF7Ur6dd/z5EzHIsiXVR+OOLTnO7iygIrrRhIo1wDKtspNV5WX0R+Q47
 OS3G3iC5gEC5cPxJeo6N2obKgT593EjE86lzY193Q28hVTCsRoxoaXdh7C3/t+rqg3PUXshK2bp
 Bkrv6AWxfB7py4QUA1XsitfuhfNghJcjG/56hjIpDDgu/7J4spjOtRGCV8mQIJar/I1JKJaD74D
 4KU9MBzg9tpc/1HrQSljqMeWx4CTH+v/mtc6o3mT70hrLlSREgmtTKztjD5kH9msBpDzxCzIhH8
 2Ik8KlecLIkFB5N54MAm/lxdSQMwX24UFaKDhm/xaHZHdXd12cJe4eq1Kx2jaIM5XhZ/ORGaFbt
 dUy3YKd1GH8fhK5ZSvtq3ZK/i0RrM81lN41kTkS/v9jxeLFpA/CvBJn8XRubkF4mlkbfn+5mAU1
 3GlDM8euiwLmmVkbiTFkY6dXkZsH0fL8uTFbAROgV16pba2B9CcKc6BAuulmpjT3H5QE8pdt1cT
 yNTuNZvLrae59r6rg==
X-Received: by 2002:a05:690c:4f02:b0:81e:eebb:8e4a with SMTP id
 00721157ae682-87123521b7fmr78031777b3.12.1788818082551; 
 Mon, 07 Sep 2026 14:54:42 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714bb0efc1sm77847347b3.45.2026.09.07.14.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:54:42 -0700 (PDT)
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
Subject: [PATCH 1/9] bitmap: add bitmap_and_and() and bitmap_and_andnot()
Date: Mon,  7 Sep 2026 17:54:30 -0400
Message-ID: <20260907215439.409858-2-ynorov@nvidia.com>
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

Add bitmap_and_and() and bitmap_and_andnot() to combine three bitmaps
in a single pass. Both helpers return whether the resulting bitmap is
non-empty.

Introduce BITMAP_OP() to share the word iteration with bitmap_and(),
and add tests for small constants, multiword bitmaps, aliases, tail
masking, empty results and zero-sized bitmaps.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/bitmap.h | 32 +++++++++++++++++
 lib/bitmap.c           | 46 +++++++++++++++++++------
 lib/test_bitmap.c      | 78 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 10 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7df1573a409c..d524ef6b0300 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -44,6 +44,10 @@ struct device;
  *  bitmap_fill(dst, nbits)                     *dst = ~0UL
  *  bitmap_copy(dst, src, nbits)                *dst = *src
  *  bitmap_and(dst, src1, src2, nbits)          *dst = *src1 & *src2
+ *  bitmap_and_and(dst, src1, src2, src3, nbits)
+ *                                               *dst = *src1 & *src2 & *src3
+ *  bitmap_and_andnot(dst, src1, src2, src3, nbits)
+ *                                               *dst = *src1 & *src2 & ~(*src3)
  *  bitmap_or(dst, src1, src2, nbits)           *dst = *src1 | *src2
  *  bitmap_weighted_or(dst, src1, src2, nbits)	*dst = *src1 | *src2. Returns Hamming Weight of dst
  *  bitmap_weighted_xor(dst, src1, src2, nbits)	*dst = *src1 ^ *src2. Returns Hamming Weight of dst
@@ -166,6 +170,12 @@ void bitmap_cut(unsigned long *dst, const unsigned long *src,
 		unsigned int first, unsigned int cut, unsigned int nbits);
 bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_and_and(unsigned long *dst, const unsigned long *bitmap1,
+		      const unsigned long *bitmap2,
+		      const unsigned long *bitmap3, unsigned int nbits);
+bool __bitmap_and_andnot(unsigned long *dst, const unsigned long *bitmap1,
+			 const unsigned long *bitmap2,
+			 const unsigned long *bitmap3, unsigned int nbits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
 unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *bitmap1,
@@ -337,6 +347,28 @@ bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 	return __bitmap_and(dst, src1, src2, nbits);
 }
 
+static __always_inline
+bool bitmap_and_and(unsigned long *dst, const unsigned long *src1,
+		    const unsigned long *src2, const unsigned long *src3,
+		    unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return (*dst = *src1 & *src2 & *src3 &
+			       BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	return __bitmap_and_and(dst, src1, src2, src3, nbits);
+}
+
+static __always_inline
+bool bitmap_and_andnot(unsigned long *dst, const unsigned long *src1,
+		       const unsigned long *src2, const unsigned long *src3,
+		       unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return (*dst = *src1 & *src2 & ~(*src3) &
+			       BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	return __bitmap_and_andnot(dst, src1, src2, src3, nbits);
+}
+
 static __always_inline
 void bitmap_or(unsigned long *dst, const unsigned long *src1,
 	       const unsigned long *src2, unsigned int nbits)
diff --git a/lib/bitmap.c b/lib/bitmap.c
index ed685127a107..85ce3cbaa9ab 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -34,6 +34,25 @@
  * for the best explanations of this ordering.
  */
 
+/*
+ * Common helper for bitmap operations.
+ * @FETCH: The expression that fetches and combines each word of the bitmaps
+ * @bits: The bitmap size in bits
+ */
+#define BITMAP_OP(FETCH, bits)							\
+({										\
+	unsigned long idx, val, sz = (bits), result = 0;			\
+										\
+	for (idx = 0; idx * BITS_PER_LONG < sz; idx++) {			\
+		val = (FETCH);							\
+		if (sz - idx * BITS_PER_LONG < BITS_PER_LONG)		\
+			val &= BITMAP_LAST_WORD_MASK(sz);			\
+		result |= (dst[idx] = val);					\
+	}									\
+										\
+	result != 0;								\
+})
+
 bool __bitmap_equal(const unsigned long *bitmap1,
 		    const unsigned long *bitmap2, unsigned int bits)
 {
@@ -230,19 +249,26 @@ EXPORT_SYMBOL(bitmap_cut);
 bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, unsigned int bits)
 {
-	unsigned int k;
-	unsigned int lim = bits/BITS_PER_LONG;
-	unsigned long result = 0;
-
-	for (k = 0; k < lim; k++)
-		result |= (dst[k] = bitmap1[k] & bitmap2[k]);
-	if (bits % BITS_PER_LONG)
-		result |= (dst[k] = bitmap1[k] & bitmap2[k] &
-			   BITMAP_LAST_WORD_MASK(bits));
-	return result != 0;
+	return BITMAP_OP(bitmap1[idx] & bitmap2[idx], bits);
 }
 EXPORT_SYMBOL(__bitmap_and);
 
+bool __bitmap_and_and(unsigned long *dst, const unsigned long *bitmap1,
+		      const unsigned long *bitmap2,
+		      const unsigned long *bitmap3, unsigned int bits)
+{
+	return BITMAP_OP(bitmap1[idx] & bitmap2[idx] & bitmap3[idx], bits);
+}
+EXPORT_SYMBOL(__bitmap_and_and);
+
+bool __bitmap_and_andnot(unsigned long *dst, const unsigned long *bitmap1,
+			 const unsigned long *bitmap2,
+			 const unsigned long *bitmap3, unsigned int bits)
+{
+	return BITMAP_OP(bitmap1[idx] & bitmap2[idx] & ~bitmap3[idx], bits);
+}
+EXPORT_SYMBOL(__bitmap_and_andnot);
+
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, unsigned int bits)
 {
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 56bd23059b26..fbc46ed960a4 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -193,6 +193,81 @@ static void __init test_zero_clear(void)
 	expect_eq_pbl("", bmap, 1024);
 }
 
+static void __init test_bitmap_and(void)
+{
+	enum { nbits = BITS_PER_LONG + 13 };
+	DECLARE_BITMAP(src1, nbits);
+	DECLARE_BITMAP(src2, nbits);
+	DECLARE_BITMAP(src3, nbits);
+	DECLARE_BITMAP(dst, nbits);
+	DECLARE_BITMAP(expected, nbits);
+	unsigned long small_src1 = ~0UL;
+	unsigned long small_src2 = ~0UL;
+	unsigned long small_src3 = BIT(2);
+	unsigned long small_dst;
+	bool ret;
+
+	ret = bitmap_and_and(&small_dst, &small_src1, &small_src2,
+			     &small_src3, 4);
+	expect_eq_ulong(true, ret);
+	expect_eq_ulong(BIT(2), small_dst);
+
+	ret = bitmap_and_andnot(&small_dst, &small_src1, &small_src2,
+				&small_src3, 4);
+	expect_eq_ulong(true, ret);
+	expect_eq_ulong(GENMASK(3, 0) & ~BIT(2), small_dst);
+
+	bitmap_zero(src1, nbits);
+	bitmap_zero(src2, nbits);
+	bitmap_zero(src3, nbits);
+	bitmap_zero(expected, nbits);
+	__set_bit(1, src1);
+	__set_bit(2, src1);
+	__set_bit(BITS_PER_LONG + 1, src1);
+	__set_bit(BITS_PER_LONG + 12, src1);
+	__set_bit(BITS_PER_LONG + 13, src1);
+	__set_bit(1, src2);
+	__set_bit(BITS_PER_LONG + 1, src2);
+	__set_bit(BITS_PER_LONG + 12, src2);
+	__set_bit(BITS_PER_LONG + 13, src2);
+	__set_bit(BITS_PER_LONG + 1, src3);
+	__set_bit(1, expected);
+	__set_bit(BITS_PER_LONG + 1, expected);
+	__set_bit(BITS_PER_LONG + 12, expected);
+
+	ret = bitmap_and(dst, src1, src2, nbits);
+	expect_eq_ulong(true, ret);
+	expect_eq_bitmap(expected, dst, nbits);
+	expect_eq_ulong(BIT(1) | BIT(12), dst[1]);
+
+	bitmap_zero(expected, nbits);
+	__set_bit(BITS_PER_LONG + 1, expected);
+	ret = bitmap_and_and(dst, src1, src2, src3, nbits);
+	expect_eq_ulong(true, ret);
+	expect_eq_bitmap(expected, dst, nbits);
+	expect_eq_ulong(BIT(1), dst[1]);
+
+	bitmap_zero(expected, nbits);
+	__set_bit(1, expected);
+	__set_bit(2, expected);
+	__set_bit(BITS_PER_LONG + 12, expected);
+	ret = bitmap_andnot(dst, src1, src3, nbits);
+	expect_eq_ulong(true, ret);
+	expect_eq_bitmap(expected, dst, nbits);
+	expect_eq_ulong(BIT(12), dst[1]);
+
+	__clear_bit(2, expected);
+	ret = bitmap_and_andnot(src2, src1, src2, src3, nbits);
+	expect_eq_ulong(true, ret);
+	expect_eq_bitmap(expected, src2, nbits);
+	expect_eq_ulong(BIT(12), src2[1]);
+
+	bitmap_fill(src3, nbits);
+	ret = bitmap_and_andnot(src2, src1, src2, src3, nbits);
+	expect_eq_ulong(false, ret);
+	expect_eq_pbl("", src2, nbits);
+}
+
 static void __init test_find_nth_bit(void)
 {
 	unsigned long b, bit, cnt = 0;
@@ -1533,6 +1608,8 @@ static void __init test_zero_nbits(void)
 	bitmap_zero(NULL, 0);
 
 	ret = bitmap_and(NULL, NULL, NULL, 0);
+	ret = bitmap_and_and(NULL, NULL, NULL, NULL, 0);
+	ret = bitmap_and_andnot(NULL, NULL, NULL, NULL, 0);
 	ret = bitmap_empty(NULL, 0);
 	ret = bitmap_equal(NULL, NULL, 0);
 	ret = bitmap_full(NULL, 0);
@@ -1566,6 +1643,7 @@ static void __init test_zero_nbits(void)
 static void __init selftest(void)
 {
 	test_zero_clear();
+	test_bitmap_and();
 	test_fill_set();
 	test_copy();
 	test_bitmap_region();
-- 
2.53.0

