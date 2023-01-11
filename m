Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5D1C5479D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Jan 2023 15:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E120A419A5;
	Wed, 11 Jan 2023 15:07:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E120A419A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673449655;
	bh=aw9MpNsdBoIf3s+61mv5PKo81v64y4rtUXwMxiRR2V0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vrM/zfBNXixT6nGtMJf0EUmgVubqb4XyBcuWn+QTZDG7vmPW/e+qNktKKG60I1ZK7
	 uIa3TztN3GeJI4eksykqlnYJgXlvjCW0zZfZ9ZeIj5YOR/WH5OROhhuz+P9eXTuVnw
	 wr45ZLIMIu/nuVLz6UKEX+aj7Jz0o9AJZWkFLUWkOZBr9u/WooiR/e+IbE040EGGhx
	 WpAHbtXEOg4/5XJ0ok/VRBIbNgmLaOONiiH0GWmQHBOYHsU3qJDlkaiRO6qGwN3Kgt
	 6oQEywrNNdEojS7Gb0AkWa71WekX+iyzirEhJP9MbpRzu8y58r2qSwrOEtF2C24DdD
	 7d7ZmQFEKOQPw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qbGIIjaZ12Bn; Wed, 11 Jan 2023 15:07:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0329419BC;
	Wed, 11 Jan 2023 15:07:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0329419BC
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 457061BF3C0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Jan 2023 15:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F54881FD2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Jan 2023 15:07:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F54881FD2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sbP6j_sh8KQX for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Jan 2023 15:07:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8E4E820EE
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8E4E820EE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Jan 2023 15:07:31 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E1349B81ACA;
 Wed, 11 Jan 2023 15:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE85C433EF;
 Wed, 11 Jan 2023 15:07:26 +0000 (UTC)
Date: Wed, 11 Jan 2023 16:07:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Hai <wanghai38@huawei.com>
Message-ID: <Y77QrFNIQrKB8xvV@kroah.com>
References: <20221220012143.52141-1-wanghai38@huawei.com>
 <54066d0e-ef50-183f-74fe-551bb99741eb@huawei.com>
 <Y7vtbayi+2GfkhEa@kroah.com>
 <6fcc6c81-96fb-112f-3aa9-3e2d58ecb2c8@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6fcc6c81-96fb-112f-3aa9-3e2d58ecb2c8@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=linuxfoundation.org; 
 s=korg; t=1673449647;
 bh=aFrvoqKWG153xIDPgIDZp4R1sSPgs+OyQK/bgpbZFjE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V1Zt1eHKFeGTo6EMQ/caKrK+6KQgb78mOIMzztorWNFbzBGiqJwPFdRyC1IN7n8H0
 TUInbFJ2uvaJgm3b8l8uJzbYE3ESrbHNfjlCPWaabC3lCxsyIFzBZOpDh6LEyzE/Dd
 /SkKcuicMD3XO5Z8Kyd6lnqH+T6lN53WisMufKrs=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=V1Zt1eHK
Subject: Re: [Intel-wired-lan] [PATCH v2] kobject: Fix slab-out-of-bounds in
 fill_kobj_path()
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
Cc: rafael@kernel.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 alice.chao@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jan 09, 2023 at 07:15:05PM +0800, Wang Hai wrote:
> Thanks, I thought you had forgotten about it. I hope I'm not disturbing you.

No bother at all, it's now added to my tree, thanks!

greg k-h
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
