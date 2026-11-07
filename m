Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B3606A333
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qcBDlSIf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4yDtueU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C235281215;
	Sat,  7 Nov 2026 11:50:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5FL9cgGVRWxQ; Sat,  7 Nov 2026 11:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0720812AC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794052252;
	b=XhHcKxnwSYaIbsuMBf0wk376R4qUM1bTC+uBKRmZsLha3+ZKd0PHhMiW33RFU7JEEi1T
	 MY87tnNSJR+/A1yk0B687tTqQakoAqJBNjqHOteDBuaLMY1YLPjZ4xTSiTLtcPmcxqoZS
	 Fn3HuKPj6JDATlFjUpU8ubsrdPz6FA8RjzKTAlIKyLm6c2vGSulj/1ytzlqU0Ytef7so2
	 n+Ps3Q7OLDrDbCDPDOwL7nT1zzhq3jsXTOh6HmcfILH9bYLPXDoQRylIh6XTNaYqWDFV8
	 wvjgNLo5L3mW3esvJAQlgD9YsiZ8SuxnzUab56h8vEJ5GwtUuCDk0Mk5mo7V4zBojPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794052252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0nl3EtW/t9ZcBzb8A/tKhYaRHR6Wov+cG3wp3yyG6Fw=;
	b=qIzevkkg6kSfklGeL4NilxMr1bWI4XR1PnFYT3x1VQJQ0mKbZdt+JgveLjIDR3piPX7m
	 2FOKWm5E7+bgqXjfmKOgzQr5rv6hn5yZm2GH5juWRG91Qif8XUJEdEN+Y/qRUdr51C3a7
	 itySU+r4H7l3N/4QsTr3vUz5dUCNhl82j8tk6HOc/6Hvvz7hOZIYM/3nfA0adrfSmjhOU
	 QdvMAFj9iYnI0GcR1p0Z+EPr9nBBbAzk0BTZPloNNyoKvEIJi62vKr69OWlcJLCiHB4um
	 fmUWmR6xUkOjK4q/rS1Tq4uaigfHj4gIKzkHAHd9ETim04LR9dhekgWX7dkKTr2tddA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794052252;
	bh=0nl3EtW/t9ZcBzb8A/tKhYaRHR6Wov+cG3wp3yyG6Fw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qcBDlSIfdbgr0vzKCTJQu23S0gRsAVfZ8DSYTj80m2RdH5DXPLKAhxfHZPtviK1lU
	 rU5gFOOKXhbzjrmP2M1agTgz0TjWQtb5tVzNh/vMTXbLQWcmEAuJ+cYG2z/CO/G1Gs
	 M498gE1g3/u+LyTmtDPn2cXKdL0reRgMx/BYA/3ZitOUpf3V+jkq369et7k7Ai7Wwk
	 HxLwo5B0OdB0bWbufPsAEODfV4Qn2h1lRCJ5emVo3pZ3ETYpxr78FSOcslDePeHzu3
	 F5peV4X2wD4/p+TWj7XTsIFpTp461wvQ+6ErfoMdXDYmC+SY8xaIS7m0A6BEvHkuRH
	 wSkAkDdYHjVrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0720812AC;
	Sat,  7 Nov 2026 11:50:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BEF1B2E5
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 11:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B069F400BB
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 11:50:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 41DRIqPOW_SL for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 11:50:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 79E2F4009B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=i4yDtueU
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 79E2F4009B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 11:50:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49640601EA;
 Sat,  7 Nov 2026 11:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667A31F0089F;
 Sat,  7 Nov 2026 11:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794052247;
 bh=0nl3EtW/t9ZcBzb8A/tKhYaRHR6Wov+cG3wp3yyG6Fw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=i4yDtueUQSU5XJr9MzitR2Fl+pi/ipaP5eQHiW3wI8jA04yP3Ok9og7wETsVtL5Dd
 khsI5tCNk0CRHKKOlG5BgT5h7oGlEJDKOSwH17Ic4gXhNV7wJ1tJ+XPYWd1vXME0Cd
 uzIBb2RH4riODr+k1Urj2IwkxxLY9aRKfBeaQ9ZexG0draPrkjTVvs8fAsmMtclti5
 MrH+i/d+Tby9UEB8FLJUiqWL3QuAmGyRYvVHo/MiylZGgxcF/pV+cOIXf7OKY58OHM
 T34Wir8JbVG2jllyGg71m2PV3nBpyM4ntVqk4Z4X2Oa933BCwnXuFsz44lwfMgooyv
 ynUWz5evMo9zA==
Subject: Re: [PATCH] ice: release the VF reference in the switchdev trust path
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 07 Nov 2026 11:50:45 +0000
Message-ID: <179405224597.994134.14854399116658341017@kernel.org>
In-Reply-To: <20261103100530.1309907-1-vulab@iscas.ac.cn>
References: <20261103100530.1309907-1-vulab@iscas.ac.cn>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
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

- [Medium] The Fixes: tag in commit "ice: release the VF reference in the
  switchdev trust path" points at the wrong commit.

--

ice: release the VF reference in the switchdev trust path

In ice_set_vf_trust(), the VF reference taken by ice_get_vf_by_id() was
not dropped when the request was rejected because the PF is in switchdev
mode. This patch sends that path through the existing out_put_vf label
so ice_put_vf() is called.

> ice: release the VF reference in the switchdev trust path
>
> ice_set_vf_trust() takes a reference on the VF with ice_get_vf_by_id()
> and then rejects the request when the PF is in switchdev mode without
> dropping that reference.
>
> Return through the existing out_put_vf label so the VF reference is
> released on this path too.
>
> Fixes: 1281b7459657 ("ice: Forbid trusted VFs in switchdev mode")

[Severity: Medium]
Is this the right commit for the Fixes: tag?

When 1281b7459657 added the switchdev check, it was at the very top of
ice_set_vf_trust(), before any VF lookup. VF refcounting (3d5985a185e6)
did not exist yet, so the bare return did not leak anything.

The leak seems to come from 83b49e7f63da ("ice: check if VF exists before
mode check"). That commit moved the lookup above the switchdev check and
did not change the early return:

    +	vf = ice_get_vf_by_id(pf, vf_id);
    +	if (!vf)
    +		return -EINVAL;
    +
     	if (ice_is_eswitch_mode_switchdev(pf)) {
     		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
     		return -EOPNOTSUPP;
     	}

    -	vf = ice_get_vf_by_id(pf, vf_id);
    -	if (!vf)
    -		return -EINVAL;
    -

With Cc: stable, the current tag would aim at trees that have
1281b7459657 but not 83b49e7f63da. Those trees do not have the leak.
There, ice_get_vf_by_id() still comes after the switchdev check, so a
fuzzed backport would add a goto out_put_vf that runs before vf is
assigned.

Should this be the following instead?

    Fixes: 83b49e7f63da ("ice: check if VF exists before mode check")

The phrase "takes a reference on the VF with ice_get_vf_by_id() and then
rejects the request" also reads as if the check has always leaked. That
has only been true since 83b49e7f63da.

> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index c49f48b5ae38c..90bf1becbc3da 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1400,7 +1400,8 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
>
>  	if (ice_is_eswitch_mode_switchdev(pf)) {
>  		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
> -		return -EOPNOTSUPP;
> +		ret = -EOPNOTSUPP;
> +		goto out_put_vf;
>  	}
>
>  	ret = ice_check_vf_ready_for_cfg(vf);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103100530.1309907-1-vulab%40iscas.ac.cn
