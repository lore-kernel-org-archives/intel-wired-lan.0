Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC4DEFCE4B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Mar 2026 22:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7837B408C7;
	Wed,  4 Mar 2026 22:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kki0_4vVm3TF; Wed,  4 Mar 2026 22:40:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79570408C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772664013;
	bh=QFep6DoXCTa6MHlsiX+CObDNlX2M5BuqRR2s8vPNjQw=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rdqXp2KaavsxyRZCLSSar1edqPE+2SXB9ZwrFKpDTKwBo2TyWXJ4VGkdnK2U9/Vrj
	 ZbNajdu3Y/J1Kz3WRjeFRYfiGUn0Zm/p3kE+Ih7BIs5ErS0MeRhHzCpodLfJadaePf
	 JsFGExfKdxOLYCrQKdmGul9iU12TfMfK28IdR328Z52Ak6PQMo6dpY4683790I3xO3
	 XyJLFtzKGeosTOiA4OLwnYny7NKZ2nbyrAP8DUUxeg8M9gFaeDtYUcITh9FtmtrHXz
	 ajcxrConrFyCyG5MzorQ3KyPLACW4Yynbu+9FHGLVJQfkDwSc/cPRnPe3woKkjCvOx
	 ZGvvAQL4A8wdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79570408C6;
	Wed,  4 Mar 2026 22:40:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 572EF1EB
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 22:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48E1081466
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 22:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9hTRbK-1BU5b for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Mar 2026 22:40:11 +0000 (UTC)
X-Greylist: delayed 365 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 04 Mar 2026 22:40:10 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CD27A81402
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD27A81402
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.79.88.28;
 helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=<UNKNOWN> 
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD27A81402
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Mar 2026 22:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A78E940B4E
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id A78E940B4E;
 Wed,  4 Mar 2026 22:34:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@linux.intel.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kees
 Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <352c3f9f8ffd2d031c86a476e532a8ea6ffcf1ed@intel.com>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
 <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
 <878qcj8pvw.fsf@trenco.lwn.net>
 <352c3f9f8ffd2d031c86a476e532a8ea6ffcf1ed@intel.com>
Date: Wed, 04 Mar 2026 15:34:03 -0700
Message-ID: <87seaf442s.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lwn.net; s=20201203; 
 t=1772663644; bh=QFep6DoXCTa6MHlsiX+CObDNlX2M5BuqRR2s8vPNjQw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=FFoWFdvKTGVVYBua1siObF/ey46mYxmOLcZGV2bmR2fbaG6NwxZ3th2uh5jbu5utG
 0qB8XWF6PqZ14mHP/DYJKy+g3i5IAfL/vXb+tYHDuPZFawpGT3ysTRYqldztWkiTwj
 kjojNazoDd05ZY5le9rksrrzwAm3IzxuauTFzhxnzwEH3+zHvFxTiLkKc9qq/Ma8xA
 ptUz7PtIv/b2FJZ8P3JuSzpkI/8l7U3T96cGfvEDJ/5PwBuZMX513Qs+F56zRvqBLz
 KSiGjd8eTlzi41qo48+AR3nRw7WV1cwHxr2IOUjfd2XbsvwNy1wv7aeMWN7I7sCGIS
 KDeyNFJQM2Gyw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lwn.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256
 header.s=20201203 header.b=FFoWFdvK
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

Jani Nikula <jani.nikula@linux.intel.com> writes:

> So yeah, there are definitely tradeoffs there. But it's not like this
> constant patching of kernel-doc is exactly burden free either. I don't
> know, is it just me, but I'd like to think as a profession we'd be past
> writing ad hoc C parsers by now.

I don't think that having a "real" parser is going to free us from the
need to patch kernel-doc.  The kernel uses a weird form of C, and
kernel-doc is expected to evolve as our dialect of the language does.
It *might* make that patching job easier -- that is to be seen -- but it
won't make it go away.

Thanks,

jon
