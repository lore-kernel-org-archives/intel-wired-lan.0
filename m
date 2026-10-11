Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837AFCA9EC7
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 19:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C499405D8;
	Sun, 11 Oct 2026 19:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hW8ykhrn6Tfx; Sun, 11 Oct 2026 19:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 41F61405DA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791745450;
	b=AkUFVFlaMy6LvpSTk43szh/XhV8lw8U2mu+jRs9zGL4FAqDQhKR1+ia7mjVjGQdcnVIL
	 fHmMK4xXmQii1WFQbgOlKTBG6Uc09oxi/Nqe6r1jwCjzvW72k4eUVUx587Ryr4DPc48dx
	 0Y3d+SYwSRPKoJpLsKb0KN+1fHTndYmUB4aizvL8/XeuM/ju6X1R3X8ufZJL51EiAUzNb
	 uBCzalSJ1DIcComCnuRYcjPMp4zt/7+EqFckk9r3qBiLyYypVU3L1r96qs2CxwLuhj4/n
	 75YCi424O5OqDaU6kdF7C7U00hasrYOxQtl5fVJv8TCeZjqAson+hh7VIylqLX7GWlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791745450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ig+0+y+f6lfiozGzYQzbwtDL6sxb4GUQ6Cp/t/tcq3s=;
	b=tUrtj5neAYIk5xcbHd2Cw/40n9W7FkGp8tQ8HqnrGP7rC9Pid1o/qIL/WcVEt5oIlzAQ
	 pqD2Y7d1t9EexHFRAd4/2FcCCQhEM+6xnk62UsS8JtNqO45FVONExOeCdmiFJlXkfCeXZ
	 yBrxhWM8VTjcm06+5k0HWM7Yj/6w/7OmIST4H6YbgSLQarDT/u9Nu3MhpstdF83QfFoZn
	 BWMoBAqj50UitFWDD9BJtUG4z7yeH4GteH9S48EpwLIAlF3e+f0XkLwCqVqZR5gspIEHE
	 /Q8cKfvF//m0DLrg3gjS06cb+cGMWwmoJ0aZo9HerlgUlLWch1mcKSUzbRRpB+DD0Ew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791745450;
	bh=Ig+0+y+f6lfiozGzYQzbwtDL6sxb4GUQ6Cp/t/tcq3s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9dLCcXk5YexAmvuQq04TOpCaL8krQKutLQdTbHBknHkl1caHXLhfP4TJj71sT5w/
	 vekaDw9XchEjcx1puliwXQQTDU4smMh/J+NybA6Hi8nilnxpGPsgK6kPrtpaOvgO37
	 AQ1agvqjVJ37tUEnb5JJjCTgA1JLzzU0yeRIsbC6fXUAMYWG0ECfti6FU79OHQQLsn
	 aB8lPVhjywy41OLo/aNtS4VpSzKUkX0jtwxpXYvM8P/ooliZrGPRM7dRnj9pplxTok
	 vbAEStMSX5izvii/0gAu7/1I9aFtW4k5hywlaWBqHrTpTXKh7WzHubPZr+gwGVjMwA
	 fs58ELfuta0sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41F61405DA;
	Sun, 11 Oct 2026 19:04:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 275BD2E0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0950A80C7E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FsAXjZ3rT0Jv for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 19:04:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F3EA808D9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791745447;
 b=nGIpbYSw1q6CBJa/aC9MDGG/I8YM55pM9GaaIse4wEuVvvHUKyECZV97ZE66bMBjh6wg
 3sfRPS2QItpkubGz8MoVCXuKA/nXWMEDgpuuf581wl/KR+7C3iaXKMD32dq1wjgBA7xoX
 b7vo/JHK8uWap9/3F2gNzTLrZcCFrRrK2S1Pdkk7rJNPwIdwQu/GujxXMIMMASAn5pzXy
 1JogCiOmTgsFmuwbXqOU74bVyigp22PJFKiNOXBbd5JydmcDwfrEssrQWuItfUD0Q89qa
 XUkeFv9KF4D5ayVTWXWoCZ2CrzQ0tJuEvjBZPKeJ5+Bi+yPshuEGXEz4y0iiThSyTNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791745447;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=Ig+0+y+f6lfiozGzYQzbwtDL6sxb4GUQ6Cp/t/tcq3s=;
 b=cE+rmHzgBDdB8sP9/YsgrBausnjs9zNsbSXeAAdOP3pGm1pKtuSuWCjBhwZqhmnFwoAr
 k4JKIS6XLu8xicqXiL7QAbYWRGmUUZ/xCe72OQ+XxMPTv/MeM4cfG2jC/QBWX7K1MCl0E
 eP88gAUcbbq4RCAkovgTRr/sru0u6PZhJr5y8ChaSjUsdtCgafLn+AG8rpj3wHb2WS6N0
 Ax0SS83kfntCrm3jFKNO/JS5KYKTBBH0PBqpE+9uFaq6WUWEww4DHR3Y7jTgeUgfosh8R
 Tofjkm7WdLNfCNFxRCWoyYQEHXbM7ASASYTu4J4BZG7GyOD+Ya15+eq3l0knpsML0gw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="BZo2F/Sw"; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=BZo2F/Sw
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F3EA808D9
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 19:04:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC14D601E4;
 Sun, 11 Oct 2026 19:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4241F1F0089B;
 Sun, 11 Oct 2026 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791745445;
 bh=Ig+0+y+f6lfiozGzYQzbwtDL6sxb4GUQ6Cp/t/tcq3s=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=BZo2F/SwAn3E6EeHf7x+ECDWtVASPkWlWNzltBFSHAwoxQnOlT+nh1NASgrpE4PGO
 lZQJ4xmjJ39tPWzPWN99gpIMFwxDgHEVLl8vW+139XhWKJoem1PGY312qI1g10Ubhz
 jX2cHNndfHdZo5gAY8Nz9UtzxUb2LGjZ5ZaqGV3HG3JWhA4HpZMHhde5fFLf0wPGiv
 WnfkWQSQTZa3/h1B9bg3CDJ3KZnuk8xPoWmwECdRyAI7EEfq6BGXDkog+blD6JuDSL
 KISORjp/9xhmHxYaTyNNpF0/gThUv4mpigBSi66Ksw1rhYxCevY2lkJHqHQXsNHnPx
 TILMeHZD3vnCA==
Subject: Re: [PATCH net-next 6/9] e1000e: use pskb_may_pull() in the 82571/2/3
 TSO workaround
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
Date: Sun, 11 Oct 2026 19:04:03 +0000
Message-ID: <179174544385.434549.3694135096916688968@kernel.org>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-6-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-6-9512b0fb977b@toxicpanda.com>
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

- [Low] After this patch, two unrelated error paths in e1000e log the
  same message.

--

e1000e: use pskb_may_pull() in the 82571/2/3 TSO workaround

This commit changes the 82571/2/3 TSO workaround in e1000_xmit_frame() to
use pskb_may_pull(skb, len + pull_size) in place of a direct
__pskb_pull_tail() call. With this change the driver no longer calls
__pskb_pull_tail() itself. The error message printed on failure is
updated to match.

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad4..e216868e15cba 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5859,8 +5859,8 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
>  			unsigned int pull_size;
>  
>  			pull_size = min_t(unsigned int, 4, skb->data_len);
> -			if (!__pskb_pull_tail(skb, pull_size)) {
> -				e_err("__pskb_pull_tail failed.\n");
> +			if (!pskb_may_pull(skb, len + pull_size)) {
> +				e_err("pskb_may_pull failed.\n");

[Severity: Low]
This isn't a bug, but this TX message now matches a message that
already exists on the jumbo RX path in the same file:

drivers/net/ethernet/intel/e1000e/netdev.c:e1000_clean_jumbo_rx_irq() {
    ...
		/* eth type trans needs skb->data to point to something */
		if (!pskb_may_pull(skb, ETH_HLEN)) {
			e_err("pskb_may_pull failed.\n");
			dev_kfree_skb_irq(skb);
			goto next_desc;
		}
    ...
}

e_err() expands to netdev_err(adapter->netdev, ...). The log line
therefore shows only the device name, not the function or the
direction.

Before this patch the TX site printed "__pskb_pull_tail failed.", so the
two failures could be told apart in dmesg. After it, a failed RX
ETH_HLEN pull and a failed pull in the TX TSO workaround print the same
line.

Could the TX site use a TX-specific message instead, for example
"TSO workaround pskb_may_pull failed.\n"?

>  				dev_kfree_skb_any(skb);
>  				return NETDEV_TX_OK;
>  			}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b%40toxicpanda.com
