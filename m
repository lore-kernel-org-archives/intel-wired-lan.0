Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F053CC47073
	for <intel-wired-lan@archiver.kernel.org>; Thu,  4 Jan 2024 07:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84F2460674;
	Thu,  4 Jan 2024 07:26:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84F2460674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1704353215;
	bh=4tlXlEufC4GWb4djA7zy4fURTkr4HKxPw2taqwc9z7I=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ed1cTvnsU1nc5OdUQd7Ukg32jDnoG+pU57A4dkPKFyBWhAMC3hpDojHUqG6wIEeBk
	 14Xy9L8gM16cGtJ5tD4NA9qj1tsyrt9DPdPwGXLJuaMRnG2LywnGhgsq3Ap/aY3c1Q
	 d9L5A6BSeBTY5s4RO/sEJiktEOj4aCUFjYpQt46wvPzoY0+v6aPcRYVWoTNyeXDu/D
	 3eVWr8mNfUciILk2RvoxYj414f5mQa3CQ/zOWwBLb7O5k4fEJxSkVe+P6eCkpzgSbP
	 TKqFU/u4HIoIKt1mDMeYb7Zua78qK+t0Is3Wcz4UXfHhbW6gklxafB04MBRuL5mNy4
	 CI8TLzCAir4kQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IKyBKeM5F5xR; Thu,  4 Jan 2024 07:26:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6C6C60B46;
	Thu,  4 Jan 2024 07:26:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6C6C60B46
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id AC39B1BF422
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 07:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8315D60B46
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 07:26:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8315D60B46
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6EefD6midUMZ for <intel-wired-lan@lists.osuosl.org>;
 Thu,  4 Jan 2024 07:26:51 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4145D60674
 for <intel-wired-lan@lists.osuosl.org>; Thu,  4 Jan 2024 07:26:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4145D60674
Received: from [192.168.0.224] (ip5f5ae9b3.dynamic.kabel-deutschland.de
 [95.90.233.179])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 16D6D61E5FE01;
 Thu,  4 Jan 2024 08:26:19 +0100 (CET)
Message-ID: <7bfd7069-8222-4388-bc1f-d4e77093b503@molgen.mpg.de>
Date: Thu, 4 Jan 2024 08:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
References: <20240103101135.386891-1-jedrzej.jagielski@intel.com>
Content-Language: en-US
In-Reply-To: <20240103101135.386891-1-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: Convert ret val
 type from s32 to int
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
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

[Re-sent with diff removed, so message size limit of 90 kB of list 
Intel-wired-lan is met.]

Dear Jedrzej,


Thank you for your patch.

Am 03.01.24 um 11:11 schrieb Jedrzej Jagielski:
> Currently big amount of the functions returning standard
> error codes are of type s32. Convert them to regular
> ints.

Please make use of the full allowed text width of 75 characters per line.

Also please add the motivation. Why are regular ints better?

[…]


Kind regards,

Paul
