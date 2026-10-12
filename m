Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEADBCA9EC5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 13:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64E81405B6;
	Mon, 12 Oct 2026 13:50:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMFxUa9fnKAf; Mon, 12 Oct 2026 13:50:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A256B405A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813037;
	b=gClvrBO1of+0qgFhtGG0mA2dqE6b1JKgbguaTJRLRxp1Uw3MsuwA2heAOiSVuwTG3o5C
	 cUXhI3hsJmNsnBTh7AbwPlSe+Vc15tlOakw34OXO2ABIDE04sNgQqSumBu1bucYEFpCy/
	 ytoMFtQL59RFMhjTkp4H+5mAEsMj3HWfeUWiQ42Z6QGcYppGI/V319Ja7jCeTn9XwUuul
	 UADderUn4/oTo2kGL8hOCCnsPUfg+qJMXJV1qIB9RzaiKbR+uXasI0L+TasMNaLIt+cnG
	 U4cgfavpCQSAq5yVJqRDoJ8C1xyGkcKj+d3kQHC0IBf/x0kDF/oc89l5SDkd8cnDJrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=4PC4UyKNGexm1Fw+yR4Tb70n/1wo2DcTf0BnPQWg8h4=;
	b=EVOTw37xFT+TaD+whrHDQm/llkeFHZtomzZ5OiAF/m5tLGjoYFK4sVZ9c1kMt9NNPeAQ
	 +WMefuLTub3qRcj71hnKtWZgP/BCA0ej/tBF3Ek4OYRsfu3ZkIfRSPvayjnOcbFVM4Utg
	 ceqWQUThgIAMATy/KWyw2zXT2UYJxM+AiUKzk4BBOS+LLeo43yYBULn7VlYFVb4CGsYnf
	 g+4x44rs7Vs4Z0eNYl4T045jzZY/UJoMxFIT6za58MYVl09q7r+N4q1BQibkuX+yspKW4
	 /BFiG0UsE+5LrZkO5I20j6Dryu81jazGa+zkZ6wfXCl1gA4LXrr1iKklrXICDSWzODQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791813037;
	bh=4PC4UyKNGexm1Fw+yR4Tb70n/1wo2DcTf0BnPQWg8h4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=rzKhSWPRbsBDpbPaVvD3Pzwwp+S+yI/nj3FTxByRVqxerW5LzhdW4kgV8jJt9yjZx
	 E8q0ekKHu26rt+ffRAoqoiT6N5NXAWKbKU/QcEjxOuwiAkx1/uzmSbvNbeAwvA7kQn
	 Tj78QmQF0E7femuco4SNgVcljQJbiPK7xuBJSdgRdvFuXLQTM9SqCRmbw3nG9oWvwi
	 DOkqYbCtrm9RULl0qd2qmMw3HHVMSouTK/SRmEjRsQrif6hV73Wm1f9+w1jixGqwAK
	 14rCH+lkFP4Lw8hqKWdWxp/LTpb492lXlccxHiKAfpIcmALT/WfaxNys9bIc8ThQ41
	 yruk2EQJZSL4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A256B405A4;
	Mon, 12 Oct 2026 13:50:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 777592E0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CA384010F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:50:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kVMbqXhUQP9p for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 13:50:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 869B94004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813035;
 b=qaEYC65OHmdsPV62uFH5b1n8Z0elG53rjKQq4RnoGlUgFt5lUOiUIx5s0NxSoVov/kRn
 2z74Te6llHbANxK3F+D6lLn28eju91JoZo9V8BJkxbjuqeDHmGZKoiEq4PjQoomxPx36q
 zNpOwJTX3b59h8r/mjfb0blFrveMg6LYUkPOFztxYzUi8HVG2AZcrs50Xxg6EjYH6Ls++
 9qcaHNyoKZYKgM5LTrgeka03E9aDoUJ3NgNawIb08CJOfwcMfAKHLvd+u/LYBRuth90Lr
 fYmvO+p+Zmz4qaX1BMve5dY9H3PTt2/iT/Z/v1KPH5/vZGkDrOg6iYpFYG7gRtMniMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813035;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=4PC4UyKNGexm1Fw+yR4Tb70n/1wo2DcTf0BnPQWg8h4=;
 b=nz/J94cEDPM3o0u1l3JthvZil/P3+iZZ1bRxdIOYWpqtD9roz9muXiuTdlOE+kp7UCni
 KpoBTYE8x0nfOomaVnVSjlF/T8v+AlRnP4qaLhfp9iaiBLXVIEvyNPSuTO6G4d5RHKjVo
 cQweald4k76/7sxE1jJkXBTCH2DQr/vcebWt/KTHAAxT31ELrnlD9ko0wxGdVvGbK9u5n
 WsFoVpw6YZJisVGeef5cS6Z2dyXz2Af8DjO6y9odOAlxm4qgIsgwULDX1DjkUPIOQ23vH
 zo/CYxqQbAxzUeTaSpn9s5MWNFBIV7X7m4p4fkG29QhwFN9zIfmGc6WXFqO0FAfrojA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=I5xcIuVO; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=I5xcIuVO
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 869B94004D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:50:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 18BC843F94;
 Mon, 12 Oct 2026 13:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ADF1F0089B;
 Mon, 12 Oct 2026 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791813034;
 bh=4PC4UyKNGexm1Fw+yR4Tb70n/1wo2DcTf0BnPQWg8h4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I5xcIuVO742ztfR7n8Ax1Y1aMVBOSegCg2ZKDPFD1WNV1t5drXQOgrK8yuz6epR9y
 7JeR680ufLmx6ziWv6fHenLTHDutyPAn9Xsyk8G5lZL1Gt0iIWAMS8Dl/DvIFxQMKI
 vB1zCmGyWXxSR/o2dYJqGLoqjHV4RuYq9NBqvtwGJ96BFqAF6E9d3dCcYM3rZ3ZRpz
 wCvfJBBnBzx2RxjvSv377wzikyRV5u3TQG+mmcg/OW0bcnjsCXPDeBYhl5sLn6sNzX
 5OHFwsXuTBXyigyLgoYOkIGQvRz6UXhjGeB+IdaYpGqepP0GE/G2BhwP0BgztFpDoJ
 EdJIIqVn7SJQg==
Message-ID: <sashiko-outbox-168218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v6 2/2] i40e: add devlink parameter for Flow
 Director ATR sample rate
To: mheib@redhat.com
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261011134952.54887-3-mheib@redhat.com>
References: <20261011134952.54887-1-mheib@redhat.com>
 <20261011134952.54887-3-mheib@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:50:33 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] i40e: missing state check in devlink atr_sample_rate callback cause=
s continuous flushes
--

commit dbdc3fe26acc90d8b2942b0ba0ea5222fd02c43b
Author: Mohammad Heib <mheib@redhat.com>

i40e: add devlink parameter for Flow Director ATR sample rate

This commit introduces a new devlink parameter, atr_sample_rate, to allow
administrators to tune the update frequency of Flow Director ATR dynamicall=
y.
It provides set and get callbacks to apply changes without rebuilding the
driver or disabling ATR functionality entirely.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net=
/ethernet/intel/i40e/i40e_devlink.c
> index 229179ccc1319..8af2487776f28 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
[ ... ]
> @@ -33,12 +33,58 @@ static int i40e_max_mac_per_vf_get(struct devlink *de=
vlink,
>  	return 0;
>  }
> =20
> +static int i40e_atr_sample_rate_set(struct devlink *devlink,
> +				    u32 id,
> +				    struct devlink_param_gset_ctx *ctx,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct i40e_pf *pf =3D devlink_priv(devlink);
> +	u32 sample_rate =3D ctx->val.vu32;
> +
> +	WRITE_ONCE(pf->atr_sample_rate, sample_rate);
> +
> +	/* Setting rate to 0 disables sampling but does not remove
> +	 * existing ATR entries. Flush them so stale filters do not
> +	 * persist on devices without HW ATR eviction.
> +	 */
> +	if (!sample_rate) {
> +		set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
> +		set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
> +	}

[Severity: Low]
Will this trigger unnecessary hardware flushes if a user or configuration
tool repeatedly sets the atr_sample_rate to 0 when it is already 0?

The devlink core in net/devlink/param.c:__devlink_nl_cmd_param_set_doit()
does not filter out unchanged values before invoking the driver's set
callback.

As a result, i40e_atr_sample_rate_set() unconditionally sets the
__I40E_FD_FLUSH_REQUESTED bit in pf->state, which then triggers a flush in
the background service task.

Would it be better to check if the new sample_rate differs from the
existing value before applying the change and requesting a flush?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011134952.5488=
7-1-mheib@redhat.com?part=3D2
