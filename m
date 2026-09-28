Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA80C9833E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 10:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DD7D80DF5;
	Mon, 28 Sep 2026 10:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qby9Gj09FP_x; Mon, 28 Sep 2026 10:16:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3A4CC80CC3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590598;
	b=QttSOKnc16Zv7uy3yaZbLyQMLmfJDXRmeiFBxCiAvdP4g06gUHR4nucjmO7Pne7vSwIB
	 HujMWbMNQD/iyNQ2BYs5uP9PyU/hpfcLP07DLJk96ZvRbHWXR424clDSX14liZxj2/B21
	 sM1uBx11bo8DndpHRnr0aqpdfQnvVx8X9LrokSsnlmCtLgRah8oKuDooXV2ypMGxl9neX
	 TXXiaJbkOYQ4YryniHIZj0ZIxymGElomgbOoDyEisOWf3Jc3RM6h8HLW9WHr7ckWC5hX8
	 I7OKBrOoO9wLbbxhtO3djThZgn0DanYjW5IRueFfhev289GZh/T77QQ+9bqf+sLPycQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=etan1i0QlkGI9ymPe4sBc1kewwzg4v5oWnGmaGuoq0Q=;
	b=OdRojRbBD5uhfpFFUam06kUiSaB5RTwJrxE5KjtLkKW/oeCOfVtl/KR8JxBTlZjR/xnI
	 k67MgBBYeXxUZsgJUsA2SZz64KYh8pCpHkZqFs/p7B2LmfMPAf1IT7nDbuK4TVW93nD5a
	 Ucc/HhpL12yv8wJv+x5lEKaPhTUL0x8BwbYIZnPG9itPHqTmSAqAODbJVrEHDR2rUehWs
	 sWBtzqPFxGnIfASrh/w2hK+SpArdRij9mQab4uAaH7lvo2N3PAouBovMqCsQ6+yLz732k
	 6pxx10lxyCfdqmIcXQJHGZkVgnaQQRjUJdVSrJZ49P6YqC5s6VDIX9hRrz2Uo4qErEw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790590598;
	bh=etan1i0QlkGI9ymPe4sBc1kewwzg4v5oWnGmaGuoq0Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WBVKn2MGfkWzBkJPv8/yx+Z5/luMpUIXp3OZs1NRcLJ46Ev8oz1ToAdSH9IllBBEo
	 GCSkHwHGn+juGZHLXfMe5Nv5XMlPg0NKyOkin7EKTcA1JVJRe2jG3ls2+tTqEjEoqu
	 Te/SO229ITOL27a/RNhAyp5ZfLJa9+tGzZsaxxwE+DRz3N0jMwDMphKvbT4kiyZnEO
	 5yG8Va/+eX+fBpPAdByNj8NFCZj5jY8K/tKFaNkkgMNpjsUD4APVDLhtWkYuVAolOf
	 hIHRWCIymj4KSKWjyTH9+KmAfRTN1QYBOvEbeSgBdbW/6XvqYAiia84PetiZkdT2IR
	 QLbBw2v7UylTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A4CC80CC3;
	Mon, 28 Sep 2026 10:16:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFA99361
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 10:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5801401B1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 10:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgx9UiH60xqY for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 10:16:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8EF564019A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590595;
 b=VkaYG55/PoJ6JeqcOhbcxqJga6nPERVRyjTqcGNQW3+2Fb3lfIyxwpBslBVIfC6NAtII
 ah14xtZHMjaU6U6tk7nrMI+5MIHoM+6tRyn+2RlNBYLNaIPx2QA/tWXHe56A5Y9/5ZsPQ
 WFDsJQKsHatmPD1LsJw/ayuaShpv9BH3epkPus2JPYtM7gevTVO8cXdsdVkf/sO9B5euo
 cwPOrElGtrGiqD4U8mcJbEHUx84LbjwMFPpZwLA/S8GFLVoRKkVpR7ye4ncEq2Pyy4vz6
 zXDhtw0YIQ3ty8ktfPuIirrxGdc4GnNl2IndO1e74uWMeM4hDxSucd2GWw3exWjJSwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590595;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=etan1i0QlkGI9ymPe4sBc1kewwzg4v5oWnGmaGuoq0Q=;
 b=ICftggTHXJwlSRiGN1YB8RNQDkx7l60bz9X9s6Vj+CbgiWwZSPTcosWaZu2+trlzr0s2
 uw1KNtrBTHCtvKHJtN36sgXpbqFHKUk2Ih1D5nbxHdkMWw5JBWGrq8V4Dp4SGNGCYJpIx
 hIlQ338CA4X/p8wHqWCycQZB7f2YKgFrjZTqMXCI0qGptkbw9ZC2qXibYBAOdWVbSHAky
 S5qImI3fuCpt/wYAQ+lV0rZgm6KeJ1oU6fyU36vNPPyHJPfwlAWqWi3PKcOvJY3bzSl+/
 kOHBADFXOpT+bIRxXShYg85swULRLPvYU00Q/fFx2KLOyc/a8WbwFev65YZKJGcLl5w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ea2IoAqb; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ea2IoAqb
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EF564019A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 10:16:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41DDC600CB;
 Mon, 28 Sep 2026 10:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462611F000FF;
 Mon, 28 Sep 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790590594;
 bh=etan1i0QlkGI9ymPe4sBc1kewwzg4v5oWnGmaGuoq0Q=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ea2IoAqbhQBN298GzM7zylp3SKGP+PY+5jwXn8L7vS99opwR+N/Zm7DwK+j0dpQap
 AjTgk7uKldbJTFRMpOUGiuzIWqE6WbbNQZFIqdnDtS+oOsd62lHMaAUZX0MnpnDrJR
 yjD7nKqP2s3dBg4GVCNcLTVHzcZnevEOjfPr1RkgyouoMtLsMVxiYFbspkcFqCI62I
 Jkr8bjl92VXgKIK9BGycHje20ZPIysXbbs308FqZslmjlx1B/kmCcfeMwH7P+T/Nya
 2Xr30D89hjEzJzuWa38UfcDLvIi2RJUbsQbt1cYVrLSodPVSSA+wHxSKGzusk1kTYO
 xeGMIrj0zUv1w==
Subject: Re: [PATCH net v4] net: e1000: fix warning in iounmap on probe failure
From: netdev-bot+sashiko@kernel.org
To: nsvatoslav515@gmail.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com, stable@vger.kernel.org, 
 aleksandr.loktionov@intel.com
Date: Mon, 28 Sep 2026 10:16:32 +0000
Message-ID: <179059059281.3145.5878621064360703289@kernel.org>
In-Reply-To: <20260924095955.3471-1-nsvatoslav515@gmail.com>
References: <20260924095955.3471-1-nsvatoslav515@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says something different from what the
  patch does.
- [Low] The Fixes: tag does not match itself.

--

net: e1000: fix warning in iounmap on probe failure

The error unwind in e1000_probe() unconditionally calls iounmap() on
hw->ce4100_gbe_mdio_base_virt. That pointer is NULL on non-CE4100
hardware, so the call triggers a WARN_ON_ONCE on x86. The patch makes
the MDIO unmap conditional.

Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b

> Fix this by conditionally unmapping the CE4100 MDIO base only if the
> mac_type is e1000_ce4100, matching the exact logic used in e1000_remove().

[ ... ]

> Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY registers")

[Severity: Low]
The subject in this Fixes: tag doesn't match the commit. Commit
13acde8fffc0af has this subject:

    e1000: cleanup CE4100 MDIO registers access

That commit moved the global MDIO pointer into struct e1000_hw. It also
changed the error path to iounmap(hw->ce4100_gbe_mdio_base_virt), so the
hash looks like the right target. Could the subject in the tag be changed
to match? checkpatch.pl flags this kind of mismatch.

[ ... ]

> v3:
>   - Switched from pointer null-checks to checking hw->mac_type == e1000_ce4100

[ ... ]

> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index d7f5c6f16142..d7e279b739b8 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1227,7 +1227,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	kfree(adapter->rx_ring);
>  err_dma:
>  err_sw_init:
> -	iounmap(hw->ce4100_gbe_mdio_base_virt);
> +	if (hw->ce4100_gbe_mdio_base_virt)
> +		iounmap(hw->ce4100_gbe_mdio_base_virt);

[Severity: Medium]
Does the commit message match this hunk? The message and the v3
changelog both say the unmap now depends on hw->mac_type ==
e1000_ce4100, "matching the exact logic used in e1000_remove()". The
code here checks the pointer for NULL instead. e1000_remove() does this:

    if (hw->mac_type == e1000_ce4100)
        iounmap(hw->ce4100_gbe_mdio_base_virt);

The NULL check actually looks like the more complete fix. In
e1000_probe(), e1000_init_hw_struct() sets hw->mac_type well before the
CE4100 MDIO ioremap runs. So on CE4100 hardware, these two gotos reach
the cleanup with mac_type == e1000_ce4100 and the pointer still NULL:

    err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
    if (err) {
        pr_err("No usable DMA config, aborting\n");
        goto err_dma;
    }
    ...
    err = e1000_sw_init(adapter);
    if (err)
        goto err_sw_init;

With a mac_type check, both paths would still call iounmap(NULL).

Could the commit message and changelog be updated to describe the NULL
check that is actually submitted? Since v3 was sent without the staged
changes, it would also help to confirm which version is intended. It's
also not clear which version the Reviewed-by tag from v2 covers.

>  	iounmap(hw->hw_addr);
>  err_ioremap:
>  	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924095955.3471-1-nsvatoslav515%40gmail.com
