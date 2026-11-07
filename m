Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47958606D804
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=1HELVWyO;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjLVTBZa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1457C60757;
	Sat,  7 Nov 2026 12:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZhRX97pNuKgk; Sat,  7 Nov 2026 12:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B666360746
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055578;
	b=P5qDN+ZRihiOoo1JnngBQUCGWDOW9AHuNXDo8oX1RThx3mIQTRvtXj5hG0HGiAxHvIzX
	 ro1l0eZTlBhHmXKljKWvtxCfJonDFmQHbATv3rvR44617jkuVeQJ/jQ/Sqg7T2WnjH/Rg
	 QuWKR8f2UhLL1AjWCPuwLhtfaH5dFBzQZgkc/Z/e369YGx+8bpCb1fteXhrKzRzmwai0h
	 RyaEJTVZdXICfe5BftHCZDqPrA7yqpO+WUGJCpFIySFEqxnudA1a3uErUyzHaIcrIn37q
	 eH9q+AGLb3Q/icQZ4nCXHPEVYRgY88/MLZGRlvtgmqA26sy7Mv++42lFobPmnskSzzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055578;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/RiPgyoXuembimyDq6WnhbjkgPIJFpoffN9+ARbON4Q=;
	b=j9Bnc1qWLACl5MuOr9Jx2slgDAQjDhoTGJLTyh4EVYizGunlwmcDY7nFujEO5N6xmQwl
	 iaf34Yny61OB1IMMjzxfu5jgD1s7aTdNSzPkHXnizsiNQrJQOCEK2B9NPfxcy92JjxjKO
	 /eyhBuLHNZDAroN1OJsJMeewTbJkcxT0xgBiaE6wuYN6RTUxjzm0SuG5FRwLZo9moYhUg
	 Mvv/4+UH9nA9TuYym2gg5Gj/4zdWKgrHOU4CGRV3QR7xlewo57HXj+FiYtMSCN69yzybI
	 hWB8WVKKIR2YvHX8s8sufL2Cdj7JkRwJ0WQSzVbyymslMgvOaWhOZ6hZ8GuZUV1UTCw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794055578;
	bh=/RiPgyoXuembimyDq6WnhbjkgPIJFpoffN9+ARbON4Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1HELVWyOkB2BlLL7SV9G+U5J3zZ7I6umY4NZwkIw3btCcgIcHwL84G6fPTZWl+lHF
	 /Zrbcs1vzA3f8IZ9NQtBrulpv8anEkhV9CwJcAO1+j9rq8DCx4p3Ioe/2eViFFSTP/
	 I4eOtD+0pEGfG0AYY2ywJOd5lHlTY+1PjiokZQpP7M5sF9wyd2jjVuDWQnhUxsaOLL
	 KMzjr2kvucywf82Er8BStPFOuI/NMq0J2vdkW7boR198kVz8eTnGMBcRa/+0T3/NsG
	 15e/Q/xIh07jgb21rJRKXZsMboeUZSh0j9SONzpcJx30jOUZIuO+1OPLcD/L84ALhC
	 EnHWpa+2qCC+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B666360746;
	Sat,  7 Nov 2026 12:46:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9ABFB34D
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77CBE812CF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T2W-_cPruLfK for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 12:46:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 43DC8812CB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kjLVTBZa
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43DC8812CB
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:46:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B5F360145;
 Sat,  7 Nov 2026 12:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286251F0089F;
 Sat,  7 Nov 2026 12:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794055573;
 bh=/RiPgyoXuembimyDq6WnhbjkgPIJFpoffN9+ARbON4Q=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=kjLVTBZanYT45cNamz8KZqx4UF1JUJoQOjZ2AZ1BlKr3QRZMTupufknRY5QkMZ+lX
 UnTFpTddxV3lyO6+WRTw1eIiWzxH9XvUQKw5Cv1BKJRchgtVXQsraaAnYgsaifghaN
 qoJUORi35W5qKZLS21RYDRDTxtsyEHGDUo9hyLmwNRR4Ei6ofquYj2yZOcPqH+8gKr
 Afh7CPIoU3gAFJ4B56UABiiiJC+WrPYDVBUFwGtwfyeOuR8ISHuf11joJ8TgGOfaes
 XFllM0JZ9GK/Tjhg7OPS1DHdKuauN4Yi3/mSxRCU8Tfv75sLGJeAPe/GFakbG6BOv4
 joX4XEJegZ7wQ==
Subject: Re: [PATCH] igb: disable the PCI device when resume fails
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 07 Nov 2026 12:46:12 +0000
Message-ID: <179405557264.994134.1212641106918033235@kernel.org>
In-Reply-To: <20261103102849.1340413-1-vulab@iscas.ac.cn>
References: <20261103102849.1340413-1-vulab@iscas.ac.cn>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds pci_disable_device() calls that unbalance the PCI
  enable count.
- [High] igb: missing interrupt and hw control cleanup in __igb_resume()

--

igb: disable the PCI device when resume fails

This patch adds pci_disable_device() calls to __igb_resume() for the cases
where igb_init_interrupt_scheme() or __igb_open() fails after
pci_enable_device_mem() has succeeded. The aim is to release the PCI
enable reference that resume takes when the resume fails.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index d4a897a8c82c6..853bc99a10113 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -9621,6 +9621,7 @@ static int __igb_resume(struct device *dev, bool rpm)
>  
>  	if (igb_init_interrupt_scheme(adapter, true)) {
>  		dev_err(&pdev->dev, "Unable to allocate memory for queues\n");
> +		pci_disable_device(pdev);
>  		return -ENOMEM;
>  	}
>  
> @@ -9647,6 +9648,9 @@ static int __igb_resume(struct device *dev, bool rpm)
>  	if (!rpm)
>  		rtnl_unlock();
>  
> +	if (err)
> +		pci_disable_device(pdev);
> +
>  	return err;
>  }

[Severity: High]
When __igb_open() fails here, the new error path disables the PCI
device but leaves the rest of what __igb_resume() set up in place.

Earlier in this function, igb_init_interrupt_scheme(adapter, true)
has enabled MSI-X or MSI on pdev. It has also allocated
adapter->q_vector[] and registered their NAPI instances on
netdev->napi_list. igb_get_hw_control() has then set
E1000_CTRL_EXT_DRV_LOAD.

None of the __igb_open() error paths call
igb_clear_interrupt_scheme(). If __igb_open() fails at err_setup_tx
or err_setup_rx, it also skips igb_release_hw_control(). That happens
when ring allocation fails in igb_setup_all_tx_resources() or
igb_setup_all_rx_resources().

So after this hunk the device is disabled while:

  - MSI-X or MSI is still enabled on pdev
  - the q_vectors and their NAPI instances are still allocated
  - firmware still sees DRV_LOAD and believes the driver owns the
    hardware

The runtime PM case is worse. When igb_runtime_resume() returns an
error, rpm_resume() leaves the device in RPM_SUSPENDED. The next
runtime resume then runs __igb_resume() and
igb_init_interrupt_scheme() again on this uncleaned state:

  - If MSI-X was in use, pdev->msix_enabled is still set and
    __pci_enable_msix_range() hits WARN_ON_ONCE(dev->msix_enabled).
    igb then falls back to single vector MSI. That overwrites
    adapter->num_q_vectors with 1 and leaks adapter->q_vector[1]
    onwards.
  - If MSI was in use, the same thing happens through
    WARN_ON_ONCE(dev->msi_enabled) in __pci_enable_msi_range().
  - igb_alloc_q_vector() then finds the existing q_vector[0] and
    memsets it. It calls netif_napi_add_config() on a napi_struct
    that is still linked on netdev->napi_list, which corrupts that
    list.

If this patch is meant to unwind a failed resume, shouldn't this path
also undo igb_init_interrupt_scheme() and igb_get_hw_control()? For
example, igb_clear_interrupt_scheme() and igb_release_hw_control()
could run before the device is disabled.

__igb_shutdown() and igb_remove() already call both helpers, along
with pci_disable_device(). How do you intend the resume error unwind
to stay consistent with those teardown paths?

[Severity: High]
Can these new calls lead to a double pci_disable_device()?

The commit message says:

  The PCI enable count stays elevated and the device remains enabled
  even though the driver failed to resume it.

A failed resume doesn't unbind the driver. igb already drops its enable
reference unconditionally on every teardown path:

drivers/net/ethernet/intel/igb/igb_main.c:igb_remove() {
    ...
	free_netdev(netdev);

	pci_disable_device(pdev);
}

drivers/net/ethernet/intel/igb/igb_main.c:__igb_shutdown() {
    ...
	igb_release_hw_control(adapter);

	pci_disable_device(pdev);
    ...
}

igb_io_error_detected() also calls pci_disable_device() before it
requests a slot reset. __igb_shutdown() is reached from igb_suspend(),
igb_runtime_suspend() and igb_shutdown().

Without this patch the count looks balanced:

  probe: 1
  suspend: 0
  resume: 1
  failed resume: still 1
  remove or next suspend: 0

With this patch, a failed resume drops enable_cnt to 0 while the driver
stays bound. Any of the following then calls pci_disable_device() a
second time:

  - rmmod or unbind
  - the next system or runtime suspend
  - reboot or poweroff
  - AER error_detected

pci_device_remove() calls drv->remove() even when pm_runtime_get_sync()
fails, so unbind can also hit this after a failed runtime resume.

In drivers/pci/pci.c:

pci_disable_device() {
	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
		      "disabling already-disabled device");

	if (atomic_dec_return(&dev->enable_cnt) != 0)
		return;
    ...
}

That second call warns, which panics the host when panic_on_warn is set,
and leaves enable_cnt at -1.

>From then on, the count stays wrong:

  - The next pci_enable_device_mem() in __igb_resume() moves the count
    from -1 to 0. It still enables the device, and __igb_resume() turns
    on bus mastering, but pci_is_enabled() now reports false.
  - Each later pci_disable_device() moves the count from 0 to -1 and
    returns early. do_pci_disable_device() never runs, so
    PCI_COMMAND_MASTER is no longer cleared on suspend or unbind.

The existing teardown paths already release this reference. Should the
new pci_disable_device() calls be dropped? If they stay, the other
disable sites would need driver state to make them conditional.

Because of the Cc: stable tag, this change would also be backported to
stable trees.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103102849.1340413-1-vulab%40iscas.ac.cn
