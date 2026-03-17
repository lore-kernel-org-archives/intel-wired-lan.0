Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037DCF3381D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Mar 2026 09:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCB7483EA3;
	Tue, 17 Mar 2026 09:01:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pCtAdRDLeehZ; Tue, 17 Mar 2026 09:01:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E7DF83EA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773738065;
	bh=ojgsEh5obRGiSq1T5vrGWdb+Psz+QfVFhSaFy+wU9pg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z/2By/luD74kL7Zba1bJzjpy8x8u9xvJeywHRmowEALojocdQGGprq4iUNmtKkmjM
	 SOKGajP1Z99/2VLvvyirBhXfTlzv7P3VT7JnHvwOvyvTLQpfcL2OcdSj6+qRljLAfF
	 +mviYVJRE0QiuMrxYmGNxaZtU6EMTTAi+tFTQ+Mq4VcGtuzd4lFN5I2Vvq42Yv0SVr
	 pWGxp24lTiXioo+neU5KlQFdcMQGI5xQCPI/u8tnOHEYYLHp3CcjODZ5YsYmSoHSM2
	 +VavlIAX1F8lsbbfpgXPaZ0ubtZZ+RD7fxw+3ewhN6a+6G+HrhjFTWAt7YXwY6CaEb
	 yUoN+ytAdQZsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E7DF83EA4;
	Tue, 17 Mar 2026 09:01:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C09BED3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 09:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A686F83EA3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 09:01:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PyhycWIAa8Xc for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Mar 2026 09:00:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=bigeasy@linutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 412E383EA2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 412E383EA2
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 412E383EA2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Mar 2026 09:00:59 +0000 (UTC)
Date: Tue, 17 Mar 2026 10:00:54 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev, sgzhang@google.com, boolli@google.com
Message-ID: <20260317090054.DuPZ6O0O@linutronix.de>
References: <20260316232819.6872-1-emil.s.tantilov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316232819.6872-1-emil.s.tantilov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1773738056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ojgsEh5obRGiSq1T5vrGWdb+Psz+QfVFhSaFy+wU9pg=;
 b=SLQ3uN6YVuQEg9kQON08A+uY+LzsYogYGBF7WzKqp6aoAg3T5JlIvHYGN8zvU3k3CdOnpZ
 2Jg2yvFNQTvabKDfBp7RhgeZjkGDUGRMQOn7ahIkopEC4k4woJfiAlRuusg77RPsfBXSf8
 cSkQUm6rAv6bJZurgBFWhvRDvfjkQgYJZWIble8dNDWYf/7CWXoQRniv26Z/HfU223GRTk
 AANgoYNmPEjUM+TnUB/5FmDTHaMTF54iirhdrsPimpfjHHNFnrsgpCNpgaE4IO1z/7Af6t
 RVkImuD7anFB2pqhswu8OXdF+RTUILeT4WknwXNjZ1r2X5GPdRAm+KIxVIPE+g==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1773738056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ojgsEh5obRGiSq1T5vrGWdb+Psz+QfVFhSaFy+wU9pg=;
 b=UbrxvkWhkDSOs+slId8jQ4SyV8kdAoHk7Q+mesTO1eEAkG3Da51ejvSL2WnUEuXdS8Fqll
 HSEHKiRrtHStMHAg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=SLQ3uN6Y; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=UbrxvkWh
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

On 2026-03-16 16:28:16 [-0700], Emil Tantilov wrote:
> The first patch in this series improves the locking around the setting
> and clearing of the free_xn_bm bitmap. Previously the lock was only
> taken during init shutdown and pop, but not the push function.
> 
> Patches 2 and 3 are fixes for the async handler. Patch 2 ensures the
> payload size is set before the async handler is called, and patch 3 fixes
> an sleeping bug due to nesting of raw/bh spinlocks.

Why is there a raw_spinlock_t? From a quick look a spinlock_t would do
just fine with not runtime change for !PREEMPT_RT.

Sebastian
