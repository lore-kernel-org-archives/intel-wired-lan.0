Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF487C5DF9C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 16:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C22E80C8B;
	Mon, 24 Aug 2026 16:02:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3gTnGtmr0NGA; Mon, 24 Aug 2026 16:02:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787587328;
	bh=LGq+20MTSxt1LGfHj3jPyYgDVwZp6lkTgCk64GTKZho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AIabs+HNTi+kajGy4+BxhhdSTZ0AiwwOGGyw48r6haMiio9xOGnkTi001CphAK9Gr
	 PqwNduYniPxCNHtuPQZO5AMQ7N2LpZeHaTSqHn6HWukoFttyWw8cSmBjLRkFJed05H
	 bqmKGuv/zZ/2r5VpicJjtWPyXiqwxFvHzRNO3Ts+mBsdK/yQxiuUMCC0Be01cB1qpu
	 tTEMeyFhBylURLFJvo1+/DOudQqFHNZ+y0NvEk7dQbFOdIHP4RzUilPLOrsqxY/oNy
	 0WZOqhjLigQRrqVXNvEDFRyf26PYTZ341bPAyIMZvmRE7kVH2rdfykk5H2PpM5FYVr
	 lRFKwLsEq8WvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A098F80BA8;
	Mon, 24 Aug 2026 16:02:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BA0E279
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 16:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D91340097
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 16:02:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEZLDPFTNLWL for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 16:02:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=RrxyDW5P
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D48F240068
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 16:02:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0980542A30;
 Mon, 24 Aug 2026 16:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089F61F000E9;
 Mon, 24 Aug 2026 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787587324;
 bh=LGq+20MTSxt1LGfHj3jPyYgDVwZp6lkTgCk64GTKZho=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RrxyDW5PXTz7/JgnpWdBk/R+ttFpiejJO/6ekdULuH4V393VsC2hG9nXnv5ODKXqv
 c8+8/aoSkmdlKpqJtRfV0EcsFwuSYYzVNGB7Cx1/woZqtL7Mwi5wY/3jeomKE7W+mQ
 AQmQFITiHtWXB+ZObUlKWqT0l796jWqlPlyuY0+Fn2eNug7H1wXUr1nDkdnv283v81
 bIOlmrtqs9RmbW6AXg3YDs6FrsQMnaMPN0wOSroSM6BqwYM+ISmrKH9RP+fq5vyV9M
 UrclcChU3jIXXORGkR1CwQjy7SpfggF69hoKi4aUi5FwBQcm33OMTDnviyEYFu7uMJ
 FTv8G9HtnAaDg==
Date: Mon, 24 Aug 2026 17:02:01 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 0/2] i40e: fix set_ringparam error path crashes
Message-ID: <20260824160201.GX265046@horms.kernel.org>
References: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821130157.1451118-1-aleksandr.loktionov@intel.com>
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

On Fri, Aug 21, 2026 at 03:01:55PM +0200, Aleksandr Loktionov wrote:
> i40e_set_ringparam() has two independent ways to crash a live queue
> while resizing descriptors. Both need a failure injected into the
> middle of the resize to hit, but both are 100% reliable once you know
> where.
> 
> Patch 1 is the reported bug: the free_tx: label frees vsi->tx_rings[i]
> (the live, NAPI-active ring) instead of &tx_rings[i] (the staged copy),
> on Rx allocation failure. desc/tx_bi go to NULL under a running NAPI,
> next poll dereferences them. Reproduced by forcing an Rx alloc failure
> right after a Tx descriptor count change; panic address matched the
> original report exactly (CR2 == old_count * sizeof(desc)).
> 
> Patch 2 was found reviewing patch 1. The staged tx_rings[] copies are
> shallow copies of the live rings, so they carry over the same
> ring->netdev/queue_index. Freeing one of these copies before
> i40e_down() has run - either from this same free_tx: label or from the
> i40e_setup_tx_descriptors() failure unwind loop above it - resets BQL
> state for the live queue it was copied from. dql_completed() then
> BUG_ONs the next time the live ring reports a completion that was
> queued before the reset. This one predates patch 1's bug by four
> years (Fixes: 9f65e15b4f98, 2013) and doesn't need patch 1 applied to
> be reachable via the setup_tx_descriptors() path.
> 
> Reproduced by forcing i40e_setup_tx_descriptors() to fail on a later
> queue while flooding real Tx traffic on the earlier ones:
> 
>   kernel BUG at lib/dynamic_queue_limits.c:99!
>   RIP: dql_completed+0x285/0x2a0
>   Call Trace:
>    <IRQ>
>    i40e_napi_poll+0x74b/0x1700 [i40e]
>    __napi_poll+0x10a/0x200
>    net_rx_action+0x2f7/0x380
>    handle_softirqs+0xcc/0x270
> 
> Confirmed clean with the fix applied, same traffic, repeated
> resize cycles.
> 
> Patch 2 touches both error paths above, but only the free_tx: hunk
> needs patch 1 applied first to match its diff context - the
> setup_tx_descriptors() unwind hunk applies, and matters, on its own.
> 
> Cc: Simon Horman <horms@kernel.org>
> 
> Aleksandr Loktionov (2):
>   i40e: fix set_ringparam error path freeing live Tx rings
>   i40e: avoid resetting BQL state when freeing temporary Tx rings in
>     set_ringparam

Thanks for the update.

For the series:
Reviewed-by: Simon Horman <horms@kernel.org>

