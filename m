Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95688E7717F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Dec 2024 01:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FBBF81371;
	Tue, 17 Dec 2024 01:56:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QP6wOf8CU9BF; Tue, 17 Dec 2024 01:56:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC28282049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1734400579;
	bh=FXMO7Uj1C5WXZnstscdNw9Bhcp+a3TuCpRDpokLq4Sw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JEA8Os087HlevRuDoo1aZGT6862syN+WzgM0OMXs3AVTfC6h40VCftp216nnakY9S
	 zCer/KyYtcpq0ifi5ARF4n68+oaZd1oNMlSc+xTdYKNI6cRTCFWJ75fEwYBEuA+BIv
	 y8oFJS5csXeZkJNy/CciCFaklRuERpY3zt7tsxp6eHh/4fmcfX/TzpR5dyq15mD0g3
	 Eb41ebEHqe/ScTMNwDbfKk9LyA+Cak9SA//q7VQ3kWP5MhhMR0nFZzLXwYxc5ECltO
	 xZksHUPEBGIQYW1KPLgoTjf8KwevmLIhj2FV0PX0YDOw6JTjWW7ZjHMXC5Wxwm+F2M
	 AkSYrkqAE3nTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC28282049;
	Tue, 17 Dec 2024 01:56:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1351ECE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Dec 2024 01:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0107760F74
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Dec 2024 01:56:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jgx1cKvA-C0g for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Dec 2024 01:56:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5D80D607A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D80D607A0
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D80D607A0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Dec 2024 01:56:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 19D09A41BB2;
 Tue, 17 Dec 2024 01:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADB8C4CED0;
 Tue, 17 Dec 2024 01:56:14 +0000 (UTC)
Date: Mon, 16 Dec 2024 17:56:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Alice Michael
 <alice.michael@intel.com>, Eric Joyner <eric.joyner@intel.com>
Message-ID: <20241216175613.3b9780fa@kernel.org>
In-Reply-To: <20241216173212.1157855-1-paul.greenwalt@intel.com>
References: <20241216173212.1157855-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1734400575;
 bh=FXMO7Uj1C5WXZnstscdNw9Bhcp+a3TuCpRDpokLq4Sw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aLkFDYPaqieluQkYbTq3b2g72saYHQvJNCfds8G6lrxJIHadaK2+h9gRZp1eicGJz
 UPsvSCjsLq8jJuBp0CXsZEnBKuvpZDaZsqVwJOs5xr4zJw9gx/lZp6iflhcLSmonB/
 LHnP9A/FTYhdxsVDPsIBfLSNTG/yN/n5XV1TRt2X8wb1vZR6AmW8dcMfWpwLIxHINP
 IrF/0XmZpzklO6YoBwaWaMBTY6qdKgEAboGvB3D6y9DgFafljNvPbTHwne305nNHuk
 btylqmNeCg8Okk0a3oyFwBjGUcCPleBFFLNfsDUAf4YcXBPub6UNNzUufTBSgVmpUl
 0Po1f3CZKg5Ew==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=aLkFDYPa
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5] ice: Add E830 checksum
 offload support
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

On Mon, 16 Dec 2024 12:32:12 -0500 Paul Greenwalt wrote:
> Cc: kuba@kernel.org

Please don't CC me on iwl-next patches unless you also cc netdev@.
Makes the patches got into the wrong inbox..
