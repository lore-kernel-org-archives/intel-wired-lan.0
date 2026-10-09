Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDFFCA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 13:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90AFE60663;
	Fri,  9 Oct 2026 13:19:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w84zbYluooj3; Fri,  9 Oct 2026 13:19:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C5F5E60680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791551958;
	b=WEP9YTdErAp5EqHvOF0GuYIE+OB9hl1xxMrvKGptR/tNtHuJge+FH6wKM0wh7aYZo7Y/
	 hltEEieIS3wgmRTjrcpbwOVC00Eisg8Mq5gWRI6WIkt7dEo/Xu6LHtZdh8ZbxazIV5ILN
	 uQveENix3XvY2QJqiybgmXctT8/gWAQerFrTAQYDxCmViJASQWw4OsCdDyho9Y6i7A3wU
	 uTzf4Hg1H9bNyCwqK2Yjzc73k/K/h/C8oh9GPjIXtWv3KzFdP4ymVuE6aveW5r8S7IZU4
	 Zf50K/V+aLl/L2PF4CNFBQET8s+/3ItVdCXNYO2sfNV5mLp717DUIoDHx6r/NSlhxQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791551958;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=bo+v2QxNt0XAgkE5/+21CqaJy88U+3ds7hOysDguQjo=;
	b=XPv7WpfLXVEwbrYXgMmKFktJBzzlRMTS9s72m1zKUej42Z1t/Wa7H6xwhkss9Cw1hxB5
	 vuFSp4w2KIsd5WhNnbzBtBcK2WxBCLaqg3xm/7Ruaz6OquR1FtaJmXhwm/MqxF3hsXdW3
	 dKcJTQRMF4p/iYHSEqaLEUNutchDpp0SWT571Wr34uk0FgupJ91gqB3u+DmdqjG7sDh1/
	 jAUpBgSj4AZ1bmvecfLYtovsmR87ThKjAqg7MWGpiqnoantvpZRfW1TL1JVYkvePFBBBU
	 f6cnziSAW8c3TuqW89dOv2436JTLl3gNpJjkHo0BSShXwdZOQPG02LZZNA7LJL33slw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791551958;
	bh=bo+v2QxNt0XAgkE5/+21CqaJy88U+3ds7hOysDguQjo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xYL04eswiLyCIweuftp6UCg1DWWXk4VPMHjh+HnjchWfLpaQlXQw5flmh2Ey9psN4
	 RvpmrzfOKkUbR7iaBKslinJDN6uCROJgn4x3Q27krlNp9VOIMXLx68AkF7u1RmeigG
	 W0hhJlwcoUU8a9ShSlTBR2HI9ttNLAivEuGUyNtriFO1RnDIV3Kxc+UNKpfF2SSnHN
	 NDxTx5rsTahX9xwEm94QI0+TLE4Ad7ozvoAr647HUfwySJObW0EwB9J5NnJcrzDdwG
	 B1BCDY2SdyRtiQYNu7nCXq+apm4nIpVkcWZT8YnH/DCRH9nk3Rxah5w54oqqBEkCUv
	 6h4Wl30SfO3eQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5F5E60680;
	Fri,  9 Oct 2026 13:19:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 767D4422
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73E2640835
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:19:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SP6_lSDj5MWl for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 13:19:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8909840824
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791551956;
 b=U1tC4rBVxlUEGU6rHYfedEdwlTt7lyqlId7SyECVYPBuCR1V17kqXB3WyFG5WQweLt3q
 FL0X/uNUehgDPv5MX4quZhPbzb+74D5ahnYLYVQxgws0XX8qSuGn4wRsJPW5rdTsGhw/V
 vP6y2i3ZEwk0GluZcHJOwtY6rMou7bOTWaVaGWUe6cxK1Iwbgm44FUo8pV10RjjNvxo2C
 AbEx06WfCZhqGc9/Nvw6CNGAgKZmQUzSPQ7ojfHku4eMArt9XJbycjnNORBLR/QIHwGXa
 kxeuHFR1QY6C522PoL29Xv5w8P9Ti7pMlBDIEv9TxpxN6ywXcAYVgZM4jewyB0b6Lsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791551956;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=bo+v2QxNt0XAgkE5/+21CqaJy88U+3ds7hOysDguQjo=;
 b=UVFZIxXU94hFfWQkwrCCNegA90GZ8Go5dkTUrhwQWLiDUxGP3BOgHkd3YD+hxWhcaXj3
 nhoCZ3bJAPiDXuZ+jD55s/5SKjhbNnJhkVKgxzrCZe6ueKLtNlK+yglPSqo8w2AZGOKxN
 88miXHsGPwT2ffzG2Vb1edJ2jKj95dwsDVWMcs7DwOZEFCKU7NdZXs42VRU2UMhhMpQrG
 Uvy4LrXktCCR+wSwU3gLxHnx8JjpwIfRCVVJNd2yWVOJLoeUhKeSh7KuvVfeOemU8plP2
 3i0Wxz8EzwPWNY80aUxXRlLjbEXDtWPYDQIMQMMyp8xlJ/xVvs0nXCOLho/d0Ywu4bQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TV9FpAKe; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=TV9FpAKe
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8909840824
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:19:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EECF760098;
 Fri,  9 Oct 2026 13:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6461F000FF;
 Fri,  9 Oct 2026 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791551954;
 bh=bo+v2QxNt0XAgkE5/+21CqaJy88U+3ds7hOysDguQjo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TV9FpAKe1sBDrf6iKc8bjsT4wo7X6uZdIqDZIk1rzDUPN5S1iOSfN4nfOYqUlqU/E
 wBqreG8P+n80TGcak6ks1U8t5aiTNx6Ki0QF4mHEgYk/2sNHiItivWuMIlm+L139zn
 id7uJxL5Yf4Ol12XY3q6XkGWiu8rGNDWGhecpTeu6MTVsIgHE5XHjYdd1K+S6LAtSP
 w4JiQKAWmTqxjE9CmXeIr6ZNyBQgAm8/sIqIJPGP0wBCwOkodErRzKrLGI1jrYn7Up
 abLsIZB65w6lcRW7hHmRRtChrbfELSNyeDxmKsOF7cyAC88inzdq0xvkLDgbuG0OwC
 trXcjOs2S6u9g==
Message-ID: <sashiko-outbox-165616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v5 1/2] i40e: move ATR sample rate from ring to
 PF level
To: mheib@redhat.com
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261008131824.248508-2-mheib@redhat.com>
References: <20261008131824.248508-1-mheib@redhat.com>
 <20261008131824.248508-2-mheib@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:19:14 +0000
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
- [Medium] i40e: reset_needed bitmask overwritten instead of ORed in i40e_s=
et_priv_flags
--

commit a5576ab3ed2619cb9e4c77239e0fd5bb5851d0df
Author: Mohammad Heib <mheib@redhat.com>

i40e: move ATR sample rate from ring to PF level

This commit moves the ATR sample rate from the per-ring struct to the
PF level to apply it uniformly across all TX rings. It also triggers a
PF reset when re-enabling ATR to ensure fd_ena is properly re-evaluated
in the TX queue hardware context.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net=
/ethernet/intel/i40e/i40e_ethtool.c
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -5300,6 +5300,16 @@ static int i40e_set_priv_flags(struct net_device *=
dev, u32 flags)
>  	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
>  		reset_needed =3D BIT(__I40E_PF_RESET_REQUESTED);
> =20
> +	/* Re-enabling ATR requires a reset to reprogram fd_ena in the
> +	 * TX queue HW context. Skip when FD_SB (ntuple) is already
> +	 * enabled, since i40e_configure_tx_ring() sets fd_ena when
> +	 * either FD flag is active.
> +	 */
> +	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
> +	    test_bit(I40E_FLAG_FD_ATR_ENA, new_flags) &&
> +	    !test_bit(I40E_FLAG_FD_SB_ENA, new_flags))
> +		reset_needed =3D BIT(__I40E_PF_RESET_REQUESTED);

[Severity: Medium]
Does this direct assignment introduce a regression by inadvertently
overwriting previously accumulated reset requests?

Earlier in i40e_set_priv_flags(), we have:

        if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags))
                reset_needed =3D I40E_PF_RESET_AND_REBUILD_FLAG;

If multiple flags are modified in a single ethtool command (for example,
changing I40E_FLAG_FW_LLDP_DIS alongside enabling flow-director-atr),
wouldn't using '=3D' here instead of '|=3D' silently drop the earlier
I40E_PF_RESET_AND_REBUILD_FLAG requirement?

> +
>  	/* Before we finalize any flag changes, we need to perform some
>  	 * checks to ensure that the changes are supported and safe.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008131824.2485=
08-1-mheib@redhat.com?part=3D1
