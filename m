Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD22EE369E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Feb 2026 16:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9156383CD8;
	Thu, 12 Feb 2026 16:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id inKuo--Tk9_G; Thu, 12 Feb 2026 16:29:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C56DC82890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770913742;
	bh=TRHZXcV2nDdeLMlTQ3urObUjcIUvRlNNfh8C7w6ZmWw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r/EHoUkYq7Qif8ZF21zI/rn4rveWROkUwXClj25cTw1zlqWOK5VcIy965efsB+uRj
	 W1qsas2Vr0Ez6mUg3a8Nn2p0nrX4DKO6678LfnFSqM+AC/6JhPQdXe85PMEGDRcdNY
	 oB03rDTcEHWemAIt+JYGd1pOOKpYtrxQI8XeMjMMskfeIfhF2UdD30FKREwjxTpqQt
	 yNVIqs5fXfbgWfm9CmfqdVKIT/paTCAthYZrmSCxSlNol3Wj06GqZFVyxVdvY33Xcv
	 3/quNtMSJLrIzfU7KapOP658dpwDC/SzuMcbxf+Yx1qCPyHFcZ1O04LtKzlQk1Jik1
	 1gLE3tzpkA3Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C56DC82890;
	Thu, 12 Feb 2026 16:29:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DCD0EC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 16:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0EF8640B99
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 16:29:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9OJA8DvZtGFK for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Feb 2026 16:29:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E61EB40B58
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E61EB40B58
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E61EB40B58
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Feb 2026 16:28:59 +0000 (UTC)
Date: Thu, 12 Feb 2026 17:28:55 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
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
Message-ID: <20260212162855.Dgc3fZ29@linutronix.de>
References: <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
 <20260210121207.9kLHroS0@linutronix.de>
 <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
 <87qzqr5vos.fsf@jax.kurt.home> <20260211105444.1e370abd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260211105444.1e370abd@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1770913737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRHZXcV2nDdeLMlTQ3urObUjcIUvRlNNfh8C7w6ZmWw=;
 b=p/ptBcHjrc9RG4J9Cw1PYdMMkkWrumGBX+6YmfQ79wXkjPLO57C9tf0kNJAr2L74Nps90j
 +29v+InfesxgTH/JdwOO1DfrnXxDlPFqDe1rP5CU+zmhJFst6UTOAly39MZNzXz1bokFSe
 G2AZQTtszcZzjt7kY9133l9UPd/9ArtFnyNtvnBMlXf06ouqWNq51AiUaPRkgx35Ni0Ue1
 bSPHQO0YOsa4857DIrL81tQuRQy8fZGnLr6zYn8gOhME/o2gV1JfhOaKjr11wHeyme/eIe
 +rFjSyg+iP1zpdpqJEuL1eJ7zIuVg4c2b0atL+jzpcOW4ZHzKNwNzqRyGLqeog==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1770913737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRHZXcV2nDdeLMlTQ3urObUjcIUvRlNNfh8C7w6ZmWw=;
 b=S9aeuaEKL1lC/YpOEcGHrJEc3I6QnFlB8A10YpQbEE2IGu9V5lucP8wOVqVJaDfRN2orsm
 GHB/OXRda8IC53Dg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=p/ptBcHj; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=S9aeuaEK
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

On 2026-02-11 10:54:44 [-0800], Jakub Kicinski wrote:
> Are you concerned about the latency of delivering the TS to the user
> space app / socket? Or purely reading the TS out of the HW fifo to make
> space for another packet to be timestamped?

The problem with the global workqueue is the latency. If the system is
idle it works as-is but if it gets busy the workqueue can be
significantly delayed. You can't give this workqueue a higher priority
because the workqueue is anonymous and changes.
The next best thing here is the aux_worker because everything here is
executed always under the same process/ PID so you can apply a priority
and ensure that is handled before other "less important" tasks.

However. There is actually no need for the workqueue so you could do it
directly (which is what some other driver do). But then I stumbled upon
the locking issue=E2=80=A6

Sebastian
