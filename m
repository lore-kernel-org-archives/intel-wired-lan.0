Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033B6606A32E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fkUqhF/p;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=guRJCv+5;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=P/LdaD2Y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD2EA80DE5;
	Wed, 25 Nov 2026 21:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1uK2zHDO5Wa; Wed, 25 Nov 2026 21:16:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3791480CE9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795641408;
	b=r28JPqDyglL9uLKHnVCEmXyrdZbl4xCFyyw8I5lShg9ecqLnqPO/8NgWEMIfh5XoJSS6
	 RYq0iDIWFhsEl+j65wJLdZ6vnTTVQi9XnNvnXdD5ietwjQOn3tt7Gq6Y5ORUSIxY2kN80
	 zBmeLrOPCEaSKhSS684qe+qmvGEBb+VPUu9Y7sa8fUmmZ2pFK/z3SGFlM+yYeVau/4DCB
	 JH7Akl50daQAFyPRxeZh0XCBh2qbKLJY3EbGdvQT0ltgUpM1Eks0SzdBCc0PB09V6g7jt
	 RPzVQfeu5tHBl7j4Du+ts7rWaQsK04IoYp55y2yz5nYfjZ6UQW5ARxJwjtDzOqIWNAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795641408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=ycV+5ea2zBzuJNOLw1HICBe+fopJ2tGflDhRi13ZxPo=;
	b=BdgdgWYE0MD+mqGV3uIMiSctwhImtvBlavzuSAlQ4DgCGPKxefTm7+K/PDMlQr938rNc
	 S5Bs8g+7vYZKp+RFkfk2pYVGvzA/NF1OZILFmPTfZhDbIIVYeLkwkPJtCs7WbJwt4Xk9l
	 /HNisymvr+8A2/gmNedBFWSPV68I5aoZfhwqiVMtYPdfI0WlWc3tOjETaZUd9d+bWAKeP
	 uUCOZLPEuLoYjREPeLd4C8RzazBLgXgBbmz2OiF4MURMeQkimqAWHCQ7VjZv+Qp9fNtTj
	 bZi64CVd1gNuK/PTIWUzuhmcHzifkYqzREoWn+uiaj41ldFJq2wwmUIMloMiRwxzl0Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=guRJCv+5;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="P/LdaD2Y";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795641408;
	bh=ycV+5ea2zBzuJNOLw1HICBe+fopJ2tGflDhRi13ZxPo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fkUqhF/pkvp8dRiCJw/ggHmfMd+rypLzsLIpBobyQ17SEX4RPz5PM9AniD3+RCtUE
	 Xg7QYcWH3HP6d0j+Bw/e8imAdkcgnaXBVxECI/QeOpkU5UdeLzLwz1ZtzW4q8MVcMi
	 CxIRKckz9N4AeWm6nP1nFQ8BJHsa/eWEAC6WpwlMiakSV2SLEw0mBNNr6fznJYKbEK
	 4WjMohc37Nu9+sIjyHAJVX5jpXiTroDZxCMSWLGnMiHZnjeME4G5XZ3N4kZZ5ig9iJ
	 /ZayKclx7pLB5DBWmU6LzQGs72nymFfLMMaF/5LoQjEDT6HEHAuMX0Nc3Dp2v+S292
	 32wNWoaGLBeFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3791480CE9;
	Wed, 25 Nov 2026 21:16:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AEBFF22B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 21:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 94AFB80C0F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 21:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XsaYdYpuygvS for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 21:16:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 98DDD80CE9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=anthony.l.nguyen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=guRJCv+5; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=P/LdaD2Y
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98DDD80CE9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 21:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795641405; x=1827177405;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7FvcqB9kOZF/upMMc6004Uxnzq+h4HwxEkTfdjUlreA=;
 b=guRJCv+5ambOIpov7LsPDAKfgihuLIqkNVCTUo8KtnPMIrOPnpPku0QW
 K9uuSzsidLwcfeN3WqqeJ7vzZ7c4C/Qto+zLHpYWlq0532tLB/l2FGmUe
 8liw+7jraswT1PDOW8N6yGuX3xIB2Fch2Qs/eQXRD4/W9W5sxeCniVoeI
 gK7itfS4ZtLSTpbihYWtwMR2ACOSV+4HKhPXdVM/hmTFGTW4u0qJBstUZ
 UaN7ZIEsC5hrJoZ1hu+4uup4X9nFkVT9afN4rNFn6X2AlId4o4w/RuN/E
 F2M1OPIS84riISUmCyyBDt14F2V07tl5EPOE1Yxt7BAYy91zA15fOv7mE w==;
X-CSE-ConnectionGUID: zc5zURlvT8S2mxgodN4Qag==
X-CSE-MsgGUID: jsvUbMh5SDWzmEv3SHiMhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4441163"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4441163"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 13:16:43 -0800
X-CSE-ConnectionGUID: Gn/LGuTAQkisOJi4t3XDsA==
X-CSE-MsgGUID: ftDFj9ANTwyQMaEhZq3e+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12561821"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 13:16:43 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 13:16:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 13:16:42 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 13:16:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycV+5ea2zBzuJNOLw1HICBe+fopJ2tGflDhRi13ZxPo=;
 b=P/LdaD2YjwQwR18LSGxEjiua5Cqq/R/IyecLsRU+oQLa01eYP2U9JYiaRThoXxD2QbKhdJNPwTm0LG1qGqwK+NDLibdoL2rR/L8XF7I4zYg8Mb4ox5lCxNBC4+bPd9VeN38hwNHvnf8JPpul4FfeLTwBfydTD7qp5MVw2Vc0GNw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7710.namprd11.prod.outlook.com (2603:10b6:510:298::9)
 by LV1PR11MB8844.namprd11.prod.outlook.com (2603:10b6:408:2b4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 21:16:03 +0000
Received: from PH0PR11MB7710.namprd11.prod.outlook.com
 ([fe80::dc6:ac78:d884:137b]) by PH0PR11MB7710.namprd11.prod.outlook.com
 ([fe80::dc6:ac78:d884:137b%3]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 21:16:03 +0000
Message-ID: <81c519b6-2d94-424e-8cfe-22ed8c1d728b@intel.com>
Date: Wed, 25 Nov 2026 13:16:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-13 (ice)
To: Petr Oros <poros@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@gmail.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <edumazet@kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <horms@kernel.org>, Marcin Szycik <marcin.szycik@linux.intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
 <20261118115915.116177-1-poros@redhat.com>
 <20261125124652.3843638-1-poros@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20261125124652.3843638-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:303:b9::20) To PH0PR11MB7710.namprd11.prod.outlook.com
 (2603:10b6:510:298::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7710:EE_|LV1PR11MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9529a1-9a27-449a-7329-08df4b394fb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|11063799006|56012099006|4143699003|261028144727099003|261022105027099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5xhgiQ39GQWjsGeXbu0rvdHGocCx6ScuSqvTnwzt5lwj3ICd2HK7yfVeZ4SGhKxUopCfGCGgd4kCCEq06kycAsDjzMeBPzm+HK+RzY6HnAkpzyjNxYo/2T4GhuJKe9EpV+kzuImAs4vBvySR9NEigXmXDae/Y1N1nfREufoZkAYJ5Gpbf9lgQ5xnqNgzMqydpsreKBWuJntEbbLMFBcysNfr5T8CGSR2cJl3GXjp6qG3Yof1bNM3HDbqmMB0k99AnMa4NjzQ49Be1r7VATy5pnSOQlBko817SwH1E8QODdikGDLoSp4xgtLkfWd/c+WUHX+2eeiTXQLbtLCLE3khl8aCdYwPGhPQL4iMDG+i5oQgGOAiIIVSdMuHBjkVHcBH+hU0BLXhV1qkGFQ3vNBfKAT7wBjgX5rksBlzEmArYIVvZxXJH7wbkSf/WMRJwuixiDCkufpwhNjFSGZ+JHC81HPDCafVx72tv22T/5Q5KRTzmlpTEC2lkPzYGesRnxjyZOMXseGPSRD8ph1nKSAck9F+gzxZvQAWNEgxv+fbO6+dPNiIeTC2AbvVxoF0nsalWiXy2Ahk2LYrJjVP1gZXHdouVfxlapXLCTYmsjs7haPMbTW664HQ1ZcS4XLhsrdkgph3HURtzxWrOeclJ9KFnXCRCmmyVMQAVT8zEV6+mAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7710.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261022105027099003)(261026140227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnN2NnR0dThDUEtkQXEweHNKUlVEdHNmbGwvdjJDWXlCbjM1MkJkSWs2eVpB?=
 =?utf-8?B?dWRWcDQzM0M5Ky9SL2hhS0FFZVRnYlU4VGxIWUc1VlVrT3lWZ3kvTFd5cGpt?=
 =?utf-8?B?Wit6NmZUNCtpT1dRd0hYZjVJZW5FMjBwWEd6VVVHWkd6NGVuV2VITFUwNW1G?=
 =?utf-8?B?NzhMdiszeXowQXdjRXNXc2V2eERZbUw4RjBEMVZ3Tlp6NjlQU0VoMkJOUjdT?=
 =?utf-8?B?ZWZSdDhDL0FWOUllbVU1aHpwOUFaMjZpdVV6VWhtN2ZhVTNYMXFvZ2NTYjNm?=
 =?utf-8?B?U29zSllrZEVLa2FLc25xWkVwbnRaaVhkTjZRVEVZdTRDRGJqK3oycC9nbHo1?=
 =?utf-8?B?TWp4RGxwZjkwc0VsdElyVkI0ZmJnSlVhMUtGR1lTNXo3ZkdrUG1zZ2JRUlZI?=
 =?utf-8?B?UVllSC80eXRpTHlhR3VoLzY1Q09HYyt6MVEzQUxTUHF6ZGNOaTYvaVE2MDZn?=
 =?utf-8?B?a2V1cy9YLyt0bnEzaFpZSThteW9kRi95SjJ0NVNCaXg1SWRrK3R1dEtCV1l0?=
 =?utf-8?B?YmpteXhmNFl1UDFkSGxMNXlpRVkydHlGVzA2RUpyNlA4N21pMnpvTXJlVkJG?=
 =?utf-8?B?eWU1R2tiazRUUFdUUmlzc01xUjZEcXM2YThWSW43bllRclplYTFVMWlZekZz?=
 =?utf-8?B?RmhOK240QTVCQ1dkRmVnWVcycG9FMlgvWkM3Y29mSzhZb29TOC9iRUgvcHcy?=
 =?utf-8?B?R3ZOY0ZiU0ZsQVQzbzdLNlhXdUd4RkYwTEFKZVUwZzRHVnhYREhtc2FVaUR5?=
 =?utf-8?B?WHM2S1pFcWRPSWNTNDhaWDU3QVFSYmJFSU9UQ0J0VG9RQTcxckdSNFJpWGM2?=
 =?utf-8?B?WU96OENRTWl5ZzhpeHdZSzE5OVBJcmZDWkdvcFBGTHJXYnhlWnF2cmJidVhs?=
 =?utf-8?B?WEMzK04vQ0YvL2hOcDZZTndMYXFtM3VKYkZVV0lIYmxZTW1UWWxScEc1T2Js?=
 =?utf-8?B?NEY5SDdnVjRnRUl2VE9FNDdkOGVOUGwzdnBReHVDTnZ3ZU05eC9scEMwaUc4?=
 =?utf-8?B?Y2xzZFl2bmZESkJXZk1WV08xa2NwakwrVE9Rd1U1U0FTQlBaaXlzUEhKWnB1?=
 =?utf-8?B?VGIyTDhSSmVHSVBSNFBpOEdKbjFDcHFmUTFPWmFaSVdDdjZ6cjdOTkRXWXV4?=
 =?utf-8?B?V3dkTTJqNExNNFM1SEh0NkVmWVNLZjNSbWE2ZUNROWZTTEtUYVZIcFFrcmM1?=
 =?utf-8?B?VjJKeDFIaWo5QVFtS0VyYU5uZndVaDZwbVJoMzVoNFVPM0VRWFhZUGF4MGhC?=
 =?utf-8?B?RDFzUGRqVmU4Y0FESSsvemxnNDhFSnNISy9veWlFa2dJNnkreUxUMHhxdUlZ?=
 =?utf-8?B?MG1JMDZoLy9Qa2cvM1plZ1EyQWc2V3paRW83MGd1S2s2aDQ3TUFuVWJGcWtW?=
 =?utf-8?B?eTYydThObWdhT3FpdTF0cHBvSENWTEN4TmJhdENhZXQ2eFkrSHpsY09JMmtN?=
 =?utf-8?B?N2laREgxUjNjTlB3bks4RWVZY2FXZGg4NVV3RjBmMzY5UkdCNkZYbEhSUFFm?=
 =?utf-8?B?MjUxR2d2UTRnUmRFKzdabjVGNFd2RlhBWUlid25oakovbzdXb1pNamFmdzJo?=
 =?utf-8?B?dkUwQ0taK016MVJEcnVjaTZKSUZINHdCK0NJYzFyV3J2cTdFbWJDc3ZkTXRj?=
 =?utf-8?B?a3VhUGVVZ2NzSFpoczNJYUdLeW10WVVtUjBpV0dsekROOEliU1JvYU1jaG5E?=
 =?utf-8?B?aGtWYWRrV3JOQVBRc01sYzBJUUNCdlFMQzN6ZDErVFJOSHZUd0R3QmhYdkpO?=
 =?utf-8?B?NTJhdm9pdTN1VGZieVZDQWJYS1J5T2Uwc0htTGtNdmRYZ2JmaGFoVEhkcG1H?=
 =?utf-8?B?WDZtRDFwUHZ1dFdiYU5leGdVUG1HNTV1R1cwNUZINDUzajVXZjBSVFllQlhC?=
 =?utf-8?B?Tk1Yc0J4cTU1bVlPK3ZNRld2Y3dhVXpGR0k4eWdRd0NpTCtlSHFMVDVMVUNG?=
 =?utf-8?B?YmlaV3BKQUtMUWttTlAwaHpHWDlxSHQrVFBMdVhxYkVUWWdYdmliVEMzamRr?=
 =?utf-8?B?bENRcVNLZHI0TWN4WEdSYXNscmFreUFvUEpMNk5Sd1BWYlViY2pDMzFFZ2R3?=
 =?utf-8?B?T245eUZMaWdPemVDaVJGQkt2M2J0N3RSWFlRRU9hcjNua0F3R1hCQUtOREl3?=
 =?utf-8?B?djlWd25hSXpycUE0RW9IRDVpYkl0cGx4RFdwY2kwTzZYL2tFOUZQeWVsWTlI?=
 =?utf-8?B?MEFLWUZ5QVRNZ0s2bE9SSHZkQkNlTkV0a3lBR2YwUEdJWmZKSXZ3RW5iWmUz?=
 =?utf-8?B?NWcwU1E4MFRFZnFBNURGT25DNWE3d1hkTzRHdVhJc1A1eWhqdUlQOWhBM2tZ?=
 =?utf-8?B?cFk1T3ovOHFNeWVXcUlBcnFIQXZMUWFBdHlnTC91UzdMcDlJY1g5c1h1bUZD?=
 =?utf-8?Q?+w5PV7DNIhFSZuGE=3D?=
X-Exchange-RoutingPolicyChecked: B6rbsPnXX4umEeNZwLqvq/lx61nYx+Z803jpuBy8qvEloqxvcsQczP8zjKfIo8epvoC6+wAm2ZVBCGt+jFrf2TdNvUYfbYBSnOcDjt8UB72LBJFY/5JL5CLU3k1j9rpgUjzxKVMpJFoRD+A0e1VMSrh33SYVmF11DQ2E2obfnulYlnoTCdnp7mwKd4GcMAM9t+kGl9mP8bjYxglZwLcE9GKYkqLCyeoodxWL5FpTpJJTPcDhxL9y/Yaz2hdcBx8khCl6Hey69A/rZY/+08Mx8QdkYKkez6E+OryH/Lz272L47LgW2GmGqpQJDUYLnCZFpt5fwDBKGGJ0/haKmaYmTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9529a1-9a27-449a-7329-08df4b394fb2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7710.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 21:16:03.4925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8AGQzY7oFdHfxu2pSQLugQ202dMW5gO+U6EtUnMm8d++gUj2LkQFLm9tnnEl3albkNHyiW/edoqmUbSa9tyXYcxMuBAw8VD5GOOVSQOvKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8844
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/25/2026 4:46 AM, Petr Oros wrote:
> It would also help if Intel updated the MAINTAINERS entry to match and
> kept it up to date, so that it is clear who acks fixes for each driver.
> Jakub mentioned adding maintainers or splitting the entry, and the
> details would be for Intel to decide.
Yes, we plan on making updates to that file

For netdev maintainers: Is a Reviewer: entry sufficient to be taken 
directly?

Thanks,
Tony
