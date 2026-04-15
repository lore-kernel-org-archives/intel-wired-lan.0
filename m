Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503E5F43854
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Apr 2026 16:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02D1485303;
	Wed, 15 Apr 2026 16:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N81uTc1agYh7; Wed, 15 Apr 2026 16:17:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3297852FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776269848;
	bh=OuXxctMtyNo02fkMsbc2VQF2aWvPAE1tCryv+34LPQw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UA2Smt0LQNVv4xawZQaAkEK4cYDOPdTF9Zw/GaJGT129XN4YjZYPmZy7Z9JZCFlHa
	 hOeoD+TkDxQtMcTpDt+WYirBXtkBX+r2ky2KzriLgITk88bKNn82AZbWgBIZoI5ZOo
	 pLgTEksCY7TD5GCNLBj2RLA/NBx8xs2452uq6MZspFnadMm2ulTQhZo3wV/ZGUwlQd
	 V99HlAMoIO3U29dUnawaZcabElSZb24HvRGY3fcVjBQaMGOlXLtnoNL1qgyckg5cf7
	 URq344AUljCTgZNcDFOXuZnluIQifnFTValDZ70DaqEYc8ZFCYYL5fkkSe0Q+91fFO
	 mFiI3gZmHfutQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3297852FE;
	Wed, 15 Apr 2026 16:17:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D7E5F283
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 16:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDB0B60E74
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 16:17:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q2Bi655jOL22 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Apr 2026 16:17:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2D69560702
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D69560702
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D69560702
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 16:17:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 21BAC43A00;
 Wed, 15 Apr 2026 16:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9425C19424;
 Wed, 15 Apr 2026 16:17:22 +0000 (UTC)
Date: Wed, 15 Apr 2026 17:17:20 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <20260415161720.GN772670@horms.kernel.org>
References: <20260413182427.298513-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413182427.298513-1-michael.bommarito@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776269845;
 bh=ObP4Q43FL+RVMu+5SHEP0abI1ltYtBb2y+YqFs2GNog=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W+kJeeA4kRw6T6Xd5VUPhpj+GBA6M+PwTxrEsPI6gmd8rrwSgPfC2wqw3hPwG3Pox
 fzaxnFfveEjcbMGKJMZVYE8HdniTTwCAhpTIsaNNagQ8VVFqIJadE3BKtBm3KeRZj2
 zOB1yCfqRULFsaeBiQRktKEajgJXnASbWFqfLX1KSN2LZNH8frOAq8+JMOrINW1fbM
 sfBKq2fhACstl3pAZA+QYGETa2ywRCTBGgGLkFTwa/ZvdVfzlWpyIAFLukm1i2jA3b
 iuYSv9QmKvV5AIkF94KpBXTymzCdgJvaQJ9w/6GecXPgvYoopmNl3aRmHrEe6+NEq2
 yp4gE3oI6ATuA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=W+kJeeA4
Subject: Re: [Intel-wired-lan] [PATCH net] ixgbevf: fix use-after-free in
 VEPA multicast source pruning
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

On Mon, Apr 13, 2026 at 02:24:27PM -0400, Michael Bommarito wrote:
> ixgbevf_clean_rx_irq() prunes frames whose source MAC matches the VF's
> own address (VEPA multicast workaround) by freeing the skb and
> continuing to the next descriptor:
> 
>     dev_kfree_skb_irq(skb);
>     continue;
> 
> The skb pointer is declared outside the while loop and persists across
> iterations.  Because the continue skips the "skb = NULL" reset at the
> bottom of the loop, the next iteration enters the "else if (skb)" path
> and calls ixgbevf_add_rx_frag() on the freed skb, dereferencing
> skb_shinfo(skb)->nr_frags — a use-after-free in NAPI softirq context.
> 
> The sibling driver iavf already handles this correctly by nulling the
> pointer before continuing.  Apply the same pattern here.
> 
> I do not have ixgbevf hardware; the bug was found by static analysis
> (scan_drop_continue_loops.py + semgrep drop_continue_in_loop, multi-tool
> corroboration with the highest score in the scan).  The UAF was confirmed
> under KASAN by loading a test module that reproduces the exact code
> pattern (alloc skb, kfree_skb, then read skb_shinfo(skb)->nr_frags):
> 
>   BUG: KASAN: slab-use-after-free in ixgbevf_uaf_test_init+0x100/0x1000
>   Read of size 8 at addr 000000006163ae78 by task insmod/30
>   freed 208-byte region [000000006163adc0, 000000006163ae90)
> 
> QEMU emulates igb (82576) but not ixgbe (82599), and the igbvf VF
> driver does not include the VEPA source pruning path, so a full
> end-to-end reproduction with emulated hardware was not possible.
> 
> Fixes: bad17234ba70 ("ixgbevf: Change receive model to use double buffered page based receives")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko flags a number of issues in the same function that
do not seem related to your patch.

I'd suggest looking over them if you are interested in
follow-up work in this area.

...
