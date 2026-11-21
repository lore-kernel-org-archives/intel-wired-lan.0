Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232FF606A327
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=K9YY5344;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xLGxHGMD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 060C7605F3;
	Mon, 23 Nov 2026 16:24:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mub2J6P6RBD2; Mon, 23 Nov 2026 16:24:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4EE6B60673
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795451091;
	b=ShYtAT8aBDCXUsPAC6puk0QD3Z4AGJbQH+EeVfg2QSCIaV3QFzVdroKx5BEGvXOzSEVT
	 HeRF87TmexMaYDhx8vCA2pZuZyzfPmW/QF0pqbw/VjDg7uvsdU44SErmq6+n+N/pp8qKm
	 sndLgVAbKjpkCgHlVvRxdiAlxos/ua/pelJqsfboasukdHy1X2tJ8Jz4cnflLLFpHPviI
	 Vk4wjO2kzhjOOGzrb+n3p0fM8YWtu0H4nS43VYJZIcV34Xan5Wa0Hs1rOc9wuZzo7Lmyg
	 GXNab0H43NShttasRbVjJLEoHrrpDk5kti4j9G3q5c6ERzdu4oZFXaCz0/TsqD8NDZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795451091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vbgwELF6CWUmH82cJRM4qpAueUKNM+gZeKyQBoi7/Ao=;
	b=Sdy0XMEpYb6cXxUIkFnCXt6XzoHreWryql/kPunyAUMGSEM+znSa4EMB8jGWXBnj7Edn
	 AGuoA4UF92DF2Y+2CQvItaRnfQwU3GGxH4sQNDhC7Kz7o86FZxu++1QWfux0PseZlZSXj
	 3VvT6yOYvZWiWLQxlG/uZ/j/EtyOAFmcFUnQKxRAbsm8eDthdiz/Jw2ZssC+qBP5uj6KQ
	 91SU4JQai/OASwP4J7+JZDH7lE0BwbW2QXb2LEiJc63lZPbq6zoQ4d1rgmr4vTVT7yR8q
	 fz2o/L4O6UmwSGOtxnBR7bgfcD8hi9hEdwxUgJPfvhjwwmpzOi+dKO+kA07gqwklkcA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xLGxHGMD;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795451091;
	bh=vbgwELF6CWUmH82cJRM4qpAueUKNM+gZeKyQBoi7/Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K9YY5344Ztxf83FgtwQLBsa4CkMEF2zzRF8H5SkGFyTgq17Dy1NgCQV8h5Bag99Vg
	 NhUSpiH7Zp057xRC9rLBwSLCjrMRgSFKa65ECbDFl2K192VJs2KztYsuG2y63kNdc2
	 JM53SAlhIJT/6tRgtcI0orkdy7YAROR+/Lf+iZRkEPtA7mFHAXqhYnF8OmsMlOTr20
	 LOPBdhujBB6XK2eagMOV59xLsIisp4CSTOqqu7f9Is0qVITVam71CftEoEkDOXUpak
	 +YLNUY2n/DPkqsTIgrF/VYHsgwmfHTuX3WWLHkhTG0QpQzMk+eKc3EXOn1E8vNeoTo
	 QedfdG1lhbSng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EE6B60673;
	Mon, 23 Nov 2026 16:24:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C70043A8
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 15:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE4946062C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 15:03:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rv7hPTDb4B-r for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Nov 2026 15:03:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC25A60608
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=takano32@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xLGxHGMD
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC25A60608
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 15:03:26 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3869f03af6aso544479eec.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 07:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795273405; x=1795878205; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vbgwELF6CWUmH82cJRM4qpAueUKNM+gZeKyQBoi7/Ao=;
 b=xLGxHGMDJVYpajXx0Kxl7LcEvAN1Jdx4nK7UKRKFvTH6VCmB/mEQT5OSrsOQsof+B3
 1n3VuwYaPRqFD1+dvzvotsPVttZoAjYSQi5eOzZRElG1oPfVX2TjVmRteQsilTStAmJS
 8cFUROXB20hWkYFvrxzx7qWWL2nMq9CnvccAIIe9M1YGRTw+5Yp1tZ6GqkfomZvjzPRx
 PXDaRBmlVuBEOWti5ky4rh5i+OWnA+SXeMn5NQrMia8wY6vP+lSPSKcp7HNs7+oZOBM0
 +9ETNwNuFSr0xpJLpLgEUBJpgNd+HYQU+syX0ZaMrNlXE5MA7elTMj/lmHHH89Z+qGmk
 lIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795273405; x=1795878205;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vbgwELF6CWUmH82cJRM4qpAueUKNM+gZeKyQBoi7/Ao=;
 b=IwvDPx3fZ3aCXDjYd70DLj2/DRGNuBXvescG5cajkSBd7Wj5nLbGyHYBI797+YIpl/
 Wp9vHdqJI8OgMEYunsj/9OqkvRy2YeqkAChI2umZHom6V7r0XXaF0OSfxbhmOeXiE2lx
 G/NSCTzuGIk7sZn9u/wj7+jiAdTGYqFgxXI7pZuRD+jkkjOeIgehgR8+xgCKduNXr+HS
 Fg7X6DMJxBJ5LM9mkVpF/dwY5gOw+IBpK4iKHmcZixS1aRfUJaIF+wBOZVr4RhIgDoDf
 vgMILjqCU/DhiVnT5UHCPLiMNuQaIwVKI0XD82Kzuf1v2FXgEtq/p/e9z8swOXEq0wW4
 Anog==
X-Forwarded-Encrypted: i=1;
 AL+hErEYpk1tXF2FJMPtL2d6W4bagMHB+q8nrf9fbFwI547IViA8WiUMRe1JJd0q6gs2tl08l1pAaIQFg02TGW+yXTU=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/tiZZwjR5dFBuYHvCx6iIn1kMNgX6JMmNztAATbIvTRNS++CFh
 mkZ7OMTeSGvlJBN7sJF1NSdN8oY0Rr4sCe7ii9HsSTclaRw0eIPduLMy
X-Gm-Gg: AZFdTZcaiuWj+OpIrtwUEbPb6tpgpSCZwGn0DuZ11FJCbFD6oJNrDexWUh+O3vrh7Go
 2mZ0KPSlxQUCW+0Hq9xLfQYDvierWbKdFEI6au5UBQB/lNLWfZ93/bxtlbuY+gSkoh28vldT007
 01romX7MycTQGM9JaGwdD5buERFRUixM/fzTRxAV4ANVZuhbqIV7zZudLb8UOAjJK5paR6efzT8
 eRfA++OMRau0rBrH1ktezXDnSveVg6lWjsTJPk1aYaM/CmQio2tEz6JHPskwgvL2+epPWhdCU5c
 70EB7PmE9148eLIRWSJzwffNDHNG8C4wyfX6inGDGpjkq6RGr3nTaDs4dUtsm70TcHzQKpf7ihW
 f2WqDznSQ4xeLwbiobmg6udXeC1/+z/9Idd8dQHIWi1UAEerbZk7j3bpyLDoV8RtmF9ylQz0fTU
 22W+wyPc0hvcnn00npV42WNUI2P+Bm6hzSH/QqpD3ft7Ykll9JpJyUQv5uzP82Yc2D4K2umq4wO
 r/gb2YXyQN+E8jzbESEY4F5N9a+RMqtDX7cnzRjT/1nvbxEqpDlJCEyFFk1zEAvQ7VHrQDUjjR4
 unZsg250Pg44PwkbfY5HvUh/xg==
X-Received: by 2002:a05:7301:5098:b0:381:5fe2:a079 with SMTP id
 5a478bee46e88-3856c6b010amr6448576eec.1.1795273405079; 
 Sat, 21 Nov 2026 07:03:25 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm16396954eec.8.2026.11.21.07.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 07:03:24 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Bart Van Assche <bvanassche@acm.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH v2] docs: kdoc: fix struct_group_tagged() parsing
 regression
Date: Sat, 21 Nov 2026 15:03:21 +0000
Message-ID: <179527340172.2367332.3292077208678045371@gmail.com>
In-Reply-To: <20260916214357.22573-1-emmaonana18@gmail.com>
References: <20260916214357.22573-1-emmaonana18@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py
X-Mailman-Approved-At: Mon, 23 Nov 2026 16:24:50 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Onana,

Thanks for the patch, and sorry it took me this long to test it. Randy
tested v1 and carried his Tested-by and Acked-by to v2 in September; the
run below is independent, on mainline d0f871bfb831 (2026-11-20).

Short version: with a fuzz-2 apply the warnings in the four headers below
go away and the test suite has no new failures. The patch needs a rebase
before it can go in. Two things below are worth a look -- the rendering
loss and the excess-warning scope -- but I do not think either has to hold
up that rebase; that is for you and the maintainers to decide.

git apply rejects the hunks in tools/lib/python/kdoc/xforms_lists.py and
tools/unittests/test_kdoc_parser.py, because of 2d72a4c09867 ("docs:
kdoc: parse context_lock_struct() as struct declaration"), which landed
after v2. The kdoc_parser.py hunk still applies. With patch -p1 those two
go in at fuzz 2. Everything below is from that tree.

Could you rebase onto current mainline and post a v3? For v3 I am only
asking for the rebase; the rendering follow-up and the excess-warning
question below are for later.

kernel-doc -Wall, warning lines (the tool prints each of these twice, so
4 -> 0 is two warnings):

  include/net/page_pool/types.h                   4 -> 0
  include/net/libeth/rx.h                         2 -> 0
  include/net/libeth/xsk.h                        2 -> 0
  drivers/net/ethernet/intel/ice/devlink/health.h 2 -> 0

Those four files are also where the descriptions disappear. The five
warnings above are about the group names themselves; with the
xforms_lists.py hunk alone kernel-doc instead flags the 24 field
descriptions as excess, and the endswith() hunk keeps them out of that
count.

Unit tests (cd tools && /usr/bin/python3 unittests/run.py): 122 -> 123
tests; with only the test hunk the new case is the only failure beyond the
four expected ones, and with the two code hunks as well there are no new
failures.

Those results -- kernel-doc -Wall on the four headers and the unit tests,
no make htmldocs -- are what the Tested-by below covers. If the v3 hunks
come out the same as in v2 -- same added and removed lines, only offsets
and context differing -- and no other commit has touched
tools/lib/python/kdoc/, tools/unittests/ or those four headers since
d0f871bfb831, feel free to add it; if in doubt, drop it and I will re-test
and reply with a new tag.

The rendering follow-up: with v2 the field descriptions inside these
groups stop being rendered. page_pool_params renders today as
{unnamed_struct} twice plus its eleven field descriptions; with v2 it
renders the group names fast and slow, and the eleven field descriptions
are gone from kernel-doc's output. Across the four headers that is 24
descriptions, and no other file's rendered output changes -- I checked
every file that uses struct_group_tagged. They come back if those comments are
rewritten as @fast.order:, @slow.netdev: and so on, which needs the
xforms_lists.py change in this patch. I will send that rewrite as a
second patch.

The excess-warning question: the endswith() check in kdoc_parser.py also
silences excess-member warnings where a comment uses the flat name for a
nested member instead of the dotted one, in files that use no struct_group
at all -- for example 12 warning lines to 0 in include/linux/msi.h, 24 to
0 in include/linux/mroute_base.h, 20 to 0 in include/net/macsec.h and 30
to 0 in drivers/gpu/drm/panthor/panthor_device.h. Each of those is printed
twice. msi.h has no other warnings, so it goes quiet entirely; the other
three keep their unrelated ones. In msi.h, mroute_base.h, macsec.h and
panthor_device.h the rendered text does not change at all; only the excess
warnings go away. If that is wider than you intend,
restricting the check to members of a struct_group_tagged() group should
keep those warnings; I have not tried that, and the parsed members do not
record where they came from today.

The testing above was run by an AI assistant (Hermes Agent) under my
direction, and this message was drafted with it; I checked every number,
edited the text, and the tag below is mine.

Tested-by: TAKANO Mitsuhiro <takano32@gmail.com>

