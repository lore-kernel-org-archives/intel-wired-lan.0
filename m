Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC67CA9ECF
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 19:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F003405DC;
	Sun, 11 Oct 2026 19:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fAidNcVKHNDx; Sun, 11 Oct 2026 19:04:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 84066405E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791745453;
	b=dZtLgdkc0ud/dgD/Yf+wmF9TDapXfBL50Cm1HEzw8eGAf7nhOz8A6mTohQn72S3MJXGX
	 ypBCq+ReW+fqQJJCfBIfsmnX5Pb6+8/tzQGvYm0nPhKf7lSSudz3GsnsBTvdUnc0LpJqf
	 PES+EU466eEE9/cu+fvDhEoJylZ+KbLfsIsFM92U3lgP3kfEd5du2tK7d93t82MSv8Chp
	 iyTP2EQX19GcrizlMskYkedGOsVMj7LuIhvPEZy1k4VAjLBlkrU2nxCkzxPGMXnxT1kq1
	 BwbDFbZXl8YdxyqKoG8mNqGHvKtrsmTR7eUjwdx71xZIOahLNQrAMbZEV/9a52a92Zg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791745453;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4vxOlSiy9OgWc0Y0eZ4LnuQ00GAjNw7bsz9uahntp8s=;
	b=N/+dt+TO6j9qqOhahpjo8D1olDK2/xziILxmL9YRbFVoZzQc6CSdBllB1n2wnip0qjDk
	 c+FaMWo4Wqztrz6+Gp5qH8ZhlulfUPMeQVSf4dU9Vi5+RzpX1VLIAkcbSRzK7E/1rTmyD
	 u0FSqXeXeIs49gLR8fSzcH1muC3Ax13ORhSIe6/RJ2fK3SFCHM5qmXBZEV8vsvEryilH0
	 15exn2bwauxYzR+TW3mF2rQMCgN/un0PduwDzYQ4ktiihkQEy4Rzvjp+ZHKC/cAA9doJJ
	 V6vMgbZjSgb2eNYQjMRKNMPIxNBBQC7LujELVbRdp1p+yr93J9gtsJTyGu61PvZEUeA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791745453;
	bh=4vxOlSiy9OgWc0Y0eZ4LnuQ00GAjNw7bsz9uahntp8s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gobSY61NcKwfF9lMqPskB5EEK7p+LoxF+Gl5AQ9AQHqQi9roO2ZMvYYBSpdgx7Wxn
	 nBAcHzvUXYG9xi2Tl7XQeFvTl+XicjgPv4aPzwL6ZQAAUD6HsCnC5ITlxWcizhPTFh
	 47xzZRsbjW4EP+35w18p4Vc8N40jioDL1c6LBAZRCXpfavhQFMea7aRAgNdBRjLvry
	 /hPONlhWB4kxaQdY1ggO4Er8/XZZqEfKRnozuq9wPqrFMsyEdsrrQXdKCMNYTNXDZs
	 aGYoRFJ0wiOpOEmvX4w9hhcpveGbpDUH46SnDHNNBsKlRB1FRU14dX/9P9r2bD5d3e
	 v2994tQL8Lwog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84066405E0;
	Sun, 11 Oct 2026 19:04:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5480B75
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5212180C88
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ABAPuVPdgS2A for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 19:04:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4160D80C8F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791745451;
 b=JMJmMMFy9vPwxXHb/7dIwLVRKQvjr9bb4T81nRCKO9OaU43B/HuhJAipW8S2q9/aYDyH
 norBySYZojC19HZ4ntXQYOpw7otNXVJEeRFmNSXkfdqQCDZSgGaKizg8D9+LSRR/lA0gE
 EQISDUZCVGsVt024Z0uk3S5yIXuTFyfqlwiKXbuN+FjTWDA7kwMMD+NO0MBZhqfBKZV99
 G6lcbW6/eSlMXWtq5z0lNa7t8cRhALAhhau6Xw97Gu7cPZ6hnDfKy6DTMQlfyHSmzjIBw
 8CbhrCf4hJooLqA3v30iJ+bg8/YCsS7O+d+vA9bLnvkBnwGtzV/Mi8HNb7JMKzCCwDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791745451;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=4vxOlSiy9OgWc0Y0eZ4LnuQ00GAjNw7bsz9uahntp8s=;
 b=i3WqdcZxNtcWIyiSShPgXzCoAK6ldyULSIqVKom+o0BHV/XfYgCnv8N41H2Xlk7BV6hj
 J/lNkdp7ZOMiQmjsKQEuP4ah62BoYmNkLYRIIVEfpaykw8BdcPMDeFJ+G91dvTvBT2c8d
 BEvULl2/FxCt50N9c9iWvyv+IqjA2WrbcbR7MJuRrvjg0Lxl6N+nHCdSKEwUraTHKhBhJ
 s/cp5TyZh8FafmYWZjo6Kdxk2aKRmSIiXJ7CmNOwQrgU3DjM3edDp4r5wXuR4R/agSoZu
 eGlGnuSlP7P/mxYEW8tWun7aNnM5KEFj5VlTf3nSWU0CTxuk8Or2RqTPpo1rKKp5M4Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CjY4UeAJ; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=CjY4UeAJ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4160D80C8F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9AE8A602C3;
 Sun, 11 Oct 2026 19:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4261F0089B;
 Sun, 11 Oct 2026 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791745449;
 bh=4vxOlSiy9OgWc0Y0eZ4LnuQ00GAjNw7bsz9uahntp8s=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=CjY4UeAJxeRG+6zxZ2JMQ37NUAAJU7B0QFD0x9u4mXCWNj3x6vTki4Ex4jmP5nmTr
 nEldysQH5Y/i+i6Ds1cl7TMCoF4zbdO7g9CiGRvRY0SLb70r/ihN0mDoEIRqtoYn3w
 2uzBXoO+p4seJUiCIHK2K9XYeWjuiQQAxemBKvKRSUv+qTLZogLvdD8pFDes31UBO/
 qqqUxMv4TP2EuoPSEBNUPyElJS9DYJKkxV4am0zKNhEx33NSG7p9azBdb6wpDNxnk6
 PRlz/r8bMcy04afRZ+RkwV6mpYk6jovQOrSnOeAcoCdhP2F5rRABrdly4WqTQ13wd+
 m9WvDT+KPx5QA==
Subject: Re: [PATCH net-next 8/9] qlcnic: use pskb_may_pull() to pull excess
 TX frags into the head
From: netdev-bot+sashiko@kernel.org
To: josef@toxicpanda.com
Cc: kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org,
 davem@davemloft.net, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, jgross@suse.com,
 sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, manishc@marvell.com, 
 rahulv@marvell.com, GR-Linux-NIC-Dev@marvell.com, shshaikh@marvell.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, xen-devel@lists.xenproject.org,
 intel-wired-lan@lists.osuosl.org
Date: Sun, 11 Oct 2026 19:04:07 +0000
Message-ID: <179174544742.434549.15432453849443944349@kernel.org>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-8-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-8-9512b0fb977b@toxicpanda.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In qlcnic_xmit_frame()
  (drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c:681-688), changing…

--

qlcnic: use pskb_may_pull() to pull excess TX frags into the head

This patch changes qlcnic_xmit_frame() so that it no longer calls
__pskb_pull_tail(skb, delta) directly when a non-GSO skb has more frags
than QLCNIC_MAX_FRAGS_PER_TX. It calls pskb_may_pull(skb,
skb_headlen(skb) + delta) instead. The commit message presents this as
an equivalent API swap.

> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> index 761ef3bc8193a..4a81d499e51c0 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> @@ -682,7 +682,7 @@ netdev_tx_t qlcnic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
>  		for (i = 0; i < (frag_count - QLCNIC_MAX_FRAGS_PER_TX); i++)
>  			delta += skb_frag_size(&skb_shinfo(skb)->frags[i]);
>  
> -		if (!__pskb_pull_tail(skb, delta))
> +		if (!pskb_may_pull(skb, skb_headlen(skb) + delta))
>  			goto drop_packet;
>  
>  		frag_count = 1 + skb_shinfo(skb)->nr_frags;

[Severity: Low]
Is this exactly equivalent when delta is 0?

delta is a byte count. It is 0 if all of the leading excess frags of a
non-GSO skb with more than 14 frags are zero-length.

In that case pskb_may_pull_reason() returns early and never calls
__pskb_pull_tail():

include/linux/skbuff.h:pskb_may_pull_reason() {
    ...
	if (likely(len <= skb_headlen(skb)))
		return SKB_NOT_DROPPED_YET;
    ...
}

The old direct call to __pskb_pull_tail(skb, 0) always reached the
pull_pages loop. With eat == 0, every zero-size frag matches
size <= eat, so it is unreferenced and dropped from frags[]:

net/core/skbuff.c:__pskb_pull_tail() {
    ...
pull_pages:
	eat = delta;
	k = 0;
	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
		int size = skb_frag_size(&skb_shinfo(skb)->frags[i]);

		if (size <= eat) {
			skb_frag_unref(skb, i);
			eat -= size;
		} else {
    ...
	}
	skb_shinfo(skb)->nr_frags = k;
    ...
}

With the new call, nr_frags does not change. The recomputed frag_count
stays above QLCNIC_MAX_FRAGS_PER_TX, and nothing checks it again.

After that, qlcnic_map_tx_skb() maps every frag, including the
zero-length ones. qlcnic_set_tx_frags_len() then writes this frag_count
into the first descriptor. The descriptor loop programs more than 14
buffers for a non-TSO packet, which the comment above this block says
the hardware does not support:

	/* 14 frags supported for normal packet and
	 * 32 frags supported for TSO packet
	 */

This needs an unusual skb layout, and no in-tree producer of it is
known. Even so, could the frag_count be rechecked after the pull, or the
commit message mention this difference?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b%40toxicpanda.com
