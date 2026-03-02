Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D3DEA4E3A
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Mar 2026 16:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4381F83BCC;
	Mon,  2 Mar 2026 16:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WcqhGKDh-cHj; Mon,  2 Mar 2026 16:14:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75B7882CF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772468045;
	bh=GllBRQ+/5lw/YKIoqIlltaCvkXN3t0K2P1wecZTMdfo=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i1491Atgc1A7eCXBndgaAXVEYLp7cA+eBE/yV1UK1QQLQN3nR/E2r+ji7Dw83P0y6
	 nU2vHNns7bJuaMAe7uhPjoDGbC3ZMTMSbYVmD2ldRN33OqVSntizHqvCH40jQFrWVq
	 0goNgKIaez/h5Ltsgx31vZKTT99jQfP4xliVIwYrnDHm0ryX9ybAsfr3FHSlKcSYkG
	 ddVVl5iWS7WV/ROIuousft687HE8NehQq4M0+rIcMZFJNo3KE7fd/u33uAsLqhpB7w
	 ixeX8UCuucZ66oEaEvmiY/jIlJ2/tQ6GSkIu5xQTQhUPYnBeegR30/w+D3ISP9CBIl
	 LM5dSCruei/Mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75B7882CF1;
	Mon,  2 Mar 2026 16:14:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 998C41EB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 16:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EF7840BF7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 16:14:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBmowqIm_Dz3 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Mar 2026 16:14:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c01:e000:3a1::42; helo=ms.lwn.net;
 envelope-from=corbet@lwn.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CD1C24095B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD1C24095B
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD1C24095B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 16:14:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5854040C69
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 5854040C69;
 Mon,  2 Mar 2026 16:14:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Kees Cook
 <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260302165433.27f11148@localhost>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
 <87sear2kbm.fsf@trenco.lwn.net> <20260302165433.27f11148@localhost>
Date: Mon, 02 Mar 2026 09:14:00 -0700
Message-ID: <87y0kaw6nr.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lwn.net; s=20201203; 
 t=1772468041; bh=GllBRQ+/5lw/YKIoqIlltaCvkXN3t0K2P1wecZTMdfo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=f8pn8U6FA7kUP/r8iFJZ4rWUypHnzoaqHWxdAGjfHjokYaiGJKCr7IU0F2JeN/8Fw
 azpeD8ldqGCxtqmHWLxHS49TZl0QI+PrcVa1ESn/HNUJLsJpACllhhxKlZ7WWhWA0G
 4aJvqrqR8VuLoM4+Eg+rb1g/Si03GSmPlar/FE1+ppa4Qndh/WT11KisZJg8mqwbVh
 /WzQmizJRbq2GmBEJHki9LsLvF6IsnP61jEwvwgciTs1BsM2J6ZOLVi4QFAAp0/ZhL
 xDEN8yE0rRR0o2SHCha4a+omT/xNujvFQOxlgrR+kzRwwpwg0ORD4R3MLY+vZKFmpC
 3fI6jawrtR2kg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lwn.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256
 header.s=20201203 header.b=f8pn8U6F
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> So, instead of merging this patchset, I'll be sending you
> a smaller series with the basic stuff, in a way that it would
> be easier to review. My plan is to send patches along this week
> on smaller chunks, and after checking the differences before/after,
> in terms of man/rst/error output.

OK... *whew* ... that sounds like a better way to proceed :)

Thanks,

jon
