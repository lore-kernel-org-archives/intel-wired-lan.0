Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121AFD5E145
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 Nov 2024 07:29:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D64F42A7D;
	Fri,  8 Nov 2024 07:29:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Ic8sfIpU8qn; Fri,  8 Nov 2024 07:29:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B96A542A7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1731050987;
	bh=1XdvSNOuZouYbPrso1Npt+Pw3m9uE9gj44xGyrYmPaU=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c21YtA6EFZVwlAz1K0ZPFArsaQAsKHz90K0WV3sTucYkXAiz5NX9eUtFPrC/8eoz0
	 NRZIQ87rDlhDpExDxuKoRFdosvIbT2c6QH0RnW75GLQhL8zP0pNHZul6xQBunfjDjA
	 9sT90v3vVenqZ3K64VA4D+W0anXPuaGgTQc48B1viQ0sh8k/vHl5Sai3J27hhmNP4o
	 WDB6JTCTtSNDweEn66ONw4/sOjt2E8iXha/mz7DkaijH3fZmO/xNJ4qKR0SjF+YyS4
	 XJz0FHtjPTQXdTk14eGydNFqzL5HVpwmQclyK7vCF0KXX1+dRr//jB1qTPGDExBJDc
	 AeUvt1aU9qIBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B96A542A7E;
	Fri,  8 Nov 2024 07:29:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C7B7C0
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Nov 2024 07:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC21642A7D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Nov 2024 07:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id es5j1tfthi68 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 Nov 2024 07:29:46 +0000 (UTC)
X-Greylist: delayed 577 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 08 Nov 2024 07:29:45 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E08BC42A7E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E08BC42A7E
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E08BC42A7E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Nov 2024 07:29:45 +0000 (UTC)
Date: Fri, 8 Nov 2024 08:20:03 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT"
 <linux-rt-devel@lists.linux.dev>, tglx@linutronix.de
Message-ID: <20241108072003.jJDpdq9u@linutronix.de>
References: <20241106111427.7272-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106111427.7272-1-wander@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1731050405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1XdvSNOuZouYbPrso1Npt+Pw3m9uE9gj44xGyrYmPaU=;
 b=AnhH4xgzd7yEF5ZPSICzS90838h37rRz4QvNEoDVonGelJrNlW/RX0p/tso6Ybyy8ZK6QC
 IKF14CkaWFbgOfceFNhxhb2QhxU+leLMGlXWdwDF/0kyPEtfQuvK0HJ8SP8pDeRiLN7i0O
 6NuiWXP4gK480xVWEyFSwIoUb8z0dDZn24TyC13CyacDujoIGOCXZ8UcODpau7Cm+cEyPA
 jQXSHbvAC2TaKddjxmK92ulR2sbpMF6CbgVmDlQbExPBeOzRtrnOU9jEC/Xk4FaRmCxoJz
 bDY14JRtHUwtW0FUSfBtOlSeSOJTp1eLkovJ+ePNZrxJ6tyyCistLfdYhIyvaA==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1731050405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1XdvSNOuZouYbPrso1Npt+Pw3m9uE9gj44xGyrYmPaU=;
 b=7vyL7oQgNV/EO92EBKAOkT+kUaIUcdDXypNUcpA/+SK2vhVxhAiIFnO5XGPi/PJFsdtepA
 iw7VOGjOOY1FzNCg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=AnhH4xgz; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=7vyL7oQg
Subject: Re: [Intel-wired-lan] [PATCH v2 1/4] Revert "igb: Disable threaded
 IRQ for igb_msix_other"
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

On 2024-11-06 08:14:26 [-0300], Wander Lairson Costa wrote:
> This reverts commit 338c4d3902feb5be49bfda530a72c7ab860e2c9f.
> 
> Sebastian noticed the ISR indirectly acquires spin_locks, which are
> sleeping locks under PREEMPT_RT, which leads to kernel splats.
> 
> Fixes: 338c4d3902feb ("igb: Disable threaded IRQ for igb_msix_other")
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This is the only patch.

Sebastian
