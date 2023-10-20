Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39E1CDB474
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Oct 2023 12:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F52D60B89;
	Fri, 20 Oct 2023 12:00:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F52D60B89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697803229;
	bh=dIWJzhlSg+uzoyCHBpX1rd2POkA5c+JBjQexN9Q/4Ek=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=cOYCSFw8Fk5R4licwPpx5RyR298URHLA7yK8l0t52zU4N8MiTTSfHjJLTQVZ2dsxQ
	 VxWNWUJ/1gpXmy0dAvPtqgpz1fo4wP/3QYQ+TU2GjYe3G5y7iiaaNpCmAfBYFyij6K
	 JvZz1lgLGXP5UlGApNcFjflOogSdVE66M5neJGiBJgyPjgdVDw5M38+72FM73Itd+/
	 n7VzcgJDHYXDZruSyyy3GnKgFznvDlfA/oHy57QUgF/BpQMHF5+GFF8ZjkkR1P2vcj
	 pNmnPzT+UwMF5U1F3oP9wpdzQv6zgT6xXtJqSAHFFFAAJRkvo1ZEnMGNHEB7WFmR3z
	 C0IU1gaCcX44Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sAOya2ukz88z; Fri, 20 Oct 2023 12:00:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DCB3704FE;
	Fri, 20 Oct 2023 12:00:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DCB3704FE
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id D799A1BF3A9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 12:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF9B884965
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 12:00:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF9B884965
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gYzFklX8yOL8 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Oct 2023 12:00:25 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A88E6831F2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 12:00:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A88E6831F2
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 932CD62114;
 Fri, 20 Oct 2023 12:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DAADC433C9;
 Fri, 20 Oct 2023 12:00:24 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 1FDFCC595D7; Fri, 20 Oct 2023 12:00:24 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169780322412.10600.10310001607168170468.git-patchwork-notify@kernel.org>
Date: Fri, 20 Oct 2023 12:00:24 +0000
References: <20231019163721.1333370-1-ivecera@redhat.com>
In-Reply-To: <20231019163721.1333370-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1697803224;
 bh=D15z/0oXu2m7VQo8gW5F0wjdgIyPA8e7yZ0xj2+0Uyk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=hoDopc0f1NLUT57g6ES2s/mq+umUbqZ/Y9WmVSY/HnUxiNIedEEBPS+Kvlijd9Vg3
 XiLydu3tu1WNn/ta40S81xTHKSI6owh1luCzUJtm913hjm+6J6KvgfaPeD/efjc/yX
 P8AvqAueblWnO8vXmrxN0VwDvgDcjSrw+LxvOsZeqj9YVPx38eEyk8n2+M+Oqz/sfq
 aYgSy+1DaN7fC3YaD1OICgWmkURBvgtvKmc6d4Y1r96eCbOIuB1lRY85p9z/IKtxFX
 uSWwMSFp/Ji+f6aNRi1ghvOUGRpkV5i5l2AS3cyx9qYzhaOj9It1ZuRCMAPvJ2yrgx
 wnSpSYkeCI9Pg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hoDopc0f
Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: Fix
 I40E_FLAG_VF_VLAN_PRUNING value
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
Cc: przemyslawx.patynowski@intel.com, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, sylwesterx.dziedziuch@intel.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 horms@kernel.org, mateusz.palczewski@intel.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 19 Oct 2023 18:37:20 +0200 you wrote:
> Commit c87c938f62d8f1 ("i40e: Add VF VLAN pruning") added new
> PF flag I40E_FLAG_VF_VLAN_PRUNING but its value collides with
> existing I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED flag.
> 
> Move the affected flag at the end of the flags and fix its value.
> 
> Reproducer:
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close on
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 vf-vlan-pruning on
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close off
> [ 6323.142585] i40e 0000:02:00.0: Setting link-down-on-close not supported on this port (because total-port-shutdown is enabled)
> netlink error: Operation not supported
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 vf-vlan-pruning off
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close off
> 
> [...]

Here is the summary with links:
  - [net,v2] i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
    https://git.kernel.org/netdev/net/c/665e7d83c538

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
