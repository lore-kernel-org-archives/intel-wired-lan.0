Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC4606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=yPx/reSb;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RdlBwdgU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E80160677;
	Tue, 27 Oct 2026 21:36:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ebha17tI31P4; Tue, 27 Oct 2026 21:36:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B33146068B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793136965;
	b=kASzn+WZH7QXM/+bO4d8chXAiOmyoEb9abrbI02KQWscRp3WoQRcHPnd9aEOyvqc6l7s
	 CNekLzpbelubFcWILSzApfhr2GwUjgw+1c+TSr7VEBMBy9LrVv5I65ujszXr9LGss/N7w
	 eaXofXtVeyL1vVQIT9OpqSYV6A8TziDhHUgP3IeanYtfkD/RAJ4hc81Sqoj2uZf8PJY5Q
	 SFsstPSk+wQOGeTduJ+BTkTsMrvCC2rCJgit1RbkFrxUuSHpU+Eu9PJZnzet0NKScH9Zp
	 t0LpNbNKmSoVYChhgBUqR8lgLV6jcLZR3KmWYdpXSAOotNTErm/4QR3LqkLmeLx8yPA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793136965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=XBtNHD19F8q9qg94y6P9EKIrX2lVHe/nbhpO1b5EzzA=;
	b=WJFg1YwiBRBxjlVOZNFU40/3GAHFJ1CSecLUzoNmTK76ELMeOhP2wwysjeiLWhvBSyND
	 VN8A+bdmkwSv+LuaAPODRNw/+RBjxlFk2qowhFFOOsSX7EiMPM/2MlreP5QCJklBXctOa
	 ZI6R2yRFBLmKsGbdkT8/HH/vgxvCfqGifNAf/vzS7/UoUr3peYY56d0rKEXh3TQoRlOTo
	 6ugRCZv7kDcvU6z1HdCQq6ewysvlEy4yt4nhdiTvjmUXZiUtbDrJ5fFzC3fEkm6AhL7cN
	 5TYrPcthN+BbI3VmQKelGoRpnPr4Ox+Q+DNJyDIKEVcqruIdlJpPhK49QS0gV4xmKXA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RdlBwdgU;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793136965;
	bh=XBtNHD19F8q9qg94y6P9EKIrX2lVHe/nbhpO1b5EzzA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yPx/reSbPoxXdp7Hg632jp709zvrjfi2FG2q2rVzBgOa2LJyDXtncFaQOthiRl4Ru
	 ogFGtoKT5scmoQY6oDoaUEDPlO6wUb71t6KurA/5FniGWeSb+dk7H0NT3GTNSR0FBJ
	 Nse0kGXxyWDQyUMNBRibnfSSD0EVieip407/JKnJvtLtCv3Je9w7yG9fEzZa2LZeIu
	 0MyXAK8ZLUXp2DKSbnjgfsw2rlCehQw1t60Gvyr3I/FMADSeCnefjdAiGg2g13ISJT
	 YRom0vCF3VbuFz4EI4oL4VPrjU1XujY2tS/7QeH3uHseNu0FNodaiGK3BbnWGRQDsZ
	 BMzzzKU9aGMHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B33146068B;
	Tue, 27 Oct 2026 21:36:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51CF0529
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 21:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37DDE6068B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 21:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id abR7DLTVogny for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 21:36:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DE7360677
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793136963;
 b=naiR/aghyFqw1y8DJYGgP6+l8YsDKZNW0D/XQdbWvrXzEtN3Od3ZCt9bEKHLBOyE95/L
 fvYBncE5ke1tmQuHgYLEfgteQhU64hVJLDHVOAvdZFOxaADsCKUG6E23h8hMQJiO541NA
 ARgRoGnxGGbOp79LUjssWcz6m1bNtBRA+EfjXvrnCUbat1/90OMfLjvz0lsFV1Rkc6tiH
 THQCX0otTWYv8Vc6DetskhhzY/F6VMVvknrPmg1GIZz4fzWXN2u2bGjOCPvkhwX1qKCF3
 xoPP8xXODnbqmQNv3SeVSzlPnGDY62yRJdNGGtbE+TKs+/HtsnqBn5XSGGuY7XTi29w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793136963;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
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
 bh=XBtNHD19F8q9qg94y6P9EKIrX2lVHe/nbhpO1b5EzzA=;
 b=EnIQZqStWS+wt8uN3h4pmi74w8kAQMXbDFYMnXu3Kom3hjq8NE8n1PnWpSaWERKjnw1m
 UlxKZfQ6XF2mLfVAnqLwAAvhq2zUbMMhByi717z7rNIdzRtNe4txx+IWVXn5duZwoQbgm
 FlHF2+CD5Jwjj/OCQ0wVWRQMaZq5FMKBesNdQhekAXvSuSkP1bH3UkKMwGGZQ0hc6ZqT5
 ufTalVyWN4vfVWbOwoivB/P6XvqWjzy5zVyNeuKHRsfGkLZiPiCCuxMlS6P2+aEM768qp
 83vLxzrFOH/dItUJc2Tt2xbsNCKniQIqsLyy4Sa+DiaoOPINAPKROU0JjM6Fcs4aaxw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RdlBwdgU; 
 arc=fail smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RdlBwdgU
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2DE7360677
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 21:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793136963; x=1824672963;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vY8prbnK/akgtDVnE/KuzwfNNnBqA/C03JK47Ctpfsw=;
 b=RdlBwdgURABC4UjV7UO36Pg1kDbCM+naWXc2dCJw/uuTBWQatE0+WHBc
 wgPTWmryNEZFtcdiirpR5ys3wzQ+vlAP9y9BYHByv0+RBTmpELZssXgEY
 IBQnq2v6IC4au3L+DJQTZdHHw4soFd9b+Bhiv+b2rOd7gMr59RlHX/MoM
 8La1TNeGdwjxllHkqf71W4/NqD3QCt1Ef0si5eEx634gulwP5ZpZ4RTB9
 eGEWkCLw/t7PB/SAxsDb4neNezZD4pW7WnYGO70+kHxtpA0kjEVYHPGZJ
 4F+lsnb2+5ScYHoE6RDCU684KmmJZ4PIRikFh6twwcPubar6Zckhhqq+n Q==;
X-CSE-ConnectionGUID: 1yWTLol7SVevPh45H1R6wg==
X-CSE-MsgGUID: BTGv9GRNS7Wb0I+W/U3xEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1850720"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1850720"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 14:36:01 -0700
X-CSE-ConnectionGUID: tF/AEm2RTxqyf5SP+kCHSA==
X-CSE-MsgGUID: 7y+rO3Q8RO2HDfEesx9ioQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4712370"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 14:36:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 14:36:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 14:36:00 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 14:36:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tiyu2JAJsBChiE+d3gdiU+NfSqckVA2aRHgtmnc/zOitMWtmXDI4h8HmR/VQbWl1XIVMLbgZhTGxQ4Zz1Ro/j0+X30Y6N5Clq6/qTdMCMZaWl/bQ3KCA15wGoVU7Fv4WjsPt0+CAJi1P8k/wWCXUdbBc6nzF6Rx6OoEOmQxIUe6VtFHDgrzSX8iIWxaHeMhDrxze1zrFOO84t1kz9RRvliytTOzo0VvsG14hWma4v1P709susY+MHR0zYufESCOv8ZWtz83/u+jDpY86+wNZ0JyK36Q1TprlhWxYgOTggQw2fXWv3UMpGrht/7GdGhMwvFkuFTphW6X7t6nSSofECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBtNHD19F8q9qg94y6P9EKIrX2lVHe/nbhpO1b5EzzA=;
 b=rcrnp2c4ouCWsMq0g8tDli6tQd2YlYhkzBdEkw23N8jp240y3lCP4fRPlFP8IkCXAJa28D5mehENUy5ZqTgzJ5QBnkkvSqtMPlLx3aoACoDkE5oYbgSi5ATTL4S0RRPYHZ/17uDF9GZLhfooMhz88ZEQq7zEfSzvqlbUibPlRh3uDRBZrGttld39XkcU7Zx668lspaMeztSTH7BJw96qL4/mWEevov8RE1wCaxFWJdoRStVsKxwS6HgpalS4aFILh0VqBxf8b9nd8VkJo8564egcro5WLyVwCt61oBO01xLi5Rl2XebHX3+78Nf908ZGdvUHpkHwiG6vMcmtFPBUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CH8PR11MB9458.namprd11.prod.outlook.com (2603:10b6:610:2bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:35:54 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:35:53 +0000
Message-ID: <f225d50e-fe71-4344-a88c-3c9e678a6211@intel.com>
Date: Tue, 27 Oct 2026 14:35:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ice: check the full PF reset polling limit
To: Aaron Ma <aaron.ma@canonical.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
 <brett.creeley@intel.com>, "moderated list:INTEL ETHERNET DRIVERS"
 <intel-wired-lan@lists.osuosl.org>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-2-aaron.ma@canonical.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20261019105155.3793063-2-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:303:6a::20) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CH8PR11MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b27550-8005-467a-0cad-08df3472470b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|261022075727099003|261021123027099003|261021135927099003|11063799006|4143699003|56012099006|261009223027099003|261022105027099003|261021121427099003|10067099003|22082099003|6133799003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 9tHdu//mm9DPgyomN6CNp3eTd5VRz/crnq9IG5LC/5jYePBofd+JwLTLz66cnSASKhTlGox2nAqAM/Tk8plG9zTcojdQncC/E1r9A1MJRKBRTiteTbyJKoC4m9pScQykNheelk0f74YFU5w/1xFRWS040tRr8wjOAWXjw8aHyzZrPcQEbAy1zK6Y+sEOnnLQ8lPc2+DcDIRHkuFh11C8sgMdWGIp6wB0rcngl1C1MB8UAPOtyMsBzywbQKNznhlatOuD+tjzOr6iRK5nwxJl5Hi02c3/rgrc7PRxUzK1FiDb5an8yGKJBC+nh5qLNzq7sr1Y2Zxk0/KlGt+tbnfBK15QhZ6GKbMvFbYyLX3rmQ8+KQwJtCd2c6oIOvLGaeXmkBiRKfFy6Tpt8p+6MmQ2eeFL9nWlGysvMdW+DgyvELtJW6RRCxuvYyBiiFHQdFV0kvAa+cvE8+K9p43o7DiIEKU7ig8PGDBf84dkOXWjx2zuafDWvdrWYwNAuvPnKlcOylcrhpd2/UQnCTGVZZ65NIDBcOGg4dfHTWqOjX3Tw8VrqZd09pOVvBl54PbwQ87KO+zxldYxcmeCrdCyecujlwpg7TpNd/miqvp8RiTbGgJNyGcLdV+/siYJq59or8CRPNeHftdUFy8Md3qldqNbcqmEE/gyLBuFPZ8O5K59xGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(261022075727099003)(261021123027099003)(261021135927099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(6133799003)(18002099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXg3VUR4YlcrVXhzblZRVUZYR0cvSFFseVpSc2ZTYjBTMEpYeEZHdmkveHlC?=
 =?utf-8?B?U2NLWVJpTjc2SE44bEJQT2hVTmxEUFVLYTVpNnZLeVU5MTFoZHlXVjJwUldM?=
 =?utf-8?B?ZEdCSlhIKzQyLzRIQmtqTVViVGZ5MGdpY1kzaG5XR2FIUWtGQU9PSXBjY0dO?=
 =?utf-8?B?M2pZbm9kd1RJUXlEcmtGb0pWa1pONVN1VW5FZkZ5MHVJUWhyeERLWDQvME9T?=
 =?utf-8?B?TXkvZ3pDMDRtR2V5NlVSZHg0NmJnUmZDOTlPQ0JEWG0vL3pad1pPUlNBRDls?=
 =?utf-8?B?RGg4aG9vblNtRTJCZXhNRGJQZ1pKVXRGbm8xWUlobXRzM21waVVRVldVR0R1?=
 =?utf-8?B?cWNxMy9aQThrM1RvbzltSlp1VjB2a2xKZ2RRUlB3YTJRb2hlMTRnbjN3Z2VS?=
 =?utf-8?B?MEJDMTdZbi9waHhRUy81eGlNMkF3UjhEWWoyK3RmZnRjUUFKK2k4SEpFenVm?=
 =?utf-8?B?RXBybU9icVA3UVNrN1IzUFJzYktzbWlWL0JFMEllSzlEcFlYNTQ5TUQ1N2lB?=
 =?utf-8?B?SWNVUHArU2creW5wUFRSekdwU2dDSXZDTUIzdTNsWDArUkw1V1Axd3JhTlJl?=
 =?utf-8?B?UHlwTkJlTEFUUzdubkRXanhrdGpLVTY5ZHNQN05EaUtFNlg3WXF4NzhxV1d1?=
 =?utf-8?B?d21JRDgweERPdWJtWmxTc3YrMTNUbk9EUkpLaTJxenVwRDdCL0xZa2N3UGpX?=
 =?utf-8?B?azFIUmE3MEdjRHJXeDg0MHg0N0kwOVJMTEo5TVZXbkoxV2thaDhNK1RMUURW?=
 =?utf-8?B?c1M1ZWhpSlgrSVlONFh5MUtKOE1sSjkxVW9FQ2lxdHFFbGFVVzdoTzB2OXBh?=
 =?utf-8?B?aGttQ3JDU3JnbUY5WUU3cFh1TWRGOXRsU0tVK01yem9MbTNwN1J3Z3lqQ0FX?=
 =?utf-8?B?SVNKcm1MR25hOVBQR0hJMFFzanlxcENsb2p6aXZOZUpLaEVSMWdFcUsxcXR0?=
 =?utf-8?B?ckt6Z0dsdEdVR3ViQ3dLWFBTUUdINHVFTEJxUS9LRnl4YlZMWUo4elVGTVB0?=
 =?utf-8?B?SEJ1WHNISkpZeTNodStiYnJsT2FtWStxdXJVZDlsaUR0RGk0T2tJYXJpd1JG?=
 =?utf-8?B?dDJEWU1GV0F3ZW55NXJxN1lCV0R2N2crd2tJb2ZGZVUxdHlyYWVtNVZaMlVv?=
 =?utf-8?B?SDcwY3RSa283T3VzaUl0NWNuSjRJeHdPVEsrQnAvaXQ1bDBTbTk3cXhVNGk4?=
 =?utf-8?B?aGNxSTVHSGpteUs2MEppamozMENWYVpSYllOUzZJTGF3UFhZZWw1aUcwYUZj?=
 =?utf-8?B?OUpjekg4bVJOaWVlMnlZeEMvMjdBL0Vhb01hTVdCZkVKZEw0c1MzVis3dmFV?=
 =?utf-8?B?OUxFSUs2Ym5NVFp3R2cycmROTlZFOU85djd5amNFWkJzSFNsYUVzTXhTRHdR?=
 =?utf-8?B?U0NqZ1hWTXNxbkFJdnVjUW1DZE5ENXMwL1ZKd2IrZFZOSVEyQ05kemh1LzYr?=
 =?utf-8?B?SEE0cDdPYTYzNXMxazhZbzNpdkl2clR2QnhKbVNzQ0RRU2J4YzhmelFtTVlD?=
 =?utf-8?B?dTdJeCtoMGdNRWZBV2FQSEhPOUlDc1RwN2lITDl3UVc5aTJKTlMvQjJZZnZ3?=
 =?utf-8?B?bGNtOUJOb21ScnlXOG55NlV6M3lpS0R3RDZCWGZxK3ZwN0gySlFEM082Zng4?=
 =?utf-8?B?YkZkU2dkNjBlNWlaL0Z5VUNGN0NVNXYyaGJIUVZIejg2cGFNNGs3cmRoUEI0?=
 =?utf-8?B?NEVxcVFCakxjb2Z3b01qbVZaK2oyTjJnZ1UxSVRzVG9UQ2d4a0JWcktmdXc3?=
 =?utf-8?B?ZiszN1hKdG5za0hYa081MUVGcmx1Q2pFSXRTVHA5ODRmT1lFTkNZSWhPRXJr?=
 =?utf-8?B?ZDl6b3U3NldqT1pJd1JHdlNuMlNBS0ZDN1IrQWdwV292elhWVzdlVktFVWRq?=
 =?utf-8?B?eFplZlNpQnptOWM3clhTYXkxWERXSzFSTUN0dXlQZnNhM3Zwd1MrOHJTREg5?=
 =?utf-8?B?K2V2ZTVIeC9OYXcvOG5yL3doVkxhMUdRblVST1NaMHVrSTJNTzd5OWdtdzRx?=
 =?utf-8?B?SWtQTDBJODVqaEQyK09JS1lXcWtZS1RSY0lORTYyUlhMc0tZcGNFZmdCL1Bi?=
 =?utf-8?B?V0puaXhrNlVuMjhFUHNOc1JidVRTNHEyZE43UGs2M0FiZVJiV05QeWhsQ01T?=
 =?utf-8?B?ektkMnpLU20yTStXcjR3OW0zQXRCZVI4T0pwMVFOdk1Ga1FacEJhaWFQRDBz?=
 =?utf-8?B?RGNLRnJVRWZ3S3ZmK1FxWnFreTlhYzA5bDdBRFVnMlBYdUphZWJOT2oycXM2?=
 =?utf-8?B?OTF4eXk0dUswOVJGSzNFaTNoY3J2V2ovOUVTRG9GWlBCVUxCQjZJVXBnWXIw?=
 =?utf-8?B?Rmc5TW5EdEJxcWxUS0xCbFdSNUxCR21mclBla1FmWGJaTjBaOElMSFZ2c0ND?=
 =?utf-8?Q?ewojF/qdq0Rwi6GI=3D?=
X-Exchange-RoutingPolicyChecked: dkMBM57RXYTrhzJneF0Vej0SQjbC3hLQXd+rBEVLinF99yIbRfrAH7DfRhQq5KlAXtVMvGtPKcdrCrtY/wlKX50Vud2Cg/YgQpUDes65BeVHZsxoJ4/+uN63WzgbJF9VkxDxNlFECArcdTiyRxY3a45BsyWnkoIIwIKDletaCUm0HcygpXLGc8elcZ3x1BE8nUpEUqdRSy0hOVwjaQmnbi2aFwUKrqxIjN/rWxmIEl7dL+wuLd02kS84wMFlHN5VXci5AOjuhnh7Ks7QdFejal0ZiTjG6hZkOttn4ROkXTKtDpHUJLGKTX4euXgrZamjoxJkc18eGmB+SbfsYKe0KA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b27550-8005-467a-0cad-08df3472470b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:35:53.4864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y7X8o6ynJqSgbq/0U3mf/KZmsglmc46daTFeMqmexKFI0UYNrChuFRrf3wif0yEyJt5HoBJWlsDhjRSTl7Uyc4zkXG90BxmdymtEcf40cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9458
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 3:51 AM, Aaron Ma wrote:
> The PF reset polling loop includes the Global Configuration Lock timeout
> in addition to the normal PF reset wait. Its timeout check still compares
> the iteration count against only the normal PF reset wait.
> 
> Consequently, exhausting the extended loop reports success while PFSWR
> is still set. A reset completing exactly at the old limit can instead
> report a false failure. Subsequent initialization must not proceed on
> the assumption that an unfinished reset succeeded.
> 
> Compare the count against the same bound used by the polling loop.
> 
> Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 04633103e3e61..82b803e74aac0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1291,7 +1291,7 @@ static int ice_pf_reset(struct ice_hw *hw)
>  		mdelay(1);
>  	}
>  
> -	if (cnt == ICE_PF_RESET_WAIT_COUNT) {
> +	if (cnt == ICE_GLOBAL_CFG_LOCK_TIMEOUT + ICE_PF_RESET_WAIT_COUNT) {
>  		ice_debug(hw, ICE_DBG_INIT, "PF reset polling failed to complete.\n");
>  		return -EIO;
>  	}

This conflicts with
https://lore.kernel.org/intel-wired-lan/20261002130752.2597259-9-poros@redhat.com/
which is part of the series
https://lore.kernel.org/intel-wired-lan/20261002130752.2597259-1-poros@redhat.com/

I think Petr's fix is more complete, checking for the actual reset
status is more reliable than *either* the old or this check.

I'm rejecting just this one patch from the series and won't apply it. If
you need to rebase please exlude that fix in v2 or later and we'll carry
the better fix from Petr as it goes through the net tree.

Thanks,
Jake
