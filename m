Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29278C54E94
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Jan 2023 19:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A058381D7D;
	Wed, 25 Jan 2023 19:01:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A058381D7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674673306;
	bh=vvHuc90ixnzjsdqcSmL382lzx7Mfpu3GwT2t3ePCXLw=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=E8NAT3/b544EogFHL3tM0byVTqustLpykaJvX2SijSaRdQafcdDfM3LtCdO6tmHMC
	 N+YGR1BCk5QNBUMg6lUMwlcmp1lhuHFz1keF1Afq2A/X/kHe+mXZMJGP9Ox2DSQUKC
	 Wwj3MW4JzV+wDsTg7JoUcNDUrCTxH0XBTnMAag2SODm65zpFhWSb2uXMyrCPQ2oWpf
	 MF/wCSBSF8lm7mtsN5E+UR2Aa1boM1QXPi3rrhOyEiycuMzH6OY3vjFBEdKar0i96M
	 LzUK/NO3fVlpS7i1VboY0lkG3H3QnBH7S7E4i+zUkiLHhwSjMikVrHWvtWRRXM7kZR
	 342FsUr4z0Hyw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4x_Ij_AmDpBN; Wed, 25 Jan 2023 19:01:46 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFF0E81E2A;
	Wed, 25 Jan 2023 19:01:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFF0E81E2A
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1EE881BF39D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Jan 2023 19:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF52C41920
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Jan 2023 19:01:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF52C41920
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MWkqNnhToMvr for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Jan 2023 19:01:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFB4E41833
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFB4E41833
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Jan 2023 19:01:41 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 2A696CE2067;
 Wed, 25 Jan 2023 19:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AADBC433EF;
 Wed, 25 Jan 2023 19:01:34 +0000 (UTC)
Date: Wed, 25 Jan 2023 11:01:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Message-ID: <20230125110133.7195b663@kernel.org>
In-Reply-To: <cover.1674560845.git.leon@kernel.org>
References: <cover.1674560845.git.leon@kernel.org>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1674673295;
 bh=AXaUtpNg3QgcsfBT6bp4+5ZQ5MYWDv9VhOmUZbTWnSA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JZLmlLIsVO5/PNbtG96h90qvJZDxugRBOB6FfaCfl767Y3S+jHYyamYGzDLnqsV+i
 hm+PbuwyiX8nzUHL3++9JOwsm7HZiKMnFKxVc1KX2EVGb1mig9eYgHaHqhGj0yJHJu
 hxAEcn9mXXNjtwEDP6fy0OAWUO3+X1cjhA9EIOpe7ntewNDBRBTblFx7NJM8xwuGoi
 mOaHNAW52/vQs9X1ORq3L+o81eafxZcKsyB+jftIQU905ijscxtKPa0itatbKW8WQ5
 T584vxFIV0tdNdmrwZIZTN60YO/bJ1mHQ21TXQZa1DvS1AR80xwBk6ORrEX2EcZmqG
 uyFsyben+XrsQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=JZLmlLIs
Subject: Re: [Intel-wired-lan] [PATCH net-next v1 00/10] Convert drivers to
 return XFRM configuration errors through extack
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
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Veaceslav Falico <vfalico@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Jonathan Corbet <corbet@lwn.net>, Jay Vosburgh <j.vosburgh@gmail.com>,
 oss-drivers@corigine.com, linux-doc@vger.kernel.org,
 Raju Rangoju <rajur@chelsio.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Ayush Sawal <ayush.sawal@chelsio.com>,
 Simon Horman <simon.horman@corigine.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "David S . Miller" <davem@davemloft.net>,
 Andy Gospodarek <andy@greyhouse.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 24 Jan 2023 13:54:56 +0200 Leon Romanovsky wrote:
> This series continues effort started by Sabrina to return XFRM configuration
> errors through extack. It allows for user space software stack easily present
> driver failure reasons to users.

Steffen, would you like to take these into your tree or should we apply
directly? Looks like mostly driver changes.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
