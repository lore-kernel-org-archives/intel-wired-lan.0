Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64791C3271E
	for <intel-wired-lan@archiver.kernel.org>; Mon,  8 Jul 2024 13:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FF7981182;
	Mon,  8 Jul 2024 13:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7tgF4O4o0agP; Mon,  8 Jul 2024 13:53:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72A4481184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1720446781;
	bh=jIpl4ss1SkLDm6klDrpxqUvCJukfOE+7mGpBVm048W0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AQC+QKJbgslgnWHNjcXkpewcBtPB0MfrRlf+LLsxrCvTgK+8gODCI11KqKmUv8kQg
	 oljCVzdT5Qz9zmCdv93dWgvTszFlRrOrhb442LLmrJ1c5cjCmCn4soNixaS/iST5GS
	 4pa5GwZcztwTKEmHEW5bXoPhc9MBkO6M26zls/x4kkCC81i2F2KKoeYoX3bFH3yjbF
	 M+dZvY4j3jB5AsoQ8HAZctBuX7Nbrvrm2OZuNKP55GEkGCHb0KSzk24LAUSIeg5lH2
	 e165eExrKiHK6keXKpFj2RC/XHAouOj/4sZVfExOXDgWiEryPaQ+2To2uTus3fx8nY
	 H7VZa4Cit7LzA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72A4481184;
	Mon,  8 Jul 2024 13:53:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 961801BF484
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jul 2024 13:52:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F5C96085F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jul 2024 13:52:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kcRc3A9t-_Fe for <intel-wired-lan@lists.osuosl.org>;
 Mon,  8 Jul 2024 13:52:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E74676084D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E74676084D
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E74676084D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Jul 2024 13:52:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3400860C94;
 Mon,  8 Jul 2024 13:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9C0C116B1;
 Mon,  8 Jul 2024 13:52:56 +0000 (UTC)
Date: Mon, 8 Jul 2024 14:52:54 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Message-ID: <20240708135254.GV1481495@kernel.org>
References: <20240704122655.39671-1-piotr.kwapulinski@intel.com>
 <20240704122655.39671-4-piotr.kwapulinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704122655.39671-4-piotr.kwapulinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1720446777;
 bh=Y4BaQbuYt8F1sF8Wrtz6aYSuj6Q/I8XFlw9K1Vcdx8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RGMP8Tzq72Wg3XlfBFCl2MJJMKMhE/11B+fiUX20XruvA4UvO29P8MSKEkFjOTkXL
 Rv7ZRTVG6TkeA5LpWYiGKp1ao6ujhAvrN/yzaDvRDjUohQvPxLmyNHiplOTWoEuaPL
 oXSDhrX+umgjlpDaTUj+RQaLJNv9nz6t1Wwaefusx7vp1krk/TQvp5OzTRI2dxyZvf
 RPtrDupIy7880+ggoWpE6ORxfQu4ShCF/vwQIBjILOVSW6Lyw+yN2WfyhlOu4RwfjY
 KMmoiVZrEpqA4t7rFnTOA4fekSgGCQwBYLvGx0SZrk7s2EcYc3xp4qWcytVMyw4YNi
 VR8PzW9ghfR8A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=RGMP8Tzq
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v8 3/7] ixgbe: Add link
 management support for E610 device
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
Cc: Stefan Wegrzyn <stefan.wegrzyn@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Jan Glaza <jan.glaza@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jul 04, 2024 at 02:26:51PM +0200, Piotr Kwapulinski wrote:
> Add low level link management support for E610 device. Link management
> operations are handled via the Admin Command Interface. Add the following
> link management operations:
> - get link capabilities
> - set up link
> - get media type
> - get link status, link status events
> - link power management
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Thanks for addressing my review of v7.

Reviewed-by: Simon Horman <horms@kernel.org>
