Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556CBC4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 Dec 2023 17:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFDFB40565;
	Tue, 12 Dec 2023 17:13:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFDFB40565
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702401195;
	bh=KGV6mFKpBOdQePSh1IleC9l4MyS0Azio0FplhWCBn+s=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=itEBodAt9yuQiYAhMcX0ctXJzpoRxXSJMd2b7LGyC7BZFz2g80Cx8zbzRcXbnsGQj
	 k8+zyJcL93sF+yNpSANxUVU44pNFv1jF/xjuEKoS7CV6prwxzOa6W1LvMmxyYaJnXf
	 c2uvvsJ0jYL6d48X53NXquuCjwUwVJopTegngYAIqcqdFqG0TXxiFX7Z/I3QBoB0RF
	 OtzRXJTHAfn2bptEtXSBJG2Q0Sn4RSavpnWEdSHrfk9+/jCftHcR9hglrDB/nEV/UM
	 bj6wiTcTzarv0ihlE5y7PT3Uu/Wrq2sL8DZfnIt3f0IijhfAsVAYZWTXmpjfNHTPPS
	 6IKoPLc4ov6QQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lPG0W8sZBQeC; Tue, 12 Dec 2023 17:13:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 554344077D;
	Tue, 12 Dec 2023 17:13:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 554344077D
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 40D051BF3C3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 15:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC5006156E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 15:32:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC5006156E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jZ_f_Ly5M00k for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 Dec 2023 15:32:08 +0000 (UTC)
X-Greylist: delayed 375 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 12 Dec 2023 15:32:07 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 967D861574
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 967D861574
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 15:32:07 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 47F9B68C4E; Tue, 12 Dec 2023 16:25:44 +0100 (CET)
Date: Tue, 12 Dec 2023 16:25:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <20231212152543.GA19879@lst.de>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-4-aleksander.lobakin@intel.com>
 <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
 <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
 <534e7752-38a9-3e7e-cb04-65789712fb66@huawei.com>
 <8c6d09be-78d0-436e-a5a6-b94fb094b0b3@intel.com>
 <4814a337-454b-d476-dabe-5035dd6dc51f@huawei.com>
 <d8631d76-4bb3-41a4-a2b2-86725867d2a9@intel.com>
 <6c234df1-d20a-812e-3c58-7e3941d8309b@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6c234df1-d20a-812e-3c58-7e3941d8309b@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Tue, 12 Dec 2023 17:13:12 +0000
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 03/14] page_pool: avoid
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Dumazet <edumazet@google.com>, Michal Kubiak <michal.kubiak@intel.com>,
 intel-wired-lan@lists.osuosl.org, David Christensen <drc@linux.vnet.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Nov 30, 2023 at 08:20:44PM +0800, Yunsheng Lin wrote:
> I would prefer we could wait for the generic one as there is only about one
> month between now and january:)

Same here.  Please fix this properly for everyone instead of adding
a pile of hac
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
