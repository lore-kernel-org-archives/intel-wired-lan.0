Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9C6C25B75
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 May 2024 15:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC0C6405B1;
	Wed, 29 May 2024 15:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nitc09Milh5J; Wed, 29 May 2024 15:18:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D91E540513
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1716995928;
	bh=ym+J7mVYo/LTr9ahU0cXpH68cJTQUkWvad/6GbbbCpo=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=pxaRPOV01xfXUXmks+Mmqi/+OkwjykDLBqRnFS5+8ONsH00S/rdJlykwnwdzTmFsa
	 k9qVUi3+l+pPWW8Y8H0YaEeSwU5uNptyEh+hxZqHEY6JVPOGW5LIjkpXnvlovpg1xZ
	 ZZ56jZXzmwY3eF5z8knT4t1bFyKUxp4d5MKVmqPigzRvfAwgON3d1A8kMOc8Ofe0n2
	 cKEp8Ojip/o3y3E6vby41e7gV4UpeGu72E2xlyVT+Xb2eAs9DmU/Wq7kcO/4WtG8AG
	 CqxKFuG8Vz/IuCEthH8PcHcLZcUAc6y8JyQomsuIl+yBvTmaNUeV475iNjGG1P3sdq
	 gfjYtxHY5sK7w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id D91E540513;
	Wed, 29 May 2024 15:18:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 694CA1D373F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 May 2024 15:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52B42402EB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 May 2024 15:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id loovGDS-eXaL for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 May 2024 15:18:46 +0000 (UTC)
X-Greylist: delayed 369 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 29 May 2024 15:18:45 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4600C402B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4600C402B0
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4600C402B0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 May 2024 15:18:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D874339;
 Wed, 29 May 2024 08:12:59 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4A6C3F762;
 Wed, 29 May 2024 08:12:33 -0700 (PDT)
Message-ID: <5a18f5ac-4e9a-4baf-b720-98eac7b6792f@arm.com>
Date: Wed, 29 May 2024 16:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <20240327152358.2368467-14-aleksander.lobakin@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240327152358.2368467-14-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
Subject: Re: [Intel-wired-lan] [PATCH net-next v6 13/21] bitmap: make
 bitmap_{get, set}_value8() use bitmap_{read, write}()
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
Cc: Yury Norov <yury.norov@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 Alexander Potapenko <glider@google.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Alexander,

On 27/03/2024 3:23 pm, Alexander Lobakin wrote:
> Now that we have generic bitmap_read() and bitmap_write(), which are
> inline and try to take care of non-bound-crossing and aligned cases
> to keep them optimized, collapse bitmap_{get,set}_value8() into
> simple wrappers around the former ones.
> bloat-o-meter shows no difference in vmlinux and -2 bytes for
> gpio-pca953x.ko, which says the optimization didn't suffer due to
> that change. The converted helpers have the value width embedded
> and always compile-time constant and that helps a lot.

This change appears to have introduced a build failure for me on arm64
(with GCC 9.4.0 from Ubuntu 20.04.02) - reverting b44759705f7d makes
these errors go away again:

In file included from drivers/gpio/gpio-pca953x.c:12:
drivers/gpio/gpio-pca953x.c: In function ‘pca953x_probe’:
./include/linux/bitmap.h:799:17: error: array subscript [1, 1024] is outside array bounds of ‘long unsigned int[1]’ [-Werror=array-bounds]
   799 |  map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
       |                 ^~
In file included from ./include/linux/atomic.h:5,
                  from drivers/gpio/gpio-pca953x.c:11:
drivers/gpio/gpio-pca953x.c:1015:17: note: while referencing ‘val’
  1015 |  DECLARE_BITMAP(val, MAX_LINE);
       |                 ^~~
./include/linux/types.h:11:16: note: in definition of macro ‘DECLARE_BITMAP’
    11 |  unsigned long name[BITS_TO_LONGS(bits)]
       |                ^~~~
In file included from drivers/gpio/gpio-pca953x.c:12:
./include/linux/bitmap.h:800:17: error: array subscript [1, 1024] is outside array bounds of ‘long unsigned int[1]’ [-Werror=array-bounds]
   800 |  map[index + 1] |= (value >> space);
       |  ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/atomic.h:5,
                  from drivers/gpio/gpio-pca953x.c:11:
drivers/gpio/gpio-pca953x.c:1015:17: note: while referencing ‘val’
  1015 |  DECLARE_BITMAP(val, MAX_LINE);
       |                 ^~~
./include/linux/types.h:11:16: note: in definition of macro ‘DECLARE_BITMAP’
    11 |  unsigned long name[BITS_TO_LONGS(bits)]
       |                ^~~~

I've not dug further since I don't have any interest in the pca953x
driver - it just happened to be enabled in my config, so for now I've
turned it off. However I couldn't obviously see any other reports of
this, so here it is.

Thanks,
Robin.
