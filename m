Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA5DC624DE
	for <intel-wired-lan@archiver.kernel.org>; Fri,  4 Sep 2026 15:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2239240BF9;
	Fri,  4 Sep 2026 15:08:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HTIqTmTN967E; Fri,  4 Sep 2026 15:08:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AB2DE40BEC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788534499;
	b=OlYBo0icWCg+tmbizG2YK4uLKl45Urn+PhQ3TIKwf1ceLLI3oEz2dSmkDjej9i+a1wHZ
	 ShpXZPveZolFlsdykAAHVDsYbhiw0f/23gLqsgvF7GC2LXrVKnk6hvopdDj1nXxHkrNvb
	 D7N4J6cWxTLIvJFsP99keZ/AulT4JKTQ6+7+6Dt5EGmNKmgG3Yfao7C3Cgmx3v23cowX7
	 fkvRA/sDmcd2nklzmG3+Yislw7UhOKd9vhnbl7sHg23HO77ytdrWOHyeHwnozn1IZzBzL
	 p267WpCoZPA1gFlNjUT3L8yCgzI2nRCkr1DZ2/k3rAoEYziD7mHxybUk4eIG4+QIc6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788534499;
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
	bh=UDkaguzm6fv0k9j/jCSwxhnul/hppa7Y3WFU3a3ZuOA=;
	b=f1fWtPmIeCM7TYVs4qA73Qy9xk+CLv7qOIT38t2j69svOO6cPI9SSTeMckNKoKFwDLgC
	 +xkvZ7I39bJS3b66xpRFKKkkQzlksykmXr1921PNbjhcXCG0gBrhBXuHoQd/IQ9Hkxv4Q
	 +5stuLO1C6vN0UCmYar3uAXFHdmcj/Rqqr2HSAmIWhlRvGU2te6+LeJr38wfWv3CAbaAn
	 ZPAxc0Kh9mGpGLsyo0zzckmwY6INGLSrzlGCjAUBriJnlGzz6SpNOp7pTi67eZGZvDpyw
	 y0sZ0UGyY4M1UZpCkVJfJr2SUomWG+ktD91aO/i+GAO065ofkYRC5YduhS2IFvCh8ig==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788534499;
	bh=UDkaguzm6fv0k9j/jCSwxhnul/hppa7Y3WFU3a3ZuOA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SIfkt7M4Q6aav4oCLtbzjXZxFynNCCbXCuTZxE/DdZxIcFHqZ6H7cpf6oDU6R4HSU
	 zpbzdogrQt1kgnqURn2BGo6kU2BSF+Glb8S5RI+P9ql+mqJ93iNCQyWH6oFKf4bWUF
	 ahCxbowu8dtYUhe0orWd+JOj5+G+itCzfdZuaWunNQiTRjShelCN4o0EJLSzAHL2na
	 59lV5fe/yvmyqO1+56KBJvMk/sOhu194KEszM/em7SErC+cDNvTYkqdxqpyKcgwKPm
	 xR1petqm99J5AE6LSX35JD/AdCtw8KWNbM0Zk4XkhI1KMUaBmIN84LsEh80+O5TZUF
	 rOKNzEq+7IsCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB2DE40BEC;
	Fri,  4 Sep 2026 15:08:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 904D210E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 15:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8193B80F6E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 15:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qoEdHOVKGHU4 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  4 Sep 2026 15:08:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CED8680F05
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788534497;
 b=r8XgXeZ1Y8sSis0oY/WI4xgEx4nHWgX6YeAC98LCBXZaXJPwMk7jtBsehVedAm4Kd7tZ
 Dj6HPf41jifbqH1ellQAuTHChPr2pXdZDN02KIxDUPw+UYixCqaxtY0DTd5heajqQ9a9a
 j/ZsB9fEFZT+/+HHglLVMK+Sc2HjNlvR0yYZJkh//nXdMmcdhIoXmPc+IqmHs6ULR/4lF
 qcIVr4wAlVZjfncRby2vLjLYa0MEEehh9P/76jV9zFuex95r+vqvrG0EQf6Jfg0pL/gct
 uQ9wa6+y3yTAqlByTCkaNLN/Pvcjro+0z+znfJaps4RLy0E4gQ7/G5dJd2fD6pWyckQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788534497;
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
 bh=UDkaguzm6fv0k9j/jCSwxhnul/hppa7Y3WFU3a3ZuOA=;
 b=Xp8287CFcsWjjewwW+eGM1XSDDRNd2pofccDjUy+y0T5XcNlonWeO06Er2xkgKh33AM1
 1NBhoU1fqex2oaWELswm0Ns4VnhaQZi8nbPZ//CnniGV71X7sg5FfLeWc4t+LOE9UpFBv
 PKWGn8wn5H1eJiZndCl7gU/L/HAZzhgmLf5916BOcfGET36fF5Mk+T14SVq0d0M8t2yfl
 9tn5dmkmfwKeeZYbsKHWSZ/dcBFkZjrEbk15b4GXcLKJUQnY2WGiG0n42zp/3amb8Fgxx
 vKYKStTtRoH+uXS2IzLlI4BCAhSJPFq3gaMqA86YDwBs6gyvrESKBOAh+xBk6Ks2Wug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VxLiKnX6; 
 arc=fail smtp.remote-ip=192.198.163.18
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VxLiKnX6
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CED8680F05
 for <intel-wired-lan@lists.osuosl.org>; Fri,  4 Sep 2026 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788534496; x=1820070496;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JHFJRZC7aT2Iatz/Jjg5ekeq+MPKRo3y81VuaekqnI4=;
 b=VxLiKnX6pPXZa1PqgwXRyC2JyEBf1AVbmfh6qe3/cWUSfPBOnI+y+Adc
 ApRnB78bKkyyowFjfXvoCL+HIZzmFLZi98yQiy3ZJQGLkx1mwee5l/37z
 qoeR8JhVo27Y6kUASCxVPDOhnJ1nCejy91r6LJgDAfvO/q0WWQ67+1yuZ
 CjXKg5ZRCngg7fFEcPPhVbXY+WgutFJp6HwIqyQWAX/6TdHjwTqq1FXvj
 8ZW7nQqRUMEpYNTygw64w9NwiaBVtTsu6cYq8xNME3+pAHtRQT4xEYm6i
 ithRhPDrl0joHTfd6IwEFNXMvb0lx8MSoDDRIp2IrrBrDfDwpIwlU71yw g==;
X-CSE-ConnectionGUID: Byb0te+kQ8q1/z+QxOi0+Q==
X-CSE-MsgGUID: wdTAwlkQQnGOayJ/JxWmBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88180987"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="88180987"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 08:08:15 -0700
X-CSE-ConnectionGUID: QGGa6mSrSK2BTuTP9KJOlw==
X-CSE-MsgGUID: E0MvG8uPRlSuWIXXwURqvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="272003215"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 08:08:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 08:08:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 08:08:15 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 08:08:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWDn2o/1OuHrk96QQ6bqbSKQ8oyHJ6vw1gsv+z0hrxcxJtFV/RffXotfkzNJlt/xEgWQmDIhy7vPsbIeAEaLkicQ5DI4t0HtQlb+yPJ7eYuAMgb2QYL56t6Bk2ulJsMeenngLlsDV61KxqMH9EoSCnwTIrC9SkRvl+ARTXujYCCDWbuhzoBHdERw/kB4xyYsPJYlZupFdAVidTs6JqI1BVvYj4u+ZkGgU+eR0165SCeyX7jlCKr/080bpD38eg32X2+fNcGUKb+sGiCuYd8c2KB+c48ay2AFq3Ow82KQ+7kMRhvg9e/XKJ6KyjaQhoi4LpM7pmNJqo2jGjR//IIzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDkaguzm6fv0k9j/jCSwxhnul/hppa7Y3WFU3a3ZuOA=;
 b=ugd91YZhKRzenKtyy2RBPz4KXypM7uu91d0WoVsYXDXZRMnRVLhdJATfGOb3BO8U7EsHHjr/qp0oj3716MvHRSQ8+Qyynx70PXZ9E79cXllbyj9K0yqUkcBItwPQRb+aF17IRJXP+sk6OxA18s0d26YVoQ0kETop9kQztaxHgqkbPkrOK3n42qKYSBli6wZ5+2d4XqJRY9pN6EOn00cYqeuPQSnUioDSiFis705CuLp7XteBNqjXjbIYAnAf3Lt5iOmer5v4Y2lk4GwPiy8F9IulM9RcXIUps7GMyY9VS12BcorLzV1PmgWpNpucurt/4En1jEeQKDVqJgeu4yM7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SA1PR11MB8573.namprd11.prod.outlook.com (2603:10b6:806:3ab::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:08:06 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 15:08:06 +0000
Message-ID: <1447effd-b291-4253-b63e-ec36828fc2af@intel.com>
Date: Fri, 4 Sep 2026 17:08:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ice: restore DDP state during PFR recovery
To: Aaron Ma <aaron.ma@canonical.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
References: <20260903074706.602087-1-aaron.ma@canonical.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260903074706.602087-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0312.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::17) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SA1PR11MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: afdd5e16-6f7b-48ca-967f-08df0a9652f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: b4jH/Dmh4XlPvnNE/q8PPe6/KkfhozBma4WoKt80RpRB/eWvHbpRYqEFvB5l1WqnvDJk3G9FVRnWSn1fnNtQp8k0QoBOpJJSAxdl41ur83WV1Md5TSNNkuflPqX0+gW8psxdlqS8uIvoQLc1V+PZECz+NPHQI1GiEc6y+ovPnslGADrRnKStcBnG9gZu+Yas0Qs1HsxRkcgOu4mzc/wpB5qnMpguo/zDh3skctTBu7cH2RQCC1e17xVfcqHtSCK5xAIqcLXKNS69Oh1o6FA4MmOYBjvEvd2dnGJpGlpn8qHg4a/PkKutWY61HOjoRxEfJYXFuj5J/AWl0nMAWvRBzyZseDoZImMzE7L4SPzGdTssmE2Yg8IVewgpD98NAYuwdJWcIjZYF12KJQuIu+wZlrSBFGGBx04rXlQ32aW7/OnTuuZktsLW/8N7jTMYCUV6Qeqt+eGGSg1qOuSjg88hNg5HKral9W0jcGAX2O1/xHdKrQ+DCWpjDlov347wZ1CD+h40IHNRdvUYVgJtEcuLuzk2hXsDFBuBg606g/JNKLUKdBszmPn6qhZgf99aLGmekeo1LAtV0tYGxVS26Xx1UyYGFdaWfwNmbPou+Vy820as5WHxcvYr4TRKp4/+nxYfTNCOS8ykVxQlS4YdeVQoGSfQmJ2dfXmzjfiPNNtOxd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YklkRUg3cXZIZUdXN2lJQ3NOUGlWaFRLVXNoRGd2YXBHRWl0RVdBSFFpZ25E?=
 =?utf-8?B?a013UUhaOThiWDEvODNiWmtyc01UVEdBaHlqaFliUnFYWHZQM2t4cDJ1TThU?=
 =?utf-8?B?dWJ2Q3o3NlJ0R25tQjJ2MkhlbTNWcmY1NnAyUnpHQUxLZjdZek8rZzlIengx?=
 =?utf-8?B?SGVuUStpRXNCNlkyWDJVYjRlcGFmVjZGb242cC9mSm54d1lPRUtOcjd4M1c1?=
 =?utf-8?B?ZDUwRlZVaFlDLzdCS01VNFJzMWZmRkxJVGhmMkUrcXBCOTVKaXk5cm1EWmYx?=
 =?utf-8?B?OFVJdGFJTllGMTFOcW5iR0xVNjd6THJHZ3JsaEZqUFE1U2NIczRNVkxpSVUr?=
 =?utf-8?B?V0RWRnFzRlBoMkhzYllxTmFiTEIxeUNjdUtJR0JGclNhNDRCdGtUSjIxY0xH?=
 =?utf-8?B?N1YxclVMRWhmaHMvSVBxWDZ3dFJ0NUdXYmJWTDkrK3lWWGJTeFdPN200em9L?=
 =?utf-8?B?VHp1cHpqV2JsWVN2QTBOK2NEQkJ5TTM2OHlNNVRNWXhjcDdkZnpXS3FnWEZy?=
 =?utf-8?B?NXFqZktVWXJTUXFSYk5MaFRraUVTNGsvT1g5YzlzcG8yRWZCa3ZXdmVnL0Uw?=
 =?utf-8?B?OFlWMjNYMTFxSDhMYmFEN2o3N1gxYUZPeUhMRE5MbHhrVDBKZ2hjclNJUHcv?=
 =?utf-8?B?a1VXZWFVWHN1dFZEbU5ydGx6TUlXSWxlenkzZzVHS1hqQVlBTzl3RmJKL2R1?=
 =?utf-8?B?QncrR1AwSUZ0U2RJRE13dnFCUTd4ck54c2tHQUV2MmZlVTlkaVBXY1ZLU0Zp?=
 =?utf-8?B?R1o5R3FVNUNwZEtoWVVOdmpaT2hoRWV6YXE0dVgrOVJmSmw2MUNGcXBHNGRj?=
 =?utf-8?B?QlVYUFppZXk4YVVlelp0K3Jhdmc1VmJhaTVta3pLUEorZzh4TndoS29xamVL?=
 =?utf-8?B?bVJxUUhkUW40ejZkVFlvVElpeE5NUmw0cENGSW9JS0ZZOGUzU0V6V2p4ckxt?=
 =?utf-8?B?ZFBLQVZtaEh6R0JKbEwrdWQrbzNsWU5IamQ2a0NtYnhvdm9iZVQvVTlHcEZ5?=
 =?utf-8?B?VU1mQlZNUlhaeVNEaFZ2Uk05T1NZTHJJRTV1a3BWMVo4NVlxOWQyKzIrNDQ5?=
 =?utf-8?B?dmlDbEJtZ3VRSnhpRVd4QXp1YzZjeXo1Z1dxYm5Ba2tqUFRqeUtXWmR3YmV0?=
 =?utf-8?B?M0xTYnorVVhpYm5BVmhXTTNFRWNFL3hUWGlkOVEvSWJFNHBlQ3VnNnFxd0lj?=
 =?utf-8?B?L1pKSDFST0lZWUZBMnF6UWFEKzRQd2VjTFpxSXJKeXFFd3ZPOWhObElSNHhp?=
 =?utf-8?B?NVBWRGVKOU1rNUVaM0s2dVFUcFJiSndyekIrU1hZbWFjbzNFUlNmdk9LV09F?=
 =?utf-8?B?bUU5dlJZWVlCV0l2WG16d3NWR2dna0tDbWIrMmozZEhyZ2FQS3crbk5QMXdQ?=
 =?utf-8?B?TkhGZHgrK2FyeGx2NFRQeTF1cFBTNlRRWGxOYTcrZ0ROUkt2blEzMU41UHNp?=
 =?utf-8?B?WWlERDVjeUlteHhmTk1WK04xTWYvU055REppUzdiVnRmRWxjcXUyakprU3h5?=
 =?utf-8?B?clE1MWNVSlh0WnJRZGNRS2FsQzZzZElDbzExWHdXU2dNZEE5bzN6VTN5T0FS?=
 =?utf-8?B?dXI3L0tCM1pSNXg2WnNZanoyUExwTk5FTWRaa3BlY2lqQU9YUXJZVW5hbE1j?=
 =?utf-8?B?cThtNm50bk83d0JUWUViMjZwSTB4b09GSG1lT1V1NGJDb0dncmxZQTBCNDZl?=
 =?utf-8?B?UU8vdU03RG1pT2tYMWpPSWhEdmxyMWgzRmFrOUhXbExCTzVnZ2hyZ1liM2tr?=
 =?utf-8?B?RnBTZjhYZjBRTDBvdzNPaXpmZHZkWDQwOE5iMVVlMi9wRVI3NzlRR2t5RFhy?=
 =?utf-8?B?UTFlb1h2dVV1QzRTSnF1WGxySEI3VWVIZ05ZVElwWkJ3eEN5RVNMQ2N4Q2pk?=
 =?utf-8?B?c0lUNXdtd1NGTnhVMVBHeVVCdldkamlhZ1JDa1JMZWxPZUJiaWs5N2FPVi9z?=
 =?utf-8?B?VzZQVGI0SmZ3TUh2N0JhcHV0UFptNnN1V0JHMjN1UHk5Z3NyOUd2bzk4Q0FB?=
 =?utf-8?B?bmRmZkVtd1RZU1JQbmgxL1p5emlhanVIWmltUTVmVkVoeVREZTIzVmFZSFRN?=
 =?utf-8?B?a0NuQm04Q3A5a1pQYWcyL0lGZWdjRlJxNXRJSlEvTXBpM085MXVMc3BwcG4y?=
 =?utf-8?B?TWRkM1pleTl6Y0JXdHZDOUg2REF5ejJxN3I2WUVkcEo5NDF6U1BNWkxscnRG?=
 =?utf-8?B?QWtwZnhjenRBV21ZN1MyZlVVQ2Yrdk00ZzVjemRjU1p5K3JlWFR6OFd0YkVQ?=
 =?utf-8?B?Y3k3SHkzbXRMWjF6WExGa25NSi9xLzljaEpNQ1JHc2FENTRDdnhFYWhhWm9F?=
 =?utf-8?B?K21EQkJKeVVnN1duWCt4WmhXZlVFZ1pYY280dzdXQmxVdExJNm1CUGJmOXBx?=
 =?utf-8?Q?5fqUHSe00nI2qtCU=3D?=
X-Exchange-RoutingPolicyChecked: JVVXjOa0qH4wIQgSFrMI+qtJUMsKdUId9m8vVUJk1CzbLmKMk2+cm6/0IMnTHchVK6K7eGxZHCgzZgVnvyypKCEsb1ri/pSxXJTRBTqT2p9/9yWQkd3TGpi2Siw+cIlhgNTYYVbW1SpgrlnCV8oVqFzy4+PlOf8qEGIya0i7uTzqrl+uMSWpF/+0v8kk7ajxexfPMa+XTQ7+L1cbdw/WegigD3HSvL+4+sMznm2cbTkjj17XSHBFu/uneft03a1VaSkXLLOn6CEkQ5MTrehklq7AOQ6tz26mZXA9WETCILT41YWgB8DekIj5CEzMRs5OZbA8YkPrn+LXBkFwAoc+pg==
X-MS-Exchange-CrossTenant-Network-Message-Id: afdd5e16-6f7b-48ca-967f-08df0a9652f2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:08:06.5899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JITIBx4wOJ1Gc96ZQlX8NoExDAy1d8w17CF4OabI+m47iwWyu2lyf1/tx5GdrqGFxfx+oj15lYZUZhV215xHprcH2hobHeoHKpcvN8u/Hwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8573
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

On 9/3/26 9:47 AM, Aaron Ma wrote:
> The firmware package and switch recipes are shared by all PFs of an
> adapter. However, each PF rebuilds independently after system resume. The
> resulting package downloads and recipe updates can interleave, causing
> firmware timeouts and leaving interfaces unusable.
> 
> PFR also clears package-derived firmware state on affected devices. The
> existing PFR path only rebuilds the driver's block tables, so VLAN recipe
> programming can fail after the reset.
> 
> The failure is reported as:
> 
>    ice 0000:04:00.0: Update pkg failed: err -5
>    ice 0000:04:00.0: package load failed, -12
>    ice 0000:04:00.0: Rebuild failed, unload and reload driver
> 
> This was observed on an Intel E810-XXV-2 adapter (PCI ID 8086:159b,
> revision 02) with NVM package 1.0.0.18 and ICE OS Default DDP package
> 1.3.43.0.
> 
> Serialize rebuilds across PFs of the same adapter, while allowing each PFR
> to complete independently. Reload the DDP package from its cached copy and
> restore the default DVM recipes before rebuilding the remaining PF state.
> Abort recovery if either operation fails.
> 
> Fixes: 462acf6aca85 ("ice: Enable DDP package download")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>


we have FW-level lock for global (per-card) changes,
we have also per-PF SW lock to protect global-update from given PF
against unrelated AQ stuff

You have added a protection for the case PF1 starts its SW preparation,
then other PF starts the same and its first to grab the FW global lock,
so PF1 could be confused.

I fully support this approach, thank you!

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
