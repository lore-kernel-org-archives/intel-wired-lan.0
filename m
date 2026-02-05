Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34381EC1EA5
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Feb 2026 12:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBBA3610CB;
	Thu,  5 Feb 2026 12:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M-y6E7WBss6f; Thu,  5 Feb 2026 12:12:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 245FE60F58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770293557;
	bh=7PelbcnS3xUMscOsvh2ZeX/gyBEvi2+xKP1rvNjD0C8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=I9a32m1bjAXg9CmP9vtq+IsZHHA3FqGzrMqbOPo3drhkKXp6urit9nykliZ/FzFrF
	 ObTzccncxD0xTWtSo+zZurJJgS0aFiBKpaAcDEqvEjPv8Dn1x6FiQ/+BK5xhaoqodw
	 0LPBIQXbp3hpvWa8Iv00Y8IoergE2bpCVQQ/T4ZAv8NqAE5F7VjJ/bqKTvtMHq9JZX
	 fG21e4GlTvf5alaxXJB1userHOfajCthwkI3FMvE227OZNYOm8kL1VPoC0i+wCEAuz
	 6S5EKviibJMQVtknX9tdwt3iePUBM6sJi3/o0w/wvfGWE3LP1sW/JZ+nKiW/xcIS3T
	 tKjcqkXtGhHVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 245FE60F58;
	Thu,  5 Feb 2026 12:12:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D559117
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 12:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E7C984146
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 12:12:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKqWWL6Za69u for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Feb 2026 12:12:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=bigeasy@linutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4BF7E84152
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BF7E84152
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4BF7E84152
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Feb 2026 12:12:34 +0000 (UTC)
Date: Thu, 5 Feb 2026 13:12:29 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Message-ID: <20260205121229.AwxNfEl_@linutronix.de>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1770293551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7PelbcnS3xUMscOsvh2ZeX/gyBEvi2+xKP1rvNjD0C8=;
 b=ZQPf6a6yM+MN8oWcb8D/hbpJDAPU5eQClQGr/bAQeReS94O/EkUOlrrvm+Y5BQkFcE/Fin
 xsPHTaZLbJCrxVqYEH2qlXYPyy6y6vR7Jqg3GLgHHFbKuANwi/pQTK9ZH951Uc9xh3x54a
 r5jjdxcHJdZdAYDJ/U8QZ1akFmO9fNihVjG87eg4uXkR8d3pSSoUXe15kgrLhhDjm9ti3e
 udq4klY7jPgyfNuSK/DjCCyT2Aztzf+CmEIJdx2IXyFehCsCTLNTZrz1vcZrht7PwDUQnI
 kMLEaFNgdT+dCDunkdhaJ4pHmZ7rNMigRWl0GlqdYbOgTnO1LswqwDV6ShC7Mg==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1770293551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7PelbcnS3xUMscOsvh2ZeX/gyBEvi2+xKP1rvNjD0C8=;
 b=PgYUZHNktT88QYXXPu7EIYbh4Rp3lqX4vzxGT81vpxAupALs1NelX9ES3lsjbJXxZZmBC6
 mm8buKh0B+D8XLAQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZQPf6a6y; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=PgYUZHNk
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2026-02-05 08:54:34 [+0100], Kurt Kanzenbach wrote:
> Retrieve Tx timestamp directly from interrupt handler for i210.
> 
> The current implementation uses schedule_work() which is executed by the
> system work queue to retrieve Tx timestamps. This increases latency and can
> lead to timeouts in case of heavy system load. i210 is often used in
> industrial systems, where timestamp timeouts can be fatal.
> 
> Therefore, fetch the timestamp directly from the interrupt handler.
> 
> The work queue code stays for all other NICs supported by igb.
> 
> Tested on Intel i210 and i350.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

IMHO this is a compromise with Miroslav where he observed less PTP
timestamps on the i350. While testing I did not get near Miroslav's
difference but there was a small change. I don't understand *why*
because the current workqueue usage reads the timestamp on the same CPU
on which the interrupt occurred. Doing it directly just avoids the
context switch. This feels beneficial.

Sebastian
