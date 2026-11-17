Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3545606A32A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=62huWo5+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRGHWZ4Z
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC72460774;
	Tue, 17 Nov 2026 02:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CTdgpRdEMfGd; Tue, 17 Nov 2026 02:16:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3AEC060825
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794881780;
	b=CCJeZ5PUUzgd+uz8wDZ1iI6j6On+rgMA45XN6CsT0MUUSrFroJlEIIrJf9rZbM+JPlPT
	 1J7GhH5oObNG1XuCwJXhcUXgcXw/YlhyMdmwdflAc2ZKmBS5E4qP5fTIijM8eSYbLD5PQ
	 27rNjl9Rocb0gOsztlBKreeChpxiSIEpySuWCTqODiUKLhT0CRcRKmT5NfnmtMi0fwZ9E
	 KaYz7e42YsQToYLA4ekZu9g9NWBD4Eb6UOQ5xQBuSRwfJvnz/lywb2NrAE6BYHVTD+KYB
	 sKuUT1ZmyXDEnJJy+wUJy/jyd+FKdexFa8DzYfg7E1sw8bx2oeRl3vysck2HBCIL9OA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794881780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yt13tp/rvLvexjlMPma+hJFiFj/qQmugNFpZecZf8sw=;
	b=rAc4KU3xrCOhgNBiodV1Ff9g5yNjTOCgdMhdmexi4DFMnb6as/X4+kVpNNJyY6QNqyTV
	 Qz5doGI2g7M6XRd63eqF6JUdWQ0FIXJ7gR4rs9Z2KW70Jw9AL6cmTLWBL3J7XSGSXe4ys
	 zSL3Gu8qlCzmGYiVdEoyVZ5wvSId4PJ7Nic8xy0cm2K1XcVxw/1VPkwfzpqh6PG+9HN7v
	 fsRUkM8Cw2CWofcSE9lrjs+hhRF8pGlFV1V0bIGzVFeAR1ElU8I3ottQRHCw5Z2XOpRoQ
	 sdd0SGwi+lOfUEn6nGBKmwUsKcxgbrsYRfz7Kd/Ig9QDFhKuQBfi4a7bEt5dM+tBRQg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794881780;
	bh=yt13tp/rvLvexjlMPma+hJFiFj/qQmugNFpZecZf8sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=62huWo5+UamSHM/zN7xt2ZKFTuG4t3TeGlG/uvFTwlLCq7Hjn5Re2N71+OGLZwba4
	 rI48Llc3Ohm5yHhECqx789ksDcTpaQ8XTidAFWyhn1172SNDZzCybgigeswai7PWI5
	 P8CJOQ0T+OUo86zZvzVwDAIR9LvEGRa3zKz9Rg3eMRhBl8NmYCpnM/v9pc4MkqvNcW
	 aYwTbUFEbxpSQkrZlp6xALYKs7luscTIoaKMlCnOgeK6XoSCwowP/6ZhpS7f3x77o5
	 WE5P9QppGqIHtYJZLcWFQWEkJss6wlcs8codO/o+HcYNLPYyJlFxiMzPjyVYg2Ep8v
	 XLB/VedcpivQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AEC060825;
	Tue, 17 Nov 2026 02:16:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A7BD49B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 02:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4087E81053
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 02:16:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xtywmL-dYpNJ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 02:16:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 433628101A
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BRGHWZ4Z
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 433628101A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 02:16:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0A62437A3;
 Tue, 17 Nov 2026 02:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE141F000C4;
 Tue, 17 Nov 2026 02:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794881776;
 bh=yt13tp/rvLvexjlMPma+hJFiFj/qQmugNFpZecZf8sw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BRGHWZ4ZG4Pk2S9yip/TgmH+UX3gPqHKvnmbx3WYO7WVHx6DhUQ+VsoehKTeDLcXa
 HfIpHmKlYHL+glR7sOXidda/KfRzP92NpnD5Qgaz7KxTd6/RoJkovp8ACrNUjGdH1y
 h0J2TUX11aSyEF4NIZWzlVGvDlSP1J2rUn05r1B9c7IgNtYX4Hs/2ATUuMRhndrtaZ
 YoBBog8btT2sLVSEba+91hEz7SrOcJSU72MYMaYDb/9H+aMNdA0oDSmM4/v4Cjbjek
 AcgyM2tnelMvoJ1NSgrtuXp+LkgNrChuOIOPi6Wj4qFYbHmnTxVIe1uzGAOP30TgHu
 Am4Mw8VifKZYQ==
Date: Mon, 16 Nov 2026 18:16:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Min Li
 <min.li@microchip.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, Grzegorz
 Nitka <grzegorz.nitka@intel.com>, Karol Kolacinski
 <karol.kolacinski@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks
 under global dpll_lock
Message-ID: <20261116181612.107a4b57@kernel.org>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 17:40:11 +0100 Ivan Vecera wrote:
> dpll_lock protects topology and object lifetime, but it also serializes
> all driver callbacks in the system, so one slow device stalls every other
> DPLL device, whichever driver it belongs to. mlx5 callbacks issue firmware
> commands with a 60 s default timeout, and zl3073x callbacks can wait
> seconds on a driver lock held across ToD writes and phase steps.

Can you provide some real life data of how much this actually helps?
Real device topology + scenario you hit?

For the cross-domain pins - shouldn't we stretch the domain to cover
all interconnected objects on the system instead of hoping people get
lock ordering right? You documented some rules in the doc, admittedly,
but not sure how enforceable and practical they are.
