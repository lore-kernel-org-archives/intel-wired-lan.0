Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0342AC3DA49
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Jul 2024 22:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B172E6079C;
	Thu, 25 Jul 2024 22:26:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eEuzARW968pS; Thu, 25 Jul 2024 22:26:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0461606EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1721946384;
	bh=jDxVSJhiMlsrkovokL+3p48zJoCus0/yKse10umzxrg=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XjWlZBgbyVV1LgiFPy4qxw4nMWjbVDSDuUJbiplRenFmqfmV4KVlZrUrgvyjGOZAd
	 QrHoRkC6P7seRPsLzZWgSLoXEqDX8HIosqRWQxK7XYsvkQRquGEnz4ekjLdcZ0x8wA
	 YkePIJPOpGdlFSNX7Rif6Z9b9XHKl3/WDLcd7y6SsVbNMQOs4j77McBQxuj1t0A54J
	 3sZKGSLsnNEF4StE17NMmh9Dd2dop3JB4pRpwdp6ULEqTBc/8uFd//H+N4hz7Q4xc8
	 rwkeD1KXd0wxam+MWlR7L8u9Qkat9m6j0Bkr8c7BzwWvo6jJP80vugSvdq+YhaZpWu
	 417CxOmeOLZWQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0461606EA;
	Thu, 25 Jul 2024 22:26:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 830381BF3C3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jul 2024 22:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6BC2840217
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jul 2024 22:26:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a0UAhfyDgQ4G for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Jul 2024 22:26:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 94DEC40188
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94DEC40188
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94DEC40188
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jul 2024 22:26:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 559B461237;
 Thu, 25 Jul 2024 22:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA0DC116B1;
 Thu, 25 Jul 2024 22:26:20 +0000 (UTC)
Date: Thu, 25 Jul 2024 15:26:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20240725152619.75787373@kernel.org>
In-Reply-To: <20240725220810.12748-1-ahmed.zaki@intel.com>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1721946380;
 bh=fJHHbC3sfxfjAFbMnFHrHavQdpnYTeHQ371xF7CckrU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ist/rV0d6lnFSQ6ObRpMW6CEYTKsb1J+HS4PkYksNpsC1u3rqnuYJlnsgVXZhh3IJ
 Wo4ti1mX2/OP5UO/ugBaIn+AlqFkpQ9uPHjXfup/HRSmBgXHz4IBK6XpciaEeMV55L
 CVy/HA0dhtKPJ+kJmIWr5ZHiHjt3U9AQgbEQkx83lxU/xAl/eFNMAG1hjXuPIsSpro
 qu2hFs5jvkt7n/9f67i63JM59nguiEDHkjvA3BciI0JZu7TodL9BCBc7tPm0sdUfxx
 pkGAfJcO2y1UQIWlSIkqliAvWIJo/nmmlpJOBXSjA9PSbIgn3vGLjb4okmrag3Pb5X
 uAhjRHzXWFHIg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ist/rV0d
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 00/13] ice: iavf: add
 support for TC U32 filters on VFs
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
Cc: netdev@vger.kernel.org, hkelam@marvell.com, anthony.l.nguyen@intel.com,
 horms@kernel.org, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 25 Jul 2024 16:07:56 -0600 Ahmed Zaki wrote:
> v5:
>   - Add queue ID validation to iavf_add_cls_u32() (patch 13)

Is it really worth reposting after 24h without getting any feedback?
I'd say it's not..
