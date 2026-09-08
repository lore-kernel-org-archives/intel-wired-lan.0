Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC97C79F82
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 16:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96486405B1;
	Tue,  8 Sep 2026 16:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vOTiSjlQrixX; Tue,  8 Sep 2026 16:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C73ED40665
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788884267;
	b=D2983O7rRDdR+7dIxW+Zr84rTea3772+JonYk9jLiZD9ND9DaWCU+2YGT8Eb8v4Opded
	 zUsX44tj0hjkeBIrcm3wdMSDgKiZVedyxWxxSvxvDt3Tq9qFMBocTi73AGIM1H5iuLNBp
	 RBhpKvOq9n0lo1PWK5QO2rzr3ZBeUzs5KQbanXQyMokrCFxtRD2f9BANsBNWmKQVEOTY2
	 w+Z5PdCYEGUQDL43diG5X2GfJ43hngNqRfJnDNTFp2p/deGX1nDZDqsGJtYgE8Eovz/ST
	 G6Z9NpRcCJaD6Z/DrS0zyfmtntGgRHDmU1/1g32yqjjH4Khtl7ekqRHTJrJvxCDx4vQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788884267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tnZJ4TAR3Sf4Zu6CGRu48cBWy8dW5MWtCE2PWAjoCqc=;
	b=f4KfcS59Rd/9XP51S6L7+Jdm2KyWl5UYb9N92ZswrDb24r9CMOSJQCmM56EvUoVQiTam
	 mceSCqhPHCpSti4QSSsze5Wsv43cexJ8Pk+aZ/F2EfzqxLI4Kdl74woZwNE4K9QRTOi+D
	 UX4W1lCHvZVixomJHknY1wwQ3IHlB851dd+VQlXtNAl6fVUJs5o/PJV6kdLwmHi2EFmUm
	 L/X3NgZXpR/sixweVhOtVVdVabWUPodm8n1FZRq7RbEVP50sIXx5Jlwnku9+nG2khQnSZ
	 WRbWgFdLfiS6IywOhGvuBWNQzVb9mhlMM5EkMNOITt2ijNiAuGDf8lJfByV+Y07iRcQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788884267;
	bh=tnZJ4TAR3Sf4Zu6CGRu48cBWy8dW5MWtCE2PWAjoCqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LYOfJMqGyAf83DmlsTbLz6ultpSe8zr1h9yttdGR6CsS2Mp4yDrPkIf/NDLKV36nd
	 vLUW0CWqTjwC5I4jQZHV5/W9UWVJiQHuZ3W2q9Dzk+eWkz3Stc7qPMOf2TSkBykJmx
	 LTVqeN6BWeQ1ZKruJw8uQjDvpaW5s93Xk7YjHzgjEFECkCn4g4o7Fs7Z2eSEjQuZVC
	 xZKi2ouA/d+I1BPYTTvIsU6b4HveCfP+/PNuzOFmTGq+PSR7FYeEN0wzXJ6ug9eap9
	 WsiRFcKo9+yh7wL7b66SvimU79px9AvGPfHgQPfG6bq54bNPzLH0msJ12Frbrg1nFC
	 afSg3P7X0a/qA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C73ED40665;
	Tue,  8 Sep 2026 16:17:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 82ABD230
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 16:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C80B80BCF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 16:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wzRTX8jCS2Jb for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 16:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A60528086C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788884265;
 b=KW2PUHeATytvaS70TKyk6drn3x0lYSWm5niMA95Bod0JK4NGV+uu6sxDS2PTwge5VVka
 ikAy0maXNZxB7P7T5Z8pxwI6PnwsgdhZ8oxZpnlDQivvZpPCuWfzciHtNU/wVxE3TxiWl
 h97kv6jxeXtLGwysa/zer0BX8OHZp5+5cpkHsCGHMdEWiXcl+R9SDsSwQzXjA+s3dyXpI
 6C2lfo/uodGa3ln9Fw87BanwwMa9ZBJvpHyi09pXU711BTyFcotG9ynfCAQcmJTKVVoxa
 UKZpjZH2R8YznI0Hhg8BRzhDWH81h39zkyeZ2R87I+KFLYSpuDVEw9T15IUnU/sTJfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788884265;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=tnZJ4TAR3Sf4Zu6CGRu48cBWy8dW5MWtCE2PWAjoCqc=;
 b=sFE3thrVZLDWy2aMEM3jGqvWoHoaa5sWbWdQO0jSOv6lAIvK2cNaRcsofGNj2Mt3/esx
 x4F0YAhPgyJ5mc6cWu9sei7HL/63RvZxEVMeX/GnXwbsVvI4uINTtuYS1YOv12eRvPlJU
 i7nJe7ighIuTAeYASvY8brMgFKcaIIL7/QwRsdR3YGLustBEEYyr7GT6R26pVBXZZf4H9
 2CT76YC/yqjOcljuvXPk9YQg6ooq2GAEEGmI2mkeemGE7rS4yk5q/8Z2a5zs6Fx1A7Elm
 NlRE18N809VfRaKrlw2L4z/ubqzhJVnWgm6X74iBfCpkgpUsKGyCzWUYzvNL46E/3cA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WN59U50U; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WN59U50U
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A60528086C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 16:17:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5D5943A5A;
 Tue,  8 Sep 2026 16:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C8D1F00A3A;
 Tue,  8 Sep 2026 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788884264;
 bh=tnZJ4TAR3Sf4Zu6CGRu48cBWy8dW5MWtCE2PWAjoCqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WN59U50U5G1EKkyX71IUfpoCdPMeC5d90wuJ/gt98+xen9YCUqh8ZG/YidigHUXPP
 IhlM+NWOWtOUgVdRMk/Gj3buyE37EJaDBeIjp7O5OKeNjkfshbqSp0hAzWT8B5oBV1
 WQT3dMZizZKwfQeYfA6x2HryRi+AHeGoF8V+H/+ulNhAs+W2K5TbyoXfUAtDR0FPK1
 yTxOB4s7Jt43xHu2Zdztz3cqSRqiNiHT3JhpEqn6NupYlI+jAxMF3OpxToeAWeXJHW
 Z8DevSzdNm6cXa86lBRAhOUHOiU+hcxTbDFyjqzhX95SZhD2HKD83uyo3zgDG15oS4
 1fo4L3eHIz/Kg==
Date: Tue, 8 Sep 2026 17:17:41 +0100
From: Simon Horman <horms@kernel.org>
To: Richard Patel <ripatel@wii.dev>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Steve Douthit <stephend@silicom-usa.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
Message-ID: <20260908161741.GB40544@horms.kernel.org>
References: <20260906023319.1978945-1-ripatel@wii.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906023319.1978945-1-ripatel@wii.dev>
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

On Sun, Sep 06, 2026 at 02:33:19AM +0000, Richard Patel wrote:
> Plugging in an unsupported SFP module caused ixgbe NICs to get
> wedged permanently.
> 
> ixgbe unregisters the netdev when rejecting an SFP transceiver as
> unsupported.
> 
>   ixgbe 0000:3b:00.0: failed to initialize because an unsupported SFP+ module type was detected.
>   ixgbe 0000:3b:00.0: Reload the driver after installing a supported module.
>   ixgbe 0000:3b:00.0: removed PHC on enp59s0
> 
> This code path failed to unregister an MDIO bus owned by that
> netdev, so when unregister_netdev() tries to tear it down
> (via device_del() -> devres_release_all() -> mdiobus_free()),
> it trips over the leaked registration.
> 
>   ixgbe-mdio-0000:3b:00.0: not in UNREGISTERED state
>   WARNING: drivers/net/phy/mdio_bus_provider.c:711 at mdiobus_free+0x3d/0x50, CPU#21: kworker/u128:0/12
> 
> This prevents ixgbe from reloading, even after PCIe remove/rescan:
> 
>   sysfs: cannot create duplicate filename '/class/mdio_bus/ixgbe-mdio-0000:3b:00.0'
> 
> Switch to devm_mdiobus_register(), drop custom unregister calls.
> This is safe because the bus is already devm-allocated, so unregister
> always happens before free.
> 
> Assisted-by: LLM
> Fixes: 8fa10ef01260 ("ixgbe: register a mdiobus")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Richard Patel <ripatel@wii.dev>
> ---
> v1 -> v2: use devm_mdiobus_register() instead of another
>           mdiobus_unregister() call
> v1: https://lore.kernel.org/netdev/20260826042945.2344686-1-ripatel@wii.dev/
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++-------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 2 +-
>  2 files changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>

