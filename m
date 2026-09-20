Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06851C982DF
	for <intel-wired-lan@archiver.kernel.org>; Sun, 20 Sep 2026 00:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A32916065C;
	Sun, 20 Sep 2026 00:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qH0ohZBM8yqb; Sun, 20 Sep 2026 00:41:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DC5066065E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789864879;
	b=MoZmebkFZmLs3vIz0/GT5EJZm3ivnTbq3IrOKBNVR1ZfI2HM3HR7snzqLJzg5Bdh7mdQ
	 1C8G9lB+Q0+ePD7NmXz90xHhxU8CM0lgDYWq/ueQJAMpz2FBpkrLzwcHrJS7X8uo1u8vh
	 f6oH8JMcGcRd0lgwHaBEwX2dK/RdyU61Suw23jGzX5rgEk4Y2Hea4Nxn0NlQkPfIMUpPc
	 L3ntV4mvs8MDAeHTrtUHl7OQDYwQkX6c8gELfBiz6WQ+VNEtGNu1oHQTlgZKNZEMaRPnI
	 ZTVfo+/kg2GLf4jy0fjKVRHrE4scIbnXik7f7foCGapLkkeirpE0lua/mdgwFvygsvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789864879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pldEBeieoNLIMuf3xzY7/FQ4h1jOVkgeRGPmSStpAeg=;
	b=hsgluOE8wDnV+vWyHEuwMlm6ahg3TBphzihtwqB31o5Zvz8fr5tAnmpE9vkQh9gjhTsH
	 /ucF8Gptm7Rodgk7jx34KDBkwcLlK3LPd8//45LseV5D8sUPTi/VO2CqVrV/mU5EGDkUu
	 euWTZX8JQqhWk8A1fC0Y6qInElLX6xlsgsxEyrd/uH7wNpweSAmeRYbsiW13Dfnt5AzpY
	 za93M4JhjfezEph+9e+8LKSGSxI5IaTLZ2AgsVL0O8OxbOQWSOhP/vX+fjPx6bGf1Q9Kv
	 arEOZNsP9BFnoQ8DQqWNdElZYFkr2O+Inab85BVWeLNqMFwI6OSqTL7h6pqDvCNpVPA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789864879;
	bh=pldEBeieoNLIMuf3xzY7/FQ4h1jOVkgeRGPmSStpAeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tN65A25Ic5BnqytUaKQL2TtOAHTJ7HhjGLzx/KhiR67FeHwVvy8TUKjfFjkyTR9JQ
	 muCh9mtjIkP3szNKNcg/zeCc6YZo/StUT4Lp7qvxVek/ojn4hSb95rIonK8uKxhD3K
	 G5JsJHT3+Tx/xmWbQ4eqmzUolW3k5RBbtVUfog2FKqIjF63Q6bjkjvc1yJwxR+h6Tt
	 alrW3N2YwnMvfb/MfyVVX7PeM93W6FjT2hCwlTrrfVRi04rPu4twvec0H8Tsx3sC5p
	 w5hShLJMwo5XQ+wyKf0WiM2RulAMLTk4vbpEGmEYwq5Nc5J8joi9re3taYAJv/sG+F
	 qDwEHmko61WWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC5066065E;
	Sun, 20 Sep 2026 00:41:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D980F3FA
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 00:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB2088101F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 00:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n5zDW6aYEBmb for <intel-wired-lan@lists.osuosl.org>;
 Sun, 20 Sep 2026 00:41:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 06B7C80FB4
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789864877;
 b=os+mMdqIaZdmVVXe6Fd2V+Hk1UjDpsQ2tRh0tQifi1LGXOKvc+EASZF2KGfJxMuyrkDM
 1YpzUta7wMxXFQ3StPDu2DzpkF01ylY8dOShMrw5yVIUFYLZTLcyHuXJ1gSX/8SooU5UF
 E2MKjRxuMV4i5hKZvGetZIgY/HkGOg1UmY8szDdb1IeP/YBMJT7XCTE/h32UQvgfbzAoH
 iEQ4k1aV7+krEMDCPGvrsk6htZuJMvK7PaMOk8wTTQUsgLx6Uz4o+pNvLtzLHuIHlbSoE
 nQOxgF755MJwj3HN6fqjwXGDs9zFOi0X2lUD1pGN9INX9eRHsdWqVqsO92X68dUqTuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789864877;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:Content-Type:
 MIME-Version:Content-Transfer-Encoding:Subject:From:Message-Id:Date:
 References:In-Reply-To:To:Cc;
 bh=pldEBeieoNLIMuf3xzY7/FQ4h1jOVkgeRGPmSStpAeg=;
 b=KfmY8aM/eI0rLrkiPfq0s0EnOFT0HbPSuZlsLwIWaI83XO9IXDsQva8rG85gHfB54h/z
 yDSHf/VASzuAlxxCYMDqSHt//7g1zcLTnqC9sxMkCAjbcnPQVwjDzL+6eygRsUl3D5Rel
 vRQfjYKpA0snfAqDz3vVqTvKaMbGDf5Pp5Vvc6NMmRR/PlDt9pz7DlyWolMtM39A3rPVD
 T+wyYUjI0Sjny3BO95IQuZ1S05/Z+2l0LpG+7NG0H4r9tvH+Qy/Y4ll7fgNVnT20DZlJm
 ssOi+TfoZ/2fI+UL/3SwCDfacsW7ZMYrfW3h5A0Rfkbk4v0TWoCn3kwzRNH4b/Hm48A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="iw/RZudZ"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iw/RZudZ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06B7C80FB4
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 00:41:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A3A760136;
 Sun, 20 Sep 2026 00:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3674D1F000FF;
 Sun, 20 Sep 2026 00:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789864873;
 bh=pldEBeieoNLIMuf3xzY7/FQ4h1jOVkgeRGPmSStpAeg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=iw/RZudZflo07UepdUsNoLomL9kP8U+VcGoZH1lq76C7Hi6ussDP5UikNkB734d86
 l3B3MXE5Zc7X7RrjX4TpJIVdmp/B3hGBn5+ZoNnGUV16nkbz6djLrRfGZgSK9b7Enm
 gchOvlQQEkrWuL68TjyzJkaen9d+CWC+y/TaudYfUfOsfnP6A5a8nn88+hT9HlwImb
 if2KRi6q6JiM2P91F1pzMDq5Y+ZZUtdNoccrqEYktkMLHKKJBRRUSBAm8gVDEgH3Tz
 kBc4bE9D5vNj04GIXeQv6WWh7sKCjulMMhiHqND2hgZk+WOQ9dGwWDXk0XNVH5JPrS
 bScvF10iYHNnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0BAE3924A49; Sun, 20 Sep 2026 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: use assign_bit() where applicable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <178986480565.1504357.13555480327800349461.git-patchwork-notify@kernel.org>
Date: Sun, 20 Sep 2026 00:40:05 +0000
References: <20260917-net-assign-bit-v1-1-e9c97965e080@nxp.com>
In-Reply-To: <20260917-net-assign-bit-v1-1-e9c97965e080@nxp.com>
To: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Cc: dario.binacchi@amarulasolutions.com, mkl@pengutronix.de,
 mailhol@kernel.org, Raju.Rangoju@amd.com, PrashanthKumar.K.R@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sukhdeeps@marvell.com,
 skalluru@marvell.com, manishc@marvell.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 shenjian15@huawei.com, shaojijie@huawei.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, sgoutham@marvell.com, rkannoth@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, alexanderduyck@fb.com, 
 kernel-team@meta.com, brett.creeley@amd.com, GR-Linux-NIC-Dev@marvell.com,
 shshaikh@marvell.com, jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
 daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, jjohnson@kernel.org, toke@toke.dk,
 nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, pkshih@realtek.com,
 richardcochran@gmail.com, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, imx@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, peng.fan@nxp.com
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

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 20:39:52 +0800 you wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit and their
> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> API.
> 
> Done with Coccinelle semantic patch:
>     // set_bit -> clear_bit => assign_bit
> 
> [...]

Here is the summary with links:
  - [net-next] net: use assign_bit() where applicable
    https://git.kernel.org/netdev/net-next/c/8830e65ed46d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


