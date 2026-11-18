Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646460A2612
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gLZ82+k2;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDztSSZR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C221A409B0;
	Wed, 18 Nov 2026 16:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QkHHWVsddMef; Wed, 18 Nov 2026 16:29:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0C0BD4079D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795019372;
	b=HtqbTy/9xxF0zsSL6a3f7ZqdCdbH7sQ+d/xq39Gz+j2AhgO0WT54eB91AwtwDVwxRjTA
	 PunN8k2sKp8p6RcMtGBVd5K1yc5XySaTZw9typT2/jovbYgAwdHe78Srle/aw0L0AQTOx
	 nbprh+K3Zf5kidLJBed3nOeqltDUi9MkTfJgwRgmFCuTOzRM23zepm0AlHS7iJMLmXRkI
	 39cwnh+7WLP+EXpFulcy/K1iQUmhIeg9O2S5rTsUN1pWS/TGAVsv8CEr8DOczgCmK+Ur5
	 gOThmthz7dC0i8+F31XRdOiarS54geQppVMfRCpOJQpKOR2dL7iWhhoCVp7zaKPdiZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795019372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=H9IB/QVB2+euVplEaul1HXKfeIZrctddfWwJi1Lw4sg=;
	b=Bv7Re38JcI15v7wuuLNzTZsbetywDeRAt0h/PobkYvDxPsf0TjOGo513K14lgh4LYhs/
	 sFixpgoOTS67LHCO2Lgt8E7IfBt9xYseh6jwMtNPZvbTQja2KO0PB5bE4y0kMF84SQrxL
	 uW2hbi5xX9vd0jqoZUyMx8ySKn/5hUIL+yCHN6siOD2wXi5ZGaYvW6JPWx7tdJVLhl6a6
	 9YWqlBkS+/NFt2ERumUGs/K7t37qi6KYnXv4efLHtA0eiFGnK7uYrslilJlLCLQREdOkP
	 a8uRSoMlwKWQ1PCExEH7JkNhNEMarw9OGWhidDCVfnAGJy5lEw9qysDTLtvhY/q2PrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795019372;
	bh=H9IB/QVB2+euVplEaul1HXKfeIZrctddfWwJi1Lw4sg=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=gLZ82+k2lIPQZq7zDmag2pHSLAwrhBemgQdmTb9NlsVpNYVbAYC5H5egzIWXVOOe2
	 KzldI3yRGp0bhZ9EajqbQbqcPSdtCHus4zxKw0dmVk4HEnQymWctuzZRFK3j8YNCAh
	 L5K+rEm3eAjJXvt2Goqw0W1C5dJN8sB0t/o5Nm1HuaP5c+6NIOEdK5eJAksCU39CJ3
	 Nrpuz+jnVi1kyS2XAoc1H2+mJn5Z2Quft9JNEv2BU0jOmYRGK7yWGw0ttL4qmy08B5
	 OPvlHOL0yPwDtMlpWwvsWFDJz79h8/yVYDB9JmloVEVzIlKv0w2cUcP3wJw8P3ixjp
	 rorQfS2H0LR8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C0BD4079D;
	Wed, 18 Nov 2026 16:29:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B3434977
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 997A8404AE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cJK67P65ZlSU for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 16:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A02BF404AD
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=YDztSSZR
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A02BF404AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 16:29:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7479E62886;
 Wed, 18 Nov 2026 16:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8151F000C5;
 Wed, 18 Nov 2026 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795019366;
 bh=H9IB/QVB2+euVplEaul1HXKfeIZrctddfWwJi1Lw4sg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=YDztSSZR23ynfnaSYgYPZ1Ho1uswwh/4vIEE17ZxVP4BpVdVBMFOsUiOR2xS1JHKs
 UCoA2p62K+fuK6sHp0wwBwMOy/FfocvqXl78uonklYydQ7raYE44PjXut/5jJwCrzL
 kRkJ7g4pQqS02ArFaaFJYruvhQh4TspwCAsPq1XD+tk9UhZC0amHCvyGvwDpOaOhaS
 pL4JTf9ZVQfq/CrqmrWnBz9snrivcFiGV+nlpLX5o0c/Xmz5Wd4v9rFsuIt59YsR1c
 WyQ4Vb7J+2rDJZpLicRt1ale2O2faTEo8MQF4j7NGOIY0FnfcrIl5QmlQsiMzJ8xlv
 IBkFbJks/vyoA==
Message-ID: <sashiko-outbox-221482@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 04/15] idpf: psp: add psp offload initialization
To: "Stan Iliev" <stani@google.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261117145522.1910636-5-stani@google.com>
References: <20261117145522.1910636-1-stani@google.com>
 <20261117145522.1910636-5-stani@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:29:25 +0000
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
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] idpf: psp: use-after-free on netdev in idpf_remove() via
  idpf_psp_free()
--

commit 77673bf9c57703b770d88ecaf99ce33c90db8e20
Author: Stan Iliev <stani@google.com>

idpf: psp: add psp offload initialization

This commit adds PSP offload capability negotiation and initialization, alo=
ng
with helpers to register and unregister the PSP device.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/et=
hernet/intel/idpf/idpf_main.c
> index 566d5804c8c10..2fab58f4b02b7 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c

[ ... ]

> @@ -180,6 +181,7 @@ static void idpf_remove(struct pci_dev *pdev)
>  	}
>  	kfree(adapter->vport_config);
>  	adapter->vport_config =3D NULL;
> +	idpf_psp_free(adapter);
>  	kfree(adapter->netdevs);
>  	adapter->netdevs =3D NULL;

[Severity: Medium]
Once idpf_psp_register() is wired up, can calling idpf_psp_free() at this
point in idpf_remove() cause a use-after-free on adapter->netdevs[0]?

idpf_psp_free() calls idpf_psp_unregister() -> psp_dev_unregister(psd), whi=
ch
dereferences psd->main_netdev (adapter->netdevs[0]) in psp_nl_notify_dev()
and writes NULL to psd->main_netdev->psp_dev:

net/psp/psp_main.c:psp_dev_unregister() {
	...
	psp_nl_notify_dev(psd, PSP_CMD_DEV_DEL_NTF);
	...
	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
}

In idpf_remove(), however, the net_device structs in adapter->netdevs[] have
already been unregistered and freed by free_netdev() during
idpf_vc_core_deinit() or the cleanup loop above destroy_wqs, and
kfree(adapter->netdevs) here only frees the pointer array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117145522.1910=
636-1-stani@google.com?part=3D4
