Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD34C982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 15:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EF9D40BAB;
	Fri, 18 Sep 2026 15:13:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T1CUkbF98sVs; Fri, 18 Sep 2026 15:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CC2A840B9E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789744393;
	b=nx0eAC3GNY9v3i2mrSvlKHs97vtT8Xo+RucKHiUpVUFygo173qcdGcujDthqxGFI1ITJ
	 USdQIkFVHBOdE6LtidC5J+cwq/LRxoGMUZ0/IizaLgaguNC7Tp6M7jklJqFCHll8A/Z1M
	 fsdNHXh7ylRM+0dPjDvKFv95R/PawtOu8uOEWJWwvzjvnlIBA9OBnPav9Yuxj8EuKAJUJ
	 kUeW1IoFFpxKuL5tSKk0kanVJsQA2G4Fjh7CaKOeptSXMQKVo01XRlOW3A3a7ijYX0gMy
	 Zgeo8+mx6eaWZv6YLE1EVp7YZpJzJqYr26TULvofzhDZgQsTzYJxsU+Iu8sBtv5VNSw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789744393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L/nor5Xs+3qqWQOS1MAPVghILT3WgphX5IsnR0FN3ns=;
	b=e9101uX3hWwCRaY//3uB4csFjCeKn0et+hQhE9IQ9Afdkdf8UapRQEnZdlNXMtbnm41y
	 bLcJ8zoCMTmloK8dQcyCLpRmSSxfC7sRhJm+G3dro5MANrVRey5sNxn/LkJl5w3BEmdNv
	 Uv7bxNzN4RkMtUg/l1J5szSoRPgt+f2Bcf6PyDFnBFCUnheUpaC7PlQJKI1IyA/wiQ4Kz
	 j23ghJSE3iV7r8d0Up96XXHKhXP4zQtT6oKCZe+zgAV1NBrDBjhhLmPVPdj1KSlI0ZJMr
	 NsPtpCd+ojwXBo1b1C6FR2ub4x46+dYXayT7tgX/IpJjskDWCD/mg01DFLqRr05VVAA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789744393;
	bh=L/nor5Xs+3qqWQOS1MAPVghILT3WgphX5IsnR0FN3ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RS1yPuJXye9kVJyMrkv5LRcjAESOHMHDOTld/wuyGKeAaw1aCGh3phLCiNCVrxKao
	 CmV28Z1oNYJBFEHikDUB4zFXGZdlnUmXG5uNbUOGB4ONBP6EzrRmhx4c1+6sbFYV6w
	 VPSolxzQBHRytSqlx8CuQiLZw/MZvpb7K/LAqvrKPI3AQmxXHzDw62J8CO+KGexxfk
	 SgJhMvA4QogSqqGOcmJC1SB59qnLVmgYECoHUhVcB8wsy0IzPWnERfEnIkI7TRZ0AG
	 CzzAY/x/Mtnix3t3+3Op7CJkcRv7k/50MCSPjTSRJoS3nvV+hJ4Z6IxRmq6h1WhKPB
	 3QTiVqsvmjD5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC2A840B9E;
	Fri, 18 Sep 2026 15:13:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 82F4342D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74C2581277
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNaSlKRYXTaW for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 15:13:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E684081274
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789744392;
 b=i4RBYiVqHMqWWKkUFbBoevv7kGmjPGTV/8CFVy6edC4YWRkmobjrjkgXVmWmJZWsQmKT
 JdG3LJK9PAI5v7sUg3PfVFEUWp3KhDzmLBTXeyc2QSlq7a1XouKAXxIsOItJ0SFzdbXsY
 voqm7Wufqj5MuyxRvhLWPIYN9snmMDiCu6uo9evB5iuNxwohlQOrVNcSSQt8u3d1peofu
 +h8MtKouZhYyZ7byJJ3nDdjOHYAv1BpHAlsjB7KNqRfKpbvG72bEyXb/TN7TPxFnkuZEB
 jmOQehab1At0UVqGmeSko8D+BuuO6ZMM2zWT6Eyqr8UBllaDzvf1xaO+318roDEj04g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789744392;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=L/nor5Xs+3qqWQOS1MAPVghILT3WgphX5IsnR0FN3ns=;
 b=gXPzxf4zgoRUUT1T9XsS+1Gm+RU59VBfnPFFooh/oGjgPwMy6+aKupiIe+SfGKf4kOmJ
 ouvx0eimu/4YP5FmxdoeZTYaFUm5/s/v0pUgL2/T7rocdl8Nj0ne+8JYaG9xr3s2ncb8x
 QR+n9W+Tqq1zPfwbTp3coOhQpsrkY8HDjT6LZ7skZwLD5Hqg7vwTCCNbDt7LGB+l4yUfF
 d2qO2O1ALJeM7qVKsVtCTgDomVQA6L2L0mTqnDQ0TrOpCaPmAoqkAbbj8QZiFhlW4Bh66
 kzOK+8q/cOmcprIY2dBA8HiI8XL/LaRGMqul+6VeFY3yw3vesosLvSgaU7+USsfcp9A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="IvXcNz/3"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=IvXcNz/3
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E684081274
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 15:13:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33A6E43C06;
 Fri, 18 Sep 2026 15:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BA81F00899;
 Fri, 18 Sep 2026 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789744390;
 bh=L/nor5Xs+3qqWQOS1MAPVghILT3WgphX5IsnR0FN3ns=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IvXcNz/3eYR8O06yvOOhBgc3YzBBSJayfQOMfy7wW7FOQXrh8wxC8B453SOCl3s8R
 NepUxD4eK6lHOMSCZBean/rjNIaZf+g0H8COIl6jy4DeG43Dm8olLZakWLMQ/2SNb9
 9wMrf8AVYyEfX+zM/mJ2J3UWy+3IA8XYGy6kaUOqJDQpJOdg8tTeiTjcSMmOL6CTHx
 PIYyTM29JyCH145e4jaGxU22pQDF7g/bblVckc6+hBClGUFXPsZyVjO90zavdcwGaI
 tXkc1tYQrINnDL42PBiKEtn/+vRO2XfAIzdeHgJmrih/uhaTvyv2CNr4TegR4ov+IZ
 4rFunxzlTB5cA==
Date: Fri, 18 Sep 2026 16:13:06 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Kiran Patil <kiran.patil@intel.com>
Subject: Re: [PATCH iwl-net v2 5/5] iavf: return 0 when TC flower filter not
 found after qdisc teardown
Message-ID: <20260918151306.GO51261@horms.kernel.org>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-6-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125551.3976068-6-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:51PM +0200, Aleksandr Loktionov wrote:
> From: Kiran Patil <kiran.patil@intel.com>
> 
> When an egress qdisc is destroyed, the driver proactively deletes all
> associated cloud filters to prevent stale hardware state, decrementing
> num_cloud_filters to zero in the process.
> 
> The kernel netdev layer is unaware of this implicit cleanup and may
> still try to delete the same filters individually. If the filter is
> not found in the driver's list and num_cloud_filters is already zero,
> return 0 instead of -EINVAL to avoid confusing upper layers that
> believe the filter is still offloaded in hardware.
> 
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...
