Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DE606A31E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 04:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=0hvURLg4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8+ElPoL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44E0260667;
	Fri, 30 Oct 2026 04:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nE7Njj9--3mp; Fri, 30 Oct 2026 04:53:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 47BDC60A70
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793336026;
	b=p3keTe/61opCmXVbqKI5Sr1y7t1NG7gHsyoyX6eFijSFMFCothCXePxyz5XaIm/G1OP/
	 tPnzbXs3t0QerYVfheaxY+APXh9pm4TtRMi933mpUoKYtuEo3hO99wPU9QVAqh3DoAQvF
	 7pojiPrn0r7lpbMZil3XS1B5DEF5dtGtNXqSRBM4YcswRoFSRHGEbF8LUMK4LbOO9unKC
	 RUJd6VWxBm7TaPUzgm7b7YPX0I/s8lgdgyU3bOfVTkzyrXtyzHWkfqd7JeTu9IWt9Pyxd
	 ZvG6KvNgPwx3kLHIt4XDcrqDiZpLKkFQ1t7rt2NlLvnTtaarKXiYRPNgYmgeGdTJeLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793336026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=gOlBZkYiQ7X4DBoRSN46jYuAa3psHfdbOueVCxjqTeg=;
	b=DuBquR0pf7uyuYV6ocmMvv5fpLFV9/kTjB0pYzXZ11w0swqIRwEGz0S0j9OcWAtDI14P
	 kCunwjBmQiS4jZ7ECFDmO/vmH5nb7bppZQ1G5VGz9D1Ank1kzHvhKJxJXxbFi5vk/1uIc
	 KedPFHZDc15o+5WAfN8ZUN9AWIxauTdtITDx2BOoWESD52LpwlEwJMHs2g71cN9jtP6Bu
	 gO/raZdJaybO9rsZGeFqujRU5LgOXi2n8RaLlQqiqd0G5w/mEp71ZILRH2swhbj83ppYl
	 6zegw8EKhJ+uRD7Z2baFKTviQfDL5xVPLI6MGBVGCy2VvcCKMVJhLmft4btngqa215Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793336026;
	bh=gOlBZkYiQ7X4DBoRSN46jYuAa3psHfdbOueVCxjqTeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=0hvURLg4ZYXu0nVcWR8eLcdfi1/FpJkV7oO7bUdQ92SwABnC5yo6DW/o71k4p0eaF
	 fMVrYYvI3VomSyxzM041hTNIXg+vp4RPsPVK+Af0gZ0xSrtHpYcfi/21HwWzjo4Y2K
	 nMl8SI4FdCUswF+YOoIfpCyOJH3EWKk7sT84OkWiqcqw8vuzmIDHvRzNn1KbwDcjFZ
	 l0w534FlJCpoxX1j/HG0Q2kQyuaXdNH2x22laE7ngjzDek6pFtkH21Oo+htNTszo8D
	 kPpxS/ESh/By+rKJP3jabUM/WB8+5sI8as7ISwNbwVNfoS/tEoue9exMCgBVXD2prM
	 kkUEHG3Rw74Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47BDC60A70;
	Fri, 30 Oct 2026 04:53:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 49F91D38
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 380884051D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GM7aWTNtvy4d for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 04:53:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 480AE4051A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793336024;
 b=cuEkX5J2c7sHhgKxy7Wj7jzszJX9VIT7FEjjZKcKF1TF2TthUSIdWG9VLIi5aa+n7ziP
 aUKYu7dH44fcqyAahC5bgS42JmspEFqfouPT5Fhljk0+mG3K0PwtxOEPftWh1lc/CIeup
 A3C8ZoCJIpLzWqfVPMtO7Xx7QA5Kv0iqBM5UVIUpZ7pau3oZ2JT8X/HxIXYJxXCKZpjKh
 KWpbF+XMa1FOmwjJoKDtwrD0Ba55gAvYPXJlWSRfr8qMef9wJWiP0bKuXbWZis35WAWJO
 GttuHPr6OtOhbnKJP8eNYV/fFydkYnSSv7RKQ7ywSME7xpPSAiHOhZ2TBte+Soi5XPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793336024;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=gOlBZkYiQ7X4DBoRSN46jYuAa3psHfdbOueVCxjqTeg=;
 b=c/569CajVWcJr3dF9f0zAz6TIhwMQdSZ9aghgUrUeKmPc1qlwXsU15RBBNoaT2x5BVRb
 cIyxvaUg+kqolcXkRrq/DZvYvSw1b7rLoLhk5M5dcdVaUQkSTiVf2ijUS/jOsCAM+aKix
 hDwh07Z8qDrZuZLL3P9LXoWoioHlXWUM91PqGaQYFzRJbFvUyxqQu/tr28ADtIb3UnnaL
 x8uOWW/pZa0mbL03Mubi4Z+JwBpMSpMsRcDSNXxBtQLv/TzNcpKfEzWtP3l36sCVYvjLR
 I8+r45WmCk58etlgyVsgrBZKGWoUXFrC3zm6akndByr9gbgQvbNdo8ygnImJ4FlfvJQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=e8+ElPoL; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=e8+ElPoL
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 480AE4051A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:53:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3EEBB421F4;
 Fri, 30 Oct 2026 04:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040E41F0093A;
 Fri, 30 Oct 2026 04:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793336023;
 bh=gOlBZkYiQ7X4DBoRSN46jYuAa3psHfdbOueVCxjqTeg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e8+ElPoLajNhj2YCXq3qoFrClM+wTIkAsiAuCgT2oO+cul2u3uAv2/DZHZY9aQu7F
 0Di8UPUIUVIOipGzFefs4Q5DcuaSbay10K8wBSlXShX/tWWOoemxMFhlGijcBmbK32
 DbjnLKU3j9vnu55HK52St3SmVpDmf4scKMyxkkzXMeAEXWZQzTBOFLuaawkYqIWacP
 3yGekP2qZaOcj5M2AdWXLJvc4f6tNi6rB/aVsYAiTIS8qjlIM0OzeiKiiIwREY5EsX
 DKWF0+AJSPh7z8I3ZKkHUn5K/AQjBkqvuWt7yxY+fsJIS+//xDylwfdvPCK4ck5pFY
 vp0u/zbfBqNkw==
Message-ID: <sashiko-outbox-190340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next v4 3/3] igc: add support for forcing link speed
 without autonegotiation
To: KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20260428060009.311393-4-khai.wen.tan@linux.intel.com>
References: <20260428060009.311393-4-khai.wen.tan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:53:42 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Forcing half-duplex permanently clobbers the user's flow control p=
reference.
- [High] Missing validation for DUPLEX_UNKNOWN causes silent fallback to ha=
lf-duplex.
- [High] Ad-hoc synchronization loop using bit flags instead of a proper lo=
ck.
--

commit 8d7b28f68d024d026b38dde450a1a1adfbbf8daf
Author: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

igc: add support for forcing link speed without autonegotiation

This commit allows users to force 10/100 Mb/s link speed and duplex via
ethtool when autonegotiation is disabled. Previously, the driver rejected
these requests.

> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/e=
thernet/intel/igc/igc_ethtool.c
> index cfcbf2fdad6e..9997ebbdf778 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
[ ... ]
> @@ -2000,6 +2013,41 @@ static int igc_ethtool_get_link_ksettings(struct n=
et_device *netdev,
>  	return 0;
>  }
> =20
> +/**
> + * igc_handle_autoneg_disabled - Configure forced speed/duplex settings
> + * @adapter: private driver structure
> + * @speed: requested speed (must be SPEED_10 or SPEED_100)
> + * @duplex: requested duplex
> + *
> + * Records forced speed/duplex when autoneg is disabled.
> + * Caller must validate speed before calling this function.
> + */
> +static void igc_handle_autoneg_disabled(struct igc_adapter *adapter, u32=
 speed,
> +					u8 duplex)
> +{
> +	struct igc_mac_info *mac =3D &adapter->hw.mac;
> +
> +	switch (speed) {
> +	case SPEED_10:
> +		mac->forced_speed_duplex =3D (duplex =3D=3D DUPLEX_FULL) ?
> +			IGC_FORCED_10F : IGC_FORCED_10H;
> +		break;
> +	case SPEED_100:
> +		mac->forced_speed_duplex =3D (duplex =3D=3D DUPLEX_FULL) ?
> +			IGC_FORCED_100F : IGC_FORCED_100H;
> +		break;
> +	default:
> +		WARN_ONCE(1, "Unsupported speed %u\n", speed);
> +		return;
> +	}
> +
> +	mac->autoneg_enabled =3D false;
> +
> +	/* Half-duplex cannot support flow control per IEEE 802.3 */
> +	if (duplex !=3D DUPLEX_FULL)
> +		adapter->hw.fc.requested_mode =3D igc_fc_none;

Does this permanently overwrite the user's flow control preference?

If half-duplex is requested, requested_mode is set to igc_fc_none. Because
requested_mode represents the persistent state for the user's flow control
preference, the user might permanently lose their configuration. If they la=
ter
switch back to full-duplex, requested_mode remains igc_fc_none, and flow
control stays disabled.

Would it be better to dynamically override hw->fc.current_mode to
igc_fc_none during link configuration instead of mutating requested_mode?

> +}
[ ... ]
> @@ -2071,14 +2126,20 @@ igc_ethtool_set_link_ksettings(struct net_device =
*netdev,
>  		}
>  	}
> =20
> +	if (cmd->base.autoneg =3D=3D AUTONEG_DISABLE &&
> +	    cmd->base.speed !=3D SPEED_10 && cmd->base.speed !=3D SPEED_100) {
> +		netdev_info(dev, "Unsupported speed for forced link\n");
> +		return -EINVAL;
> +	}
> +

Should we also validate cmd->base.duplex here to prevent a fallback to
half-duplex?

If a user runs a command like "ethtool -s eth0 speed 100 autoneg off" while
the link is down, ethtool queries and preserves the current duplex value,
which is DUPLEX_UNKNOWN (0xff).

In igc_handle_autoneg_disabled(), the code checks if duplex =3D=3D DUPLEX_F=
ULL,
which evaluates to false, and forces the interface to 100 Mbps half-duplex.

Could we explicitly check that cmd->base.duplex is either DUPLEX_HALF or
DUPLEX_FULL and return -EINVAL otherwise?

>  	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>  		usleep_range(1000, 2000);

This isn't a bug introduced by this patch, but does this ad-hoc
synchronization loop reimplement locking without fairness or lockdep suppor=
t?

According to the Networking Subsystem Guidelines, using bit operations as a
substitute for real locks violates core kernel locking rules and introduces
potential races.

Could this be replaced with a proper concurrency mechanism such as a mutex?

> =20
> -	if (cmd->base.autoneg =3D=3D AUTONEG_ENABLE) {
> +	if (cmd->base.autoneg =3D=3D AUTONEG_ENABLE)
>  		igc_handle_autoneg_enabled(adapter, cmd);
> -	} else {
> -		netdev_info(dev, "Force mode currently not supported\n");
> -	}
> +	else
> +		igc_handle_autoneg_disabled(adapter, cmd->base.speed,
> +					    cmd->base.duplex);
> =20
>  	/* MDI-X =3D> 2; MDI =3D> 1; Auto =3D> 3 */
>  	if (cmd->base.eth_tp_mdix_ctrl) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428060009.3113=
93-1-khai.wen.tan@linux.intel.com?part=3D3
