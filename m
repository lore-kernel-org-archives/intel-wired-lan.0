Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE6AC001DF
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Aug 2023 15:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9BC840568;
	Wed,  2 Aug 2023 15:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E9BC840568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690989891;
	bh=GLVHcGPtj9f6ZHjSXyJLaS+aewOK2Dt7rORGkghmDMs=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gokSME3JfUKtb1z0vsXgrjzB+oWy6FxmNnti17bt3h85KphSpcS2CA/sQCXgxYRQD
	 x17AngfvcWvyW65N/hbfPgl1/gJxC+kqOq59H1ROOxm4ubQJY0D8/YYLgFGKfHBwWp
	 Abb81BBA2m583ioi84vIHFopctHVSXpljDMhXn+4AfxsgOgVyG1k8APWzfF0dwT1Ky
	 SGWNJdpNUvJK+B+vBtZpfke+jNxnM+taC4afSOJ4OaJjGDrjSh7kq6JpWZRj/TSajd
	 Wxeytex8bBGXtr+4QATTDZkiHTFkgivENN7Sng2fzO6M6idh4rnysWU827pzqmowx+
	 fsBCJWP4cpYWQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Vo7jpWbwQmZ; Wed,  2 Aug 2023 15:24:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07D19414E9;
	Wed,  2 Aug 2023 15:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07D19414E9
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 0A1691BF982
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 15:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C36180FA4
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 15:24:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C36180FA4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EQf-pn0w4GqD for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Aug 2023 15:24:32 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02EFE81746
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Aug 2023 15:24:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02EFE81746
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 02731619EF;
 Wed,  2 Aug 2023 15:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC64C433C7;
 Wed,  2 Aug 2023 15:24:28 +0000 (UTC)
Date: Wed, 2 Aug 2023 17:24:25 +0200
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <ZMp1KUZIEli6WL0H@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <8b945fa3afeb26b954c400c5b880c0ae175091ac.1690938732.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8b945fa3afeb26b954c400c5b880c0ae175091ac.1690938732.git.gustavoars@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1690989870;
 bh=AsAwCL7YysIyiApwU0DEZ4rat1nzt2aX13d1nS4nuDM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bjlME2upSvXRAf/m/cuZiwmo5VnVspD8x1KGckoVYQHKmQplffbUWB1H7uK4qoUbt
 PK8ca8wW+aNrIfdVEofOBhya1CiO7YkGKnDgOYBX8Y/96WuTNBDXaCdKIVoneZ4neu
 4ET1Zs5R64PtWXwfAcZNi/3Xcuwrd8WrG6SGevC3Zrz40MzstmH8cJLFfny/MreVL/
 6r2Vn0UxD1V2B89tmD8j7KnRXqaf/u34yVV8tTxPgCTeQKo6xSeB4QngdPUZt8tsxy
 pbStjBW31lQFPs2Pi74aEJTB+8r0w9LYtn80AZx14nr2St7H1sjMHpiIHUBOBMyhZ4
 Aib0mqDq/8UwQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=bjlME2up
Subject: Re: [Intel-wired-lan] [PATCH 4/4][next] i40e: Replace one-element
 array with flex-array member in struct i40e_profile_aq_section
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
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, linux-hardening@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Aug 01, 2023 at 11:07:06PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct i40e_profile_aq_section with
> flexible-array member.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/335
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
