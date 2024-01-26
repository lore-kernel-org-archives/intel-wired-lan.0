Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4D1C47422
	for <intel-wired-lan@archiver.kernel.org>; Fri, 26 Jan 2024 11:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71EE181839;
	Fri, 26 Jan 2024 11:13:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71EE181839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706267606;
	bh=Vk9u1I4vNB2nwLljmjUk1jQ6ixCBNTy86Cxs4jWTr0c=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=hv27QI8L9ReeCPc7qnNkpCwJWn2hSsAJ06AonoUQUjASnK/FVb3QI1dN0ZEKcajis
	 0e6605rMCOLsh1fjnZ1Mz5lZUpzGKgD2UYt/sigJ9GANnn/kKrVZiv9/vO1Fobh22I
	 Ofp4jpu1ZcmVFW/Px9Lnm2KStTtLW/afMC8aFOgKt5wV7ehV9OX9sgncxjcpeSBEOm
	 3Odc7kXJU2YkY5SUYiCiRDBdUIYgtEh8/vT0Eprkpgg6ymxXAf1+JHtgD92ceJyeMF
	 yf6e97kv9+y7NmsDYVWTtN8YUkYVVRuRXqJ9AZC2mlYcSPUGF8xqgYzzKKNWf2wq4A
	 W1qGvegje5iWA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dNNnWS11Lle5; Fri, 26 Jan 2024 11:13:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E11181775;
	Fri, 26 Jan 2024 11:13:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E11181775
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C34B41BF3D8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jan 2024 11:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B17A41EB5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jan 2024 11:13:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B17A41EB5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0aHXF3TyPimi for <intel-wired-lan@lists.osuosl.org>;
 Fri, 26 Jan 2024 11:13:21 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E55C041EB3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 26 Jan 2024 11:13:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E55C041EB3
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1597761E5FE05;
 Fri, 26 Jan 2024 12:12:34 +0100 (CET)
Message-ID: <fb90ae9c-1f83-424c-878a-8b7e472bb6f0@molgen.mpg.de>
Date: Fri, 26 Jan 2024 12:12:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Takeru Hayasaka <hayatake396@gmail.com>
References: <20240126045220.861125-1-hayatake396@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240126045220.861125-1-hayatake396@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Intel-wired-lan] [PATCH net-next v3] ethtool: ice: Support for
 RSS settings to GTP from ethtool
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
Cc: Jonathan Corbet <corbet@lwn.net>, vladimir.oltean@nxp.com,
 linux-doc@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 laforge@gnumonks.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, mailhol.vincent@wanadoo.fr
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Takeru,


This patch was sent at least four(?) times to the mailing list. Could 
you please sent a patch tagged with [RESENT] or a v4, so there won’t be 
several replies to different threads.

One nit below:

Am 26.01.24 um 05:52 schrieb Takeru Hayasaka:
> This is a patch that enables RSS functionality for GTP packets using
> ethtool.
> A user can include her TEID and make RSS work for GTP-U over IPv4 by
> doing the following:
> `ethtool -N ens3 rx-flow-hash gtpu4 sde`
> In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.

Should you sent another iteration, please do not break lines, just 
because a sentence ends, and please add a blank line between paragraphs.

[…]


Kind regards,

Paul
