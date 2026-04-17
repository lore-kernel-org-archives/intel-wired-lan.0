Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410F2F43695
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Apr 2026 11:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E99CF40D70;
	Fri, 17 Apr 2026 11:51:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ko5pPqf-ugGx; Fri, 17 Apr 2026 11:51:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 343CB40D5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776426692;
	bh=LaUNep/TcTq+dxW8ZEh9dZ7xTArEj61fBTSvcr7fY24=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U4QUxacmbUL+yvKa8ljx34Ise7XLq8qnFsaq3JHKBizzn+p8wdZeRpmdBTQSalKMk
	 /eMB8/wF693z7UxYI4eohLFhqDB9j6z9jU6aZt69vlt8SgbW0tprv0/4YYMNHwpry5
	 Yb1KQ18GmotR9fHoyziNAeRaoAjhggZMQUZBdJddmSQ8GM2LsKOY2qVBaSd7TWsHQS
	 N6KPyngvC0gZTaLiqfNieOYij2dPB28r9zuq+hssQNPeroYdYOkmu2ZlN0LN2uJBQe
	 Ht3vqJnLFK2dAUy4SZx8HmFY4JDmC8mecM2PHqTzliQnJHbqCT5UzLad2XZqMfYe6X
	 XYZGmTdgER+6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 343CB40D5C;
	Fri, 17 Apr 2026 11:51:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E8EA259
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 11:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FC8440D5C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 11:51:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AuEUZ8YRrbup for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Apr 2026 11:51:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8C57E40C9A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C57E40C9A
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C57E40C9A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 11:51:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EC4054055C;
 Fri, 17 Apr 2026 11:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92BCC19425;
 Fri, 17 Apr 2026 11:51:25 +0000 (UTC)
Date: Fri, 17 Apr 2026 12:51:22 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
 kohei.enju@gmail.com, stable@vger.kernel.org
Message-ID: <20260417115122.GA31784@horms.kernel.org>
References: <20260415025226.114115-1-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415025226.114115-1-kohei@enjuk.jp>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776426688;
 bh=rAXyLT5RLfyphcv1d83h3XEBAAHlPAV0dBZp35OPm0I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GWWhQdIWdYicGc8rjEfFApwQQ+vyljQ7WmK9K7RlPn9NGJURPJ1tCWClR1V7WaZ6U
 owzPnxJCDENKSUiyrTS1zBbuELUUCKMVQQmlB114vq85MFkzdOHJ5QeVuJWCXShi9g
 iDNg3Uy+B4ptYuzKAeIwn/V4v7UMxODwIl2GHDAQbevpBVa3WumJREEh8XVuKjEUel
 d5NhrPviXJrtSgqBxxVWLWg5T0ZVkKcdNXJWZyYwapcyLcjhYxUwOIwEZ369YTKOZX
 U5elaBkIoufQN7a/nGJY+QqERUq2fj3Lqgf4YGrdBNgftZax8/3UCrP1ckDYq7rQ/3
 vWUHcLTk8YJ7Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=GWWhQdIW
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] igc: fix potential skb
 leak in igc_fpe_xmit_smd_frame()
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

On Wed, Apr 15, 2026 at 02:52:18AM +0000, Kohei Enju wrote:
> When igc_fpe_init_tx_descriptor() fails, no one takes care of an
> allocated skb, leaking it. [1]
> Use dev_kfree_skb_any() on failure.
> 
> Tested on an I226 adapter with the following command, while injecting
> faults in igc_fpe_init_tx_descriptor() to trigger the error path.
>  # ethtool --set-mm $DEV verify-enabled on tx-enabled on pmac-enabled on
> 
> [1]
> unreferenced object 0xffff888113c6cdc0 (size 224):
> ...
>   backtrace (crc be3d3fda):
>     kmem_cache_alloc_node_noprof+0x3b1/0x410
>     __alloc_skb+0xde/0x830
>     igc_fpe_xmit_smd_frame.isra.0+0xad/0x1b0
>     igc_fpe_send_mpacket+0x37/0x90
>     ethtool_mmsv_verify_timer+0x15e/0x300
> 
> Cc: stable@vger.kernel.org
> Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> Changes:
>   v2:
>     - change to idiomatic style with goto (Simon)
>     - add Cc to stable (Alex)
>     - add reprodunction steps (Alex)
>   v1: https://lore.kernel.org/all/20260329145122.126040-1-kohei@enjuk.jp/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has comments about a potential existing bug in the same code path.
I'd appreciate it if, as a follow-up, you could look over that.

Thanks!
