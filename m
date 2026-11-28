Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A4606A31C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=SHHttNr0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPDZmdgE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7BBB80C8B;
	Sat, 28 Nov 2026 08:58:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7s_Pg3-4uwXv; Sat, 28 Nov 2026 08:58:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0DDA980C9A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795856298;
	b=Iw4LbvS/IFvCQXXYIg0m8aEqhIQHfIlTG3cg83n67r5zoUQjEkIwiO2SLuJ1WXglNoW7
	 sS5DntJSsOv47nwLIDFNdW9CmFkwebUgEc+0/R/rERzL1ZrCQqa/yY1mt7Zakum5wTpt+
	 X0SawSIcXRPlSkOOpCVgAdYiZbDHqCFMbhKiMtndofGzrGZT2Xm8hmvf+l+GFCQMADMEl
	 SxklHKkOcXRkblHBwLWJ5LmpIn5zhUIrFshZFoODSs6GIhzI8t9VZ6/SEb7HHawus+BsJ
	 Mpl5d6VocsC10/x8qGryMf0+CigsIMdCFnOWRYLRYd/5wsqFyzWdm6nNhsOe1rl1A1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795856298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=j2a2zgbrxxp/wNyUxM98vxcrdjJQnVyv3jV6feqIx5Y=;
	b=s0NPwg9QAzUP5K3OL7LSjt8Wx/1aJrq+3+xRoecFt2R9aTE/HEKI9v5vvjjILOtYy464
	 MYW0YeQsJFCVnEEQRad07jh2E/9w0HFOFGiP2C+wWeaXDi8EA8H3b5m45xKEDXW6MtIvi
	 MdSP+d6Awqqjq1puIV9bCLe/Af2OIv4kqNEVZLYhPEeI6UPj7qkQQN/S6qRdyVcTN8Z4i
	 XcRDtiUeYu7KG0tFtrSR3Bq67nkqJbXoLWrvgoyMNDhXAl0jNiiIagK9Mkxzx26nvFIpe
	 INyeGkVW3n1WLli1VyTpdS1msICKQbTjL5UmW7J9xomBVW8DvugVm3KBwoLzm7KJxAA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795856298;
	bh=j2a2zgbrxxp/wNyUxM98vxcrdjJQnVyv3jV6feqIx5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=SHHttNr0VD5xjrZJQVcpna7LZroRGoEIChdffrQ/cLj/yW2kcUxmLtMbtoWsCg0dF
	 KFDPV/Lkl4c0yvTliKFe+tJZLTS8js/4Rb7OjmgcCPswfALtKkN7H1wCetwfS4WT4U
	 vGCDA5LqVTCYD0aTZAk589EgC4sKBAz8y4Zj9yd4J71WB0l9WflUZvR0umxM0UN8zh
	 5AQfzsswZpnNMOwEk1GWNymSjvWU+ZLhljbBO8KOT2ZkP9sbRSuuA1rIYLHqJ4DoFl
	 vCS5uzaJQRKvlTed3NDPbzUzGuMhYbI6hj9hxyBHnoNkQgt2pvzsF6JYh5H4ypAlWE
	 CwGFIYclT1y+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DDA980C9A;
	Sat, 28 Nov 2026 08:58:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA0CE3C0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 08:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DBEC5408CD
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 08:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i-FRi2XjWHgw for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 08:58:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C648E40652
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UPDZmdgE
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C648E40652
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 08:58:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3161C60252;
 Sat, 28 Nov 2026 08:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86C31F00893;
 Sat, 28 Nov 2026 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795856293;
 bh=j2a2zgbrxxp/wNyUxM98vxcrdjJQnVyv3jV6feqIx5Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UPDZmdgEuKj4w51ZUiE2McD6F8CnEkYrcPGjGGI3OF0wyNDHaNMlhxFKg+00jAAvA
 wsg2Gzlq7fz8I/3+Ix9WVW7jxypI3FHLHkjM9Bd3VYlGb2D3Rt8H6GKratuaNYLhWQ
 ZebD3dUtumxtN3gJg5W3d0wG5Fuy1alRTzk/1fxxHNGLlFkGmSarubrqTvIR0K9S//
 HoR5Y6RRYtGcJ1frtZsddQMqb4Gg5JCxxu0fXNK207Li+WM6qieUlQIkosecMq6oWt
 i/8IMboCl1HOkjyy1a95FtyYhiQmY4orCd3ngZ4Jv5v7uc804IZ88E86nsB4yK0qyc
 Zf7uMfK2k3JuQ==
Message-ID: <sashiko-outbox-238568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 3/4] ice: resync uplink filters after a switchdev
 session
To: "Petr Oros" <poros@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261127085714.1207361-4-poros@redhat.com>
References: <20261127085714.1207361-1-poros@redhat.com>
 <20261127085714.1207361-4-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 08:58:13 +0000
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
- [High] ice: ice_vsi_sync_fltr() re-adds uplink MAC filters during
  switchdev
--

commit edb8f55bf97ab7c6c15ad8258647b17f2ec38996
Author: Petr Oros <poros@redhat.com>

ice: resync uplink filters after a switchdev session

This commit adds ICE_VSI_ESWITCH_UPLINK to keep ice_vsi_sync_fltr() from
modifying the uplink promiscuous configuration during a switchdev session,
and schedules a filter resync when the session ends.

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/e=
thernet/intel/ice/ice_eswitch.c
> index c96b201901f48..d55c70edb7f7f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
[ ... ]
> @@ -28,6 +56,12 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
>  		if (ice_down(uplink_vsi))
>  			return -ENODEV;
> =20
> +	/* the eswitch owns the uplink promisc config until the resync */
> +	while (test_and_set_bit(ICE_CFG_BUSY, uplink_vsi->state))
> +		usleep_range(1000, 2000);
> +	set_bit(ICE_VSI_ESWITCH_UPLINK, uplink_vsi->state);
> +	clear_bit_unlock(ICE_CFG_BUSY, uplink_vsi->state);
> +
>  	ice_remove_vsi_fltr(&pf->hw, uplink_vsi->idx);
>  	ice_vsi_cfg_sw_lldp(uplink_vsi, true, false);
[ ... ]
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index 6dede87b78944..2ce2b7138f668 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -394,6 +394,10 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>  		}
>  	}
>  	err =3D 0;
> +	/* the eswitch owns the uplink promisc config during a session */
> +	if (test_bit(ICE_VSI_ESWITCH_UPLINK, vsi->state))
> +		goto exit;
> +
>  	/* check for changes in promiscuous modes */
>  	if (changed_flags & IFF_ALLMULTI) {
>  		if (vsi->current_netdev_flags & IFF_ALLMULTI) {

[Severity: High]
Does checking ICE_VSI_ESWITCH_UPLINK after the MAC filter sync block allow
ice_vsi_sync_fltr() to re-install the uplink's unicast and multicast MAC
filters during a switchdev session?

When ice_eswitch_enable_switchdev() calls ice_eswitch_setup_env() while the
uplink netdev is up, pf->eswitch.is_running is still false.  At the end of
ice_eswitch_setup_env(), ice_up(uplink_vsi) calls ice_vsi_cfg_lan() ->
ice_set_rx_mode(), which sees ice_is_switchdev_running() =3D=3D false and
schedules a filter sync with ICE_VSI_UMAC_FLTR_CHANGED and
ICE_VSI_MMAC_FLTR_CHANGED set.

When ice_vsi_sync_fltr() runs for uplink_vsi, it executes __dev_uc_sync(),
__dev_mc_sync() and ice_fltr_add_mac_list() before reaching the
ICE_VSI_ESWITCH_UPLINK check, re-adding all the MAC filters that
ice_eswitch_setup_env() just removed and unsynced.  Because
pf->eswitch.is_running is then set to true, later address removals on the
uplink are ignored by ice_set_rx_mode(), leaving stale MAC rules in
hardware for the rest of the session (with multicast MAC rules also
overriding the lower-priority switchdev default Tx rule).  It also updates
vsi->current_netdev_flags =3D vsi->netdev->flags before the check, and in
ice_eswitch_setup_env() releasing ICE_CFG_BUSY before ice_remove_vsi_fltr()
and __dev_uc_unsync()/__dev_mc_unsync() lets an already-queued
ice_vsi_sync_fltr() race with filter removal.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127085714.1207=
361-1-poros@redhat.com?part=3D3
