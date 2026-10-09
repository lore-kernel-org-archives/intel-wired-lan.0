Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBF5CA9EBB
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47F7B814B5;
	Fri,  9 Oct 2026 21:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pmm0LAGQtcAc; Fri,  9 Oct 2026 21:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 81C81814B1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791579846;
	b=a9PNBHRds6KzyEgmlfYmlhFlwr4fGtShd7Sy7w+xEa+pu+QSDt5pN5LU06Uztcd8CcPy
	 CjKhg+4oX/26N5LqjaLIRtsoQoKXBwATIgBruI97fZs8eKlhnq2KCDKTljruyfR2xc2R+
	 ePAsnfc4tGAmrAuwUJce9+I9vXmZ1p9oqCuUTUAKLVUUSnBwFWDIG3YvNHXxkAwW40xLI
	 dJ9oojYh6wCND2ZRtQCKNWwwtHGamIxkFmY+B3vc/lF0QDt4/BvjkeCYcfz7NKmkP7K/C
	 Z5pLKaO6FhmuGBfch08TEIwNKt6zJ2c1FaXl7NEkF/q3BLvxAZ/PI1mZyOGm3HwnNpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791579846;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Tcv8NXtIokDyWQizCm2H02vtvGGJ+ADovDn6UZtLp6o=;
	b=iv8zEiQFlwjNXoMb2yMqFgKV9+jad1aCd/05WgghDjmCTH5ngvX6bSQEeNbm0gWg5qeO
	 LIuzBj0/m9rMNShte43FrwZqoKH12QbK6Gqk5pnF5RjrKOsgaLPwmaHvvRA2r614BxuUL
	 9qbaoP7pFf14Y+gsBzA6MGhnJO8EQaIf8XXcE8WKUDcb1IVXM8JerSNT3O3kNXpNgvQCN
	 tnHdCEjdYMBC8OY5zwkFlxcdQ+3YxQmy4CY2d6xlRbdTyPRG17nZqM5HhAg99B9fmytxa
	 VWqkm8jNcfMpLqQqD55iDucSLzniKuWn76vgL/TpLt5IBX44TOg1ZiWWyivwJHsZFvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791579846;
	bh=Tcv8NXtIokDyWQizCm2H02vtvGGJ+ADovDn6UZtLp6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DZLhrHIuaj18l4nteu/Soo+k+C9yC+vtCROVODTJpkDtODmv0f4jUiMhZKsGMjgtT
	 Zr+vu2fhkSJ/lyyZ0HWhx7sEuDgLeznP0+6hIqjWae+YB7Av/DMCwOZhAtvcRC6SB4
	 Gcgfq2vwKicfwCJduPplXE5s+p3Q+02HX4pVQoDaRig6GBBT2SyNfvIU0g/Ncrz+2i
	 VkNTVdLSAzRi4SpnzmLbuUqdMVmSynB3r3VesZwc2L9pZWhi072Ms2zAFmI9iqzOf+
	 aH36fF2Br5Pkw4z64VlOsnpI7Nl6Zg13K3LC2uN4Bsati/M/YFbcgvrpXBkHMzKhTO
	 jWrqPtTZjPHZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81C81814B1;
	Fri,  9 Oct 2026 21:04:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EE4475
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84A50606F8
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JEYnujBPTLDR for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:04:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 90E6B6067C
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791579841;
 b=qEl62MBwpCG1PFK6tJmUS1DZZc94nGnQiPPOq3JuYxsY5wjdzApfnPd0e7Ltr5xykhQP
 JIePMiRQt3by9yW79mpjgePVyLhiZPtRe2c1NUa968X9lybsZt995uZkkqgIZCpFCds6O
 /VGtXgIgF6voV+KBjLTFyEEGvQWOeBTVI+0bTu1ywqVKx3aUj2Lk0vqoTBpTsGNHWw96f
 RQ/pMsJkU3Z0pTGofq36cO5m/uWyOmvxF8US+eEPgLTjxTbhGQAA4WCL/cVdszH+luS2x
 PzDcf4c88knigRTFjrdjzjGjgRUJnayR9yssGYCEJKTAdtCZYuf8MER6YxMTkDWhNhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791579841;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=Tcv8NXtIokDyWQizCm2H02vtvGGJ+ADovDn6UZtLp6o=;
 b=gehFuBpC/EsyO3qMNWPEYfFgW7KDl4mQ3rpG5M0HQ7Ul7llLA1Lsu5j04d/KJmr4zQum
 S+qRp7lsGdTW8q4LqYNZxRK7xavLL8Qflvtu202xreNBhVUfBNAPyp9/FR1jWthuLd+ew
 oSDbBoji51jw5zaLPBWkaNlNCH7NzwbTrXo9/Nk6gd5XOWMy+9CVzquaS9t9iNhwlAfai
 PHNqNNjGoChpS23xBAQOmjHprfberEnuB1LOtrU1cJs/JNyVzs52a8DXzUGF8x6k5FT1V
 v/F2gXKKs4N0ovIFBXd8wnYcxnAqsNZPAqKdNV+7ycUnmj5eOdqFJt/60Pa9rddLZMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gym6jvsW; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=gym6jvsW
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 90E6B6067C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D09D60202;
 Fri,  9 Oct 2026 21:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF02A1F000FF;
 Fri,  9 Oct 2026 21:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791579840;
 bh=Tcv8NXtIokDyWQizCm2H02vtvGGJ+ADovDn6UZtLp6o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gym6jvsWiZNIXkn3xpHP5WuG1UWKJ6TrIrIMcaElSyZPUN4fcRGUBcO0Ff646F6sf
 MLx2vwwyr59YUjTPdmMMl7aCYib2y/YdkBBtnjlafzstRqPSGP60LEmZn/RKxO6WoA
 VoD+GguU4B1627KOL6dkwl3btvXD4mJd6pgDMWdJPhdEK9/PDyVLVFi1TAtef8kyam
 NmervWCYeOv7xpvS17EnC4DIZBvF2sZevBQ4v5GeH6hJuTJulee3AXr7mBmnB9iMAh
 LnAonNCR1/qQk62HMZU7Fkpdn1ulnbPp1s8vRzWbfr2s3apRVy/0v4kgZAF8Dgiib8
 TF/6h8IJGgQKg==
Message-ID: <sashiko-outbox-166072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 01/10] net: skbuff: add skb_drop_empty_frags()
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-1-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-1-8f2bd9bee138@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:03:59 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

> __pskb_pull_tail() releases every zero-length page frag as it walks the
> frags array, even when it's asked to pull nothing.  Some drivers depend
> on that.  xen-netfront calls it with a zero count on purpose to make
> room when a backend fills the frags with empty slots, see commit
> d81c5054a5d1 ("xen/netfront: tolerate frags with no data").  netxen and
> qlcnic get the same effect when the frags they pull to fit a TX
> descriptor happen to be empty.
>=20
> pskb_may_pull() returns before getting there when the head already
> holds the requested length, so these drivers can't simply switch to
> it.  Add skb_drop_empty_frags() to do just that part, unsharing the skb
> first if it's cloned like __pskb_pull_tail() does.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-pskb-pu=
ll-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com?part=3D1

