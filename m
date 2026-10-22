Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C7606A327
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Oct 2026 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=iWP+Bw/c;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OnFQEsRC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2854360884;
	Thu, 22 Oct 2026 11:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mT18XUrIXDiz; Thu, 22 Oct 2026 11:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7FFFF60888
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792667504;
	b=QTzdrxW3pQgcf+FRw9GUlEyrsNiQR4K2VaaA7yJj+Polw1OcJ4qJyXM8E4HYoYKLkV6f
	 daAu0i1DZsGej2x+9j1/3/2sCdUaLtOS6WW/HmD2DPZkmi36KQ0uqVX7F3uP/qBcZv6rM
	 19nvJGkTdI7utbR1okfODwhvjvqocI0W6pUzHJt5GwCaDU+OHDBJuDpTkJclqMLcnof7m
	 IPvEotRQkZfxMNPgB+fxf5DsM0zrn8hzfHpxQ7fgJXQ+MJN3Dv3/K+XFKh4z97Y7/R9UL
	 0dJkiNQafnTKKCvOuTmFCmCdFckA/yqiMklpdewaEJIiDQMC88B4Sjl0FG40vnfWhMQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792667504;
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
	bh=Lv0h8wYpfemIWPmpERW5irYbfKpk3/lwz4m2Uk/RcBA=;
	b=KTt4j1o04hgse+EtHlnq2HP22dIVHlp/OM2nBpefLY0vFYaroKUeXnBFI3qml384EViZ
	 qosY5JBNjtFo9rf75yX+wqXO6Ky/7nNj/+evwq8ip3B12U/23HL+0QkGql83fErQprH/i
	 +rT1u+lMbFpdhVk+7xGcmT24o8ISjh3ozR1osR8n/QxjivYkKqYT9IFGcHHR6d+Vy037n
	 7L+0gYM1Yf6KMg8a5gJmtKVFxgq3xsr+LlLRDUkZ1bRek0MtMZYvW1wgEomrs04Jw8U8v
	 scAimTQIcPzKVrhC8G0Sjk9Pu8mJ1mj1eRy5hHMzHnsqp5WIh0frdjscZQIPzHyMAIA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792667504;
	bh=Lv0h8wYpfemIWPmpERW5irYbfKpk3/lwz4m2Uk/RcBA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iWP+Bw/cHKsY1XJs75KHBFpfGOc09UkgdMBVLfHzEQQzOsSNsVRcqmiWwCV3lsEGc
	 BcWjxo2cIlAEqhzj/2Z3cV2VKcn0IQhPrBbdfFOgM1BHxYdMBees7EypLhjkvgJ60e
	 0vsbdhdfNY4bdEjF2twnmAzq5N1BkLV7gioAbZw9CfMDup8DbyyYAj2ylBDqlnJdhV
	 jfSLV3R7nC13X4BZH1Zbhj7Gciiz5P84WbKcJEKzvWnEn8VPnxZaaT+RCY2p8OxPGb
	 nL7HgTQ6B2cpJCMKoYqZ4XyV1UO0L5Ky3i1PEcCRyjnlWRhgxQ6o3N7qcNz/5rrnFn
	 9o4fi2fBzvy6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FFFF60888;
	Thu, 22 Oct 2026 11:11:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DE2A3A4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 11:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22C664098A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 11:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BrbE3daKNVLp for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Oct 2026 11:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3485F407C4
Authentication-Results: smtp4.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792667501;
 b=HlEYvGIDf5dyHCKlDrxUYp0h6NlZuojxYFwxyNXtQNNogolUEs/iwAN1NDe1nLFY2T68
 kRO3cZ0+PP6yHOUxnWWusJDvuc+qnLzhCZnvjpHBrA6uZAwD7dRSgqwKwpCU2/1SH6AS0
 iI+3lsi9S/eBlWcpNDB06jlo6SZnA97Dct97BFO7QboTVLxvOX8fprofHfViFtdfyIVJm
 hc/lCwQouoavqGSoav5yl04/ra6xIONOBn1v9gNZYTvww5d8bDbJyPUC/LdgSkjLyns/T
 OJMqiam7EW8azL6ot3GCdA26spPnu+gO/dsWU1kkiQtvWKgc8CJbNNiINOCa2DZ/Iqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792667501;
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
 bh=Lv0h8wYpfemIWPmpERW5irYbfKpk3/lwz4m2Uk/RcBA=;
 b=oYHFO4CjA9yZDjq3YCpyZXtmkAS+NkYp6GFUks94BW+WNObVDp+Nt5XO0adEIm56gLY6
 04HwtIRs4plNS31kbpPGH3TV1wMCCooY+rJYbQ1vRTijhr89TMm5T4csPkP8N2zldZCBi
 zeheP9wWbCqBSFlH9/m6kYWS0WoBJLHxCWWFqc972S3TliugZApeKHJSQj17m7IlEq9l+
 L/kjT0jOX7I/+sAzTU4thYm7AqmE21GzQUgOocJb/v+X9j5NLreiX8tp2uBIPU+sDMgyt
 XbnlrYIumC9cwDUWNnwvHhZNORNOv0youwYFWCce3kKNkBJDfF5xC8eyrtkHj2MTRsQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OnFQEsRC; 
 arc=fail smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OnFQEsRC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3485F407C4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792667502; x=1824203502;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=E/wygCOESoMJTWvkQYXjuKt/1Wb0k3c+cCfgtOuyFBM=;
 b=OnFQEsRCInQvZRCbf0iucQ788XVVwUnX+P5NwN0Ac4eo81dhImZ0H5Ab
 YDnPV/OgiJenxMCrPJpRVdJg+9g4W8nY0ix5SiHCk9K4hEAPU2x1TP5Vo
 XYtwc1DJQDBrTP51ROIVvZUuwQc3WjWtrgi0gbXM1PAMjDkvje8sazA7p
 df64sHbqAle7KN4sxdTSxeVZ01Crs9jyRr191/K2RsgxSgh9Uo6EZSxdp
 BovUIa9DZKkuPpLR6HLXOgdo6Xuz5Hl3XYqfhOaQCD/Taf5XonW4efVp4
 yXAvqfzIWBru6d+/7rrC3oAfCZyr3fCARdBD5FNBiCAy0/sUsZBFqmLAk Q==;
X-CSE-ConnectionGUID: 8HAfK2PKTwOu8+26OJRgpA==
X-CSE-MsgGUID: tDS4rzYnRPiCKwhn7R3x1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1517030"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1517030"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 04:04:31 -0700
X-CSE-ConnectionGUID: 7qfOeZANTSmSWGOstxYRMA==
X-CSE-MsgGUID: R//FouXNSTyRRQf1R9G2WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3696588"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 04:04:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 04:04:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 04:04:29 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 04:04:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGaeNDZrJkXfF4VklyNdv451/8HNh0LUrtTvQi76zZP/tr24l3t8gOgRpaXxeYj/L4Cs+cVKbH0TC3ExmN1W1DwPpbXGvagRRDHViN1X0Y6vGBQ8Ei9MRhNPzacMnTf9I5V72TsI/96Lvf70y5ZHK7dokK+tCe+rwH/zySUF94JsM2YZZrE6CTxHAdj3AlF92VKKQvSfcE4Hrjhgab4uqlo7pYx1bkp/0DFBYIcz6AOq0egCF23ZNwEKxPj9gmWWhoWx4oyL/dZiBELoJzyc+pYeu8EYccNTp2lq5adeJ29/FwhHBLK8tP3IQvPi3tXgpEE4BXYUTlM0lKUbeQ/4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv0h8wYpfemIWPmpERW5irYbfKpk3/lwz4m2Uk/RcBA=;
 b=V6p4g5ljkc0iI6jSUgliCbOIDSxIq3hWSYrVSb2jPpqrasaxofIFlA0F7DkiRGlnZeXZjk70oTOKtEO4XNNK6LyoVXgo+itAerRtbqhA3cyihJhF7C2JWVXMh9k3fkawCM3J3EqXsXJUqFG4DjRDdVg8lqD2OHcdD2sFN5Oq1DJu3NYHQKaQHqMfhyE4/x2U9fd/rb6NUTIF8vZ1I1lF+BhcAH78eFTbFCG2K8mzyUr/W6dt4E9D4X1ZskbzAF2of6qUpneLGKExCoogao93pb/UUEZ67QiE/lutlauFMuz21TL/xmWMOCEeQbB09CKU8Kuxf97glGv2/CrhRyAvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by DS0PPF0A1E7F360.namprd11.prod.outlook.com (2603:10b6:f:fc02::504)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 11:04:22 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 11:04:22 +0000
Message-ID: <ac4fb583-4721-48ec-bea5-ee4e7380f606@intel.com>
Date: Thu, 22 Oct 2026 13:10:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ice: scope global configuration lock to the adapter
To: Aaron Ma <aaron.ma@canonical.com>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
 <brett.creeley@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-4-aaron.ma@canonical.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261019105155.3793063-4-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|DS0PPF0A1E7F360:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0c42a6-ff3a-430d-0133-08df302c3a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|18002099003|10067099003|261021121427099003|3023799007|261021135927099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZOwmIx5WYbh7WCQlQ9BtDmz48v5RmBXGV/0LRYa+5kK6wXpWEDo8JcmGVnB2vTOeGyPgzs6IPQb0w7NiwKU4MVWZaGByFZRJykSu7pszABGQMCxdIGjlKLF8Ulq0vkgg8O6QVNT+OIi7iFArHmxS8AatQ27GSKTGorjHRZ9R4fWAJ/LQHedyF3xUYJo+NW2U6LRrzW42Ss2p2TVNuU1HIeUSA1yZ2ylaF44DZCPmBdAkWtJEv59CmvtGfLDF+Yu6yw9NceGdOJvuk/rDwBVzP7KnsOfwhqyZ1fladZLiL7jrUg+X4+5p2qV9Z3t6w58faHpiQl5y16S3mgEo8UzG8yFfp7T641dh5fcNcGVOV6e3PpH2YX/RVoKuQxjYJ+T/b2tIfF01g8u7dP6FG+vCJhASj7DFYOqxUAJHt0zkW33rNHal4kp1m3lqRjh3u+QyhZUJry8k5qqkQKRhwGO9fKNljD5nbVY+MuMrt6e22NttgJXROk2W5cpDoCMU2K3S9SmLx6K2G0CZO9XDh7NZLunYg+gDCJgTrZuJcQy7GzG57DKuoMgr+fvPny14cIxyoV0vfYZF4pfPEY09vru+V/Zby1Xzk+nHxmnB2gl20pmbUFlswtauDztTePjL9BJ97uXd9sWDSrF9BGK5x5oSy5WCbTwIK3RCdeG07ztjlrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(3023799007)(261021135927099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJ4aEY2QUdaUS84a2tQcU5GSVMrMzNSd2hKTlFtTjR3Q1dKYU94bFJ5K2E3?=
 =?utf-8?B?R3QxR3FqaFAzRXUrcndXUlVCYjVGaG1oU1RBUWk0SFhRQnZZK2VPSzNMVlcv?=
 =?utf-8?B?WmRhY202dWM1ckU3QVJyMHJEMWdMT21EWmdrL25oRDZTbHJhYXBUb0NGcU1l?=
 =?utf-8?B?MjczSjBVUC9MZ3BzeVBxTVBWbDVBenk5YzBFdjFNUFhaL285WnJCektPMWNZ?=
 =?utf-8?B?eC9PYkRSVHJTVGw3R2Z3QXBFTUZLWThsU3ZMbm8xMnJGdFFFd3RGTE9Wc1Fx?=
 =?utf-8?B?cUdIc241a20yM081VXhWMlR3K2pJbDB1Tmx6N2p4SUs4a0JoQktsWmFBcmJQ?=
 =?utf-8?B?WVlmeW5WaENxNE9lWEs0R3MzRVpITk9YYXBMME5ZS1dTQk1XbUkzeXNldjhu?=
 =?utf-8?B?Rk11UzJSUEt2ZHRhaVhSWFVudGdhQzFVbE5MVmRrNk5ZQTlGRDZtZ1FCUG5x?=
 =?utf-8?B?N0U1cVZmT3lwdmRma0hzSmo5R2t2MHpPc2c2SjFFM0lKTVpTdHQ5dXBTVUNw?=
 =?utf-8?B?eUEyZFc1QzBrbWtGamUzZGFEK3JGZjNqVWZMMHlGSjQ4TWU1c1BmWjF1Tlg2?=
 =?utf-8?B?VXgybkl2VUd1RWhMVUVwWXpicUtaMzc2TEl0QXNtRzZSWHpjN3hOMVdiN1Rv?=
 =?utf-8?B?WUJNY2xKL2IrVGV1UnF3b2R4Nlo1T1NMZXREdngzRGhOZ3l2elNWNHlqNmZ1?=
 =?utf-8?B?aUNNZkZsSE8zS1d0bW93UkhhKzYzY3ljUCsyNElFOWlMWm1MM0psY2twS2hw?=
 =?utf-8?B?K2RBVmlFTXdXTkJhQWtvdml1b3BMcDBmbHNHdVJDSk9WR29xNVF4Mk13YVBt?=
 =?utf-8?B?eFZGTnNWclJEa2RMcW85OEpVeERCMzNvK2F0dDNsanNKa3UvcG5VRjlTYlVl?=
 =?utf-8?B?WU5SS0RnL1dhVHAwZTRjT1RQbUR2ajhJbUd2dUdzZ0U3RTNBYU1rd1VPMjFn?=
 =?utf-8?B?RWF0amlnWTdINXVDQVd6ODhxMEh4ZCt0dXBqQk1yaXM3czkrVWRHTDJIOFFO?=
 =?utf-8?B?cWROL01ZVzlQbFowN1JkMm5lY2ZSMUJOMm1IM1JhS1RCTkxVYitrdnVMNlVs?=
 =?utf-8?B?UThDbC9Lb1pVVTlOMk9teVczQzJQU0pxL0J0cFlXZCs3ZERRRnAzeURxSUFX?=
 =?utf-8?B?dkhFamdPZHVWTzgyQ2txWUI0MGh0Z3Z6K0xtUzN6cmdQYzdJazAyVnBDTUYx?=
 =?utf-8?B?M3BRRGRoKzhlRnBZZTZhOTIxUFQ4Z0NMbXBsRW5sa2grMFNlM2daQ3E3R0w3?=
 =?utf-8?B?c25WdmJKSlorYmE3aFYzTlh2b3lSZTdOVlFWZUdra0Q2anBzOXl0a3FMRjA4?=
 =?utf-8?B?MnRrUEdLSmw2d25FNVpScUxhTGVPSTNPbUp2ekpURjN2N2VJSUtUTTV6YUZj?=
 =?utf-8?B?c2o0MUh0QmJmemZjN1E3M0lVMVYvdisxdG0vaE5BbHh6V1FVZytXZmFZcHpt?=
 =?utf-8?B?eFhiK3NXWkRRVmNwUVlRZEE1SFhDMG1TZ1NiUXBJTnZvNmtvWnJBNFZncGhD?=
 =?utf-8?B?UG5HV28vajlQcnI2eStZdHhCTnlPbXNsZURpSi9kbndnc2VVOVdRVDNCUkl4?=
 =?utf-8?B?bEhLK3hNS2w0RXgrTk9SemROQXhSdTdOc2M4TE9rQkEvVHprU1NKNk5IbXZx?=
 =?utf-8?B?d09DWE0rOWNEYy9xMlJ1LzlFK3lNT0ExSXlJaXBOaktQWEc4MElSVEVJOTJI?=
 =?utf-8?B?cHBWY3p5dzRwT0wxeURqTk1PMUgvZ1BhWUtHL1kyek9iZkU3UWpXWHgveVBR?=
 =?utf-8?B?akZlbHp1TmFGdHZxakgwQklSRnFma3FaOEt0QVI3TkVMbzBhNi9OYzQyM0di?=
 =?utf-8?B?ckIrdVVldnkxdldFbjNlQndWTGtScWdSb3lPQjZaTUMyWHBCUWg3VDhMM1ow?=
 =?utf-8?B?RExmUmg0b3BaQWVidVpjSTZjV0RWc1dhbzZDMlluSTN6c251Ujl5SndWYzlB?=
 =?utf-8?B?SktYQ3c5OHU0MVJQQ0VaZHB4TU9YTkZlRTQrNXVnOVRSYm9lZzZMdkEzTmlo?=
 =?utf-8?B?eFlnUTV0dWUxNER0R096Z0xhVEpzeWRyWitBM0tpTk9HTFRuZWgzekFOVnBB?=
 =?utf-8?B?L2tQcTN6MnhBa09Xd09PelgxUzNpRVQ1T05EVjB1NU5RVjg1c0R2bGgyWlAz?=
 =?utf-8?B?bkhuV2MwVzl5bG1ySXNZZkh2L1VYOFUzcEJMMGhIZ09jZWhLc01CWEhhMUZQ?=
 =?utf-8?B?MWtXUnFDZThIS1JINHFzYkljeHhFLzVkOVZmRnkyWWppV3VHNEgvUWxmbE1p?=
 =?utf-8?B?dzlVMEpMWWd0R2tSbCs2Ym1CWW5VanZ1M1RMWTAvbFIrSzhJTGxyMWdNT2sz?=
 =?utf-8?B?Q1YrVnVFREhmTDQxWEFSdWNOM2U0aTl4ZjZ6bHRCUGxrMFZYQVI1SmxTUGpB?=
 =?utf-8?Q?n51ysKvud4HPaQ9Y=3D?=
X-Exchange-RoutingPolicyChecked: E7vd+QQYhqJVlwZOgGNU/hxp30MP7FvACh0pHLBddu40nnm5T4y1qWDzHTAeCoazmTz8KRAsgXrbhRG3PnLsZdrkxny11EDmLXyiH319cWx66wA052uCTcBV8GA4Be00BSC4BBoTL3Yy0cKqygseyDdCyj282X0hifcRSBRBWTcXFvSDDqvspX7hXw4GMWP/WwcCiemu5rn8YhbyhJB5Ht1m4lbvzZjv2Y9UU1Eg5N+mnvi+us1l9Jh2icJsd+i8GI0C0aEpXz+S8rro6TmFDuYk73QOyX0SxLpXJobzgOpWut1+xSVkQsISse5GKbzTjs4GAA9cx2kGdVCDbWbXkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0c42a6-ff3a-430d-0133-08df302c3a2b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:04:22.6026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQQ/Ro2DPY57GSABgz+FkQzM8VA0Z25t7VBvClt2ThDgTM0TzRS+byDF001mrcOUmGDRN05DZIPH6+HM5Q1IlJlQiW4WOoLGRePEpYNua38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PPF0A1E7F360
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 12:51 PM, Aaron Ma wrote:
> ice_global_cfg_lock_sw is a module-global mutex, so a package download
> on one E810 adapter blocks Admin Queue commands on unrelated adapters in
> the same system. In addition, the mutex is acquired only after firmware
> grants the Global Configuration Lock and dropped before firmware
> releases it, while the opcode exemption list in ice_aq_send_cmd() does
> not check whether the caller is the lock owner. Non-owning PFs on the
> same adapter can therefore submit exempted Admin Queue commands or
> sideband requests while another PF holds firmware ownership.

This is not a bug to allow exempted commands, does not matter from which
PF.

> 
> Move the software mutex to struct ice_adapter and record the owning task
> across the entire Global Configuration Lock acquisition and release
> sequence, including the core reset path in ice_cfg_tx_topo(). In

this is fine,
would be better to not track mutex holder

> ice_aq_send_cmd(), require non-owning tasks to wait on the adapter mutex
> while allowing the owning task to issue the permitted configuration
> commands. 


> Route the Admin Queue fallback in ice_sbq_send_cmd() through
> ice_aq_send_cmd() as well.

perhaps this should be separate commit?

> 
> This patch depends on the previous patch in this series.
> 
> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>


> @@ -1895,17 +1894,24 @@ ice_aq_send_cmd(struct ice_hw *hw, struct libie_aq_desc *desc, void *buf,
>   		u16 buf_size, struct ice_sq_cd *cd)
>   {
>   	struct libie_aqc_req_res *cmd = libie_aq_raw(desc);
> -	bool lock_acquired = false;
> -	int status;
> +	struct ice_pf *pf = hw->back;
> +	struct ice_adapter *adapter = pf->adapter;

RCT violation

> +
> +	if (READ_ONCE(adapter->global_cfg_owner) != current) {
> +		guard(mutex)(&adapter->global_cfg_lock);

no guard()()
especially here scoped_guard() fits nicely

> +		return ice_sq_send_cmd_retry(hw, &hw->adminq, desc, buf,
> +					     buf_size, cd);
> +	}

