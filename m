Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5B8C2BB3F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Nov 2023 17:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEEF3818D7;
	Mon, 20 Nov 2023 17:16:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEEF3818D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1700500579;
	bh=7HEB4qN9ttNiGgtX9xqPZOQhYjahHp0XN1mQJMaB4MY=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qlj+rSALvKW92+ih+RT21X/KbVS9x3z+LzBZLHvKeK0tW8+yquGMU4r/z2lJaUiy4
	 KlXmR5qK2j8SDBTIQBJKaJzFKBPUii2h6h2xhErtCBatmGATTLzGRtB2RnAzidFNKd
	 2aHUF/+8jj+qKBvcE9dtee6OXJBfxohCVl4HYUi69xYtofQSSUX3t2UMyReV9cEnmL
	 FwIVEX59cqC5oWRYI5nXk0H7XvOFljl7Pd6s5rxTDhpclmdK+LSOPN10fpGkDdqidP
	 5GUkp0QpWJOYSkulhGY8kAPjZFPVtpPbHH+ytU8933ofXkqJTfyyBAV/oLs+gTcaou
	 vXcfrrY3NZZcQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gA4ks7Y8Cd7N; Mon, 20 Nov 2023 17:16:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA201818E6;
	Mon, 20 Nov 2023 17:16:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA201818E6
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id E480F1BF3E1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Nov 2023 16:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9603608A5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Nov 2023 16:28:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9603608A5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AZcjYHptQjV6 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Nov 2023 16:28:10 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C7D2607E1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Nov 2023 16:28:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C7D2607E1
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 6B7DFB81914
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Nov 2023 16:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90994C433C7;
 Mon, 20 Nov 2023 16:28:06 +0000 (UTC)
Date: Mon, 20 Nov 2023 08:28:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Message-ID: <20231120082805.35527339@kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 20 Nov 2023 17:16:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1700497686;
 bh=9JBfn1ONMcmxNC9o8jdLY4A6lh+CyQcaLZ1ppSfApx4=;
 h=Date:From:To:Subject:From;
 b=P5FiXsDz4o4RPxK5F7XgWz7QTFzCmL384ea3DAuxusgEAIQKdXUc/34R0kZIb6JVN
 XBmkqT+uT8euF9oelcVl7KGQfixANtc5QDH/oy5sUFTDC71lD7CKGXddsQ/tNUGeFO
 zwQORAiKlAxcTPEfU/RIMpe55B9f9XW/KES2XyrxxRdyvBkZjWGmMKb3EK06JTFnN4
 FkMDDI1jg0jHMx/nPdtleG/Jwc+sU60yihXR+AElsUSKTqZpgw3n1wWW+ASXZXnyTC
 8FqX4dttxEc1tY99jaXE0tdlF7qepmqXm/M2lc5Ag/XVLFoB9661d6jjoOK2Ei4Zpd
 0hus3+DQJA59w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=P5FiXsDz
Subject: [Intel-wired-lan] [ANN] netdev call - Nov 21st
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi,

The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).

So far the only agenda item is a minor update on CI,
please send other topics!


In terms of the review rotation - this week's reviewer is Intel.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
