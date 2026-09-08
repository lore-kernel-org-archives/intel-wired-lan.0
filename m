Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABEAC79F9E
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 05:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8967160693;
	Tue,  8 Sep 2026 05:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfpTXRj7FuAp; Tue,  8 Sep 2026 05:51:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 07DD760641
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788846704;
	b=k5MbrDTruZpRMi1zGik6Rgp/wNrCcjDPf0WCo4WiZ8cZJN/yZ0WSNjt1N7Pr5doOkHc2
	 wZPvSluahp2GkJV2I7YU6nInsosDphQi95MGylavpIS9l0Dyex8z73cj7/c5SgG9T4ND0
	 1IjjyFGmZ5/SfRkN3/j09qJ5IkrKa/TcA1k/naeicx8ppr0bKccJFveuA4XAXF8cdSu6T
	 AHOfGZiChc5hZKd4yuAKg0snzWXxIiF4Yp103EyOk2kJxu6IeWnBeWWPvBpfjtyrrkGK0
	 9shgIojSULjZ3vP/Wpd6NvqhAfSA6NjCNT0+rKyT1C7fo7HP1hULKUPg5vheTVfvCHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788846704;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CS9Kzo9hjCgoY/ebMX4a6llaNutb9H5FCC13GmHGBYM=;
	b=mp9Uu+Tq//0HSsXAvjLONtxqpxG0cSdPColaW4BvDqpc8vy4y2/CFWvqn+geYkOdPaBZ
	 uYakyZRUnH9HQsSnlX0N+6CabxruQ0POz3lWCttnCbMxbcrbCFNN3sZn2Th1XFZKzTelS
	 XgNJV/B/8SR+XbGSD6tG/UNr7szSTvchzTirhqol3+KecIrQxxajLOROL8SVc3w0Vo/qm
	 SsLCeOVV71yWiZ6LmhCLoT8wGGzkh8OCt729goNmJuem7ArF7IhXMkl1lE8jkiaAVm9TI
	 SAo5W2GJVCzbmHFMFREDmgzJNJDD3qVrWtqf96Mqu6Kg19h/xK936IPhxrYUOypv7zw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hEI+WL6S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788846704;
	bh=CS9Kzo9hjCgoY/ebMX4a6llaNutb9H5FCC13GmHGBYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nRpO7Sns6geJIpzPf6UHyeXoXZeGrtVWxg37GSKfGwj3CnBcJXcequLiLWbxpcgMy
	 6VISzZw8juIuk7RWQJbe2ncYuVTldttmAKHboyo1b04lOK4P7MqBTmsMzv/ywEtzNR
	 ndSVYGBZ7sNFm75tTj6DhBgxglpFC2QcwBQBdAKC/D2C6Y6AMKlVWOgpeVcRo6ZmOy
	 SVDfgwxj8T2cpgG5gOE4tkQS+wGwiVfM9vRyloHgD278N8xSloE/l8VL6sXB0gom4z
	 kUX2SDDoxmbAOq+m6/fbVox95+PNbJxQsNOmzeVMfq3Df71F/qEinaBSuMVNLX+Ar7
	 Ybm+CUftO926A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07DD760641;
	Tue,  8 Sep 2026 05:51:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF39BA48
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 05:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4C0260641
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 05:51:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERPbLbORt6zH for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 05:51:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7424C605F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788846700;
 b=s1mbV4S0E3oxnEcmJ8JYbKijRpKLJdVF5sqfqcuFzp7E9qXKMaMgiWxyQc2w+AUWkbvC
 /3m8st+8BMVEw0ZIGR6tdzwzDWCzyjjZoF9zqhGRuLTsq/TqxYhiEy8YBVCfEGEjpRK6V
 mE+4WrGekh+6e2K5jv/9uYGCLarNmOC/SP7IhyjW2ZFR0jKgM5rkDVTwb1yeUhqubGD4G
 9hV7Ae6lrmCBXsdMVEjM5623BMPvG1hPny71jjvpOgJYhQnnBT4fBUv/FgX9qt+KvAcvL
 U3XKtF33gfieW13jVFTKTCtonK2IbpGiDFSWgKt3FRTCd+HyPz1BDCdyRjfSdSuxmtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788846700;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=CS9Kzo9hjCgoY/ebMX4a6llaNutb9H5FCC13GmHGBYM=;
 b=Y3AHSH1tI5ZbawPH8l5teBxxCprVMvbdYb+Sy+XxsHktcYu4TnboKzH4lR4uEgQQywWj
 bgmkBx91zGAIkk3YZETPrpwziKAwYkhrwMyi6i2eOLg4wm5DDeX5uGZAGcvZ3a0orDXMi
 K8cw/GWHp77fepXxbEFwb9bOWBxA++Cc//4ErH8KB76kmHIvTFdZWPecaukFy6Ql8AAPY
 KaBmEdTTamQ91KCKoARc4iecITdVxb+PnX/ZqdNjyrWj01plCxLGB+xqlhQMjarMKCaov
 RWU02PGsVQ4qDpN0mVA9e+OO/qCLNdPV1lpnpI/xNzM7BsRMK1fVP0LYEZ0+dr9BjWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=infradead.org; 
 dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=hEI+WL6S; 
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:3::133;
 helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hEI+WL6S
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7424C605F5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=CS9Kzo9hjCgoY/ebMX4a6llaNutb9H5FCC13GmHGBYM=; b=hEI+WL6S4BD6EpAhd5u+0sXBv4
 EhFC7Z1hzizaAjMCNuhFuj1sRJqto4HJhslO+2h2CfjywfaNzMOcr1H0jHc7AK9ixllauY0YcJiAN
 rHCYu8PIEF0B9E5il6zTrxDWSthsHsGhon5K60zNwXpInOMh+G09hPvgG7zS1FLQAm6g55GzJFXiZ
 iXMRxaoyXrlkdzSeUbsMKf2TS5kzS5Gon06XqcwatYdVtoFSxwg9vMyxl3joIsDZOkHNlvSVqNGc1
 3f13A9ApkeKhcTfrq5Z5Gn3DpHPphv+EaU4tWAr2FKPiPhqT0cRVRaM6aO8VRQpchKqunbVBeSio/
 WvKRgnKw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x3ok1-000000086w6-2wAk; Tue, 08 Sep 2026 05:51:33 +0000
Message-ID: <8b923faa-4676-4487-931a-98d84993517a@infradead.org>
Date: Mon, 7 Sep 2026 22:51:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <45869dba-955b-425c-88b5-a9793ab2717a@infradead.org>
 <20260908054643.11460-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260908054643.11460-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 9/7/26 10:46 PM, Hemanth Selam wrote:
> On Mon, Sep 07, 2026 at 10:27:00AM -0700, Randy Dunlap wrote:
>> How did you choose iwl-next as the target tree?
>>
>> The closest match to that in the MAINTAINERS file is this:
>> INTEL WIRELESS WIFI LINK (iwlwifi)
> [...]
>> but the patches don't touch any of the Intel wifi drivers.
>>
>> I expect that you want net-next there, but I could just be confuzed.
> 
> Sorry, the prefix is a confusing one.  Here "iwl" is Intel Wired LAN, not
> iwlwifi.  It is the prefix the Intel ethernet maintainers use for their
> next-queue tree, the one in MAINTAINERS under INTEL ETHERNET DRIVERS:
> 
>   L: intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
>   T: git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
> 
> Intel's own developers tag patches for that tree the same way; recent
> examples on the list are the ice, idpf, ixd and libie series, all
> [PATCH iwl-next].  Since these four patches only touch
> drivers/net/ethernet/intel/ and its documentation, they go through that
> tree rather than straight to net-next.
> 
> So I think iwl-next is right here, but Tony and Przemek should correct me
> if they would rather have them another way.
> 
> Thanks for looking.

Thanks for the info!

-- 
~Randy

