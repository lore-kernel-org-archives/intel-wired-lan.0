Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AD606A32F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=7ktHfbkS;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ccd3oSWe;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=HpQVQxFk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB70540880;
	Fri, 27 Nov 2026 13:45:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9rriIvn7l-aX; Fri, 27 Nov 2026 13:45:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F646408A8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795787130;
	b=DlHGfBHZgeinFjnMZXivh5bXP1Mn5gFrr2cSKaao405MXD4mvg8fAFbFZR2EC93gmG7F
	 nTx6u8bF62REduMNvIW4naXMCVpL2svRluqY0ZUszV+QtIejcQikGQuEE+x8soDAk/hmE
	 IVgSBO5/SIIAofzucupziU+bkfOorwxKvyeo8jHN6mzkbddty66yUGZ29zIwQGo5E6Jd7
	 QjYPSt1qVLT1ZAQ9LQT2pIsLNDXpnMUnOLe584OLwLls/p4Dy9Vk343jEGJa+dhiCcDlk
	 ZuQz6Q7syNzJAtI6lcDxylTTk8146OZJye0UqofhYH5KYfDdCpQOzKDM6/f0hM57fyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795787130;
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
	bh=QVE4/DfAodPWdrZ8HCaz2k0HE26vQvOrrfdXfmqNy8U=;
	b=gEJq2Zsxh+y8YTjbPYnmUAS/IBfTmPTu2ExAX55oQqUPjjpZz4+HF+KuUNVcEELCOPtA
	 /nZvcs6vbMH4D/MYsaY4wyOzxllTfBynOpO4mxv3mBZTTggmUuR53fX4S3HQbNOFLAFhX
	 sqcVVmVXbWCLirGWAp5j7ag7lAy1weVOUfYvbWiZb7ERKps+mphm3rnw1103XhOQ821sn
	 Wer+0YWA1wCSay/oMRSubR9Y0+SuJPcGfPA/iAtL/g05K6cLvJWCxQTGfVp/tFxtI6neo
	 YbBAOsNWHm1nEht6loed4aWIfPY9B3zaqiEqunqSZ9hniCemKxTnimvdXLA1ZDJjFDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795787130;
	bh=QVE4/DfAodPWdrZ8HCaz2k0HE26vQvOrrfdXfmqNy8U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7ktHfbkSFNmktFydKmsvmDYpxe32Lq9bNifnSzMo5SHWeHWHicZM8g2FOL+1BHt7V
	 V30gtAyW/tgNGO9QVx9BN1TLtqGB5VHN/qN1ngl0y0GluGOeK9UfMPhFNXpdrFMxbT
	 6Sv8/kXQi/HzZ2PRBZ6I/qk1cM3YqBhyw0v6/pKHt7VLi8hwotZdNAQXZUzcKDFUMo
	 lURwfVAj2F4OHNekg4plnSwn0J0QZgfkUIVU9g2AbtVUM1zpZK1kKPjgzc/vme7DKT
	 Rw7R3+ETkHREqqygz2sh1KXVJx2YoNsKdwXwhN1VKwEcsmVVwJZo1Li82O7WG6Q295
	 TnusjdGD6C1Eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F646408A8;
	Fri, 27 Nov 2026 13:45:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B172311
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CF5C60AC2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:45:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hohx0IFEv-Jj for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 13:45:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F377A60AA5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ccd3oSWe; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=HpQVQxFk
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F377A60AA5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795787127; x=1827323127;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gHNzhi2219im3RbFP+bL4Fr0GUF606e/WFbOWHZYKEY=;
 b=ccd3oSWeh7gDs1wP72ehzYLOXaT1zXWYwC9UOL9x1iXISCkgQ+pEdey1
 hRftXN54oXdomq5Ek2tUnWg0ITV2MwUrhsYN28FIJrUaDhnPBCbwpBclG
 xhyK5CvS+FHcDY5w1Grf87xW8w1sv/zU2gfQcCBr5L/DPoMDTBrRDQvEO
 kbJC32sj6x5fs5ewwGAlL/bZJ5z+ljVEVB2HQn6B7ORl0URUyPtkRPcSE
 yoobXTVKSBHUaP/TDKYiQUMr272baJJFaoLe2zfwnejXrnCnj1yudHqxJ
 BaQ0cCuHBXrf6q2F9xyWeDNMQjsF5DWNtrV+9Zs4JT6AopBC6WPQi97wL Q==;
X-CSE-ConnectionGUID: OcyxirmpTmKcgWqCvXcEhA==
X-CSE-MsgGUID: 2yXHUs8hT2ays8HJ7rIY8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4609138"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4609138"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:45:25 -0800
X-CSE-ConnectionGUID: TmtyBfY0RGmGnYkjZrBnWg==
X-CSE-MsgGUID: 6/JDVI7YTz2LIKGMlxqWnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12694267"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:45:25 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 05:45:25 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 05:45:25 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 05:45:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVE4/DfAodPWdrZ8HCaz2k0HE26vQvOrrfdXfmqNy8U=;
 b=HpQVQxFkIOjuuCH52F1s57S3bNy+Nz4i1raMH/VnPSc01I/5cckfV6bxCh4AT/9Q7piL3cRMsXpD10ODPdLV45wUxtgHnkZbszLd/dXgack9F18v+gSU2bd9ImZjY2N8X2CIC2zxQY5eDMSYo2vNw4CfqBH5feHK/CoDT91mj9Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by LY0PR11MB123582.namprd11.prod.outlook.com (2603:10b6:404:226::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 13:45:10 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 13:45:09 +0000
Message-ID: <489c2667-b109-4dd0-89f2-b0aa6088f0a3@intel.com>
Date: Fri, 27 Nov 2026 14:45:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 3/3] ice: share all RSS hash profiles between PFs
To: Jakub Ramaseuski <jramaseu@redhat.com>, <anthony.l.nguyen@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20261126123114.893916-1-jramaseu@redhat.com>
 <20261126123114.893916-4-jramaseu@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261126123114.893916-4-jramaseu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0192.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::15) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|LY0PR11MB123582:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ceac134-bced-4a5d-f799-08df4c8ca6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|4143699003|6133799003|261009223027099003|18002099003|22082099003|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: cr6OmCyDz2BVS8fpxQA1e3UOGMGMDJQUsRwgiACNueysGggfNyTszIBSFff/88jNdnbQUkV/ABZGcqMUHCcChGBfpETWlOouYpEkPsJlBfqmRJuz47+MNHQanxNKMQTN70rMqOQttZkpi0ZWxickFxXYZApqmx21nCmCbxo+MqiGff3SozppOHWp/09LfS0l1bXZdbToWhLBcB5BXHlHim9XfmDEvvQkuNEwiOYSUnh2qp724BTTIGZZKcWJ0OzARtBTukqVu/WMzJkiOsd/nYDPGANXbdPDeGWp1qUKv4cArfKLBZLWcwDzbJl97o4MQ8GkygR52HAAWz5WubiLnLcD+UTHExEXrFn94I40YI1H6oFytTGdQ7dy4gLwPMHdYUWTPGr5vAl+ANW6IY1+KgwEXcGUvPJa1JnUg+rjkridZ8m2ST4cuY/WvjRx9EdnHd/2Dc/kEAlxAjNSXl4thKh/ND7bCHEeA254l7SrFG88rPYsTI7aP5c4bEe4zNwYMra26gIYlCPy/IdL8Rt1ck5xC0GO6l7W/rN7ShxK6pFy4xQan7zGIWHAL1sUTJgPTEXnP+JH4WdxBrb64dgQGzL0DhsIefNxObseG8aZ9ywMqok8UB8kep06uc3lTsw7MDW4P4HzRrl/vb7qAw6JENp+jKFmg2Ao40TFmH7tNsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(4143699003)(6133799003)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K283bDIvaGI0OGJsZXhKZERPR1lNNzJkU0svK3phekNDVmxCWWpLY2JHWjhZ?=
 =?utf-8?B?SWoxL2dRaHMvM3Q0bHVXdTZacWFrSDA5SVM0ZnJaTWE3MldyOFhaalpaSGpW?=
 =?utf-8?B?bXVUTGhQOFR6L2JjOEJlbC9ST1Z2U0tLN3ZHRlBpWnF4MnJYRTEveDgxTW9v?=
 =?utf-8?B?bHQwbWc0ZUhNNzFuREpzeVBVUkl6Um1GZzRieVBac05leDc5UzFFbzNuVG5t?=
 =?utf-8?B?TUZzOWtQenMrVmVZa090MXgvRG91YzZnNjB0elh0aWRDSmxPV1dIM0dXSisx?=
 =?utf-8?B?Q0JmSDRmdVU0R1NuQ1k0cHprUnl1MnBkQU05dCtmQmRKeUxEL1lWZ1cvdzJE?=
 =?utf-8?B?R3RZKzJEdVcvSWh4QlhpOGZUSUJvOG5KTVQrOUlyeDFSaUZ1ejFTbzl0SEZt?=
 =?utf-8?B?S3Z3c2toNDBvU0F0dCtva0RYNzQ2VmpaVDhoZXlYTU8wSFVzZXZ4MzN6V3hN?=
 =?utf-8?B?Z1NWVjZnSzJwaFIvWjhhdnR1eGtDVTM1bHRPOFVtMFVCdDgzOUlNZThFQzRy?=
 =?utf-8?B?QjJ2NHNtMGRoOXZnOWllU2gwWnJreStxQUk4NE44eDZQYWNaS2pvRzRUNkNz?=
 =?utf-8?B?c2tRWjR2VGNlSy85QWYremxkVUovUzAzaGhJVzVjcGZWNytVY0p1Y1ZRZEF5?=
 =?utf-8?B?ODBVN3ZwNHAzV1M4Z0V2S240YXpvcnVFcm0reGdJYUJhZE5Ka1dWY0poWDFw?=
 =?utf-8?B?YUwvZnlMRWpJbmZ3c09JcFMrN2YwK0R4Mmw5L2lENnI4QWxNa2tUaVZGdHkz?=
 =?utf-8?B?cS9zUkQrOTd6SkZnUW9PZ1ZQRmNhSVNteWNVeHBDZ2Ntekl1MXZoRmtsczEr?=
 =?utf-8?B?Y0JrYTlGZFFuTDJLNDhFbG5NWkozQW42UVdYTUlWS2QvWWRjdURaR0lPZUhR?=
 =?utf-8?B?Y3FUSzJXbGlvazduSEZnekVzdjVPa2FvTjgrdjNOY1JTWkwxRWVhR0k2TG5T?=
 =?utf-8?B?eGlHcndKeWVwYy9Cb1pjbTdRUmJjbmliVW95R1Via09NMCtVOTdJMWRZQWRB?=
 =?utf-8?B?aVVWRXdONjhVRXh6Y3ZLOUErVWtDK0dHeFZ3TjFoSkpEZHVoWmdBMHY0ZU9w?=
 =?utf-8?B?Qy9nbW03SlVpeit5czcwSmxZWU5BRWU2WnVEQ0RBM2hpT0VMZDBXY2FEV3hT?=
 =?utf-8?B?NndNNVZuMHAwVGMyUkVDc1Q1SkdtOExubklSWFF5UHEwUlFrSkc1dk5BSFFU?=
 =?utf-8?B?NGdSY3c5NWhxZFMwUWlaNHpHRThBSFdyNzhZR1k3MkhQWjZiODExMzhPOUdi?=
 =?utf-8?B?VUZpSHZUVXlmTjJmRzZZb0ZmZXpWd1FUUWFXdzdFVkcyNlIwMVRGTWZRTjZ2?=
 =?utf-8?B?YXgwdCt4VmNXNE9uQlpxNEZOMTdNZ01KMDNJekNKRHE1d3ZXK1J4ckZzL1pE?=
 =?utf-8?B?Q3VnQ2xkMGlrb09hN2tRcGpxMDNQbzE5dEVRSHgvRGJMTGZhaVRhTGJqUStD?=
 =?utf-8?B?K0FxQ1lRVGZ2dWlPRmh5MnV1UVRBZFU4VnZFcWcrbEZnZnZhTzFOeXFZdXJs?=
 =?utf-8?B?eEtkUDlxSktoc2puU3A5SFQvVmVHd1p5MHhhOUc2dzcwL08vWWd4cVFWMXJr?=
 =?utf-8?B?M0pGTGxCblZvR3dUOWZRSGZZQlZNQmtxdVdWNUZidlNtRWhKTjFtemFRbWtW?=
 =?utf-8?B?bXdiWjFZcE9EZElydU53R1k4dzBWS3ZGN1BmdjNWenVoNnVaWWJvL05hYzkv?=
 =?utf-8?B?R08zSUJINm1iazUxZlFKWlk3YkRBR0pjUnlGTU5jOFRTOXlvaDBWa29wa3lt?=
 =?utf-8?B?VjZOUm1nMXg2MndLZnozWnBSamdrVGl5Q0MvUFNXc3d4UHZFeTR0empUQXQ1?=
 =?utf-8?B?Ymd6UE84TUNIdjVaeFp6anBDNURCTHk2NkZPdGd3R0djOGM3dmdGRUcxc0VX?=
 =?utf-8?B?azhqRVhSUEpsanlkZi9KdllDSXR3d0lQZUllVXZIdWtDYU1WNkwyVnd2Nm5y?=
 =?utf-8?B?UnRxZnJ1NHZEWVZ2a0lOeGlkUWptcGMwcjMzM3IvbmhLcWRkQ2pjZmRLY09E?=
 =?utf-8?B?ZVpzTkxnbzJIU3ovM0NWRDR4VmNpQ0U3MmRoSWJEMjQzcDhZNzhKN3dxRmZr?=
 =?utf-8?B?Sk42Qkp4cTduWnl1NEwxWFFGcVBtemcvNGFMREdZSXcrREJETWFGRnpvTElQ?=
 =?utf-8?B?Ujl0YWRjOFc5azFhdzJkRTVlZzZ0MTgrTkVIbC85SWtoSTlPOVhwZTZ1amZF?=
 =?utf-8?B?Si9MWGxrenhZRTlNMmd3YnA4aWQ0eTkrcHcvT084eHdqRGFocVNIVys0VG9u?=
 =?utf-8?B?S2FKbU4vUnlqRlpOQ24xWXJ1NlRKc3JvdnhuQXdsd1dOeEtJNkpHanJqRDdB?=
 =?utf-8?B?cUtBQnZ6NWlpZCtibS9kTnFOUXgxNE05K3BNK0llSDR0NEx6eUsrVE1ubUR0?=
 =?utf-8?Q?LD8lB/zx0I/6RzwU=3D?=
X-Exchange-RoutingPolicyChecked: RIynbM6EEtmBeB23oO2hA6aYlvUw/ynJEHlhTUAmi8hIaj8zAaHZGaWTaB/1mAHccVHZZoq/J3qU7yFkBhEb1LdqdOe0thyl33L5D/1fhIL9crS8B14Oa0PukMGn0Z7uDBMosMTQBhgCPYsNKza5BEx2ST+kRQzRmYIyTfMoDwwSbc2GFMtg5kqRGPsyf1Db9p/8gPvRuPJ7RZI35wiHzUaMYVgfs8pikbJ+XIef22Bjb1ud4dX7K9Vmx1j1QgOs/Hd+o6fZIIc//H60X77pO9SIsmvrN00NQ7w6RW0Sg2XPhSDQhl0+oPsbkugZL6XXYtRMy/NWhmdifbcHRBeCbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceac134-bced-4a5d-f799-08df4c8ca6f8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:45:09.1879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJdqz7u2S2xsyrHx2RRKqC3qL9zMGz3ECWW1ccAJKeO54zYHhLibaYy0YboY/3pfB38LZM0P4Px+fCt4eLFejBRRi3z3VIRmT7klwZd97ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR11MB123582
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 1:31 PM, Jakub Ramaseuski wrote:
> The previous patch lets the PFs of a device share the profile IDs of the
> default RSS configuration. RSS profiles added later still take an ID per
> PF, even when the same profile exists on all PFs: with a VF on each of
> 8 PFs, the default RSS of the VF VSIs and the same "ethtool -N <vf>
> rx-flow-hash" settings on all VFs take 4 more IDs per PF.
> 
> A profile ID depends only on the extraction sequence, everything else
> (TCAM entries, VSI groups) is per PF. Share the ID of every RSS profile
> added through the flow API: besides the defaults, the ones added by
> ethtool, by VFs (advanced RSS and the AVF hash enable bits) and on replay.
> As before, profiles using field masks or symmetric hashing, and raw
> profiles, keep IDs of their own.
> 
> The shared flag of the RSS hash configuration is not needed any more,
> remove it.
> 
> Measured on an E810-CQDA2 split to 8 PFs (NVM 4.30), with all PFs bound,
> then one VF created on each PF and "rx-flow-hash {tcp,udp}{4,6} fn" set on
> it, reading the IDs the PFs hold from firmware:
> 
>                 IDs in use     IDs in use after   failed profile ID
>                 after probe    VFs and ethtool    allocations
>    before       33             65                 0
>    after        33             37                 0
> 
> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_flow.c | 49 +++++++----------------
>   drivers/net/ethernet/intel/ice/ice_flow.h |  2 -
>   drivers/net/ethernet/intel/ice/ice_lib.c  | 10 ++---
>   3 files changed, 18 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> index 9be769b105cca..02337d9d3de56 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> @@ -1444,7 +1444,6 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
>    * @segs: array of one or more packet segments that describe the flow
>    * @segs_cnt: number of packet segments provided
>    * @symm: symmetric setting for RSS profiles
> - * @shared: the HW profile may be shared with other PFs

(general rule)
avoid trashing - please structure your PR in a way that code grows
incrementally instead adding then removing things

unless you really want to get first two commits via -net, and this
one as a feature
