Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB97C43458
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Jul 2026 12:07:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D129881115;
	Fri, 10 Jul 2026 12:07:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFpcFRJb275L; Fri, 10 Jul 2026 12:07:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB47281108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783685275;
	bh=y5XvCgitT9kdCWv+PywisGMr6Q3n0tEns6fgqvf8TXk=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ofVM6GCAjDq9vNcZ1gMAtuL/xwnEDhq0LJaGNRkod+c0EqRRGX54VgZL3VPnktgNT
	 xcGdfgcnruvcGnqzSVwEioyKsHHMNnPf6KAYl0Xt/zxp92h83Yc+ECNFEMW2pVOwHF
	 rwd1BGdLO/Qh/aTGNIle93VK2kha4T92/D/bmkQ2ULS699cBgHLP5yp5x20oIAaBMX
	 QvRzVMCG7chBCqABAPS9bOHPDKqvMMZBv0MZrnbrKkZpFBM+n36uvkPzkOTxgra4qv
	 4ODwlYjgKLTerE9CMSXNNX2kupQQJadhkisHjuobXb6/j0QcByJ/Oa3JtL57LiwaZE
	 nADFxp1G4nNRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB47281108;
	Fri, 10 Jul 2026 12:07:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7332DFD1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Jul 2026 12:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D39760693
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Jul 2026 12:07:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vwEGHGPMeOH5 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Jul 2026 12:07:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 39EB76068C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39EB76068C
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39EB76068C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Jul 2026 12:07:50 +0000 (UTC)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 719DC4C1F29993;
 Fri, 10 Jul 2026 14:07:01 +0200 (CEST)
Message-ID: <b4d17a58-f6e5-48c4-9bf0-230ca710ea2d@molgen.mpg.de>
Date: Fri, 10 Jul 2026 14:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Adrian Pielech <adrian.pielech@intel.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 andrew+netdev@lunn.ch
References: <2c5c3c03-7a4d-4020-84eb-825bd6ed1e78@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2c5c3c03-7a4d-4020-84eb-825bd6ed1e78@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [ANN] E830 NIC join intel's netdev-ci
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Adrian,


Am 10.07.26 um 13:20 schrieb Pielech, Adrian:

> I'm pleased to announce that E830-XXVDA2 NIC from Intel Ethernet
> E830 product line joins the suite that tests ice driver against net-
> next-hw branch.

Great news! Thank you for sharing this on the list.

I am curious: Is there an overview of the test lab?


Kind regards,

Paul
