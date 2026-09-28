Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176E7C9833F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 10:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD3946067F;
	Mon, 28 Sep 2026 10:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wa0BrQWTQfzm; Mon, 28 Sep 2026 10:10:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B540360641
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590221;
	b=RYTZERnGSDzYlPruWiNhxumS3FZIpCf13lr/4NsslZkCWU63vV2l3dRiskmdfbdQ2fhz
	 FBpSIqz0PY4Sa6FtF5cajAbnXUYONcrx2VT25rmr/z5UoIhKb94bEbg/n9TQNP0tsbibi
	 dXboYd/5xnYHwTJ7pzyOelfR0yr3pszV/cyUBij+hVC+ur7O4VuOgE8j4tf2fIzgsvsqi
	 +1J/R4fO9PG/V3swEpFllpDQrjH5RHJqv0xsfWXxQ1TfDV6IW1OkzVPrDs8isrW9uanuy
	 +823pRn3ho6vPd1laVU5ELnDWUwbi35bWkzfLYaAWjFOIk28xOlXGo4KiuMwSCty0fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590221;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9MntvWW9bEeKi0i0MyUEHXEi1fIu9h3nvRSRBG6xKOE=;
	b=RjqOjzLe269VoE8e+xy9DNGkFt8uAynkYTppFlDerNj5kpmnYZH04qFOw/O/4RNMd7eX
	 hQIYNecEQqB/ydIdKHfjdM8u8O+z4rKzrsca0PBMJdROwd0mRGKyVugkMIkGd4ZCDTOs3
	 x2DNZvUQW8jwdNfcjpz8B7AXBDptu5tIM3sQt4/CeMeV1b0UMR+uMutIssUKI4sQKvGGT
	 rz0qlTUcKSZEvXcW2omu87vbyISHGiAaByvLWt5SX0xSUvVDgLn/tdtq44yzh5sbbNnw4
	 TBmOP+1Wde4u96dpw+mAc/C58w2CTuMaDjrQp2DOeSsFyN5IElwBsl6bTsTR/aPIT3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlX7tEQ6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790590221;
	bh=9MntvWW9bEeKi0i0MyUEHXEi1fIu9h3nvRSRBG6xKOE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G0aUmZWQg4G7xpBbZewrWXCqRcHAWMvoeJLkol4UEyzmxiorNA8S4DWQosipWSqMI
	 AxcSW+sV7vde1l0JW4bhiFU9boNORUxKeBsSzpoH8SVlU5oHJRHHzt9DBWCCDtcB8d
	 w81i6kmd64iA4gUYi1QSEkC6O0iuGYyHFUxVkx5HKY36/ZT5jihJhcmlfwQLdHj3yd
	 szPWI//ztXNL2dNEvgkX2l/1EQIP7ZzpJoDY1ZqDUaofdV2O/gUEQAVaDgNIeVl6MS
	 EExI/l2/LNkrajDaGmSNRg8Za35VrTMhh8GCUakjDzLfeim+CS7PCbHb6LAAPciTHl
	 rFWCoacwescLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B540360641;
	Mon, 28 Sep 2026 10:10:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F4A9361
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 10:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 210FA60641
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 10:10:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nYCs2zDfsGWK for <intel-wired-lan@lists.osuosl.org>;
 Mon, 28 Sep 2026 10:10:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F2B7F6067E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590219;
 b=ZpmAO2jwaZatst3siMoZ9f+kRXT2ovH0/gy7SLGQBjAMv2/MkHd5s4PlyPgzR8iEAMSD
 +XyOHuxWxyKLRZLh6ZZekbWqA9HlnWuHnK6u/bshkIyg24Us0gPu262rILxdLSW6au7D1
 tcLCKeN/EppGYTJ0RrLouTIdJILcjknPboSI8i51UUfnzFX+gPQjKtCHh0/CyOUd3V91K
 dQuwrrwe52I84x1yQ9ZIruTALCeRYOccZZ1iytFVdlzWjjjFk1/SmBD9/NUOPUhJ3VmD3
 PE/Fgf5Ue7Okl3PalpOjZvp9wZMwilMdxX3RrHBhK0c+ukWJIVd9rLZBykNypD1G5Xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590219;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=9MntvWW9bEeKi0i0MyUEHXEi1fIu9h3nvRSRBG6xKOE=;
 b=NDX0DWfVDlwRc3Knn1rQsByO1g6kzsNbCbQO35jiSXCBC3gKGVuPEzpZy9s5r0SCqUb+
 QRP/L5f2NZBwRoD19Ub5Xm21J4RWklVgZzuPHf6udfUZiwK9BYdTM6OAg7AM5BAcut1Px
 7Mm/haUE0WitCYhGoXzswEf9N1xwUMfEl4LgYv7Aj5Lk5vRRGFxH4ZkdoMwBXkf4opb65
 4rITppi63mXrXmXdNBLCTKIMz8UEiuHOfddmViqGkfzCCgFaXNOpR/wxbexWclU0nyOft
 2sZhYtcnTFjb4yJTxzmxApXsfBZfzfRCpz4/sYbaeuCTB66wqUyG6dCtyEkrEIUR7PQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YlX7tEQ6; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=YlX7tEQ6
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2B7F6067E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 28 Sep 2026 10:10:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E80F60052;
 Mon, 28 Sep 2026 10:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F851F000FF;
 Mon, 28 Sep 2026 10:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790590216;
 bh=9MntvWW9bEeKi0i0MyUEHXEi1fIu9h3nvRSRBG6xKOE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=YlX7tEQ6DPjiU6Ou1ycBzSHAUWiI/6t+uxGq0KekQoUIt5bNPFcisFea6QqI3p6/8
 bP6/W+oMxqVgPWd/ulgmWlnAQJx5e9OhAGHA2lrNQd8hqVfkc7+v8K90CtbckqWVEf
 k97YUxnACPiWYmSpm5+qHykloi0/zBEBXUreV7tGbw7+3KutLComTtSQql0H9SF3ob
 mLUSfB0gm0LCp42ZifW3AtuwX0OTJWbD/TTuV0wNsziouWFwBuTCuFZi4hs/kP587r
 uBE/NqHWv/0vJlrKK8exe9jngIKZKA8NjWzkbpWQdbWJslLd+dLpfzasNLn1g1UycF
 OwrhFbWMq/74w==
Subject: Re: [PATCH net v3] net: e1000: fix warning in iounmap on probe failure
From: netdev-bot+sashiko@kernel.org
To: nsvatoslav515@gmail.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
 aleksandr.loktionov@intel.com, stable@vger.kernel.org
Date: Mon, 28 Sep 2026 10:10:15 +0000
Message-ID: <179059021568.3145.6865816311046573732@kernel.org>
In-Reply-To: <20260924095152.3069-1-nsvatoslav515@gmail.com>
References: <20260924095152.3069-1-nsvatoslav515@gmail.com>
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

- [Medium] The commit message and v3 changelog describe a different fix
  from the diff that was submitted.
- [Low] The new `if (hw->hw_addr)` check before `iounmap(hw->hw_addr)` in
  e1000_probe() (drivers/net/ethernet/intel/e1000/e1000_main.c:1232) is…
- [Low] The subject quoted in the Fixes tag is wrong.

--

net: e1000: fix warning in iounmap on probe failure

This patch changes the iounmap() calls in the e1000_probe() error unwind
so that a NULL hw->ce4100_gbe_mdio_base_virt is never passed to
iounmap(). On non-CE4100 hardware that pointer stays NULL, and on x86 a
NULL argument to iounmap() triggers a WARN_ON_ONCE.

Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b

> Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY registers")

[Severity: Low]
The subject quoted here doesn't match the commit it points to. The title
of 13acde8fffc0af is:

  e1000: cleanup CE4100 MDIO registers access

The SHA itself looks right. That commit added the unconditional
iounmap(hw->ce4100_gbe_mdio_base_virt) to the probe error path.

Could the tag use the real subject and the usual 12 character abbreviated
SHA?

> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index d7f5c6f16142..156903089fa6 100644
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

[Severity: Medium]
Is the commit message describing this version of the code? The message
says:

    Fix this by conditionally unmapping the CE4100 MDIO base only if the
    mac_type is e1000_ce4100, matching the exact logic used in e1000_remove().
    The hw->hw_addr iounmap() remains unconditional since it is guaranteed to
    be valid for all error paths reaching the err_sw_init label.

The v3 changelog says:

  - Switched from pointer null-checks to checking hw->mac_type == e1000_ce4100
  - Removed redundant check for hw->hw_addr since it cannot be NULL here

The diff has no mac_type check, and iounmap(hw->hw_addr) is still behind
a NULL check. That looks like the v2 approach.

Was the wrong diff sent with the v3 message, or is the message out of
date? The Reviewed-by may also have been given for a different version.

The pointer check in the diff looks like the better choice. A mac_type
check would still reach iounmap(NULL) when the CE4100 ioremap fails in
e1000_probe():

	if (hw->mac_type == e1000_ce4100) {
		hw->ce4100_gbe_mdio_base_virt =
					ioremap(pci_resource_start(pdev, BAR_1),
						pci_resource_len(pdev, BAR_1));

		if (!hw->ce4100_gbe_mdio_base_virt)
			goto err_mdio_ioremap;
	}

err_mdio_ioremap frees the tx and rx rings, then falls through to
err_sw_init. On that path mac_type is e1000_ce4100 but the MDIO pointer
is NULL. A mac_type check would therefore still hit
WARN_ON_ONCE(!is_ioremap_addr(addr)) in the x86 iounmap().

Could the commit message and changelog be updated to describe the NULL
pointer check, instead of changing the code to match the message?

> +	if (hw->hw_addr)
> +		iounmap(hw->hw_addr);

[Severity: Low]
Can hw->hw_addr ever be NULL here? It is mapped earlier in e1000_probe():

	hw->hw_addr = pci_ioremap_bar(pdev, BAR_0);
	if (!hw->hw_addr)
		goto err_ioremap;

The err_ioremap label comes after this block. Every other path into
err_sw_init runs after the mapping has succeeded, so the check is always
true.

The commit message says the hw_addr iounmap() "remains unconditional",
and the v3 changelog says this check was removed. Should it be dropped?

>  err_ioremap:
>  	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
>  	free_netdev(netdev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924095152.3069-1-nsvatoslav515%40gmail.com
