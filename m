Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93880606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=QGhX3BPh;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=ptDd7pi4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 704FB810D7;
	Fri, 30 Oct 2026 09:02:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R5Nrky47vBeD; Fri, 30 Oct 2026 09:02:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C3F5D81082
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793350923;
	b=pv3kZTNcod8pmvvvoqV/8tmvHarvCac+JZoFe163th0Qnpuv/Y8aEWTht/JniwgUU+SR
	 hRfJAOkgY5MnuMWkbq1VTILn5Zz+3l09NR/nNKmm9FgEEMnuUV9yH+Yi+FVy/yvR5AMQN
	 lkk25QS/jtEYm3uG9TL9+EBzrdKSE4bJBTSXU+xAADs/gMvVE9b0shlZDgsF1TdJFIeot
	 mKFJLD4tAwnXHXs9plytYhRug6EGUK5YuDnGU39FIR3KiyhdGjRdKr9OZToQWBLKUniQn
	 R7RufbS4C28Zi4gzx+KPDvx1gAnEt0bSwPCQJfEqE8jeNCGiaZEqO91wY0wEJf7LC6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793350923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EboqprzWKR1TmB59Ku9/L+t9P/HJHq4mAjFlDgZxalA=;
	b=nOKKElUXZpPfkZnTBniUnSt3oB1i6AjAkvTjlzhaSvHmt4XVrMpt8AGCx4ccBOS0cNIN
	 DpIosmLCEubNxJsDzb7AmSWa3+I+EcYkCt2AHBwQzrZoEN4q8B0qv5QCT2NeR1ZfyTskt
	 vmKSovoefR8i+e/nMR10pExgTsgWVAyPt3yQ2+LE9AVfjHbafetG2lhGj/sYDPUdJwmha
	 OAlk3WUD/GhlWihwUaAzRbxXIi9k+ycg38ySS/VzfFx5y/K8GhIGJfkdTQHPHVuU7hMli
	 RDiHIzTwfDk0FLivcJvvUG+lBJFzA6HDOlHImSYRqT1ZePasTZGwQhW4iuyJ2cO4klA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793350923;
	bh=EboqprzWKR1TmB59Ku9/L+t9P/HJHq4mAjFlDgZxalA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QGhX3BPhNY8Zv85fYM88PfKR1jmWdsK9HCgn/20vdM4Ij3VhzAwMY6TkWz9zpNOM8
	 j0egrTJXJxWgxmCqPbPBMtcbMtXnnlginetCwEAseonVUIvsqEtyc/FHh09zR31DRe
	 APDmIGpo1tgVHotTmKuKAlelQaEcX7qMXevOej99Un65CZ4CG3BIqyspy1ZGVGkUiR
	 9njW+4gnpgGaJMZ1nOtdodl+csLGrMbD5M5rrPhMzYAOIjXCsKvebI2WsG7/ZCLgkg
	 okhEPrzljZfrN1wicfxFmtrOT8/BF2Lcax0IeW+dUB4P4FJx2+qzLHji1quuefRpn+
	 MaXS+CeDsoWZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3F5D81082;
	Fri, 30 Oct 2026 09:02:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A91D1DE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 09:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FFBB402F6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 09:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aAxgbK9kAJNq for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 09:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5070D4010C
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=220.197.31.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793350921;
 b=WasDK8uZHaUlgPdFFr8I10sTX0zq0vkDn8rP9BrmepR/yVJ3iA+fBSRVQ+fpMR61HdsG
 i0bX7E2zb+bQ2U0rOEpNv6k0rTrlLcFwZ8bq/wVtB0edq88OybupzuqwqHQF94tg2ukpn
 kOtQo2QNQNNFoeOn6x4uSLheT0+96qo88M0iPj1QDRy9VsQVclS47Eb9nbpEAt9qdds19
 KjEfhzz5YOfGIsq/Fj4/ZdqPoyTgjZ1xt41p6rdwLovQGPOfusxYPifq35uXBW+r59Nkj
 wZaSf8wEPSXNOTziIiTmUPbo/wHdC9fVxvwHcVt2kmli2TX6iIOVM3K7ikNaSASpuVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793350921;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=EboqprzWKR1TmB59Ku9/L+t9P/HJHq4mAjFlDgZxalA=;
 b=KZp7jjeVeUN0LDk7Oe8pqlrTl1maIuOlrzJCMhq+W62bMDBGD6pQ1SK1DkzSNlcSjPfe
 sxWdNJpoMomecUY1PwKxsxTWVU6KyO3plpAcTOuR5aUqdhJfXlGiykKqF3xY1ujJ8HoME
 NZvpBme6/zRTdAQAwDU0SxcMvV5TCcz2NJbMEgQ3LlAVpQ1vc74MAVFgv8B4oP44Ya7Nh
 lTFiN4aGoPi2SiVgqciy8TjHl2c1ZCSk0VROqTq53biactnMtVMUSHWfQLSpEf/S9wNJI
 V3SrPwfEruRDlyLZ+gPlgGNC+0GKNiXcAPi3VVkCUFGQbKEgK3pTGB3xDFrI0v/ctXQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=ptDd7pi4; 
 arc=none smtp.remote-ip=220.197.31.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=ptDd7pi4
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5070D4010C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 09:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=EboqprzWKR1TmB59Ku9/L+t9P/HJHq4mAjFlDgZxalA=;
 b=ptDd7pi4zg/am05pHUprpzLk74rZiQPZHtiypWLiLyCUMpfNTKXl8OPzqm+cu6
 QzOr95TPDfhtpMHU6cOwSOPj6zcolA8By7/UWF9RTvjQz0tAR8E4qt3lIvZBRho7
 ZHdcWVD2iDhDz1T6Tv2SgAuqf/RulVDRjTIgqwMGOoHXk=
Message-ID: <1093eae1-8ceb-4a6b-9dcc-077e977e4ceb@126.com>
Date: Fri, 30 Oct 2026 17:01:22 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] e1000e: close and reattach the netdev when
 e1000e_pm_thaw() fails
To: netdev-bot+sinfo@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20261028093117.2313438-1-xiaolinkui@126.com>
 <179318011223.3327.3243826211150431182@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179318011223.3327.3243826211150431182@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wD3N_rjXORqiXBABw--.10056S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr43WFWrur17Wr13Kw15Arb_yoW8CFy5pF
 Z09wsFyFn8JF1IkF1xXw4Iva4FqrZ3GFWUWr47Kryj9w15CF13KrZFgw4UCa4DCr93Za4F
 9w4jq34qyFyDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZZ2-UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqAQk+mrkXOQdRgAA3f
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Thanks for the automated review.

On 2026/10/28 17:35, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Please find the missing information below.

- Discovery: The issue was found during manual code review/inspection of
   the e1000e PM thaw error handling. It was not reported by a user, syzbot,
   or a static analysis tool.

- Triggering: The issue has not been triggered in practice. It is based on
   code inspection and is currently theoretical. I have not reproduced the
   failure path or collected a stack trace/error log.

- Hardware testing: The change has not been tested on real hardware. No
   specific e1000e device or firmware version was used for testing. It was
   only compile-tested.

I will include this information in the commit message if another revision
is needed for other reasons.

Thanks,
Linkui Xiao

