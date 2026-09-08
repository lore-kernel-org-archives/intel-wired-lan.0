Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502EAC79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 20:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F212960722;
	Tue,  8 Sep 2026 20:44:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vxs0EA-3ylas; Tue,  8 Sep 2026 20:44:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8260A606EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788900292;
	b=hXBZhIkWg9hmaO3bMPw9+xzIh6WPwa1HZoeit7SIIsJWBZpQ/OqKzFUASFNWE8TMZQbb
	 Q+DGp1f53G2OD1qzRICP0VZ6kzCa0toIa2jq69iUSQnuE7OMqNyrYKAYblJDa5pW6pm/K
	 JhH2+BibMfGwSWIQjnPitFiOoF+2d9bP/+kr+GvpXB8+REp1qalHxxl6qSvRkLCNtIj1L
	 O01FWsLLJ7S0fEn4Ze4fSFes0iRM+eWSsbsrPgygu7pZLWvcCU2/kZDjd7GZrq+KdYd2/
	 HMagJFSFlgj90nsKHGwiArE6vlnye4Hi9anK2ad4yWvkBSle3v4cFrpiG5M1wnopJbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788900292;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JXLwFnkqdE6J67EAMoGXafcMkRcYwlwH8UH+rj+BfS8=;
	b=da3Pw2VfsBdFUIRIgCKJW/angrmBY2hy5yw2Clw4kWHKxAJaN4hxiWujZitGQcFBM/xh
	 PhpwqTg8k/RnCU39Rwoa8ACPzXGq85hTgHIpvVsjvHWcVZFAYZMjSKmRPwJGW62eIQCng
	 sPIzgStBcNAVlWVYKuYjvvlmaCdYpYTzuPOvNSKUjZXOiIAMBQ6J2iSAf5f406p2XdYYB
	 xCVjfc8dTUYIxCp15Dca/ZemIbFTs/UH3PInmUGG9ZukLYCf+gNjZeSeFXpZ1P4Yk2s4h
	 G60gGPZJhFD2GHY0YwySlYQbP4bwHl0VLYadTO1TR4p/EEBcOntKPZovhxoS8388olw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1FybzVZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788900292;
	bh=JXLwFnkqdE6J67EAMoGXafcMkRcYwlwH8UH+rj+BfS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZtYxjxvG7uerPY9Qkfds3OSG7c6aHMIbsnWnwneS/ybsdibf/vRQP18fHCc93uSMg
	 2oDCNAjF34d+8x/R2DGGZmKEqFR1J/ttNUD1Db4llpMoLK2m0mCLYaVYnIz+lqnJQc
	 4uPxrobTqQfLszVBDo6C5WRirhkoRjGIJOyNJNFugH1YEXLzxLJX1k5ocGZACQoihy
	 0kbHZbwWEGUT2Jyx77kUN7ENkdzzE9kheeU2HjO1H89AeKIM0hSQyokQrqqr9opWGS
	 t19Kuub/aBvHhrNLEi1ig7T3WNDeZEc3LyIj4C89+u1P6OEEPjmLMOuKYReJO6HMe4
	 nVSdVDitGwiOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8260A606EA;
	Tue,  8 Sep 2026 20:44:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BF16755
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 20:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5A96606EA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 20:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7-I6emBRS9XV for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 20:44:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5A4DF606D3
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788900290;
 b=VMXaJjqHxbvg6bRIilCwdGI5qthv1AR/dFda+Cpg/+7LHw+eP/AHrBg3kwhGYv8cIDqW
 HfA3k7v4d3P5qXF+EYzbxgf+TDKY8DqNH1uML4u0rFxpyx7FUdoZKqsTUDpbQMCdyamnv
 xwIJIVfTZ4e9n6TCYZeQNCca6gzy0jBw+Uam/Oe+05lQ3cDU9jBkU+Af/viFwNDHBdqd1
 D6vHjJzVOYBi1J3BYK0C30P1l9PrzaFqgqeD1P1O79b3sgUYrJpBsRNvj3DNs64c912KN
 TnIlu+PT2sCuikZXPzsh/2VOCksbpIl3T5zJAfseAJ/UZZhbeUltKvGK8W4AHSlpz/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788900290;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=JXLwFnkqdE6J67EAMoGXafcMkRcYwlwH8UH+rj+BfS8=;
 b=gbjwfePyLrRFexsBGK6fLGjIwjKNGifjENcBKvr5olGX64Tq0D6wCK8DqXYV6Rq99rTU
 YnE5XdUrImwBVcGp4Uc7RuxnWY3dl3CsjzrlhLVMPiEzgEHXqS+XU7NvhysOvrFKC04lm
 NRUy46ng0sDsEdyn8VKJZB11sextr8WWCBY+fyUPQ65mlxKEzMX/gGSgMXaC5lMmi24f6
 9OeH7lGdlvbdT7GK8R+XeSAb3QufzwC21B2MYA6QVfOBhcm4y6h5FsCJvB9KlmnkNzU47
 xiBBqVKUnO9KdE3m+ZlY9sViE3nz0hstvFlkxWVeZl3zZI3JxGyN1ojKXPLZVQP0Kww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j1FybzVZ; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=j1FybzVZ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A4DF606D3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 20:44:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9516D601DE;
 Tue,  8 Sep 2026 20:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDF61F00A3A;
 Tue,  8 Sep 2026 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900288;
 bh=JXLwFnkqdE6J67EAMoGXafcMkRcYwlwH8UH+rj+BfS8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=j1FybzVZ62PixgCpdcAMz2Eb68ClkUs8u85JeRschAdcYNfcOFlHlvCMm+oBBf7p1
 FpgS993NQDQ/DnxPrSseFszqSIEuVfyRz1KEQPrF77WLVrsQ3T9H9bsTZTzablQ1i6
 nDO4QCIfeM8BC6VqAygbdUGzsFCZmDxBYxLTf7975UN185zu18e0+BcZSipcFVU9Ra
 jhzxkqONrT69Omfq2MXVc7x544gEqjCLsuurOJ1ppPU3iw/walG2nSlRmpP6M6Z7Ak
 Xye0DTHnB2mqGsiTztUmrR3I5GfETqk4ItSliAlX8in75V63FZ+VBC/zZmGJGPpNVp
 UzH0bL8un4CjA==
Date: Tue, 8 Sep 2026 13:44:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Raju Rangoju <Raju.Rangoju@amd.com>,
 Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jian Shen <shenjian15@huawei.com>, Jijie
 Shao <shaojijie@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-usb@vger.kernel.org, Yury Norov
 <ynorov@nvidia.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 9/9] MAINTAINERS: co-maintain linkmode.h under BITMAP
Message-ID: <20260908134446.58796a05@kernel.org>
In-Reply-To: <20260907215439.409858-10-ynorov@nvidia.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-10-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon,  7 Sep 2026 17:54:38 -0400 Yury Norov wrote:
> The file is largely a wrapper around bitmap.h. List it under BITMAP
> section for co-maintenance.

I don't think this is appropriate, configure lore+lei if you want 
to see the changes.
