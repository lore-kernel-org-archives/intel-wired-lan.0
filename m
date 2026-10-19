Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87D606A32E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=QHP4Iow3;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dVcVWdOu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEC6460749;
	Mon, 19 Oct 2026 21:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C3i27vDS9PVv; Mon, 19 Oct 2026 21:06:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 06B8260747
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792443974;
	b=F88naFI6+R0O9e6g0zHu8YgdxVGVK3STPrben8XrtoPRwTYI9BszgLxRcyrXcd2mtJgN
	 vrk/7PAqJGZ7g+B8kqYqb2gqJ6IpyD+mShZkM3UTWRBqnG1dM4dfr9LfyHqHd9Kxrj29E
	 rQhKTFex4OaaljDxkHHpQbO+VKS0yaEd7jQgPHZuZ0HH991ZXcICUUQJ/jZnz6RbjqLqH
	 7amARYu5yRKZ7zQYdXBWyNwA76Il1tBkKBhANINWZWNQt13vXnpCv0U75bSy0DDmHjI5N
	 y7smg90ce4qtC5ZY23z+kVatXIeIX5EovEuylVu8AqcTjd7dgFP+gSW+09bXn/PZUZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792443974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9MAmvIn08RerEdZ3pqVcuDHmjNgJDApJ50B7PsC0yxA=;
	b=miouHRHK4vW7OPSBhl9kpDDiu9k0kT0Go9ecE89YFdPLp/4ETfYGgH0AXrdq81mBGAJE
	 xrXSe/NkfUqWpZdwnEQFs4xlVDQjnLQMmEvPzs0izOFZXzBIcALRAem5JoTbEBuxGz+dv
	 i6eJMqs1BCbbx4Z3TaHE/MdCRnHuuQbFjnKXyasbXGKF2Wg7lCFqI4KsrwRy8+77Oa6WO
	 5JAzkjlu+DbYxLARkkfD+xrveZFCWO8zqyjuSoRRdPf8MAlAiFORjRNJMXMECdGQXJa4k
	 ZasOtRzOCibwI8KzXLCgbaC84GDo2vy7NgTdwZYTAd8dwDjSRcoQDBNjZauozX3iNIA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792443974;
	bh=9MAmvIn08RerEdZ3pqVcuDHmjNgJDApJ50B7PsC0yxA=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QHP4Iow3Zcj2yYCusY6fsfWfSKGTokkI3Gy7WrlNCLLB7n1l8nAeqog0WKClYUOd5
	 n4xR5XwNZBt1YMDDuJrWqOmFXUBcgWUGCuzHa776nZrQsAG9Zk+IflrrNLRmE/iVv8
	 qcDCF2RxKKnbkY+J0snKrdB5DHw/4OImXS4J5tl1QvXyaeb7HI6vsTgFHU9ehysrT3
	 wyH/JLIttJH6r6nJm8hTbCMJ3NLJG0nNF0tPCwK09BP490yHctfUdSVpk3EvZAV2KV
	 w7djH+8lHie9dkfk8Dl0V0elqAMD+JFGoCTsvF+qBkidbdD0RpKmAjbm9eehfMSK/T
	 xf7gXs8ixmchA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06B8260747;
	Mon, 19 Oct 2026 21:06:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C957F23F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF5FA4009D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:06:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IhExIZ4-Cgvo for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 21:06:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 85C8B4008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::545"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792443972;
 b=N5hZKacb9nvN2KBBbYsPVKVVn9YDlMdaERx771roq5R2TFJxctepvE2yjq6TcHMysTu7
 iFH1FJqnOSrEKmzjlTIwGd7RShI+EpR3QBeuz3dFKd0Of+fMrm7oDnUWZSadzvVEhSGo/
 RE45Oey1losGyx5mKwBLi0Zp4vs5ZyJNsOpD8ItYe+YXOV2WSdLQLihDr6wojr8aJRpi+
 DQeLOEundjsgfbG+kaeDl5gFyWYh34yxvJXiwooxAAP2VUXzwp4OhidEuHkanG9Ot7Cb5
 9fXugfw9qcVRJX5R/FEhuUN1oYezkxjyzwg0wPE35cTQP3viCc3MKs3yARtgijzJgWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792443972;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
 Subject:From:To:Cc:Content-Type;
 bh=9MAmvIn08RerEdZ3pqVcuDHmjNgJDApJ50B7PsC0yxA=;
 b=Vy1kmqgjPK7Rhe0JyMkdRmIYOt5l0tjmDT/X+YUudZRokZTcGrplwgjLuJC9G3wTawNK
 96PJQNsiB1jR4jnoSKywboqyVw7Le9P9MNGkaYMl1e/rFz5EDXXMtNG3TWlLThTgrwKrl
 FSpbY24JgGABb2vSVOiYKXMgbnyuiJdKdXGt8IzSyqaqC58/5YgXsoA38D8vPa1nqH4fC
 YZYkcDgmrS+XdVFpbYQnUaZ8wzdU5DiWTbIq9SJ1rTWf8z8DV8Py/fMRTCp2qEMqd1/5j
 bY04gxPtDQDV+hs0soznQHgCgfZAPjBSQXXkXMWQzVh0qRPTjJPFLGBPOUjwQtBvVYA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=dVcVWdOu; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::545"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::545; helo=mail-ed1-x545.google.com;
 envelope-from=3qibwagykdwuqwn44tlttlqj.htrnsyjq-1nwji-qfsqnxyx.txztxq.twl@flex--lrizzo.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=dVcVWdOu
Received: from mail-ed1-x545.google.com (mail-ed1-x545.google.com
 [IPv6:2a00:1450:4864:20::545])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85C8B4008C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 21:06:11 +0000 (UTC)
Received: by mail-ed1-x545.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab11f4a3so2172780a12.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 14:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792443969; x=1793048769; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9MAmvIn08RerEdZ3pqVcuDHmjNgJDApJ50B7PsC0yxA=;
 b=dVcVWdOuC1RhxEVQPnlL52SeG0Utv9KOy33HLz0dO7QZzhTFeSMKDEMTRIL3fZ1vWx
 KYAQ1olqkifusH+TamH9TbxIboqoVqBOU7wxQzyOaZ6gjE9yEKwLiCmtLmYPWljQoIK3
 nBFMQM/mJQtTwsvt/Rerqyk3XRsF8a/dMSC5B/0EkdbU01pIcDOtY2qjlT1SVBlktjKj
 rz+RaHrT5pf6xsABAPzBhJ5qpHs9u11xcmvR1Nrij74Ub6PClwKnQnP/oG1EtSWwCc9R
 tyowDMYDeYUsvElT0TJo52tcuzSsBEQGARj+7rOTyaA6Wsd3wy4gzvhxck97JtNPIiOZ
 3YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792443969; x=1793048769;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9MAmvIn08RerEdZ3pqVcuDHmjNgJDApJ50B7PsC0yxA=;
 b=Fr2wqOGis7blil6amBQGJd09Fui233rrELpaQtZicc2zy0MtfY6I3ehOnQMLZyXBEH
 c+QLHWy0hc+S1+RS8YqitzEJD9EfbPTXhQfVCKt+tmtl8RzOEwmjzuKIwGUiaLSKZ0Fd
 Fac82F7bXPuggABnxEyn6eMjz3Pm9IXZfhas7gpoUYn3jxX871Fn68e+HBqNrOND6Mj9
 Cx7mN7owhPfYH85Z18YDZF2V2Ra5224pOZ3JPmbShMqxixCcyxF9CSqvld/AweeVCYWL
 Jxbq6tZKIBOzahRrAutHI6+uSQcpcq3lAOZTIfspDcinfMN7BdO97/tlxeiLYF3XZAOe
 lMNQ==
X-Gm-Message-State: AFq9FYKgPx8TBiCnYpeNhnHkuRG6Du+Kq6ImEfj5hCDe8fHIm8N0TOvn
 wcmXoC3W2RMQBFdGj+3/JypRbjYmQqiELkXGuBI7GgN2kUG6A3RCcREnx52NPvSrYBXnau7pPJI
 EmSSyGB46oWBo22wxpqFhFYT5AB90eCCViDwLNfD/ozlePdp6kjV2V89Qjy2SQFwBuu8qZFJyOZ
 /4HV3NTaV+3SRDVqzJOIWrAKkbRVGnITlXcCYpG543ai9Z2WyW4g==
X-Received: from edvi20.prod.google.com ([2002:aa7:dd14:0:b0:6ae:14cc:13c4])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:354f:b0:6aa:f14f:5571
 with SMTP id 4fb4d7f45d1cf-6b3a81f6f9amr5851038a12.45.1792443968890; Mon, 19
 Oct 2026 14:06:08 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:06:02 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019210604.2433620-1-lrizzo@google.com>
Subject: [PATCH iwl-next v2 0/2] libeth, idpf: use GFP_KERNEL for the initial
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

Patch 1 adds libeth_rx_alloc_gfp() taking a gfp_t parameter and turns
libeth_rx_alloc() into its GFP_ATOMIC wrapper.
Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
to GFP_KERNEL.

v2:
  - split into two patches (libeth helper and idpf consumer)
v1: https://lore.kernel.org/r/20261016151835.2500807-1-lrizzo@google.com/

Luigi Rizzo (2):
  libeth: add libeth_rx_alloc_gfp() to specify allocation flags
  idpf: use GFP_KERNEL for the initial Rx ring fill

 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  7 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  9 +++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
 include/net/libeth/rx.h                       | 23 +++++++++++++++----
 4 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.56.0.212.g129ede20d9-goog

