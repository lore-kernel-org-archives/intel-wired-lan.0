Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775DACD6E45
	for <intel-wired-lan@archiver.kernel.org>; Fri, 29 May 2026 05:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 209DC41DEA;
	Fri, 29 May 2026 05:39:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bB_-JLkSNQJF; Fri, 29 May 2026 05:39:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72B0D41DE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780033140;
	bh=w1ONFpfIdPAWMceFFrpPiIqatePtthElUP6Et+fSb8M=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hshjNe/7UOcYcBQkPbTEuq4hxxztZQriCMSfgnbuShC+XVXnqjvteefOtlX9FAY2B
	 KTBH1f7Cef7KlINml4vIXE/D3LG2gPYJgVrOPHwVgmEj4sIf35dT/o0iZ39mHPUPbx
	 niqUj3hO7fJAnorSNKyGZRPN2S/2UNAAijKSvynlNNBkh3XZQwPb1bLG92Ixc4evdp
	 5KtqcWawYSFqYt8XOPN5aWuBkMLaVhcm9XzxJnDXsU62qW1/I782dID57coA30MlL7
	 K64fzubb6YwQu1FRxYnQvcK4j7qe3qM5T21Xm7ily9zcfM1ZkK2iKaTcjr9C3ij2nh
	 Wa8mynf2NAdZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72B0D41DE6;
	Fri, 29 May 2026 05:39:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 40B5C288
 for <intel-wired-lan@lists.osuosl.org>; Fri, 29 May 2026 05:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D1D082BC4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 29 May 2026 05:38:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZFKLVzAqky4p for <intel-wired-lan@lists.osuosl.org>;
 Fri, 29 May 2026 05:38:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=35.173.142.173;
 helo=smtp-usa2.onexmail.com; envelope-from=zhaojinming@uniontech.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 256D482BC0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 256D482BC0
Received: from smtp-usa2.onexmail.com (smtp-usa2.onexmail.com [35.173.142.173])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 256D482BC0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 29 May 2026 05:38:55 +0000 (UTC)
X-QQ-mid: zesmtpsz5t1780033066t39dd5d5b
X-QQ-Originating-IP: 2Rf3q/fdA1E7d+O7Srod5LXOW0idSnL6+dciArsfJPg=
Received: from localhost.localdomain ( [124.126.19.250])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 29 May 2026 13:37:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5534762632318884595
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 29 May 2026 13:37:31 +0800
Message-Id: <20260529053733.764996-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260528171202.2659491-3-horms@kernel.org>
References: <20260528171202.2659491-3-horms@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NAeO0+xU6W76l6nBX0RxNcnzlyTcEqN/jnKr4LhxGFe8D8Qzb68UGPpC
 1buF4f3PE8ScC9tbVC/wMB+yDLzRgpeNGbirPJE+yjysYajJM9PvtDhCP0pEQwcNMEmRvmO
 ENSKivMeasBg7lGwcPQIVHtfdgJya1IInaPWLLvrLs7o2CoBfO5UuQBAzKRKqxCPJKxFlx+
 rwVy4ur3x5th/6tH9vaF+kDrNB6sOvfkTi8Y0suhufFXlN5GyPtTVdVPpRk4MCCzsXZQ8lM
 rLX8rbK+UWLw7ikErnyHT7Xag0KJAHj3cAN/3oso59cBoUgWRDEE+/33fUsanjYZpwPE+R/
 sKVZApyEoOJEvYKCOkxv7Zxui4OD8/30MxTAyequxbh8+j8J623LSPk5sr3QfwItpB40pkY
 6jr3ZUbaDBVEgQG8QZu6wnz0hd2tuXCtWVJCAE8O2B8e10m+5BWiCR1l+idxJ83JWyMDAze
 BU5LZXsXLKliLUIvQfIncbZUMGhclXODajLDMx4VQtF1bHtyahfF0/8zmul1G/1/sRNg3Fc
 e9ucw6PZYVJmlk210lDgvvjitPE9qrHA2zCYVqU4/P/jPsLyZ46YEvJnoKGiDasxUtTOxvd
 QkJqy1Jue3kA0EPionl2vtd4Mrku92gJCZWTBi7TDhLa7k96MWcMreHy2eIdrAKVyjcRe0/
 1sPdXUkLjnMTHOenRu9VrXXY1Hf7H33SKzdVZ6R9jFMQpzylr0VvE951lgE20ckiS2vp58f
 Y5pKf3A4lrHBkGMerhrNeD3pa7k2AhvK3g3PSg3FnuHn7TnCIrHiNJL6z5yfGxLm3xpsOn2
 WggxrTcgydtrFw4uk1duftxBKwNLwN12MNtOjdveKXe4S4Mv+KXt89CNoqvNfIDgvqtPRwd
 0NCVtqaD5E2DAIHobUTsq/7QZs2Uit87nmx22MVuKaAHX7xjIx6L8BqbJTrwzFNIXoJCcpr
 afVdAzqrNX0cnntruxQB+cBfunGMtMnNNpyqGQ15E8mPCzgMhKt+McXs8rWezgS1PZwnKr7
 0EuzIWvBtETlmZS38W4MFOB4KY2mc=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uniontech.com; s=onoh2408; t=1780033076;
 bh=w1ONFpfIdPAWMceFFrpPiIqatePtthElUP6Et+fSb8M=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=TcZBuL7dMqEXjm0IZB6WsHxjaGZCe3YgisOHFJjUYB4qVwlXhCIzraBGf8JibHJvt
 MmS2NH3vy9KiApM/CR6xv8QyQN/+L4LNXq0Gm6JhqF02gKRoXpxkTwIebaUcmAANNJ
 FrBcwe0iEIbrEF6RiEyjVsaSjZ3MKwBEhAFiBvL4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=uniontech.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=uniontech.com header.i=@uniontech.com
 header.a=rsa-sha256 header.s=onoh2408 header.b=TcZBuL7d
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: dpll: fix memory leak in
 ice_dpll_init_info error paths
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

Add a prerequisite patch that sets the pointer to NULL after calling kfree in the 
function, eliminating a potential risk.
Update to v2 version of the patch.


