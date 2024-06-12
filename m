Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB6BC27C7B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Jun 2024 15:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB055412E9;
	Wed, 12 Jun 2024 15:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rVN2yKasZtYq; Wed, 12 Jun 2024 15:06:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 931FA412E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718204780;
	bh=BQFOOHKUE5+8vXSSbw900OF6SGMvwSRfneg8s5agc/0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=SdyRmpaTaVvqzOOsknaeK5yS2xy10uZxNcK+w/RlNilvQk07RTBkQaAP6IZN40kCf
	 cRX4Yr9tdyc1d4V8wo8MSOi4FEXvc8j/ezU+rJf241P5BLsNHngvhkiYrL9yycWCFQ
	 UL7dsh4SYeeWrHT4wSAdZ/Q02V6gI5oWY4/gdzQqn8oJmlWSRyW9oSvT5rQgD+GxQw
	 1jneLLo+DwJlWZOFn32jMxQjvX+hOWYrAPQ2dKz6hjhTIMJZrfrQFvG+vDSxyZ/ISX
	 a6MNFuYsOJ/ASM/34gWwI+5et3MaJr887Q0+u6gZYWhvPtxF/CBMe3oFHDbn8pl2zB
	 TJf0OZaWii8MQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 931FA412E3;
	Wed, 12 Jun 2024 15:06:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E16A41BF3A9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 09:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC9D1404F6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 09:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z_ovDY7G33M5 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Jun 2024 09:35:56 +0000 (UTC)
X-Greylist: delayed 444 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 12 Jun 2024 09:35:55 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 89687404ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89687404ED
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89687404ED
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 09:35:55 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:28:27 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Message-ID: <20240612092827.ezAf-luJ@linutronix.de>
References: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
X-Mailman-Approved-At: Wed, 12 Jun 2024 15:06:18 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1718184509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQFOOHKUE5+8vXSSbw900OF6SGMvwSRfneg8s5agc/0=;
 b=rwBmetO+KdO1lFIgaNJkOHbT2OpUqwVdBkm4LX8/pHRg+BRzRCD0bHEkpuCRrh4UZhcYlh
 vVNJCOBAPX9kPhXmYEVzd7oya1FKjDKqYAsxujGU2k9Vi9K8AO5yKoTpG30XORPpf0PlJs
 6tvp1FidN0CZwVLK9D0Uh/PhaK404ddTFy2VL8vnPvZUgTwZIBAY6bc9F69MMtoJOwssHJ
 KkjPiABDaj59BKBMFMUas9zV3L521rFPydPU1nDbkoa9xmONrleIDO6xFa0YuW1OO5BJ+y
 73vP6JbNKGbTNAn5sf3qVKJTzuZ8Mr7G5MNc7TTFoCQN3ZN2fiRXpptL0N9Ajg==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1718184509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQFOOHKUE5+8vXSSbw900OF6SGMvwSRfneg8s5agc/0=;
 b=p6CKydGYM/gYUSMoNMiy9Qv+g8dF6peiPoMeI5bhgtJPDebsH+aDxS+J6WpA31fagHvB53
 lmk/luaEspUt/lCg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rwBmetO+; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=p6CKydGY
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igc: Get rid of spurious
 interrupts
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2024-06-12 11:24:53 [+0200], Kurt Kanzenbach wrote:
> When running the igc with XDP/ZC in busy polling mode with deferral of hard
> interrupts, interrupts still happen from time to time. That is caused by
> the igc task watchdog which triggers Rx interrupts periodically.
> 
> That mechanism has been introduced to overcome skb/memory allocation
> failures [1]. So the Rx clean functions stop processing the Rx ring in case
> of such failure. The task watchdog triggers Rx interrupts periodically in
> the hope that memory became available in the mean time.
> 
> The current behavior is undesirable for real time applications, because the
> driver induced Rx interrupts trigger also the softirq processing. However,
> all real time packets should be processed by the application which uses the
> busy polling method.
> 
> Therefore, only trigger the Rx interrupts in case of real allocation
> failures. Introduce a new flag for signaling that condition.
> 
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3be507547e6177e5c808544bd6a2efa2c7f1d436
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
