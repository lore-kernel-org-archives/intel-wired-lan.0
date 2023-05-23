Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01A8C77B75
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 May 2023 05:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 546F6400C1;
	Tue, 23 May 2023 05:55:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 546F6400C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684821330;
	bh=CphLx4cbEB8efk/cJ05un5zX0jvzqMi9OREB3T46TI8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=D2W4Z4Hlp3YkcgxTLye0MMER5HVvG0Z1uSmNjdGOSOjmyUKE0XpMAwn6TBpaX/VVe
	 I9ltesa6FDAPpiw/gPk3906O1QhjMC1lv9LVTDwdgbQII3JMcw45WhlVcZFBFFF3AD
	 21X5sAUmO122tSyqb2V5r98c1wNb8Ah9O56ZaYuhFuX3t0LF144tyWCfrQ7M2z+Evn
	 D/cU9lQ+BMy8g1JuxAT9m4HBpaS/e5mSBSReHTTnk8RRuOcN4BUvGOeSkUjB0LHz0x
	 2KtpfWwm2eTcJ13gagjD0pAIiXolpUxPTGdw8qvVAJPSGtLiLryvyoAw1Jn9vd6waD
	 Dh8YtcvS+fzPA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cp3mTH5uM2P5; Tue, 23 May 2023 05:55:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35E4C403C4;
	Tue, 23 May 2023 05:55:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35E4C403C4
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id C46671BF37F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 May 2023 05:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0EB260AE3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 May 2023 05:55:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0EB260AE3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fbWYaO6bZc4t for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 May 2023 05:55:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B133607A4
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B133607A4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 May 2023 05:55:23 +0000 (UTC)
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1q1Kz2-0091FK-2G; Tue, 23 May 2023 05:54:56 +0000
Date: Mon, 22 May 2023 22:54:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kees Cook <keescook@chromium.org>
Message-ID: <ZGxVMAa/3QOd3cRf@infradead.org>
References: <20230522211810.never.421-kees@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230522211810.never.421-kees@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=f9sp9X29rgCQutb1zyE01/AbOq
 vvWhdCJdNJmWOTdpGbrPMqnfPwdWtXyJItgUJklC82G5xiqj0mrMp5gXWlrUyIeXR+Mo++eDaMld4
 tWsVWKUUVdFiL9GEbmNRBORxElvBLme8vx5TTV6tYdjJ1e5eSV/VbS43P+Khj8kMOh1O1PmULkLJL
 0OOzVdMaikHhPYDVaCp6lILsdt3BDSSS47fwmWLB1b9IJk0UQN9gdlYyugYZbkMVru3EO8fQg0G+G
 R7W4esEGccYKZIxg5UNd3i+kRa2lJcm+3kpcPRdptBLx2RRxWT1S+kucCJVOfA0C6e6Y7HByMAMiS
 62Q8eALw==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=f9sp9X29
Subject: Re: [Intel-wired-lan] [PATCH] overflow: Add struct_size_t() helper
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, Daniel Latypov <dlatypov@google.com>,
 storagedev@microchip.com, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>, Guo Xuenan <guoxuenan@huawei.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 linux-hardening@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-scsi@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
 Dave Chinner <dchinner@redhat.com>, Keith Busch <kbusch@kernel.org>,
 HighPoint Linux Team <linux@highpoint-tech.com>,
 megaraidlinux.pdl@broadcom.com, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Tales Aparecida <tales.aparecida@gmail.com>,
 Don Brace <don.brace@microchip.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
