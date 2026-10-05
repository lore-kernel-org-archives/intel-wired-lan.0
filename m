Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF33CA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 16:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1AB340576;
	Mon,  5 Oct 2026 16:48:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qr4PxPoXF0dL; Mon,  5 Oct 2026 16:48:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6C7104057A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791218888;
	b=nnmfVLUqHiXTOGODsUquu6xi65F3PjmM/8De8tlFyl4plbnHU8HFLsZft6rWE9AYEHUd
	 pkrP7FfjP7Vkv6RjzYTeoZKuTHshs5uWsCKNnvpUUWkbMK464k9tgR8ZTg7D8eRCcEirf
	 AlOL1AkHQow1OJcpR1sjQAlYPk3HZz6B1TmpHdDx7v+uQ8t0hP4rlgOLkYjmr+uKt1kNq
	 u/gkNv9lhvLn/74f8x5nv9/6TeVyIfHx5D1Lsb9f72rySdPFztLrhjHSAqWSZTLvPakag
	 BxB9KROedYXJSxAxpr+ba8JK2OhGhg8AyrvYz5WcCBAOuoHooUb8zgQi2ka6l/FM/rw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791218888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0qGHbBms60xFPKgi57VodRM5C39Ha2DHXvR/RiFkZ70=;
	b=ZuPu6OGZo5vRMBWIzw7ZLxae1rqDznYSJiHgbfF80ccEVI9ygb49M6+z/3T/ZU+ALNBM
	 LitkTLnnNBZvItincCz1UQJgvWaDDd9JTn6DGtADe53NEW3EBTLBUZ7QJSnx+MgrfsKIi
	 yFPVI8pA4nI2SAvFcPHXrD8kTEdFyE5zCSEwdBBWI1Apn3hGG93aiy4JkGrnn7Q1H6yxz
	 fHEps4Fr6vV7kgg1UMYGMYCspKyqcbW3k4AZrKK9UW0EVGWEQwoF8sHzdvbR6tzX1jCLA
	 Yn1aoz2Rlf6tTPqG46b8QkoTqWGFJvVFSSff8DrhAWGWS69R3eStvGL8IkkFfp8tiQg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791218888;
	bh=0qGHbBms60xFPKgi57VodRM5C39Ha2DHXvR/RiFkZ70=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CONi1MxuAQWASV8ySVkmNHBqPAMQIt7p3v0ptTbe+eOsuO4FGaX2HKz674L6Muu+l
	 AzyTceDycujA0kgvGpM37l2OfaEYLZdPKjJErst1O7Rdnqif8F2wUa1LtwGkGl1fDV
	 QXMSYOn7+nFcdbD3cLgSlC+JlBteCnoziUClsjIjdhH0q5A7X48XvyySUvCJeoZs3l
	 Ezath7mwVj3WWUsdTS+imLPJ9uYGmRsyNywjLqeEk2ujzA4kCUyR8STxFBvdBeCMbx
	 UyuCYVqXwmv1ZiaAyzZVzSCnhzCAdp4O3dF4kBiuvuPfdW7GDDfx4abEQSjitM9V6B
	 u4UXxSKr4VYPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C7104057A;
	Mon,  5 Oct 2026 16:48:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C201E1A6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 16:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B340460718
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 16:22:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iz5XZK9OztRq for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 16:22:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3EA91606B8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791217329;
 b=UIkcf4mHCywZB4jTykjlE7sRJ7yP9+/WqtiOuemwNVgt5oc1XilNF+raeFq+fcMGU3ww
 sV3QH7k6AT+3jsG5GrVQ9xpLgoS0lq7ng5r1zhlp8sY+sXT5RG565PLuwHfv1nhbjR5dM
 y21Skd2MX67j5fUtpymq5t9HF6kuAJOtwx4fVhnHW2MpLR/WnYNrWiNdGYNvq+diHpPKo
 g/3EDSsOcdNdadSFg1CKo5WDuh4mzxsHVu5JPlUVtfMi6HrONaI66MonXfhO8Riy9tCEN
 0EF876KLLi6sKt4nNz2sgrOon3DXbJAvsJpYfwmLR9sr6Ui6eN9t0WjJ+tJ7RRYkzmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791217329;
 h=Received-SPF:Received:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
 bh=0qGHbBms60xFPKgi57VodRM5C39Ha2DHXvR/RiFkZ70=;
 b=X6EBCRC/6QiKiDlgbUNVR9MRQpin6YW2ipH5/pnDVAvM1ODin1pcMEPHAzqFg2sx8xKt
 2FILHFpV6XlioXLrNDr9BCrxks29pWdRoB1CnsGJ73E4L43xxx2TQ6M/z0wg7BW3eAEaL
 M9mGhlc4K7yhCQqU4ooDei1aRSerGijUFgxCch/ek5rdXtfc9UcGwmlLVqp3zhLBoQNqB
 uF4sVWd9chOU8wCI65tkW25kFK9DfYtreLPmW905DbOw2obT1z/4Emde6YxytbPqZBY11
 /nTvysz+ZknIBMP/xPjUf1gP24MvCnMo3p9+bH6umrF7ZwrEs/tYa0D3PQCDZlYXZIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=molgen.mpg.de; 
 dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256
 header.s=20260906 header.b=LU49uSgU; 
 arc=none smtp.remote-ip=141.14.17.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de
 header.a=rsa-sha256 header.s=20260906 header.b=LU49uSgU
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EA91606B8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 16:22:07 +0000 (UTC)
Received: from [192.168.44.156] (unknown [185.238.219.75])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2C93E4C2F3FFF2;
 Mon, 05 Oct 2026 18:21:38 +0200 (CEST)
Message-ID: <92e8c6a8-c2ba-4e1f-8ce8-f567636a24ca@molgen.mpg.de>
Date: Mon, 5 Oct 2026 18:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: e1000e: I219-V RX CRC errors on ThinkPad P14s Gen6 Intel;
 disabling K1 restores throughput
To: Christoph Groth <christoph@grothesque.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <87v77ial45.fsf@grothesque.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <87v77ial45.fsf@grothesque.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1791217298; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=0qGHbBms60xFPKgi57VodRM5C39Ha2DHXvR/RiFkZ70=; 
 b=LU49uSgUoVsc3WDTzL2dxL3czsr7K4cNRq5e+PHHwy9bWxACFoGFSgYXoNRHi/6zjva5Wn3CTwHl
 2eG5eisngjLiIQrAqU5dUbJbd8/2K4qWe6P8IS1iAoeVSDLarNZhWXoePLl2P2rdDz/1mJeZTLzYJz
 oEhWp/zq4O8+Wg9guO/XjMYTGHxg3a8P6/5qqxFUAxakutbGTinCuEaMoq1PeTnHH1eba1K4K9TOnq
 XjqSDG/NLceqQsrkRZBUd/2I9ej6B2Yp/IC4rBR5yDuR4OZA07AU5hshGuDyl8pRZi4XBiHQjz8vU4
 hxpFJ/oIC7QT0WuUgCNgoLKOxAE2vwjg==
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

Dear Christoph,


Thank you for your report.

Am 03.10.26 um 16:56 schrieb Christoph Groth:

> I noticed that wired Ethernet throughput from WAN is much lower than
> expected on my new ThinkPad P14s Gen6 Intel.  The culprit seems to be
> CRC errors.  This is with current firmware.  I updated everything one or
> two weeks ago.
> 
> Executing ‘ethtool --set-priv-flags enp0s31f6 disable-k1 on’ works
> around the problem.  There could be a relation to commit 578294b8b60d
> that re-enabled K1 by default.
> 
> See below for a shell session demonstrating the problem by downloading
> data for 30 seconds.  With K1 enabled, the transfer generated 125 CRC
> errors while receiving 156 MiB; with K1 disabled, the error counter
> remained unchanged while receiving 2547 MiB (i.e. a 16-fold faster
> download).  The following has been recorded using a freshly booted
> current Debian testing live system.
> 
> I’ve been observing the same problem with different recent kernel
> versions, different network cables, routers, and networks.  I also had
> the opportunity to reproduce the problem with a second identical
> computer.

[…]

This is a known problem, and patches were sent to net just on October 
1st [1], and accepted. It’d be great if you could take a look, and reply 
there, if these solve the problem for you.


Kind regards,

Paul


[1]: 
https://lore.kernel.org/all/20261001222443.3500206-7-anthony.l.nguyen@intel.com/
