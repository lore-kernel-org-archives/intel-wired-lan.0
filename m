Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA5DC4167B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  6 Dec 2023 17:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9204420E5;
	Wed,  6 Dec 2023 17:55:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9204420E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701885345;
	bh=TGDkPj+OW9EfJtctdHUFndGfkq5x+eQAoLVWqmhwzDU=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=sgjIsA0MSA7tt/7yt8HFN21e5uqp+M1IAYpWAQzuZktFI4WhuP0EAgcKDY/GvCe2z
	 4IcBk0yyQZrCRMNShUBXBiQJd0MF7n74exsrQ30medUQO6S/I0RjBGNdnZ+W20Q28j
	 MWx2A5lQtYe31nneseqhkCjjcbxR2oUEaNgwth7gJoSvXXGXfSHniwlV1cCkuAAX85
	 N+OJoG3rzN3NgRlEUFJpQCH1DFuAt5arFdr0CSP+X3hgrhGR2LfAM2gN/lSmqdVh4g
	 pzGCXsnKciuAFu6+5cuuKbdgJkI1dA7yEZjg/Tw8Sx65BYx4KZm5u51U/r5VJSyZ/V
	 OkiKD0Q1PABzg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F45SWOP4ukYX; Wed,  6 Dec 2023 17:55:45 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id D65A5420E8;
	Wed,  6 Dec 2023 17:55:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D65A5420E8
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 00DE01BF335
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 17:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBB27420E8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 17:55:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CBB27420E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DVwfE-MLa8qx for <intel-wired-lan@lists.osuosl.org>;
 Wed,  6 Dec 2023 17:55:43 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31097420E5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 17:55:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31097420E5
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 63C7761DF9;
 Wed,  6 Dec 2023 17:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3032DC433C8;
 Wed,  6 Dec 2023 17:55:41 +0000 (UTC)
Date: Wed, 6 Dec 2023 09:55:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20231206095540.5df7c5a5@kernel.org>
In-Reply-To: <20231205230049.18872-1-ahmed.zaki@intel.com>
References: <20231205230049.18872-1-ahmed.zaki@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1701885342;
 bh=TUDaZmgDVeZf7ahZppg49YtSKlr7WValVfZgX1WCnVI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TK8kw/XUVkKievC9keVIJ/kgNUTLNcfUMDiIE0sX9zBqoXq3H33LGkxmfpBxTQUEf
 X4Vn6NtX3K3TwtKKadtebAEL/rUorESSrG/6I6JbvL1TlrQ6jZFWpWFX30VIAdNQAl
 yIg/TYJePDYhtU6QDHajNNwk07clyGKKaIwZKmv4ExPjt4B65PA0jnOkdPnxdF4FiF
 LIDOrMTVv/7ON8GKbjcRHAwvKd46IOynujTAKQKpgTgbbNy/HANNOWEZ5G9HPgcPhk
 kucN9PqPJ3kllVfH8kOD/CZZX/0yotzEZDp3ghchuL+18cKjKv7RBgZHpIG9/ecaYj
 fBkmLlFUdtgew==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=TK8kw/XU
Subject: Re: [Intel-wired-lan] [PATCH net-next v7 0/8] Support symmetric-xor
 RSS hash
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
Cc: mkubecek@suse.cz, andrew@lunn.ch, willemdebruijn.kernel@gmail.com,
 corbet@lwn.net, netdev@vger.kernel.org, gal@nvidia.com,
 linux-doc@vger.kernel.org, jesse.brandeburg@intel.com, ecree.xilinx@gmail.com,
 edumazet@google.com, anthony.l.nguyen@intel.com, horms@kernel.org,
 vladimir.oltean@nxp.com, intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue,  5 Dec 2023 16:00:41 -0700 Ahmed Zaki wrote:
> Patches 1 and 2 modify the get/set_rxh ethtool API to take a pointer to 
> struct of parameters instead of individual params. This will allow future
> changes to the uAPI-shared struct ethtool_rxfh without changing the
> drivers' API.

Looks like it breaks the allmodconfig build.
-- 
pw-bot: cr
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
