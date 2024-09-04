Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14837CD37AE
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Sep 2024 05:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C91C760847;
	Wed,  4 Sep 2024 05:57:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pjO0hwISPdKS; Wed,  4 Sep 2024 05:57:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B70D860815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1725429424;
	bh=G+G9s1luBmtPzU90PxHILb9gEYRiStFk5g6Op94i83Q=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XSjOKDeGM4eU5b9S8yaxdkxePX5bhTpdrOE1xObJpq+gOtWwxYsHG7tLtPC7jP9cY
	 YCsiJzKtUeip2zEfqdd0+DF4A2ku30JFAVC73GfZRUGwJwliuUfVZp9EMI64zzLa4E
	 jW9xFdy1Zluw8OL4ZB4r8fpOGrtNbws7astPWtWwKNcdKDlaoOswO4vuHFHxHonRox
	 ljiyc+g+wg9p2kaugsSPk49HTY3v9jnw31Ri6Z/oJB/YStsWlzqejFPkJvZguj0Db/
	 JCGyDT981/lZ5TN96M9jYPD3rZmdSFBSYUUtTxDj7T2yzIijQR8XBwgn1W4z3Umum1
	 WV5md8/awyAVQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id B70D860815;
	Wed,  4 Sep 2024 05:57:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id A8CA41BF3D5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Sep 2024 05:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9363E60815
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Sep 2024 05:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id muS37aSkLONe for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Sep 2024 05:57:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.119.213.152;
 helo=smtp-fw-52003.amazon.com;
 envelope-from=prvs=9706ba1aa=takamitz@amazon.co.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6335360663
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6335360663
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com
 [52.119.213.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6335360663
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Sep 2024 05:57:02 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="6.10,201,1719878400"; d="scan'208";a="23206570"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:57:00 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:40999]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.247:2525]
 with esmtp (Farcaster)
 id cacf0781-44cc-4b50-9e67-0cc85c46de4c; Wed, 4 Sep 2024 05:56:59 +0000 (UTC)
X-Farcaster-Flow-ID: cacf0781-44cc-4b50-9e67-0cc85c46de4c
Received: from EX19D005ANA004.ant.amazon.com (10.37.240.178) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 4 Sep 2024 05:56:59 +0000
Received: from 682f678c4465.ant.amazon.com (10.143.69.10) by
 EX19D005ANA004.ant.amazon.com (10.37.240.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 4 Sep 2024 05:56:55 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: <andrew@lunn.ch>
Date: Wed, 4 Sep 2024 14:56:46 +0900
Message-ID: <20240904055646.58588-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <3ef52bb5-3289-416a-81b6-4064c49960c8@lunn.ch>
References: <3ef52bb5-3289-416a-81b6-4064c49960c8@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.143.69.10]
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D005ANA004.ant.amazon.com (10.37.240.178)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
 s=amazon201209; t=1725429422; x=1756965422;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G+G9s1luBmtPzU90PxHILb9gEYRiStFk5g6Op94i83Q=;
 b=WnHkfufstzXiHb12HNJINkd540Ip48SL/W0+rZR1AH7YIqTdk5bbx0IE
 lFVB0GEP3UcQUW8sEJ2TDwQNcRuq8fYgoBDwfMlxy91uletXtAUKQj8Wi
 Bn1DGSgbaIHPTZheZLpuPxJHnXyBrgFGTfR0P55arHn/V9n236XLe9wv/
 I=;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amazon.co.jp
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amazon.co.jp header.i=@amazon.co.jp header.a=rsa-sha256
 header.s=amazon201209 header.b=WnHkfufs
Subject: Re: [Intel-wired-lan] [PATCH v1 net-next] e1000e: Remove duplicated
 writel() in e1000_configure_tx/rx()
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
Cc: netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, takamitz@amazon.co.jp, kuba@kernel.org,
 anthony.l.nguyen@intel.com, pabeni@redhat.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> So you have confirmed with the datsheet that the write is not needed?
>
> As i said, this is a hardware register, not memory. Writes are not
> always idempotent. It might be necessary to write it twice.

I have checked following datasheets and I can not find that we need to write
RDH, RDT, TDH, TDT registers twice at initialization.

https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/82577-gbe-phy-datasheet.pdf
https://www.intel.com/content/www/us/en/content-details/613460/intel-82583v-gbe-controller-datasheet.html

Write happened once before commit 0845d45e900c, so just out of curiosity,
have you seen such a device?

My colleague, Kohei, tested the patch with a real hardware and will provide his
Tested-by shortly.
