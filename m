Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FD606A335
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=eeTjM8P/;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=USL6RpLj;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bdcDOfyf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5173E8116A;
	Wed, 18 Nov 2026 20:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8RwcjwsEzpK8; Wed, 18 Nov 2026 20:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91D838116D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795032616;
	b=szNFKqpFjWIV9ObKzK6yYhRQdT5B1/Hnzpg+uAIHjodmbJUd4SsaKNUAOF32mG6uxjad
	 //1OznxcX9f3xKgq718gkqaZn4I/96GfjZX3XoTllS8IONKph8/br5Gh/5jT0IK7u12iG
	 jrTKIa88vw+Wu1c6/gK62PC50HuvRXPZ6+u8Ex7i146u3A1Ezf4+VeqnTsizNpc6sId+x
	 X/gyhJJS15107KaSAZdGpFPbF2nkJ7rr9kiOP3IHkxQUAFKtQSRVDGtJkCK7mOEdP98IY
	 fnfVx0eqNeXk6dCiDWmfKotnXNge92F0biR1UDz7eNc3jZ8R7V5v4QdhRVFoDuX8ZGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795032616;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
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
	bh=e+pdzDCRdQGrDRWNGtmtv07aoEGXAXZQQLko6GgZJ0c=;
	b=dGXXGDgRrlEcYu1BLSZhEVsg8Wwek7YblFeXLfbYWOTQ6XytZ5RcvvqNwq2/nC5Teeoy
	 Z6PgrOfh6bWrnBAGXGfOhtrMVwN6H3y34shKP45uQOAOmorXmF70nqgMjp/MBpMjy9CBJ
	 wIIbnbqVZbqb3r4y/2g/g54SpGVmiHwqm+H2pflz2YSB1lv5qhUGUYYZL8dx/Ioekvit+
	 ybugOtniX/VaVhxFCvjY1Op9rE1ESC8V677oHhaUryAN5aSMVyx7blRe2ujtQuBTxx4fY
	 H0cedNAn8ewPoqQ1D4NxgiJ3nhRMFgvAo7nfOc1kx47xTDHo5AXPNlJJpfiTtzHITOQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=USL6RpLj;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bdcDOfyf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795032616;
	bh=e+pdzDCRdQGrDRWNGtmtv07aoEGXAXZQQLko6GgZJ0c=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eeTjM8P/RKejHGo0zIaDW0przSbQtmauJQwvPy/y33k1wSyfoJzi8Zr1K8/RUr2YK
	 V1N8KDS+allj/jOc6qfhfGtxcskC0yQ4IfO4eh/azF+pkMnLAoCMJU4D9fwo+GeueR
	 xJ6uAetMejaav/z+SCbjCcMKdqqfrRUVWNzokIfmpg+Kx5LwAGueIgyPH4thTfx9LW
	 rbiGeIkl5pVVRecxuV5kYAzWm5eh3Pi9wxmM8m8WBaoFHL7Hsun4bYLrexFlgKK/JO
	 g6E60f4fYVcXJJsTrPVUqqjAPyRZ7sda5vvXWAmqAWHHCTyFwKDNG+V7ebp7p6elmR
	 6CfK5a+YcaA0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91D838116D;
	Wed, 18 Nov 2026 20:10:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B4FED2F1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 20:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A73F58116D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 20:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fBTglfbPUoqJ for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 20:10:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76D928116A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=USL6RpLj; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=bdcDOfyf
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76D928116A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795032614; x=1826568614;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=8/9p4//TUR280DAqhFcvny1XbtWGR5CneNhRVr/N048=;
 b=USL6RpLjDY0vRKjTPuTv4+JtebBSmtqybIf5rK1x2Ec92s8UXENkL2iZ
 AiZJUhpwMetlMuJ5BNbn9x9e3e3fe9KbvDzUYWCY2isbaviRzbQ8aEP2Y
 fdUbbmVMoYm/aKz+gbiVJQX1i3Y/mnO4HJrRD/928pBA1K6fHxFtYjdJm
 xTDtZXPPSFi3TD8/Fd0lhDD2VLw6NbSqSlYTcxKfLD/wNNohsHhxgjIyr
 KyXVyvPG5RmQM8X1kFBs8zqw1A11fv6OX1MCHZZELPLYmpdEoF/Un9TGZ
 prpQvnar+4ekKIxP7HFpKhx4MZn8FfHum+Z5QyohkcBAM/NTOq5jvYBXO Q==;
X-CSE-ConnectionGUID: eD28cophRge3z9EwWQyk3g==
X-CSE-MsgGUID: 8ygBaWF/QUq6cJnfi9Kykg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3907418"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3907418"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 12:10:12 -0800
X-CSE-ConnectionGUID: wSfHJBYPQDCZAUdE+AqdZQ==
X-CSE-MsgGUID: d9eLgcJ0Syuiy45rxM4EZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10321653"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 12:10:13 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 12:10:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 12:10:12 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 12:10:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+pdzDCRdQGrDRWNGtmtv07aoEGXAXZQQLko6GgZJ0c=;
 b=bdcDOfyfyPIFlueh5pFF12HaaZVteVxu+rtY8BGxkJG4Q5ZirisCU8l4f01tJnt+pjbn4Argf7k5Ez4FPe2qAvIXFgQjZmtdUosiEUccJUGtODEqQOmGlrv7QQ1V8cFdoDdLuWNYVwhYGp8cn8vTdCQk5kpkLXjCtNt6H02uat4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:10:10 +0000
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c]) by SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 20:10:10 +0000
Message-ID: <80f7a5e6-03de-4ad4-9bbb-8b8460951485@intel.com>
Date: Wed, 18 Nov 2026 12:10:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 3/4] ice: store cached PHC time in ice_adapter
To: <sashiko-reviews@lists.linux.dev>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
References: <20261117-jk-e825-e830-timecounter-v3-0-87ea4c86a249@intel.com>
 <20261117-jk-e825-e830-timecounter-v3-3-87ea4c86a249@intel.com>
 <sashiko-outbox-219870@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-219870@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:303:b6::21) To SJ2PR11MB8451.namprd11.prod.outlook.com
 (2603:10b6:a03:56e::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8451:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8d1d51-f2d4-427c-391a-08df45aff249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|4143699003|11063799006|56012099006|261021135927099003|261021123027099003|261022075727099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oV2KLXm0wOeVlcfA7Jx57v3l+BBNGy+g4N2Blq1yf9iE0/bnN7ORwO1KpisjshxTLINY2KX3rVa+o6piFBk0qlAyeaJvE97VSvZUcF/T/ZQG8KKmZ/jFn/yVnuu2AAj9TdX/ddf0sXuHdEeHBmM+YR8rvgX0z++k0xI5fET/wmIERspQvDL4CuX2Vrv4uSAelQDYPfIU58OpaQexAm0H1KzBwT64FFblytGAW1OFMhjjyk1uuAdRUA7WvAlsNimu3dgv9PSLHciqvjE4af+MaXZxGhz6VZYtjD7OBBTwfsPRhwxjzDNsssDKfp7kbU0srUWbmwi1mtp4OuIoQ+fyxbmMuCtBEDRZxAIs4iq65ntLNfhiyoYTWOUb+0CXaQMriBxg+OlmvUoISplXGJALLB14YtV/FzMau2X2WKQcdsQUL2jpaBqaJ6Ei5nKW2NLzjN8fAUVTdw4r0Eh/+K7LecdC3E4WM37MQPJryw6Lo/dsbvXXChjcV0/fBsiO0mVqSkZtWIhvBj9LkfSzq7Otlf+Pe6G254/6UtWjhAUBd5UepA9BYXQV2NqeFZr4p4rsbu4i0byuKx5cvCwMHOplY4Ja0v2J803w7+TkrnS8P14+5vF0/Ua+QZdeb9gcHxkunNTc9jYw1reP2bytL9L+ZIR4JQ63I8+tx524DX6wl7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB8451.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(261021135927099003)(261021123027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjdZQVJpVG1zZHkreGt3cEVwL3VHRUpLdnpET3ZwRndEL3BxWWZ3d05udDA0?=
 =?utf-8?B?UncwUHQ2V0RoOXA3YXBqTVIwdjhsMmFrNFhlQ0VqMVFScXZZMkgvZFJzSHBv?=
 =?utf-8?B?YWJkdk9TMWdma2p3TUlSdnZDZVlLcHhQNFA3MnUyYmh5OGV3cmZrcG1hUmFK?=
 =?utf-8?B?alM1V010OUpVcnRscmhxMDRUN1hNU3F3Zk5qNmc3cVVuNzNvaFlVbnFVeWk3?=
 =?utf-8?B?QVBMcEc3Q2UxYi9zTWFsZTBKWlFCYy9FU0dwRXVJTmp1WVpxQWdXNlFRc3dY?=
 =?utf-8?B?bFM3RkwzcWtlOERWSkJleW42SFNzQ1FUTzg4NStHaitZTm9ReG1ZYVkvM0JE?=
 =?utf-8?B?WDN5U3J5YTA0YkFUWjAxVnJabnpCemtOMFFoSTBYdFBCaHFVYVlDdHhFT0JW?=
 =?utf-8?B?b3FiWXAwVFFaTlpQTWxnK05jcVlLb0RSU25PM1FNUUQ3aHJXdGFRaTJnbk1i?=
 =?utf-8?B?RkkrYlJUS2pzWHN0WUhSMkZJbEt4M0xpTW1zRkU5aW50K0hwTTZOY3ZoT3ZG?=
 =?utf-8?B?aG1GSyt6MTBHZitlTythT2V5TWsraGk2ZlJEVFlDR0VuUEJ3OVFpTEVmSlVM?=
 =?utf-8?B?dm5XQzh5NFRydHI4TmlwS0dQZ1RjWFRJRE9sWFd5elplM0JublIxaFhmN1U3?=
 =?utf-8?B?T3BPOWQ3YzB3Snp4aWVuRFpaWG81Tnk5WXFKYkZkL1ZHUmtpQ0YyQU11YXBv?=
 =?utf-8?B?dHJJVEI0dDNhT2RHUG9kVVBGeHVvZDdaWDRhOGhTWkNENU1iekZObVA1Sy9V?=
 =?utf-8?B?WTFGeDhjZHhMbVVIaEhqalpoWTFaVms4b1U1MjVHUURTdDliU2ltTnQ4N3Q0?=
 =?utf-8?B?ZEZRc2RxdzdHS2RsbnI5OFF3dmVOVDBTVEVPN2kwYkYweDdJWi9sNWFNYzNB?=
 =?utf-8?B?OHp1RUllSGtyWW43bEpnL1pBN1VQVlM0Nml2V1dqQ3hsSEswSGQ4Z3JoaEMx?=
 =?utf-8?B?M2hULzNnYXg3VGVJYll0LytPRDk2cnlob05aWHdzOFk4bHFKS0ROdjNzN2Z6?=
 =?utf-8?B?SUx3V0NLaWErS25PTEtFeE5qUWpLbFErZUM2ZFF3N21Rc1BpQ0ZWMWttZTNQ?=
 =?utf-8?B?SVg1NHJvcVVEUFhWL3lGRU5zOXlJZkdqL1A4SnM4R21Gd2hQcW9CU1JHUFBM?=
 =?utf-8?B?R1lnWFdYa0tTVWpXd2VaZmJXYjN4VThEQUVnWk50alhNNW1XNjA4MWZFMXFS?=
 =?utf-8?B?djIzUGZkUk9mUmcvRHhtUnZzZWRHczRVRElVVEVhT3dKeDJjN2tRbFhYZDBx?=
 =?utf-8?B?dGlybU56OEkvanNzbXVySEtFaG0zNWJkOUsvd0VEUUtZYkZRTTNnKzd1L3BN?=
 =?utf-8?B?UHFTT3ZBL1h2S0hnTmZkRDhhTjcwbEt3Q1JmSTdoWDZhNEU5eHVCNjBjVVd2?=
 =?utf-8?B?UkdBUUtYbkZPbXRLQWZXOGlkZmhaWGhjNVU2TXoxLzlBb1dNZjEvWVhzZmFL?=
 =?utf-8?B?bkJBa3psT001MmJISWtYckpjZzR6T1UyZ2JpL25EL3ZOK0FCV3ZZaDh6QmlO?=
 =?utf-8?B?OVFpOEdIUnk2a2NxejVTV0pzTDRiNFY0UUsvYktLTk1wbWhPV0ROSEwxNU1C?=
 =?utf-8?B?TjgvMHFZRzU3ZmRBUTB0eTJ5NG82U3MwQUVoQTI1RXUzSDMrL2pJSmd1Vm9R?=
 =?utf-8?B?QWVnWHc1SHlCS3FNbHp0SU16RHJNNDZZYUc3OEVXT1ZNZldheHNhQXpzY2lP?=
 =?utf-8?B?M3B4b2k3Y01OOU5TWXQ2OGJzY2FhTWc2T05JOVJPZVZ3NzFPaDJDSFRYbVRh?=
 =?utf-8?B?bjgrQldyQklLSkFKMWFkYmJjTjlBc2pnRS9zMFArK1AvdzM2dGJqUlJGSGRj?=
 =?utf-8?B?Q3I3b3JZRkFGYnJHMmRaTHRiWEtCcFZOSzJTNkZmU01yQVdqK3B3b2JrblVY?=
 =?utf-8?B?WndMNzhYZmZ2Vnhod1J0OTJBVEJlYzJyclp1WWRwY3pTVDlDeFNtSlZjeVNP?=
 =?utf-8?B?TUJtaUR5b0lhOWpEeVhLQmNnck1GRHFzR28yZEwzZlVBeEZGZGM4emhkZ0Yw?=
 =?utf-8?B?b0toTERWcWVzeHJZUGMvS29wNG5VeExVZXF3eE03WGZIajVYMmZEMFpNQzNa?=
 =?utf-8?B?dDRaOTRRVGhTbks1RU5MVTBBbVZZNmd3Q0dVMERBd3lBdDg0R21TakszVW5M?=
 =?utf-8?B?YVZrYms4ZFNweTFOKytXd0R2TzBxd0F3Z0IvSTBqdG1jbW80WGtCZExWUUFv?=
 =?utf-8?B?b2lESlh0eDBlenZ4dWsweVk2Z09ncUYrZHVGTDdCdDZtU1RETU5rdk40eWJH?=
 =?utf-8?B?TWRINmJvMDE3Rml2WHZlWFVHNUF3c0Jod2ZPMGxsdXNhTzZCYmpNNDFjbjZq?=
 =?utf-8?B?V3lXeHQwYkw1Y3VsOUZELytsL05TdjdDOWhGR3ZmTkJvVG5zdm5WR0hJa2lM?=
 =?utf-8?Q?Gz5EYi+umgWDn088=3D?=
X-Exchange-RoutingPolicyChecked: r4o64xTqKru1vclRupJV6ftfeRYOcxq1I7xsq/4Tfq7s14rxC5WWLY6Ymfg+7Ru7scSzF1wdU2LW6cLqOjmewn5kjN4FhdtJ3+HCJbWBuuYdaL79P590hNMCboW4nJakOeJpQXWrO6k6tmRvsmzLAaYIK7wYNbYNovrgM91pH414IZUby83lkTsx2NHP1u/DybSzRvggLwzZkv+skmM5lFsAxwseGoCJ8Ck7wYE8P1jx+UAQ9PCjEcyV5EHyCzsvG8GuKODxpLIyYY4srqgTUTrkCOmVkhilcABYSQrguAHNW0QeGaoP5tOZOGiVnKOxdDo6xoo+HXcaV5gRGPvZZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8d1d51-f2d4-427c-391a-08df45aff249
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 20:10:09.8644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcwUbLtkdF4laYhO558AQyoosB10clcNQd5JTAggNt1aareY2e97op++//R4QOSfwWvob5xFA4necm6vEt0q4GWS2aMT5283KydjdI4ZhKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/2026 4:44 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] ice: 32-bit build failure in ice_ptp_extend_32b_ts() on 64-bit
>   update_time
> --
> 
> commit a94f5b039e979b49b6aea8ea8e4275f20187401e
> Author: Jacob Keller <jacob.e.keller@intel.com>
> 
> ice: store cached PHC time in ice_adapter
> 
> This commit moves the cached PHC time and its update timestamp from
> per-PF and per-Rx-ring fields into a shared struct ice_phc embedded in
> struct ice_adapter, updated by the clock-owning PF under a mutex and read
> locklessly during timestamp extension.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> index ce1fe08462652..ade829c05000a 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> @@ -35,6 +35,25 @@ struct ice_port_list {
>>  	struct srcu_struct srcu;
>>  };
>>  
>> +/**
>> + * struct ice_phc - PTP Hardware Clock fields
>> + * @cached_time: Cached copy of the PHC time for timestamp extension
>> + * @update_time: Monotonic time when PHC was laste updated
>> + * @lock: For protecting updates to the PHC fields.
>> + *
>> + * Readers are lockless and rely on READ_ONCE/WRITE_ONCE for the cached_time
>> + * and smp_acquire/smp_release for the update_time field.
>> + *
>> + * Writers must acquire the lock mutex to ensure that the periodic task cannot
>> + * write back an out-of-date cached value after a clock adjustment.
>> + */
>> +struct ice_phc {
>> +	u64 cached_time;
>> +	ktime_t update_time;
>> +	/* Serialize updates to cached_time */
>> +	struct mutex lock;
>> +};
> 
> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index bf37c2a7ff863..d07dcf619bb18 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -309,13 +310,26 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
>>   * This is prevented by (a) periodically updating the cached PHC time once
>>   * a second, and (b) discarding any Tx timestamp packet if it has waited for
>>   * a timestamp for more than one second.
>> + *
>> + * Return: the extended timestamp value, or 0 if phc->update_time is stale.
>>   */
>> -static u64 ice_ptp_extend_32b_ts(u64 cached_phc_time, u32 in_tstamp)
>> +static u64 ice_ptp_extend_32b_ts(struct ice_phc *phc,
>> +				 u32 in_tstamp, bool trace_rx)
>>  {
>> +	u64 ns, cached_phc_time;
>>  	u32 delta, phc_time_lo;
>> -	u64 ns;
>> +	ktime_t update_time;
>>  
>> -	/* Extract the lower 32 bits of the PHC time */
>> +	/* Discard the timestamp if update_time hasn't been initialized */
>> +	update_time = smp_load_acquire(&phc->update_time);
>> +	if (!update_time)
>> +		return 0;
>> +
>> +	/* Discard the hardware timestamp if the cached PHC time is too old */
>> +	if (ktime_ms_delta(ktime_get_coarse(), update_time) > 2000)
>> +		return 0;
>> +
>> +	cached_phc_time = READ_ONCE(phc->cached_time);
> 
> [Severity: High]
> Does calling smp_load_acquire() and smp_store_release() (in
> ice_ptp_update_cached_phctime()) on phc->update_time break 32-bit builds?
> 
> ktime_t is a 64-bit s64 on all architectures, whereas smp_load_acquire()
> and smp_store_release() enforce compiletime_assert_atomic_type(), which
> requires a native word size up to sizeof(long).  On 32-bit builds with
> CONFIG_ICE and CONFIG_PTP_1588_CLOCK enabled, compilation fails with
> "Need native word sized stores/loads for atomicity".
> 
> In addition, lockless READ_ONCE() and WRITE_ONCE() accesses on 64-bit
> phc->cached_time and phc->update_time are not atomic on 32-bit
> architectures and can tear when ice_ptp_extend_32b_ts() runs concurrently
> with ice_ptp_update_cached_phctime().  The follow-up commit "ice: use
> struct timecounter for E825 and E830" keeps these smp_load_acquire() and
> smp_store_release() calls on phc->update_time.  Protecting the fields
> with a seqcount_t or u64_stats_sync (or storing a word-sized jiffies
> timestamp when a 64-bit read isn't needed) would avoid both the build
> failure and 64-bit tearing.
> 


I'll just switch both paths over to using the seqcount_latch_t in v4. I
think this will address both sets of complaints from this nad patch 4/4.
