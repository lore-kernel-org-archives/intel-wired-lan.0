Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737E606A68E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 21 Nov 2026 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=c8HmBYTN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1lc2L+W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FC6D60622;
	Sat, 21 Nov 2026 03:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7BFzvcqW_FLQ; Sat, 21 Nov 2026 03:39:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 78D766065D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795232366;
	b=XQpPNpw+zsinYXVrgl6nh3v1rVSbcnhJRzSuXw/J/5uETJoXyQbjCKHn64sokF+x2YRa
	 E9JbUEBms/bDTIZJTDTyt1FHIX478XC1NJ+MYhEz+bzanUqTxdeBMUvnXeI0gSx+x4OPi
	 cxLDrreyFokPV90jYhtpvd/9dL+zjQlekBHg8ID450oErYn0Q5CHiNVJ3TduepZqEI1bO
	 C9+VRqqdcBjr3/qlKwsdoBASUboa8XreBYr6B3z0Kpzi0qk5EBSHO0EBs16Cr3asI9JfR
	 vkMe+rTIvcsaesHBW0VVMyCINv94x1JixsJvuAIacoG+VHyk3gb1TzMfmN3ZSezNlDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795232366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Filp+jPnB4LdLSs5oUY8qShYJmbqQLLCmqTweTdfRXY=;
	b=AMIwH9e1llheAPf+wV8k9Jbtl35KuLcYcq1L0LFABAtKvvfMatp+qosp+hTT2f/K6/lN
	 udTOizGiS2K+1asKOHmCz5C4ovcoS3sCf07T5Gmch0Df9bwXBcsdlZm+jtgl2zcQianR7
	 u1ZqfcKve+KF+M4p52vKS/A3NX9PZDMOD1JwrgtIaMV0Qb2dBgYU7TtCPBHl7+KGq0EZE
	 RgF7yCIDtFzgYEiWTY7YWIBPoO0Ctba1x/dqHgyIpqu7bo/MTzbWjZTIWO9FjXMh2T72b
	 ndzdbQbG8YSwLIfRVx+PbhHx6ogJPN1nyrScQMkqMi/luf57dSimnrI96ml7wAbyWpw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795232366;
	bh=Filp+jPnB4LdLSs5oUY8qShYJmbqQLLCmqTweTdfRXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=c8HmBYTNkoW9HqiszQ9vHDvDLNUUcMSoAiU6DAPTby4N4RqwHxbW2bV+CE+jS1hru
	 XCxBgy6rVYWYuF2YHEbKjcWdgD15z6ToBOmspja0HzwPov+0SQy7d8a+sIcOQw3uIG
	 pJIUdSfue5O8veXqEyHRhtUPYxb+F8rcfzRvdLs/8QIKBIwwAf3Nlgo1fMo/bDE8oe
	 kn2rAX65e8HjzxcA+gnkwH5B23AbHyFgNxD58wrBtzADUaSO3Stq3IUzm9C5pdahnk
	 xQYEyh5wJ4e4fiqP3aKuRya0ztByuTgoVSKuVBgtX097EakxSfsn2HEmixXRmQ6xsu
	 IxKSYrxCJsxPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78D766065D;
	Sat, 21 Nov 2026 03:39:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 167EB1C9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 03:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0EEC40A79
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 03:39:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7hB07A2eRA7M for <intel-wired-lan@lists.osuosl.org>;
 Sat, 21 Nov 2026 03:39:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03D5E40971
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=M1lc2L+W
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03D5E40971
 for <intel-wired-lan@lists.osuosl.org>; Sat, 21 Nov 2026 03:39:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A366E406BD;
 Sat, 21 Nov 2026 03:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724BA1F000C0;
 Sat, 21 Nov 2026 03:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795232362;
 bh=Filp+jPnB4LdLSs5oUY8qShYJmbqQLLCmqTweTdfRXY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M1lc2L+WzMyvcB7e+TdHv5h3dh1gX8ZMPu6sDM7jnle9KfvpJ3zIZduu0N+DqVcFk
 1f+d4grF5eVhlYA+QXs4ufCoghHEM12fMo8LRWZ0f1dz8xPcUM1zDPf6ZXLXksqSZt
 PoKZ+KPtSNssatYC7vVtMo3ROokrogutUhomXIzFA64+Nv2uf8iztRx+0Rw/2Nah4O
 RaKTou4p+TcVrE/lhlmCAphSnQmb8F3GSQUUftXK8SHzTzn8YmjmYfRdhhkI3BWicZ
 LH6yviqbzdWvAEDVhSaei1rCt0hmXgqn3yXR9FsYfQ3WJ1C3AqKVGPS8TPICT1bkcD
 pl3tuUr5w7IyA==
Message-ID: <sashiko-outbox-226595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net] ice: hold a VF reference while creating LAG
 placeholder VSIs
To: "Changyul Lee" <lcy8047@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261120033910.1731258-1-lcy8047@gmail.com>
References: <20261120033910.1731258-1-lcy8047@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:39:22 +0000
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
- [High] ice: UAF on placeholder VSI nvsi->vf after ice_put_vf() in
  ice_lag_monitor_act_act()
--

commit 78df21de98f414a15f945d5648335b162e30040a
Author: Changyul Lee <lcy8047@gmail.com>

ice: hold a VF reference while creating LAG placeholder VSIs

This commit replaces the ice_for_each_vf() walk in
ice_lag_monitor_act_act() with an indexed lookup via ice_get_vf_by_id()
and ice_put_vf() so a VF reference is held while creating secondary PF
placeholder VSIs.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ether=
net/intel/ice/ice_lag.c
> index c4b8af01e2af0..e0803c2a3e8cd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -1913,18 +1913,24 @@ static void ice_lag_monitor_act_act(struct ice_la=
g *lag,
>  				struct ice_vsi_cfg_params params =3D {};
>  				struct ice_vsi *nvsi;
>  				struct ice_vf *vf;
> -				unsigned int bkt;
> =20
>  				params.type =3D ICE_VSI_VF;
>  				params.port_info =3D event_pf->hw.port_info;
>  				params.flags =3D ICE_VSI_FLAG_INIT;
> =20
> -				ice_for_each_vf(lag->pf, bkt, vf) {
> +				for (u16 vf_id =3D 0;
> +				     vf_id < lag->pf->vfs.num_supported;
> +				     vf_id++) {
> +					vf =3D ice_get_vf_by_id(lag->pf, vf_id);
> +					if (!vf)
> +						continue;
> +
>  					params.vf =3D vf;
>  					nvsi =3D ice_vsi_setup(event_pf,
>  							     &params);
>  					ice_lag_aa_clear_spoof(nvsi);
>  					lag->sec_vf[vf->vf_id] =3D nvsi;
> +					ice_put_vf(vf);
>  				}
>  			}

[Severity: High]
Does dropping the VF reference right after ice_vsi_setup() leave
nvsi->vf dangling if SR-IOV is disabled before the bond unlinks?

ice_vsi_setup() copies params.vf into nvsi->vf without taking its own
reference, and ice_free_vfs() drops the VF table references and frees
struct ice_vf without releasing lag->sec_vf[].  When the bond later
unlinks, ice_lag_changeupper_event() calls ice_vsi_release() on
lag->sec_vf[i], which dereferences the freed nvsi->vf in
ice_vf_is_lldp_ena(vsi->vf) and ice_vsi_delete_from_hw() ->
vsi->vf->vf_id.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120033910.1731=
258-1-lcy8047@gmail.com?part=3D1
