Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B968606A31B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=W4bEFG2R;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZZvw4u1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 349F44072E;
	Wed,  4 Nov 2026 10:11:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9gpDKOVC6p8U; Wed,  4 Nov 2026 10:11:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61D1340732
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793787065;
	b=g6sYD9w1bUcCK3FMesRsx3FoB/a+DccakGF90NrwXkmTpnTdNrqwkwAbh2hklNWH2QRX
	 RF4wN2w0bu6B5AI663Y85RWgHd0fOK4aBoPmjCbtCfnjMzxUYipM+n+zdOviI3kosxlr8
	 pchblX9/wHYXRJ/Tsfew/shWeSOHFXSqIkidhUO8i7+G4v/YtI6CG33DP2j/JO7tbS9Ra
	 SDOl18HxMad8Firom3Xym3KIA2vFr5dKBXZuis2eu+h3ZiJKubr1Vj/CrkvKpHfW+Nm5U
	 IOU+DdfCqizWmkEMCnAMzr591OXQvE9YYoGYXXIdO+VE9oTR44nmYbjOGz/nrnqiowg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793787065;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Dlc3LskfVT7qb/YiWBB4GAKr43vEaWr2S23EHPUmVnM=;
	b=S5JNOHIbBb0onJnAt4E7UdZ1N7h17HNC+0L0PNUyyTWb8eKKC3oiYSbvcWwQU4h7ITcV
	 zLqVVdHMy+lkVzyPOy1MsOz8ZYFPD+DKm22ytpNJ4EOA3A66L6v4vLHrp9U9JCBdOo5OJ
	 x+9JjodS5pJJpoLkXC86haLqrr2f2c5G1FFJOSBLTN2QvLV73gNRpcVV7mZDS6dHcCKbO
	 eANg2bbjsqgWvxYmXyF6padFM0nDa+I519TNj/HOlibgLxwqxWxjO6fl0d47zQCZY3IK9
	 q5qDOVk1IPcn8ZzqleWorbj4Zp2fNhoOYtYgoqat6tnBR64L2Vysb5M788HJlMqKLVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793787065;
	bh=Dlc3LskfVT7qb/YiWBB4GAKr43vEaWr2S23EHPUmVnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=W4bEFG2RqMGWgKZnVnNPalThhwSkmpnvRAllauysLFh0Cwlmm7Mfd4MT7N075VUTH
	 4SblazXr842Z3od1G0UsuX9QBYNBOQTieOfIborgVl0K+QUr9zQylFzZHz+0h+9Doi
	 iapk4oTXsCViBHw9O7x6ALrbO7N7itVxP2nynUZJh+/u0lNjNybmiMInM5w+k99KgI
	 h0B8f83JnBei3HGfHpr/vROlKlWjNpZZdsi+KboxugRHj9oGUg+ssxI1tM6qOP8OP4
	 us8L6Q+Pdmgq1RKu8TlzpkrdXOEP6bb3gHjozxOcL3zN2Y/TsuimeILVpCT3OP4tW4
	 7axR0eaT2fAFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61D1340732;
	Wed,  4 Nov 2026 10:11:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9359C2B6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 10:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90E23402C5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 10:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5WcfxKevtJE1 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 10:11:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A4B774004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793787062;
 b=de1z9KH02BjvfUt5JAxji495BVtXdw/mhMefrHX5T+nJaSdrrVVxDtWK9Qd3W26PoeTR
 +7X6AorUNwxt4jWVtuzLLvBF3+GYx8RkSalAEnsxO8CVMlemnPf/CyG+SZS7Mglc0zTg+
 xOS2zRAuybJLFZqUlOqXbKyDrfydqyjgkE71cgUrGiubT9h7/9Ij++BBQQXviHDfivGoT
 VIuTB6TWmIj1lVpiHp1nqdV9eTuSxG8dI3TQsFj/wSaiARngK4untCbt3UXoPsN4VYYNp
 vQWGrU0zDNBdJLKVbfeMSrev9YT1dYks/MQfPK9WEZjbOqIHTHzAbHFaF/s2VosIelQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793787062;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=Dlc3LskfVT7qb/YiWBB4GAKr43vEaWr2S23EHPUmVnM=;
 b=HVHG6Ewk79qKfCO6JeZOnsEyYT8/LeUrZv0ZkwaKCv/RkBZpvjaCShWhxf2iXrj1vj7q
 FyEwfxUGMFiA6GpJY+CDyIo5XIblPby0qZ5wcLf5IgE4i9/QG5Q/P6jav3JKznAdJRa2v
 EQRN3platoseS5AOvzjuocTZNyXynwwtSwBdiykSHa7OM8v1Uo3oqw0d1FW3InoexQ/yA
 pWCAg4NIBK0G7AYH9rgcaAY4CMsuUugwkSvxnpcb0XyPLwPOCqp2uUBB6vnqgf5OuAOna
 UtdasvbDjXwWed37FkgZ9yy6TcqxCZD2BKLOG6tHBdwwyGWhTMJM63Rcb1B4GK+6Vww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WZZvw4u1; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WZZvw4u1
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4B774004D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 10:11:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A36044043B;
 Wed,  4 Nov 2026 10:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614E21F000C1;
 Wed,  4 Nov 2026 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793787061;
 bh=Dlc3LskfVT7qb/YiWBB4GAKr43vEaWr2S23EHPUmVnM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WZZvw4u1xxzQouzuwPk8ygNlow5dBefzDhPRYErAmpOsyqB+kie7h+Qt2KPsgOlb2
 2vpH/L2IdpIMjqUgL5g06HCRwxald0ttuNG5Dfk3p6rKGvro9lxwHj66OBClUFcjYg
 dVdbbctYZj/91TMhf9YbMHUUrqzgRIJIKSzLfa1NPPjnxPQutICvq8AZX/9/hOeTv+
 C4rduz4+AJyfEm4k326ZneJtLUF8e2P4KdXktlXSzIeSLcX71b2KSQsObUiX4MqbVf
 0eMglIHe84y7aOq4dWCjRqO+czipqdH1QGjCOYn5h9qAIKXcNBPK/QN2SX5+BT6miA
 qh590jek/sBbQ==
Message-ID: <sashiko-outbox-197051@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ice: release the VF reference in the switchdev trust path
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261103100530.1309907-1-vulab@iscas.ac.cn>
References: <20261103100530.1309907-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 10:11:01 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] ice: incorrect Fixes tag in commit message for ice_set_vf_trust() l=
eak fix
--

commit 42da2ece24c78562b789e051c2ce4c73f6f2c81d
Author: Wentao Liang <vulab@iscas.ac.cn>

ice: release the VF reference in the switchdev trust path

This commit updates ice_set_vf_trust() to jump to the out_put_vf label so
that the VF reference acquired by ice_get_vf_by_id() is released when
rejecting trust changes in switchdev mode.

>     ice: release the VF reference in the switchdev trust path
>    =20
>     ice_set_vf_trust() takes a reference on the VF with ice_get_vf_by_id()
>     and then rejects the request when the PF is in switchdev mode without
>     dropping that reference.
>    =20
>     Return through the existing out_put_vf label so the VF reference is
>     released on this path too.
>    =20
>     Fixes: 1281b7459657 ("ice: Forbid trusted VFs in switchdev mode")
>     Cc: stable@vger.kernel.org
>     Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
>     Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

[Severity: Low]
In drivers/net/ethernet/intel/ice/ice_sriov.c, commit 1281b7459657 ("ice:
Forbid trusted VFs in switchdev mode") placed the
ice_is_eswitch_mode_switchdev(pf) check at the start of ice_set_vf_trust()
prior to looking up the VF. Even after commit 3d5985a185e6 ("ice: convert VF
storage to hash table with krefs and RCU") introduced ice_get_vf_by_id() and
the out_put_vf label, ice_get_vf_by_id() was still called after the switchd=
ev
mode check.

The VF reference leak when ice_is_eswitch_mode_switchdev(pf) is true was
introduced by commit 83b49e7f63da ("ice: check if VF exists before mode
check"), which moved vf =3D ice_get_vf_by_id(pf, vf_id) above the
ice_is_eswitch_mode_switchdev(pf) check without updating the return
-EOPNOTSUPP path to jump to out_put_vf. Backporting this patch to stable
trees containing 1281b7459657 or 3d5985a185e6 without 83b49e7f63da would ju=
mp
to out_put_vf before vf is initialized.

Should the Fixes tag reference commit 83b49e7f63da ("ice: check if VF exists
before mode check") instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103100530.1309=
907-1-vulab@iscas.ac.cn?part=3D1
