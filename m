Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16491606A31F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Oct 2026 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=J3dKFi1i
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBDE480DF9;
	Tue, 20 Oct 2026 06:59:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jk38SQfSe8aA; Tue, 20 Oct 2026 06:59:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A33A8101A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792479571;
	b=cAscCy/0H5bIRJCZjQ2Yqu2CqG6TzJxnf4+Q5Ajq4o4tr3KKpV8yfQKpgVNBv6TZpEx+
	 lcKxaOTNk94J7C/LJeMQsvu+i1davDkAY7gwyyGbv7rWNLJmNHlFfLBJL9952KQ3F9Wns
	 YjF9OAEUwg1FUYz0lPC5NLNwxYNcx8/lYud8Jb3jpX00VIWQOPT+GjrdxtFKNHnneE40U
	 60X4nHbGGCqRU6KWdxYEiBwIaQzr8gd+9RdQPpFJy/nOTUxmzd2t9CV86LZXcaDLaqIl8
	 Jyb2RGy1IgE+7qpSDFg26DvyAFH5gL5Kb7KJ/LlkWjUw0q1+He6j0B1+qVnkEQBIWpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792479571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Message-ID:From:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=GNgGNwvFAqB+5GglajRuYHSbxfe20Slti+2cXbK7VOw=;
	b=GGEMQ/DAD/T8lhSjugc21S/IYKFau+KQ7nnBc0X//IFVmZtTOJ8DI41MKC/lErL3QtWT
	 ZiCPA2FpVL15Dt1ivMl8wHk1CdIGMtV5OSmmGbm8lszeiv/QzCxKUj+SArnN/tGwcPyF/
	 uJd0zTOsP7C9Ie4tiS6wmKJ/0825e8ZoahIDD2UwvaAJqEuXpWgmGPSXLVWlqAwsPgqE+
	 7kymMKXG6Ep5jbem8Dhvbfxb2msxDddzyRD6UW6JixCiRsG3tHDcAFX6NS0LX64BwMFUB
	 l3lfLMrdNl2OkaI10WPYpXcglihmSGLJSC95WHGkm0IZVjfWBOOG3A6dhxQ6+g6qvrQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792479571;
	bh=GNgGNwvFAqB+5GglajRuYHSbxfe20Slti+2cXbK7VOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=J3dKFi1i8uPpLHSl4LCd2fAa/4CkLv1MZTcHx+pfHU1AgkRsX3LRvC3JDpiitA7qX
	 gBJY2gBMoLWPAUaOpiZJezExk8BhMc6YrbjL48g3D3LIVrjyvXaJ9lOmJ0l3xuyaqZ
	 tzBr74MgGPX8v/XvW73Blz9FwdcP4PqetsYqj6jTBmjD21m34hs5DOzFb8xWbv++qx
	 sNcvEr1aArm9B0sPjK/vQ9ZaeeyuyWAuYmijY6mWTUG5DduJlJBohV/F6vHQx946/J
	 SkrbsxiV4JCo/o/VT5riJjykUTBTIzNGWJQpNzKozxzt8HAzckRYJBO3Mzb1dlz2pj
	 NU2vWsLUi55uA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A33A8101A;
	Tue, 20 Oct 2026 06:59:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B63623A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D19D8101A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:59:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZyfHsjTp0Erg for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 06:59:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 90C2F80DF9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792479568;
 b=fmn0pKCFeCJUJrr0ucwYfLvTujbmCPph9IocQTeJm6HIRTox81F/NVuLRa33yBVHanWM
 khgEYyusUQW8b2plmpyhC7WnBmY3S+SEmtmq2g9DRnI5kc+tnlRo/e0V1RfyF+5vk8CBy
 l7eQYSWzQmvBbtdVgxJMOw7U2JrSYfgFXKx3IcwrKbz/mp6KY0WMgRfFXiqLlBB729GTx
 VybJH+4j0w55gQO2NZRiB+Wm3Sg8hFT3z4L/NH53vJ0gWSA+qUXZNwNLw6FJJfdy6fDuB
 ILs0gvyc05vNOEqmcjTFjrTA7Yp0w9ZXU9okPTgmTzm6WlXIy3dfh0W/eOmDMwvSdEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792479568;
 h=Received-SPF:Received:Received:Message-ID:From:Subject:Reply-To:To:
 Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 Date; bh=GNgGNwvFAqB+5GglajRuYHSbxfe20Slti+2cXbK7VOw=;
 b=Gwq7Mw3GKaUbh4wYEiK0ODp4QspXOMnu6Zx7a5pUyC3pjlrDlzUwYYVTFLN7SxNHeobT
 y214VaJEnZbEi7jNRZ47EAx7Ls4GGp1FErBRylkvaQtLPj2Eyfby1hsKnyGyxL05rjvdr
 rKoYt/U38181fUDTEneeasgnflDX+YZcHEnAcBNDunBweiM5oIuSGI7Nc2gDq1iVCRxY9
 ah1WRTlSltYtb82V6pZqkLSbkWFt8RHLEOrgIbGOzwCefv/ovivCFSPkSmN/ybZVZzDU5
 R4c8OL7OuING3KbFp4ngXQRZOYr/pxm+3ZdYlUpoyVmtwsT8TICtaPyg0xSxBEQm8qg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 90C2F80DF9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 06:59:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED70B433B5;
 Tue, 20 Oct 2026 06:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820151F01810;
 Tue, 20 Oct 2026 06:59:27 +0000 (UTC)
Message-ID: <sashiko-outbox-178445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 2/3] ice: do not block on the aux device lock in
 ethtool set_channels
To: "Petr Oros" <poros@redhat.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261019065301.3983537-3-poros@redhat.com>
References: <20261019065301.3983537-1-poros@redhat.com>
 <20261019065301.3983537-3-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 06:59:13 +0000
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ice: TOCTOU NULL dereference on cdev_info->adev in ice_set_channel=
s()
--

commit 41ef61e89b925d28893681cf06722f3b9581b193
Author: Petr Oros <poros@redhat.com>

ice: do not block on the aux device lock in ethtool set_channels

This commit replaces device_lock() with device_trylock() in
ice_set_channels() to avoid a lock inversion between the RTNL lock and the
auxiliary device lock during RDMA auxiliary device probe, returning -EBUSY
when the lock is contended.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/e=
thernet/intel/ice/ice_ethtool.c
> index aa87d4f6324e8..976402b6836de 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3947,7 +3947,11 @@ static int ice_set_channels(struct net_device *dev=
, struct ethtool_channels *ch)
> =20
>  	if (pf->cdev_info && pf->cdev_info->adev) {
>  		mutex_lock(&pf->adev_mutex);
> -		device_lock(&pf->cdev_info->adev->dev);
> +		if (!device_trylock(&pf->cdev_info->adev->dev)) {
> +			mutex_unlock(&pf->adev_mutex);
> +			netdev_dbg(dev, "RDMA auxiliary device is busy, try again\n");
> +			return -EBUSY;
> +		}
>  		locked =3D true;
>  		if (pf->cdev_info->adev->dev.driver) {
>  			netdev_err(dev, "Cannot change channels when RDMA is active\n");

[Severity: High]
This problem wasn't introduced by this patch, but can pf->cdev_info->adev
become NULL between the unlocked check in ice_set_channels() and the
device_trylock(&pf->cdev_info->adev->dev) call?

Paths that do not hold rtnl_lock, such as ice_service_task() handling
ICE_FLAG_UNPLUG_AUX_DEV, ice_prepare_for_reset(), or
ice_devlink_enable_roce_set() and ice_devlink_enable_iw_set(), can run
concurrently and call ice_unplug_aux_dev():

drivers/net/ethernet/intel/ice/ice_idc.c:ice_unplug_aux_dev() {
	...
	mutex_lock(&pf->adev_mutex);
	adev =3D pf->cdev_info->adev;
	pf->cdev_info->adev =3D NULL;
	mutex_unlock(&pf->adev_mutex);

	auxiliary_device_delete(adev);
	auxiliary_device_uninit(adev);
}

If ice_unplug_aux_dev() clears pf->cdev_info->adev after ice_set_channels()
checks it but before ice_set_channels() acquires pf->adev_mutex,
device_trylock(&pf->cdev_info->adev->dev) will dereference a NULL pointer
(and conversely, if ice_plug_aux_dev() assigns cdev->adev concurrently, the
RDMA active check could be skipped).

In contrast, ice_send_event_to_aux() checks cdev->adev after acquiring
pf->adev_mutex:

drivers/net/ethernet/intel/ice/ice_idc.c:ice_send_event_to_aux() {
	...
	mutex_lock(&pf->adev_mutex);
	if (!cdev->adev)
		goto finish;

	if (!device_trylock(&cdev->adev->dev)) {
	...
}

Should ice_set_channels() likewise acquire pf->adev_mutex before testing
pf->cdev_info->adev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065301.3983=
537-1-poros@redhat.com?part=3D2
