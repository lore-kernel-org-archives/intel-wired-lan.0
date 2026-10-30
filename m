Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC7606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=CFa0Z9ox;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XW00FVnK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B1AB60AA8;
	Fri, 30 Oct 2026 04:54:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B_dhxYlw_Umc; Fri, 30 Oct 2026 04:54:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 72EDB60AAC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793336052;
	b=I59+05OX6hB13N6JTS/RRR74xVy+hE9lsCXJ384QyiQsZF07ovlGqns3yIt7prcbqpC+
	 4e4b+8MBpVnnDRuiT0DlvmTcv+FvzDab+jAIFRHCoKxtiTmjS44K5ukHYuso/+irZhxCh
	 aMnjb+x73FBTYOSOwPHvtmobbTLy5iSR52ndhZZ7dNZ/cViPfTOFon1TsxQ2F/hSYUmF6
	 Krj2ncPokR6dK79Q0106doPyQH/zNzAij7to+1XlPXnZwOCWbiuS2BTPp/QbyfCns0X6t
	 z0jVBlDabfvHfBdodsDbhiQRa/midGsVEnMJnH+Vntj6iysz4o2X9UhGiqHbE/gDAxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793336052;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=mFlnYRXt6kkYCz7qLsrR0bZ97Ul4eAtWvFF8Ha2RNnM=;
	b=ZNql/ywf8LBXumVHCNsXX7tS09yhgjeQ5gqjlyRY8+wAvJU4N6mCC4uhOIn2Rn6ary32
	 8CEOP819SZAX8MqT71pFuB+70jYoGJ8CJr6/ln4bK7d0u0eJCPYylqi+vNJHsDbzurelP
	 nbd5TUVdK2GbHfAcS/mXYjMVtWUkwHjmoU2lTz/MPvepb3ONNCMrj0LMBRqiGNUITKpR+
	 rU154NZwEWmA8wHVX90nt9yFrF/1+/zO/GsjYEf/kLp5sYKWDLvlYhAlCB/oa3zy0SZui
	 B4Cmf8POaPl9ivom+VisB2JVbrKXRiUYx32+sjAy4TbCn2TwcKYlFQ/fXvq8pVbWPRg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793336052;
	bh=mFlnYRXt6kkYCz7qLsrR0bZ97Ul4eAtWvFF8Ha2RNnM=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=CFa0Z9oxSjzfl32sqcfHArqW0cmzCuHW1qOlEjMMoJO9/qtPf5DEtQMr1lD+6FhOt
	 uZ0uJ9fRhH9IArnfufK/HAq2ExqvAVU+D3Iqkb4ZmbKXGcu6nxx1oIrt1bpL7dtZyR
	 vNjsI2YlZeYhI77CcqlOWAEO0oE3rUOA1c+8Y3i7YOiOvqGtQe7mvF9NI2CEjM75yt
	 wBhH7yBfZkIBKtI8K0p1Imm1xUgeyMHYdygZdFpSckzpF+0zqO1tqpZ9PHE5zDq1g+
	 1bILn5DL/pUun+zbymWczp+ZSYhv/5xs4n/g+/neIFqbIE4az8kBRQxUCaL1+GmQwo
	 BWFkl/Qn2ZuPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72EDB60AAC;
	Fri, 30 Oct 2026 04:54:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F4ECD38
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 75D754051A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JyUlhJBFFIy0 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 04:54:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 830B6402F6
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793336047;
 b=U+AhXhKvRP/0/ProAckO7cpk8GpxUvLSe7XvblhB/EYrOXObReXyT5oKcK9F5Ysj3DvN
 PzxPfPbmjR0df9sAGGRVdedATGB+pa/gRwtPuotG2ZQ8FhehnW60Ban0Th6PbUqfw5w9Y
 F38LGCltPy3oQ7+XC8uYvN3V3Xjjoajomi3wTROjIGayOr92WMvHaPV/q2mrYfU+DqHlj
 PqVR0o07xX6+sZkAhz7uH2ie+OGctd7qbXIiDy81a7RPj2czs4Lb1OU6cAkYFYMs2XQYI
 351v/wzPMLv+kiN+6HPoH66bJqJLnMTtik27637rMg1rBJAKGosVGoMZl9n12hzF62w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793336047;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=mFlnYRXt6kkYCz7qLsrR0bZ97Ul4eAtWvFF8Ha2RNnM=;
 b=mCsprMpQRzkbkwjKEU06fiBJpkgxDsXyePwERxipWJMGieNEDPRAA9w4hNIv3ape53YA
 MuLhekTLaM7sELpmG38BjvFuh/S6iBUhS4vch6KWE1G87D29WR94DmEOOzVHMeetFBziA
 HzDRSrq0bzkX7V97k1HrqZEUuO+HkEZxrREjd1S6lUYG7P8gY/tlIHzlLRpk4kso/slLK
 R/wrb/lWpe2Jm8+Wma5pImzToU3EXONZkUchu2FXZhH7gCUGJHGJWyjhRCmhCoqd/hgGL
 od88zqdZAuaP/I/aOFbBoA7L9R4DVMurhnsus+mfnPruCItlDRjA6KuJw6yED9ai5Sg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XW00FVnK; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=XW00FVnK
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 830B6402F6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD08443F42;
 Fri, 30 Oct 2026 04:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBF81F000C1;
 Fri, 30 Oct 2026 04:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793336046;
 bh=mFlnYRXt6kkYCz7qLsrR0bZ97Ul4eAtWvFF8Ha2RNnM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=XW00FVnKmO1yj/aznMw3gJLEtGfaOiQxNdlwyaAHP7vW8fX8dSjpzACFeDkR8ICef
 dZq0OCKiAwd471ceSdjMqTU0VejXqUECLVetN772mYgzWee7W6ufAJwm6LTjmdF1Jd
 +XsQWH3z7ftDvBd2rmTPyq34R5C4phqlkKr//mfTYrv1bh9x+E25G2Pk3DNzKO6pCT
 3hqt39qFZfNVEwC1tAsN2fAArzRoNguotUmtVCZnl/eMKOl916R2LuVg9Ha3cBmb4V
 sNdW/Oao5pGHq5kOEEC1G9+eFw1yvqh7HYtOnbi4THKiZTXXHk++xI50irIvHRiq6m
 WpGopReSr+4ZA==
Message-ID: <sashiko-outbox-190402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 net-next 8/9] octeontx2: cn20k: Respect NPC MCAM
 X2/X4 profile in flows and DFT alloc
To: "Ratheesh Kannoth" <rkannoth@marvell.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org
In-Reply-To: <20260508034912.4082520-9-rkannoth@marvell.com>
References: <20260508034912.4082520-9-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:06 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The primary default rule allocation still hardcodes X2 keys and un=
masked reference indices, completely ignoring the X4 hardware profile for P=
Fs and successful VF attempts.
- [Medium] Caching device-specific hardware profile information in a global=
 static variable causes a data race across concurrent device instances.
--

commit 0a14e92cf2754f6d4cb9d8447914740b55c1a43e
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: cn20k: Respect NPC MCAM X2/X4 profile in flows and DFT alloc

This commit updates the default CN20K NPC rule allocation and flow-install=
=20
path to respect the active MCAM keyword width, dynamically selecting X2 or =
X4=20
and masking reference indices accordingly. It caches the profile informatio=
n=20
on the PF.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/driv=
ers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 67dfbe5ca903f..15b3f29d60ee9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> @@ -4467,11 +4467,18 @@ int npc_cn20k_dft_rules_alloc(struct rvu *rvu, u1=
6 pcifunc)
>  	 * as NPC_DFT_RULE_PRIO - 1 (higher hw priority)
>  	 */
>  	req.contig =3D false;
> -	req.kw_type =3D NPC_MCAM_KEY_X2;
>  	req.count =3D cnt;
>  	req.hdr.pcifunc =3D pcifunc;
>  	req.ref_prio =3D NPC_MCAM_LOWER_PRIO;
> -	req.ref_entry =3D eidx + 1;
> +
> +	if (npc_priv.kw =3D=3D NPC_MCAM_KEY_X4) {
> +		req.kw_type =3D NPC_MCAM_KEY_X4;
> +		req.ref_entry =3D eidx & (npc_priv.bank_depth - 1);
> +	} else {
> +		req.kw_type =3D NPC_MCAM_KEY_X2;
> +		req.ref_entry =3D eidx;
> +	}
> +

Does the initial allocation attempt unconditionally hardcode X2 keys?

Looking at the code just above this fallback path in
npc_cn20k_dft_rules_alloc(), the primary allocation hardcodes the key type:

    req.contig =3D false;
    req.ref_prio =3D NPC_MCAM_HIGHER_PRIO;
    req.ref_entry =3D eidx;
    req.kw_type =3D NPC_MCAM_KEY_X2;
    ...
    ret =3D rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &req, &rsp);

If this first attempt succeeds, VFs might incorrectly get assigned X2 rules
on X4 silicon. Since PFs bypass the fallback path entirely if this fails,
will PF default rule allocation fail completely on X4 profiles?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/dr=
ivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 38cc539d724d8..5dd0591fed999 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> @@ -37,14 +37,13 @@ static void otx2_clear_ntuple_flow_info(struct otx2_n=
ic *pfvf, struct otx2_flow_
>  	flow_cfg->max_flows =3D 0;
>  }
> =20
> -static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
> -				  u16 *x4_slots)
> +static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, u16 *x4_slots, =
u8 *kw_type)
>  {
>  	struct npc_get_pfl_info_rsp *rsp;
>  	struct msg_req *req;
>  	static struct {
>  		bool is_set;
> -		bool is_x2;
> +		u8 kw_type;
>  		u16 x4_slots;
>  	} pfl_info;

Does caching this profile information in a static structure cause a data
race across concurrent device instances?

The accesses to this shared cache are protected by mutex_lock(&pfvf->mbox.l=
ock).
Since this is a per-device instance lock, multiple network devices could
concurrently acquire their own independent locks and read or write the shar=
ed
pfl_info structure.

Could this lack of synchronization lead to torn reads, such as reading x4_s=
lots
as 0 if the compiler reorders the write to is_set before x4_slots?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508034912.4082=
520-1-rkannoth@marvell.com?part=3D8
