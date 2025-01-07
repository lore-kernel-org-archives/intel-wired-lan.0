Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B0AE77197
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Jan 2025 14:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69F9A81453;
	Tue,  7 Jan 2025 14:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E-tBGCgSSh6X; Tue,  7 Jan 2025 14:00:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBCB4814AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1736258423;
	bh=cct8mjPuTS2g1hERdmr1jNSJDlrhhPaqQc2wki1mp24=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IsfabSWQb8UC+ditIFxO6gyudpCLzgrIFY6zIivt04gtMXeTahmHeq8spDxz+TCyy
	 fYnL5wZX+bAkQs2Fh8TtIbC1/8/2UIJuwr+e3j/DZRhWy9K/UZ5jIOhySZDWWG72e/
	 pd+uxOx7Xxx3cnw5IRPpkPRme8N7wj8ifjHYvgmaJpwrpIwK0lRLc2qGh6jgcnaFck
	 MsaTYarDWS0ZBI/gnbVirlMEX90wEvtax4x/wGwFR+g3x1wEO+i8OMDpRjcrPuQB+f
	 IX4ukbdbMAM/iP7TFnXRp+1e5tW0Aqyt1u3cdRfv57dctq4xfZo7d7mp6OU+bskXX4
	 5oNlA9Wiwy4mQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBCB4814AB;
	Tue,  7 Jan 2025 14:00:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54F997AA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jan 2025 14:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4323481452
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jan 2025 14:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pLUDZATQ4b9r for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Jan 2025 14:00:18 +0000 (UTC)
X-Greylist: delayed 537 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 07 Jan 2025 14:00:07 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 81DCA81678
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81DCA81678
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=bigeasy@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81DCA81678
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jan 2025 14:00:07 +0000 (UTC)
Date: Tue, 7 Jan 2025 14:51:06 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jeff Garzik <jgarzik@redhat.com>,
 Auke Kok <auke-jan.h.kok@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT"
 <linux-rt-devel@lists.linux.dev>
Message-ID: <20250107135106.WWrtBMXY@linutronix.de>
References: <20241204114229.21452-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204114229.21452-1-wander@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1736257868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cct8mjPuTS2g1hERdmr1jNSJDlrhhPaqQc2wki1mp24=;
 b=IOhx86Esibh8T7Uq3RkbLHC3DioF3Wrh98RsmTDbQA8S6DEUvMNyR/rkleXX1Xa0xSoIg0
 Im2GF8dgr0/ARtD0+n7GCXUlzUnLgHzIQCOOa3hlf8ac8o516KXrFXZgM5C1FkQYUIMTQo
 P55DAIuAcWvJWRM0E2l/P6BRp+G2ojoxa7EJvpVB36U+F/wBmf19Bv5PZOnlUfmk7sfoSz
 cDd6XqNhYXvLZ8IA93UgD71FLqojCGw7UHxDDqunXbdIV2so0ORCOuz4HI85NrJcgvkrlE
 mTsMtG6d5pUg2OpqOIEI7LYtT+dICn+rRUKML3cZNUqGNR4fYaW3yQJw9Q/PIA==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1736257868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cct8mjPuTS2g1hERdmr1jNSJDlrhhPaqQc2wki1mp24=;
 b=4knpNCMXSS+IFvgXhM12tf4YO5sC0sRyfIuWp2PqSEy+zyUrQ/71+LYqqZSEEv8ZQ886yE
 q5lFR933wlWa/ODw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IOhx86Es; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=4knpNCMX
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 0/4] igb: fix igb_msix_other()
 handling for PREEMPT_RT
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

On 2024-12-04 08:42:23 [-0300], Wander Lairson Costa wrote:
> This is the second attempt at fixing the behavior of igb_msix_other()
> for PREEMPT_RT. The previous attempt [1] was reverted [2] following
> concerns raised by Sebastian [3].
> 
> The initial approach proposed converting vfs_lock to a raw_spinlock,
> a minor change intended to make it safe. However, it became evident
> that igb_rcv_msg_from_vf() invokes kcalloc with GFP_ATOMIC,
> which is unsafe in interrupt context on PREEMPT_RT systems.
> 
> To address this, the solution involves splitting igb_msg_task()
> into two parts:
> 
>     * One part invoked from the IRQ context.
>     * Another part called from the threaded interrupt handler.
> 
> To accommodate this, vfs_lock has been restructured into a double
> lock: a spinlock_t and a raw_spinlock_t. In the revised design:
> 
>     * igb_disable_sriov() locks both spinlocks.
>     * Each part of igb_msg_task() locks the appropriate spinlock for
>     its execution context.

- Is this limited to PREEMPT_RT or does it also occur on PREEMPT systems
  with threadirqs? And if this is PREEMPT_RT only, why?

- What causes the failure? I see you reworked into two parts to behave
  similar to what happens without threaded interrupts. There is still no
  explanation for it. Is there a timing limit or was there another
  register operation which removed the mailbox message?

> Cheers,
> Wander

Sebastian
