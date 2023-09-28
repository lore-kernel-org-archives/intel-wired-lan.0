Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E2BE732C7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 28 Sep 2023 12:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 265E883B33;
	Thu, 28 Sep 2023 12:10:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 265E883B33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1695903033;
	bh=dwqyopsu1VXP/FvOFDEBawsqrRieKWCWLsxiilu1zDw=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=PvVEI4r9s5tDt72cj3DPic1ueXbWyUcle2iPPVzzvSiEfZ1nfgAoJOeVgKcaRTv7h
	 CcaL/RhXbRlCs5v2NYW+X/vhTtihX4ribG/qzxFcMQ8MTjtFUabiDKxQYGVg7S/AVI
	 WsTVWUDawEe/uUb40LN4H0o1rlgoYL+ZhP2z1AWo6NScicZ75whiiRxPVx+xJKdqhU
	 zLFQwIZdASnx8wXYgyAqF6fqBOLZ2QNEqUt9JPrHTlbTQlMqmRD0GUGuXqNr0DWxAB
	 iuY9IWr20/9Kzy3Ix/ATcpxarhyA6M/WNBXwYQOMrc9EJ6Fcj6a02EQGhhhUzJmFbW
	 6993eMOnC97wg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qg3a9iUSbPJ2; Thu, 28 Sep 2023 12:10:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B51E83B1A;
	Thu, 28 Sep 2023 12:10:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B51E83B1A
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id F24211BF5A5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 Sep 2023 12:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8F04400BA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 Sep 2023 12:10:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8F04400BA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K8KQGNIUxd4g for <intel-wired-lan@lists.osuosl.org>;
 Thu, 28 Sep 2023 12:10:27 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC4DF41B6D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 28 Sep 2023 12:10:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC4DF41B6D
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id BAEE5B81BCF;
 Thu, 28 Sep 2023 12:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21915C433C9;
 Thu, 28 Sep 2023 12:10:24 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 082FBE29B00; Thu, 28 Sep 2023 12:10:24 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169590302402.1991.14030271738897322227.git-patchwork-notify@kernel.org>
Date: Thu, 28 Sep 2023 12:10:24 +0000
References: <20230920115439.61172-1-mschmidt@redhat.com>
In-Reply-To: <20230920115439.61172-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1695903024;
 bh=cVOcf7Wupqr8J1dsGsFLOc3bos3BO3TBtGp9C9LDHpk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=FZyX1r7Pjp69JEbO1pa5UDhFga1vMMKml3FPRDh5wueS/NZNKVpmZZ/EcVAWJcPWS
 1fLq5P5QRxFq39mZbeipxppfYZK8xRvJcATd80BqKwLxdZ6nvx1qZ7XLfPSstPyZPd
 aJ4caxIrfY/d7sESNNMJdg6bE4EUXzWCaHGmPxrDKGdulyGhwOxN5yNq9GU7vBcdSv
 I+7bN7S8n0HwAIoYsojZhO5KGVJQ6AKOc83bxdFcEWPPHgiUdB32ZVlnr769F819kH
 h4J/zmEHdMLSbawq8CIPF3zM8FOa47iliKxvZHcvLBE3CcnaRwYUSn11YFK7sBVgh6
 yh68Joj+uoW9w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=FZyX1r7P
Subject: Re: [Intel-wired-lan] [PATCH net] ice: always add legacy 32byte
 RXDID in supported_rxdids
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
Cc: michalx.jaron@intel.com, mateusz.palczewski@intel.com, leyi.rong@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jacob.e.keller@intel.com, pabeni@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 20 Sep 2023 13:54:38 +0200 you wrote:
> When the PF and VF drivers both support flexible rx descriptors and have
> negotiated the VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC capability, the VF driver
> queries the PF for the list of supported descriptor formats
> (VIRTCHNL_OP_GET_SUPPORTED_RXDIDS). The PF driver is supposed to set the
> supported_rxdids bits that correspond to the descriptor formats the
> firmware implements. The legacy 32-byte rx desc format is always
> supported, even though it is not expressed in GLFLXP_RXDID_FLAGS.
> 
> [...]

Here is the summary with links:
  - [net] ice: always add legacy 32byte RXDID in supported_rxdids
    https://git.kernel.org/netdev/net/c/c070e51db5e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
