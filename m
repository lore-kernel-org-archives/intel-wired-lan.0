Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB4606A31B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=DcGeTp+1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkOone0p
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80238403EB;
	Wed,  4 Nov 2026 10:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id coPbgA2zMHdh; Wed,  4 Nov 2026 10:29:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8B630404C0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793788142;
	b=RDpf/jDH84BXvJtmo2Eic7/N/v8ecjDb2Nws/svRZQKW+UMzUfWyxnh9AWzf5u+yyJmw
	 fv+I2uaYPvsCppDNqgYj9984Bje+6jG0/6uhBZjWMug6hOBlUFaWmKuxNTtmmd0gCea3s
	 GPEKgcUJ+6lrfI3S428dYMJrAGeVcn71UnKRs4x+xWh07Ug4EFyikHDBDKnXkE4XwV+5u
	 Rd9pzCHunVo0NjHo9r+Efvd56blBmUDn2yzmWKa8x9+Sao7P7jU6kdpbOqvmL24fO9fJn
	 nLrVxs0sG/Quv3w2KD25MaKCVnoJGnZG9AgHpUX30gcQxC0yo+Tk3S+pS5tcaR7EPIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793788142;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=tTCm4LxUn2+8l1DzMSpT8v/188PvAGrt5pMorNbRdr4=;
	b=YR557eOrsW1U+lA/fsf7Qv5gZl0gg6G6dchmaoKJPkL5/yCow4mllwizSAS45/3HOYJm
	 K8V/WTuubsqhyz3Ybin9DMX75c79h3TbP0IU4O5xAzQL2xO0+P+m41HSIwwrT/6agZ0En
	 SJJWkcCkz9BRarzurnJSLHj7lr6wyQ25z9qHXVw3AHciLTEiO2yf+JRUoyOUHymy3v3s5
	 ACKq3P9xDquom+ukppBxopEfsUg8O+hhyT2wxE0A9DgPd9ltkp5m0woKOpg3t/DGwprVc
	 UwpuPjcDdy7tG+Gj4mL6tpDeNj6SxkYSxK6GjVK0lKKveEZOeiAkrhJNt/SYFxfE+eg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793788142;
	bh=tTCm4LxUn2+8l1DzMSpT8v/188PvAGrt5pMorNbRdr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DcGeTp+1FaVKMEygoFezhBcInwR/w8dznoPBwugLe9rT8Qimu1HUcyT/Iala9CMz+
	 d+5SxLrFQMK/6IDvkfLHMDoLooKS/fVa2ahgWb0pEyGtBwRD+ux/5WatzY7UqjxHcm
	 /GINynANQDP9tfzEAaKXG2+KF88es+PJ9HAx4FYXuL+ZlBrEUm1hfgZ/OYj+DZ0KTN
	 I72wlrPb0C8HxWUhYSoKUs0TpqmFYxqFdsdGL5uXTAcoylhrSZUXHC/zvMMHmqeHmc
	 F1LMKC/iOvCWPGKxXUOwCUtjqFSAiSND8NknVkXkiu+eVG8aNsBVfpeSaQEda66SHK
	 dUg56uiS6nvFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B630404C0;
	Wed,  4 Nov 2026 10:29:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B3BD411
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 10:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28B004008B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 10:29:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bAHLwS5NudG7 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 10:29:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3AF3D4004D
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793788140;
 b=eUlHPjB0+36MFl+LVHyIKsNe+wMmA8UAcKWo6A2+tIpGrh2oaWQClSD4haO/GEUdgcuh
 PH2KSlyikvbWLoZdNGvi8NvTZfur99NYg3rlbyXJ0REwWcySeZs5Wa6RXmcaGUjZ0/cT4
 gEY4tUmRmgp9IGsmujXzn1KNxAK5x3VYPwmJgy3RccbwjRHG36tMLa0NN9bzlvBxzYuFC
 HmPx8m6lK62Qh3P2l1TFo2MXO6/4tjeVbLYafLneADin0zJK7+gquVhNNzrf/xWLDqYse
 nqqVAzkcD4YeV99fQr8tyf2lPF87xBAIpyC/PAdxi2vvHtbz9j3E7Gs4A4U1QDgzSCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793788140;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=tTCm4LxUn2+8l1DzMSpT8v/188PvAGrt5pMorNbRdr4=;
 b=dRkuejEv/ZxeGHtx9OENxN4xlBGpHeqNyEbnANucTOQMYDCyHwgKN48oEqSE+TygF31G
 sY1Ly4VPlm7i7KlGy830Ud1JBJ3UxeAxO/7O78C7Z3MuBZ3iscw5d+dCQUth4BPpI/Fmx
 PIKZzR/Ta18we3q7AacpaHcRksTqmvEmz5Z+AUNPN3NWrCbpZqiolcgBKpkfKn/djutVO
 TaeL2T1po4EAkeTQKF2vdBjwbhluSaQNgu03Bt9jBEggIYPRgkNYZv8pQylNzRAbAjjA/
 bBC1myygRI54/c4x4m8bum4uIP2wkyyo35QnVlT+ViWjLn050xfBMf6JnF9iMd8b+Yg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NkOone0p; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=NkOone0p
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AF3D4004D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 10:28:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95FAF401CA;
 Wed,  4 Nov 2026 10:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA011F000C1;
 Wed,  4 Nov 2026 10:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793788139;
 bh=tTCm4LxUn2+8l1DzMSpT8v/188PvAGrt5pMorNbRdr4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NkOone0pO/DP+qcSK0hjywT/8LoWCQJc9uhh5bxC5G3JIgpaM6X3GDbF01dR+EYvS
 BsJaVgeC1jQK0s11igDVotwzwXkO8HuIVXobMeIEDNcy8jvkCnuaTCHpSGP8yF5Unz
 eqYaLSb1IQ3T+LAewlk3/qtpdD2oT8Zcxa+c4Iu2LKejtg/jULyyQxLQbdKtlJjZ8K
 mLnNVxljxbhM6441Q56VUee491O820DVkMiBk1p/B6DT4WO02DR6g7cUAPoBxDKrFr
 Bal+UcWv/po4QToAz+Lnf4cq0WGIIC9VygFJSGHtz7vLWCqieis69uyDpWryLAnZ4n
 l/K8bPQGxjcag==
Message-ID: <sashiko-outbox-197093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] igb: disable the PCI device when resume fails
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261103102849.1340413-1-vulab@iscas.ac.cn>
References: <20261103102849.1340413-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 10:28:58 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] igb: double pci_disable_device() after __igb_resume() failure
- [High] igb: missing interrupt and hw control cleanup in __igb_resume()
--

commit 7cf84b374723aebb6dc086448341821f57e54043
Author: Wentao Liang <vulab@iscas.ac.cn>

igb: disable the PCI device when resume fails

This commit calls pci_disable_device() in __igb_resume() when
igb_init_interrupt_scheme() or __igb_open() fails after
pci_enable_device_mem() has succeeded.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index d4a897a8c82c6..853bc99a10113 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -9621,6 +9621,7 @@ static int __igb_resume(struct device *dev, bool rp=
m)
> =20
>  	if (igb_init_interrupt_scheme(adapter, true)) {
>  		dev_err(&pdev->dev, "Unable to allocate memory for queues\n");
> +		pci_disable_device(pdev);

[Severity: High]
Can calling pci_disable_device(pdev) on failure in __igb_resume() lead to a
double disable and pdev->enable_cnt underflow later?

During suspend, __igb_shutdown() calls pci_disable_device(pdev), which drops
pdev->enable_cnt from 1 to 0. When __igb_resume() runs,
pci_enable_device_mem(pdev) increments pdev->enable_cnt back from 0 to 1.

If igb_init_interrupt_scheme() or __igb_open() fails, calling
pci_disable_device(pdev) here drops pdev->enable_cnt back to 0 while the
driver remains bound to the device.

Because igb does not track whether the PCI device is enabled, a subsequent
call to igb_remove(), __igb_shutdown() (via suspend or shutdown), or
igb_io_error_detected() will access MMIO registers on the disabled device a=
nd
unconditionally call pci_disable_device(pdev) again:

drivers/net/ethernet/intel/igb/igb_main.c:igb_remove() {
	...
	free_netdev(netdev);

	pci_disable_device(pdev);
}

drivers/net/ethernet/intel/igb/igb_main.c:__igb_shutdown() {
	...
	igb_release_hw_control(adapter);

	pci_disable_device(pdev);

	return 0;
}

Wouldn't that second pci_disable_device(pdev) call trigger the
"disabling already-disabled device" dev_WARN_ONCE() in pci_disable_device()
and underflow pdev->enable_cnt to -1?

>  		return -ENOMEM;
>  	}
> =20
> @@ -9647,6 +9648,9 @@ static int __igb_resume(struct device *dev, bool rp=
m)
>  	if (!rpm)
>  		rtnl_unlock();
> =20
> +	if (err)
> +		pci_disable_device(pdev);

[Severity: High]
When __igb_open() fails here in __igb_resume(), does this error path leave
the interrupt scheme and firmware hardware control active while disabling t=
he
PCI device?

Earlier in __igb_resume(), the driver sets up MSI-X/MSI interrupts, allocat=
es
adapter->q_vector[] and NAPI instances, and acquires hardware control from
firmware:

drivers/net/ethernet/intel/igb/igb_main.c:__igb_resume() {
	...
	if (igb_init_interrupt_scheme(adapter, true)) {
		...
	}

	igb_reset(adapter);

	igb_get_hw_control(adapter);
	...
	if (!err && netif_running(netdev))
		err =3D __igb_open(netdev, true);
}

If __igb_open() fails (for example, at err_setup_tx or err_setup_rx when ri=
ng
allocation fails), __igb_open() does not call igb_clear_interrupt_scheme() =
or
igb_release_hw_control():

drivers/net/ethernet/intel/igb/igb_main.c:__igb_open() {
	...
err_req_irq:
	igb_release_hw_control(adapter);
	igb_power_down_link(adapter);
	igb_free_all_rx_resources(adapter);
err_setup_rx:
	igb_free_all_tx_resources(adapter);
err_setup_tx:
	igb_reset(adapter);
	if (!resuming)
		pm_runtime_put(&pdev->dev);

	return err;
}

If this failure happens during igb_runtime_resume(), the device remains in
RPM_SUSPENDED, and the next runtime resume attempt will call
igb_init_interrupt_scheme(adapter, true) again while pdev->msix_enabled or
pdev->msi_enabled is still set and adapter->q_vector[] is still populated.
Wouldn't that hit WARN_ON_ONCE() in __pci_enable_msix_range() or
__pci_enable_msi_range(), leak q_vectors if MSI-X falls back to MSI, and
corrupt netdev->napi_list when igb_alloc_q_vector() runs memset() and
netif_napi_add_config() on already-registered NAPI structures? Should this
error path also unwind igb_get_hw_control() and igb_init_interrupt_scheme()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103102849.1340=
413-1-vulab@iscas.ac.cn?part=3D1
