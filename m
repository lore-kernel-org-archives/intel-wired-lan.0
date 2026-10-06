Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825A9CA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 20:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D39080EC2;
	Tue,  6 Oct 2026 20:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4uj_nOczs91p; Tue,  6 Oct 2026 20:05:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6C0CA80ED4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791317152;
	b=VsoWNqN8HqIwSERIhwFw0Vly1ZEDtCfSh2CXleTd/quFrNuEvyAuM7fiLEjQNi6GXwyw
	 dVhuExTFVEFyiewnEVjJkrYbzUC7PlT5KVe3CF3LxP4rWsyYiFZrmSiwEN6lMaTem8g3k
	 IK/HfMTdCk2nb15rWzOBCGXJt0T13NQtX7ADnK7oJMubHvKMDxmBSy+aB2nJF0B5iJggO
	 ZchVS2ZJJ4xfprMxAqNfuHDwLZ1UZYHvRXKAzLZ8vSheAZ0JxmlhYNZ2IVYCsBXUbyteC
	 3u/ZsrfRknadYAqtQkrnYd4OSFD3tui7XnmKJ+TnjBXidWm6r3I9Oyv+xErZnWpFTSQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791317152;
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
	bh=Nxi/jDE5V3I4LY5vZta7wrRM7tGIeZVCMsZJoVeNtdE=;
	b=SvgFOue/973imTh0ROg64AD1Jm9fMy5gTx5NqD7hdhHPk6eOg0gD0GI+ToKgJKMoACJh
	 Lhpzl98dpywXKwLlCWIpOQkFVJsP70NSRqlytIdszL1diycB/wbOu1O1kre9XlAH3L/Vf
	 iT+5+LFbQUbeIL6ADNs4S9xvWchEVfxgJwdV2rlPb5hKV6GIyEDBUk541TnvHOpEghD7H
	 7FFJqK5n4HF5f5zYb+UPOU4nVRNDNGMtiqrwlwe1et0g7288iTBoLSWUK76ZNqj/SdkUD
	 NXxi3fvTm5UV4YY8Crbk6tMUqlhpG+RQ8i6/zn/GADIwRFbYVDPQwDZ3EMsvbQahAEA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GHARSoT4;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791317152;
	bh=Nxi/jDE5V3I4LY5vZta7wrRM7tGIeZVCMsZJoVeNtdE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SjZ2+p5C+YR090CLNOOTC6nJe0Dym2AuIO/XvOiXIHBxrvONTyC5IcLD0KbAcb5Hx
	 7fJeGnOfic1aVFAKrMzXPGt5jDNWMiKBM2Ln2mG0RQmQHdCFOLZLjPDLod7SmWmZBt
	 0cZ0WG1QYRg1yZjxeYo+h5xIDx7tbPDkrGc71ovcba+nvpXvZECTtO9pwo7txZoPc0
	 2D01QYPh34P40snz4YfMDMHdMQAHh9O/puBQjNtXZC9m91z0+SY1VkjoGfIAMQxDWN
	 W/4cpx3sNIHnbaKdVx3TBZugfXElhDPapYMNICLtpZFQp0om8bSL84ofc5LlHUBJ2F
	 zScUi8D6PWYpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C0CA80ED4;
	Tue,  6 Oct 2026 20:05:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9526622B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 20:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 925EC80EA9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 20:04:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iIhrHcszJhAP for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 20:04:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7801180E97
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791317043;
 b=OFTIwQFk3EPvoTOkFzhZT4mPS0UyqJ+7SW4vPcbCpEpSjgMd4wLuJsKbsLLcWIVfaAIQ
 QpcLaNw7WbTmmKoi2i1Jqi4u3VxiX2mG1Zo1YC4EJoQJGak24UcYytWWoOMORg/0BEnHA
 fwGQhk5rZoRW1zZKXSMl2wUi9WwdkZKNphbPPmFt5pi2mV8Dczftvdf1GMMWUNr9jDbOA
 ylc6N5J5FogaKM4xgGKXx65YzLpsISrWsVE/1f0y7mV740szTCNXdcTzeG1dyJLKREl5j
 xtiU7Aosg8Ol9T5kJDwXV32rRBxss1HJcpwSr8tDTudbYT1RELwNwhmNMg1PVjxdSCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791317043;
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
 bh=Nxi/jDE5V3I4LY5vZta7wrRM7tGIeZVCMsZJoVeNtdE=;
 b=Mtj3dekolnxOZhKsNY2nJ2XiGy4iAQO6WVifEl5omdjRJuNavssk+DTcW8Hsq92+/tS0
 efcvw7DjOyQ7or9T7AViqlSFeQ2GyhBw5dOOXTqiLTzHUwwG+5irFVg/mNsGtWkKafEVu
 Wf/H4fK44VtnJdC452z00XJxYDhm21Ym7ZLPoI+OTTwZOCLLwUwAeJU9Wmz6wfrzFsu8j
 paNNy/GjYLP9rN3RZw3iFlWB5Edao/Rozp74dAXY049d2LDYHKoH+yopcFOOqb5d36b57
 16J9jXOgECgs9LUmpCeYe4HZGRjb/sdH0qMgWCrTmG8l/YqmpfPrKgXIU8+BQZ9ETkA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GHARSoT4; 
 arc=fail smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GHARSoT4
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7801180E97
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791317044; x=1822853044;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YRiCh4R1MYa6vFNT/z0bxFYXCk39bqYaChUlPbNk6s4=;
 b=GHARSoT4wXPVBFvFx1qJJIlhqziMRBp9KVkWF9SlOCk8beDCTMSYdQwL
 eDCgYxE7YoOjapYC5Vh6JI0WoaL2pBrSIzbhAhB7CW0wGJWte8TZEtoZ+
 H+CkLZtRji5266lfmoyuYQN8k29AbF8jInL1f0FK8tsXSLjVPWb5IVuuL
 pkCk/XR3qK8Qm9f18Y0yMezBNl089irUwq1qct3/1Y3d1kmjyjAFJPrhK
 jagFk3nDITae9imx1UEBMbbWoQNDNT5PbmlJurE8NRc1OrdlwUj0HbYip
 AMYwmCGqWpEiclW/jMJ+Qe7+d005P+gholG5ElAaTyVqJJ5KD3gMUnmvu g==;
X-CSE-ConnectionGUID: 9NJBC6JxTNa87d/LPj1NnA==
X-CSE-MsgGUID: Uwln8NNMQ5aw3Tbv0x/FFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="81343"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="81343"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 13:04:02 -0700
X-CSE-ConnectionGUID: Cdiyq34YRPGWbug7LIsSQg==
X-CSE-MsgGUID: K49BTGqeQ7mCDMWbBsoYuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="315271983"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 13:04:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 13:04:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 13:04:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 13:04:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKeINUdnCup4g+gfwDEMzAsBzKtdLoFtcA0wUgql77iWkPdNzJdQVST1GZqJYYd24ciXJ0x2rcGMdNZqOJKShpCoQ7gfRQozJjL7p7Qu/RebYBBrqOp0mSTDbq4nldxgQpDWk07XC3ifi7iWekro1WpHd0U7+KQsE8Ar1NfkwNyFyh+OMWBUU2LO4WARz3howqsRdFVQva7OUDtPrd8ur2pClXr87h1q+B7/wZ+6FhJgqseLQGQ1XJkHI9M/Gm3BaVDhEqCt/RmQu8vCXgFRMEsSQExc45yYALBDLfeObOErNBjS80IRM/ek0YYqJRm8IULmrvZ34t5X+8p85zYGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxi/jDE5V3I4LY5vZta7wrRM7tGIeZVCMsZJoVeNtdE=;
 b=yf1jLwfq64iFqbVVjKy+8upZIrbEn9/ewLorGmwVG9PNqi/sprrTG47kFCM2O9OTgAWCnmX8kiksbdm9vtT/zTD7y1PBKScip3dv9mkbpB0FQKx0tVc/Wdqe4x1z5m8/lhVXMvWHbf0A4EG9KKM9LD9bc1u6E4blQoAInBXa4QES60yA7lFuG/fYvIFWpqqgodkTbxzx8PHbCODyXuU9vAWvUxB2NaiiDV5sHRrG4XqTycuRETGZaI/OBt4lUuYyeIXyliA2hRMCjM38MR9XQlonTdj8c7TX6RCqnNFzzm/VwB1/CqaPk6hjs5pjZlYRjfIQa4F9ygnyi6u5nrcJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by IA0PR11MB7955.namprd11.prod.outlook.com
 (2603:10b6:208:3dd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 20:03:54 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 20:03:54 +0000
Message-ID: <f6a32b39-6319-4389-bb7b-986e840589bc@intel.com>
Date: Tue, 6 Oct 2026 13:03:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down
 vports on shutdown
To: Tian Xun Ng <luckilystar08@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <aleksander.lobakin@intel.com>, <aleksandr.loktionov@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, Tian Xun Ng
 <tianxun.ng@bytedance.com>, "decot@google.com" <decot@google.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
 <20260917105205.37561-2-luckilystar08@gmail.com>
 <45ffbd03-653c-46fc-b500-07e9b99f295f@intel.com>
 <20260921032827.32485-2-luckilystar08@gmail.com>
 <008a657f-f914-4191-b5c6-0fcc062bf73e@intel.com>
 <20261006105629.7481-1-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261006105629.7481-1-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|IA0PR11MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: d352b6ab-6db1-416a-bd9f-08df23e4f2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: hkjiYwZPYt+DM9CspMnpKNh0CclDefQEIdgF9TU0cI0btYYcNOEViH3S+7lTJC8ThfBkKsnNk+NEDE2CngJHcVpWqvQayiW4eXA0ooLjITGiaSyUpClWcBOmBzUfu12inAE5af6D2eBOfTXlMdswH9yfFNWXYPRJrym3ecRXXEa3hcUTE8BqFx7M6K27bhF4unbp38nS7iPDmTdqswmTIXdcYF2cXC0HirvvoU2mCH+4jKjfB5icjCAucC/8cBQLeHggmWLxWe0YaOfeDM7sGhLNY4Jx+GNHuj+mQH4aHCAJ7I+14Z6Yp27iag2mriV1Y6HW5Vj5s3APND9A8yx781HXr4DCvRxuz1TcFR4cIR9gyZJxahYF09d3rriILmif6vuMog1QAbiVhvvotGLD6WHDmCueoN/PPXdnthu0q9xvfwnuGepwpk+Gkw+Rqb53mCTr9xHeSX9AvqQj5KTqcASzr7cvxQS2wUuBqjarXv+9w0Ec7I18k5kXNFwk4scvsHTfkOSZu5W2SJscFdIk/2TQxmQOiSj8NiW6iOvkNSmojLI5GMo8TCxFE+8s5VOpaRSC6JAUJMeGykXVYs44Jm+ziSw0ltimBEX8TAVTg2m5QU+YBN/b/pqZfL8EolCZIbIyXdhYmxcR4GXkUPb7VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tlpsak9GSlFKKzBJUHFEeXpZV3lZVndPVE9LdEdoUDNkeURBSmNSNmg2OThG?=
 =?utf-8?B?SjRVQXNuYkwrMXVseldGbDNDTEViaEFNZmwwUDA0NTc1TEpLa0Rwa0VZZTc3?=
 =?utf-8?B?STJua0VMdzBzK1RGMEw1RzNuSTBybzJrMUY5RW0xandFWVczbXVPRWt6Vk03?=
 =?utf-8?B?Wk9CdWlmRjExRVlYNFZCeGRWcURVZmY2am1MU3M1MU1rWlRvMW9kbWN5R3Zi?=
 =?utf-8?B?djlJanNDMWY1UzFkQjlkajlZTjJkRFpLU0p6ZVkzNXJnd1hid2pmRXg0WEVP?=
 =?utf-8?B?QXFTb3RqVExBRndUWS9vZUNyNE9XYWdMQmhKaktPQlJrWGpzc2ZiRnIrQkdo?=
 =?utf-8?B?bXBMQ05FbHZuOUkyeloydFdRQjBvQWtFWG1uNFZQekNzMDlOWWNtNWdKQndn?=
 =?utf-8?B?dlVyUXJnVnZDcmVOVytRNlZDZVF1L0QxeXZMU2ZueE5uYS8rblBxM2FmL3Zs?=
 =?utf-8?B?QjgrZ3lLUmFwYTVmV3hpTmpkUTYzdHhSZFlaZ3lDZFlaL1YwQTJQNlJ3UGMx?=
 =?utf-8?B?RGRNQ3pTSnRuSHlJaW1jb092czZLaUZXS0x4aHhIZzdWTE41QTJXL2FDVHpS?=
 =?utf-8?B?UUR3T3h6KzlZSE9aR3QvL0FFK3VuS1dpVk5hRWtJaEhGYmZqR2F3aWlNNnJT?=
 =?utf-8?B?dU9QT3ZJSmwrVkxvMDNEcmR1WW43UUJWUDdDaFB1L29mZklaOE5zSUFBeXJ1?=
 =?utf-8?B?NnhFT2ZWVDc5Yk1vZHpwNUxsZFZjcjdDNzlxT2pURmlyZjdXMkViblhVWHJN?=
 =?utf-8?B?MThENHZQQThLL1NCWTVGY1dwQ3NQTmhOSjdWc1JNNVNzTmdMT0phWTErekI1?=
 =?utf-8?B?SUtmTVBFR2prclQ5UmpBU0lDaXJSWkJRcWZmd3JwdHFibng3Wk9DS0RvUExz?=
 =?utf-8?B?MEdtc0cyeXFyUytkWXdNQ1JEZHNRSWs2blJmQzV1Q1F5TGJ0ZnVZTkFHaks4?=
 =?utf-8?B?QWg1RytUaGMra0VSY0dScWdabzViQzV0OVNvQ1hsV1JrODZpdXNFMmZtdUxz?=
 =?utf-8?B?RFkxWmpLL0puMTY1N0paVHFTcEpmL0VtUnVvNmdIRkF5SGhYMjB0MFNGS2NY?=
 =?utf-8?B?ZW5lVnorTkxFVnozRDBGQnFYWHQ1MGxxUTN6bTEyZExJUk1lSlkyRzJmZXIx?=
 =?utf-8?B?UEdlaGUrZUxpMmlFaDlPckExQ2lDTzhJQ3YyNk14d0FiS0o5TDl4dzIzSWlC?=
 =?utf-8?B?MTVubFJhcDBaUzcwWjM5REdOVWd5TjlHOFVVeURpa2xWMTBEOWVZWUJvMlZw?=
 =?utf-8?B?OEMxUHNWYllBL28vLzR4UGJVN2Z6L0tvQlA2RzZrZ3VnNThZd2FCN3pHdlBi?=
 =?utf-8?B?ejRCeWJQalpMeUZ4UE80S21qWEZuRjI3Szk3U2k4UzBIN3VFS3dqeHFXV2Nt?=
 =?utf-8?B?cGJZMDdITGgvcTJxT0NRdFFVMXBDdzBXc3RDaGN0Qlk4UUVrQm5ldVVPSUdS?=
 =?utf-8?B?Ti85RjM3cXM2T2dpUm92VGN4RFowYUkrWVl6aU9QYzhDSXhnTkQ0UzNXY0tj?=
 =?utf-8?B?ekhOWWhHaTd6R2pYeE13OUlQVmlPRk1Ic05VUUtYdS9OOE9NS2RlSEVDTFZL?=
 =?utf-8?B?cWlkOVY5UHlhKy9oRE5tejVoOEpPODA4Z1krMVFKZ1E3Y2tLOTkxY2FDT1VG?=
 =?utf-8?B?UmJ0Z2RGbFlLU1FiK3pQa0t3a2VrOEpJSW9tSmpLSVFBWXVWT0JtbVBMTFZr?=
 =?utf-8?B?VklidUg1U3pHOWFDb3paek5CTmtDTERBc1ZoWTYyQlNaZHkvQ2RwUXVWSmhW?=
 =?utf-8?B?bkpXRENsakZjc3FITXdPN1ppUlNFK1VuY2FLZ01FZVBkdFNLd0dnM0k5WW8z?=
 =?utf-8?B?MDViNmM5U1p6am1qdm9DZmxQTUY0aHovRzZWdEVrMFdHS1VVVUlhUk9rRFpy?=
 =?utf-8?B?YUh0bnNjU2E2NzZubnZZK2tnK05WVEJNTmxGbUxmTEUrRHRKVFlGNmpOUXZU?=
 =?utf-8?B?eVduOTVMc3dydFhxdjB1aGttUmo0ZXJYRkRCdlhnYjkrZUlnRUwvaVJmcGNS?=
 =?utf-8?B?aXA5ZkFUdE9RTVE0T1J0ZzIzeUpleGR0dzdDcTMvZTFOZzR2RyszZnVKVEtD?=
 =?utf-8?B?OUg3bVkwU3VnalU0SXJQdTN2ajF3a282aGFrcytBNG03NlJVU3VBZDJwTm5x?=
 =?utf-8?B?SkxyNVo2Tit3UHNhcmNIbkNXRFVIWHZRS3Z0N3hrdUhmRlpaeTBMdmFYQU9R?=
 =?utf-8?B?QjU0MUs3em40VVpXeHdkYkxKeXEzaWpDaENoeGxaYmJlbVpTdjQ3cUlla0Yy?=
 =?utf-8?B?WCttRzR2Vk84WkJ6cFpVRTYxTEtkT2VwVVQ4NHFCbUdSdUFUMjVEZWJXYWNk?=
 =?utf-8?B?VlB0T0FFOUNLTVp2cGF0ZllKRC9TOENScG0zZVFWS1pOZ3ZkM2cyNUVwOTI2?=
 =?utf-8?Q?ydp94T7V+/N4LURc=3D?=
X-Exchange-RoutingPolicyChecked: dgZmpCcGMtAbx8tlkynBFe1WzoXz85kxABHTpT5pu76AVCabKPrd7PXHrLty+QWAm4exWUJv5kUKGIS7ly/mETUe+0EyfyATIlwHjuuX+cBAbHXpMFkR792sGdTl9WoVEJcFvtnBOunOXkKI/ugPDCqYuaVWfV9eHCFL/UgVWP6nVuj2re1R2JcP26JuZmdcMIcVvTO303Ai4CA/IYI0VRcOBEotxz0WP7bOLTg4MKsB3PUwQLaYZuL7xy2SB0vk75fZ6IMmm+OViTEVfhXsNozRID135oc6bRvTD29NdBE+SWG8Bbbnvnp9Zacqdo0fBFNUjWGyNALAQGTXwa/bjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d352b6ab-6db1-416a-bd9f-08df23e4f2d6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 20:03:54.4816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8fINZbk5HUohLtEXO92rqwqyWZ+tJMmc2ITpn3IHrCL4h6CWC7IoCLpCHlk1lHGPKzxlGbK7YwzsYCi+cP7N+0BTZJlF6qGVdfMDNWTHcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7955
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



On 10/6/2026 3:56 AM, Tian Xun Ng wrote:
> On 9/21/2026 2:06 PM, Tantilov, Emil S wrote:
>> In that case wouldn't just the reset on shutdown be sufficient? The FW
>> should clear the resources on reset, which should take care of the stale
>> vports.
> 
> Sorry for the slow reply; I wanted data before answering. On these
> devices it is not sufficient.

No worries, thanks for following up.

> 
> Same arm64 hosts with two idpf PFs, IOMMU translating so every stray
> write is blocked and logged as an F_TRANSLATION fault, warm reboot in a
> loop, counting boots with idpf faults (always ~19 s in, at the first
> queue reconfiguration):
> 
>    shutdown as in net-queue (mailbox shut first, no reset):    10 of 10
>    same + PF reset after idpf_vc_core_deinit():                 2 of 2
>    same + PF reset, then poll PFGEN_RSTAT for completion:       10 of 10
>    teardown messages delivered, no reset (IDPF_REMOVE_IN_PROG
>    set in idpf_shutdown(), the effect of this patch):           0 of 100

I think this change is warranted - setting IDPF_REMOVE_IN_PROG in 
idpf_shutdown(). We just need to figure out a way to bail early on 
unresponsive FW. For the moment I think it will be OK if we prioritize 
the working case and make sure a shutdown is handled properly.

> 
> In the third case the serial console shows the reset happening:
> PFR_STATE goes from 0x2 to 0x1 within the poll on both functions, and
> reading the register mid-reset raises a TLP error on the function, so
> the reset is not being lost to the reboot. The device still has the
> previous kernel's queues afterwards. The reset the next kernel does at
> probe (IDPF_HR_DRV_LOAD) does not clear them either; only the
> disable/destroy messages do.
> 
> Is a PF reset expected to drop the vport and queue configuration on
> your parts? If it is, this looks like a device firmware issue on our
> side and I will raise it with the vendor. Either way the driver cannot
> rely on it here.

In general yes, a reset is expected to provide a clean slate for the 
driver. This is why the driver issues a reset on load. Even if we make 
the shutdown logic flawless there is no guarantee that it will actually 
run. In some cases like a system hang, we'd still end up being reliant 
on the reset clearing the state.

> 
>> If there is some clean way to shortcut the MBX on shutdown then I guess
>> it would be acceptable, but I don't know what a "safe" timeout would be.
>> As you can see the timeouts are already quite long, so you could
>> potentially still bail out on a working CP that just so happens to be
>> busy on the replies.
>>
>> Also, consider the case where a reset on the PF will kill the MBX for
>> the VFs associated with it, so a shutdown on such a VF will always end
>> up timing out, since the VF reset is a message to the FW.
> 
> Understood. Given the above, some mailbox traffic on shutdown seems
> unavoidable if the stale queues are to go away. What I would propose for
> v2:
> 
>    - keep the vport teardown on shutdown, but give those transactions
>      a short shutdown-only timeout, and stop at the first timeout
>      instead of waiting on every remaining message, so a dead CP costs
>      one timeout rather than several minutes;
>    - skip it on a VF, where the PF/CP owns the VF's resources and the
>      mailbox may already be gone;
>    - drop idpf_is_reset_detected() as you suggested, and drop patch 2.
> 
> A busy CP that misses the short timeout leaves us where net-queue is
> today, which is no worse than now. Would that be acceptable?

Agreed, this seems like a decent approach.

Thanks,
Emil
> 
> Thanks,
> Tian Xun

