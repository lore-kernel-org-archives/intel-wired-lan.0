Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9382606A31E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ePh3U6oy;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nj/Zm+Vj;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ZjV365lg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A75E84083B;
	Thu, 26 Nov 2026 05:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TG0udN60PGd7; Thu, 26 Nov 2026 05:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E3C63405BA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795670765;
	b=rWf2wukqgHxTkyfFvOSyjjUYZ2m6/J2CF2L+p3tMnMkcORwlExHDl5BfHKX3SliuumST
	 46cWqvFUA2kCaqYSdvltTcR8gJrlEjUfQSRcLxZiG0DoJsAY7+nYYX0HWIeJockN5vJLM
	 FqalWra7P3+EYQ+pGsyNVStoi3/JOBRs2WcUlL+wtzxuSXADSNje2gZuuaO0ec+Z0M/Em
	 X1UPEA6Ow9tdeZS3gyXbh1aMgSsPT5v1Ts3KW6LJELTlUKftWCvCwre6pbbGDxsD3VjIL
	 Xx7L+qIEbTjXJwgzuaPRShybppDCjU5teO2vy1yCxjQ6Gl/LfY25RaXGuZFzXavT0VA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795670765;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 From:Content-Language:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y182uWwJ2rYYo186gzH8r9f+ZC2Aln9Rk2ZDS/qMi4w=;
	b=HPhVkdFWPjrrSoXBXM7V2r1quScIwyuXeBkfZCXe3XVKEt9F8Wz7sWyq428fCN8AqY8K
	 IytBwnYyhXb1EJ1PghzOoWiWqgVlSTvOd184C+yoImVfl1IsfB/XFMU5mYmlthppP3fB4
	 93zJvNokb259EXyxSLhwyrsyD09mvnAEdINjGHcPHFJIDeSHMTws4lbI13ksWLkfH5RMS
	 lY81K/Muo5xbudwXODJ6EwoIu9OEuP63AOJUn9PMjIq+n+riWx/V2COYb3/PKCF6E7Rgr
	 ZjLMcR+Yb9m9KbHE/ZrXFvaJgL1gkT1JIqlqcCCq6uM/ER2XX6y5RllY9yAHvSZMwug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Nj/Zm+Vj";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ZjV365lg;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795670764;
	bh=y182uWwJ2rYYo186gzH8r9f+ZC2Aln9Rk2ZDS/qMi4w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ePh3U6oydt7Qp5yDm0DRXxAYHWO1mRKPq9/r+aZerTrV9w0+Z+L6wMbkKv0aQdFP3
	 EegSy2OfMSPVDrjT366v5Lhv3EcMixRR+7tkT5Rou962h9UrjWjdTreSTyNkfFi42t
	 kQOqK8j4EWU5rx18WI0HxE93s8A7nbvQS2J+8T76SBuCGpWIXplmih5xfFewSmRTeC
	 6Wc14v+S4UvYndvufiqEhyOGB+YvEYct6wwsud9UNGx/6WS2Y99mpov/4GmKJJQnou
	 MmsY9Y8bMGf2ugk7zyKNLftsv7+E648BTUcDdflObSA6FYtLbQ9Vw7X9x6KlwlewuQ
	 8WSv6/paW//RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3C63405BA;
	Thu, 26 Nov 2026 05:26:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A83E1C9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 05:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F4C1405BA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 05:26:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6wU7DJ7MZIZ7 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 05:26:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7ECFF405B7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Nj/Zm+Vj; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=ZjV365lg
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7ECFF405B7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 05:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795670762; x=1827206762;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GIBCuMt3auKz85XwGQNT573rHWY8/Wgo4ehvN2Or8xE=;
 b=Nj/Zm+Vj/4NNMXHcxTh50Jq8lvkJkMmJCcWf/rKeMuDE0/Z4ljLUyJhw
 FbLiGvTh36VW7ZDcwbVq5AZEKSgWCFJOZoMCn8Eb0hWHUYWmH+shOuA5u
 0HCxSPMxIdmFRR4ywHcfOFfG3H+1qTrEFkM0FYQ+dBhie5EzykHL5c+Ec
 Ajc83tbCwsy5UWjWQ4TCmAxynHBvxoHnV8i74hguH9PE9GponCuLpHtPh
 uCMwGHzPEJmZzteXEf667ON/83DLdpMbWd6FB8g2N7+a0bmYXwp0+q+t6
 /R4F87NM1ElVHrrgeVP6r7tBIpuW1Itc0ZbBHCWunD04bUTNalDMklsjs A==;
X-CSE-ConnectionGUID: zNkuVGjrSmSZfsHcn1iXcA==
X-CSE-MsgGUID: 1SR/DQFjR5C8c9q3KOCggg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4537447"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4537447"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 21:26:01 -0800
X-CSE-ConnectionGUID: XPE57wBHQcuQhGyP0amrNw==
X-CSE-MsgGUID: REDmECB3R5+L56b36Q+4Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12404501"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 21:26:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 21:26:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 21:26:00 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 21:26:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y182uWwJ2rYYo186gzH8r9f+ZC2Aln9Rk2ZDS/qMi4w=;
 b=ZjV365lg2dtplOW9HpqIVOfeG7WRDQLHh/CWlgzxwfJFO4k0Ux1JXNDAOYYvySE7bz8OXuR2MajwEoH3nPpFVp/B1nMTkOTRTYRFw+f4xMmoE18u4pRAfhTQzDIQKCXqZw/3N3AxA75EBbcd4RJQOxjyDzLh5yufno9t0bLFQRs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 05:25:53 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 05:25:53 +0000
Message-ID: <38ff7d07-08b2-4a26-9781-5cb58d794847@intel.com>
Date: Thu, 26 Nov 2026 06:25:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] idpf: report Rx overflow and length drops again
To: "Soheil Hassas Yeganeh (Anthropic)" <soheil.kdev@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>,
 <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
References: <20261126-b4-idpf-rx-drop-stats-v1-1-ac492e92faa7@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261126-b4-idpf-rx-drop-stats-v1-1-ac492e92faa7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0134.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::9) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|DS0PR11MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: cb01cdff-c2dd-4bc4-5848-08df4b7dbd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|261026121527099003|11063799006|261021121427099003|56012099006|261028144727099003|261026140227099003|261022105027099003|261009223027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: 3XkiuE6xlu4t8uX/eQLTcrRWYIy1OwERQdPMEAQC4RBFpuV/GJtx5iJkES+Z1VWApmG4uDVoOl5Cn1eCt4xg3tLJa1eCERqv0Zd7GJ9qecCAnYKIKRJs0ADUchJPyD4rr5CtZ0orBqC01JDtvHW2tKdGpoY8st8By2Cp47s3ojshBZs8cFsQOv5BqlniICwXT3MyzkVE1aq0ppYK4yELoEdQL7QcNv6pZKG+PGCe9CFq3rycO/82BBJrYADhPi87EKhVT4llCZuzaWMSD/0Ye5J2srrmv7rhW3+7HVxCmwM70uvAYKQs11skIGVsz/rY2ylNxlMQZoTlxU/UrBtTxuF/TtIARxDwkMX9dG6oSfGF/k5zgeLp8nGXw2YknPK7YQLIlCSxp9AH+wLUslP7C01LuYLA3awQllqLP6a5Yo+iQtlOwMrnnanxOKyV1qG85kDbWWXmU6ql+Bl/fGXkEnYC5KG7ay9FCqXD2xUaYy6X+hS/DO5VCbkoi8Um0UG9gpiVD75Z5lLkYkLkYtdToihFqBJcx8lvfEreEIU1ZsT7R/oc8VyUvMK8MivcSXcYzlRBfr6S+mYTUDpxNsd+2lGYLhhVrBr79gHslVSOIgfUPd5c61DGUeG6x0ZPzkVVqjbJkTaN46e+m7BUSH7HV/W43vcYRIrwb14Gt2u3B30=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(261026121527099003)(11063799006)(261021121427099003)(56012099006)(261028144727099003)(261026140227099003)(261022105027099003)(261009223027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzMxU0FoaS8zVDRJQ3dwMi9QZGdSMHRVQTZUNExUSmxPak1pWjFvSEdqMElh?=
 =?utf-8?B?VzEvcHdPNWhWeTRTWS96TW9IdEZHSzlQVHF4R2YwbVlKaittTTRicXVtZWUx?=
 =?utf-8?B?WG9WZ2Z1b2g0emY3alNueGZYQlhLOHZDcHdKYVpKL3FmUjlGOHhWRWFPN2FH?=
 =?utf-8?B?SURJMjBFSnpIOXk3THJMbU9laklNV3A1ODJqaTZaMCtFQlNreWhCVkVWeEg4?=
 =?utf-8?B?N0dPWndvTkdxaHFUZUU4T2tyWVd1NDFHaENrL1RDNGVqOHk0bWswU2RuMFlq?=
 =?utf-8?B?RXlza2NTY0tCcVVCaU5LV05qcEZYZnNoTC9Jcyt1UjVoWnUwOFZ5cWR5ZUhy?=
 =?utf-8?B?YytuVUJxdUdaSmtjSUNXa3Z0UnFrOFo4U2tjeHdMMXVIeVlwY3JBQ3JYOCtM?=
 =?utf-8?B?ZkZOREd2Y2ZwNm1WTWNCU2l5R3VNZmxGdGt6ODVxem5YTmVKMituS2ZKMDVG?=
 =?utf-8?B?Tnp3QlVFNzkxVjV0NXhkSXpoUmFvWkk2QXJUL3QzNUtBMkJRUHJuRVBWb1Y3?=
 =?utf-8?B?TUFJTUZVOVpNbWgvNGtmOXpvS1NvdWcva0xmamRvRzhzVTNTTlhnd2V1K0VW?=
 =?utf-8?B?RFdES3hFcjd4RndEN08wWFdRcnB4SzFBQWd3c3l0RWV0NmhuM0VDNHJUSUJi?=
 =?utf-8?B?Vm9QbFdDUEpPdFNlMWtTQ3hvZFFCQVlaME1nNm40dVA1MzFhdmVSamZuOWpG?=
 =?utf-8?B?TWtyOXlFN29SWXVFWksxNlJTN3FqMUlEZTJmMDhsQzJjOEZNaXVRbVBmc011?=
 =?utf-8?B?a1dwNWg0VlEzSTJiaW9STm9od2phNG8xRTBIZnBqdWhwd3d2STN6SmVjSW5U?=
 =?utf-8?B?YUNkaWNhbkNKeithUmJPRFU0WitzN1RDS1ozcHhxOFJVeUNtZWNqamVocXI1?=
 =?utf-8?B?ai83bHA3WVVzY0VOb2R0MnNQT1RjS2xpUm5reWFDTGVlejZPU29MdkZYMG5r?=
 =?utf-8?B?VjlWRnFuWGpjRERqMExpaVZ6VDNxNVZsd3U1VkRnNVUzWXBoMW9Jb3VFdHVk?=
 =?utf-8?B?R1FzbHNnUjduRGVxdmVvM2ZZTHVzcUVvMkFHVUpKNnY0VjVidUUwT0tNa1dH?=
 =?utf-8?B?ZDBKVGhXRVovcmVDOXBHRnBYQVNkODFKMTN6QTZpQnUwb20vTGY2dGdqVG9j?=
 =?utf-8?B?KzhPUmhtblovMWNVVW1wekZSZnNTNnA4T1ZGdlBzSDNKU0dIWDJ3Q0pMZlpv?=
 =?utf-8?B?dDZBQ2tmUzVIMTQ3UWVxQjF5R1lRdzI5VlpBUFZWQXl3bzY4S0ZKdmZycWlJ?=
 =?utf-8?B?NlQ4TUlZY1hSVGEwdUI3N1VJYUhmZStvS1UxU091Tk4wSE83ZTZpdWlVVFV5?=
 =?utf-8?B?NmZkc21RQTVwaHBMYjQ2SmhwVlNFR212UGQ2TkpxNzljVjJNTzV5MlBkZmwv?=
 =?utf-8?B?VkVOYjJZTDlZeXNWMnRQZi9jQkNqdXRRUHVYbWlIdGEvSmJBVzkyYjhBSDNL?=
 =?utf-8?B?d1NJeitseFZ1UE0rWnJPUWxCL25BS09nbDhSN1lPZ1p0MDg4QXdtNEN3Sm1w?=
 =?utf-8?B?NlcvRlVqbVBhaGZYMXRqTG9TR1NLWjlld3FnYUpuRm95ZllkZFUxNEtVOHAx?=
 =?utf-8?B?c2Z1NmRFUU82cXhEYjNrQWU1YlpvRXZwWHJrMHg3NTg0bVpCY3B6WlF4ZmxH?=
 =?utf-8?B?Tis1cFJ5cnBvYlpiV09WLzZvMXFwb3VabWRReUZhaWlkdlFTYmpHMGZTcFlN?=
 =?utf-8?B?ODhuNUdBYmFVWEtsdS9XeU5YWU1lTGpGV2hwV2RrTmJaN3J1aStYOHB6NVFp?=
 =?utf-8?B?TW5oYlUrMzlIWW5oYjY2Q1N4VElZKy96WjlVV3hKWHZjZWROWERuVHl0K2tW?=
 =?utf-8?B?SVZOeFVxQXU5bjFrZ3JEcVVHMTBmK3Z1RGJRN29EbGVkOU0yZFRQK21WVUxw?=
 =?utf-8?B?RUdzRFdmYlFJak5uMnNZSU1EaElJRnYvMk1LaW9WSm0yNXBmVTNxcWg0Snox?=
 =?utf-8?B?WUhTVG5rb1d0Mlcwczc1cHFpdzA5WEo0MTVZZUp3V0JRSW5KNEdMMHJ0SG03?=
 =?utf-8?B?TlgxR3c2N3I2SUk3VVhDdE1jN1NEUGhUNk9SZXhLUFRsL3lZWXp3VlJsMzk1?=
 =?utf-8?B?YytHdVlLeEFRSWxIMVg4ZDdBSFVwdEwwL3gzUkFidHZmZlZLalVvSkY1RXVP?=
 =?utf-8?B?Q21Lamh1NXhjMlBaYnZSRVdFU0ZUeWh1MzRka2NOQ0VIc2pxa0NLdlFSMXRW?=
 =?utf-8?B?UldreWRSTTY1UHczUDhDWjhoYytFVnZYRm96aXR6VlluTVEvZzE5SndnVkdy?=
 =?utf-8?B?SS92c0tDeSt2Y2UvYzdjTlFMV3QrbDBWTURUVTNsNVlaWG0xVU9INjdiK0Ro?=
 =?utf-8?B?b3BsSkxBd0phWlJhazVvTFk2NnZSQlM0YjJ0RUh2KzU5dFNob1lGOTVvWjUw?=
 =?utf-8?Q?5Kgz7hPhdQME5Ha0=3D?=
X-Exchange-RoutingPolicyChecked: MPGMAbxWxtZyhxQaCqNmXy4rZp5EjWN4uyxo8BeRMpWKbUJoGUOScORctS98SCGzi2zjqY78LKU7LHFiT+r/FeMTS6lxoNCDeDKbBO9c34b7eriyZv0lP0eAEncQeecpqJRUT00/taDFmUK+kpatRQukIvnvcd7gNLrBPBb5nZMDZavHrPen64cPd7qZdQdCqv96Bg8IvfUP+A/wCZveSQ/0zCB75BBdBEKyuYMTIm9u/Sl1Nvlj1SlF57iUkfnYZ5i+BWMfIFlk58kcKlMB90l2SKZ2FdL3FqWIekOtcrpchskqZ7HS+QQlKk58QjSbuBviFbqRviT8lNLOS9IltQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb01cdff-c2dd-4bc4-5848-08df4b7dbd70
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 05:25:53.2491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYThvSl9gkqJmOWeELseKTdL0TLJ2PgzPTnYeYJbe5fT8aoKkMcziVZPd8HzZfYEr8RMiUs91AkgPhTiibD9Nv1IWHPiYg4Vu/eswv61a1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
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

On 11/26/26 3:34 AM, Soheil Hassas Yeganeh (Anthropic) wrote:
> Commit 43b67308df98 ("idpf: refactor remaining virtchnl messages")
> started copying rx_errors from the VIRTCHNL2_OP_GET_STATS reply, but
> stopped copying rx_overflow_drop and rx_invalid_frame_length. Since
> v6.9, rx_over_errors and rx_length_errors are always 0.
> 
> Add them back. Leave rx_errors and rx_dropped as they are: virtchnl2.h
> does not say whether the device already includes these drops in them.
> 
> Tested in a QEMU guest whose kernel was modified to carry a test-only
> emulation of the device that sets both fields: the counters read 0
> without this patch and the set values with it. Not tested on hardware,
> and no selftests were run. A kprobe on one machine (x86_64, 6.18-based
> kernel) showed both fields of the reply at 0, so we have not observed
> a drop that went unreported.
> 
> Found by an LLM reading the stats code while we were debugging Rx loss
> on machines in real use.
> 
> Fixes: 43b67308df98 ("idpf: refactor remaining virtchnl messages")
> Signed-off-by: Soheil Hassas Yeganeh (Anthropic) <soheil.kdev@gmail.com>

This is indeed adhering to the spec, per comment above struct
rtnl_link_stats64. And you have correctly picked offending commit.
There is also almost no risk, as you only bring back two specialized
error counters, leaving the total rx err counter as is.

Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
> An LLM-based coding assistant found the missing assignments, wrote the
> fix and the changelog, and wrote and ran the QEMU test. Built with W=1,
> the driver's directory only: x86_64 allmodconfig and allyesconfig, and
> i386 allmodconfig. Not run on an idpf device, and no selftests were run.
> 
> This restores the v6.8 mapping. The same commit added rx_errors, so if
> dropping these two was intended, please say so and I will resend for
> iwl-next without the Fixes tag. If the device's overflow count means
> "out of Rx buffers", rx_missed_errors may fit it better.
> 
> Based on net/main.
> ---
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index c89783966bae..bdbfd3d4e545 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -2503,6 +2503,9 @@ int idpf_send_get_stats_msg(struct idpf_netdev_priv *np,
>   	netstats->tx_errors = le64_to_cpu(stats_recv->tx_errors);
>   	netstats->rx_dropped = le64_to_cpu(stats_recv->rx_discards);
>   	netstats->tx_dropped = le64_to_cpu(stats_recv->tx_discards);
> +	netstats->rx_length_errors =
> +		le64_to_cpu(stats_recv->rx_invalid_frame_length);
> +	netstats->rx_over_errors = le64_to_cpu(stats_recv->rx_overflow_drop);
>   
>   	port_stats->vport_stats = *stats_recv;
>   
> 
> ---
> base-commit: ef3e21c61baa74e39a49b75318bd4541562ec43f
> change-id: 20261126-b4-idpf-rx-drop-stats-7bb4eded6d49
> 

