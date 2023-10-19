Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF66CDB482
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Oct 2023 16:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 073A84289F;
	Thu, 19 Oct 2023 16:10:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 073A84289F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697731829;
	bh=6EZYnZT8imuZX+MVLdhNaLV33qs+kIZWC1Nshc6JLSo=;
	h=From:Date:References:In-Reply-To:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JVg/Yzu8XC8AaPiMUYR6+1nuWSXFw8IIcs5T4l4FH6xKP/OiTOfSUfj5iWHgJW9s+
	 t450rPfQEL3NxQKbEuDL++SiJ5QEiaWwK1dTsH+H8XOXiAVKMoPHP/0v0WCKERyzBJ
	 OImsIJTjIpWyStESYwfbCRYYcF2dnAaHo9LkCKpRMfmBMEhN9FDmExKQWpsOuoKRMY
	 Y1rY5N6jVV4ckat60+1Dt8uQArLIsNMbeEiohS+yPPJwC9DtZuWyc7iNx5ajtn2f76
	 kp0CH31oTSAsGR8Tdc0DYR3Qb8uKdu2ssxJbp3QiNspGcq1BbDyN5YMMbFaShVFvLF
	 lp+uPoFHsx/yQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fTDdQOKnV-p2; Thu, 19 Oct 2023 16:10:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2412D42C88;
	Thu, 19 Oct 2023 16:10:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2412D42C88
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 7BA331BF36F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Oct 2023 16:10:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52FAD4289F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Oct 2023 16:10:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52FAD4289F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a6dKN3HGD2f0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Oct 2023 16:10:25 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F3D242886
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Oct 2023 16:10:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F3D242886
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4BBF361938;
 Thu, 19 Oct 2023 16:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9B79C433CC;
 Thu, 19 Oct 2023 16:10:23 +0000 (UTC)
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D2C9FC73FE4; Thu, 19 Oct 2023 16:10:23 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169773182385.32102.13500484487081368542.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 16:10:23 +0000
References: <20231018123558.552453-1-ivecera@redhat.com>
In-Reply-To: <20231018123558.552453-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1697731824;
 bh=BE/4wyJzn7vqO89mbnyTMDJ6LgXLjJtglZRTGIZ98Lk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=O0PDjHslPWAMHNN4aF8/IAecO1ZQWt/JoKB5AETbSUvQ96Og4SvHXWY3j91yqxw7f
 Bt6D358sBjNeI9D+WfCm8eiepZ5xoMjJV5J4Vi7ES4PqgV+YBVIERzBjztMT8Oi4VY
 uHO1lEOLmN5wjD/hiHMYMkFvjIQSlU4YW3Hnw52EiGkMNNblFCnJS0eXVSPDVGyjNo
 tYY+XknbRmrwn6Tq4zZD/LfaUf71s53f5nF8oIPT4ddUpmeXETE0KNqBuvlZ/7JaFU
 +XquT1KJb89B4kpOWHHTfP7z0Mig/D3uY352JBWIqxJ/6S1e74T/LM0GgfXAHVUs42
 qvq76xZbPAbMQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=O0PDjHsl
Subject: Re: [Intel-wired-lan] [PATCH net-next] i40e: Align devlink info
 versions with ice driver and add docs
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
Cc: jiri@resnulli.us, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Oct 2023 14:35:55 +0200 you wrote:
> Align devlink info versions with ice driver so change 'fw.mgmt'
> version to be 2-digit version [major.minor], add 'fw.mgmt.build'
> that reports mgmt firmware build number and use '"fw.psid.api'
> for NVM format version instead of incorrect '"fw.psid'.
> Additionally add missing i40e devlink documentation.
> 
> Fixes: 5a423552e0d9 ("i40e: Add handler for devlink .info_get")
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] i40e: Align devlink info versions with ice driver and add docs
    https://git.kernel.org/netdev/net-next/c/f2cab25b0eb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
