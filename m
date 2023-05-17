Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DE0C77B7A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 17 May 2023 15:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38D5D80C34;
	Wed, 17 May 2023 15:08:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38D5D80C34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684336136;
	bh=3jf2UB+VwzmHgl8RDxgT8/cRctnKTpSeoWuNUvFBRAw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=OoSKcQ2OosykNaRuGdMTq0YXG10965i+ytIeCYHExu2bOB9oI19InBAVIXbHhHSfz
	 0irVdHHVg8qopNIJNHXCqrdH2pMLVLA+0zO81VfwIOswgmyUn9PLI1LBwuqSUyvMnf
	 vh0pkUBqoUaoXbClfyRZQXKXV2h99HmjUSaIxviPeBqLMAMtnEvBOd7Nt/HcDGI1GI
	 rdsIb698Uzbgqf9vx4o74cKgVLbItGRcZTOKZlVZbgYwPex8fpKJZdCgMYZNb6YL+f
	 eCD0lUKtrWsw1TbAu6ykZqDYdO7bXzTR3zObzYjZhArVe4chd7RmT1jRjjSu8NPGBD
	 GcQK410ngDBtA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNGY9ZdZt5c5; Wed, 17 May 2023 15:08:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F4BE81A47;
	Wed, 17 May 2023 15:08:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F4BE81A47
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id E39FC1BF410
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 May 2023 08:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBD1381FC4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 May 2023 08:15:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BBD1381FC4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6vSoNi64AnxH for <intel-wired-lan@lists.osuosl.org>;
 Wed, 17 May 2023 08:15:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A15D581FC2
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A15D581FC2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 May 2023 08:15:05 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8345368C4E; Wed, 17 May 2023 10:14:58 +0200 (CEST)
Date: Wed, 17 May 2023 10:14:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <20230517081458.GA32192@lst.de>
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
 <20230516161841.37138-7-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230516161841.37138-7-aleksander.lobakin@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Wed, 17 May 2023 15:08:53 +0000
Subject: Re: [Intel-wired-lan] [PATCH net-next 06/11] net: page_pool: avoid
 calling no-op externals when possible
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
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

So while this looks ok, Eric Dumazet had looked into some optimization
for this touching the core code, and promised me to come up with an
even better version a while ago.  Eric, what's the state of your
optimizations for no-op DMA syncs?

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
