Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D063606A325
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 04:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=INLL3t/g;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAlfJTDX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 311D160AA1;
	Fri, 30 Oct 2026 04:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E7l2deIEYmWL; Fri, 30 Oct 2026 04:54:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 51FCB60A70
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793336045;
	b=c2dWq4JZAXWmUYDW1PByFtFbr8F5odnLRF7jHVD/nWgZz+ZYKdCavsFdOG8PC8WuTZM4
	 OfixPikCBcb0jozmhgF/lx02K32vB0hN68sDFIywEPL0rg9Q9JoarWZSQMZfObbRrk7Qv
	 kkWKJUTBNumCXw6FjKfjOXnNZsYxLstnH0mSmejQ+cMJiuT4Ao9IH+7UyJeJ6CTRlO5zB
	 NatyZ4nuN+WslcQwOTsaSC5bbN2v+iv5+7gqPm9ppGTDtqv6LEMql24apjIQQ41KB4SFn
	 iL/pkGu3VcShtEtN+y60r1ENrK1y9l6uuabIVBwLBnde6p40Of3ZuHGkVFyPMmQJNXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793336045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ypK+XpbXzqymYnMSICyxl78EYLPAEwkshdZws3ByR1E=;
	b=WUW0tK9GiBNHwPwSrNjDx3LZVeujAw38mrZ2YmLAIp/Tucr6XPxMaoMD5af6mSALfbow
	 IfmIK0GLCqASgK/FyNVJqCzzPvf+vmAtGRpVfYZKQCMUuFUkYwMK5QIGn4It/FN4TJML1
	 onQDx2UlebYtsg++6SHelvxjRYZJSWhsZgPumoNQcEUdhGB65o4bVCM4RD9mzqyCJrim2
	 mak4g2B6MQvO6HR8yt0yW/P/6XFajotUaIN0F3xTN4E3DlvQB9oJLvRwZ72DFjSuaLe3I
	 qje7U5bF8G0WnD0xrpynlYYfsX7/3tey8Ef0Y7koNSFIFTi5osSSHlidRacGFRW4Bqg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAlfJTDX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793336045;
	bh=ypK+XpbXzqymYnMSICyxl78EYLPAEwkshdZws3ByR1E=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=INLL3t/gfzLLGEPnjIjfAVTMMl8bzX1tdlAeQAiz+IfEgZzoGc5wBGV1PJxCqYopp
	 ofUTkogRsMbVi4L8zgofuJinIXld3/CaNF7qVSDiPExcwA7utxwLcFLvJB35herjH6
	 u2VJ+Zu8bRwU7MJ/UUbNlgooJs/4DrvB/f1koLfHdDPfDsvq9VVeVnisjm8+Mpe/LR
	 lEIxeyTWUG6RE5lbga4gSmQDPaZB3IT8KSc2WaP7Q2uiIptIHQuIlLBBJhDveNE3sZ
	 db0eEGA9REtLdO3iFpY6pY8dVZXDQEMb1baVkphMojGgmwyCw8oQuvuUr8LB9i2S4i
	 OhzTlnlPTCqZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51FCB60A70;
	Fri, 30 Oct 2026 04:54:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A3EC21DE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8AA3560667
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gK5aDAaBuGEx for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 04:54:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A6F0D60A99
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793336041;
 b=ZWsEdXpfhlOCewoyruO1iyR/c3fKpN+9ENKoe84sJYTKfyDz5eJkUHbiCBimpGjdlrQT
 V+gtb84mXDeqBGsicX03zUWtsc8DYTcRvezHC7OVTLWUK9p7VzilE74Mzd2ks3xYLaI87
 8dOW5I0RsePax4BWwp4ig6aWzWvB+WeJSLuXu6dupbT25gkjLlBT2FHNGeq/m0ryuZ3w6
 EoivSZzVOEl552fY/k2bf84u0ikKMG4VgcDwqx9JGoZ6bdLaBWz4HT2yfCI4XMLi88Y56
 r1JKXPgvAohjfPwR6WfCvlvQHGd+whXU+YJsdhCDNlhdiPbVnhEmY0QwdEdhNeaNgeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793336041;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=ypK+XpbXzqymYnMSICyxl78EYLPAEwkshdZws3ByR1E=;
 b=cwI2x9KsdOyZGBxFIaox19wkxVPC/JEPaUsfoapJc8p6eQBSa/S6lHab2oaEk3RBL6X2
 co5mfbYYIHS5F2AzvyuPjuvWfDBbI+b1hGxBrel1FrzMSL5uHuETKq6tMB9nYK8AaVcZp
 PSuUOP6+fruKeMNnhXGEEM3ZNPFYzaUlPSwbjES74lE4c0nq6L/DCUFxYeNxGzX9HtUjQ
 mua/ETVAKV1CjmpQ838F1K8uy3jYwfk47noqsRQbU+NTZMksvep+9jiX8bpbwj0kOJbtz
 nYBXbr0900sPirQZsQiAm7g+5Uq8vNxvH22fNSEyNjhPrez47CUL4qvveGF/JrFliUA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OAlfJTDX; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=OAlfJTDX
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6F0D60A99
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E650543F2F;
 Fri, 30 Oct 2026 04:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11DC1F000C1;
 Fri, 30 Oct 2026 04:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793336040;
 bh=ypK+XpbXzqymYnMSICyxl78EYLPAEwkshdZws3ByR1E=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=OAlfJTDXriFUs3yEv1OZLsvdx5TKxTGeQOtJf5zbhw6pYyTdReH+/L/5iS+i02tX/
 B9d4IqzcFzP4DQNGthxhj6L9KQnG6c52QMmX1mcxNIAvw6eg3ISGjk25EhhNFHPYAH
 UHhglVaGE5VNyAN/WqtZ2oiTs94KkQAPnWp83X190xVq/M4+DPVCDHoCv8ioUJuJPN
 TTWhxojnC/EVpcx5Cxg8S1+og+2r+7k0W+r6y3njs0DXuMT+cDzEVerUTy374aBiP+
 opRqv0LvXEKqx0MYcNFjr0EPuD0WozNfLlHpGj6L75IFiQ7MGGlXDqT3BQqR1x90s2
 rZ+b6vIjgTnQA==
Message-ID: <sashiko-outbox-190394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 6/8] ixgbe: extract ixgbe_restart_auto_neg() to
 avoid code duplication
To: "Aleksandr Loktionov" <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20260508031226.3601800-7-aleksandr.loktionov@intel.com>
References: <20260508031226.3601800-7-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:00 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unchecked register read failures cause cross-register PHY corrupti=
on.
--

commit bb1b6f6954d948eeebea8f8bf0a9c8bd82cf6d54
Author: Jakub Chylkowski <jakubx.chylkowski@intel.com>

ixgbe: extract ixgbe_restart_auto_neg() to avoid code duplication

This commit factors out the PHY autonegotiation restart sequence into a
helper function to avoid code duplication. It also updates the sequence to
check the return value of read_reg() to avoid writing stale values on read
failure.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/e=
thernet/intel/ixgbe/ixgbe_phy.c
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
[ ... ]
> @@ -1089,6 +1089,26 @@ int ixgbe_mii_bus_init(struct ixgbe_hw *hw)
>  	return mdiobus_register(bus);
>  }
> =20
> +/**
> + * ixgbe_restart_auto_neg - restart PHY autonegotiation
> + * @hw: pointer to hardware structure
> + *
> + * Sets the restart autoneg bit in MDIO_CTRL1 to trigger a new
> + * autonegotiation cycle.
> + **/
> +static void ixgbe_restart_auto_neg(struct ixgbe_hw *hw)
> +{
> +	u16 autoneg_reg;
> +	int status;
> +
> +	status =3D hw->phy.ops.read_reg(hw, MDIO_CTRL1, MDIO_MMD_AN,
> +				      &autoneg_reg);
> +	if (status)
> +		return;
> +	autoneg_reg |=3D MDIO_AN_CTRL1_RESTART;
> +	hw->phy.ops.write_reg(hw, MDIO_CTRL1, MDIO_MMD_AN, autoneg_reg);
> +}

The commit message correctly notes that ignoring the read_reg() result can
cause a stale autoneg_reg value from a prior register access to be
unconditionally written back.

Since autoneg_reg is shared across multiple operations earlier in the caller
functions, does this same cross-register corruption still occur if one of
those prior reads fails?

For example, earlier in ixgbe_setup_phy_link_generic():

ixgbe_setup_phy_link_generic() {
        u16 autoneg_reg =3D IXGBE_MII_AUTONEG_REG;
        ...
        hw->phy.ops.read_reg(hw, MDIO_AN_10GBT_CTRL, MDIO_MMD_AN, &autoneg_=
reg);
        ...
        hw->phy.ops.write_reg(hw, MDIO_AN_10GBT_CTRL, MDIO_MMD_AN, autoneg_=
reg);

        hw->phy.ops.read_reg(hw, IXGBE_MII_AUTONEG_VENDOR_PROVISION_1_REG,
                             MDIO_MMD_AN, &autoneg_reg);
        ...
        hw->phy.ops.write_reg(hw, IXGBE_MII_AUTONEG_VENDOR_PROVISION_1_REG,
                              MDIO_MMD_AN, autoneg_reg);
        ...
}

If the second read fails, won't it retain the value read from
MDIO_AN_10GBT_CTRL and blindly write it into
IXGBE_MII_AUTONEG_VENDOR_PROVISION_1_REG?

Should these earlier register accesses also check the return value of
read_reg() to prevent similar corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031226.3601=
800-1-aleksandr.loktionov@intel.com?part=3D6
