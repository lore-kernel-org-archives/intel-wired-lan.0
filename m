Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FBBCC6B1A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Oct 2026 13:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 193C2607A9;
	Wed, 14 Oct 2026 13:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wl371AE-xmJE; Wed, 14 Oct 2026 13:30:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6EACE607B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791984616;
	b=JWi2SdRQ0cT9UzvkDs9+4nYEBVD/LHHO9mYl/S3VYaVZsl2hBHOgXiwN4RJ3YzivL9co
	 wjMPVbQ6WIaS1gPth7c+ezG3QqlGOwnZkISSQlvNeXs7p2GHwgX56b8JBWFYDOnvCEaUq
	 vC9s7dsVWtbBVW/EcHXsE4Gf23Wx5GU1jkH4sZrSYT8lZoLClxl0HhuchEVFN8Yd/SeTz
	 Dpakxditd6Q6JJdL7ATgHlTAmMceJ38wZkgSJXUKBoQO9OtlNzLw0V42Ir2mD95Ws1ayl
	 q2ip8PhfJkqfO9sP6EH52qFroyHPbbQVdZENi3pn2338o+lcVlB4rOQctg3yEq8zZ4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791984616;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mhD4IKfkuUbyMU0v6DEvobnYF3a1AdfM7IAhJ/CNqVA=;
	b=syWjiAaTZIOWim/KLq39iOa77IVIYht3YOoI/uWusFl+30ROITr9sE6ks+q2xqThIQJR
	 QO7awmryg7JpkXJlKypXz8CmXr0jKbs1ViZckcwkw/hPLb3a8VscZ5ntMlSlGJ9uCOzhg
	 sheTAqH3ZdNthIxAA3kL6bFYkU5RZ8yJp+onAZ29ioGJx3b7Ng5IkY4+PskKkVXKo0Vs6
	 iPfHmWShAwdn6mGmziQNuADENHAsCZ6ksRBj8xLor80UYXpfyv2G2shFmElQcF+wA8GLT
	 xrhJLypZzTQ2KIRgbSDZSm8rU9zYL/2L3sLQXiRTSGFttBgIGUrhRZQWMDEUuj79tdw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791984616;
	bh=mhD4IKfkuUbyMU0v6DEvobnYF3a1AdfM7IAhJ/CNqVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sxbpiNSshKPmfYGMAkjOxfFqRcPCdgj2kwrtVqgZy+bcFoE7yZHLDRLLrXOjmoU52
	 AFIQdjE8yPATskhwyMUBzzqEj/FnyemUiaQO9j2q59MJruza+siUCnpx4rac2UtQWq
	 /Pn7xOEe1hkTJkYcLk2Rww9dVbKtjYzEw/Umbh/WNwu9BK1+xBxtpDmTUqz40UYwOs
	 NAcH/eyjNWKp3aQQmYhFJwZJxo0XrSk6ZJ/VGrmDtzwYHa/P+QCZvMx+ZaWu7kGVfs
	 iZXBSz1dYuE6mWcQrqdSUVD8H8W/nLetmrfUsose2QjM083T4JujXQACMc0BlZmVew
	 VE5aOq5jUtaAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EACE607B6;
	Wed, 14 Oct 2026 13:30:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CC252A8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 13:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E39A80DA4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 13:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bg2xV5ZyNL74 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Oct 2026 13:30:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C48280C23
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791984614;
 b=BLXIMb9R/XWUCeO3JplbJrKEiL8a9TnnPrLVmP2YbpC0ITIJzwlga5eVytyQxbsR2UXC
 pXlII8Cpr11Om9U+oKHZEcgkX8m8d8CmWpeMOjxbGx2fzpcmScLezWQVf5/lT6bTUFp3G
 FNc4ZBVLw1h3+frO3WPBJR9Fxdfj1OtBWevElp2l4KL5KenRgUbcVFnWj+uNNOrZ7N1MD
 SpO5b1DaAwjAhaMv3hCXvhpf+Aie0wQfF6y+eL30XwTwfK9PTixkLXDdVhwKca2ca9Zsc
 fypsmBjnw9b2TMyOGMfm5njO33u+3X+G2O+Md/Tjh1jVVpHV7HW7LVu8eBnds/FH8Dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791984614;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=mhD4IKfkuUbyMU0v6DEvobnYF3a1AdfM7IAhJ/CNqVA=;
 b=A/5UToI3JZIusUnY58RVCbDhH+THEjqrakclJyHKYqX+32Tpy5TVHmqjZRn4+5xI2sMf
 cI/lEE66uz9ZCTUntF0YKPzf0iE1GpXZ8qSDBKgjDMranrX6pCTHDH9SBwwIaUEznKwXg
 jzrdsf92jTNdX5sj6QbjhPsKjq5wRGzlM6d12Vltg4Fv75IZr5tY9Kn/J3KFuv10jOp3X
 DDWCbwdFn/bvDeMlNX54Zrwk+0A45kEKCoAXFp72MYAagNJOb+sPHswwF/9NWbS0oL+nZ
 Z7enFNiKRU1M3p/4Rsx600jE4EPzMIrAy6hNErFPlQnikfF3IFnS2fabikTLOmKroSg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VtUZqAVN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=VtUZqAVN
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C48280C23
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 13:30:13 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ab066bef7dso276288a91.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791984613; x=1792589413; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mhD4IKfkuUbyMU0v6DEvobnYF3a1AdfM7IAhJ/CNqVA=;
 b=VtUZqAVNeYb42nUOsBqZXL6YCRpAyUDfMUFFxt/BKLYio2RgCNh5ZYA7hjxKm5VQnE
 7F8j6qdxNWr3AvTYZ+uftY/DiWhh0j/3g9U5ALZdWd/hN+GDX/WjNizyM+DpOsSYEQXd
 QDUx6Nx5Tz4gX5MbQwhskly0Hq9ur4HsBEJoqeiU5b3ypEMyVTJkTch3tz4CSMSVd2/h
 Q/283BIJ4LkiXmgPvRmQWIc0Vt5YhvFURU/u1+5fc2CPy0UfkMY0X6FyHZEC1F6SBWBx
 MQ9Ooq5brrSC3XhrBtpPxDyICBwU/0hOCVCioiHYnBfubBTp/Vf0ARMJ3IT6n+v2Kdgf
 SH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791984613; x=1792589413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mhD4IKfkuUbyMU0v6DEvobnYF3a1AdfM7IAhJ/CNqVA=;
 b=hCgCOwDIm3rfgqHSIw0kABTIpTXEZeTeD1En3AXShk4R2ZnJBLittvYDqvWwOFlO6h
 XE82hTrg8bf7B/7oEOkKCFAGDokim6+ir5CjtJ57KpsSGAgkH9i7U4Z5CFkOD7l+FUX/
 Eo4rNDVjHeYUqI3Jv/UrZFSFFZKMMju+5m+KyEuSOQNwcmHny6yNXRpyf8yL7icVlpoc
 ksObt9jZhqFR9SewgreUnCwMuQTfwYX69ewx3zkwtSEI+nnxhlkXC6gXkXZcFnvTU2Vl
 V1fuwEqhWTnZ+Na1brzQqEPiv31Q9YBbUNGQ8Z4zfm9p7eTHCmsyPK0cpIo922MW1FKZ
 hzKA==
X-Gm-Message-State: AFq9FYK1P3187E5u5XXvxq0LcAydhTZwmo4OuCEx9d8DGd65lywNjg1k
 z4uwM5Y4XIACLuYpif7tkCTd2Bjqh3d9wKrAaLBMcT2oWmypBACUA5278Z5VhKB04Kw=
X-Gm-Gg: AYBFou22FbTy/2jKDheJ1LNkfWEeK2QY7oZ4wxownWfNuY+/D6bAW64l4MM6mHaUxAD
 lvHvCJU7dp0YCLNO7dWPng3v8ehfKBGgIF5n0+nL3FXgZOojnZmO8osqaiODCK2zFIh1tCwvTDZ
 aCPa1BY8zvteLHyNDk5YCEElaIHJt6pj5wnxE97EBW6YMlnTrvk1gWl0qbyCb4mlPLLwY2HK9G0
 exfc99AYjiqF8vJS3W4Lcy4s7JIw+W/L1lTHPZJkMcd+nb5cPqNYe9+9G7wD0UzSZ3JedeM/yuw
 H5zHmC5bnrf5jWcBihcsCMZ/AFwWWIBW1gHWBBGAnShvuIHL8WxjY50fiysuT90o84QuNy1iiVk
 klZ3tRppOnCfNQNwOiHcJMVm4eNa5xbC+ryqX3JfxGuHjRWyfHlc2MKAuUEj7ZEn6iMzD4EwjXa
 HWAfBSVhS+Ksb4Ii6oSsL6lD9CSwz/f2ik+y3FH4skhwBArJurwSjGxCycm4epNzOIiBqm2sjiX
 GviHJf+96oL+Q698DT52zufvtKmCAwjmxl1f9asSka+WyFhK3cUJgQEDmOA
X-Received: by 2002:a17:90b:1d4f:b0:398:c3ca:1ebc with SMTP id
 98e67ed59e1d1-3ab3a91173cmr13060295a91.18.1791984613094; 
 Wed, 14 Oct 2026 06:30:13 -0700 (PDT)
Received: from C9P9279WY4 (206.135.124.34.bc.googleusercontent.com.
 [34.124.135.206]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f202aeesm4800199a91.5.2026.10.14.06.30.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Oct 2026 06:30:11 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: sashiko-reviews@lists.linux.dev, netdev@vger.kernel.org,
 Emil Tantilov <emil.s.tantilov@intel.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 aleksandr.loktionov@intel.com, decot@google.com, milena.olech@intel.com,
 joshua.a.hay@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: Re: [PATCH iwl-net v5 3/3] idpf: keep the mailbox up while tearing
 down vports on shutdown
Date: Wed, 14 Oct 2026 21:30:02 +0800
Message-ID: <20261014133002.99917-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <sashiko-outbox-171247@kernel.org>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
 <20261013121224.84482-4-luckilystar08@gmail.com>
 <sashiko-outbox-171247@kernel.org>
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

On Wed, Oct 14, 2026 at 12:13 UTC, sashiko-bot@kernel.org wrote:
> - [High] idpf: NULL pointer dereference in idpf_tx_start during shutdown

This path is not changed by the patch. idpf_vport_dealloc() skips
idpf_vport_stop() and idpf_decfg_netdev() while IDPF_HR_RESET_IN_PROG is
set with or without it, and idpf_shutdown() has lacked the stale netdev
cleanup that idpf_remove() does since 4c9106f4906a. It is a separate
issue; I can look at it in a follow-up.

> - [High] idpf: SW marker consumption race causes cascading timeouts

The set-then-wait order per Tx queue is the same as in the current
code. With the default split queue model each Tx queue has its own
completion queue (IDPF_DFLT_SPLITQ_TXQ_PER_GROUP is 1), so markers are
not shared. Where they are, this patch limits the effect on shutdown to
one 500 ms wait per queue set. Setting SW_MARKER on all queues before
waiting looks like a reasonable cleanup on its own.

> - [High] idpf: DMA memory corruption on slow CP during shutdown

This is the trade-off discussed on v3 and v4. Without the patch,
shutdown sends none of the teardown messages, so a control plane slower
than 500 ms is no worse off than today, and a responsive one gets the
full teardown. On the tested devices the queue-related messages took at
most 240 ms.

Thanks,
Tian Xun
