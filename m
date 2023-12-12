Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4013DC4167D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 Dec 2023 21:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD508819F3;
	Tue, 12 Dec 2023 21:28:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD508819F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702416537;
	bh=Ymm0VB3yuuyvHtiGROCVD0oiLWTjT6gdWT8sQtYqgb8=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=yET7X80+Sb2oc8sxn+jE7BdiQ0mRw7+r+MEGXiEj/wkylBKH9aA+FmSqDOcvVGsI8
	 9V8CsCPCu4bmz+7JAMOxLoSfjpEqqJWZBuTj2srKhVQNnwJD3H2ovDgEvvQCMSSHhD
	 bO0zQwWNDiUTqtNkEhfpFToSfPHsDWXuBJMjM2utrANncB/s+2mFOEfo5ebLETtRbS
	 qvY/B86iDuqvZZ1r0ALKU/CgEMUhjNB66oBmC2919slQQ6pgiixKHq5lZsuVOMS4HZ
	 QRlE9WUxsyHhvnvNVxMXnBMytuLL+OqPnf7cy7rVbQJUqsqxdqJO4PQy6PqCGxgzVV
	 xSoNhXE4M/WMA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sd-5ajkwbutQ; Tue, 12 Dec 2023 21:28:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 051E881A33;
	Tue, 12 Dec 2023 21:28:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 051E881A33
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 0B2AE1BF2FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 21:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE1A340291
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 21:28:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE1A340291
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VaU8C0naR-NK for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 Dec 2023 21:28:54 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1667D40223
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 21:28:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1667D40223
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D079A619E4;
 Tue, 12 Dec 2023 21:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDA9C433C7;
 Tue, 12 Dec 2023 21:28:52 +0000 (UTC)
Date: Tue, 12 Dec 2023 13:28:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Message-ID: <20231212132851.59054654@kernel.org>
In-Reply-To: <20231211025927.233449-1-chentao@kylinos.cn>
References: <20231211025927.233449-1-chentao@kylinos.cn>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702416532;
 bh=7g23NbUaG9IocrYKtfcJQkcARBOL/6cB9B3IBOO179w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RcEo5PtV4dcAiaQiaiYd9nV1ggHqQ2IfUnP05wzeW+Exw/eoKMP0vUwUlK+ubJvFm
 D7kgFLDhvfVL3xvjQzuFVEDI5tENiXmEq6M1OxK74Y+wAh/DOuK4XPs9a0VpSGAIUD
 i5IF/Az+XIJYBNC9C468l2agnMAnC8MrxjHg0h6riZL/zzzKFtO58KCnhPa1M+FkWm
 O72fM02HcAHtEEmUIzDrYIiFJzKVwvVmc5xd9E0gmajxplF6jVUAlHY9I2GmfQkAZ1
 yGOsAKJjb/MtAJNIkGIpIb7pPD+2DwJXDOTrr3EE6r4MxjJ8C9BI/YIT8t5zkNRkRQ
 8/rovDm3IMRZw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=RcEo5PtV
Subject: Re: [Intel-wired-lan] [PATCH] iavf: Fix null pointer dereference in
 iavf_print_link_message
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
Cc: Kunwu Chan <kunwu.chan@hotmail.com>, przemyslaw.kitszel@intel.com,
 jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, jacob.e.keller@intel.com,
 intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 11 Dec 2023 10:59:27 +0800 Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fixes: 1978d3ead82c ("intel: fix string truncation warnings")

No need for the allocation here, print to a buffer on the stack.
-- 
pw-bot: cr
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
