Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEEAEEC296
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Feb 2026 21:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9962860B46;
	Mon, 23 Feb 2026 21:58:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aNMwwenIk8tj; Mon, 23 Feb 2026 21:58:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D13260ACB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771883937;
	bh=rVO0cWY5YQPss4mxRPqlFNx3v8FT5KAjLgK+RHGEKFA=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k6hKjkwF683vfH+b++6xBzqCbHhTSoGb+Eoxx3PFfd+hcK4OerEH3PhMoLYgk++tn
	 mDh1GLRKDiJPb1GjyA4XwhhfjLMyxyHI4VIsCKTzgTJdGtJ5LdXiX5xDTAZnx/faGn
	 JbuFCnFc1L8Jz0zFbw4ahx/VZBFn6j/1L3BqgJyDVHhImjwSz7Yc1oeiQKIXT2iqEp
	 chclYbvvK4a7x6LbsMGZ9n5VFxP81LuNXohKKAVTZ0pdf8pStNxBwqbt8DAaDibeUd
	 eAGdJT8GhVAO6RGNE6cQAvHdnuWJZ/UFXy7zmS6MeFeU0dncv3M1apEiHivq6QlXi+
	 Eao2eCWpZ7niQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D13260ACB;
	Mon, 23 Feb 2026 21:58:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D564237
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 21:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6D84403DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 21:58:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VOAjiOPkSwz5 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Feb 2026 21:58:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c01:e000:3a1::42; helo=ms.lwn.net;
 envelope-from=corbet@lwn.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4427A40095
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4427A40095
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4427A40095
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 21:58:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EAB1C40423
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net
 [71.229.227.126])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id EAB1C40423;
 Mon, 23 Feb 2026 21:58:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kees Cook <kees@kernel.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
Date: Mon, 23 Feb 2026 14:58:53 -0700
Message-ID: <87sear2kbm.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lwn.net; s=20201203; 
 t=1771883934; bh=rVO0cWY5YQPss4mxRPqlFNx3v8FT5KAjLgK+RHGEKFA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qV+GVt7p2nYnN1+NX2I9tzAiI/gfQQzdkQ5MNfOJF29j/ytt6j6GfVJyQcDGu1V9F
 YzM+E746lUijkUKpKBr/KYbV1rzWjfVocyBhqMP3djNh9+BT6yc51cpcDy+26+iFjy
 ytNBD5vsgO4PJMlVr/fP3rzSWkp5g0tcqX7zfyzuS2j84CXLoENSSFFDfAUlQFpgbS
 Q16b5X9YhSeh57ro64FMLtPeMpYXQwX960eUJ9tbOr5UG3jP/phyYJXfSG9qMUjMVK
 v2l9/1oNHjVcEx7Gi/XiGY2JJ45V06G7bwVdYIGfeMKQ8WygYhYF7R14R+pULAyLSL
 m0Cm5wLPQCcMA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=lwn.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256
 header.s=20201203 header.b=qV+GVt7p
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
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

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> This series contain several improvements for kernel-doc.
>
> Most of the patches came from v4 of this series:
> 	https://lore.kernel.org/linux-doc/cover.1769867953.git.mchehab+huawei@kernel.org/

So I will freely confess to having lost the plot with this stuff; I'm
now trying to get back up to speed.  But, before I dig into this big
series, can you say whether you think it's ready, or whether there's
another one on the horizon that I should wait for?

Thanks,

jon
