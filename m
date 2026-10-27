Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123B606A320
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xg2BC3UN;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/x5zjto
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0EA6606BA;
	Tue, 27 Oct 2026 12:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k3ZNGu6WnkUV; Tue, 27 Oct 2026 12:17:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A140360711
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793103435;
	b=RkN2TrYjtvjh6KWPnsFFAW+TAcNXjcrutMrL+fsSqjjzxPYCPmErfTPRdn7luLs2mjpr
	 OIMDQjkdbodKnZfrImuC1c0BTbqalLgIOYD2tQqJm2mlvnShmoxo9tL6+U2KYeC4WmTwl
	 fxwPx8UJ4Jc4qor+w/wqDMfDGMUerkDYEku8FUut+9qd8DYY5DUKVae3rexCS6+3MrRUl
	 wdnscWHIfwaYrFe9T+9lWL3MctbH0yJgZBLLl8FuueVkW9gpXUvXgZZl8csaUOFI55/r7
	 +dy+Ffp9Z6Vdj7n/0w45wPSiYyfkkiyOVQt0MFkx+yrdwhJlhCu5WY9aZ/eHS2ote8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793103435;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YhcjD1YBMzA5Xs7JoqVBnf/2Enan5NxfdYZ+s0ul08c=;
	b=WTVLIxeG1A0j2+lypka4qJ/UG6FTD2gVNEK9svEYSEegWUEOBbkjOq4/ZGrjZoacyKEN
	 nV2yKAo2Z11XAtAN/G8yTbwUmE+94eFP9XJsVGVU681emh3pdM4arYULhlo+cGNYAatiB
	 PYxASJITXjtaZNkBqczymRjYH6qlysHy1O9Cnvl5NKcn26EGBlqn6Cxe8ziulku66uO/e
	 z4+sGUi4s4EYPipJoIM7OOAQuK4uVEy62GR+MFQjWzlhvTIccvGAB2/DwkNr6mvYRiebF
	 L0P+dnB/EBtQOYeBjSJ1qZkSfZRgdz/LI4XWc8frOgARF5fXiyLkggvBUwEqNXmCu2w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c/x5zjto";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793103435;
	bh=YhcjD1YBMzA5Xs7JoqVBnf/2Enan5NxfdYZ+s0ul08c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xg2BC3UNlC1ZFjDgeiVbs85sOy2396lawCWy/zfRE4D+O00QvKmVbyPr4+RA+4lZc
	 CxwiLN1Otl7rdWI3wGCWF8LBKpgzsn6gZC6p4U4pfkfyQQb3rMm0rAz98UN4580Qk5
	 RWNFy/NN4V1HDZze/Eo2ifKuC5/4syD+g9cWoN5UDgcJ912T2ZHJmcs1ZcO4zmcJI0
	 xmPLsM1q8LDhJ9T7NSOvtlV3kSBlH/tcTB6u2xl/HnmAa6AfoQVgIa9OAyCoGelKgz
	 CHQWECtyA3GgaE+4LV1pEHdmAoj1G8Sgi0Gqer3x2gXSA8wQwPrgoF53a4RaMTB4yb
	 ulSDwfA/qU8pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A140360711;
	Tue, 27 Oct 2026 12:17:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CDB13D9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F2E560711
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XsLVBR8_MUv0 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 12:17:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A7AC606BA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793103432;
 b=drVlOw8O+qtQ4TgkbgTMCTWYM1LMbefbWmUeuH8C5ASC/0RJRpBAyCNBihxc/hryKMXE
 fDS7r7skt6kA4NoNtjJcabYDquW0y4U5yw/kPvQcmk9iIaGzjKdEMpp8ZAfNUbKPzrc1a
 qPjbiWco4T6Qef/rv/QF9qsAB6rrJ2B+XdgqVArFkHjKYucF1ouwMh+jw4npCsCFPyPzZ
 426hckcsuI56d8ZtOF4r/adEl7DiN/yADF1EVod+BSsDSNLwEr/bP9CWdg/tiXSa4aqz/
 i3p5tSTZvHP+WzcuPIgCB/fqiGgH4DQDzqDmB4QzyUGpt5vrF0gve5NMk0LaG+/kuWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793103432;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=YhcjD1YBMzA5Xs7JoqVBnf/2Enan5NxfdYZ+s0ul08c=;
 b=p1dGqCjn+4iP8SfaOCU8T3QP6ZeMCaO+wO5SqejVPxfqn4YcJrpUirzK1kya9b9tgSFG
 f4C+sn1hMqiSd+C0mtuT7SJA4zkacNG2LPSl9B4rXyxZM05m3S5Jip2NW4upsrFPMUWUW
 ZEXnh9kFWo6CHH7Eg/HG2l31WfhSeQVjU86mFuXjyOjOa0A/3oH/SDSKBN3pzSmBH/P0f
 OoHVOk+822blwkAPZJ3QX7dqUDBuLeMLsAc0/feP8Oltki22h5ol7QMIIpELq2t36vrtu
 NrpdLGq4PqiuAGOHwKV4k/SHlbwklS20rCdFHcSTQloxI+Afhm9Exa6YlX4NZz1Y6lg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="c/x5zjto"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=c/x5zjto
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A7AC606BA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 12:17:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0138743B32;
 Tue, 27 Oct 2026 12:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4581F01825;
 Tue, 27 Oct 2026 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793103430;
 bh=YhcjD1YBMzA5Xs7JoqVBnf/2Enan5NxfdYZ+s0ul08c=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=c/x5zjtoSUWG3kSbfh2U+NnRQ109lCtJVwu5+uOcfnNbifpj61anmMJ8cnZRp0/eh
 7Uo0BhRmcPNF8Pef1y50r3+x4i4HMz99vhb5uyo+hIOl3Kv3xKARsl+XbbvMgf4zQ1
 b4+PkKXNNQ8YLkJhuoZfK/MomyirEV027P/LxDA/Xm5FYDlZe6GXeu4hksqXWEcaOJ
 0A+VLqY2n0W7PX7seGzH78MN+cuvqrLzE2iExxPS6FCaeEkFQjBbpEgeQYMcNI2kKr
 vj/YRwmAHAQ62WAPiGhiBu6f7fhGE1mk5ziMYm0QTvb75F4FCIPZudCvuJB8gHHFTx
 35eXFNx2CIZrA==
Subject: Re: [PATCH net 2/3] igc: prepare TSO and checksum offloads before TX
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
Date: Tue, 27 Oct 2026 12:17:09 +0000
Message-ID: <179310342944.3134.10071026023246764321@kernel.org>
In-Reply-To: <20261026091549.605810-2-p@1g4.org>
References: <20261026091549.605810-2-p@1g4.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message misstates what the patch fixes.
- [Medium] igc_tx_csum() (drivers/net/ethernet/intel/igc/igc_main.c:1200)
  still ignores the return value of skb_checksum_help().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but ixgbe has the
  same skb_get()-before-skb_cow_head() ordering and the series leaves it…

--

igc: prepare TSO and checksum offloads before TX timestamps

In igc_xmit_frame_ring(), this patch moves the igc_tso() and igc_tx_csum()
calls ahead of the TX hardware timestamp reservation. As a result, the
extra skb reference that igc_request_tx_tstamp() takes no longer exists
while the headers are being prepared.

> Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
> pskb_expand_head()") replaced the BUG_ON() with -EINVAL, causing TSO
> preparation to fail and the packet to be dropped.

[Severity: Medium]
Is this description accurate for the tree this patch applies to?
c7d8bc3dd511 does not appear to be an ancestor of this commit, and
pskb_expand_head() in net/core/skbuff.c still has:

	BUG_ON(skb_shared(skb));

Before this patch, igc_request_tx_tstamp() does tstamp->skb = skb_get(skb),
which leaves skb->users at 2. If the header is cloned (for example an
AF_PACKET tap clone from dev_queue_xmit_nit(), or a bridge or mirred
clone), these paths are taken:

  igc_tso()->skb_cow_head()->__skb_cow()->pskb_expand_head()
  igc_tx_csum()->skb_checksum_help()->skb_ensure_writable()->pskb_expand_head()

Both would hit that BUG_ON() instead of returning -EINVAL.

The stable trees that the Fixes: tags (2c344ae24501, f38b782dccab) point
at would behave the same way. Could the commit message say that in those
kernels the symptom is a BUG(), not a dropped packet or a missing checksum?

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index f1bf4e462a511..cd4c9815fca7c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1678,6 +1678,12 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  			goto out_drop;
>  	}
>  
> +	tso = igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
> +	if (tso < 0)
> +		goto out_drop;
> +	else if (!tso)
> +		igc_tx_csum(tx_ring, first, launch_time, first_flag);

[Severity: Medium]
The commit message says "igc_tx_csum() ignores the error, allowing
transmission to continue without completing the checksum". After this
patch, igc_tx_csum() still throws away the return value:

drivers/net/ethernet/intel/igc/igc_main.c:igc_tx_csum() {
    ...
	default:
		skb_checksum_help(skb);
		goto csum_failed;
    ...
}

The reorder removes the shared skb trigger, but skb_checksum_help() can
still fail in other ways:

- -ENOMEM from __skb_linearize() for shared frags
- -ENOMEM from skb_ensure_writable()->pskb_expand_head(GFP_ATOMIC) when
  the header is cloned
- -EINVAL or -EFAULT for bad offsets or unreadable frags

In each case ip_summed is left as CHECKSUM_PARTIAL with no checksum
written, and igc_xmit_frame_ring() continues to igc_tx_map(). Does the
frame then go out with only the pseudo-header seed in the L4 checksum
field?

The default branch can be reached because igc_probe() advertises
NETIF_F_HW_CSUM. That lets CHECKSUM_PARTIAL skbs with any csum_offset
arrive, for example packets forwarded from tun/tap vnet_hdr guests.

Could igc_tx_csum() return an error and goto out_drop on failure, the
same way the igc_tso() < 0 case is handled?

> +
>  	if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
>  		     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
>  		unsigned long flags;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
ixgbe seems to have the same ordering, and this series does not touch it.
Later in the series, igb is fixed by "igb: prepare TSO and checksum
offloads before TX timestamps". ixgbe_xmit_frame_ring() still takes the
timestamp reference before any header preparation:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_xmit_frame_ring() {
    ...
			adapter->ptp_tx_skb = skb_get(skb);
    ...
			if (skb_cow_head(skb, 0))
				goto out_drop;
    ...
	tso = ixgbe_tso(tx_ring, first, &hdr_len, &ipsec_tx);
    ...
	else if (!tso)
		ixgbe_tx_csum(tx_ring, first, &ipsec_tx);
    ...
}

ixgbe_tso() also calls skb_cow_head(skb, 0) itself. Once HWTSTAMP_TX_ON is
enabled and a socket asks for SOF_TIMESTAMPING_TX_HARDWARE on a GSO skb
with a cloned header, this path runs while skb->users is 2:

  ixgbe_tso()->skb_cow_head()->__skb_cow()->pskb_expand_head()

Wouldn't that hit BUG_ON(skb_shared(skb)) in pskb_expand_head()? The DCB
software VLAN skb_cow_head() call and ixgbe_tx_csum() also run after the
reference is taken.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026091549.605810-1-p%401g4.org
