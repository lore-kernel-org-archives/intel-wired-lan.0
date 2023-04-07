Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA1AC6FD1D
	for <intel-wired-lan@archiver.kernel.org>; Fri,  7 Apr 2023 15:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB94F616B2;
	Fri,  7 Apr 2023 15:25:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB94F616B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680881127;
	bh=N2J1+yKzl3mJmZ9f4YdQt6RE2RufRoT8O3vDj2ProwM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Ivo7I+VoiyWj+aGMguyATheUW4CGNtOFKuxMi2ztC3tZXVMBewOmf4QgX4uqyTPUa
	 X2mqO5GsId5TbEGNYzPD/9G9JMLZNBK51rBpnsEDVSqeN1wS0Cg4rU0F2TzHTj/jW7
	 Khg43cVDf9HiaFfVabZVCco7f4XVpw31s+osudb+GUcrmWCrK9jAp3y7k2gg64SjyG
	 BIj+Gi4pRfOKZ7mtlMBuGnXhNsqtqCkIu3C403j+waUdVSaPrcQVnfxIY0IQhyHv2M
	 w7yrrG7IlPPXrJjyyPCnDl0PlJm+ixQAYzjbt54wuT1FNx6UtmlzMSwlEZjv2OrHXU
	 toP301YNDNu/Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0p01geJTejeC; Fri,  7 Apr 2023 15:25:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4BEC616AE;
	Fri,  7 Apr 2023 15:25:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4BEC616AE
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 896291C2E1D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Apr 2023 04:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69AD641F7A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Apr 2023 04:45:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69AD641F7A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XkT7fsMEwip6 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  7 Apr 2023 04:45:42 +0000 (UTC)
X-Greylist: delayed 00:05:42 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64BB841F78
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64BB841F78
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Apr 2023 04:45:42 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E720F67373; Fri,  7 Apr 2023 06:39:53 +0200 (CEST)
Date: Fri, 7 Apr 2023 06:39:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <20230407043953.GA5852@lst.de>
References: <20230329140404.1647925-1-pavan.kumar.linga@intel.com>
 <ZCV6fZfuX5O8sRtA@nvidia.com> <20230330102505.6d3b88da@kernel.org>
 <ZCXVE9CuaMbY+Cdl@nvidia.com>
 <5d0439a6-8339-5bbd-c782-123a1aad71ed@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5d0439a6-8339-5bbd-c782-123a1aad71ed@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Fri, 07 Apr 2023 15:25:25 +0000
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/15] Introduce IDPF driver
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
Cc: willemb@google.com, netdev@vger.kernel.org, michael.orr@intel.com,
 intel-wired-lan@lists.osuosl.org, Jason Gunthorpe <jgg@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, decot@google.com, shiraz.saleem@intel.com,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

FYI, thanks to Michael for the feedback.

> As explained in the Charter, Intel & Google are donating the current
> Vendor driver & its spec to the IDPF TC to serve as a starting point for
> an eventual vendor-agnostic Spec & Driver that will be the OASIS IDPF
> standard set.

Having both under the same name seems like a massive confusion.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
