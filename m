Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EF0606A326
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=pdgcHNz8;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKXIYWZq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74E166065C;
	Wed, 25 Nov 2026 11:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IA-YJv1GvB58; Wed, 25 Nov 2026 11:20:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F3C1606BD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795605610;
	b=oAMw3pzqONvVqrpGh1OGo3w8EanpVzkMDJf521a57ZwgZTJ8tZGHTaL8ZEq1Zn/av+sn
	 LqxeSwZb3uDo1sKM4VQP/Pzg6oeW+CECpe+woackQlMq6AsFJ09uuXhjciLZRHXkz9pGY
	 tqXzquJ79LvO+Z+3Q95RfNpRa145aMxMJ89yq8edUMuk+TQ9ymzF4QxBy1D0bSUFGiP0H
	 lnWd4IVB9m3bAjAnpnKYB0p7g+UH8D6/UFiZIKGgYblkvhBozRp7Z8lULFByoNKWNEcw8
	 sLtOJwtEnz4TXDetEn10uRXLpZsnjGhutVfpVQttinDoASvv8AQuVnqrYkMaBjCVL5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795605610;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=8dAgV5pVEC2qlSvmNuiLPbcttaJHTx7j0Sz+N6eoQoo=;
	b=o8gp7erybvTlcX+zbpcCUN4w4J7rmoxnkg7a5Kdomhf4ic8Bub3o6kuqxNuYTE9EIY/b
	 BCW2nb0VDs9l5KFX4WxuacLzeKtyvCh7zE7efAZkq8KIkWyaXzy4BNsZT1oFUjAsaizVv
	 MZeIH31D5Korlbie5Cg6tpTrrNcVirU9u2/ijNN0bS6JTBgPyV6D6yUHGJQjnQSW7rJqD
	 Lfu1502IdK0v+EMvG50CrwA/1hJhLBxD9wO6KVLsp6FkV7w9Co9vbM4wspwtOEyUG/hLf
	 q/jlFl8QNVHb26gPWuIpV1a6zBpPS1+s4txIojQudhICu3VOpKjtUQ6GKfrWoByfIAg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795605610;
	bh=8dAgV5pVEC2qlSvmNuiLPbcttaJHTx7j0Sz+N6eoQoo=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=pdgcHNz8ZDWTKtUHc2NMAaw/77USXQ5pRq4iMvz1gl/YkQ56ObMA7GDJgHJXKsipn
	 PiEKc3Zb4VMiUp+5KC+v3uT1PzoDnXGHYSuc1LT7+/12mE2OLo11VcEfQBjBQNWxMh
	 YubBFIE4McNcOflUJQh2oAr/syv34UwP5WlDPhPt+RPorBNAEOa7YOfo84UldoDJSd
	 YiRxIPkSmXYpkSKvioLSQtb7x0WDB11wJcCrDR+X82Rk/H38vw+jk580dlQRVSy8+c
	 d2LRvis6TnkmvyH8MHLcfJKVti9u53c7WxI51/4AVmIZtGHO0OvpGuz2kdmud6x+YH
	 4v6ryV4s4tR+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F3C1606BD;
	Wed, 25 Nov 2026 11:20:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 480A7325
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 11:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DC2F40572
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 11:20:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bT8gO10Kl2Rd for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 11:20:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34FE940564
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=mKXIYWZq
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34FE940564
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 11:20:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C4C7400C6;
 Wed, 25 Nov 2026 11:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9251A1F000CA;
 Wed, 25 Nov 2026 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795605606;
 bh=8dAgV5pVEC2qlSvmNuiLPbcttaJHTx7j0Sz+N6eoQoo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=mKXIYWZqAmQdSml1OQOOhl4hAuGfQBVsWuTcDwNFlgMY/Y2Ox+mW1/saqaCm+tXwh
 RsCfHzzr3EWroCliItU5k4fJoEOJtky0VUkN5nZWT4cAjcon66rOdYSMh17I0m98lk
 e4E0i4MMS8jnCZLJIcEnLefs3ZhQogMZ8iygy58R44YiN0lmKBZ8KUg0nycfjnfMwV
 eDkJFQeV2C7EnFr7gM2YZddVOwTY44mSJR8PuQ5M4h1VKYwrFfOx0GkQYwpVxXEOvU
 KLE80gcqz8ZR61RRUB82Kq7JNzYkWxFJ+GWSEpVfu10LWlwTUINzHGsnehlnCWgoVQ
 anu9vF9LbDBLw==
Message-ID: <sashiko-outbox-233218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v2] ice: bound the CEE DCBX priority-group id
 before using it as a traffic-class index
To: "Minseok Kim" <kor8821@gmail.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261124112631.43172-1-kor8821@gmail.com>
References: <CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com>
 <20261124112631.43172-1-kor8821@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 11:20:06 +0000
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
- [Medium] ice: unbounded prio_table in ice_cee_to_dcb_cfg() on
  ICE_CEE_PGID_STRICT
- [Low] ice: Fixes trailer cites consumer commit instead of CEE DCB
  parser commits
--

commit f657c73bb29d7266856c212fb6404876509d250c
Author: Minseok Kim <kor8821@gmail.com>

> ice: bound the CEE DCBX priority-group id before using it as a traffic-cl=
ass index
>
> The CEE DCBX priority-group ID (PGID) is a four-bit wire field spanning
> 0..15, whereas prio_table[] is sized to ICE_MAX_TRAFFIC_CLASS (8):
>
>   #define ICE_CEE_PGID_PRIO_0_M  (0xF << ICE_CEE_PGID_PRIO_0_S)
>   #define ICE_CEE_PGID_PRIO_1_M  (0xF << ICE_CEE_PGID_PRIO_1_S)
>
> The IEEE ETS parser in ice_dcb.c masks the equivalent nibble field with
> 0x7 (ICE_IEEE_ETS_PRIO_{0,1}_M) so it cannot exceed 7, whereas neither
> CEE path bounds the value.
>
> In the wire LLDP TLV path, ice_parse_cee_pgcfg_tlv() extracts each
> nibble into prio_table[i] and inspects it to select tsatable[i], but
> never rewrites prio_table[i], leaving values 8..15 intact -- including
> the defined sentinel ICE_CEE_PGID_STRICT (15).  In the firmware AQ path,
> ice_cee_to_dcb_cfg() remaps only ICE_CEE_PGID_STRICT to oper_num_tc - 1
> and lets values 8..14 fall through untouched.
>
> Downstream consumers then use prio_table[i] directly as a traffic-class
> index:
>
> - ice_vc_get_qos_caps() (virt/virtchnl.c) indexes local array
>   u8 tc_prio[ICE_MAX_TRAFFIC_CLASS] via tc_prio[tc] |=3D BIT(i), writing
>   past the end of the stack array when tc >=3D 8.
> - ice_dcb_tc_contig() (ice_dcb_lib.c) accumulates used_tc |=3D
>   BIT(prio_table[i]) into a u8; for values >=3D 8, BIT() is >=3D 0x100 and
>   truncates to zero, causing the contiguity check to pass silently.
> - ice_vsi_cfg_netdev_tc() (ice_lib.c) indexes
>   vsi->tc_cfg.tc_info[ets_tc].netdev_tc with ets_tc =3D prio_table[i],
>   reading past the end of tc_info[].
>
> The driver already enforces this invariant when writing prio_table[] in
> ice_dcbnl_set_pg_tc_cfg_tx() and at the VF trust boundary in
> ice_vc_cfg_q_bw().  Bounding the PGID at CEE ingest enforces the
> invariant at a single boundary and prevents the u8 BIT() truncation in
> ice_dcb_tc_contig() that per-array bounds checks would miss.
>
> Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size co=
nfiguration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minseok Kim <kor8821@gmail.com>

[Severity: Low]
015307754a19 ("ice: Support VF queue rate limit and quanta size
configuration") only added the ice_vc_get_qos_caps() consumer in v6.13.
The unbounded CEE PGID parsing in ice_parse_cee_pgcfg_tlv() and
ice_cee_to_dcb_cfg() goes back to 0ebd3ff13cca ("ice: Add code for DCB
initialization part 2/4") and d24ef08a9d94 ("ice: Deduce TSA value from
the priority value in the CEE mode"), and consumers such as
ice_vsi_cfg_netdev_tc() and ice_dcb_tc_contig() predate 015307754a19 by
several years.  Should the Fixes: tag reference 0ebd3ff13cca ("ice: Add
code for DCB initialization part 2/4") so older stable trees pick up the
fix as well?

> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ether=
net/intel/ice/ice_dcb.c
> index abea84f146583..a36458b01fc21 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb.c

[ ... ]

> @@ -805,6 +814,10 @@ ice_cee_to_dcb_cfg(struct ice_aqc_get_cee_dcb_cfg_re=
sp *cee_cfg,
>  			/* Map it to next empty TC */
>  			dcbcfg->etscfg.prio_table[i] =3D cee_cfg->oper_num_tc - 1;
>  			dcbcfg->etscfg.tsatable[i] =3D ICE_IEEE_TSA_STRICT;
> +		} else if (dcbcfg->etscfg.prio_table[i] >=3D
> +			   ICE_MAX_TRAFFIC_CLASS) {
> +			dcbcfg->etscfg.prio_table[i] =3D 0;
> +			dcbcfg->etscfg.tsatable[i] =3D ICE_IEEE_TSA_ETS;
>  		} else {
>  			dcbcfg->etscfg.tsatable[i] =3D ICE_IEEE_TSA_ETS;
>  		}

[Severity: Medium]
Can dcbcfg->etscfg.prio_table[i] still exceed ICE_MAX_TRAFFIC_CLASS - 1 on
the ICE_CEE_PGID_STRICT branch?

When prio_table[i] is ICE_CEE_PGID_STRICT, it is set to
cee_cfg->oper_num_tc - 1 and the new else-if bounds check is skipped.  If
cee_cfg->oper_num_tc is 0 (underflowing to 255) or greater than
ICE_MAX_TRAFFIC_CLASS, prio_table[i] remains out of bounds for downstream
consumers such as ice_vc_get_qos_caps() indexing
tc_prio[ICE_MAX_TRAFFIC_CLASS] on the stack.  Clamping prio_table[i] after
the if/else block, as done in ice_parse_cee_pgcfg_tlv(), would cover both
paths.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124112631.4317=
2-1-kor8821@gmail.com?part=3D1
