Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B083606A320
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=TzLPS62B;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClM3rRbw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64AB080D1C;
	Tue, 27 Oct 2026 12:17:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H7pDWE1oE1YK; Tue, 27 Oct 2026 12:17:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8870A80D5E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793103434;
	b=ckp34nddlJTolt9a4sBiRKs9kUZmYSnjEPJymReR43XIS+C7gUZlXDJmv2OfRSzOAWin
	 lMALkcQXQJyOanNuHZFkGplPyvbzSbfibDxdQAcgTkan12BgtXWX9p9NFdyQuhn9WJFOC
	 ZZV0kLEa20ItZPU4obUzMGaiEaGEA6DYMezLVLCDqw9f7fpdn+RXHXtH8mRRqCqRITYOR
	 ndyrfV62LjR3eEB3d0M4AxFP7cM3lgRl9DhuoWy+MUIrHjxfsDtZh3tLQe9Y55Kl9yfpp
	 NDRK5H2k71l6zigJn33PkUvqcsZ+hMdylWHU1yhpyKQa297FtQAYtnYSSLFLfBwGukg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793103434;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CvpAXhZ/zB1/UtUz0RWVeDfIbCVfPxKrIVg3TrbtYsk=;
	b=EdPyChWIEKqeTj232Qn0m3Bk7f7C4sf0DAsuNoKhk90siAGHzj9LzwVfvnFKffhNeiG4
	 vrRfwsW6wK9u/OKfOYa8b2Vtwqnq+KDM2tJ20g7HOhV59aBrJXpmjRc+6SbhE/tj1LMyu
	 lB5nCZ/Qk/LMhFsw8pyTdEoSHwwpqzZ7JlchWxjVv9Sm09noTtp2GzFd+lGiqbjfRyQhf
	 qSZoAlKR0sljE+7wv14Nc+P8kmT0aS9kkSF/qyxe/evNv+2OA4PcUgHPBwVM40d1FdHtX
	 vLuo7c6zkmpJ72DRTe/bKCSm0bq2JRdJ1eXYG4o44bXAFfa4LPxwRNpAiJNzvfXYh6w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793103434;
	bh=CvpAXhZ/zB1/UtUz0RWVeDfIbCVfPxKrIVg3TrbtYsk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TzLPS62Bxtc4NxNpy3XTcfSpaoPTSKKmBa7CLcF3k88yZ7DFO3Nm3kOkzAVnw4trL
	 alaJjIIvzBNosGy7ifVIYtC0ZoE1JzUuKhRb1vmL/ZsckRjmc8DztVhMtkb2DUQ7HX
	 KRvmYUlb675mJS4BjGTiPZSt4jeH3+RYZKDI5rELQMQEcsuWS62d9iN7Th24VG7vnx
	 WCS1wukiveK6JHaD48QMHR4pWQN1TQ5edhxLZXkUiQcHplLDqNShW3e+MHdNvBG9x3
	 xpcjPkWmO4MIAE6UrBpORPRmttCHTb+EYC/ANYBJeyH70kj4d2r3mVnUWcqB01JAnh
	 8FBgA0sjrclJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8870A80D5E;
	Tue, 27 Oct 2026 12:17:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31B413D9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1767F406FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kH0bcX4yZdZK for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 12:17:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A2584060F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793103432;
 b=Prag3z4yKsoWrK1L4y7xRdz4iwpgCLc8jBibregC0GDVdT4vslzcJFZ3EO4KQDOntQ/x
 4P9Wc6lyUKSf95bQEEZSuiPj9Eqtj26fhpfVCvK5/r8Y7n1hGTdWIUncRsxtaGCcPf1nV
 C26fQtWJwNTZzEvNS5mDQia6wByoC9VLFlDmK6K+voMN4tH3esYh5PhVjn3W/2TIxdojZ
 4eJhS1X55tihRG4ojk7UpRZwbpRUw5q9lJWZj4nFjMnDGUp8PEWiQ4v9q/7MsRzVuwbpr
 SXbGOGFweGUqL4wmISjjRFy8p0XczBXKJLaKoPJfNLIhNrkCz2M/zXRC5Viy5aAozQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793103432;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=CvpAXhZ/zB1/UtUz0RWVeDfIbCVfPxKrIVg3TrbtYsk=;
 b=kRBH9HuOzM0nco3LDJJ4hzIy77oFNNpkSe22vgVlBHSRtDddppkt80rfxRlRTd20amvE
 APzrVvADJT4w9IfvuRc1IF2BtI7bC4ByE/K5ZbU7BQB+QNJyUhVzMn7XMvRI5G5R3py2B
 pwdMG4ZNScnFqfLyYjpfstBfIPASCaUvyWEIfmAUnCeZ+dDEEKIXqqJ/Vvahr4tYLbLV7
 RJdWNFx6zOf7dko202EIi6uk1sF36cWVscQjVj0lVqbIA5b+AGf/subsr66ijrCuQO+Db
 KpXBUockjLwhDT//izJ3Dru283KfIObfWqH1db9LsXTzmUENr6GfN2VIyULBoEpRulw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ClM3rRbw; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ClM3rRbw
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A2584060F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:17:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D6CD41937;
 Tue, 27 Oct 2026 12:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4791F01829;
 Tue, 27 Oct 2026 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793103429;
 bh=CvpAXhZ/zB1/UtUz0RWVeDfIbCVfPxKrIVg3TrbtYsk=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ClM3rRbw7sUjK5COILTK6VMb0rOMQo1W6mGE8fGvM4PcVoB/jHoq47VmwsbdWmuPv
 LeG6wIiU/HGyBgX/pVXX0zuvoKbQBsF9d06IlYnUe0cg5P4xVa/Jqur4ukM5sHbMVw
 kU/BUr1kHZeMgAJSEOiaCIbSXsIeueFFInMQ2u7K47TAmW5z+hID2zzMSlDlurUAzd
 WaGauLzBgIA+GP1xHDK6JtP6vNamVQIlj49scs8EWVAp0LkiZAb7Qvoq0ARc7RwrZB
 Swd7G37xWLYdnFYmC2RULY2i+//cVUnTwtvo0UcqahermV42Yc4SxdzVVR46aY3Kse
 ISPQtQxU/nvEw==
Subject: Re: [PATCH net 1/3] igc: pad preemptible packets before reserving TX
 timestamps
From: netdev-bot+sashiko@kernel.org
To: p@1g4.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org,
 vinicius.gomes@intel.com, sasha.neftin@intel.com, matthew.vick@intel.com,
 aduyck@mirantis.com
Date: Tue, 27 Oct 2026 12:17:07 +0000
Message-ID: <179310342759.3134.9480442291648763504@kernel.org>
In-Reply-To: <20261026091549.605810-1-p@1g4.org>
References: <20261026091549.605810-1-p@1g4.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After this patch alone, igc_xmit_frame_ring() still calls
  igc_request_tx_tstamp(), which does skb_get() (line ~1687), before…
- [Low] The commit message describes a failure that cannot happen on the
  tree this patch applies to.

--

igc: pad preemptible packets before reserving TX timestamps

This commit moves the preemptible-queue padding in igc_xmit_frame_ring()
so it runs before the TX timestamp reservation. The extra reference taken
by igc_request_tx_tstamp() is then not yet held when padding may call
pskb_expand_head(). It also switches to __skb_put_padto() with
free_on_error set to false, so out_drop is the only place that frees the
skb.

> Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
> pskb_expand_head()") replaced the BUG_ON() with -EINVAL, exposing the
> padding error path. skb_padto() drops one reference on failure, and
> out_drop drops another. This can free the skb while the pending TX
> timestamp still holds its pointer.

[Severity: Low]
Does this description match the tree this patch applies to? Here,
pskb_expand_head() in net/core/skbuff.c still has:

	BUG_ON(nhead < 0);

	BUG_ON(skb_shared(skb));

So c7d8bc3dd511 does not appear to be applied. Without it, take a short
frame on a preemptible queue that is cloned or lacks tailroom. Before
this patch it would go through:

igc_xmit_frame_ring()
  igc_request_tx_tstamp()
    tstamp->skb = skb_get(skb);    /* skb now shared */
  skb_padto()
    __skb_pad()
      pskb_expand_head()
        BUG_ON(skb_shared(skb));

That gives a BUG() rather than the -EINVAL and use-after-free described
above. The same holds for stable trees that carry 17643482e9ff but not
c7d8bc3dd511.

The code change covers both cases, since padding now runs before
skb_get(). Could the commit message say that kernels without
c7d8bc3dd511 crash in pskb_expand_head() instead?

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..f1bf4e462a511 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c

[ ... ]

> @@ -1669,10 +1686,10 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
>  		if (igc_request_tx_tstamp(adapter, skb, &tstamp_flags)) {
>  			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;

[ ... ]

> @@ -1680,24 +1697,6 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
>  	}
>  

[ ... ]

> -	if (tx_ring->preemptible && skb->len < ETH_ZLEN) {
> -		if (skb_padto(skb, ETH_ZLEN))
> -			goto out_drop;
> -		skb_put(skb, ETH_ZLEN - skb->len);
> -	}
> -
>  	tso = igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
>  	if (tso < 0)
>  		goto out_drop;

[Severity: High]
With this patch applied on its own, igc_request_tx_tstamp() still runs
before igc_tso() and igc_tx_csum(). Can the same shared skb problem come
up here?

When a GSO skb with a cloned header (for example with a packet tap or tc
mirred active) is hardware timestamped:

igc_xmit_frame_ring()
  igc_request_tx_tstamp()
    tstamp->skb = skb_get(skb);
  igc_tso()
    skb_cow_head(skb, 0)
      __skb_cow()
        pskb_expand_head()
          BUG_ON(skb_shared(skb));

igc_tx_csum() can reach pskb_expand_head() the same way, through
skb_checksum_help()->skb_ensure_writable(), on a cloned skb.

The next patch in this series, "igc: prepare TSO and checksum offloads
before TX timestamps", moves igc_tso() and igc_tx_csum() ahead of the
timestamp reservation. That fixes this by the end of the series. Should
the two patches be backported together, since this one alone leaves the
TSO and checksum paths exposed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026091549.605810-1-p%401g4.org
