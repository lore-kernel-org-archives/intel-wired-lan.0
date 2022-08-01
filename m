Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B89C00144
	for <intel-wired-lan@archiver.kernel.org>; Mon,  1 Aug 2022 19:50:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D6BEC400A8;
	Mon,  1 Aug 2022 19:50:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D6BEC400A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1659383418;
	bh=a9X7pSrU1/C7tLvKu9hZjOyj5BimBI1/Sj3rot+DRBY=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=xCve9/IjDwB5jfM/ZBfNkwmmxhSEHHdG4mEPywu8YHyRspwipsuxThabY6JxPYvvU
	 ue9Ix189KvxBebXxpJwg39vS7jVvlCParGdeW22Hs+QaTChGvuc0S7uOsoXK8Bgsb9
	 POuAv5Yd6El7gPBwtzZ8ZAsRS2F0rEoGjXQte+MsaCzT382JQaBoAdgkU2pUbaT6oS
	 tCeyBX+fukes9OL7yeZXZ3FvPWUx9BTgRLwfNTmekcFfYPwK3q8EYTjFlgYwP/wcKb
	 Cuuhsf9sdaTh/NVT1hYxLv8/2SwjLQONJ/0tvAMkEXMLsMDbL7sgcQbSasbnXZIWra
	 WjvjeFaRXAn2g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YFMPrz_cOyg8; Mon,  1 Aug 2022 19:50:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id D7ADD400F1;
	Mon,  1 Aug 2022 19:50:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7ADD400F1
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 64A441BF334
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Aug 2022 19:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E24381947
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Aug 2022 19:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E24381947
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NF9o3ktPGb3f for <intel-wired-lan@lists.osuosl.org>;
 Mon,  1 Aug 2022 19:50:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74D2A81926
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74D2A81926
 for <intel-wired-lan@lists.osuosl.org>; Mon,  1 Aug 2022 19:50:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5E1E1612C8;
 Mon,  1 Aug 2022 19:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4742C433D7;
 Mon,  1 Aug 2022 19:50:13 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 99EB1C43140; Mon,  1 Aug 2022 19:50:13 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <165938341362.9721.5948160417702328560.git-patchwork-notify@kernel.org>
Date: Mon, 01 Aug 2022 19:50:13 +0000
References: <20220729101755.4798-1-huangguangbin2@huawei.com>
In-Reply-To: <20220729101755.4798-1-huangguangbin2@huawei.com>
To: Guangbin Huang <huangguangbin2@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1659383413;
 bh=XbMu4u7qC681Oufg6pCEm6FQOATQp4hHLAqIxj8axgM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=SLFLmUC5jqcVenV89Nrn74jXFdib/t/Lx6eMfh+TM2Icy/INYG/Tp7DnTOootOVBX
 OTe4DpfB4cGVL35DGzHlC7kZmpz0j062ECkrEGfug6oILhJBGFJpYtAeE2Ezto/SUC
 uWPifFX/DQsgVh19zZA377A0+vjDbhDWmJhlsxzgO5MH6BBjuZuq2f9+WsW+kCXRRZ
 ph3GDfCAclM4yQCEZoh19jAGXyLt9WwYHVLmRl7wi5OBcTVPq5GgRbQy2Oz99NhsiL
 lLbVYLrqOBmLHlDfgoIYrbEdmDuOllWeIQ/ryz6mV0nQpMEK1C3x9UbyYAraya2Kp3
 uGmqE7HEPlrOw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=SLFLmUC5
Subject: Re: [Intel-wired-lan] [PATCH net 0/2] net: fix using wrong flags to
 check features
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: snelson@pensando.io, intel-wired-lan@lists.osuosl.org, lipeng321@huawei.com,
 brett@pensando.io, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
 edumazet@google.com, netdev@vger.kernel.org, kuba@kernel.org,
 drivers@pensando.io, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This series was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Jul 2022 18:17:53 +0800 you wrote:
> We find that some drivers may use wrong flags to check features, so fix
> them.
> 
> Jian Shen (2):
>   net: ice: fix error NETIF_F_HW_VLAN_CTAG_FILTER check in
>     ice_vsi_sync_fltr()
>   net: ionic: fix error check for vlan flags in ionic_set_nic_features()
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: ice: fix error NETIF_F_HW_VLAN_CTAG_FILTER check in ice_vsi_sync_fltr()
    https://git.kernel.org/netdev/net/c/7dc839fe4761
  - [net,2/2] net: ionic: fix error check for vlan flags in ionic_set_nic_features()
    https://git.kernel.org/netdev/net/c/a86e86db5e6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
