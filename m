Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DCDC7EE43
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Jun 2023 22:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4C1940420;
	Mon, 12 Jun 2023 22:05:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4C1940420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686607532;
	bh=kSVL6U+ipCVMxCw6ZBIBqvRYgKip2VmbMbuvLzZpAD4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=EtUHud9EpDaJTH3ngNuH1xCm9UnAR2W6gWcBjJIC0mDTs3cns+n1A8qJ2/WSfRQE9
	 zPbqLQ6l4WikwCLwRCyTI5ZTe4jrip7fsHjOWwuPKbyFVu0TMtnX6fjkTALb0eU89p
	 qbSEv0OeUW1Cj2yylHeJk4M5/fH6+DfGvIRNCLLV8BjZ9lniM68IK6NlJbGxepJ0Do
	 7B2gAqbh76EPHayo2wvLaC0Kl8EXwTl3kR+gOsxpkcDc4uv5JhSUm0aF0Z7Ipomf1p
	 BL1Kr6yDrF+b9U9zivDpJDv1JqCvXWxHBAkvNVID8m1B2jDy74L2Ai7wUEJrOqGTn8
	 /eEZ1XIpZrREQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nZYiDgT9LZhm; Mon, 12 Jun 2023 22:05:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE3774053C;
	Mon, 12 Jun 2023 22:05:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE3774053C
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 2C7541BF286
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jun 2023 22:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED89B409B6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jun 2023 22:05:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED89B409B6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JseZqhYwcv6c for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Jun 2023 22:05:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 00C61409B1
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00C61409B1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jun 2023 22:05:29 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B9455618C2;
 Mon, 12 Jun 2023 22:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74BAC433D2;
 Mon, 12 Jun 2023 22:05:27 +0000 (UTC)
Date: Mon, 12 Jun 2023 15:05:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tree Davies <tdavies@darkphysics.net>
Message-ID: <20230612150526.10ca14ac@kernel.org>
In-Reply-To: <ZIZI5czU2Qv5KrPA@oatmeal.darkphysics>
References: <ZIZI5czU2Qv5KrPA@oatmeal.darkphysics>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1686607528;
 bh=67j+zg7ffLZr8d1DjU5R47Sa/2k7qREoVr6vB5Cd3Ak=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hatKJDtMvsdi7USGKbReD6lLZDJamN3rTvZ/af6LWTc9abHe2bv81ZiFuwsFTvgdV
 WvbJk6hoz3MePv8iMRZjT6erUwQfTAeTOUniXNm7WBUIswCSV4+HQn/PamoS5zHPbj
 9oUBAr7bY3yUJW9zLCdQHp7/LjjpQwppjP/Bwp7WcOsHRl2vbALIPU3Gq1AVkXv53N
 5fWnV4fNE+5/PxWb009SHsqJga4tZbqUzRyRVpvKP3KxlVxmtzS2FKQAJsn4XDNuTI
 THOSvXA1XDbdPG5xE+eqKzOTaU/ySDaAeKYDBL4EDJRvcEYSlO9ZXjQpS0tgUum7WM
 b9QSonWi2YC3w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hatKJDtM
Subject: Re: [Intel-wired-lan] [PATCH] net/e1000: Fix single statement
 blocks warning
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, 11 Jun 2023 15:21:36 -0700 Tree Davies wrote:
> This patch fixes checkpatch.pl warning of type:
> WARNING: braces {} are not necessary for single statement blocks

We don't accept pure checkpatch "fixes" in networking, sorry.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
