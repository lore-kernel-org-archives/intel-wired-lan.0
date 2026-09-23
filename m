Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFBBC9830B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Sep 2026 19:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F573806E1;
	Wed, 23 Sep 2026 19:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3WePcTQA0C_U; Wed, 23 Sep 2026 19:02:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 83800807D5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790190126;
	b=AvYbZYklzlv/3efKJTjtZTer4eSfR1X47sIcLcV1Mdv6YOm30GGOKpJFCBouy53dDN72
	 Xsvwk8dmpYEqa0mUlloT2s88lSyIFujJoLWRfA5dM7ov+q/uREZtCXDZxbhNPOAr1cHDF
	 cRcS6orL+P3dnECklQeXH42SuTmKsm85M475VgSqCUirqmROnsEp6CebXHp/8nRpVhQZN
	 aSRGKC9coWkMf4/fwTQuQKysRDdqPS86BCuqh8EgPmNMuCvPQ8AEU+r4amcrtLy4lrIaN
	 I/iUP/JIotlQBCfcLI1AwQVXa/V11Op+kq+lvque7KFsLueVntz/bMH08Z4WfL7/b4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790190126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+8Sw/rOqgo8SDRpNG8SMic0S0ngCWUQ7HXsEYLpHeq0=;
	b=i9/QW0SA+HvkhE7ZdVb0atrA/J1J3sKWJxUGReXFIU3oXThK07qmNj+myfTp00Wh9oeB
	 PBVin+zyuXEB3Je62sbfDU8LPzChetk7hTPFtMcmEV0xuBwQpF3nxsQAwtpCeOaLEQ5zx
	 oFDi2FkrFOIA9YYRw6mFlBMX1mBbFs2j6MrCZla25MgiG1nQWEhAktSN4Ea+U9DixuHe+
	 7jKk86aM/ssGP8kI7WInmDBPVsDLVXs1VxNupyXPbk9PEMLdIMBZBQg5+AgWctSENq1kl
	 nI6hZtUBgIIbmpJB3aN3wTeZNHeS3NSrQVNR/gw1cGt+MoQJxm8IqJIAmE/EbntqZQQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790190126;
	bh=+8Sw/rOqgo8SDRpNG8SMic0S0ngCWUQ7HXsEYLpHeq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zUb4N2wl/sDzYCjWyrwVQTknEYQ2hC07TaRdPzfIaffid2Dz0Qcbc4E0hzJUsR8Lm
	 fmSHHUULBsrpJ4FSzvRxdclhKiYLykRRXQ19n3E+UtTBEYs/F3dAgwUl3rIuyjv4xP
	 3AU/tEhTlhooLNnuG+5bgHR5LEehxCqz1UJ/FCyF9c4DjXtgv3MqYzYRVhmKXpS2MI
	 XcfzIyxEewX7eFcQ8B7v6HX8s0+z8HOYoWP2tWkHmJ8vSPeiNsImCONtlY8fbkkV6P
	 rxlq/6GGRe2/0qjsVxYyl4ESUbjLdmKukPHJzmbhPtfMEEsD1dR9djgLFl/blU+kAJ
	 3b1BC7YqQryRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83800807D5;
	Wed, 23 Sep 2026 19:02:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 99A4332F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 19:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B2E260B73
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 19:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wDz0_SfAMhKc for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Sep 2026 19:02:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 68F0E60B31
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790190124;
 b=Yu1PVInr3qI2/lgXdypu0S1amLcpliihRvxalKlZoUJWxeT+xcKE3c9tl4Lirh5RVOTt
 Mr+FbyLO0OuKK8pV0uabfu4X3/kJOnj9BRXVNDgqEsp4NLc+yAp6s2xMRusujVNh1ODAE
 FYvIaZ39UNs7ttYl+bzkGetbh0sxw2sM0lloOnxXyJ1eNVEokIDhYBFuXIdYIxTucsTUX
 yBB7E2d845mh4sjKWOsLQihHNghOT5ROwDMyobOcI68l3uPU+zuSkSEekSAzDEGoS/tg7
 CZtgoyVKlxVUVzZKo1Q+CNP9dySz1p/dCZywUspeOLj+/XJwUjaKuj7OuYCVqHo1ggw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790190124;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=+8Sw/rOqgo8SDRpNG8SMic0S0ngCWUQ7HXsEYLpHeq0=;
 b=IhCql0l/14nn4oBOvYdPtSUlVrpKC29+Iq7r9axj/OoGZKvLEEVTzjJOQ5jJOXzBKlaT
 ADFvXiQMG1csnQbWTKZ4SlfFwpkYYfZoWWTXpIzXMA7Zk1S5lFT+sAw01/IvAvpGHKVkX
 YdP4YX9jnpdv0e9nTQbpvhnJHp9NlzcECx/Mhd4LJFK8snfN85H0+nnpYDNlWp30LJDWw
 kpMCD8YnGUZ4pwRgKi7vKARFawjWsEdfn5xJweZIPEJjuz+xSToYiq3vGUUXTlxT6ebjq
 mPX/xEb9rr5UN994mghV0ZFRtfOSnpg4mX0kbzE3Kna1YbYzdco26buw/CNyWo3l/Tw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hlU0VPnC; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hlU0VPnC
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68F0E60B31
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Sep 2026 19:02:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 278EA600AA;
 Wed, 23 Sep 2026 19:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322161F000FF;
 Wed, 23 Sep 2026 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790190121;
 bh=+8Sw/rOqgo8SDRpNG8SMic0S0ngCWUQ7HXsEYLpHeq0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=hlU0VPnCzKfnlTys/E135bK8UEiTz3i50Y2GM4ca6KVBT4Ib4v3G1JGQlR6Xdc8M6
 tltjNM0mVNgCQV8CFiwJikKPzpw+ykFJ5iN4WWVtHdhpKO9XwoTZpnQaFEfte0aNiR
 qCalO/8C4okV2A7qLEwh3PeIiKKuNqluhgsmb/dgoRCUtWeVDkpfhu4oNMPYosdgTp
 AdvUio3MqEnf+HXxZvd/yN+NOR9DW1A/p183ol06VRHMqJa9Q+ZcPsPlbsfA+XVCU+
 tu4WH2X/YWqodZ51nvhGnEh2a4k48JESImDXwQjyHg2FTX+wnNUlIU66nKJuGFLnSO
 BpB+zbHl1uAMA==
Subject: Re: [PATCH] net: e1000: fix warning in iounmap on probe failure
From: netdev-bot+sashiko@kernel.org
To: nsvatoslav515@gmail.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Date: Wed, 23 Sep 2026 19:02:00 +0000
Message-ID: <179019012072.2160803.2987779879938123307@kernel.org>
In-Reply-To: <20260921125932.7943-1-nsvatoslav515@gmail.com>
References: <20260921125932.7943-1-nsvatoslav515@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes a genuine, user-visible WARN splat on the
  e1000 probe failure path but carries neither a `Fixes:` tag nor `Cc:…
- [Low] Commit message contains no problem description and no syzbot
  `Closes:` link.
- [Low] The newly added `if (hw->hw_addr)` guard in the e1000_probe()
  unwind ladder…

--

net: e1000: fix warning in iounmap on probe failure

This adds NULL checks around the two iounmap() calls on the shared
e1000_probe() unwind path, so that a probe failure no longer calls
iounmap() on an unmapped pointer.

> net: e1000: fix warning in iounmap on probe failure
>
> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>

[Severity: Low]
The changelog is a subject line plus a Reported-by: tag, with no
description of the defect.  Could it say which unwind label is taken,
which pointer is NULL, and where the warning comes from?

For reference, on x86 iounmap() starts with:

arch/x86/mm/ioremap.c:iounmap() {
	if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
		return;
	...
}

and hw->ce4100_gbe_mdio_base_virt is only mapped when
hw->mac_type == e1000_ce4100, so it stays zero (from alloc_etherdev())
on every other part.  Any failure reaching err_sw_init, err_dma,
err_mdio_ioremap, err_eeprom or err_register then passes NULL to
iounmap().

Also, netdev submissions pairing Reported-by: syzbot+... normally carry
the matching link:

  Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b

Could that be added so the reported splat can be matched to this call
site?

[Severity: Medium]
There is no Fixes: tag and no Cc: stable@vger.kernel.org here.  Is that
intentional?

The unconditional iounmap(hw->ce4100_gbe_mdio_base_virt) on the shared
unwind path came in with 13acde8fffc0af ("e1000: Fix the CE4100 bus type
for the MDIO/PHY registers"), building on CE4100 support in 5377a4160bb65
("e1000: Add support for the CE4100 reference platform").

The nearby 816419dfea5c88 ("e1000: fix memory leak in e1000_probe()"),
which moved the err_mdio_ioremap label in this same ladder, carried both
Fixes: 5377a4160bb65 and Cc: stable@vger.kernel.org, so this region does
get backported.  Without the tags, stable kernels keep hitting the WARN,
which is fatal under panic_on_warn.

> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index d7f5c6f161420..156903089fa6b 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	kfree(adapter->rx_ring);
>  err_dma:
>  err_sw_init:
> -	iounmap(hw->ce4100_gbe_mdio_base_virt);
> -	iounmap(hw->hw_addr);
> +	if (hw->ce4100_gbe_mdio_base_virt)
> +		iounmap(hw->ce4100_gbe_mdio_base_virt);
> +	if (hw->hw_addr)
> +		iounmap(hw->hw_addr);
                ^^^^^^^^^^^^

[Severity: Low]
Can this new hw->hw_addr test ever be false?

The only assignment of the field in the driver is in e1000_probe():

	hw->hw_addr = pci_ioremap_bar(pdev, BAR_0);
	if (!hw->hw_addr)
		goto err_ioremap;

and err_ioremap: sits just below this hunk, so the one path where
hw_addr is NULL skips the call entirely.  Every label that falls through
here (err_sw_init, err_dma, err_mdio_ioremap, err_eeprom, err_register)
is only reachable after the BAR0 mapping succeeded.

e1000_remove() encodes the same invariant:

	if (hw->mac_type == e1000_ce4100)
		iounmap(hw->ce4100_gbe_mdio_base_virt);
	iounmap(hw->hw_addr);

Would it be clearer to guard only the ce4100 mapping, matching the
mac_type test used in e1000_remove(), and leave iounmap(hw->hw_addr)
unconditional?  A NULL check there turns any future unwind imbalance
into a silent ioremap leak instead of a warning.

>  err_ioremap:
>  	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
>  	free_netdev(netdev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921125932.7943-1-nsvatoslav515%40gmail.com
