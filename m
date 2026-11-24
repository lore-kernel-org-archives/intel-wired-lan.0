Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA984606A688
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8LEGkSxd;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aucOB2zf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 967C880A91;
	Tue, 24 Nov 2026 21:38:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nHle2TUIWKUV; Tue, 24 Nov 2026 21:38:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5534809B5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795556331;
	b=HtkxTWxtME0tw8mcfDZ9X2cvEE3za6LiyjBtR+XjfJ0P7c4GohakTXjv064USCneZoKO
	 c6yAb4haSN9JkjSNDZpSWq44u+WUGlN94x03B+RyFIEaEz/TiOK/H11IIKs3lwNgrVhnf
	 95/2Xthz2EAWhYe6HW+Ejvye7yDxkh6+DOZThw7K42jlbw+bGgva5VqRmRAcYWLZeYSQy
	 2jTVL05OQ/iypq60YdtamY0aFQMpjfr0B4XLchO/e8IcJ6zhx75dZoNdlsrsyT1fbwprW
	 zZtpFe6PmHLMBIFkNaz1DBw9hQe0apCmEK4lYR1FrS+YXlZaGIemDXc7F/+pWXTKQXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795556331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UDznTv7tvXw7e6fmTZhMJ4Cm4gT1kF7rLrwjGIShnwY=;
	b=sOP1dMcKmROUmkqicOiT1uptv08/mmL+dXwhmFTMInHE2/TsY2vpHeB1ur0WOK3DYrj1
	 shtCRyyKfLALR/otbNwA75cXpLR91nfYp/FcNhKqihh52C9QbFGAqmi+ojhMVpBBYtnSU
	 Jf3XFadiup/4/W+T0t6rGc/8BJSpYqz9r30HAVet0SczEqES1i/r1ZaBbaxLu0XrFuYLZ
	 vpJo/cAgM/BY2bvFzMmsOVL7PPAhTetZQtel3bYOhFUTZGdWD8lDC8kIfC8O1gwUN5dWg
	 rtGQmXQy+yzyk9IQM0dam4FMHgrcUhFpK8QfcKPcM7rgMKdtEy56ymT4zrLt06ptuGg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795556331;
	bh=UDznTv7tvXw7e6fmTZhMJ4Cm4gT1kF7rLrwjGIShnwY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8LEGkSxddInrrN/DKga8fNs7mhkKpIZ7wF70LuJKhhsU2lG3MoQoIBJ9N30ToR0Ze
	 L8bUzpaInLNBlhD66dSppTv7ShknKLKK/IhIbYWD626OS4ljz29Y/G+DOVMvagHIUy
	 rMNERrwDL5xSc+mSsPCmIuQXkUTv65njBHiz1YoY53xJ0kcMe8zUb/6tAk/iYZ2s1/
	 uaHmqZ+9yCEpe4h0mvx1Y+/hhbeaWmG4D1rEGF8Hgw9+aVxLirljAKJw9mtJV5UdVK
	 lqg26N2ddzCehtB3OxKuGQdmmzn3msPxT0yHcaY5rBDczQKXq1ZOZX54X9b1Ndk2rb
	 r3YhxdyliOQOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5534809B5;
	Tue, 24 Nov 2026 21:38:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBAE510B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 21:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD167405C4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 21:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EaoxIEce7Yoo for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 21:38:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD3EC40507
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aucOB2zf
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD3EC40507
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 21:38:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE62F40E07;
 Tue, 24 Nov 2026 21:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97231F0089E;
 Tue, 24 Nov 2026 21:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795556328;
 bh=UDznTv7tvXw7e6fmTZhMJ4Cm4gT1kF7rLrwjGIShnwY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=aucOB2zfnLBk8rLtyw/N5Epc20E2KqRxx+ZKX47RHV/9XWcFgAWwS8sD7BtrLr/8F
 HAZKdXCwENrM4q0q4cw2tDPw6nf/2MTzYo1eWPsJnKvMUMRIKrJ3x2wsrqzdppNHs7
 IqRWTY1IfX8UGVl2KSpmGYRRUoUmlznIuKexnSWhH967yb15jFrP+Q48UWL55kTIkC
 Q60imLaVhJdxKonCtFb1iPw3gFJ5Psw63EuSG9LTSAhP1n8D2pnQzgVbTbMUP48Mfq
 Ov3mj+Ja1ER1DBPvDe7zvqGj72+sKcQJx7Ksk1Z2EnEFp42LYPKhWkDC2RRISSX4oe
 eH+kKc9jkDzTw==
Subject: Re: [PATCH net v4 4/4] igb: only allow runtime PM if the device can
 wake up
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Tue, 24 Nov 2026 21:38:47 +0000
Message-ID: <179555632736.3135.1658046091917963917@kernel.org>
In-Reply-To: <20261120210134.133238-5-antonio@mandelbit.com>
References: <20261120210134.133238-5-antonio@mandelbit.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The runtime PM usage count can end up unbalanced, because the
  same decision is made twice.

--

igb: only allow runtime PM if the device can wake up

With this patch, igb_probe() drops the runtime PM reference taken by
local_pci_probe() only when pci_dev_run_wake() is true. Devices that
can't signal a wake-up from D3 are therefore never runtime suspended.
igb_remove() takes the reference back under the same condition.

Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 4617aba5759d2..36bd395e36dab 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3654,7 +3654,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
>  
> -	pm_runtime_put_noidle(&pdev->dev);
> +	/* A device that can't wake up wouldn't notice the link coming back
> +	 * while runtime suspended
> +	 */
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_put_noidle(&pdev->dev);
>  	return 0;
>  
>  err_register:
> @@ -3876,7 +3880,8 @@ static void igb_remove(struct pci_dev *pdev)
>  	struct igb_adapter *adapter = netdev_priv(netdev);
>  	struct e1000_hw *hw = &adapter->hw;
>  
> -	pm_runtime_get_noresume(&pdev->dev);
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_get_noresume(&pdev->dev);

[Severity: Medium]

Can the runtime PM usage count get out of balance here?

pci_dev_run_wake() runs once in igb_probe() and again in igb_remove(),
and the first result isn't stored. pci_device_remove() then always ends
with a put:

drivers/pci/pci-driver.c:pci_device_remove() {
    ...
	/* Undo the runtime PM settings in local_pci_probe() */
	pm_runtime_put_sync(dev);
    ...
}

The count only balances if both pci_dev_run_wake() calls return the
same value.

It looks like the result can change while the driver is bound.
pci_dev_run_wake() checks pci_pme_capable(dev, pci_target_state(dev,
true)). On ACPI-managed devices, acpi_pci_choose_state() caps the target
state using a flag that root can change through sysfs:

drivers/pci/pci-acpi.c:acpi_pci_choose_state() {
    ...
	if (pdev->no_d3cold || !pdev->d3cold_allowed)
		d_max = ACPI_STATE_D3_HOT;
	else
		d_max = ACPI_STATE_D3_COLD;
    ...
}

d3cold_allowed_store() writes pdev->d3cold_allowed, and nothing
serializes that write against probe or remove. On a device that can
raise PME from D3hot but not from D3cold, toggling the attribute flips
the result of pci_dev_run_wake().

A second case is a device not managed by the platform, for example an
igb NIC behind a Thunderbolt or USB4 dock. If it is surprise-removed
while runtime suspended, the result also seems to change.
pm_runtime_get_sync() in pci_device_remove() resumes the device, and
pci_power_up() does:

drivers/pci/pci.c:pci_power_up() {
    ...
	if (pci_dev_is_disconnected(dev)) {
		dev->current_state = PCI_D3cold;
		return -EIO;
	}
    ...
}

After that, pci_target_state() returns D3cold:

drivers/pci/pci.c:pci_target_state() {
    ...
	if (dev->current_state == PCI_D3cold)
		return PCI_D3cold;
    ...
}

So igb_remove() tests the PME-from-D3cold bit, while igb_probe() tested
the D3hot bit.

If the call returns false at probe and true at remove, igb_remove()
does an extra pm_runtime_get_noresume(). One usage count then leaks on
each bind/unbind cycle. The device can't runtime suspend again, even
after the driver is rebound.

If it returns true at probe and false at remove, the final
pm_runtime_put_sync() in pci_device_remove() underflows and logs
"Runtime PM usage count underflow!". With power/control set to on, the
extra put uses up the pm_runtime_forbid() reference instead, and a
later pm_runtime_allow() underflows.

Would it be safer to call pci_dev_run_wake() once in igb_probe(), store
the result (for example as a bool in struct igb_adapter), and test that
stored value in igb_remove()?

e1000e and r8169 call pci_dev_run_wake() again at remove in the same
way, so this pattern already exists in the tree. In igb, though, this
would be a new imbalance, added by a fix that is tagged for stable.

>  #ifdef CONFIG_IGB_HWMON
>  	igb_sysfs_exit(adapter);
>  #endif

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120210134.133238-1-antonio%40mandelbit.com
