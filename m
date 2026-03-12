Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0DE105A595
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Mar 2026 12:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A1CD41101;
	Thu, 12 Mar 2026 12:57:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jScLeLqrbdar; Thu, 12 Mar 2026 12:57:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D817410F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773320255;
	bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7aAdHm+gqFHOeGMsLzs4Hz+62D5XEMFrf8u6Fn5nJZ6OZ48aDraAVZud4Mhox8OTJ
	 aPuGqDGo7mx9PAmnWMw6vKfwMDmTQBn/sOagFOqJXgujs1DAnQTxpBYpzEDiu+osQr
	 VWlfyQL71PDx5RewvoxWwa9akfXcGLS/bmOT8KwKMW1iQ4tSf4CuSGBd39W9Uwy5YI
	 DYZrsmyrZxkKY/S9E23jz/z8gybN6SXbPPWKMOFpgxFBEUYafvtkEsDyJHV4q1d3Vc
	 7u1EyfgyP8YzVzYUJJphGGXRlwli91YTdGmZ3w1kD8c1ujOLJTCnIceaoUA+ESdBqg
	 8N3bxkWNsYFsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D817410F9;
	Thu, 12 Mar 2026 12:57:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 67026201
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 12:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CC194122B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 12:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bMGGcsKUguSD for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Mar 2026 12:57:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com;
 envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 25EC24068B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25EC24068B
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 25EC24068B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 12:57:32 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8cd73c4a827so89609085a.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Mar 2026 05:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773320252; x=1773925052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
 b=R0qJpsipqFY/hn/rUt5+KvZSNZjAtY3Dvv2npFODjrYvjuH7IfOkD4WQD466WwS3N5
 DRQEXgUszIa69sU4WzXG4lZRjqtA+2EHcrIKHcSTVKXVeUeh7IYxkbvu6wmYLdW6Y9Vd
 FGnqqClF3rS8Ahn0ji4E/c4gbEkINSJrTlEfvErQfFD+elqjswQ8vWjtfdxWLHQWMT4f
 /Q4COsQanW1jsqDrkh/qX+LAT5oi8BtHZ5I3taVh77J+DHVUoqBhQ2dC1O8F+wAvgL05
 Ma+EqMKNRpKq+5SvdhXqndafJuxo9RqexJKZA222a4we31sTLYXdrfL2ccQg3DmBs3NL
 3amg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrlaa2y7FCrbFvw0u4NkYvgEw2EhCUhTtNmjx3guAU+aNtJVbcNmJa3tMSM3jThuy3DAcdelv57+7aItbhNUg=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yyk+Jdg0zIb+qN1GEzSKC6n6nfCXnDk1sfUK54Wql5Zxr5eojDE
 2E5NP66BUcSCF4hvyIpD3lDuR7q35QvryfiGiWIHq/UdPFSXfw9UUniTfyCrTC1qRcI=
X-Gm-Gg: ATEYQzyBgnkPGzxSLT9gxnYR+B7d8jojBz3jTsKmgJysdprT6lv+gvtJPgWWY+w7XNk
 0CE4htGp7D3ovhgmG9QpfbG3NuwhKPA8iTAPR8GRrwfNXoxl57OR03FUVqotaNNeHEi/RMeObpG
 3gz6I3NLur1BalbD1tLZPLFEgaG2UxuFqTb9F5AvagGZTdnE0lejJtgaPkIPTiAxU001K/8moSN
 KQ8wrmEnKjjIdFWwQuRc6E1TZ62gfJYKDvqTVoHB5yhc/OsYK1lS1YTrdR2wKKp2dIUnWzniOKs
 830oKVpPtLPB9UH5qnIL2vwP5boKT+4W3yk/Dyvk6NPMniCtI2Rrw1opGKg5RIib8yP5nyhPypm
 /kNNggnyv+yCqaD5jPXsOoSOag3YiAIEfaP1uRriM5c2Tn3JH4L2Vp1PP0RkdbE8q70jWHF+HNv
 XnAGX2wUytiZHeTQiEAG2LOrAJis23tN7lTU6n+znuew+BtXPp4UFHIA8KA/pJjT1G8K6qEr8RO
 1fKxeHL
X-Received: by 2002:ac8:5d4d:0:b0:509:cbc:127b with SMTP id
 d75a77b69052e-5093a1bd58fmr77950521cf.60.1773320251710; 
 Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65bd318fsm33341196d6.8.2026.03.12.05.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1w0fbW-00000006fKD-1POa;
 Thu, 12 Mar 2026 09:57:30 -0300
Date: Thu, 12 Mar 2026 09:57:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
 ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Message-ID: <20260312125730.GI1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBlpGKO842B3yl9@google.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1773320252; x=1773925052; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
 b=PcuT+40rduz73lzf6c0MCtKdoQBEzHyj01inMDL3QUoTNkxDfOBflQuxDi8IeDaS71
 EGz0bFeirbIHgAjmA9QDN9w4wuslQvSghgDW0GOo6B56stuR2sNmcnk/K1Zqd75yPVON
 Y3kI+QOmuZ5oZtJ1zVKN2bwCFG1pT6BhH8c657aIp1pLQ4+b5nbzTcXajWG0/h4/trW6
 RXyn5zeTojnfukJptG3Cfd7hk+gvSxptLusjKk4iv++hpvyYMtcnLtvD+7JNfzaDcgQf
 4r8JJzgwU2VgYjK/zcXtyvF0bnkqIIO7d2wfv5BgK/o5SM18orZ4uvbLLlvrcTy9wc4R
 IxSg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=ziepe.ca
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256
 header.s=google header.b=PcuT+40r
Subject: Re: [Intel-wired-lan] [PATCH 00/61] treewide: Use IS_ERR_OR_NULL
 over manual NULL check - refactor
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

On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:

> IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
> flawed API design. It usually implies that the caller is unsure whether
> a failure results in an error pointer or a NULL pointer. 

+1

IS_ERR_OR_NULL() should always be looked on with suspicion. Very
little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
implies ERR and NULL are semanticly the same, so fix the things to
always use ERR.

If you want to improve things work to get rid of the NULL checks this
script identifies. Remove ERR or NULL because only one can ever
happen, or fix the source to consistently return ERR.

Jason
