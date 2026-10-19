Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7566CCCF2D6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 10:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 435BA80D9F;
	Mon, 19 Oct 2026 10:53:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HDScA7RmVMx6; Mon, 19 Oct 2026 10:53:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9790D80F7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407191;
	b=F5z1GJZZ9027eFA2EAP8tTvd3aUDMZuenQoiAN37oyy4wS+7WLA3eGJoDkuRRC49cdr8
	 1KZPtUmOlQF2eumeYoX01ZL8ifyPS16IuuroPQgvQpXyDyyt8IvHjVMBmtuTcQc+mbjyx
	 OcMtWfdlkYnVD5v9AgbtW0h5efOhCVQS8qYC/VBX5ZWqthrpQd29kDlHxHsVK/61Nfoid
	 U/EmlD+2Gmx4dOy2eLRYR+XfCJaEFpV9rvVOI8CBw2zHksXNRKpwNyZ1tSBNSC1cTTO26
	 NPMkDbTHg0i+1C0Vhm0LaxUVFUWcZBoLAUWp+KmQ9uY9H6TvE0Xjs9dEkGQFeI3bpfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407191;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=q8A8Zrm0+PIOnWjaNbzg+cn4gn/yB12bYA1j7GbTog8=;
	b=q3Lrl8HWYQzamgQDjEjZlMcG/vwVzYDQDau7VWe+pLQxVchmdWFp9VWMleTZF/U9xk9S
	 ISRnGyb6toVyCoYkrXD3OmZi4qqIrTJpkw0JuLbcszGfyLgpEot6UZYlvSEItPkHAyzKz
	 DHWj7uNMw7s+vu2/Bmw3xN0EHSIZuYLtgfI/cv2KI/jsCwVlFIrl2ShVoz9aUCZMOzVvr
	 BPabxQTyU0IsiWhqpbcThLODOBNuUDpr4XCf6CIIv8/NkgQEVDdq35xWQAbSBHNv4hpg4
	 LdkdCDfDOwgFlX2g409RTIfdjOxkkT/KLv2PrzP9o6/LLX+8V/BJ1EZ2ZZ2tPg+/bnw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792407191;
	bh=q8A8Zrm0+PIOnWjaNbzg+cn4gn/yB12bYA1j7GbTog8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mRjcSXVe6aaml6jUZQ+Ij4eJvoBGBCgGfiOqUE5LgbBBKSAhX7TaDk9nGqihLw52i
	 JzAwfOmRHALbiXObTCenAxT8epnv6jE9zlooDNzkaeBU+NSkQI0EAhduh6ZoYSSMjA
	 uS59CZCeJd0qFQqoy9aZ6XHabaLWmgLZLS2Mw6Z3kCOjCvcIhguukXy0XaubTJCsZQ
	 2boc748uT6rmZOM3yjDYhFR996JX0mDiAp5shZJC+YBLD9BXzFtnPHWLYD9rEqhKzK
	 wEL370g9aeTvtB2RGzh6jLdW+nYh3mv5qcLw+XXFKMjC0rACFnjIwnr5kNXg57wzA8
	 ezAJkoPwTL8UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9790D80F7D;
	Mon, 19 Oct 2026 10:53:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BB5271DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD86540080
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:53:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sjxasOHzdnEi for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 10:53:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 63764400B0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407188;
 b=r1lrCtlQRuFn3yh3lkVOJqjT2CHHPF2L4m8WKhihXwQtMFGpIJCimcUXps3ybgm+Nara
 tbQ+8Qs+9Ohzoc1PMGKx/B+p4gl6NZH4kLXrz93XLZqteOCc7ZzBLziW+dpOVm3xDfZaD
 i8cvoSgs6qxKzofM8pXMk/OLdBvWvslG3yXvUrLCorOPHGeLn71wUHIIonp9vQb8jfnf7
 75M1DiYxu6LzgOfOcmAZyShaPX7AH/Shv1O1PbGHABcndMzY8U6Ph6dcrZbts9NyB5QWP
 /7AxeEk71RmLdScmkloeD5xCMu5zOPu0KVMRhj4Sk95ZU189mJpQF7S90bOsu5Dbj4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407188;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=q8A8Zrm0+PIOnWjaNbzg+cn4gn/yB12bYA1j7GbTog8=;
 b=ihprXmr42gYiu1e6Va3/rzgFESNldhu/eofIP45OmDXGeHe+S3msEwy3t9v7540NZmTT
 TC/MNxIO/bSeVxdwZtpUrKmNLuTIoY/XIhxrtDFSd+19+SLPX+8OvQvbsTX0OKOigychv
 Lsn0mu5Oy+8lKQzWPx3DNxprDkPVXpDCxx43JQD7ErIgwKWG2NMOq52y83j3zvsLVdVVi
 uABLoCWOOvLFCm8y9Q/moUCzf/gJtqWgxsUTxU/7fiQyCkBJDKPmsy3NhuyT2ffD0VQd/
 51QNqwSp960EUo2iai1h9WwRTL1aOaz2SLrHsTsqArxfNE343wNomz0FXoXZFhir7Rw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=el2GgpNj; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com; envelope-from=aaron.ma@canonical.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=el2GgpNj
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63764400B0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:53:07 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 041AA3F520
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792407186;
 bh=q8A8Zrm0+PIOnWjaNbzg+cn4gn/yB12bYA1j7GbTog8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=el2GgpNjmEOnFypXt8dEGgP0/d+5kGdQdvvd/ab2XDv0SBdq700Q3xkqcFAPnd7FB
 j7tZ3uYXd/8dJIo2nKxoIe5oKFSSOXYlCSeDTBcV2RcgT4DxkIpWV0xoXF+bXvrE22
 Uv7pSTWik7W7FvpRG6A3sansPoWZW6GC0WlDQT0o2GGJbrkrZ6pXa3wHTXjxwY69gR
 3mh7uvzG/tjlsIKf4N6obqqHx7uDUudat/nlYfxWHwWkdV1w6Klj3cDti6HioVyshn
 FV1UtyhkvgyTFyDtG5Yf88JJgkdJVMx9AVomivgInviscaZaKBq+W7qTtvnyooSqUt
 MWMY3m7AvQxrNXLzMv+tvGKPHFwSdNx8UFU4fhLIslZ5phe6WmJlYGfg7VPFuEqIBU
 PG+O4/DHdzrouClr9QBEXcluCSiAKMzd52I3wP6rTvwVALYkhZzQzIghwbrkP8MVrT
 b9UkbiNr9vkty+ERYb3Y65SKgJlyuGPCLwMoAdELFcqUcB5Yredxc8/y5fv92+7zBF
 BMgfTQgB4K6ZtwnyZXfAzgsSCcSr6W3Ec5A6F0D4EqLXhWLfwIOkppvW6orSMXobOv
 +cxwE+xd0PdjKok+BvX4tAnZWUgr7MX3WlqwqNvAjOn1bU8Jt/bMZyCjztsAGU/PD7
 TR8PaY9xQc7je3/i/813j7Ig=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48dea677afcso1531979f8f.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 03:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407185; x=1793011985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q8A8Zrm0+PIOnWjaNbzg+cn4gn/yB12bYA1j7GbTog8=;
 b=Hjejs0VG+xmWNo21hytvVwK9+S+4MJriZcp+uyuFDQc6VbgIeUN9okLuGViI5pknxL
 bsLAd6c9M3BQw0nK69xo3EXxsadA86Lw0T/IYMzIfso6Qvth3gINZ0R415ip6kcGX6u/
 IBVwyyg9QL01zt59p7xf0lQq8bvPidhQOKFBdFGb9nz1EgIIVUNoEYUDwDTtmK34Y3bj
 5/g4wOYcmBm/a4fZ2mkpldAKYTKtF2bxC6xE4WSbqEF91fvXdcDbqGLl2GfQ+cIKOA/d
 rvzmpy2EZbzPv7a4DYA73q8FLfhQI4MUGaoqQhGDekMV4+czuQLwQ6SuHy8pREUTvFWE
 +87A==
X-Forwarded-Encrypted: i=1;
 AKwUvByaLPP5tHz7W5lz0zkmZkcGTOhs9t55q2oMpx9gZHIet6lUPpdeHx9Ac1nX8nOwUUyyJ/QHQqg71DQr3kb5kwc=@lists.osuosl.org
X-Gm-Message-State: AFq9FYLgrZMFjaQ0/7FRy5LfeNEaOTSyfR16L1pY1TItUgx8LpT2st5N
 e3xp6uSg5MLdb8UjwfRSM9i8buqc8gofu4H8jSY2PZAyKIhp+SqFOQ6/0ug5WvNpOt5Cksr6ExN
 3Cf99VrQr4023H+8fGZO03W+ciAEqx8v/GcyyCzDq0SAI2v7UNJmAcxFQswdMk80yTRiV30MSAU
 cUhfOQK4AC5tc=
X-Gm-Gg: AYBFou2LqpYZVvWQ5jBgeD6DXm9uI1F7FbhInjXTeaMf3xyLs0ZEkVM2U4QZ63jHER7
 aGe7CIW5GELiRxzwIkg5TvLfP0UnERy7+9jQ4mhYsdkUs6XG/lNxHkHn0KMj1LN1ZgnK1HVWt9j
 /zp09Z4mg1I6ysESYDhMWcQegSgEz3WBQzB/+lcxWW7+oXlQNYQiAIybXq22Ecvk50H2P8QPfDQ
 AKcyZSiRVt6mPSG+5wtRTszAB7g6cqWBlFGRUJ8FMdwuyENYUJ9Jap1w5ieFjeJsSmu9F/Q3VBp
 4wWH/5RyP4RkSyt3LDjyUy7cwFEP/k7/OPetrDuYcZRePchbhho0yoqghmY7802rInXlEa1So9+
 MBaIBdRAi9RhtN3ULicS3BhBj2dYA2UVJAPBSYd47bErjDojXdzAy7bEhQ9GxZWA4K+2bIgliz7
 DMLLcinjnt2Iw7W3Cz1CxLn8cpHgkLzjqKkLRvko1/tViABlXl9qGgTW9bedki/k15mWawhzfME
 afWL1mo3W6oBJvGGSf8vLkdGqLZmwAlw2ZnoGn4
X-Received: by 2002:a05:6000:298d:20b0:48d:f9dd:e3e0 with SMTP id
 ffacd0b85a97d-48e07bab931mr10390506f8f.4.1792407185508; 
 Mon, 19 Oct 2026 03:53:05 -0700 (PDT)
X-Received: by 2002:a05:6000:298d:20b0:48d:f9dd:e3e0 with SMTP id
 ffacd0b85a97d-48e07bab931mr10390471f8f.4.1792407185140; 
 Mon, 19 Oct 2026 03:53:05 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd510201sm23238930f8f.55.2026.10.19.03.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:53:04 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley <brett.creeley@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH 4/5] ice: clear DVM boost table before scanning package hints
Date: Mon, 19 Oct 2026 18:51:54 +0800
Message-ID: <20261019105155.3793063-5-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019105155.3793063-1-aaron.ma@canonical.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
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

ice_init_pkg_hints() clears hw->tnl before enumerating package labels,
but leaves hw->dvm_upd untouched. Every subsequent call to
ice_init_pkg() during reset recovery appends duplicate DVM and SVM boost
entries to hw->dvm_upd.tbl[] until hw->dvm_upd.count saturates at
ICE_DVM_MAX_ENTRIES (48).

During package download, ice_set_dvm_boost_entries() then issues a
redundant Update Package Admin Queue command for every accumulated
duplicate while holding the firmware Global Configuration Lock.

Zero hw->dvm_upd alongside hw->tnl before enumerating package hints.

Fixes: a1ffafb0b4a4 ("ice: Support configuring the device to Double VLAN Mode")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index b71f3fb791db7..a86ef097826d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2101,6 +2101,7 @@ static void ice_init_pkg_hints(struct ice_hw *hw, struct ice_seg *ice_seg)
 	int i;
 
 	memset(&hw->tnl, 0, sizeof(hw->tnl));
+	memset(&hw->dvm_upd, 0, sizeof(hw->dvm_upd));
 	memset(&state, 0, sizeof(state));
 
 	if (!ice_seg)
-- 
2.53.0

