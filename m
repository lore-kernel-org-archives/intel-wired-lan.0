Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55589606A32D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qWEiCjQM;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mR5WbqzS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F42C409EB;
	Fri, 13 Nov 2026 16:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0DR2BtXjA9b6; Fri, 13 Nov 2026 16:31:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5CF0B409EE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794587498;
	b=oc/ZixkBnuGkGebiMNQQj2xbWuyIY9+1ejF8ZJpZ05M9tRDnfx4Z8ewYw01h8SOhJK1V
	 v1HZpba4aW3rIWxpXj6JYrcJ0Xy020Zotif0tzD5ZU3RNwfH05XkQZ089MJ+IFccBOcF6
	 Vej5G9fZp/QQSeLVALE3mDpL8LIdSYqCFkbJ8t12X3G45opMAhzMov+bG7kJl6+gpOUJG
	 F4U9Bll8AU9AURrKCWcWQ8xblkETy4KAC9+/fibWMZXzjoDuI29OKvDCFQZFCEXQOZ+Ly
	 PtAvcXnakWM2eqbQD6BYHJsfOMMoWRUg4Og8x63u5WDoA16ospd7fNGTVyiHetrlwGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794587498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=GkCuQWVjzLDZhrbp/M56DpWISq4wF7M+9XoCG0i4d8Y=;
	b=cxAqns+xPCvN9K1HsS06Kk8DOsj1wX0LiCKwKMXm/xJG0a4+QcsKPa7CBfgIs95fiMhR
	 leDqkPwzOFwrK3CvI5xzYqRhu1xNr8+KSv2gStRumb99oEVNJLpJ2t6JWh8+/o2h26ucX
	 NuoSXXOk0BD4eOWQzkVVrp7LVKNQUOPt6W52IdtyxiS3F+3T0/ac6LpWhytNbjDFVxYd2
	 6KLuc/eb2DYiaI5lK45aVeB2EEGHh+md+M6ZZOzKr0wYlZ8aJnDdB6iW1yFAP1SNlgdfj
	 YT6UWCYZINZoy8nUcwJvmQwW52hV/0d1/XVoLGX7ojdU4Ah41J+4JRtXau05fkT7ByQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794587498;
	bh=GkCuQWVjzLDZhrbp/M56DpWISq4wF7M+9XoCG0i4d8Y=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=qWEiCjQMEI8M9tZVwUqvvJEjfU470JcrBu1WWrgKfsf+Nl773Nb/cte38FxBZB6rB
	 q8mJ2wTB9AGYMdd03Tkyn+CCi1c1bozr7ZoG7JlygXv/fu3rIIynT9kDFe7HdQ8a1G
	 ROOdPNksxXhjrzvmMm2cre0kjo5lUu8BdZiPR4Xqgk2QcH3JtPseyUfovt2Zdp5AIy
	 XzQLFTOXEqz/a5TKlobc0zwUrEcStTRWPnaTM47DuG9QkjV9nIZsnKd/h9Dm/bY1Ch
	 QrgFe/VfTUimyZvEn9J0JFAnkrBB116Vyb0n9G81lLt9OKzhpBy2b0GDNVojfFbu/7
	 nWbVLbTpIx/0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CF0B409EE;
	Fri, 13 Nov 2026 16:31:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DBCF2FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EA2B81567
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VceSVZbKJF0n for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 16:31:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3EA8D81467
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mR5WbqzS
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EA8D81467
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 16:31:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74F446281B;
 Fri, 13 Nov 2026 16:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812791F000C4;
 Fri, 13 Nov 2026 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794587493;
 bh=GkCuQWVjzLDZhrbp/M56DpWISq4wF7M+9XoCG0i4d8Y=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=mR5WbqzSuzvJ8UCZ3EYEpY8DjHwRYNsug2pDEmIGzjPVXSEuiHBHleZfJbyw8eMN6
 kvBPTlyPaGuNOco6AfBAmBXzarRgg2z+sQYIOzTeEBiPEVEO49u8u8SK3zUyYV8nNJ
 qBSqayCAPeGlgLpGHriWjLFfybefAgHAjUl7n9GnP3MvhHN8krWTEZlkYEKSE0SJYC
 h1tWBO5bWXb6ucapycDibb6i3UHcCriK5geikLhD0X7gUczySe96B83vdNiN7T1CO6
 /w0fFr9dZGDMykBRZf8JEz5hf/PrrpwCvedojzS/I8IguWxUac3qnxMUM9sMMbVeQg
 Av93G+7yOjNig==
Message-ID: <sashiko-outbox-213198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v3 4/4] ice: do not block on the aux device lock
 in ndo_setup_tc
To: "Petr Oros" <poros@redhat.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261113161453.1234851-5-poros@redhat.com>
References: <20261113161453.1234851-1-poros@redhat.com>
 <20261113161453.1234851-5-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:31:29 +0000
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
- [High] ice: orphaned channel VSIs and memory leak when ice_setup_tc()
  fails teardown
--

commit e098adc9e591059f39322dbf2abaa105d7a546c3
Author: Petr Oros <poros@redhat.com>

ice: do not block on the aux device lock in ndo_setup_tc

This commit replaces device_lock() with device_trylock() on the RDMA
auxiliary device in the TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() to
avoid a lock ordering cycle with RTNL.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index bbe4409b16cf5..fbcce9bd798dc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -9581,7 +9581,11 @@ ice_setup_tc(struct net_device *netdev, enum tc_se=
tup_type type,
>  			mutex_lock(&pf->adev_mutex);
>  			adev =3D cdev->adev;
>  			if (adev) {
> -				device_lock(&adev->dev);
> +				if (!device_trylock(&adev->dev)) {
> +					mutex_unlock(&pf->adev_mutex);
> +					netdev_warn(netdev, "RDMA auxiliary device is busy, qdisc not chang=
ed\n");
> +					return -EBUSY;
> +				}

[Severity: High]
As reported by Loktionov, Aleksandr on v1 [1], does returning -EBUSY here
during qdisc destruction (qopt.hw =3D=3D 0) orphan the channel VSIs and leak
vsi->ch_list?

When a user deletes or replaces an offloaded mqprio qdisc while the RDMA
auxiliary device lock is held (for example, during auxiliary driver probe
or unbind), mqprio_destroy() calls mqprio_disable_offload(), ignores the
-EBUSY return, and frees the Qdisc.  Because the Qdisc is gone, no later
qdisc teardown will run for it.

ICE_FLAG_TC_MQPRIO stays set and vsi->ch_list remains populated.  Driver
unload skips ICE_VSI_CHNL VSIs in ice_vsi_release_all() without calling
ice_remove_q_channels(), leaking the struct ice_channel entries, TC flower
channel filters, and hardware channel VSIs.  If a new offloaded mqprio
qdisc is added before then, ice_setup_tc_mqprio_qdisc() only removes
existing channels when !hw, so it appends duplicate channels to
vsi->ch_list and can index past vsi->tx_rings[] and vsi->rx_rings[] in
ice_remove_q_channels() if the new qdisc configures fewer queues.

[1] https://lore.kernel.org/r/CH3PR11MB566895E0410B0694F734EA7DAFE5662@CH3P=
R11MB566895.namprd11.prod.outlook.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113161453.1234=
851-1-poros@redhat.com?part=3D4
