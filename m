Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10175EC1E9A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 10:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B019960B13;
	Thu,  5 Feb 2026 10:52:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ysfk_Hsb9DVk; Thu,  5 Feb 2026 10:52:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65AF160AEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770288767;
	bh=x9mUfxcwOmqfbj1N448pyLfXB42fAzpjDFw1aR2+RSg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sJWaCosnPbyutfeediPwDCV88zH2D8G1093UZjIV7Nf6yovoS8AFaHBjufZ7PId0d
	 Pm5YjL3kpG1R65oqSjTJlY9YtEgq4JgCfe9ogL71pVxF/yL606IBDuQ3oAUP6Bq6No
	 lbOr6a5a4Nld10b5EopMhdGFUI89nfMwdH75DTvExM0wTvYJpYpEbBSJ8rsdhHw8TH
	 yNaTRQsUSDEfQhX4WAt/iJtWK8DyUKVzOdWwe7DVLyDClUKrrkzkxcmhOpEAFPcXNk
	 HWkt1BRbHW2ZFizMLxsMOSSSu7HErAj3v3uiL8dc0YpnDn5oxtAlrkm/SKGDmOSf5s
	 lB3E4gbJKQZDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65AF160AEF;
	Thu,  5 Feb 2026 10:52:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 77D3D173
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 10:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57CF660AFF
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 10:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8AOiJzcje6gL for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 10:52:44 +0000 (UTC)
X-Greylist: delayed 2927 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 05 Feb 2026 10:52:43 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D1C3B60901
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1C3B60901
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1C3B60901
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 10:52:43 +0000 (UTC)
Date: Thu, 5 Feb 2026 11:52:38 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Message-ID: <20260205105238.e8F64peo@linutronix.de>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1770288760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x9mUfxcwOmqfbj1N448pyLfXB42fAzpjDFw1aR2+RSg=;
 b=bfVJPYvjUXQ/r0ZyHM4BTyUwhJPPOUcYJwQ8QHRDBGd/91dmsP2Zh69NJVwxsoYcTrlhZT
 eR/Vab82tAUeAW8ES+G9qtqz0QsYKcUP5j76YjjHNyQkSqPMdWEPuD3ijft/sSy0ae/zxR
 jrQx8dH3nUaPhBZ/914E073UsK9B7/vL1pW+ZVQG0bReEik+4ye+IW+f+49ux6Tt8BSGZs
 DGJKi0+bGpS72HdNGu2gxc8hDRZEBlUUdvd/8ZyeTGYVkNZHa21Uq2YQ+vHbdwZv+K31Iv
 G69xrvSioMYNemgOm0GFnWyyKypjolG4R2nEBs3IUFD7nBeklyopkAuifOAopg==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1770288760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x9mUfxcwOmqfbj1N448pyLfXB42fAzpjDFw1aR2+RSg=;
 b=zOpymhHqUVPBJHUcRdZZu++eE6xbYv9/KOO+KW5rrDdUqKB75Af5dw+3lC6pNAjxLx231t
 yMsHbcO2LoAJwvDw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=bfVJPYvj; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=zOpymhHq
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
 timestamp directly from interrupt for i210
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

On 2026-02-05 10:37:05 [+0000], Loktionov, Aleksandr wrote:
> > 
> > How or where can it sleep?
> > 
> > Sebastian
> 
> igb_ptp_tx_hwtstamp() -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/skb_tstamp_tx -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/__skb_complete_tx_timestamp -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/sock_queue_err_skb -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/skb_queue_tail -> https://elixir.bootlin.com/linux/v6.19-rc5/source/net/core/skbuff.c#L4075 

Would you please quote an actual call chain that can be looked up and
not this where a line crosses 300 characters?

> spin_lock_irqsave(&wq_head->lock, flags);  <- RT mutex can sleep

Okay. So you are concerned about this spinlock_t, I see.
igb_tsync_interrupt() also invokes ptp_clock_event() which acquires
pps_event_time::tsevqs_lock. Why is this not a problem?

Sebastian
