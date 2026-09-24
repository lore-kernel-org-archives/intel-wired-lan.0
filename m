Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5617C9830E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 15:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9168F60793;
	Thu, 24 Sep 2026 15:54:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MkqmZ__L0I8Z; Thu, 24 Sep 2026 15:54:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8178F60824
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790265298;
	b=dfoI3G7uB5vNwO8DxK2G7+pYfzZtmVlUhIWwdIwfpCpV4GH1saTuem6B3IQykYS42vuU
	 OGsCOXaQYKaCRt9cr5X4d9CbkSK90GOLzXzuhE6gU6xObfRZCxvm+vSoE51s1pJOY6FSD
	 zEnV3suzrfdO9IHfdLHi5ZrTzLkYHW/vlO/x+gkF2QOi7CEl6KSrp+o6dOutQ+FZSzhhH
	 R335r2x6H+KylelDxPiP82iHIrEUQ37+Y+ezCdIBN5G7Hls7iy/q3yghWBVm0Eqk9/9X5
	 YTXphoue6W60o8Q05k7YgFs2LQRXE7eERsIWmExa2E5uYsqOOE/OP3/ovIMI7haTWgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790265298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WxRwkjeergipzjy0uMRZTXDUDSUf8XVConGIHIBupxg=;
	b=pKG9XIEeO2OR+HgcEVdCPOIraMGjbp0SJUMc+QW3d8JXYbY7d76ZeNWEZ2BgD3UmSZV+
	 fmX93suUqN4sYoT4VItOq9Gg/FhzzB8lEJmXWtJo1sIUo9QBzeTPbe9ccElXuXKTo1JW7
	 /cPJ7wqRW73jLb7cLdCGgMogaodLjDs256kUzYXDUk4Bna9BLY7qimnJlAcR6dcs4pfXs
	 UUffM6GcoHSxOY+wowF+k732glOKxxpNPT8G5aX/Q3EgIeUlo9EUzwcpRBUr27vymF35G
	 rd8DYKgtFtv02SusRVnjfuady7h9IAOZdEZp46Qr5wi86IIiKf3SVsDcoClzeEwATRg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790265298;
	bh=WxRwkjeergipzjy0uMRZTXDUDSUf8XVConGIHIBupxg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9oiPPyrng/U/4NfHOL4/D7w4W/ei1aZX6pZM+Tl10gUuqtcYGD8EMdokCKogDF8V6
	 PeoymydSpoknBYqeq/nPAThj8HS6LhWlJh93Lj8QQcDyMCllDdodH3pn0clu0jxJ+D
	 /+zVcmBopS2epKQn0xZsKRXbhHe0iHIQ9wM4feD4WZIvaRmYB1IccXAG7RmXr3oPKQ
	 kzZyFrRfyNmaDu71NEiCATFDQUl915r6jN2LoX2poGLUH8CHjRcZhrDWnQeiGpUBZp
	 pNya6KZpoQzP9P5Y0b8BqnyFeEaGcoyOnFOiwhLI64lM9Gj8bDYRzUPHiHmKy61RYW
	 ME0ciYExnmzNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8178F60824;
	Thu, 24 Sep 2026 15:54:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 779323B7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 15:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 676AC40CCD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 15:54:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WnnKuQqKGhYS for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 15:54:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7CE6D40B52
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790265296;
 b=moZKVCKlwfgROXzp+W+CyzQkguocNMIJgd+jLFYnl6OcXXZiK3gsrFgVQ3mp7+Y8fkea
 Y6DTFW5svFURtb+a0ZRFeK+0lxQ0lqdTrcC+DkDhw9T6EDY29T+mXWk4O2lWz1W9L6up6
 BGKJTLYQN8TLONBfAxP9Fni+whks6eb5uJ1jc0tHap93xZLN1l8+FwnVqIKn4epD1Yunx
 OG62t0D1kAOTvF/o7+mZauzXn0cv+evRyPxa9OdX53J4UXu+5KlGJ1p7lTlqbbDPawTD5
 ZhQw8k4BmbNvyHeSJPeNLjCPnr1mFoeHiR3LrsPGTSF5aomfBM2FciEDEV5DsSh3Skw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790265296;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=WxRwkjeergipzjy0uMRZTXDUDSUf8XVConGIHIBupxg=;
 b=sGgUnyM1vlmY2AiGbl5eAfxdtprTBxV6wS5Fj95q+I1vAeVuZ8xyoouIkH+G+A8A96Ye
 sBjlLAmptudCAuSG+PvNoY/eWKMjk7Mu8LWGIOsY2SZyxAbkwJZmG1RWjeVQV7jRE0gmK
 MhOq4wejpVlRdPeRJQEmzMNm/zfnJ+Pi7Rd1LFJw3HS/kgZXG0DLSsoIefq3sFwKeAxsp
 X9MyEaQ/GqVojHUI+XTW7DPVE9d5s24cFbkeD/oP+vxz7winw8ZY0iyQmkKUoZCsiXvpD
 dSpMm91TKE9TDXLS5GnuAjn8PPB+Ou31dnsKUkteI2kwf94vWqzVAlU2lqRPY79sq5g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NhoWW0jq; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=NhoWW0jq
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7CE6D40B52
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 15:54:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 834B842434;
 Thu, 24 Sep 2026 15:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F2E1F000FF;
 Thu, 24 Sep 2026 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790265295;
 bh=WxRwkjeergipzjy0uMRZTXDUDSUf8XVConGIHIBupxg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=NhoWW0jqpcicBVv7R3YtiKTCUY39VGoip6bAu1u9LFpXQ+i9ONXROPSF8AOrpvsBN
 IJ+e/ZXYgVIV/lStApAJ5MMYdRjGZ+JO2FMlKwqz7C/sZgYXMhhDbxER+yUemzZ1b3
 0efAot6jZUrQWsEiyq4t3bWP37QMzXgD/JC9kt+Wa0MUF64R4tTot2L9NwvuVku84M
 h30T07LQ5NkGVAGbYD1kQCuiAXNPEgJD/d7iBBLcXkxq3H4L2RqW1IlRcGcgOboyDI
 rvKAIFzyl7f0JmCtbOdAgL/EbK0kKTy4dSgaY6YcIOCJtzaj7ODb2iYZAZAnwXhO/V
 ozX0HRd1x8lng==
Subject: Re: [PATCH net v2] net: e1000: fix warning in iounmap on probe failure
From: netdev-bot+sashiko@kernel.org
To: nsvatoslav515@gmail.com
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, ffainelli@freebox.fr, auke-jan.h.kok@intel.com,
 jgarzik@redhat.com, joe@perches.com, aleksandr.loktionov@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Date: Thu, 24 Sep 2026 15:54:54 +0000
Message-ID: <179026529412.2160803.2090347947027060894@kernel.org>
In-Reply-To: <20260922155238.67445-1-nsvatoslav515@gmail.com>
References: <20260922155238.67445-1-nsvatoslav515@gmail.com>
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

- [Medium] Commit message misdescribes the defect and half of the added
  code is dead.
- [Low] The submission carries `Reported-by:
  syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com` but the next…

--

net: e1000: fix warning in iounmap on probe failure

This adds NULL checks before the two iounmap() calls in the e1000_probe()
error unwind path, for hw->ce4100_gbe_mdio_base_virt and hw->hw_addr, in
response to a syzbot report of a WARN from iounmap().

> During a probe failure, the e1000 driver error handling path calls
> iounmap() on hw->ce4100_gbe_mdio_base_virt and hw->hw_addr without
> checking if they were previously mapped. This triggers a kernel warning
> (WARN) rather than a fatal crash when passed an uninitialized pointer.

[Severity: Medium]
Is the hw->hw_addr half of this description accurate?  hw->hw_addr has a
single assignment in the whole driver, in e1000_probe():

	err = -EIO;
	hw->hw_addr = pci_ioremap_bar(pdev, BAR_0);
	if (!hw->hw_addr)
		goto err_ioremap;

The err_ioremap label sits below the iounmap block being patched, and
nothing ever resets hw->hw_addr to NULL.  Every goto that lands in the
err_sw_init / err_dma / err_mdio_ioremap region (e1000_init_hw_struct()
failure, dma_set_mask_and_coherent() failure, e1000_sw_init() failure,
the ce4100 ioremap() failure) happens after hw_addr was successfully
mapped.  So can the new if (hw->hw_addr) test ever be false?

The pointer that can legitimately be NULL there is
hw->ce4100_gbe_mdio_base_virt, which is only mapped for one MAC type:

	if (hw->mac_type == e1000_ce4100) {
		hw->ce4100_gbe_mdio_base_virt =
					ioremap(pci_resource_start(pdev, BAR_1),
						pci_resource_len(pdev, BAR_1));

		if (!hw->ce4100_gbe_mdio_base_virt)
			goto err_mdio_ioremap;
	}

and x86's iounmap() does:

	if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
		return;

which looks like the warning syzbot hit.

Also, the pointer is not uninitialized: the adapter is zeroed by
alloc_etherdev(), so ce4100_gbe_mdio_base_virt is a well defined NULL.
Could the commit message be reworded to say that, and could the second
Fixes: tag (1dc329180fe22 "e1000: Use hw, er32, and ew32") be dropped
since the hw_addr case does not appear to be reachable?

One more thought on form: e1000_remove() already guards the same two
pointers the other way around:

	if (hw->mac_type == e1000_ce4100)
		iounmap(hw->ce4100_gbe_mdio_base_virt);
	iounmap(hw->hw_addr);

Would matching that idiom here keep the two paths consistent?

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
>  err_ioremap:
>  	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
>  	free_netdev(netdev);

On the tag block:

> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Fixes: 13acde8fffc0a ("e1000: cleanup CE4100 MDIO registers access")

[Severity: Low]
Could a Closes: or Link: line with the syzkaller dashboard URL be added
immediately after the Reported-by: line?  scripts/checkpatch.pl checks
for this:

	# check if Reported-by: is followed by a Closes: tag
			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {

This matters here because the body defers all reproduction evidence to
the dashboard:

> This issue was found by Syzbot. The exact kernel configuration (.config)
> and the C reproducer used to trigger this warning are available on the
> Syzbot dashboard.

Without the URL there is no way to check which configuration reaches the
e1000_probe() error path with hw->ce4100_gbe_mdio_base_virt == NULL.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922155238.67445-1-nsvatoslav515%40gmail.com
