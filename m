Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A60BC43334
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Jul 2022 16:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4D0E4091F;
	Tue,  5 Jul 2022 16:32:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4D0E4091F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1657038727;
	bh=y6fpSwDRzbK+xziX/qAs09gYA0zlCXgkaP1ER4UiBNE=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=eKLd9YS57AzfmbCNng1DPo6sTKHMFxpfZ/zt7SpaR1cTcTcyzkLu+kqa8O4hSA03h
	 THr4d0FcFHUrqbhm5vJ2XmlPant4VMxcjYOkYaCg9D3qx8B33ybw01PbHirRIf2uPk
	 tePKOyjs0dM9rcD86GknOUes4APPxup/F8tUkdoZpeEL9TieOMYSHjLpE3UsVpOscs
	 /38CD1Q81GTnRcQtuxQpVbbpGbN5JZbP3/TbjPWnQT+zBCnsEnxhU2nEkTtRIXUaEV
	 5WOjFgIe4eIXTqGMTb+z9+XndRHyVHAeJ33NrfR8vix3eKKCO5l/qZH29gpfUN1SO8
	 PZW6Ag21Y590w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GVroFgTy-6QU; Tue,  5 Jul 2022 16:32:06 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FED9404BF;
	Tue,  5 Jul 2022 16:32:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FED9404BF
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 3FC331BF5D7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Jul 2022 16:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DD5E4015D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Jul 2022 16:32:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1DD5E4015D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id suUZwuuWFLe9 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Jul 2022 16:32:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 449E4400A8
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 449E4400A8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Jul 2022 16:32:04 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 4C846CE1C2F;
 Tue,  5 Jul 2022 16:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73959C341C7;
 Tue,  5 Jul 2022 16:31:58 +0000 (UTC)
Date: Tue, 5 Jul 2022 09:31:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Piotr Skajewski <piotrx.skajewski@intel.com>
Message-ID: <20220705093157.03693507@kernel.org>
In-Reply-To: <20220705102205.25511-1-piotrx.skajewski@intel.com>
References: <20220705102205.25511-1-piotrx.skajewski@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1657038718;
 bh=nOfl3SaVrrnK+8zXiHluUvky/UYDifs76aFJk+P9QnM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EbVBc/vbuLzkNaNR7+MLAZ0BmVl3Q7E4BtUOiv9bPxP/cPovX5BK7qeZQKpwxWai7
 dhR49Tf3w4vp0q8tVIcYGpKNifn6o0UktolxXuSPEq8dE2zhj5dTwCa3La3me+TcQb
 f0UNpuos1TEM23Wd6Kn1HVNNt9LUbY3JFiZHghwlpve/CY3+7tyhi/CR4FdEWE1GP9
 HPc0lyqhIlgk8gTYYpQiBvGrv6O0cRnmmz3r1g3Mm8F2pFEsrf98BmGvLBMesWMAJx
 A+KnB2Bw7SSeVB0SsJ9D+izepdNHjIsnm45urkD0oli7FIAjkTtMV4FGpGUGJHZpsB
 eqNg1cFldmXIQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=EbVBc/vb
Subject: Re: [Intel-wired-lan] [PATCH net v4] ixgbe: Add locking to prevent
 panic when setting sriov_numvfs to zero
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
Cc: intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gVHVlLCAgNSBKdWwgMjAyMiAxMjoyMjowNSArMDIwMCBQaW90ciBTa2FqZXdza2kgd3JvdGU6
Cj4gSXQgaXMgcG9zc2libGUgdG8gZGlzYWJsZSBWRnMgd2hpbGUgdGhlIFBGIGRyaXZlciBpcyBw
cm9jZXNzaW5nIHJlcXVlc3RzCj4gZnJvbSB0aGUgVkYgZHJpdmVyLiAgVGhpcyBjYW4gcmVzdWx0
IGluIGEgcGFuaWMuCgrwn5GNIFRoYW5rcyEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KSW50ZWwtd2lyZWQtbGFuIG1haWxpbmcgbGlzdApJbnRlbC13aXJl
ZC1sYW5Ab3N1b3NsLm9yZwpodHRwczovL2xpc3RzLm9zdW9zbC5vcmcvbWFpbG1hbi9saXN0aW5m
by9pbnRlbC13aXJlZC1sYW4K
