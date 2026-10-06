Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A89CA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 22:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1FB84073B;
	Tue,  6 Oct 2026 22:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jPcCvQph8KPu; Tue,  6 Oct 2026 22:40:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 067104073D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791326407;
	b=H5bm0bidET+CHePrxGOTTOy1qNVVZoyMRtD0fpCJNL6hSn/3xpWBTTSnFSb4tk3sUlQm
	 shrYBVa+WqRTJzMWCUEib28CLQ3oz1pJdAd8MUX0oZ6p4Nmm2V8wAOd5uX4kQ5TrX2GAH
	 pwBPiQY0O2KSh8NM/TB6MpdexiMS2a7NAMNr7POMUpdXkh5BunSgaZglgUfeXH4WQlwCM
	 6Oo896440aDKhER4NpBebP146un5MdhAH1VgVP7U7PqMNFkWuF37sk+DJ2+Y61q8OasFk
	 /vixt4t/56aVRjMUqI8yDBx1AvFI8VfkMiIiJx2VfJhRCp0SJC/5uT2tOzC6p3u7j2A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791326407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=i7Ps9pmZebxv3PpSRa6dxRv0LrXDNcbGTjHhPKwCSKY=;
	b=oaDcRm7spCl8mZNumPT93g6D0ZH2jZRskF20L+ldnFQSuDpXPB/vetxz7k87uGuLRvP0
	 ANuw+kGbjdbMiYAYy4gsIuie6DVj1Wj8xMc/IUhueXC6j0iSVZsesWvz4RBJ8XQ+zEUly
	 mvVijlxRPyIwG2p5/SDomxxaLB+OwU/v/bYttZoCjBRRVofllkhezfr6I9sC5A/W4Bvmy
	 H3w0NII7R0DFgYsbNxnnfDsHuIYh9NdPpSpp+dxPbBnc3agI/+Khh03EPfNQo66b8yvCG
	 wmgRIvxek1oiHHgJss5G7pHRI2CBqUei/ezwEptMEtshw7RsMOYnh2P7VasKGeVC6Gg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791326407;
	bh=i7Ps9pmZebxv3PpSRa6dxRv0LrXDNcbGTjHhPKwCSKY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LeCLCkbfRp9bJY2d2Iqydhno+9SuZ48fvemp16PSi5aUl/9Z/Uv9zk2SsthwzLcv6
	 HWWCJgnEcPC4i+1XNYB31BvKqI2ToANiSL5Bxt89MZ4/Ke375VforREz7oUzZ8h219
	 QkCSoSFpdkhUjniK5hKKHtE4Eyx6I8iHyzRyT9oOYZxEa1adoERNxPqoUd8DAEZoco
	 6FV8aLTw/RBRyJshVhf46eByPPdcq3WsGmM78EqQfSgH8GHTw3xnGQLZRZkFcCh7b7
	 v4iSXu8IxTZW+sMHuUwIVryPsGr2r/pQE6/EMR1NL4zry6L0FIlz22EuBJ76iJG0N3
	 4++VHYtb7vtrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 067104073D;
	Tue,  6 Oct 2026 22:40:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF5D175
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 22:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99A6C402D6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 22:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IfLXYCceObkr for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 22:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7134240210
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791324523;
 b=QBPLkLMp/GzV45/SYYnCD0sq9st6/6SHaUAeTz7oPLFKH46g8/uE0/oVbUeGowRru7PG
 AXwfyLnZTNwlwz4hvZDlms6I/KgiAsZgXmvu9gpsoW9GUxXJFSivEcdSHh0ALje3bGemP
 u8QtoxbeUoWOXlZZM8Mn35/aRAU+F0IlNfqDBPFlVY6qYNSWV3v4f+ZBZTEWI39ZLZoh2
 3XF3gkvmntqtwUEbH1/Q8YuVHY0B0bYmDlUhCsomLytC+BSSWwRTBmdm/FWYdzfqnw0wL
 grYr0rRLKg4pXnRQWYTl/5aIoXcEW3ThTR3ee8m9Ur/si+Dv+LuNc/LYPtvm85cNbAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791324523;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:From:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=i7Ps9pmZebxv3PpSRa6dxRv0LrXDNcbGTjHhPKwCSKY=;
 b=KDrZlVrz0wTh91yjaWtWAmT+oeZu6iQt6SmCPM6YcijMgxChRRsjh3gH8ZvLGgdabtCV
 cpfXl1XgawVSJTq+aTL8gLTW4d8WL3kDGyHYusoMqeL9SjW7zvozRf8Pk65UjyMt+fnfJ
 MpRQy9Argt5CCCeR7n0/A7hi5YlOO2FsNr4V4zdwCmDPNk4ie7Fo0rDvlONbvUwdo2Jzf
 8QJx4t/J/wqfuhRSuRkPixjgtmgo9PAT8O1tM8zu88rnrwMfwH+RK3dDxb6AjdBltDZAH
 oxJtauyCPlwiWWyTmcv0RYXlvTgdtihLINjNAmQtnrjnsPnDd5B569c2K34dJ2lMR7g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="glDk0/xT"; 
 arc=fail smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=glDk0/xT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7134240210
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 22:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791324524; x=1822860524;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fvu+dBn/xR3wQaH9U/a1zYoo3dTLA6wBBCOXr99pC/A=;
 b=glDk0/xTeeuMWf8IBUgLgEk8aN4pPvYznKUrRHjEn/aot70w1Iht6Q86
 XMe2qk0HwLepFSMKJ4Yy4kl5yKnuoAX7aTS35buKBAmM9j4kIAHJVaRLu
 /3ub6jLQdbfwLhF1FeXg1I72uHcimBc8XZtsGQrZe7dFzqAPIv38AS20c
 x3iwvPHx7aYChkJA1sc9IJSmgVPhfYWtVaY4WJt+/E7Ru8r5D4UoStG1D
 7EqmGh8Tu8WjO5XDhj6A0ocxdhOTA1k7Qo8EfD3juklacyA1b4l5rtNCA
 9/pGpgbY3pt/WzrSIffZN69k3DBwvpzVfbzN6bG0RGQkq0YSBzoagBKv9 A==;
X-CSE-ConnectionGUID: njccp8StTtKJoiEOnudbPQ==
X-CSE-MsgGUID: t+5O5aFuS4GIW6mxK2z2lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="71403"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="71403"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 15:08:42 -0700
X-CSE-ConnectionGUID: 7AVbv+FaTIinVJ5VL1tnKA==
X-CSE-MsgGUID: dDDg1yTMR8qNrrMOUqO6RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="280505804"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 15:08:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 15:08:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 15:08:34 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 15:08:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6Lbrj65orqvmzIW02v1x9lFnqCTBW08wH1Hbx+PvV+AxCTKKqzc70JUHfk28iQbnGVhcpXPBe7ZeiESIZmFOVP5B63pehFR5+Gpckz0Ii3wUvimWwhU4lng27LqrlfK5hmsbCBFSdODmQbRdFJWdZkPBw1kh/MHZKOfHM6iv3rDvePX6ytTbM3sV6Jn2MlB/Kmy6olSKyr+pvVcimFBeTm/ijyMXi+rdCEJiD2FVsVIo4EVtg4SE8vd1CN1ynKwvNwekaXwFLdAECoYt+y+JRH87EUlwSiwwmLi/OMSVcFq8j0mryA+RTTscoT6GQTIXmT0upFV8CZtvaIvd05qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7Ps9pmZebxv3PpSRa6dxRv0LrXDNcbGTjHhPKwCSKY=;
 b=Y5MdNUlzqKk+a/nrmtmUWvclYnXRtLztGlb//PX9O7O1fU0tUFiE9+nlU1kOlUrYo7ui/VGRCIUP+YrkNutYMAvaR8fzt4u+yFONbI51xL9wmYYdrE6R44Qc2mJ11g5W2w66bKxZn6CzDUoFwT0kYSLo01kx1+ci5xD9XlZBGdzemQBeqCloNnDAK/ohTYMG58utqRS0uuuouIthV9/I7T/GsDugPeUB2ngScrkBxkzdSsP5LfONZLz2LZFQy1QfVk8AZz6E3zT5aG/wIKf1Cp138ZXna/YMk9ml9Bso31JBpBkMyl6lopP7jCMB1nBagWFtOc6Q7wRVxoB07Ah/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 22:08:12 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 22:08:12 +0000
Message-ID: <61ca7331-e7ae-4629-9ac2-8b4e451cda61@intel.com>
Date: Tue, 6 Oct 2026 15:08:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fm10k: shut down the service timer during removal
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Matthew Vick <matthew.vick@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20261004114352.1232745-1-runyu.xiao@seu.edu.cn>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261004114352.1232745-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e633ff5-1ca6-4bc9-eba4-08df23f64fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: x6Auvca27fzrvnOsEr4cjZNEmOAXl9nhGfnbGLspZ8SEMXUTrjrk72JoPlPmqR/U/8dCpxKsMfOINPC3psZbMMSQ0iFNv9bITabCQtu04D0UC4mQV5d062AM6KK1s7CXl3SMsk6D0tuLwm2fLTP0VjDMJWqVNJF60njioh6VYuBZ9R0Lqgf01WJOLFdas6zgKWJqqQUlLm2IQtsc16cQQOo+pGsXHcDQpIS/x7bd5gOpxtAZOtnxZvmNM5KrJ0Ns1w3mLYl7VJmjL7psbxMT/lcz9OMCg72VWffJACKNy4vJ0LE6WitQ473S1pSQt3xB4kmGKBQ8HY+so3AIoSdl1IQXXBkUJ9frfVBQMG7scHUK3pkg2b8oxMz/mwgYEQ0HtP8iSynCNY5h9NZ2KUtjf8dDd5YN445bHvRCVyg2YUi72OBLbzZpdK7i1AWhZfmVJXmYG8dOIXyMviz4XL+ssaSkaE6D59GLUJkMFkaylH/yf8PvOhUDSuAgMZAONNuqCF4aYm78Ul4ZZ/ARFkbgNcRtmyjl6sbKSGcWvv1THnGkAndin9obFj/qe3evVkoWaZVO+HENtVyh7jq374sr3yd+TuiG7Mu5GU8B5QVX4EH9hv6vxQ2vL4N7c8/1gDe7mbYI5Bqf0nDvlLMW5gbVsjGL1tDJ8Wj37SOFQAy9S3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2tBKzk0cnFudEQrZWNGTHBRakxoVE5hc3FsQ3lDb3NONnJaWWx6MVhkODNH?=
 =?utf-8?B?QzFicEFPRFNLVGE4MWw0dVRCYkhOUlh5Y0hWb04vNGNKUUYrTFVROXp2TU9B?=
 =?utf-8?B?YnhIT0cvMUh5WkM3U201M3BNOFk4aDYwM2YxUHJUeUdaNWFnWmFZR1BKRTh6?=
 =?utf-8?B?WkpXbWs0VFB1OFFCVWdkODVwY1N4d0VvVGJFUE9qQ0RtVjhxdzNEY3lWMHdB?=
 =?utf-8?B?ZW51bC9NZzlqWXBnZSt2b1kySWthRTRGV0ZYYzZtUDlWcktCUHBJZVRMdGlk?=
 =?utf-8?B?TnY2Rkh0VVNmb3YvMlRDb3lLQmRQdXVyWTZ3a0dIclk3QzlYVkxhMEtpNGFL?=
 =?utf-8?B?V2kzSm5QRDY0OWJpbForeXBqNExvbUxrSlIxRldnZUxibVMzL3hwcnQ2b0Fn?=
 =?utf-8?B?cG10R2ZqTnA4clNmUkUzU3lhQU1UZ2lzcmlYWE9ZQzc3QzBFL3RaeUgvNlRr?=
 =?utf-8?B?NHBOaEZhMHJEVzhIU24yNDhoWVMvTjhWWFJleEJaSFRyV0s5M0locnVRV2ZL?=
 =?utf-8?B?aXpaQXJxQnIzbE1yNE82NHVLbmlXQjFxelp3UXM1M1c5bzliZURmRTNiZ2lk?=
 =?utf-8?B?TG5qZk1pZVl2dS9VSG9PKzZIL3FPdmc2K2FxeWZoR3ZieDQ4cUxPOCt3K05I?=
 =?utf-8?B?T2tzV1FjREk4VGp0SXo2QVdWZUUwd1NzRjAvRlJDcGNCTGFMVVBBb1Z3c2Nu?=
 =?utf-8?B?SG45eVFrNkpSN0lWTmNKeDhJRyt0aWZxSnUrM0hoY0IrSkdSV0dEQkNjb2RB?=
 =?utf-8?B?Tm41cGdseU8xbUlJN0g1ZHI3S2Y2c29uYnJuNWVVM254WC9aa3VzZTBCbk1w?=
 =?utf-8?B?eXByNU5CT0hwVnpKSjU1R2ZGYzJtK1oyQ0IxazV4TDBKK1U2V09yYmFqSEhT?=
 =?utf-8?B?amRqejNsd1VsNFZHamJZTVYvV1lsWk4yVXJXSjdkQmRZQWl3ZHdBbUh1NDRh?=
 =?utf-8?B?bGF3bFVXWmxaZkJvNDEwRWZCS01xR1kxbStWOVZCTDIyUldWNURlQ2R0ZDdr?=
 =?utf-8?B?bThSMHUvU0IxRHNZdWoyaXhIempNSnVsZzY1Z0lWU2MrOHZUMkRDaDk3bWtq?=
 =?utf-8?B?U2RlWGZqK2N2YXU5YzFIdHlnSGZER0JqQ1owMlcvdlpMVERQdDJUaVZOMCtk?=
 =?utf-8?B?UUNlS2kxNUhMcktMNDNDVjNpaUxvYUxoUkZnVUpyNHBEVjhzWVdTOE9yNFRp?=
 =?utf-8?B?SjBzYXJ3TzlZK2JnWUZudlNNdXUxdFFHNHpBMmc5WmwxbGlpTlVIeGFEQTFx?=
 =?utf-8?B?S2c3dEtLTFlIOG8zTFNoZ2dwdTBueWRyTjlHKzlCb1ZqaWYrTDdDa2g3c052?=
 =?utf-8?B?Wk9RWllFVE9WdElDTElFanpVNWR6SzFjQUZBM01WczZEeWhiUk9HTWhRN0Na?=
 =?utf-8?B?TjIyNC9CYVRhY3JlMGpYUGxpOEpjOFFENExmYkhXMkt4NEg5ajR0TjBEYlNv?=
 =?utf-8?B?U3ByRGl0OVBVWklUYThWRk9TazJhbXR0Sld4dDJScHh2b2V4QW43QUVSWVhN?=
 =?utf-8?B?Qk43Um5HeEt5ZjdDSnFneHVPeHljeloreG0yWHY5TmwvQS9sbWViWjBVV0xZ?=
 =?utf-8?B?WkpZblZHU2xTMzA3L3QyTnNFdy9sVGhSTkFhRlNaYm9JR05pYTlNb0pDYko2?=
 =?utf-8?B?QktSRjYzSHUyb3J1Qml1U0tpQjlnNmlGckR4Sk4wWEVxU3dManRWa3FFTjA0?=
 =?utf-8?B?N0EwR013M3Fld25Ud3B3MWo4QUsxZ2JGT1BNYUhWVHhwS2phZ3hBLzVrNWxy?=
 =?utf-8?B?ZWF3M1Y4UnA5aVpjcXNNenB6c2lkdTIrMjVON3Qya1hYSFBjRGFmQytaOGxv?=
 =?utf-8?B?UGVoVDI5L014RWZCRlJQNFIwaURaaFFNb0pQRk5uZ0t6YjBpaWZRRGRZeHVF?=
 =?utf-8?B?aUJBc2s0OFdteWk4NHNTSjNrM3NjdCtPbTEybW1iMkJ0aXhzMVBNd1ZZaERR?=
 =?utf-8?B?OUFNMEJrYVllRnhRMXA1dW9qcVNVSGFQeHpnbktzU3Q2cjZBemRhNE4yK2hy?=
 =?utf-8?B?VFA4cUIxakV1VDR0TExlclhPWkJwTjBENzFRdHp3Tll1YXkzdnhXckNwUUxC?=
 =?utf-8?B?ZjJZVUdNditQTzlPMFVDNGdRMU1zUjBOT081VHJBU3RkR1haNGRTVnEwa3B0?=
 =?utf-8?B?N0ZQZENjSzd4cnFDK2xYTm9VajdjMGp3MldkbnBwZTdFWVpIeUpiNlJWTDFI?=
 =?utf-8?B?bngxTU5IdVo5RVFjc01nREVJZ1JhNmhpc2w4aitkd1FrZHo5YjhPc1JlMjFH?=
 =?utf-8?B?OXhoTUdSZWxKSWtab0ZRMm1mWlFybERwSVVmSlh3bGFkcWQ5MUhzL3UyVEtY?=
 =?utf-8?B?Vmp2dDdETHdzQnFrd0hsTXdWWU5wUjdnNnBXUzg2RzdwTnFPNXArSjRPVlhj?=
 =?utf-8?Q?6aN2zWjS8zeZR/BE=3D?=
X-Exchange-RoutingPolicyChecked: uBeDQrcsiSPY8nAE3QSkgh2XIWtmu/V+o3tb+MJV2i1KBwc1XXKDhZY69GFmlibB4qSdl5Up01g4xWBK9snICVKMCZZ1BYqbi73aXhoSctpVFXTM87c/iMSkQWAMK0FyJchrpOWvwwvbhZbPYgWoACmSeJaxILBcJ7Mm/9UoOJKvgY+ofJq6Xr2XE9ne0atokd2zV9/fJK6MT5T1ZujtaZI70ls//XBkHjxkM3Qh5uOHVejD5EZhOwqMD92Y0OCPx1PITvDBrIjRuHFcgtKOLrApNwwphWItDfEAkbGmUxDtepVTZdClqAov2r1cfJJcls2p7NFDtvThe7My8onb5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e633ff5-1ca6-4bc9-eba4-08df23f64fe9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 22:08:12.2727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvTKL8SvQsvakvQ6GghPqMkZIO2p/LMMH0ipRwnNO456lFap2nOTNwrjPWk4ULaiLMPryVbH3+axV1zdzEbF3wqaHBmOiaMLGIw3Nhjx6tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com
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

On 10/4/2026 4:43 AM, Runyu Xiao wrote:
> The fm10k service timer rearms itself from its callback. During PCI
> removal, timer_delete_sync() waits for a running callback but does not
> prevent a callback or another service path from rearming the timer. This
> can leave the timer referencing the fm10k_intfc after free_netdev().
> 
> Use timer_shutdown_sync() to permanently prevent rearming before teardown
> continues.
> 
> The issue was identified by code inspection. No runtime reproduction or
> trace demonstrating the failure is available.
> 
> The patch was not tested on real hardware. No hardware- or
> firmware-specific runtime result is available. Validation used source
> review and available build or emulation checks.
> 
> Fixes: 54b3c9cfad6b ("fm10k: start service timer on probe")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> index f5b4d0627..836664cfd 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> @@ -2245,7 +2245,7 @@ static void fm10k_remove(struct pci_dev *pdev)
>  	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
>  	struct net_device *netdev = interface->netdev;
>  
> -	timer_delete_sync(&interface->service_timer);
> +	timer_shutdown_sync(&interface->service_timer);
>  

I don't think I have access to hardware to test this anymore :\, but...

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

>  	fm10k_stop_service_event(interface);
>  	fm10k_stop_macvlan_task(interface);

