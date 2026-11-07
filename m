Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C4606A326
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Rq7nRt1H;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/o0i7QY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 403FF812DF;
	Sat,  7 Nov 2026 12:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PY6FoxSR5ooP; Sat,  7 Nov 2026 12:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6CBAF812E4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794053501;
	b=QrqgIIzXe3CShwg1jdF12gNUjIR/aF3KKlI9UJdr5/oKK93ZRE+upq06zzyLLVghdQd+
	 vQ4aTYpzxgO96fCLV2UFHsBhmmYiaUXwCMLKRBmQ9we6mOXPKjf/Nxy0cxXWTvxQYKQms
	 ePNquENwmWlklJj5YYTWEAHnjE3kJ+6zYxsXcPG+KLnBXIMDtJMI70JuX+0/PuEIwAiFn
	 07uA/GWlFRnh7ctyjmWgaJ8kSX9K4EkaD9q0LOCwFa8HPsqqSHxNm7tyMn+BNOHlL11Y8
	 Mgh6nldZIDCFCDX+Cxw3yaoZ3on+B2XOa8oznauOC/6JhevnyJZuhYygp9Hy7ew/4kA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794053501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=8Drt58K+PxbCO+hFvJ+zR/HjxmjAQW/AG1u2EToS+0Y=;
	b=jl50bZIIkIE0oZuX+1XVwl4U5u3YN7xiXY/i6rmeiYs4ecnSF112SAjPbsZvenRhQMrM
	 B9JU3gc+aAdemcghjiDJTTcWTc+rxriaYKzqFbOH3/IV9Msem6PP9lsAG2uH/Uug0dlLN
	 gGP32CaOetRN5ZHVKOReCkXePXADOKpeZPjcbUoDDL4i2JXp2xe4Ftwhyy97gwTnQJr2N
	 vdFOl7mma8+oKBbowh+gH3LbenLVTcW/VXY5O6vC4jAmA4ugNnmedtKfDtwlvvp7WoSy/
	 SgekOoA77ktIfcx+v0vBeIDhzz87EP/Q7WprwP7UNfzZqaclQVEIEvSS8fUw1vDg0Hw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794053501;
	bh=8Drt58K+PxbCO+hFvJ+zR/HjxmjAQW/AG1u2EToS+0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Rq7nRt1H5a5luainmy0jTcGij/zU5Bhd0ggdoJ11b/CV1IMljdeL2ju6KH4WyQWHF
	 gN7mxloKhjEEQeMHCYyUPzcqyTJSt5PNznga0q/5tVh9k4xTzYz/JsRCpQ+3tfYkl4
	 gZGPuFykhD0Xp18DsGe/rlFsSGK0TzdxP9z8DK/TLmFRZibkXbOl1iegDJQQ0Wp7mW
	 tOgWb9hHSMuUUxzR9P14Cf0D++S4bc7bkcuTcVFMjzyBBKKFtEEIOAJc+GAZo9C5td
	 U0PXIBrQCfFOh+4uiLf0L3lM5krkf2Tm71a/jkhrB8h2aXRB6FkDUVn7CSvq19tTws
	 xj/JqEkX5D5kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CBAF812E4;
	Sat,  7 Nov 2026 12:11:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37A95211
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CF1060746
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JTu0sLlyXKA4 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 12:11:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E9A9B60719
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=E/o0i7QY
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9A9B60719
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:11:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DFAA9601E3;
 Sat,  7 Nov 2026 12:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF701F0089F;
 Sat,  7 Nov 2026 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794053495;
 bh=8Drt58K+PxbCO+hFvJ+zR/HjxmjAQW/AG1u2EToS+0Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E/o0i7QY+zZHhJxok6XWdCvD1wz1J2uhHCWlxPGJ+HMFLkzgjq8kDbfBo+xLC8SLm
 Kr7EzstoUhfhlJD5Dt/PhGvpDJgdOgnbPHlxAOSK1VMyFmwbQZtHkZmmjRHLpa5lDb
 grgXK/Xu8JUzT6sS9d6fib4qDBuEjGqOdslvZu1iqn7WVjJmz+Hi3oMbUQvwM5f5T2
 JR3IZ0Vo7rYpmcWN6dn2wuFp53XubaHf77kAVadrECfiqP1t6iYQiOlhk6hJg/rHXN
 UdLLWff2RtGHuHJIsPx9kZb8pVKYaER/yanmTxcqF98MltcOYjbs5Fj1XDmk5O6iJe
 4DUXjnf2+c9vw==
Message-ID: <sashiko-outbox-202874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 02/10] ice: dpll: serialize changes of the
 SyncE CGU registers
To: "Ivan Vecera" <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261106121005.1327603-3-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-3-ivecera@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 12:11:34 +0000
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] ice: ptp: unconditional R10 write and lock scope in
  ice_ptp_link_change()
- [Low] ice: dpll: missing Fixes trailer for commit ad1df4f2d591
--

commit 6fdc60cccd47bebe7d61ff60807ee77303bf58bd
Author: Ivan Vecera <ivecera@redhat.com>

> ice: dpll: serialize changes of the SyncE CGU registers
>
> On dual complex E825 only complex 0 has a functional CGU and the second
> complex reaches it through cgu_peer, so PFs of both complexes share the
> CGU registers R10 and R11. They read, modify and write them when the
> state of an RCLK pin changes, and ice_ptp_link_change() rewrites R10 when
> a link changes, under the pf->dplls.lock of their own PF only.
>
> ice_ptp_link_change() does not hold dpll_lock, so it can already overwrite
> an update of another PF. RCLK callbacks are serialized by dpll_lock, but
> the DPLL core is going to serialize callbacks per (module, clock_id), and
> each complex has its own DSN and so its own clock_id. With that change, a
> test toggling RCLK pins of both complexes lost an update.
>
> Add a mutex to struct ice_adapter, which all E825C PFs share, and hold it
> around these sequences.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

[Severity: Low]
Since this fixes concurrent CGU register updates in E825-C SyncE support,
should it include:

  Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin dis=
covery")

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index 3df08714510da..4d4b6aaaf30c2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1395,7 +1395,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool li=
nkup)
>  				break;
>  			}
> =20
> +			mutex_lock(&pf->adapter->cgu_synce_lock);
>  			err =3D ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
> +			mutex_unlock(&pf->adapter->cgu_synce_lock);
>  			if (active && err) {
>  				dev_err_once(ice_pf_to_dev(pf),
>  					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",

[Severity: Medium]
Should cgu_synce_lock also cover ice_tspll_bypass_mux_active_e825c(), and
should ice_tspll_cfg_synce_ethdiv_e825c() be skipped when active is false?

ice_ptp_link_change() checks active via ice_tspll_bypass_mux_active_e825c(),
but then calls ice_tspll_cfg_synce_ethdiv_e825c() unconditionally:

drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_link_change() {
    ...
			err =3D ice_tspll_bypass_mux_active_e825c(hw,
								port_num,
								&active,
								clk_pin);
			if (err) {
    ...
				break;
			}

			mutex_lock(&pf->adapter->cgu_synce_lock);
			err =3D ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
			mutex_unlock(&pf->adapter->cgu_synce_lock);
			if (active && err) {
    ...
}

Because ICE_CGU_R10 has a single divider per SyncE output pin shared across
all ports, a link-up on any inactive port with a non-zero link_speed
overwrites the divider of whichever port is actively driving clk_pin.

Even if gated on active, reading the mux state outside cgu_synce_lock leaves
a window where another PF running ice_dpll_synce_update_e825c() can switch
the mux to a new port and program its divider before ice_ptp_link_change()
takes cgu_synce_lock and overwrites ICE_CGU_R10 with the old port's divider.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106121005.1327=
603-1-ivecera@redhat.com?part=3D2
