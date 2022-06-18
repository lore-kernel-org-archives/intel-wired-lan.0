Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A31C433EF
	for <intel-wired-lan@archiver.kernel.org>; Sat, 18 Jun 2022 03:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B6C060AC0;
	Sat, 18 Jun 2022 03:30:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B6C060AC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1655523049;
	bh=Zrc6OxnJxj8Rlcn6Oz6UUU+lyvLQa5iVgtgMzBzXV3Y=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=SUbMgWA2eO9UsH9R53nQS6USEEUtcIoeeJh50g2QpDXQfUvG9wnKqXdvrNsenRZNJ
	 dHuokiNl3PKTWYjaOiyycEAFtDhPTXlSc32djVijWgncgkXjgYsTLFSOyQTKQR/00D
	 ohzO/dQ9k+YNQ7q633kd5XIgh7DCAAebRp/784mvjVZ5ax3dqvmYg42eBJmUdaH2To
	 tMZTl6fGUhxQiSuvbH80tdl2wB1mX7PCc858PrQsYULTda/LJBJeUrl2D4cchZNLdy
	 1MrVrtzBP2Ge6EBgMW0ibQBvnKSHiljCzf2xPQd96rpASOf4W733t8QZnmlE+3YZbz
	 AJKy/iaVN6HwA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bHRoj7YlJ1bY; Sat, 18 Jun 2022 03:30:49 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA3B560E5B;
	Sat, 18 Jun 2022 03:30:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA3B560E5B
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 012211BF9CB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jun 2022 03:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE05C83EB0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jun 2022 03:30:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE05C83EB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3RkBwjEq-eiQ for <intel-wired-lan@lists.osuosl.org>;
 Sat, 18 Jun 2022 03:30:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E21783EA9
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E21783EA9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 18 Jun 2022 03:30:46 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0975461F60;
 Sat, 18 Jun 2022 03:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0F5C3411B;
 Sat, 18 Jun 2022 03:30:43 +0000 (UTC)
Date: Fri, 17 Jun 2022 20:30:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Message-ID: <20220617203042.33d3a124@kernel.org>
In-Reply-To: <20220617201644.368bab1b@kernel.org>
References: <e5c01d549dc37bff18e46aeabd6fb28a7bcf84be.1655388571.git.lorenzo@kernel.org>
 <f137891f-eb33-b32b-5a16-912eb524ddef@intel.com>
 <108bf94b-85a6-98d4-175b-2c0d43e17b11@redhat.com>
 <20220617201644.368bab1b@kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH net] igb: fix a use-after-free issue
 in igb_clean_tx_ring
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
Cc: netdev@vger.kernel.org, edumazet@google.com, brouer@redhat.com,
 intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net,
 magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, 17 Jun 2022 20:16:44 -0700 Jakub Kicinski wrote:
> It got marked as Awaiting Upstream so the bot won't respond.

Ooo, the bot got changed!
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
