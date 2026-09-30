Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED07CA5FC5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 21:10:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E229A40B45;
	Wed, 30 Sep 2026 21:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pyC_4z0CWf2D; Wed, 30 Sep 2026 21:10:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2DA3E40B47
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790802615;
	b=hItAlREtyLTHz1wBf0BFPRwNuoTuCMz8Km/SpCnv7vlsEGGnv+sLXhy7t4gOXbVq0mHT
	 WsLxHwIyyBiWebHcZzuvIToed1KJIgErOcpWEZMsFW5Eq8RTgVnjOdFsfaltZ4j74kBpI
	 uQZY/Zt4CFuWCDfMtWs0IqE8Zc37WYMSQenSGaRap4dCM1U8qfl2l1HmWqhgZK4JoZ6fu
	 sYr2mFGAG7K5Nexq4X6fYE+31xMXu1PfRo3mFZfZQwAATsdewfAJbn4Cf6k8no5+Un/p2
	 X26Pc6hfy/gOcLlN6X48ao6v+TPjSoa0r9UHmvLfoWr9Nen4B6MENuRIKlFyqFnes5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790802615;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Rv2C60dLRPvl+tqEAsq14o0GPCWFdLg6FyDwsAVUSo8=;
	b=TqSlwfSZhmxHh/prnFjrw4Z47FGMcH/UjHOBbf44deubnRAGdRuWfP7oluQ6Rq6qD4I6
	 lxZf1jzgfRRTtGaY/9gsbc6pIZ0f/ydmb1rxqZWnKnAAuZln8D8nPpEjqiSDPogrQBOre
	 DtXEJfqiwRcQ/eFkyN9vdp0S/R658z/+K5nLXNTd6Wavzv/WdJonpsuGUthTmK06LdXxX
	 1xrvPfb4EY+CUf0120pb13/Ld8JTRrERSIFkoIafDFvff2q/K3iME25qqyD1IQYI+ApGz
	 iPFvzyg1WixzNSZ1xBsDMOY90rUHxhL7yysoGhbMVJLLERImjHKvqIIa7XnQdMzKcKA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790802615;
	bh=Rv2C60dLRPvl+tqEAsq14o0GPCWFdLg6FyDwsAVUSo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QiIqugXjWNOFr6yuVtW1crPGi/ZxL2cuhLipFYRlZWorvAmPtHFoQyOVOWX7fphP6
	 uA2HmHY7T47Dw7Ly7DUZZ276jNbaV88UJIWwuRAnFINhYZif9JKpdGhFK0uvlITnEC
	 Yghq8YL0UdeHgTrRBnmNbrE+x8KhnL16r8SF2c5lqYfm0vpaBPWHfOHCb5YTFAQ3Y5
	 Au92kdCdKry+b2z4MEquUGn8thCjUHZQFW1xMAJmVC2FeQ6qjK9ymPsT63MZkgRL25
	 2v0T4baMa/toBDiA8Qzn6DSTsaTyfl5BaWzjQmk7I3YMIdGCengvDNibYgYN+jexEz
	 0mFoez+G7nATQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DA3E40B47;
	Wed, 30 Sep 2026 21:10:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 84A611A6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 21:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A464811F8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 21:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zLhXMyY2zZvs for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 21:10:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7937D811DA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790802611;
 b=dbBfOW0HfFKHEF2jj9O1Hr4QOzavUgGihAG9Wr37Lh8Vd8lKtZshJ1ryO+kIesbX6AKb
 l1JixMZY40MBZzhZgrJQ8EAQ7VRnyjGZ9PJH1BiRw0EX3Rm3e66Gx9n0dP90D4V5r4kFZ
 BhMSBddE7HMw8FXCg2AE6PajBGbaY4H5lRrfAiOMqJDXvX3n9QdGaXTT+vZx1Wqzo2p0m
 fNoJvFWkSVmf2vjS0G+fK+7BitSO9L4V+fsLSoGXmjBLfe1SrOMQo0Gn9ZCnanyHsRNQO
 k1RLU/Dl+urIfkpy6ZXjrmpqH0qKAwwZ61xFDH26uS8/JVcPqk9dCt2+KunZF56kKmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790802611;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:Content-Type:
 MIME-Version:Content-Transfer-Encoding:Subject:From:Message-Id:Date:
 References:In-Reply-To:To:Cc;
 bh=Rv2C60dLRPvl+tqEAsq14o0GPCWFdLg6FyDwsAVUSo8=;
 b=Us0SWkpohgWBTCZ0KT94PiTbWNYFbzZvijlzF8y526ZxJrWmldAPQ0wiqXQr4c0DcyIh
 MYrSojdD0fYBdpzcJpr1VZKVaDnXOucbazLagcqEjkrtuAer/MexA+XPR6rICHndJGVfs
 cn4eIaDsuqQgo2Y2LJZIkdisMhf5IGTi9ll8V3VTVvjrW6rNOmwzkmdb/98rU4c4MMO5D
 yS9qLUo/Ffh5+6Gh9ARp7vf2+UAH8QmGQAt4trnhQK/RAFvJ1f+e4KigFNGSR4O58k48A
 EQl/xCwk52d+aSJe/G5+dZI6FpFC/Nm1Usb/xQTcOgGs4Va7GUxKVY/ONUeOBmfS6tA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=n35wyVNM; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=n35wyVNM
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7937D811DA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 21:10:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 15B1B601FA;
 Wed, 30 Sep 2026 21:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD00B1F000FF;
 Wed, 30 Sep 2026 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790802608;
 bh=Rv2C60dLRPvl+tqEAsq14o0GPCWFdLg6FyDwsAVUSo8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=n35wyVNM7jdfkTgd5kqV0MS5nIhJM0P+vKDIR2xMtdswWHZrq2XML7H6bc0sjvf0B
 dOSkNXU+UbRYaFbVLxVkV21gFKYo3F1U/gVHddtntAau8kuwlgl4F2RERGF+MzC5IV
 NyfFIDEFSZ1ZdlddnctuSj7R3LiHRsoEkDqD68CmSsvqP8nEFFftXleJyhJJKMZ1oq
 9aTebpf4qs0+l5arWtwFQizWfN7R3iFkSLSugMs/UhBeb3QWvN809Uu/1NHxo9QyEY
 OLaECp/12D+umnSo8WJrIr2QO6cAsieKH07CRPB7Efb2XpXyfSU2CTgtdWcRnGVVml
 Pf5Oqr2Xmarkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B444E3A56772; Wed, 30 Sep 2026 21:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/6] ice: fix stats array overflow via proper
 realloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <179080260753.2130503.18321701667640096193.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 21:10:07 +0000
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 15:15:42 +0200 you wrote:
> Fix OOB access to the stats arrays.
> 
> The first commit (new in v5) fixes stats code against VSI_CHNL case (ADQ).
> 
> Next three commits are simple refactors to make the rest smaller,
> the fifth one untangles the logic/lifetime of the stats array entries,
> then we have the final fix for OOB access to the stats array (combined
> for both PF and VF VSIs.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/6] ice: skip stats handling for channel VSIs on rebuild
    https://git.kernel.org/netdev/net-next/c/3fca849c9653
  - [net,v5,2/6] ice: extract __ice_vsi_free_stats()
    (no matching commit)
  - [net,v5,3/6] ice: extract ice_vsi_new_stat_arrays()
    https://git.kernel.org/netdev/net-next/c/ed3cbc4430c2
  - [net,v5,4/6] ice: extract ice_vsi_get_num_qs()
    https://git.kernel.org/netdev/net-next/c/4425fa055c0d
  - [net,v5,5/6] ice: rebuild ring stats arrays instead of reallocating them in place
    https://git.kernel.org/netdev/net-next/c/66444f06a9fe
  - [net,v5,6/6] ice: size ring stats arrays from the final queue count
    https://git.kernel.org/netdev/net-next/c/f1c3b87896e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


