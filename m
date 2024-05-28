Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383EAC25B78
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 May 2024 20:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E04E2406DF;
	Tue, 28 May 2024 20:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWDgEi6EK9n8; Tue, 28 May 2024 20:01:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12414406CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1716926461;
	bh=esh6t9ue87P6FkyVROvlYBsU7wflbcuScjreFGBG2tY=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=fc4+btPnTQy44qUnJVpaOA0Hwe6vnthaELHwMXZ7P4PWe7PgfdNAyrgxKCXN/qar3
	 cI4ODhpzVpH4GfHv1rDw/jkgdz78zloAF2KfK28Voi6ZZic3EcN7ZkSAmeO2kG2A8c
	 ut0VOcyomX4j8gVBLBzfuwHbTHi/1UKHsSd9r6UfzOdGYkOnE6FxoHjjmcC5Vlxeh0
	 E8mEzwFW5BVU34YlxIz6r9Yv/IDWcq63Ktz8fFOuo7ZzoTlzdB1W3/dlqpMe3tWJzk
	 TuBYVhr+svAKzbu4EA7yd2jWmchgbwu8C7sIj5vzaYpetpPriFPU709bV1T2ND3jXW
	 pQLpJFFYST90w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12414406CC;
	Tue, 28 May 2024 20:01:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 030F91D2C80
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 20:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1000406CC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 20:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xB4w0WFIl7Mi for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 May 2024 20:00:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1479540547
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1479540547
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1479540547
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 May 2024 20:00:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BBD2E6242B;
 Tue, 28 May 2024 20:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F138C3277B;
 Tue, 28 May 2024 20:00:56 +0000 (UTC)
Date: Tue, 28 May 2024 13:00:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Message-ID: <20240528130055.4ecf339a@kernel.org>
In-Reply-To: <20240528112301.5374-12-mateusz.polchlopek@intel.com>
References: <20240528112301.5374-1-mateusz.polchlopek@intel.com>
 <20240528112301.5374-12-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1716926456;
 bh=xUabrjVkxN8o4R8ntx8FJJfFQMqqMQAguaktepl1+hU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gn47sZRijwKiuKA20fqG+AfzEoinXxjFOCa4zW+RomeYJR0vFdGqqYWfb/i67yP3G
 8hcmqAWJSDA6TXiZlMeZFDswMBnrHJ7OZczEJmpBR4c+cJOVQu/+NVeseNhUzMMesC
 KF8apKSwmFd8Ei3LpkqRU8epLmGUjyHN5u916oLT5MRtLzarcqPd/yzDceWjVzqQbb
 I/+NWToW5VovDhmdBxGL3+GhAof/9ucuk0dXZ4GBv3FUlZYhBPvG+L4aB37ALQuy7o
 jb7jsNxuQq+Nm4CX2WWWe+PAHbD7kUzKkRAkQCF+ZVoCRGe+X3QvyVvnO4+refc59r
 MsKVXFPV3C+2w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gn47sZRi
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v6 11/12] iavf: handle
 SIOCSHWTSTAMP and SIOCGHWTSTAMP
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
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Wojciech Drewek <wojciech.drewek@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 28 May 2024 07:23:00 -0400 Mateusz Polchlopek wrote:
> +	.ndo_eth_ioctl		= iavf_do_ioctl,

Please use the new ndos:

 * int (*ndo_hwtstamp_get)(struct net_device *dev,
 *			   struct kernel_hwtstamp_config *kernel_config);
 *	Get the currently configured hardware timestamping parameters for the
 *	NIC device.
 *
 * int (*ndo_hwtstamp_set)(struct net_device *dev,
 *			   struct kernel_hwtstamp_config *kernel_config,
 *			   struct netlink_ext_ack *extack);
 *	Change the hardware timestamping parameters for NIC device.
