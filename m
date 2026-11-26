Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E985606A323
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=yHQFxPaP;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLuArq7D
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBDFC405CF;
	Thu, 26 Nov 2026 02:18:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wJcnNhk0nHNM; Thu, 26 Nov 2026 02:18:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5995D40643
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795659499;
	b=tWaO/kjP5v478n/yQ1DJbwltYlTB7LcZCEjVlSCmbhvXec5nkvYG+kAFNvqKZ61PpmP/
	 xxGkd/UOBQDA8unGMlrYorFMycMH09AK17egX6A+HPgDU+QHq6QFtLtuwIdrC3vA8K9me
	 UvUSF6jJ+8sMrP3D2OHsqIeadfvIfKaOMebn8TbYCyWw9F8WFOqFc0PUP6KwUJerg2EY1
	 VwDSI9pNVpfNmof8XGQPGBpPOMa9ZgcU/Vv9KVXLaPtAxRkuu/qpz1vvJfbxVNE1SpO1b
	 PkabsapAYq+Oy8J+Hvlh711fpWQ/JkQJ+ZURRzJtwHU2SiGKWyCuWbRmqfChoFuE2TA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795659499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	b=cQR4ElToCg7MDQMpKEUaj/jFXrAQXYdhvZJmCroQVJjAd/YBZba1yDQAfg5zuQmjWXzQ
	 WX1u7DKLbLQ84uQfFe8/+MFTo/QmUiZF9ABz6yD9M8DxAIefbH63LEbvXoAHnzVi9JKCD
	 9nrD3DjDmiaR9jjDI19MWv2UmzzvJLWwo8oqAKC24qoozSEFZwaD3HVowPm7qRtWj2lO3
	 HUXX4Gtmb3tD4MOAlper83KWe9pAgFLF9IpPhNQIF75Qp4cnYWQ88yplvR8IM3ww8nzJS
	 XqiZWCNid2HABgwVyujcV7u3Zea0dpmw+nfzC+w9XztBp1acOp8JvCffR4KCpSRKEtg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795659499;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yHQFxPaPTgth1JjiSrYDxZeqrdrTomwby+owwkQAP8pSdjFOAOf/y97Jb3OsUp0G8
	 S7fbsMMAP51Z8ahrclPvBAbSPbOTypNwrbEqNlI5TiIsrqqsCyKlfEl/xSRj+DeGEt
	 TnV76vCAe+idD3VlBEoSBSVBfst+Gafege7iNH0oDurnDIetkipN+M8RthQGvriNjD
	 dW81GZ3BfDlZX0yfzxOy01z+5mwALUhcaY1oCaxAlqk58GIkpxjckGhmKYKmQP6jlX
	 ixsby6EWmuT+BhwrVgwld9CMm/D4M8geAY7FOfVWVza2qCzqFvVIeDUMt7tZM8MogQ
	 +Om/OjZ4A2ZHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5995D40643;
	Thu, 26 Nov 2026 02:18:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AB3632D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 02:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C9678087C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 02:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dBxXsBBy_k0V for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 02:18:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5040D8085F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hLuArq7D
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5040D8085F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 02:18:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5748C61B14;
 Thu, 26 Nov 2026 02:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538801F000C6;
 Thu, 26 Nov 2026 02:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795659495;
 bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hLuArq7DazoSFkz0wELCN9Gom4sLBmCEA0yU6bRpnWEOD2IMn59lFATXBhFXbmfZK
 hYqW/Kzvj4kk9x9vVwRc+Mn9VVaE0sKzBXkv2O12V25abpJim3DS19sHkPRv9c6sWY
 s2ufk1BlJfqzPObmGynVCwWqiEBvBkhG7ZEWkiB/W02oTEn4FahATQKhWCWkdoBI/Q
 6RexlwPcOAqPCEdGQ/YoMhsfawN0BGdJ5ppjrikm0VGiket0DK2GPZbMXmH+RickFt
 gKega6aYM7j0fzVddKkwtkS9zeMqq2ZZUhSxuUvrbvfiKOf1RUVS0bf15xNIkWRpNP
 qIEJdNerr7faw==
From: netdev-bot+sinfo@kernel.org
To: guohongyu <guohongyu@cmss.chinamobile.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, alan.brady@intel.com,
 stable@vger.kernel.org, 13057616121@163.com
Subject: Re: [PATCH] idpf: fix vport_id used as array index in MAC filter
 async handler
Date: Thu, 26 Nov 2026 02:18:13 +0000
Message-ID: <179565949384.3294.6218603099017752049@kernel.org>
In-Reply-To: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
References: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
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
