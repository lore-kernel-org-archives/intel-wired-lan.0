Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EA2C05052
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Aug 2023 01:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 035264157B;
	Thu, 17 Aug 2023 01:37:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 035264157B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692236248;
	bh=lSyhjiivyt61IWsAihCMhK1vGYzYQ8qdtO6V9W9zXyg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=DgOV1l82B+acPKHcLjNNKsnDMlk/vDQSpnODW/RYeI0uBmMf2a3b1dwKmr/iySedS
	 uiBeBANYw86FSWA1PWbwgGnidBekECWN8MKE0OBrmKOv+3szm2Lp5GE0S32v3yqrbM
	 QfHbk/xbvWegZ3NpZbAjg+d5kxFqmuCb3bceE/2SR/QdFdn3q3AqSPcpYmke/90sfi
	 iagxp/9X4MbXLuUU/xUXjcC7d8WV3ZbO/abYZ0vNSZz7O58teYLyET1cj1JDWjKJbM
	 msXVDLcxWFdccKieUtBHA7puFvRccqR4UaKIixZW4C2J0wg9KTN6VsLVBCi5w3Z3jG
	 Aa1YgBA1xFRMg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HQhM7QQMIKXI; Thu, 17 Aug 2023 01:37:27 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1018C4179A;
	Thu, 17 Aug 2023 01:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1018C4179A
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id DD7321BF338
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 01:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACB266144D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 01:37:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACB266144D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ECcqp5weDSyI for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Aug 2023 01:37:24 +0000 (UTC)
X-Greylist: delayed 2196 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 17 Aug 2023 01:37:24 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 347F960AFB
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 347F960AFB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Aug 2023 01:37:24 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qWRNU-004Kfa-5o; Thu, 17 Aug 2023 03:00:44 +0200
Date: Thu, 17 Aug 2023 03:00:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Message-ID: <240678ed-221f-4893-a410-140c9f4f4674@lunn.ch>
References: <20230816235719.1120726-1-paul.greenwalt@intel.com>
 <20230816235719.1120726-3-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230816235719.1120726-3-paul.greenwalt@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=A6PqXQPKNCab21F83uHC2c2WRfIWO9pCVwKo10L2oU0=; b=wTGUnOrwid3VLaDlwxSbq0letR
 /1fZ3O7HsHtZp6nl8IW6gAXKbVfUQlT4PsOqK7ajNPQbR0d8SQQDRVa0nf610KdUa9c9dCWVaXvNa
 Ni0GbmDX3p9KF7uD6WOFEPcfHR8PmNcLPbPKz79jaF1WHTOhXLZegusD1PKwYThi1TzM=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=wTGUnOrw
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/7] ice: Refactor finding
 advertised link speed
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Aug 16, 2023 at 04:57:14PM -0700, Paul Greenwalt wrote:
> From: Pawel Chmielewski <pawel.chmielewski@intel.com>
> 
> Refactor ice_get_link_ksettings by using lightweight static link mode
> maps, populated at module init. This is an efficient solution introduced
> in commit 1d4e4ecccb11 ("qede: populate supported link modes maps on
> module init") for qede driver

Could this actually be partially shared with that driver? Some are
identical. Maybe a generic implementation in net/ethtool/ ?

	   Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
