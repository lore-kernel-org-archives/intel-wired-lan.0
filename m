Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A485CA600D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 17:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0580760832;
	Thu,  8 Oct 2026 17:59:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o2-DDl75nh5K; Thu,  8 Oct 2026 17:59:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 426C460844
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791482368;
	b=YszqYUr99Cdbp8wwr4SAA3GY5sWtjGe6fC3oHfK/Lh8Wax8WFJnVKkp/xK3tzms1ana7
	 WGd95zmIhv2FnxVKg92jCV/hqNs8P1vznEV56rAk78SIXnpJ6+wH6sIXv1nI6IdXgaBS4
	 kzOBfoSAU4uatYJnbbINKR443iDA+szi8+V/bN6Z4YXIj2cmpNqtTh3GVHErenn1SlU+L
	 FQ+kSQP0ajxiqY/60yRASi09GnQVXckdRgcORnpyCPT+8P8B7xO1Fn+r7Ix3TDjwCJpcx
	 sNAFH4xARlJpzkROrSx10lb3Ob90OyWchilrBDSkqRlODxeX/bE9+U8nWv8YzBAKUHQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791482368;
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
	bh=5dxQI2+aiqHPucjs28HFlSbFXEPyvMUGZOtTExEXhlo=;
	b=UHFIgt5qFkrxCw94YFzpP1O+iCIiiEhpNoCWjXpRa0ZX2U3NvUjnSf/LYI2vhVIyIK+Q
	 xVGWgjKFILI9mhgUbXKkBPcHIYKSfXJ5FeTOV/tZVFYxB0f1gYIx2qZuJUw0GhIERwecp
	 IHW7tE9J7ma6Hda/lkq1Wrro/QN8AZ0ErSJ/XkBN+WbJREJamnYgbHtjiDWjvoA74J2SM
	 zdNyV+V1TDAfxPuwkIaWEFOV3m0Pz78e4qEEoZ4yegHCwdXrFikCZ1OEGmyqj7LeLjvvf
	 KV7SnN78dwUtY+ByF0ed9xWU/A6UmstTS56/MvTNHVYuJpd6Wballm69DjrXoiXchaw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791482368;
	bh=5dxQI2+aiqHPucjs28HFlSbFXEPyvMUGZOtTExEXhlo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rDl4JvooK9qugqwr1bUUiYcwJIFyYMBJSbtR6IiCCoMpZ3kP/JWG770sBF0TF0ajb
	 8aoXkIbUzGTu5Unxgv8apcOzekMhDThyHbh06P7lz2FnQLgUoGkFppOFpzZDK+H2Qk
	 EgLXTezMb9WNnmK3Jpm3DWWp2zk/sdUJdOTuqShXdA5Mwhpq40/osc0Tet24RrIh/W
	 /hhv+EjnYOgL17UvC36cnpQvdKd3YXg0bBd0gI6TJcu3zYJXQRd8SpWre0tg870O5A
	 Pm3LsQXSR90pMXUyJQ1JhBNzjGhsb19lkG3e69MEFjek20B8gzTM4v1ceoojN7MGgC
	 ZeYLjiOYc6aaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 426C460844;
	Thu,  8 Oct 2026 17:59:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BE8434E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 02489403B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:59:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 55bxFFs4g50O for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 17:59:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4C62C401A0
Authentication-Results: smtp2.osuosl.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791482366;
 b=L1Ggc2pYxDIjAk664c6eyra4GqbwfkT9zNfLvbEcqG0thJyT4fU68QDYUo8zNW3tSMJw
 CDi40rJPyuO3HwPlsoAXq/gBxg2yuF56pv6hrpdbTnz5/WwIS49F6zRNfwIk4eechSkKW
 sy5YB0PgRMncUbfeRTmPYMHoMKLGMoGX03rZCiExSSnIXclBTsg40ww/kc4hGN0F4Gq2T
 lZrybHKZeHadjlzl2reRNK0TacX4Szx/ffHmRB1L55okGAQBYf2yW7MzdhGtEYFAKOvQL
 rRPKmwO7S8duaKCpSHTxzta+05DdmBFj5I5w14LL0SQYqYqX3fJy1L/VQv1AhLc8bRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791482366;
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
 bh=5dxQI2+aiqHPucjs28HFlSbFXEPyvMUGZOtTExEXhlo=;
 b=NOsvohDn3gBGW3UeOwyD9ghZKd46hLhNSedLXj4rcIY8kL91U7JSulhYexi3FDEo5oLs
 +Yx0Zo3UBoKgIqRcvotz+hN3BjL+4eMaVeyPffNZrXUejP0SdqxzrsbadcXGkb5paMFpS
 hqbP82HpSyN/HALv7wiEhczinQy1F3qtgU/WZzOKE61SUan5jNCrrIIpxpEUBraPR2Iic
 +/vGJhXikVdNEGH/891kS3Or003UzWvC1Afctk152WTJvQ0opP05Nrh5/R8DP8Te0QzKm
 6dFCSYZsz308vdPg51JrF/oDK9Ze+mI9sdF+hZPfI2xZsnGUPxearEmoorI0ddki+lA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YyJPNsBN; 
 arc=fail smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YyJPNsBN
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C62C401A0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 17:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791482366; x=1823018366;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=L6orN6J9oSdgLBW0GDw6Cv89TlEqGmUD1FN7dxuYlJI=;
 b=YyJPNsBNMH1hUgbcCDc6AJPYK8kIAUFSlJusGGukclD/cznIYVjhIwG9
 FmR5/2fCb8K+aXeJmvS7H3QwJV0Ox57jcyvpilKi8wiyeJz1JPlaXfbAH
 hY/5+3pmHHKxZRY4y7mokU6ZwZOdYxiXMsLLxoKBaFnGMNpmnvnE3sUEW
 GKbXhBCJ0V5mKCGL/m4LjbBbjr0aauYD/hfpUVCjEl/wQVwnomJ7Htxwe
 3I7lGOW+9ojVuqfgbvW7KYDZAwjXofAuyU8w2/o9hAZXHnvgQpANoeGgd
 GVmq+cgUnDea7hNoXPOnYgzWWp+0ci69l5+DUrAfWZ6IE8Ustvm54CzmM Q==;
X-CSE-ConnectionGUID: Rq0xvGs9Q6OkasYvngsNPQ==
X-CSE-MsgGUID: TUhWIhY9T4qHkjlkzN3KPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="172667"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="172667"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 10:59:24 -0700
X-CSE-ConnectionGUID: SkM3dRgeTtuYPaeKCQgpRw==
X-CSE-MsgGUID: IP9lYO2BSOqwEEDaTKRn6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1865635"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 10:59:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:59:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 10:59:22 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:59:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1FYIzzwr+N8AFYrdzQrtIPeWntYrul/xwEaPGPeE4UD4sXIgj5LYfi133AN/dEDPveHxxuKJJulT8ZSoLk2J/tv9evcW1WCfjFbVa5e/gd1TPAinZYcbgnGKttJdLnqZG/yFKfHzfUQQ625RdF0RjnBRfqjUmAn/GxHgp6wJABfCCrh7XoP2qtyZ8gY9sGuhgA0zDQXo61Grj2Gbs9DjRWSwfvEkEgFDRjvMybq+exp4WBidtWazG2Eo4bgZXPQdJhFCglNr4VPDQ/jmQPF7rtt+2hnh8KtacmjECQe5GIBftmNldYR6u3wu19ObJGzn/9UgrJLOS64lJZ8ZB3Pfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dxQI2+aiqHPucjs28HFlSbFXEPyvMUGZOtTExEXhlo=;
 b=drk8cD1bEZwOmHWgP8WyMnXLK10Fu/93RBna9f0XYV16IupPizRtbSIsTeiuQsVIzzdbJ9zaaAyTKyUogluSrDe76IUb8k768AzpX8jF3lkRBZyuJA5JP49Gmt5VxcNv5OGFjpv2sX3oJzcuoKjbxJgrk7U60F2+3sO7EL8aK8QOzc5zyAshO81XXqgxW1GwOjV6OkD0zkD9IwdlXKFlDxilCzxAaq6GXk0+pFt3qhCoVIAQisHyZMvtuEBAyOAGUkx7b43wL/XUwKgd9fjrkidUz/vV658L9wf9KFYHB62pY5HW71bCGPgftnNHSW7iig7obMQlKNfNAVyc/PAgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by CHAPR11MB9653.namprd11.prod.outlook.com
 (2603:10b6:610:301::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 8 Oct
 2026 17:59:14 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 17:59:14 +0000
Message-ID: <666d51cb-e88a-4587-b17a-ae2a041844ef@intel.com>
Date: Thu, 8 Oct 2026 10:59:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-net PATCH] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
To: Brian Vazquez <brianvv@google.com>, Brian Vazquez
 <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>
CC: Madhu Chittim <madhu.chittim@intel.com>, Pavan Kumar Linga
 <pavan.kumar.linga@intel.com>, Joshua Hay <joshua.a.hay@intel.com>,
 Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, Li Li <boolli@google.com>
References: <20261008173334.2881475-1-brianvv@google.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261008173334.2881475-1-brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|CHAPR11MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cf2af7-3360-401a-7b34-08df2565dcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|7416014|1800799024|56012099006|11063799006|921020|18002099003|6133799003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: C07itlq3guF6hBTpX8x8fQcFcHuYS5/IbEHJ21ugqOxaXn7viuqovhyUz3DTQSdNISJgbmy1P5wPSxm1PAeogog/NvIy7eH79VNc2Hdc5TGWDgB0feyTRqpD3q4LNrs2UZ6qMqyDeeNIMWkQapoMYYRWNQQRDBRWSOzCjgUQWkLNoCZ/7iePYHBYrSDEo4z36efFRrG/ObYHZ3rPEVQywuKfse65EW60CcSGTfY69kz5LO96rrff5kdT/fvavJj+HeneMduIHiyQtOO35Swr/+7EwauNFkLRRKIeC2aVcMZT6L0L8rbN7D9lsgKhP/xER37OAcgtDpUhd6USrco6fOvo1PvxI/vZO/cI1+OcGUm3x3rBGTXiR1YzCDyh5tlwSP3NGhhgWolnZ4tlk2fbWuhZArzqBAx34h/ZCs752H263fFhFPi2ZxJAnxrrB+DRDXN6UZKcG4XQvuYp4L2il88NwUpftzWvi9SwbpS1ion2yfGPaUfEdwDqOOBQ5Kcl+1OqLKpXNiyiC+9wWlkLChagG+oi1gxLkc0j+Mg+DP1JkniBMwsgxTsZXFEMhO7rG8JOAbRmMYzMYb9LOdNcA+pg5aACx+9RWDfWgFcNyVNAgF07zRNMc/22nxC9OdJsTxd7xjPj4daLLzCKgPCdIo9lkyLyAw5AxkWQtXFzkB7aeYHIRdx+XljmVs2Yxs8BeOIrYW+2Pw60LiPQI3w5yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR11MB186312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(56012099006)(11063799006)(921020)(18002099003)(6133799003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0krdUd6SFZVODZCRmY1bUovWFVvaEhQNTR3QTdMbVNrZFdlKzlRYlBkZ3NO?=
 =?utf-8?B?Qzc3N2NkMGcrMDgxcVpodnRtRzFDUGVFaGxPcFJrMXFCUXd2bUpBQmR3L0I3?=
 =?utf-8?B?eUhITWNhY2JTR2JVVk84WkowRXdKSUFLOXRKOHllYTVYWTlZVGlyL09DYTJo?=
 =?utf-8?B?ckQvS25jZ0lXNWhqMzNwNTNzam5jK1R6MDNCcVpnckpIT2U3UGlaNlRYeDUx?=
 =?utf-8?B?TEE0cGQ1NEpMaWhwNHJuTXZXbXMyUEVYUERtdFBBdThIUnR6MUNjZk10bnkx?=
 =?utf-8?B?Nk5NRFJKRmVZbEZkc1VzTVRHT2JWOTEzckhSOWlYcitJSStiMEFjQWRYcW5I?=
 =?utf-8?B?RmFROHYvNUlSbUtOSGltZkdTY2hyUjBiM3ZBa0JFMTByRzVLdG9UdldoNm9X?=
 =?utf-8?B?WGRCWk9aTCtudEZoNnlDM3UzN0pmVWprcXRxaHhqSjN6QTZGdGJkSEFOWEt5?=
 =?utf-8?B?MnZuNCtmYmJlVThnV0tObXJKRlYzSjdiTHVRd2g4cHVZcUc1aGlxcmp3UHFB?=
 =?utf-8?B?VFI2SndBc1JkUFRIcHh1YWVTV1dpeFI2bmNucDlqbGlqWVRwdk8xT0ozQW9y?=
 =?utf-8?B?eWFlV0sveVlremFSOFBYWi8wNTJXc05TQjd6UU9UOUpRYUtpakxFNndJU0U2?=
 =?utf-8?B?N1pOc082OEwvRy9CZ3d3dXg5NkdtRzRZdnRFNXBtcFZpa1BCUEF2WmtvY3pU?=
 =?utf-8?B?TzU2N2FGVmwzOWlOOVh4ZTAzeXIvTmdjZkxXOXFTQVVTamRsRFRmSnJoQ3ZS?=
 =?utf-8?B?TDMzZVJZQ0dqZjJwU0VlZTRPZzlMSmx6dmI4R2FSaFZqTzdSYkhLL1Fmalhm?=
 =?utf-8?B?cFRaVGJicFJ0bHBQVEVJM1Y3NW1BakU2Y1RlWmpRT2dFOFU4TFAvdWVFODFk?=
 =?utf-8?B?UnhCbkdMQjg5cUV6cVdZa21YTFc2aE9WTFFPQnNXU3NkVlNZV2daN0hSMnBq?=
 =?utf-8?B?ZFp1YlNML25zVU9ZVGxYei9KRE9NSzZqYzdqVzNTcW5qWis5V01IZ3gyRjI5?=
 =?utf-8?B?M0tkSEg0VlJvVmJjVE9LV2pLZnFTNG5pV3I5VldaNVpoYXhieXJINGttVFRt?=
 =?utf-8?B?aGZyblRYN3h5UmxDakttak1aNXJlT0l6UG84ODc0Mk13Vlgvd2pObXdCRzl2?=
 =?utf-8?B?VWVqK2EwWnRUcTMzQWloekM5ZUFSNjhDOTFYdnAySzN2Z1ZlWDdVY084TWQ3?=
 =?utf-8?B?MHFRK0Y4WWlqRlJ6bzBNOXhibmdsM3FHSUNzdmpKZGNOU0V1TE9oL1NGNXVJ?=
 =?utf-8?B?SXdSN0dBaU1VYm1hU1hNaVp5ZEJXUmpOZzZwc01MSTl0SE1TREV5WkxBTU5r?=
 =?utf-8?B?RjFBVUp4OGUrS2lsZFpqRlR2ZnR4bTNTM2Iwam5HalJhS1RzSVJyYkZwaStm?=
 =?utf-8?B?bHJpcENsbjVrbzRXMXR6TjIySEh5bW1xQnF6Znlvb21tTTVpQ2x1bkZFUGdl?=
 =?utf-8?B?QzJxU1BLNytxVlBucHREWkNzOTJaMzNKcHhzN05qcWY3V3lyN2p3aGR6WTlz?=
 =?utf-8?B?N2p1WCtBRWdGbUVmb1ZxbDRiTXVWUE95NzdmY3IwdWgxTGZIZUlVWXladllL?=
 =?utf-8?B?Qjg3SjNkd1N1UFNMUlFCV1M1YzZpTURlTTludDNxVThEc1oxZHBVOHRrVFhF?=
 =?utf-8?B?RG11UmlxQ2ZZNit4OFhBRHBtc3puZjZkYWQzV1B1MWI3V2d0Qnl2ODlvcEhn?=
 =?utf-8?B?cTZibTlxUjczUWV4cnlpOU1CRmF6OWlrb2NDTzljN2lPRTlNNWZiYmpxVE1P?=
 =?utf-8?B?YjFuNGszZktpcHl0cFBXcithaE92emNZeHV3YWhldDdyUFNUK0hOVzJuZmpt?=
 =?utf-8?B?UGpoODhTd3Q2dkh5Rzg4czlpeWZYcXJkbHZnMWxDTHBNdFQwMlhOZmlMUUdp?=
 =?utf-8?B?UURhako1VGJpZmFJdzIwTnErUnR4bUtuSENKcEZUVk10MFpaWmdHS004RWI4?=
 =?utf-8?B?Q1dPdXJYdm9pNy9xWTFpaUNUTzIzWUgremZkaHVmMXpmTGpQR2psT092YmpE?=
 =?utf-8?B?Q0hFSGpSaDZvYnRabFZNN0Q2ZUNCTVdPTkluaDVxU2dob3JTTDNYbDU2SGo0?=
 =?utf-8?B?YmZqU3kzRmczZmFOUDBPREUyRXR1VlptdDVERnVJUEhBZk1Ud1pTTkNFQjZD?=
 =?utf-8?B?Z0NueXlsbzdyTDE2WGg0b2VIa2RnZ0FUZWlSTEVOQmNBUTlYeW0zUG9NMW1Q?=
 =?utf-8?B?RW5PY1FEbGkydTV1YTVIMVFGd3BBOU5VMlBYZ21VOVlickVrQ20rd3pmMzQ0?=
 =?utf-8?B?K0l0c1BiaWVBSEgzRXFqbDcxZENQRjBhL2xkWUtQbXVpUWk2Nm9PSjkzSXE0?=
 =?utf-8?B?aCtQNnJoNVdwTzJiZ1NORWlPSVNtZ2N3Y2lEZnJWazdLUU1tZlJVTmpkRERl?=
 =?utf-8?Q?QBg5RW12OEuoN8Go=3D?=
X-Exchange-RoutingPolicyChecked: OK6Q7fzKYNRuIf8mp4tCc/pXjJ+ZCC3x/tVoSreD3sS8lFaoCx31rkztqbP21Akxp+5D23HCNeO9kqbWvMHphNlLVael4B31hEp4NOvDYW6+D2I9pCI4go8dL9660e5CGkU3uUcks80vnfeFeUqgendetO9b88hU/PiXhjMUeURLtg3jwh4D38m23MJkNlfoYNIHM8YJlS+xqaFd7f+03wrffa9hTEYG/pBRZ6AemUJ7d9B8ak/GGs3xZV6IlAIv8Cl2kHpAIWP09fzBb5Kt8m/RMZ6dAGbeUiMDcW9HfgDw+OoHERhz9cFGvL41Eq/IQGRiwIPNJYTs2fF6zA4aow==
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cf2af7-3360-401a-7b34-08df2565dcf3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:59:14.0287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdoV9z67ON7VfRqMNZDq1r/eT23wRiO9Vs/0lWAP0HdXtIClEmAhPfx1Vug1Uu5EjK+d1L2b+7jJUpp2wO/h3OzvF5RTLygT/TlaRLskCQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9653
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



On 10/8/2026 10:33 AM, Brian Vazquez wrote:
> PFGEN_RSTAT[1:0] / VFGEN_RSTAT[1:0] (PFR_STATE / VFR_STATE) encode the
> function reset progress as a 2-bit state, not a flag:
> 
>    00b - reset in progress
>    01b - reset completed, written by the control plane
>    10b - function active, written by the control plane once the function
>          has completed VIRTCHNL2_OP_VERSION
>    11b - reserved
> 
> idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean, with
> rstat_m = GENMASK(1, 0), so any non-zero state is taken as "completed",
> although only 01b carries that meaning.
> 
> That only works if hardware moves the field to 00b as soon as the reset
> is triggered. On the devices tested it does not: PFSWR transitions
> PFR_STATE to 00b only when the field currently reads 01b. When the
> function is active (10b) the field keeps its value until the control
> plane finishes the reset and writes 01b, which takes a few hundred
> milliseconds.
> 
> Consequently, on a hard reset of an active function
> (IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
> driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
> reset is still being processed. The control plane tears the mailbox
> down underneath it, VERSION is never answered, and the driver sits in a
> 60 second virtchnl timeout (-ETIME) before going through a second hard
> reset which then succeeds.
> 
> Make idpf_check_reset_complete() wait for the state to be exactly 01b.
> This is the stricter reading of the register definition and it does not
> depend on how the field got to its current value: functions that are
> still in progress (00b) or active (10b) keep polling until the control
> plane reports completion.
> 
> Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf.h     | 2 ++
>   drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 470bc23c844c..ce8a1bd0ec8b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -166,6 +166,8 @@ struct idpf_netdev_priv {
>   	spinlock_t stats_lock;
>   };
>   
> +#define IDPF_RSTAT_COMPLETE		0x01
> +
>   /**
>    * struct idpf_reset_reg - Reset register offsets/masks
>    * @rstat: Reset status register
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 2c148377540c..a827e0fa67c8 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1870,7 +1870,8 @@ static int idpf_check_reset_complete(struct idpf_adapter *adapter,
>   		 * register for us yet and 0xFFFFFFFF is not a valid value for
>   		 * the register, so treat that as invalid.
>   		 */
> -		if (reg_val != 0xFFFFFFFF && (reg_val & reset_reg->rstat_m))
> +		if (reg_val != 0xFFFFFFFF &&
> +		    (reg_val & reset_reg->rstat_m) == IDPF_RSTAT_COMPLETE)
>   			return 0;
>   
>   		usleep_range(5000, 10000)

Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>

