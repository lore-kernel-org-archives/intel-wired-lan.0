Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035C9C04FFE
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 May 2024 05:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2CEE83B4F;
	Fri, 17 May 2024 05:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DmobIzOk_PcS; Fri, 17 May 2024 05:51:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 987AF83C5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715925063;
	bh=h3NXfcwTy/YLouXOj4B7Qj0ZIpaG02vgs9xxzzsxFiY=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ifqJxyDT/OYXENcwPobl5+olclKNiSB8kdOnh5G+GGXNyYyQmHNP7LYAQY0K0cAie
	 S6TnnTxG7tjOkhOWXZlpHUdArnosLud40awgRJRZ0xGjNUfBBoCt68/XZefIBsC8yN
	 5/8/qfCQMKxfVH6pkETriXif6WuY1ovDBsaKDAG5BARlF8Xu3nBxleCgqj8zhFqwDf
	 jekK+Yfsh+qeVChmIfzm2Nw/6euUl0grEcQVwTkQnAgOzwVai8OCNyq83taheog/Aa
	 3h+oTOyqaATGDKfSnlSj2kAUISDxziYUDlyTsndCIWvC/roEyJBkV2qQLVnfZ+wUPj
	 UKoRdashtJSww==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 987AF83C5F;
	Fri, 17 May 2024 05:51:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 7B52C1BF383
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 May 2024 05:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 671E340181
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 May 2024 05:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id raFQuJs3t7WH for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 May 2024 05:51:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E02BC41A35
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E02BC41A35
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E02BC41A35
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 May 2024 05:50:59 +0000 (UTC)
Received: from [192.168.0.224] (ip5f5aef9a.dynamic.kabel-deutschland.de
 [95.90.239.154])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5BF1E61E5FE05;
 Fri, 17 May 2024 07:50:33 +0200 (CEST)
Message-ID: <51c51cb7-db66-4187-a7e4-6dd3044579b7@molgen.mpg.de>
Date: Fri, 17 May 2024 07:50:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Rui Zhang <rui.zhang@intel.com>, Oliver Sang <oliver.sang@intel.com>
References: <202405150942.f9b873b1-oliver.sang@intel.com>
 <23f86436-cd8a-45b0-9378-1ec3adecfc82@molgen.mpg.de>
 <7ef3669807799a83aa40e94e2bdd21a11dbe393b.camel@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <7ef3669807799a83aa40e94e2bdd21a11dbe393b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [linus:master] [e1000e] 861e808602:
 suspend-stress.fail (e1000e: move force SMBUS from enable ulp function to
 avoid PHY loss issue)
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
Cc: Yu C Chen <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
 Hui Wang <hui.wang@canonical.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, oe-lkp@lists.linux.dev,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Naamax Meir <naamax.meir@linux.intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Rui,


Thank you for your quick reply.


Am 15.05.24 um 11:29 schrieb Zhang, Rui:

> On Wed, 2024-05-15 at 06:57 +0200, Paul Menzel wrote:
>>
>> Can you please share on what test system this fails, and provide the
>> hardware information?
> 
> This is an Intel BroadWell NUC.
> The problem is reproduced on this platform only, we have 20+ other
> platforms but doesn't see this issue.
> 
> lspci output attached, any other info needed?

The `-nn` to show PCI vendor and device codes also as numbers would be nice.

>> Also, do you have Linux logs until starting the tests?
>
> dmesg after boot attached.
> After that I run "rtcwake -m freeze -s 30" and system freezes.

Just as a heads-up, that the referenced commit also caused regression on 
another system [1]. Would you be able to test that patch?


Kind regards,

Paul


[1]: 
https://lore.kernel.org/intel-wired-lan/20240413092743.1548310-1-hui.wang@canonical.com/
