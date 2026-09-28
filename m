Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22213C9832F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 07:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6C6D80DB5;
	Mon, 28 Sep 2026 07:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WGF6hNvZIFGG; Mon, 28 Sep 2026 07:15:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 20DC780DAF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790579708;
	b=D7mZ1K1827eAPYWWAe65aNPIChNa56frhgL+ZuZ0IeRfTRelIDLb05VQ/v+4+EYEfSVh
	 3MG+pj7i+5w/GBu+CWRQujrB/t5Z9Mq5ZjibpqqsAv9G5FO3yDy6O8+OiItunqjOhMVgk
	 4KtXhngAhmYKtFqMtKrnj2rF3z4B48iTWRXlXQDUzbofpd3D7Gt6E3lpmuo9TU4C/DRhY
	 dchWEZ92pB8LsAu3rZMiFp5/RiLDRR+pWueGYg/pLnal/BVXpOE7Rvj2cQOhlkPpQzxCe
	 fd3cISqEip3JNVqBwRej86x+2Qk9WpsvSbn+Q88LvBZ2PxGFl0wiwr9jEj9iDYoVZ/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790579708;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2TBoZsP4tks+iFccUSUyZdtg7yhhLexUTkXVqLs0Rb0=;
	b=RFXPT232H2l+RUpWiAYxeMU5l3MacI1LJu1RAxdxFBcNlK8867tvwjbVs3c3zLSRyRI9
	 AUQk6Jbp3zy9Q+d+mhiwdb4xEOAyzu/ea8sfjP5vEA1C4qIu2EK5UIDV5PW3Jgl+vWdlW
	 LpW83gf6K2hDuavYKi5UIi19MecjQ3XQTtxTWGU0We2pVxd+DvrHrQYgjaX2CvCDGqORv
	 eL3NxN97NyB51ZsBwx753R7pbo74Q0FM+SJedfBblytnqVyziX/ZUxkGz/tQnbZv64Jm3
	 xfWaW+EiSUIg0I4NfFCededl+70N+Bnv//G7ATlfDtc278AuylQyYHPS7P/zFHBPykA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790579708;
	bh=2TBoZsP4tks+iFccUSUyZdtg7yhhLexUTkXVqLs0Rb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=txcT4w7sA41hohejCSJ53yQ+06jFaQS4Dkrwv2gM+zVqQd9INyGQRt2XCSHoyKzah
	 SMaf8uR4IwhIrMExZ0kkOLl0r1GSgsk9/z8+fvAEnrDhXVrn3FQ/64AJ6QE6W0qsF3
	 +sluSdM7fKnpX5wHOkeRFhti6WZScUa/cBnzEz1xjC1oh7isMb8pUfbnVN2JE3HOh+
	 agc5BmVMZJmYQHZGrPOlXl5p8bFk9T0EuaZtrjV7SP8wf9r/3WfSq4ZgQO2NpPRzS6
	 rj94OxQkHU9qTu8G+HyOvYL51ESgDRF/nYbC33Y7C7oHBczNOE32ciBfuStY00qC0E
	 7NNeJjMqgtkoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20DC780DAF;
	Mon, 28 Sep 2026 07:15:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E8FE1194
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 07:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA51260664
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 07:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5c3fiff0wVUE for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 07:15:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 28DB06064E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790579706;
 b=QXlkuYuo5tIAH4fYfZmwTXFRN8oMaQa5Y0lFWiUSv+eWJPIsFl3zyy0yQ0iFeWSZ/G8T
 wFe/2Y/CKplhrhbvIKFxbKNbSd3kQLHfc/AITipGdm7MrBxY+vhswtptgp4APNGQQ1OKG
 oNnfgN5M/PinM2ux8rE9HUbxbwUH+zUHmzEJWUtFrnCbxQENCmDrMyyUIKm6TyQsBo7vJ
 kZPayrESIGW9n/bj2a/jrNpg1w8EYcSCY31vPo6dhdaN4gbau1Pl/t0qiCRCJ1JNn7EwY
 wDSyh0UJpu4X2tX+TmYwwP8t0axquMXtonSFSQYQdTsZ+BumoHeFCCPlk3/vofsHVqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790579706;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=2TBoZsP4tks+iFccUSUyZdtg7yhhLexUTkXVqLs0Rb0=;
 b=mGXHuNhn2sk7/q60iOos8TnOZIuOAz/V42HiQI18Oaw21RCKDVI6vbJwUR5Th3LhCJjp
 Lson5cCQXfja2AiwlrCbaPwHc83A6QS0Lw59gjxzqI67rr7Bcin4ufnTSKlLaC0U8Zatx
 UCNStnVo/K27BuTEpWp8YjAs0gvRz7dxfXwRQ8s2z4YXgbbiUDZavg9Y2fGmIj/3VoIkb
 j/te8DmfL8vqZ4c7/6Z2n7v8JC74ZB1XFop6kvajOYOEpoYswL2mw8+B4LHVaEV4Wjepm
 +9t7EU9xTxBB0tUQ9AKtUFORH55It7tJwXZm3+vzyU5F8lCI0jKLh+ps22EMprqaMfA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=mYcxzWId; 
 arc=none smtp.remote-ip=117.135.210.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=mYcxzWId
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28DB06064E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 07:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=2TBoZsP4tks+iFccUSUyZdtg7yhhLexUTkXVqLs0Rb0=;
 b=mYcxzWIdxREOFPjdOg46SXOuWLcBx+aB+r/LbWjE/sYac9F0H5n1nExpRuNILY
 MzYPctgCgEaJh1AF1Zbvp6mu4T16CIkZ+4/KHzV+q9K8GcqWSJGCgI4IBHYLiJiw
 mu1RZ9EbX5O9+yTgvSI6fNFWYZodIbkYEcAQeFo8PyU1A=
Message-ID: <d3f4ae98-3340-414b-9bd0-9f4588810821@126.com>
Date: Mon, 28 Sep 2026 15:14:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
To: netdev-bot+sinfo@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20260928065306.1514795-1-xiaolinkui@126.com>
 <179057875290.31693.7249107578001642813@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179057875290.31693.7249107578001642813@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: PykvCgD3l7bRE7pqg2NgAg--.15825S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar17tw17XFyUJF18tFyrZwb_yoW8Zw1xpF
 Z0vFZFgFsxJF1IkFy8Zw40v3Wftrs5GFWUWr15KrWjvw15GF15KrZFgr4UGa4DGFyfZ3W0
 9wsFqrWqvFyDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxDGOUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBNCGWq6E9MC1AAA3m
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

Hi,

Thanks for the review. Please find the missing information below.

- How the issue was discovered:
   Found during manual code inspection of the ice VF setup/teardown 
error paths. It was not reported by syzbot, a static analysis tool, or 
an LLM scan, and was not hit in production.

- Whether the issue was actually triggered:
   Not actually triggered. It is a theoretical error-path cleanup issue 
found by inspection; no stack trace or error message was observed.

- Hardware tested:
   Not tested on real hardware. The change was only compile-tested; no 
affected Intel NIC/firmware test was performed.

The same applies to patch 2/2: it was also found by the same manual code 
inspection, was not triggered at runtime, and was only compile-tested, 
not tested on real hardware.

If a v3 is needed for other review reasons, I will include this 
information in the commit messages.

Thanks,
Linkui Xiao

On 2026/9/28 14:59, netdev-bot+sinfo@kernel.org wrote:
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

