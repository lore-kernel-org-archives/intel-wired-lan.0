Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D365606A335
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LVbvcSaR;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iokX1Ngp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AFB2605D8;
	Tue,  3 Nov 2026 16:23:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ptpYhizJIKnY; Tue,  3 Nov 2026 16:23:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C0E426069A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793723014;
	b=C60z7D9dCyjDy9pxTfxkIHX0xarfko5tHSEGUDeIZjSG28P+EKoQ+lfJ+3edlvZba8px
	 +JXacJGt7ut3XV7W1mNqGBERtbaEngtN/GSs4JFDbqU4GQled5mFpogXQz0T4qDsAgujV
	 YXAWae5Yju9dScJmrtO5tCJhULHwAJv52LQXXQykpKlIabaeyEcSMeA/9+9wvJz874Vmc
	 UK9eqWQPLtkIGZZqytaCRUNqe+2ACCYGrs4dCgmcVJTsTnR0//ekWuPiV6YrWPOQ75blv
	 OseoCJNllXcE9Xd1xdzxG2MjwOwFEbi8sbwZJ8cRjNlspEY5kPhy5nQ3lPfMYCT3Qlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793723014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=siM8Df/snDn0jLC7QUxpaD63oeFqtwGPtlZ0Xno7Huc=;
	b=RwSATNtU8HAfavZ90WrAmHxl/J8ZsE/rb6fB5itfM/AVUqLT4/YwDEg7tITs0C9dS9qV
	 j+JDHqCynqhlJyHg4ziS9PZaSugY6SauUtS1GiRepAb+xejpmg+dy5Rx6zQx/1VPypIyO
	 XwBYQqqvHFgbZDnRHrHx5+G37AQSivKoA4lHP28mtYzojDO/PVHaXk8dWxwgIK89kY7HX
	 nUwX5TZE8IFXovh4bAtvrpPXuAqRXCSUIxjl1wB8lmLPJr9c0udDSh5s3Xm+/P7EcGuEu
	 80MXSugH3RTFj+7aFtZtlgT4CMB9curPvH5TFyYKhumDf8yOKTimyUxjTzs/3qE/F5w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793723014;
	bh=siM8Df/snDn0jLC7QUxpaD63oeFqtwGPtlZ0Xno7Huc=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LVbvcSaR6V7b2YS4AOKFltjxZJZJqvFCufb5KsdrNSzqLM1Vsw5BdyWaPEwXBajVk
	 Xzm6jEgAI8CobCbMFWpzr9ugF0ovMIFtLx0FMV1OS5EHv6iKd7fQCAiQpcghu5otvl
	 i9keLQ15miisHX2bXAZhhtnNokEDbN32nHkKbVsqwXODHROZPQGG2Bs++Sm7wMxuwG
	 jUS1ZxyDMfAB+LQIodaCEl7OOa5iZJ8iY1/qjjfs67RyIQdeX9x7UjRjFNRTHftZMl
	 x2zo4x5uMIs14DSspxyugAXYu8+Pt34C51fe3RuX6e/dxXpTTcrmD2eGDgO7eXNZqk
	 DyAR2TIqVJs7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0E426069A;
	Tue,  3 Nov 2026 16:23:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F00D8235
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5C8840718
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:23:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9X3XpVAFXTHy for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 16:23:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AEBE840704
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::546"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793723012;
 b=HtPHrKkCk2+ufRGRuiDS8xToZH8HlyH/g6DVyTZIrceW9kaFXNxK1B98qt+Lppicwc4J
 8dzpPzA0iCkWa3HMfRmfZ7upAof3xGiR0KHln2tXcqSwdNGkk9paGz8Km+Inulgavwzxb
 0eI939qkkdqu6pTVl5FjRN+YCGD4wEKxvPx0affFlmRwf+m86ktmBqIv9szU3pFqjnI4i
 g595Q5lFxcM2Najk8BnOWGivuWTalnknNUeF5hIggmyG0c4xTWFzowY5D8Gm6RtkenwMz
 rUQEFQISjjgVquIGqQHmi5lT8eOTXOWpe87dlwg5TSQH3KjRsMqZhAVRHPpTJ12T2fQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793723012;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
 Subject:From:To:Cc:Content-Type;
 bh=siM8Df/snDn0jLC7QUxpaD63oeFqtwGPtlZ0Xno7Huc=;
 b=s6Vr2ApguSURi3UqkSt2ZRthrBLWlO4gn4bdAHkExPWpvsHISr72lZFdH+zGxKeRI0ai
 l/1eRXhST2KSasqGMWoUskFq0qQWY5L7NGXLoLWIy+ITUs7rv1UCOvN0DSX2ADIoltObU
 bs8CuaGyZH5JuaDqquWixQTLO2b4UPrgdTAsX++JMtC5YHIA7qfS0XeiFG0vggPPhAswf
 zklFRtSn2XgC5eEmSTyI+IsUx99oKjYzO44ubijwSqDdyhY32RLUqnzhyvpREqne8Bxfx
 2NLMuhS6iLgek+SbpQIxd6MHpBPsI+bVlqGhZKzXCH2irsGvtDG3HYQEy/oDiK2qHKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=iokX1Ngp; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::546"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::546; helo=mail-ed1-x546.google.com;
 envelope-from=3gqrqagykd5whnevvkckkcha.8kiejpah-sena9-h6jheopo.koqkoh.knc@flex--lrizzo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=iokX1Ngp
Received: from mail-ed1-x546.google.com (mail-ed1-x546.google.com
 [IPv6:2a00:1450:4864:20::546])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEBE840704
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 16:23:31 +0000 (UTC)
Received: by mail-ed1-x546.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa4d7162so5584653a12.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 03 Nov 2026 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793723009; x=1794327809; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=siM8Df/snDn0jLC7QUxpaD63oeFqtwGPtlZ0Xno7Huc=;
 b=iokX1NgpolwA1rZAp9Vvt6/ETrDSwnSOorv5k8p9tQNZVgfZzpWlwOt2rdzcNYVCiT
 hDZFd5s8xNj5srC13siv3TYjtH0aptpgDzGZ8JCE/IFvKmdiUjTCNraUG1H5WZPImL9h
 P2SGCVeC16LWKVPcXmilcPELZ6GsOnBl/vkippSIYN4L3PJGdAiLEvqcTUQ0YSzU09rI
 2cTeBN95ttTu1HKFE8elMdLMFAh8+C4246p7VrMaArxHbPHbfy8ABcvX7riTmby0tfXy
 vNWvMdhOIPgkQXr/BlL8jSaxQDQAG8ujhH1kwaugzvW4eAdW0qpRU1xOhwmowt1EvzAY
 75gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793723009; x=1794327809;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=siM8Df/snDn0jLC7QUxpaD63oeFqtwGPtlZ0Xno7Huc=;
 b=Y2xZIbCn5rMrDXs3jILGa3gJ0L0gkI2S5eniT1Ec+QqV5qwLaG6qUZtbRm1sNU9Bxj
 d2zMpGsDXYEipYwCJqDlk6DBhKREmIi10QJjBbCdNGIMZzMbBnEqXZFIMu+/5DjC8h7e
 94JB6CJEJSfMU2IJSRSnqsZC8q/X2/qTefSIRuX8+FcB5FqslNiOnps155N759YF8xCY
 dNuR10S0imeqyK6oOfMBxsSK53/lqrKWVz2hytQL5+NqNQose8S3gI22wjKbkCJ9j14H
 hZCA8ym1/jDsJ7VC8hDz2wkze0u2bbB0ux35IYYfsAfiLCl13d2oL81juIH2TDbBtz1u
 Z4+Q==
X-Gm-Message-State: APuU4Z+2NJl50ne3RnTAxgbeAC6l73akQMAFLF5C/oPaJSvY+YUN7et2
 U8MANm8jFG7WY/Vhj6EI7VfEglxqmXK5w8AODAODxlrHrrGMVNX5wKzl6yi3lrxxFSWUBh9evim
 aCC2tOw5Cu+Fivug3ZbcCkOdWn+vcoRhTxRpF/P1/SRnjVBGBia6iCAOHkI4OOPTPJjISV8pD0O
 KHz+e3YT+IqIzppUThsxRvQ60xYs+mBwdjHmcCESJWHy76MqeMYg==
X-Received: from edj17.prod.google.com ([2002:a05:6402:3251:b0:6b4:21ae:bf65])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d313:0:b0:6b4:1d53:519e
 with SMTP id 4fb4d7f45d1cf-6b4d4d80728mr6622485a12.40.1793723009040; Tue, 03
 Nov 2026 08:23:29 -0800 (PST)
Date: Tue,  3 Nov 2026 16:23:23 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103162326.3615979-1-lrizzo@google.com>
Subject: [PATCH iwl-next v3 0/2] libeth, idpf: use GFP_KERNEL for the initial
 Rx ring fill
From: Luigi Rizzo <lrizzo@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Luigi Rizzo <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
driver fills its Rx rings at open or on queue reconfiguration. That
fill runs in process context, right after page_pool_create() and before
the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
needlessly restrictive there: it can neither reclaim nor compact, while
the initial fill can allocate tens of thousands of buffers across all
queues.

Patch 1 adds __libeth_rx_alloc() taking a gfp_t parameter and turns
libeth_rx_alloc() into its GFP_ATOMIC wrapper.
Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
to GFP_KERNEL.

v3:
  - rename libeth_rx_alloc_gfp() to __libeth_rx_alloc() and put the gfp
    argument on its own line in page_pool_alloc_netmem() (Alexander Lobakin)
v2: https://lore.kernel.org/r/20261019210604.2433620-1-lrizzo@google.com/
  - split into two patches (libeth helper and idpf consumer)
v1: https://lore.kernel.org/r/20261016151835.2500807-1-lrizzo@google.com/

Luigi Rizzo (2):
  libeth: add __libeth_rx_alloc() to specify allocation flags
  idpf: use GFP_KERNEL for the initial Rx ring fill

 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  7 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  9 ++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
 include/net/libeth/rx.h                       | 24 +++++++++++++++----
 4 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.56.0.385.gac671c819a-goog

