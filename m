Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1871EB1071
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B61040558;
	Tue, 10 Mar 2026 15:28:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eQFqWDOpt_8s; Tue, 10 Mar 2026 15:28:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 945E440367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156500;
	bh=CYE/HV7EYizpiAYX6Lz6xzxADa1AFKYBU1J/zOcqJyk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fklfs0Re1Ydrs6pI2mqNT57KN61EevFLGTptPaRJpbQe3Au4SuzdrzFS3OoacBE/v
	 0QVF0agWfwWwMOE+l1aq9N2BrmAtC7FHP3ixxDNS33LmG3hyOBLrcAyVfcv81RvCHe
	 J0bDwkxsa4Cbn0qr68CL0yBAo88mcRWXZWL8EkZep8JG9Kbml9E5Slp6/lRz6LXqcr
	 P3I1grnYFpqWX8bD/Ecbt20XHE8t+bfRjDbJIGm/vmV0/YYwA/jO2l057X3HI/2VrL
	 vD6BqhHtNXsZmPsUkBC2mmVtkp4xSGPuZJsZhL07rpAiI5FrCzA3FoZwWljwciGizV
	 0jUk60Hg+P0Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 945E440367;
	Tue, 10 Mar 2026 15:28:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C888B201
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE09360ACD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:28:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bk1Oount1p6d for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:28:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=broonie@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D47E0608A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D47E0608A5
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D47E0608A5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:28:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 337BD43449;
 Tue, 10 Mar 2026 12:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8179C19423;
 Tue, 10 Mar 2026 12:28:23 +0000 (UTC)
Date: Tue, 10 Mar 2026 12:28:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Message-ID: <19aa26fc-8570-492e-8e17-23d6950676f0@sirena.org.uk>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-18-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7JjDB+7CEHk89uTh"
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-18-bd63b656022d@avm.de>
X-Cookie: A fool and his honey are soon parted.
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:28:18 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773145714;
 bh=NZ5oTCN6VGzePwnu776uK+3unhTqb8pwokxv1IJtK7c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FOutLnoL/seeB/icY17T5kE23weT+c8OWPxsN1CuLtbqZf1qO8twCXpCHPEW4zEb5
 uM5pcZxBh8XK3wQOjz6gQLnb8DbNMsJ6SwgjqzPaDdyeQRMdzDiadj+7d8CVSVSbbp
 WbSnGZkMbwo0cpPlViR1A0oh5e53oFE0sYAJxulW9oCNKaXKAhhACMzXx6XsRo3Hlx
 /XgKdmLcz/EtWl6VZEOUGY5PBqGn3Xb4X+aqLL+l2HoSL3wZMd6NhcSGeVt+ZFpBkn
 8s7ZymgPrZjLjSz7/xRlCoCIsHrVCduE0eaA6Z9IamuK4ZW4bnyThB9ZhLWcSUucoJ
 BJsDSXl6ZXWkQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=FOutLnoL
Subject: Re: [Intel-wired-lan] [PATCH 18/61] sound: Prefer IS_ERR_OR_NULL
 over manual NULL check
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>


--7JjDB+7CEHk89uTh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 12:48:44PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.

I can't tell what the dependency story is here, it looks like there's
none?  If that's the case you shouldn't send things as a single series,
send separate patches to the various subsystems.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--7JjDB+7CEHk89uTh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmwDmMACgkQJNaLcl1U
h9D4VAf/VCpoXjivQsq8mL1i6sHdID6byBqwG7egrwiRCrsZav80JlvY/F+1fWQl
Fe3Ct+yRv1pWeNy67wSCZD3mtHtNH0JpwRTNxS1XQrnXc7CLjzKunCldDfzTbfom
+QmXWHQB3Qo9ie1ugoAGet9gx/vkV0z+cv9sVHg1o1R7/AKqfgov7xnuP9Hlv9Uk
p1pkMya/NhbXBsrh+BFbktLgp+7sAOMjWgtGZ3NfHzwju9n4Jdbl1JcPxgDl0SHp
6z8kP2+oskOspesqLWw62mZF+bN32Ycjt1N7/EFjtPBdJKIcQJLICoACzxyQBZYg
+i50s/oSRL1HiP4US2lxoy8BqxaqrQ==
=U6jW
-----END PGP SIGNATURE-----

--7JjDB+7CEHk89uTh--
