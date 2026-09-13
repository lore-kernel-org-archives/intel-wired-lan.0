Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5CAC88E63
	for <intel-wired-lan@archiver.kernel.org>; Sun, 13 Sep 2026 17:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E2E2404F8;
	Sun, 13 Sep 2026 17:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id crvJlV6ZvGJd; Sun, 13 Sep 2026 17:16:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 44F7640599
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789319791;
	b=VtnXYabJ4eH5dnlDJvCCVWS8O2rTkfcMnfxaUmgMeexW2wZRjle5Gq00LhlheT5tUKiH
	 yIGeqgQyCo/I2IhRUz1HlqmbvUmno5UOoSdFCEGRPWXTTIH662K8B0xjKzG9J3q8K7k+q
	 W2gPXR2pfzG1RF7ijB2qyNCJh0mnZkC4Yor1UQr9jHpCwPObfIsmBZsnj8sUdWwG9rwH+
	 Ui5BpmGIxR8mwgcVt0u/c/pxCfyVx1vW1bEd24AFI7s56Y5xu0N9gZIc41vwN+s9bcTwa
	 ngEoC42y9YIP7NHSKXBNr4+150fgEdjzaan8gJpP15twxCk60KVAkzKf3LChOimaqZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789319791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Nm14xqAcjp/Z6XZ00s6jk3HYTG3m5Se93UscFbQ0Cj0=;
	b=kzrCzJd27XkVeNEAd9tHoRhXNw3kkoCyvtDrHimpapzZKZ5vvPKg1kP8D/HYg56IlPp+
	 O3Pseh0GMxY0yr3uGFT1DNjUtaXpy3cBnOWQhWkGVbnBuSavyrHg+qpRYue5dqHvzq23t
	 veA475n5gxTcAa9r/aQLEmk8c61ZswTNHNfrpgEyWxpY/lgL+EBQHEQoXiK2oQ39rQTdF
	 lZqImKdkEq+BYzZpHIKY5Ck0Ho85iSk7rtSVzPaw+q5DzE34NZInKWKkT1EEoEZ6Orm/u
	 Za7HT6cKC6zUBP4W8M62yqfefH9xUAWuVuPdA7Q02VATKVj2C05UHqJyResgfAkJOmg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XHqwvCrh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789319791;
	bh=Nm14xqAcjp/Z6XZ00s6jk3HYTG3m5Se93UscFbQ0Cj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U3PadYKV/tG/BSbB21tPF+/oRIgYIi+CHSZ0dF+J+hHOISni0i75+ONVCLdoHzCfi
	 bP8wjQD2SUDF+AaczvZY2apM3nCvD/eXxvLkkkyIhluD/0ICCo/oywYYIEVhyK+m8q
	 HaSTb4CJ/YVVIY2qr3ICuhYCAotrwNPxJZGnidrKGe4mVionouM30k4LqwJBebs/Bg
	 MHfM66qv2tfxYsedgPRAvCk1w0konjiNvMrWXSnpDj2gmxqVzPtHqvf1zHUcYjO2lX
	 FWRybX2Au/jE0C/P6hMlbpR9/9N+DBKQp+OrBBCSGy26HCLRfTkGcehfk+xmf4QH7m
	 is8Z0LuhYUqzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44F7640599;
	Sun, 13 Sep 2026 17:16:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F6443AF
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 17:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35A3040505
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 17:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iCr_GU_Lvp-N for <intel-wired-lan@lists.osuosl.org>;
 Sun, 13 Sep 2026 17:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 69CBF4055E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789319788;
 b=USGo3JLi1Z3F0kxZs5yF926bRLK7rcdswtRGP8LvzU8rXBheHmRxGPGhpwBG7gLu9chn
 7HDIiRLzV2DsyKLAgRhV7VQxOcwpJuQ7zPLx9ZDrN5cS7D75t+J6ZiKP0x1TZ4uYfjI3L
 p6shXjbzWCb1SugYseR2PHXA9/GQ34jtdyfIi9vgxaH8I9c9JI9DqySfhyp0M7jFlzCc3
 H9FW6yDaVwUP3I5mm19O8sJV5gojA0SJohCZtokC4MUpOo6az+H2RJS8ezyvV552ny4rx
 bxy3PX3CewQaFcjYH3kTz+nY/GFAAYxkpFtjLFYfAWxT+inzLTEDhU3lozPX4t1yrSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789319788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Nm14xqAcjp/Z6XZ00s6jk3HYTG3m5Se93UscFbQ0Cj0=;
 b=mAw/XG4Ma5p8gwi8lfffEhYbuEzea4hFeQ0qUd4o5vcLIlKOnYfNKBfTe4PL2SuJqgHe
 oD+OhSqWc15odhUCQWacBwhOCgpNne2/MTz7+lkZPK2VHQDJCY7h/V1E4+Y/M+Pk/JT9P
 m8tjfGR3HCPshI3k3hHkj0ZAU3JsCAHjiutRFLshSLRit2DzcSxAV7eGIulr2Rvt77kCA
 LMQ8O/bwcKZaP1pfJyjwxX2SD1jVPaUj7LErgodjf1XHKyN7CxLPS/udzjI9DsvwOSin1
 MEZ9xurOQ3v4W/GxWt0hq8B81CXPCRFwKrU28flwV0fI7CU0fE1Qub95SzsznONCInQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XHqwvCrh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XHqwvCrh
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69CBF4055E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 17:16:27 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d43ac8d1dso5145957b3.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 13 Sep 2026 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789319787; x=1789924587; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nm14xqAcjp/Z6XZ00s6jk3HYTG3m5Se93UscFbQ0Cj0=;
 b=XHqwvCrhSqS26JIoxJ2E4DkoELRTva7nJkweh2xyoc8xaLoRDeBNCdaaA+QR96+AN4
 yA5EWA39YNIKF/D9WUn1u5gqfeoaSW5+PzVs7JXa2v7Ug1OAk6ZHpfo6SOjSXxnpZY42
 hygixtcQIjWzYX7m2X64qB/Qtk1Crx2t/1lXW+FL/vkN0Hbgov4QATRq11FhQkK8Z6w/
 tsU9dyvcCnUMOukr9tiYf6DquU3iH+M9Sm8+zAPEvqltNDQGcWOQXQqvC/2n3MoVI2xd
 yVKqk3AWlhH6mfDaNWve2fbNO3pR76lMWw77ARDNFV9lvIthO/wSJTxE+tra4lAY3i/R
 hTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789319787; x=1789924587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nm14xqAcjp/Z6XZ00s6jk3HYTG3m5Se93UscFbQ0Cj0=;
 b=K/UQr4aWioZSqeivz2l3ThXoJS6v6KacuVoSUO+XR5tCDep4A/ostEE5S8EnZ/9AOE
 Nus80K+lNkxN/RSR2NRfnKu61ekunfB8WWOV8Zin5pesQz4TNQM1+BzDDA+HddKOnxWv
 65QpCDiknDE+RUJxv6jaPNSA9SdHenll5iMFgEwOhZYaxadzwEDbdB2itFI64Xl2t1La
 wGogj5wvU2GmwFT1hulUr0kn3bEqOlUbXgzM7YOAjw9I4rEoOCpPSlKh+dRw0feyqW9n
 KW44vPUXtWgNIrc75vVFCvwSe/81J3bYm9cJlGamNgp1fBjjakDX03Vn41jLh4Zn5M/g
 Z6fw==
X-Gm-Message-State: AFuF++kNLHjn2Lm96di+bWkOtLgbpQHlQKFOaU6tVW+ysQGXWzT963RI
 Ix9PuG6/hawSbYLZFY4qu3CILYHatDmiL+s1UNEZc8ByMlwrHvZzsuectF6l034+xV8=
X-Gm-Gg: AYBFou09NUMH1Sxx8k+ReG3XzbgSaPNSY5ia2vEgUPWhWzrs3F8Bk2vGywDr1faWUEZ
 JI1kSmVdas4UjfA+3YyEJ8cffTEn6aTLR0YnbnUSqNuUyn+EDJ5N4Oc5U+4xcYJcJbwlybFPsKg
 SpMR1jYvFOpM8SNWOB4iqS6RNffMoCFs9SddLYUVg06kvRnY3GxRqm/fLvNw1NaNwo587rFT1gF
 nzE3Y9Aa/V8MA7dzKcSQcsC7cua5Qqv7pSzPBx75KQeFJA76ecECtMgN1E0x6kog1GjE/mGmdvv
 1dv8DzfIzRciqthbv5Nvvp2vcTKqsTSixnHcLA1bna7ldFTdaEH6LWxkOCYIFnYnchjWdfTvpcr
 94V5xO1STRP/VkaAVCkG9gS3W7WpsmYLesbvDCqZ3unItdBOa+WS/LQG9/tzodwpIm/H/mye5sI
 cLk+KQfZpUslJxaMlE8i6/7DnxfqMmk8Whykz1dq7EtJ/+ys7IwwBI4ZhtplFbxoXq14EwvBu3
X-Received: by 2002:a05:690c:6b01:b0:873:5c0f:28c with SMTP id
 00721157ae682-887ae01b17cmr16218647b3.54.1789319786757; 
 Sun, 13 Sep 2026 10:16:26 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8847db4476bsm29210607b3.5.2026.09.13.10.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 10:16:26 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Matt Vollrath <tactii@gmail.com>, stable@vger.kernel.org
Subject: [PATCH iwl-net v2 2/2] e1000e: fix ps_pages DMA map error sentinel
Date: Sun, 13 Sep 2026 13:15:55 -0400
Message-ID: <20260913171555.89537-3-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913171555.89537-1-tactii@gmail.com>
References: <20260913171555.89537-1-tactii@gmail.com>
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

While allocating packet-split buffer pages, a failed DMA mapping would
leave DMA_MAPPING_ERROR in the ps_page->dma field.

This would have two consequences:
* The next attempt to allocate that buffer would write DMA_MAPPING_ERROR
  to h/w if all pages are allocated. If the h/w uses that buffer and is
  handling a frame large enough to touch the affected page, it would
  cause a DMA fault and be dropped. The driver would then call
  dma_unmap_page() on DMA_MAPPING_ERROR and unknowingly send the
  uninitialized page up the stack as part of the frame payload.
* On ring teardown, dma_unmap_page() would be called on
  DMA_MAPPING_ERROR.

This condition is only reachable when MTU > 1500 and PAGE_SIZE <= 16K.

Fix this by setting ps_page->dma = 0 upon mapping failure and separately
testing ->page and ->dma during allocation and teardown.

The rewrite of the ps_pages section of e1000_clean_rx_ring was necessary
to recognize the case of an allocated page without a valid DMA mapping.
It also fixes a separate bug which would potentially leak pages on ring
teardown. The cleaner stops cleaning pages when h/w reported that it did
not write to a page in the sequence, leaving the following pages
allocated and mapped. The teardown would then break early and leak the
unused mapped pages. If the ring is re-constructed by down/up with
similar configuration, it would reclaim those lost pages. This would
only affect configurations with rx_ps_pages >= 2 (MTU > PAGE_SIZE) and
the same condition of MTU > 1500 and PAGE_SIZE <= 16K.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Cc: stable@vger.kernel.org
---
v2:
* Reword last paragraph of description.
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 26f45ee8c7e7..063fc8cd2673 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -759,12 +759,15 @@ static void e1000_alloc_rx_buffers_ps(struct e1000_ring *rx_ring,
 					adapter->alloc_rx_buff_failed++;
 					goto no_buffers;
 				}
+			}
+			if (!ps_page->dma) {
 				ps_page->dma = dma_map_page(&pdev->dev,
 							    ps_page->page,
 							    0, PAGE_SIZE,
 							    DMA_FROM_DEVICE);
 				if (dma_mapping_error(&pdev->dev,
 						      ps_page->dma)) {
+					ps_page->dma = 0;
 					dev_err(&adapter->pdev->dev,
 						"Rx DMA page map failed\n");
 					adapter->rx_dma_failed++;
@@ -1722,13 +1725,15 @@ static void e1000_clean_rx_ring(struct e1000_ring *rx_ring)
 
 		for (j = 0; j < PS_PAGE_BUFFERS; j++) {
 			ps_page = &buffer_info->ps_pages[j];
-			if (!ps_page->page)
-				break;
-			dma_unmap_page(&pdev->dev, ps_page->dma, PAGE_SIZE,
-				       DMA_FROM_DEVICE);
-			ps_page->dma = 0;
-			put_page(ps_page->page);
-			ps_page->page = NULL;
+			if (ps_page->dma) {
+				dma_unmap_page(&pdev->dev, ps_page->dma,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
+				ps_page->dma = 0;
+			}
+			if (ps_page->page) {
+				put_page(ps_page->page);
+				ps_page->page = NULL;
+			}
 		}
 	}
 
-- 
2.43.0

