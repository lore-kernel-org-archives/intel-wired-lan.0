Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B481C35FFA
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Mar 2025 10:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31B2D81346;
	Wed, 19 Mar 2025 10:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oRT9NFV5ZFDM; Wed, 19 Mar 2025 10:19:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F90F8134E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1742379590;
	bh=Hh3CFzpnRkrvrYwIsX7t2UZ7nGTfdesn+azK/Q0iP80=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7zEJECbR/H8KzgTezJj0Igf69hvQj8aXERc0THERlFtSfmESnt4Crm/Ca8srK9Yke
	 PlTpasON/gS9M6fKE949u9bwnvXKCt5RDYmt2Tfmj0clYpjp2SSce+xFFWzAfQPEYr
	 DA2aUonwIqTLgCnoxBpEjNJh1eArr+oHTlLVDk1Lqu4B3AdBtdbhD3i4l9ocSZLRTU
	 JuEU5jH2eSXglRE1klcWq2yZZQRfAtE+CVfJ04bW/gXrJ/b2U3tziIq5J6Ja5KTjgi
	 ME2NmjfvPwYOSypQX0LK5TpBLOV30KIs49O+DeYyAc98KkPqzHBouVF8XsiztkjcY4
	 5jHc1KX/S13KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F90F8134E;
	Wed, 19 Mar 2025 10:19:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 511691A7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Mar 2025 10:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31CD34018A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Mar 2025 10:19:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMkaRg2F2hJ3 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Mar 2025 10:19:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=kurt@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1C5FC40109
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C5FC40109
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C5FC40109
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Mar 2025 10:19:47 +0000 (UTC)
From: Kurt Kanzenbach <kurt@linutronix.de>
To: Rui Salvaterra <rsalvaterra@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Cc: edumazet@google.com, kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Rui Salvaterra
 <rsalvaterra@gmail.com>
In-Reply-To: <20250313093615.8037-1-rsalvaterra@gmail.com>
References: <20250313093615.8037-1-rsalvaterra@gmail.com>
Date: Wed, 19 Mar 2025 11:19:41 +0100
Message-ID: <87sen9qq4i.fsf@kurt.kurt.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1742379583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hh3CFzpnRkrvrYwIsX7t2UZ7nGTfdesn+azK/Q0iP80=;
 b=FkhFvJf07CxvmLoYuAMhCx8uq+jrRxXM+E27yceHFUFho4yC84glrX8Eyxd/1Gr2oKJRFe
 SFJ0e+ytQL+/9mAIIFQNLt0eKHop5sniH7t8KKbAHTo5EnaFVC84yInLMF7QKt2GarTeLI
 KhyOuIB4boe7W7KIPCt4+hN9+srXJdgU3pNhlA9sCDzbPY7fbLDsgYLfkwbC/B28xlOBBO
 m0JY/bjympXqVK94uJ2Va6hTB207fGQDZb8PGDQwnwMtf/rU3wFCz7EarLmDj9XEHISnlB
 KoTZiBI4xiNXl4jhJWXiZAsJJZhL9K6htr0VS+XQiOZfVDYaNVe6veeeIIb8iw==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1742379583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hh3CFzpnRkrvrYwIsX7t2UZ7nGTfdesn+azK/Q0iP80=;
 b=JJNn6Lwp5ImN5DrNu9vn/EN5tY0mExwVy/nOITMZxlHwbMJ4jCPLph0JlRf2sZn7Hz3urm
 nItPKYwBtMlb1dDQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=FkhFvJf0; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=JJNn6Lwp
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igc: enable HW vlan tag
 insertion/stripping by default
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

--=-=-=
Content-Type: text/plain

On Thu Mar 13 2025, Rui Salvaterra wrote:
> This is enabled by default in other Intel drivers I've checked (e1000, e1000e,
> iavf, igb and ice). Fixes an out-of-the-box performance issue when running
> OpenWrt on typical mini-PCs with igc-supported Ethernet controllers and 802.1Q
> VLAN configurations, as ethtool isn't part of the default packages and sane
> defaults are expected.
>
> In my specific case, with an Intel N100-based machine with four I226-V Ethernet
> controllers, my upload performance increased from under 30 Mb/s to the expected
> ~1 Gb/s.
>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Great, thanks a lot.

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmfamj0THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzguCbD/sFqhOTwB8d1HDdtnVFlTJ4+lXvCQrD
8r3VMR2I8A3OLOxgYx+JJLuOYlRU4ETbHw6FmRexWICMmMgv3xfHsEHnGolUek8D
e4sGPF/clFx74OnUi7X9g+22iW3lTFFd6x3N9g/384PP+NUWwvsGN2B3+l/cRTDB
693NKeYHa9ZggsoBS6HvMy6HhDf+p1QwuNa3aRhTDqiyp3HcEdujSgVZ35j8aXYC
8425Qs/CF/OeNwCXuD4xDqnI+3hIDSq3atRgTyhc9ThKIR2v5vgRAitqQHJUVx7K
o10jiTBP6BwCTdM5JQRrbzXoEx+gdrk7fIP/p7dF6T/xmTrr8PuaA/EUnM/IYopj
zHAuCwwcVesZUVkV3mUjD6NVDZ2JyhuUOVuE0vdtu3QA42lBjU5FVq6BacaAovK4
lH8yEHyB9cnTZoT3qiJsI69oNcTo6pH3ysJvU44y/G3drTzaDe3pxI1VDLGV5jPH
/8fMM8OZ9NO9/UHKC4hePLUmpEE867MmQUGbBdnK6Ck03aLX1Tb/7puUJ1vlNS8U
y+j7h8YXqP0Lb+AvaH325ZTSXlluIxsAR8O+e9RARdgzd+cY/s77w7coYfsED6ST
A7Ewyzc/Era0kHlN7z+hCgYEDqZgqB/b0Pr9axCkl+xFXVPXA8gVgFPfq2n+prO5
ROj5ObBGWJ1EJg==
=GTVq
-----END PGP SIGNATURE-----
--=-=-=--
