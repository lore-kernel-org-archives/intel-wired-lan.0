Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94D1FB5EAD
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Mar 2026 14:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACB3A415FA;
	Tue, 17 Mar 2026 14:38:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZ44t3z_0rQc; Tue, 17 Mar 2026 14:38:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E26E8415FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773758337;
	bh=4dwiQtjV0URScOIyDH89kknET1vSDADAowJTLNm5SWs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dbfaEQW34KzoT8oGfMaVQE9XbAanV7BXsLsqdTur7frXP6cGbnzVG+bpV9IwzB0cv
	 cea2tuXtFgWsP3a6oS6q36tlvkWOB//EATJPn7Nu1gT/U57o++VY+ZNcVy7rVVC/ba
	 d/IgzlJRCRa5R/N3EMFFRnEdf6F4EpJhb2oMWS2H+qgS1jPp8RJFPpPFVfBIOiUFQV
	 yZEN9hWPCqfWxrW+b3/1KCKCK6BVBVUVyNWwZHwykr1YBolVtoiEX57LUmOwb6sYEv
	 0qDRru5N1DRwloY+3AzDOqL0V1Nwdsko1uTR3xKdxscWARax64sdgqSQhm3xjyVsHx
	 t2CKxu/zGqjEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E26E8415FB;
	Tue, 17 Mar 2026 14:38:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CF253BE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 14:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EAB040C1D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 14:38:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdDM1Zy95OQJ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Mar 2026 14:38:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5E9814004D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E9814004D
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E9814004D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 14:38:55 +0000 (UTC)
Date: Tue, 17 Mar 2026 15:38:50 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev, sgzhang@google.com, boolli@google.com
Message-ID: <20260317143850.BLrnAox8@linutronix.de>
References: <20260316232819.6872-1-emil.s.tantilov@intel.com>
 <20260317090054.DuPZ6O0O@linutronix.de>
 <7247024b-fc8d-4a75-ba15-a10399db03bc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7247024b-fc8d-4a75-ba15-a10399db03bc@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1773758332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4dwiQtjV0URScOIyDH89kknET1vSDADAowJTLNm5SWs=;
 b=CAqrgaus2MC0i0ZA73W1BgaQkEPeGXkI36AQ10M7pSsfgysl9ZTEuCxyefNd2bwX+cTtgH
 reyD8HZoqjeRHtw2HeEZtk+C1T222jYnG1iwH+1olsve8OJUn4wuvgNhGL6G5v5YqCZbtZ
 f4j4w4+gKi3I9mps/rnIEBk2XJbNRLQQ8ZGRq4uxY6z7yF6Kpeo9jYkYo7G8poM71IPhPM
 fVhA0+hc9TUxZaIR64ZodGqKF7xWI6MTvwUvhfZgk/QBEAocv1SkZPYi5Fp+IVnCqizB+h
 oH2IgzEfULR3Pu05W8kBCo6NP+fS/LVwuS32HHSJI5/+I4SslxYugAvcfEciuQ==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1773758332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4dwiQtjV0URScOIyDH89kknET1vSDADAowJTLNm5SWs=;
 b=84bu404IaCUK9e3YVljsj9RC5Ra9wg3tAMbQJPB3/MA7gyjRQM14VVZtJQH6QS/AJSLPzV
 WddHZhtlwmYG9SBA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=CAqrgaus; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=84bu404I
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 0/3] idpf: virtchnl locking
 and async fixes
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

On 2026-03-17 07:20:18 [-0700], Tantilov, Emil S wrote:
> > Why is there a raw_spinlock_t? From a quick look a spinlock_t would do
> > just fine with not runtime change for !PREEMPT_RT.
> 
> The handling of the virtchannel messages is done via the completion API
> and the transactions are using the raw spinlock from struct
> swait_queue_head:
> 
> https://elixir.bootlin.com/linux/v6.19.8/source/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c#L298
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/tree/include/linux/swait.h?h=dev-queue#n44

I am aware that completions use a raw_spinlock_t. I don't see the link.
What would break if you make that lock a spinlock_t?

> Thanks,
> Emil

Sebastian
