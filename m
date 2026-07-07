Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2818C43458
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Jul 2026 13:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E6AE607A2;
	Tue,  7 Jul 2026 13:38:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxWCp3ZDUl9f; Tue,  7 Jul 2026 13:38:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D086A60799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783431492;
	bh=RYbaBrhQEitADW+4SI2VoYdDVhKcI2a9kMoyfM0Cv44=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDHjoOIzoeZYlDU0n4qNjiORwzcIkHIyqWQXy0shlFfT6BbRWkpfnvKnMY1PBUJZE
	 DG3oeUR927Qo2r8M3KAj5gmg1my0RFbwDb51i9oJxAUEADGBTPFwU9eY08jDRVMsLt
	 kHST50LU2SD8+aLpUFHKjd+R6XGawBK2rxdTbxxkjWD8Nq2VnkJLLaQz3KjnYzW/Op
	 G7qk4HtGXLR61vKF6+9FMxHiYBbJwi/hnZ8giImAAE2m2rWjnmC0JLBRcGRtA5D+Jw
	 Du9xZqIXv4SFlWeN33pjk/o2MZq4YA9mx8O6wBGduN7at3Gll0FruSQoPF7wdbFdnZ
	 1Xus3Ddabm/pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D086A60799;
	Tue,  7 Jul 2026 13:38:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED3652A8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jul 2026 13:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE9E540261
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jul 2026 13:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RG4_PeYGWQUI for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Jul 2026 13:38:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 29BB940244
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29BB940244
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29BB940244
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jul 2026 13:38:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 017C160018;
 Tue,  7 Jul 2026 13:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406D51F000E9;
 Tue,  7 Jul 2026 13:38:07 +0000 (UTC)
Date: Tue, 7 Jul 2026 14:38:05 +0100
From: Simon Horman <horms@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jeff Garzik <jgarzik@redhat.com>, Bruce Allan <bruce.w.allan@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <20260707133805.GF1364329@horms.kernel.org>
References: <20260626083917.49745-1-jiayuan.chen@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626083917.49745-1-jiayuan.chen@linux.dev>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1783431489;
 bh=RYbaBrhQEitADW+4SI2VoYdDVhKcI2a9kMoyfM0Cv44=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jgzW+c58B37nFSMdmK6yd3eUeIrUld9N+hk908EbC4Zhd/5WrhZZz2pl3pQyOpks4
 052813ehEQfZ2HdCxsiYx/sMPKGMmOmGsdF/t+FTYKBV95BUuAJ9A03i1Q/UntFiD1
 wmLCDcVopn2S/NgeynuV4Z9U8LX3OldIjR5YkBB77bB4YCFJ7KtyONZJOJR17UamHv
 Nl9GQAAfmXh2/lKQawawDzzJ9cTeQq48ix++WPJq64pZxml2UWA4NlQe9ZLkPFsd9V
 bcF1op1eawLWr5JJlqUWSO1ZCshC/EecA8+E+FvxzI8sLq9vMQfPpnFnzqu5CCkuWp
 3amFKXf+BzrIw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jgzW+c58
Subject: Re: [Intel-wired-lan] [PATCH net] e1000e: fix IRQ leak when
 request_irq() fails in e1000_request_msix()
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

On Fri, Jun 26, 2026 at 04:39:16PM +0800, Jiayuan Chen wrote:
> An internal syzbot instance reported the warning below.
> 
> comedi (comedi_parport) lets userspace request_irq() an arbitrary IRQ
> number and can thus grab one of e1000e's MSI-X vectors. When
> e1000_request_msix() then fails partway through, it returned without
> freeing the vectors it had already requested; pci_disable_msix() later
> tears those descriptors down while their irqaction is still attached,
> leaking the /proc/irq entry.
> 
> Free the already requested IRQs on the error path.
> 
> genirq: Flags mismatch irq 28. 00200000 (eth1-tx-0) vs. 00200000 (comedi_parport)
> 
> remove_proc_entry: removing non-empty directory 'irq/27', leaking at least 'eth1-rx-0'
> WARNING: fs/proc/generic.c:742 at remove_proc_entry+0x436/0x560, CPU#3: ip/445
> Modules linked in:
> CPU: 3 UID: 0 PID: 445 Comm: ip Not tainted 7.1.0+ #284 PREEMPT
> RIP: 0010:remove_proc_entry (fs/proc/generic.c:742 (discriminator 4))
> PKRU: 55555554
> Call Trace:
> <TASK>
> unregister_irq_proc (kernel/irq/proc.c:406)
> free_desc (kernel/irq/irqdesc.c:482)
> irq_free_descs (kernel/irq/irqdesc.c:874 kernel/irq/irqdesc.c:865)
> irq_domain_free_irqs (kernel/irq/irqdomain.c:1917)
> msi_domain_free_locked.part.0 (kernel/irq/msi.c:1619 kernel/irq/msi.c:1645)
> msi_domain_free_irqs_all_locked (kernel/irq/msi.c:1632)
> pci_msi_teardown_msi_irqs (drivers/pci/msi/irqdomain.c:28)
> pci_free_msi_irqs (drivers/pci/msi/msi.c:925)
> pci_disable_msix (drivers/pci/msi/api.c:200 drivers/pci/msi/api.c:193)
> e1000_request_irq (drivers/net/ethernet/intel/e1000e/netdev.c:2028)
> e1000e_open (drivers/net/ethernet/intel/e1000e/netdev.c:4681)
> __dev_open (net/core/dev.c:1702)
> netif_change_flags (net/core/dev.c:9806)
> do_setlink.isra.0 (net/core/rtnetlink.c:3207 (discriminator 1))
> rtnetlink_rcv_msg (net/core/rtnetlink.c:7068)
> netlink_rcv_skb (net/netlink/af_netlink.c:2556)
> 
> Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Assisted-by: Claude:claude-opus-4-8

Reviewed-by: Simon Horman <horms@kernel.org>

