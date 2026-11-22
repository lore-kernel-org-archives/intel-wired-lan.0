Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C729606A320
	for <intel-wired-lan@archiver.kernel.org>; Sun, 22 Nov 2026 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=FLm3I0Sy;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oKh1IAMG;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=m8ltRD3S
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14EF240647;
	Sun, 22 Nov 2026 12:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RpHbpoZycddN; Sun, 22 Nov 2026 12:44:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 75CDC4065D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795351441;
	b=QxGcGfd3ZDu9uK4ViTPem2DZCC90vBS7fTTNeOgA1wxuBsJcAUa5kk/ttcUzUZHsCNO6
	 5xeU2Mze3NirM0gAb+DWLYccuVKtVbujx2DBwzO0GLSH1siQTytktBB4jjHbKx1dK52ds
	 QakiMk0/Mt9oRYy2YlG+/mJEvE4Gre9HcFpQ9w2CU8FPeWtiwVF7RDdtT32Uq3K2YKSDZ
	 oKw8DTGpb0nooDjCjkXBNcu8v3yv9oxhMulB00nIDTwe8QgmgyGZBkSfgPm5XvH8UGI9y
	 ag8hwHr1z74u9RfL1ONFICuCWaMDTzboOKm63oDZ0WIl6XQMcUNJCs6Y+yM6GUo+lNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795351441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
	 Content-Language:From:Organization:In-Reply-To:Content-Type:
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
	bh=kdRdAESQcxEuNI7FUpar8PTLRlR+L8Vh0F27MOf1Mjw=;
	b=FxKvDDNp/ERiBLnxPEFG/hyC5GcpdPl20w9bjz36rt6j/2Xe3NorpOOKsAHk3TjbkA22
	 BV++TPwjo14z2qbPQxmQI/VSDcnzUqUcdNh7cpUx1k2fIivC1Xj8V65sNgPaku9tXH2aR
	 0ws6S2ARn2b8k/rIHlsT/wlpqHH4wK+R0AzXdiq4Iao0rYIoyfO2Qh4cQT2FFQbnyfetx
	 BEktaM118wUkoqh7V4rx/AoKhYe5zzsqxyk7kqGvNH1OBUd5eNO3qTtQxrrTJatnw5Yaw
	 xeO/LJxGFWRKtY4RQnpXHGlAnnLKjJqOhTciyw4Zh+wDlJGsPJhhR4ApiZd81XtN1kA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oKh1IAMG;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=m8ltRD3S;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795351441;
	bh=kdRdAESQcxEuNI7FUpar8PTLRlR+L8Vh0F27MOf1Mjw=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FLm3I0SycLe6IJbpABlWyQMvPxWXxFTTOTdkQXXJgfyQZcz9O3HR7Ym2w6MF5oEzp
	 eoa/jglejqx+9tUg/2x5TgoPs8HxnLFHrV38YAXPz7CDSp1QKNitlOaX6LaZJel+Hb
	 1/DGxjHnHN20tXtYkvKA5FwsW3gr4BMCoegj4CXdUgzVr7CuqrxaYAYaNfD1Ucxu6Y
	 qBiwsy5+7ug/TBWNTPoZVePp4WcHrJPx8aETNmtL97qO3O0rvwd4HSMJ6iRyIJA7KD
	 wK/6cqpAqyq2hquiDYm4hbRxItThq8PZiwBwXMsXAsYm0gKgcoPCZDkqWgnJGkAR5W
	 kLUOX3QLe5CFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75CDC4065D;
	Sun, 22 Nov 2026 12:44:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2321465
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 12:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF6914065D
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 12:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v0uF5GBLY53g for <intel-wired-lan@lists.osuosl.org>;
 Sun, 22 Nov 2026 12:44:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F0C8140647
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=michalx.cohen@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=oKh1IAMG; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=m8ltRD3S
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F0C8140647
 for <intel-wired-lan@osuosl.org>; Sun, 22 Nov 2026 12:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795351440; x=1826887440;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=QJzNo+Nda55ptX0X9LTjcYKgubwx9uG5TQGP6FQdoDM=;
 b=oKh1IAMGmfcck94DX15R2d2v8wkVDpACdXWcJ7AkPLsGF+gN9v/ssX2m
 wlcS6zrQ/TSi/cd4kz6A5v1bPAE69zi5N0yBCOBC+ztK3HC0JnUMTiPpZ
 g53Tzd5XXWkaKGgGl29GVnqbBogi3UsEgraoxFLg0JB9L3Txpxxzpzmdj
 Mp7gKdE37oMeW8UqeZppvcCiJaBqvBb11K7Y54z2MBwlBLOmnChfqRf0n
 ByXo5pJmNBP0bnp9suU2DSoKuJK9wh9CbcozxtLmzXu5VLjvJQMJJlYEL
 ts5X2NCcCPkxul0cwAR2M1CJ0HrKv+fd8tu06iKREbFh1M62qUfdvmWin A==;
X-CSE-ConnectionGUID: Qa1CWbjaRxaZXhK9D41VPg==
X-CSE-MsgGUID: 4BjhoRAUSX+s3UZC9wuNjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4256240"
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="4256240"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 04:43:59 -0800
X-CSE-ConnectionGUID: EDAUNh7dQzWPSWflwIZ3iw==
X-CSE-MsgGUID: vO/MF8fISx+K6UfrJMxUOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; d="scan'208";a="11282325"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 04:43:58 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 04:43:58 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 22 Nov 2026 04:43:58 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 04:43:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdRdAESQcxEuNI7FUpar8PTLRlR+L8Vh0F27MOf1Mjw=;
 b=m8ltRD3SsYSVUpp2yuOemk7jBrmpv40sxKMBZrIvNEJjzEQdE1iYd7oCStpnIWEFpY8f3NzFV0sD1dcrFvF8HEpeuDuz5GVooIf9BaLeT3DsSPyu/NWjyVUL9EARjHVaq2gloO92n7GtJP/wcYVkuUvcpCQPrwoszwdsN1zqFLA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5520.namprd11.prod.outlook.com (2603:10b6:5:39f::20)
 by SA3PR11MB984244.namprd11.prod.outlook.com (2603:10b6:806:530::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sun, 22 Nov
 2026 12:43:51 +0000
Received: from DM4PR11MB5520.namprd11.prod.outlook.com
 ([fe80::75b2:c8b1:10eb:2ed1]) by DM4PR11MB5520.namprd11.prod.outlook.com
 ([fe80::75b2:c8b1:10eb:2ed1%6]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 12:43:51 +0000
Message-ID: <63ecaa42-553d-4458-95b3-8845e54a03e1@intel.com>
Date: Sun, 22 Nov 2026 14:43:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next, v1] igc: Group frame size macros in igc_tsn.h
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Sasha Neftin
 <sashaneftin@gmail.com>, "intel-wired-lan@osuosl.org"
 <intel-wired-lan@osuosl.org>
References: <20260925101209.34832-1-sashaneftin@gmail.com>
 <IA3PR11MB8986EDA537B7DFB4EA91E5A4E5802@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Cohen, MichalX" <michalx.cohen@intel.com>
Organization: Intel Corporation
In-Reply-To: <IA3PR11MB8986EDA537B7DFB4EA91E5A4E5802@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To DM4PR11MB5520.namprd11.prod.outlook.com
 (2603:10b6:5:39f::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5520:EE_|SA3PR11MB984244:EE_
X-MS-Office365-Filtering-Correlation-Id: b21b692c-9ef1-40b7-1f15-08df48964299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261021123027099003|261009223027099003|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: ETJGDUo4JxouswEZFl9WIGOQKzyOiuTm8gpwkS62LdfjLl8tk7rDaErbGck3nuNod82CagqyJm3Fbpv8sAMyow0cKyxg2+dojXxQaCUgx8zDmBiz5klGYj9hoH67z9EBuYsrwVJ4hr8yhN1RsCm2SWrP8hWpik5lMXPdMeFv1Y847av0Tcqmm8Kp1TkOsUWZ47Y35cQmdeAoOM8DS8Bh3KyG6ob/qDJzLtubF+KjMVklSReLKXRP8q7HN/8cGlbJ6IZu3A2uE5Xnx3m46JIjsbMbv1Mo+Sy268YjlSQSS20cvzGZEz8syiUylKvSTF5uBhbTGObqtrpHM3rxW5xAd1bkw2y717VtXQ1xG0S+0LvJ+EvzlVzmXaledJoXTEoR+RuRvY3ofVJOTQR63klonFpxVozED2PObrJILQYa/1gkmaCZ/RwuerJg/D/4nrjvGcbP8mjTieEoGUgcsqAd1kwyBapmAlZk1SNbvVaBGCjLVLAdUGUWyI1Hkg7XGPnQm6FKI9RECveNrMZ5uK5btGWuR2gB/xRQwgdEOHluvNQ9wtCnETDW7Dz4ZXu8dOWzKWEro7KfdaStMyRi7fkQCldJd3VxilOvZt40J1bGvOvEDoWu9j/uWpcfWAnC7A2YGQa6+43Zy8oPPQ67+kOKfYG0CbL1yhQLzsMZVpPvkbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5520.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021123027099003)(261009223027099003)(261102123227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXlobG1kTURRWTgvU3V1UFd6am9VMmNHQTdRTVhVczh4dnZZanY1ajJhVnVO?=
 =?utf-8?B?cjBtaDljcnR0TVMrMk1oZlUwQy95SEthaGpYT1grVU44QWo1ZUpSamE1U045?=
 =?utf-8?B?QW4yZVJ4WUZZdzRyak51ZXAzU2R1dkkxVTd0YmFBc3NNc0xTMlpRZEw5N0xw?=
 =?utf-8?B?UTRodXVlTkxId3VDN3FCUm9RZXZNdnpNQkhoMVVqTytRNWpFalpyZ1dJSDFl?=
 =?utf-8?B?TGFXQ2RyRklwMVFEU25QQmVicHBtUnZCM1FhbmMvTkNmV0dXNG5oR3lkNnF5?=
 =?utf-8?B?NGFNdjVoOGE4dzVyMmE5THhUZEw2S3k2SUNwZGhTdVVORlRySUREbExmMzd3?=
 =?utf-8?B?RzdhZ2g0ZEhrUW91WE1LR3Z4aHU4VGxnWitxV2oxK2UrWFIrM05tVVdySGdx?=
 =?utf-8?B?SVBETVBzK3dCQmJVTzBqbEp1QzBiV3d6QWptUEpDUVNFVFFzcldkeXBkRE1x?=
 =?utf-8?B?Y0ZnQ2laL295TytMQUNjRFBhMjR4TWw5UHA3aHZyVWpWRml0clhlNmNyelpH?=
 =?utf-8?B?WmFGTTZ4eEdobzFRZStrTnNRd2JOM1U1bmlCK0g0Vk9CVnl6TFBjckxzaEYw?=
 =?utf-8?B?cG56RmY4U0NNRHoyR3FGY3phTGxjc0gzdmlsSFhVbVIwOFBKdzhrNVRZYmFD?=
 =?utf-8?B?S1EyakRZcWxHb2wvQUk0VGxXMGYyVWxuaXVsRmd3N2lwbnlWOXBUVStQRjFy?=
 =?utf-8?B?OTFJaCtUeDdHM0ZjREgxekFPLzBhWWlPcDMwNlQrK0tSN1g5WFRuVGZFcDZP?=
 =?utf-8?B?dmtKVTI5aFhON2xVOWZmcjNoZDZCa3h2Tm5kekFMV2d6U1N6eWdORUhZdThM?=
 =?utf-8?B?MTlnZ2hTSnpOcWVQSEtmN2ZhNjBJUmFpeEw0QnNpSWZwQzFrMzJJeFVnZ2po?=
 =?utf-8?B?ejhkTVpPamx1STY4S01XeUE5ZncrZU5ybjJTQmprU3FuaHRUOWxwdEJtMENi?=
 =?utf-8?B?SWxMRlNQMEk3Z3JvVXFhSjllUmdkUHVmR29odnA0WDZPTHdDQStYekRaVUk3?=
 =?utf-8?B?ejR4cHptQ2xCQnBkaXFpY0p5c1l3dDhhdTd2OEs4QzcyWmhsS3ZObGRiWElP?=
 =?utf-8?B?Q2wzeWQwMGQ0dlFYVG1TaEhSbmtXYjg1UTFGYStSbnU0dmFGeWgyOFJHOVgr?=
 =?utf-8?B?QjNzMUtXK21HL0JndXBwSGNaQ2drZU1RWFhYU2lremRDL2lneEYxdHZ3Mk1T?=
 =?utf-8?B?TGRzdWRIVFlRVi9sMEJCQjJPaGsva1o0Tzlab1RNUWVURUs5dFhyWExWMEdP?=
 =?utf-8?B?Yk9xaldZb0RaSHJqTi9QSTA0YWVWcUUyRFFJakJpOFczcE96YS9oNEp3TGJu?=
 =?utf-8?B?S3lLWHg5eTFCTlp5WkVJT3M4VXVUcnI1eGpDOFgrM0NFUlpDR2RVZGNpWEQr?=
 =?utf-8?B?c0k0Qno0TDBjeWJRVkp0SjNHRjA2ZEY0Y1ZRQThMYlJUZEtlUVNONjBUKzlS?=
 =?utf-8?B?ZUVPdlR4QjBJbE93dUltMkV0SWJQaWcybEpBUHMxT3RtczJqLy92WnpWM05w?=
 =?utf-8?B?MWdJVXJpb0Qvbk9vdEdGNW1qdExNbFZjejQ1OXVpNEdlcWxqSEplYWJQZnJ3?=
 =?utf-8?B?L2l0cG16djBoRjdiTEVJRWNoR1orZVJHNlFaSHhsNC8rK3VORWt6eU1wcXd2?=
 =?utf-8?B?TFB4QUFoc1ZrOERrSHZtOCtUUHFwZEc1azJhSHFiQm1DZDFlWkdxQWhCZTZL?=
 =?utf-8?B?b2V3R3V1UkcrSE9FcHdYeXpOU1ZWMFFXS2tZU1I0RkZnaDF4VlJ6bXNWdHp0?=
 =?utf-8?B?enVQSWxoaURpanZtblFxdU95NkIzN3pwNWtUMXQyb1Y2aVZZckZoeDRiYXFv?=
 =?utf-8?B?TG84dUpiZThHckZhTXE2RitDeDEraDdBNURBMWxPSXE2Q1phd1pQR3JvVmZt?=
 =?utf-8?B?UGZhamRxSVNJOXdnbitlSGFNcENNM0t2R3ZXUDJ4Wk5aMmJHZGVSTUNiZXNT?=
 =?utf-8?B?eXhVeXdLaG4yWnA1RlhXU2VsS3lJSm40YVhveUVYemVOR01ScENMeGl4OW1h?=
 =?utf-8?B?ajFzUG1POG96MitCOUs3aFZGWnV0K3FnY2QrTGdvbStOVXpCRDBCbitVNXlr?=
 =?utf-8?B?bVo2dm9NTmxaaEhsUUhFcmVSOHRFRHhoa2JXY1ZNV2FRSk5pU2IwcUpWZ3N0?=
 =?utf-8?B?RWlsMWtiOVpqcDFlQVl5c3duU1VPR2dOY0dEN2JrZXR0eVpNbE0yb0dEd0Q4?=
 =?utf-8?B?cFNERE42d0gxb3BKSFhNZ053U2JHclRkOEp1VmNlR3oxQzFqVWR0djY4d2dM?=
 =?utf-8?B?TmtVdFgrQ2hUM0d1TEJpdEtWSG02b2NFU3FHTjlOVlFJTEFnekQ1VllPTkZl?=
 =?utf-8?B?N3VoaE93NGFEclVyZ1B6bEpYYlZSbEVEbTRURmo5T1ZtaEVtREl3dz09?=
X-Exchange-RoutingPolicyChecked: A4R80LdpRRtttuBBwajLK5tzpC56zUWtFHk8XLKLYnQCmCvgRzZgXkskJHgJfTGZS6Bpcjdij10DTF+hHjMHBhe01I5qUtG6qMzu8x/Jflc7QibRiXvmaL9DPjDV/ctodrHag6WMdbc1dXqaXtsRJHMxtFMX9w1f6LP2IlpzJR+gOiRiDIqtjgxldfx6qbwzMavNLU7SsriCAGnlJZGPsvd2q2LQP0GXFet/pAmJDuPRhKt/j5tT8kOlaXZgaGZ58MqDp1/4BkTPKfeEFnaNRmEVykOFdK+zCwb8x9nGAYLNNAo/g0Ev3ybtpLQsVKVfpWUphOsFvvxP2H4d4RvFdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b21b692c-9ef1-40b7-1f15-08df48964299
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5520.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 12:43:51.1989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iKcjEV3WhuYhupMNJb0azTKQgL8dXgyjAjGCy41ifP0uADjAUHQk4USA7SKJB+wsy+7kX0SHKy78ty8sObo6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB984244
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 25/09/2026 13:27, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Sasha Neftin <sashaneftin@gmail.com>
>> Sent: Friday, September 25, 2026 12:12 PM
>> To: intel-wired-lan@osuosl.org
>> Subject: [iwl-next, v1] igc: Group frame size macros in igc_tsn.h
>>
>> Move the IGC_EMPTY_FRAME_SIZE definition from igc_main.c to igc_tsn.h.
>> This consolidates frame-size definitions for TSN and frame context
>> descriptors into a single header alongside IGC_RX_MIN_FRAG_SIZE and
>> SMD_FRAME_SIZE, making the constants available across TSN modules.
>>
>> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_main.c | 2 --
>> drivers/net/ethernet/intel/igc/igc_tsn.h  | 1 +
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 1fb5f3cbe93c..b0a4c2893ccb 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -1137,8 +1137,6 @@ static void igc_init_tx_empty_descriptor(struct
>> igc_ring *ring,
>>   		ring->next_to_use = 0;
>>   }
>>
>> -#define IGC_EMPTY_FRAME_SIZE 60
>> -
>>   static void igc_tx_ctxtdesc(struct igc_ring *tx_ring,
>>   			    __le32 launch_time, bool first_flag,
>>   			    u32 vlan_macip_lens, u32 type_tucmd, diff --
>> git a/drivers/net/ethernet/intel/igc/igc_tsn.h
>> b/drivers/net/ethernet/intel/igc/igc_tsn.h
>> index a95b893459d7..e08f48543d99 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_tsn.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
>> @@ -8,6 +8,7 @@
>>
>>   #define IGC_RX_MIN_FRAG_SIZE		60
>>   #define SMD_FRAME_SIZE			60
>> +#define IGC_EMPTY_FRAME_SIZE		60
>>
>>   enum igc_txd_popts_type {
>>   	SMD_V = 0x01,
>> --
>> 2.43.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Michal Cohen <michalx.cohen@intel.com>

