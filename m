Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A7FEEA846
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Feb 2026 18:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC4BA83D9A;
	Thu, 12 Feb 2026 18:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 064ka3bS4M64; Thu, 12 Feb 2026 18:33:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0B2A83D56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770921220;
	bh=kcQnh022aC2Z+7p6gcLCoz38vdpYDUmqlEBkvoc4gIk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lbdkd7Ehq0/3gbln2644jFagfKd/t5u/zU5a6MprB/5//Wl7ianubB5QUTYr2jjMn
	 mYzV4Gkp87y6AOEyC2b4dWMdC1fCKuAdL43GEoRwP1XWXVNPE4QUw6HS0nMaXByU4I
	 SIhCLGXv3GmCOffRRturdtVsLehK9Utb5UoVz6GWcasHjRRbsKlXTkzCxabywZtc+f
	 RFgabPe/uRtilEO7XI+onQNBuTJCiUhpR7XOvYa3WieVX0Q8UKcoHmb2ICG1STSw70
	 loWiSNtg0MYoNgWot+U9aoY7pr2cNy0YXk3ENZxQKm/RVq6DUl3941nBs0ytVflRBC
	 kMMZU0q2VjJsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0B2A83D56;
	Thu, 12 Feb 2026 18:33:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E95101CA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 18:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDE6E40064
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 18:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wOYhz2SvbSS1 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Feb 2026 18:33:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=bigeasy@linutronix.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 12C7B40027
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12C7B40027
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12C7B40027
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 18:33:38 +0000 (UTC)
Date: Thu, 12 Feb 2026 19:33:33 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>
Message-ID: <20260212183333.7xQmtLRY@linutronix.de>
References: <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
 <20260210121207.9kLHroS0@linutronix.de>
 <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
 <87qzqr5vos.fsf@jax.kurt.home>
 <willemdebruijn.kernel.2759f838d176e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2759f838d176e@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1770921215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcQnh022aC2Z+7p6gcLCoz38vdpYDUmqlEBkvoc4gIk=;
 b=I5HH8WYWA4BkepNZSdnP4Dr+ER8kkScG6f40dlArA+Cj3Hpxntd+yuJXi1CH+12cV4Pxa3
 W5x7FvPv8xsQxCeUbECiwKp6BqHvSL6BvAncIt2oL2YxsdDc5gxZVhKJKfyfQ597Q7BfTR
 5wueV7IkDbaxZRQ89PHtT2G2j8iRI80WiVYEbF1acrPf/ZNnrisMlvwWy1ZNtXVpyZfwDT
 wjD2GKtYkTNvwD/Pkd0TV8A2fzOlsdZgpU/jPABGIAjFibl9azuS96P8PhEjt/CAPP7FcH
 Td0nesceEtJobaIcLnFdpXWko28mN2VDbFvJQyUVAu+C4KDLpdXjqiRfdaI3EQ==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1770921215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcQnh022aC2Z+7p6gcLCoz38vdpYDUmqlEBkvoc4gIk=;
 b=pi/jkldNdevyqJBax/WTCm/DZPNoUUzRLh7IVtMb/LNANHFXl7e1d0BbDd0vw0v5FIscFW
 0jdd0+UsBX7AREAA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=I5HH8WYW; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=pi/jkldN
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

On 2026-02-11 11:29:43 [-0500], Willem de Bruijn wrote:
> I think we should look at the locking. It is not clear to me that
> sk_callback_lock needs to be held here at all.
> 
> From the lock documentation itself its use is more limited.
> 
> sk->sk_socket->file is indeed dereferenced elsewhere without holding
> such locks.
>
> sk_capable is another indication.

That skb has a socket reference so that skbs should have a reference on
'sk' so it can't go away while the skb is around.
sk_socket should be assigned once while sk is created and not change.
Also that ->file should be assigned on accept and remain stable.
That assignment happens in sock_graft() under the lock or in
sock_init_data_uid() without it (but it both cases it should be new).

If you close that socket then I think sock_close() will be invoked which
ends in __sock_release() and assigns NULL to ->file. The filep itself
is SLAB_TYPESAFE_BY_RCU (as it comes from alloc_file_pseudo()) so it
safe to access it while in IRQ/ softirq because it can not go away.
It should invoke sock_orphan() which sets ->sk_socket to NULL under the
lock. I don't think that orphan can be called from outside the close
path. And inode (socket) remains around as long as the filep is there.

So based on this, if sk->sk_socket->file is accessed from within a
syscall then the chain up to file should be valid because the fd can not
be closed and so anything in that chain up to file become NULL.
From within the IRQ/ softirq a close on the fd/ socket should not result
in an immediate release. I *think* the skb holds sock holds the socket.
If so that skb would hold the destruction of the socket back and this
would make it safe to access it without the lock.
This is the theory so far.

Sebastian
