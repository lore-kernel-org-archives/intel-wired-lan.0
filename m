Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482F606A321
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YWQAahjy;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6l1/6y3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E20581189;
	Wed, 11 Nov 2026 09:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uEEi9qN1Z3lW; Wed, 11 Nov 2026 09:44:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 98C1B811B6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794390259;
	b=f1T+gU9EcyO1VVSxfwmO1epMmFYQKanYnisUxi2VFgsWWe8Mq955Xa3lkrPyRyHhqoNG
	 047hTm9HujuCFGPYLfJEba0vwSQS7XhvLro+Lh5HUN4qYzOnABuoPr9mCO1faCWNMItAX
	 /YVK/Krwsad3KLQygHOtbhI7JmdJb451OR1Lu68huIn9avQUYoc2y8SvB4+JLB2MLW9OP
	 6Sxe9hT726cEQcjcP5yDAl0qp81kl24TjEhuZ2x8SR7NN5MbMcO8fTB6hHNajGbgos1J9
	 R1N0+WNYbhHKzdz9nvWreQmAQDu4hL/F+JVfKIzAg1XoTDkG9ySObachaDPzdBGOK5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794390259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=FWbJeJftKQHqnOgAXghvbIxdB1i6Btj768VsDXvEWCQ=;
	b=NC74u2LwFc+4ETUp71rSk+gxAH5Lu30katHd9tulLUqwG0D/fdF934HqE3fmY+C2CjVM
	 3debvS3qqiGkJBxjDn8fngYbufyj0or0u8UPjo4+FJJ1BsLupWGJyWHu+qE4RrC1kmu0U
	 W1i2b0e/h6D1oJe73HsKc7QjhNu7TuueTMgyur/Y817XqI5ukClynVvQRuSia43v5sJtW
	 vw9lTjhflgL0qI0sjIUQPttp0WOYW2F+9vDeyxSMUukxerSuSL6GGQiq/maSMspjei3CB
	 Vjmy1woJbGJBFdX9jeyH4jIUktwLA/SnFEfOVUR2/Vlt6TVnZBUfhGJTYoXz/65c8Vg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794390259;
	bh=FWbJeJftKQHqnOgAXghvbIxdB1i6Btj768VsDXvEWCQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=YWQAahjyA0izCosdduUr90VqH04ACaUbSnT9AiZwUNS5+cEtlrJZvXNwznVasZjXE
	 DJhtfVmcPnm8kEMS+sI4lCO+F+lPooRoDsU40JHnpHWf/h4AeB9wxVW5P53hgNFuzN
	 C3Cw6MBlEkaJoT4TcXl6wP/KVYO23tdLQ60jPOeJuzYYbKr5qeISE40qIUXWeZ7GHY
	 s+kklW9/ILptQnw7SabR9QO1GlC7RsEwcXOTI46H7Xz5IzRrDZfVLGHn9D+Pt5vGXY
	 mtQNGyLebrsbIesSIzGGZy1BptDYhur10ucy9Hv9JtYtH1EaojtZ//qi04sec/eTsr
	 ne2LKi+3b+AGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98C1B811B6;
	Wed, 11 Nov 2026 09:44:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DB3E28C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0286440318
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6wVo5oXUWQK for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 09:44:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0D29440070
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=e6l1/6y3
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D29440070
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:44:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A9CC611A1;
 Wed, 11 Nov 2026 09:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FFB1F00A05;
 Wed, 11 Nov 2026 09:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794390255;
 bh=FWbJeJftKQHqnOgAXghvbIxdB1i6Btj768VsDXvEWCQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e6l1/6y33fu740MbdUFrffQv66r2r3Xhv45yke1jynHEWIci1fYCwpksoCktrT58m
 phAYjQ7A5lFmAblLOj3yJT5/80VRsK3rpnh8lAsl2HipEe5OET0Y417a3+/C9jAtFt
 /VpzwXYUA8hw6cmGO+cA3H48mZG08LhDa8OEL/B9cAc5fILUewDy/7XgnjvEUJRN6z
 +hIR3AFmxyDHVJ+9x+Yo2AVnsPmppTYA91BfI2gSXJtVVpEkciV+cU2Qzf1KkfCO4D
 luCYuhVnWBkMeqAN48eoUpov768hMuKfj2lIdi1IRMfa9qW2Sgsb+hJCmSwQqR5lpB
 0PFFelPPuE10g==
Message-ID: <sashiko-outbox-208713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] ice: dpll: serialize changes of the SyncE CGU
 registers
To: "Ivan Vecera" <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261110094350.184185-2-ivecera@redhat.com>
References: <20261110094350.184185-1-ivecera@redhat.com>
 <20261110094350.184185-2-ivecera@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 09:44:15 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] ice: wrong port modulo in ice_tspll_bypass_mux_active_e825c()
  [1]
--

commit 54d93c3b2bb6d3588addc95fab52eae6473a669b
Author: Ivan Vecera <ivecera@redhat.com>

ice: dpll: serialize changes of the SyncE CGU registers

This commit adds a mutex to struct ice_adapter to serialize read-modify-wri=
te
updates to the shared E825C SyncE CGU registers R10 and R11 across PFs.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index 7980eaf9ce253..449819cf8c879 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1368,7 +1368,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool li=
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
This problem wasn't introduced by this patch, but does
ice_tspll_bypass_mux_active_e825c() compute the wrong port index when setti=
ng
active here [1]?

drivers/net/ethernet/intel/ice/ice_tspll.c:ice_tspll_bypass_mux_active_e825=
c() {
    ...
	if (active_clk =3D=3D port % hw->ptp.ports_per_phy +
			  ICE_CGU_BYPASS_MUX_OFFSET_E825C)
		*active =3D true;
    ...
}

ice_tspll_cfg_bypass_mux_e825c() programs the shared CGU mux with
port_num + ICE_CGU_BYPASS_MUX_OFFSET_E825C without reducing port_num modulo
ports_per_phy, and ice_dpll_rclk_update_e825c() checks it the same way.  On
dual-complex E825C, taking port % hw->ptp.ports_per_phy folds secondary
complex ports 4..7 onto 0..3, so a secondary complex port is never recogniz=
ed
as active when selected and is falsely treated as active when the
corresponding primary complex port is selected.

[1] https://sashiko.dev/#/bug/linux-800face2-554f-486e-9268-16b7de29259d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110094350.1841=
85-1-ivecera@redhat.com?part=3D1
