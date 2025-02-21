Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BBBC021B3
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Feb 2025 22:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5B0E80F43;
	Fri, 21 Feb 2025 22:26:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a__4ww5Ivmpw; Fri, 21 Feb 2025 22:26:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB767812BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740176815;
	bh=k5LB7jP+f6lNl4H1LdXjkE9kYUU+t96pBO5YpxJhE0c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=61QG2FXIiQgpiKCYTHamL/b8K8Vfqm3isRhjwq3MsnN05YWkdS+SEvCkVFw5IyV1I
	 XS/a7GC1fp5aKn/lBo4R8+0Z4sjQWTYKPg8te6JSGbjO99cjK8dmoBjan0nkRM/uQD
	 PedmSpbjdKB5Mz0k2k8qx8YDPLrayn+uoahMPH065HXkutMYTyZI/J0UaNJFxXT4ND
	 pxtWY4YkaSgsnkrm+KPUtaqxvpnTBSkJ1YZZjm+YGYurQvcSk3AvomeCr3VQ9UJ+ul
	 o/tfU+aiFxvpWPSTJ3RoSQGKDENWWe4lPjhHR8apMT2oU6Ii38DjNLpIMGO65H8RH7
	 ounjfY5Y2IKtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB767812BB;
	Fri, 21 Feb 2025 22:26:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 31D5FD92
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 22:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F073040151
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 22:26:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5NRDcdrM-DEM for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Feb 2025 22:26:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EC27540025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC27540025
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC27540025
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Feb 2025 22:26:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 999A35C43AA;
 Fri, 21 Feb 2025 22:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06344C4CED6;
 Fri, 21 Feb 2025 22:26:50 +0000 (UTC)
Date: Fri, 21 Feb 2025 14:26:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Gerhard Engleder <gerhard@engleder-embedded.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Message-ID: <20250221142650.3c74dcac@kernel.org>
In-Reply-To: <Z7jnxolsaLICS6zD@LQ3V64L9R2>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <Z7T5G9ZQRBb4EtdG@LQ3V64L9R2> <878qq22xk3.fsf@kurt.kurt.home>
 <20250219180651.0ea6f33d@kernel.org> <Z7jnxolsaLICS6zD@LQ3V64L9R2>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1740176811;
 bh=JYIZp6oz2BlHDzWW7UOSolxuRxr9OKOgkF/GatOg+lY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OD8l3Hfp+bk5GlWSCORfoSR6mRo+OZgM44R3ssUK9650oUXRETvnC+EnhZhEc61mJ
 61HQBVApFeiw2YfiptVIAlmopa0lWls5Co7c+OhX6URkkMkvuZvb8vISps6tWRHoue
 7kBcp65zDc/MaDS5V+RbIsyhcbdecYt99lqXcLAS2k6Q+TTaT033ziQihS3T6f6tp+
 +BmwEaRpai/QAPjeDYQFf2UkytyIhxZL8fx3ju7Pzg4ei3tBHuxuegyG5y29fdDynX
 LL9BdjTsnm9hkK3PRtU7u63yZsSeFQFV/1NoDiO/yX6W5mgFy/7a078Smh9rG2Tb/y
 4FbpzWkM7xQgA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OD8l3Hfp
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 0/4] igb: XDP/ZC follow up
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

On Fri, 21 Feb 2025 15:53:26 -0500 Joe Damato wrote:
> > No strong preference. If rtnl_lock is not causing any issues 
> > in this driver, the we can merge as is. I haven't followed 
> > the past discussions, tho.  
> 
> Don't mean to side-track this thread, but does this mean you've
> changed your mind on the previous virtio_net thread [1] ?
> 
> Or maybe I'm just misreading your response there? And instead I
> could re-spin the virtio_net but dropping the first patch and
> dealing with RTNL in the code like this series is doing?
> 
> For some reason I was under the impression that the virtio_net
> series and others like it (like this igb series) were being held
> back until locking work Stanislav is doing is done.
> 
> [1]: https://lore.kernel.org/netdev/20250127133756.413efb24@kernel.org/

Yes, you can probably respin v1. Let's not block this.
