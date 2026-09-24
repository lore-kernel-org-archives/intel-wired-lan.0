Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE761C9830E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 16:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71F9A60B20;
	Thu, 24 Sep 2026 16:51:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WvL6xV8C5CL9; Thu, 24 Sep 2026 16:51:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5C94E60B3F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790268718;
	b=SNb/qLFN3W4N8XNxETpTLcAD+QUpWDKRaSqxxYEC0QuzYHcYPnaEfTx+sPi2GAVtWsmd
	 o3YyBfQOtjJEbCrU5lH8TKV/mSt4zG480lHoQIFjYdi7kHIJ1td3P39l1nbFCdOEpYeDX
	 iN/xbw+ZxPeH8XMwXqLSzX+UQd6a6BqH87EQfWZaImI0/mTKdWO8R2yiPj+rTuOsvRM/M
	 CC+6Jp1VVA7kZuFo2YXsuRvusLUx/EkqtEtf8sSg7h0xq0RmbJQwZ6lkt/co1JOKA5qF2
	 Ev3fpmIPnsMCUE+5ciZ6J3sp55thJJ0K8cKJR4jVBbRAiNEvqBhG5iy4Jrtl+yn/HGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790268718;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eSSbZnuCtl8KDycVQpA/SGQENb09ic1AWqUQDE6gDSA=;
	b=myc+JFRVWqpn1wU/ugiqA7gKJlrbaG47+TJ8UYc8dBHljpAihvpj7v/H2cc/qhz29uPY
	 zqtJLDzt+v3A5JVV7HLLiEsoScjfcwcOyjOFkzuYZIgZ49OnrLj40NfU0gajpawYzMRFg
	 zFz2laki4JnCVH12P+Kdhr2Tmn41PkYkS8sBJyuH04LK/5ENhuXGpRWzeb0AgV6RvKFNV
	 LnBZIvCve1FSUoAlOuwJiMJo8sKXVJxuzX2mNoJceV3TYrihpQ4auEPJYNKd4rf3g63vR
	 AA40px2CXwDCltJKGq8FyKIxv0MH9aPrlQSJRFl7qLDXE3YrgQ2Z5iHG/i8NJAwvTHA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790268718;
	bh=eSSbZnuCtl8KDycVQpA/SGQENb09ic1AWqUQDE6gDSA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jnTVOLa/0yON3WmQGw3QezlOhskiVDC7i7++ouIVfKGeW/ekhCWvEazFjanGzDNuB
	 Lg+GnHo1BWqRD/MLA2ZOyHFhoh3cOyax+RsGyTAuMYfwqdq/C8Ohs4gJF2ZRGMAP7g
	 fMgJ3qJmBQASCriH9bzIuLXi2PUbAn+XA+mF1Ot5vlRE1sTA7Ca3AV30xMnuFWndOu
	 MbFEdaS54YwA0S0fxwYbeEbxQaQD03sAx/gsiC4zFjPNgc+vitHQrG8BfKTliRCsZ6
	 TCFJLmbUmdJOn7UU+r1aY2Gwz08JYRGye9R7C9prtmSkUvZr2YTmqjrWeVhPfZ5W+w
	 tah9LzzzUKysQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C94E60B3F;
	Thu, 24 Sep 2026 16:51:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BE0A7355
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 16:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A417140480
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 16:51:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bxeqWhPqiM08 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 16:51:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 57F6840042
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790268715;
 b=fewDbX8oXvaYPO0J8Nexzm6apnXYndE0M9vp33laGLELdRoFUckTDMx4U9wCoeCGYcM5
 2QPjPuQwZafyf+T8HzcHWZ5N91w/Ciqby+vWvc3+QKWRoMCON4NRYoJd2EJqkSL9RplJw
 GPXDJVb6CLT7ewZDWg0QS+vxQZgs0G+dB5ydeDT+Z1ub7QFOyoXycHbw702jkMkV0aVNd
 Z3Ck8kqFmAo85zquuUwC4AQHnmF9yHuqxBae4T4dN3dhWVCP2v6SawnUyVZMtAn5276ct
 X+OY+HLGNCs3qTTIViJ1CSHbkiN3ufk2b9vnSL6grnxWyHy88yuixKXmBxi9Trd1j3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790268715;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=eSSbZnuCtl8KDycVQpA/SGQENb09ic1AWqUQDE6gDSA=;
 b=Zg/7bVH1yc2PPFvAgYfFnhb6/4x392sIxrGmjqvrlEulUHa+5xsD00PjVIf93WKuFCMJ
 aX78rEZn/m22Qxe7Bn7MYhwANbOuKNAJ3YjQH2MDbjX+yJRB8u0YIjsDg+shCn98NZZQL
 lMKQPRYlu15EY9b2DHny7XOkezDuk+VjVnzuWMrrH7Nes7c88BtK+rB3OjYnWapIsjiju
 lpI3RNhNRBrGppnFhRgTVRwio3t26bE06kxLyymrzaRF5pkhasCZg7MYTFjmGsPr1tQot
 76AMd6B+m0ZTNMVW5cOsANrx27AxTOOCr51mQm9jLQX2gdGrc4r1NL27w/BuF+/C2Yg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="W+BQR6E/"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=W+BQR6E/
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57F6840042
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 16:51:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AAA6B601E4;
 Thu, 24 Sep 2026 16:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8C41F000FF;
 Thu, 24 Sep 2026 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790268713;
 bh=eSSbZnuCtl8KDycVQpA/SGQENb09ic1AWqUQDE6gDSA=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=W+BQR6E/ARkY77WyRvDCrbfBmdwmPiO5UNnTfMszL7stSF3MSUDw1HtBDuwdUWywk
 ZGYp6+BZBGHcGdXm145sBvqRnJ85ehyTl2OxgGlLbxUBGiaEswePb0yCrlyXVZIEG5
 DfTnShquyK+cdp0uBLKeX4WWnioArkHxhiNSFUFwk8wOPg8DBuvkjfEHbwzhjtrYZ7
 FTyvGTZxORK/NFEjRzTHejx6PtiRUZkEbGp8Lp/yOJgS+RCWWCXEjMuh9h3TreGZQR
 zOXVhEiHv23AWqLFUJLEOcgZS0FaQnqb5pL/CP1dOH8+/w0mi6p7Z92UuhdW8YZlWd
 ort8Ir02wrsTw==
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
Date: Thu, 24 Sep 2026 16:51:52 +0000
Message-ID: <179026871201.2160803.192841426910444830@kernel.org>
In-Reply-To: <20260922155139.67364-1-nsvatoslav515@gmail.com>
References: <20260922155139.67364-1-nsvatoslav515@gmail.com>
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

- [Medium] Half of the patch is provably dead code and the commit message
  over-claims the defect.
- [Low] The commit carries `Reported-by:
  syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com` and asserts…

--

net: e1000: fix warning in iounmap on probe failure

This patch adds NULL checks before the two iounmap() calls in the
err_sw_init/err_dma error unwind path of e1000_probe(), so that a probe
failure does not pass a NULL pointer to iounmap().  It carries two Fixes:
tags and a syzbot Reported-by:.

No Link: tags were present in the commit header.

Two questions below, one on the commit message tags and one on the diff.

> net: e1000: fix warning in iounmap on probe failure
>
> During a probe failure, the e1000 driver error handling path calls
> iounmap() on hw->ce4100_gbe_mdio_base_virt and hw->hw_addr without
> checking if they were previously mapped. This triggers a kernel warning
> (WARN) rather than a fatal crash when passed an uninitialized pointer.
>
> This issue was found by Syzbot. The exact kernel configuration (.config)
> and the C reproducer used to trigger this warning are available on the
> Syzbot dashboard.
>
> Fix this by adding NULL checks before calling iounmap().
>
> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Fixes: 13acde8fffc0a ("e1000: cleanup CE4100 MDIO registers access")

[Severity: Low]
The Reported-by: line is followed directly by a Fixes: line, with no
Closes: or Link: URL pointing at the syzbot report.  Could that URL be
added?

Documentation/process/submitting-patches.rst asks for it:

    The tag should be followed by a Closes: tag pointing to the report,
    unless the report is not available on the web

and scripts/checkpatch.pl warns on this pattern:

    BAD_REPORTED_BY_LINK
    "Reported-by: should be immediately followed by Closes: or Link:
     with a URL to the report"

The commit message says the .config and the C reproducer "are available on
the Syzbot dashboard", but without the link there is no way to check which
error path syzbot actually reached, which is relevant to the question
below.

Also, the description of the value handed to iounmap() as an
"uninitialized pointer" does not look accurate: the adapter private area
comes from alloc_etherdev()/alloc_netdev_mqs(), which zero the allocation,
so hw->ce4100_gbe_mdio_base_virt is deterministically NULL rather than
garbage.  Could that wording be adjusted?

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

[Severity: Medium]
Can the new "if (hw->hw_addr)" test ever be false?

hw->hw_addr is assigned in exactly one place in the driver, in
e1000_probe():

	err = -EIO;
	hw->hw_addr = pci_ioremap_bar(pdev, BAR_0);
	if (!hw->hw_addr)
		goto err_ioremap;

The err_ioremap: label sits below the iounmap(hw->hw_addr) that is being
guarded here, so the only path that leaves hw_addr NULL skips this code
entirely.  Every other goto that lands on this label (err_sw_init,
err_dma, err_mdio_ioremap, err_eeprom, err_register) is reachable only
after pci_ioremap_bar() already returned a valid mapping.

If that reading is right, the hw_addr half of the change is dead code, and
the second tag

	Fixes: 1dc329180fe22 ("e1000: Use hw, er32, and ew32")

refers to a defect that is not present.  Should that tag be dropped, along
with the mention of hw->hw_addr in the commit message, so a stable
backport is not aimed at a path that cannot trigger?

The ce4100_gbe_mdio_base_virt half does look like a real fix, since that
mapping is only created for one MAC type:

	if (hw->mac_type == e1000_ce4100) {
		hw->ce4100_gbe_mdio_base_virt =
					ioremap(pci_resource_start(pdev, BAR_1),
						pci_resource_len(pdev, BAR_1));

so on every other device the field stays NULL while the unwind path still
calls iounmap() on it, and x86 iounmap() does:

	if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
		return;

Would it be clearer to describe only that case in the changelog?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922155139.67364-1-nsvatoslav515%40gmail.com
