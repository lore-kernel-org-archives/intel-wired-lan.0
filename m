Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E17E94623
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Feb 2026 00:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C76B812E9;
	Tue, 10 Feb 2026 00:25:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dNninNMRmiRs; Tue, 10 Feb 2026 00:25:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F218812BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770683118;
	bh=eMgKEXKreuvett/p/7MOi0O/FowK30KohFnnpKo8/Wk=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uxZtSTJ1BV5/L3dPtxlkLN8lEaZnHngA/Vx4aAx3mwDkKzLhrDiKrJ8hKkSyfFmp5
	 s3lXXU3C18KOn1r8KnOjl5Bu/HDkaaLZLrSR3mdtzhbqPfz9ehNi47/AEYrk+L3yax
	 bWKHKutJRsCW2LkAQycOBL39z0K9oMbUlrUj9YUN5KhDMtyqXKiH/oZWRUQKr8N353
	 M5Oydrf5BKZzT4Wbp7pK8i+iqXK2o9SilRktuwcARy4r7ixN5oF0e6ymFJQYrkbZfd
	 satsPb9qJf2a33VTYbJ3Nd9ty8Kw0eB1tu/laNeRFoIF/wA9ggLfP+pM9Xl0Ve3tlf
	 I+yjfaCzFl4qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F218812BA;
	Tue, 10 Feb 2026 00:25:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 40A391A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 00:25:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22A55812BA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 00:25:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uCplfnqdpG3p for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Feb 2026 00:25:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6F644812B9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F644812B9
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F644812B9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 00:25:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A3A8443AD7;
 Tue, 10 Feb 2026 00:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D640C116C6;
 Tue, 10 Feb 2026 00:25:14 +0000 (UTC)
From: Thomas Gleixner <tglx@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
In-Reply-To: <87a4xhbk6a.ffs@tglx>
References: <87v7g8zv2o.ffs@tglx>
 <aYpalNvTIiD4nym4@devvm20253.cco0.facebook.com> <87a4xhbk6a.ffs@tglx>
Date: Tue, 10 Feb 2026 01:25:11 +0100
Message-ID: <877bslbg2g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770683115;
 bh=Wpfw2uqDmLqrlx715dbScHeqTNO7aVvos/5uQh5ZKms=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ra5OCJdnfuCdFx6NO89ZSB9V2hj4VPkmFrvDZNdgGByBa5dfNQVHsoqLer8O2UTOv
 X8zibP/PJ+MGMwrDXOs+srb/xtNvrxbY+ZVHdWSx1oR7HH8caBZ3OgALUkd14Bh6zX
 pELM7Irep/kNcgWelpHebQ5VTTSv5PHSlrGU15w5YbFJhiH827vVZa/zPcCJy3mMvD
 NM/g0rJFhA/L9jySY0X0iXDkINX3BXKNh0HwUX1P+w1C/drv/tZkShwco4Ilwm5egN
 LI4PJ8izbzekt15Zbss65v9puacrwVzng32haZrfnNNIJ4i30xPF8vSXHtR2KxxjBd
 gXdlTnjLgMniw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ra5OCJdn
Subject: Re: [Intel-wired-lan] i40e: Fix preempt count leak in napi poll
 tracepoint
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

On Mon, Feb 09 2026 at 23:56, Thomas Gleixner wrote:
> On Mon, Feb 09 2026 at 14:07, Joe Damato wrote:
>
>> On Sat, Feb 07, 2026 at 11:50:23AM +0100, Thomas Gleixner wrote:
>>> Using get_cpu() in the tracepoint assignment causes an obvious preempt
>>> count leak because nothing invokes put_cpu() to undo it:
>>> 
>>>   softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100, exited with 00000101?
>>> 
>>> This clearly has seen a lot of testing in the last 3+ years...
>>
>> I'm the author who introduced the bug. FWIW, I did use it quite a bit when I
>> had i40e devices.
>
> Right, but always with PREEMPT_NONE and no debug option which would
> enforce PREEMPT_COUNT ...

Forgot to mention that's what is required before submitting patches
according to Documentation/process/submit-checklist.rst

But who cares about documentation aside of the people who write it?

Thanks,

        tglx

