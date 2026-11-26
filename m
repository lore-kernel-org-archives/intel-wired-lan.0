Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE25606A323
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YQpOiyJN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFhl6CYz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32E084085C;
	Thu, 26 Nov 2026 09:38:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EVxa84qT1usm; Thu, 26 Nov 2026 09:38:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1A1840849
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795685923;
	b=BjcVQ225ReKTyHd5h8H9hVde8Sy8ZUpaik57ZPtRDkBfW0/8Dpw2B9kzqpx5HQ6uGsc8
	 FhhY3XkH3sp0zVV0ZYIyzTm/O5AtKR48jCjg/lmFCo4I3oRrp9gscXSyjHm/pDpUhS/uj
	 qByAlbQJb2jqQQm4L58LEstmBFWRTFGZG0aqkLupnE4F0XEN2Rh2OF2UMiGq5rkqz1lHz
	 tq/IyLO1qkVl+cjJdpMnGtwWH/yBSPOSz5vsPXB39zVaOKWZinkILz9xFBSlPsDahHcwA
	 JFLwp25r6tbe8GrtfljaarwsBRKyuNiLhtL9dgIVbqE7FuUaM2CqY+bd+NVud1KbtPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795685923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	b=R/3enTU2+KpQxjPesXPbJw653DX29mEU2WY2lmH2GJYjW1wgu2uCzrLiMou9QTfzOWh3
	 EK/Wxb0p2MhtLNY0h4m2M/+V7dJvEpreriJWdXxJQgze8eEVc8/SulYHmBQa7jaUT3uN5
	 1S1PdaYwnwLBeRaWD54hZBjsEsutBFDN+E2JrvdY9y50uMQpusMbRHTLTDYSZfLJAGMDO
	 IC3ndO6jxhS10KbzcCDK8y59hg9rSgy9Jjy5ar7ombCuYd2qoIdGCFBSifmqSt1kpCV+n
	 miNk/zxUYf+o/Zl+FNDymCD+5kFz7ScDFwpe/v3gh2g0eyqmZooV0vYssuOd57uBgmQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFhl6CYz;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795685923;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YQpOiyJN/vNqL01jGY9agIgxShN3H/9gFww0M45nZCVRe7jLfR2VogZ0jphgHVM8W
	 gmnlTJSIALZukw8yuzAV9KUbiv7YzIFVX0PxQiP5Rjv/VIIwXxiehpnYNDhu7gn7TF
	 PjepSmDifayiFf0LzLAecJdlMDKbY4m6kpZS/RftP7VJiQUdbK7P51RkNx5/8sTTeO
	 LbFItZJTbyAhugcuRLom6VkiSVRx8gy8VWJxtXXKKQsQKrNkbL4k5CATgTDGqNuQ0G
	 XQ7JLaVuXOB62I39Bh/j2m+teGKhWXAPIL3+v5sOUPoXsR936VbUCe3BGklZpF+Lkn
	 eGT6x99gZXPFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1A1840849;
	Thu, 26 Nov 2026 09:38:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A18F532D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 09:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8779E40849
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 09:38:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3vfDf8dWIks7 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 09:38:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DB42A40659
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iFhl6CYz
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB42A40659
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 09:38:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 93B3B4651F;
 Thu, 26 Nov 2026 09:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98621F0093C;
 Thu, 26 Nov 2026 09:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795685919;
 bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iFhl6CYz6OiQENs16KAC0nDztl4EYOGUlvCqOMChSZr6qXJfUIr25cpQ0TE9wYuHu
 cDbDLsLbkpLlX/9lRGCILr1e3jKZYVVmrvwutf9rv2mAfPCYp5LkkIGbv9IlrTF2U2
 8nSKc0PfDwTCpDCz7sIBuOVsC+0VVFHYCmMGdMosN+0pF7Hxx5omv265gzDzN7gI0w
 5/P1F5fIQIEvk6CQl1/lXTi9AVJg/sGRaEXOM6a/Lk0UPCuFxSiPKOwPWsGVSIENja
 enL3GJZUGRjn/EpkysGsUsXYSMtMPsL5vFuQ0tvb8QI7tLEZ90gfWKGaQyaxBwBooQ
 jK7NLsx8EQgtQ==
From: netdev-bot+sinfo@kernel.org
To: Hongyu Guo <guohongyu@cmss.chinamobile.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, alan.brady@intel.com,
 stable@vger.kernel.org, 13057616121@163.com
Subject: Re: [PATCH v2] idpf: fix vport_id used as array index in MAC filter
 async handler
Date: Thu, 26 Nov 2026 09:38:38 +0000
Message-ID: <179568591819.3294.7791318700708101918@kernel.org>
In-Reply-To: <20261126092627.255454-1-guohongyu@cmss.chinamobile.com>
References: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
 <20261126092627.255454-1-guohongyu@cmss.chinamobile.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
