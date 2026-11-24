Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66B5606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ukEJByFT;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EKO27zbw;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=e3IdggZ5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C20CC40636;
	Tue, 24 Nov 2026 13:36:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YhxEnXhPDn-H; Tue, 24 Nov 2026 13:36:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE99B4064A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795527416;
	b=e1jQYsc1paEGFYTCuZFMuyhEXIOzO/Fdl1o8ad2bPkYNnGZWUA22qrkcHLgMa53xHn/T
	 1S74wG0YGfFOY2Ofo1n4cDGZOB6NQi21sxJI22BBn3kgxsjd0fPUXJ3oTMpLev7SdnkWb
	 HNVJlie5qfnSQ+3920FelDKA2iBf447hEp5Ls2YfuEQ81f/ojbRrhqa/BXPgGaDzBKeK7
	 DTQiIagwD3X6pIDwX4u15XTSvpr1Y6JuL/A1YYtTAiFbIwJgh3b4trgsq+QLSePamJUTJ
	 W1/j52Qjzw98SpS4IDXL3PvTJKz+TrlmnnACes3wZChiG+RcCvw7ar3hQ0POGECYhJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795527416;
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
	bh=zh+rH8p2T7j36IQ3GY7bjJzGp0v8T381kEtpUgiiWbU=;
	b=G5o+D+DGVoFWGvDlJ5DK9ss5KFY/kWBxIDtCAWhCiYCvAgBilkKKqopxr+D3EYGilq+c
	 RnvQXpNs5J+uTNB834BjE4iKWjCA1i8sFqqWmtIcaUuIU74zWBne50qzkvF7rf4Sg0gNq
	 kDWSrrY+Zwq2PrHncpVqL2xcgjamwm1zx/pLd+BrRTlApr6KL/EOcNQ9oAXPGqpoqGnr6
	 RROkHIn2sWQ1H2LUY6vNxXgTTR6ROG3Lzs5LM2E/Kd+ZzydYBboe5aFQ5ZTQqNB9YC7vl
	 P/+5vr17lUu4coiHSWBrMt1MzbHI/GS+XhH1hPSkXK63NrARjsi5unvcPHFVYIONVYw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795527415;
	bh=zh+rH8p2T7j36IQ3GY7bjJzGp0v8T381kEtpUgiiWbU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ukEJByFTHDPcEJXiIa824mNzmiIMuSwroBN/6+9OSc78sCcVvEq3Q0vvmISc5ITjY
	 qU56ZatAwQO0GzPtcGKCgwS1PqJCev0hGimO4OP8Rosrsn+STR95uoVSHxTycjsXNX
	 h9KwMMe7qHeMKFeoD4ZCF8xKTYn/ikYBndVqDeQAMNkbYlCa0xqVQuIiE/MrlLC3Sg
	 BjWbOvux8ac6UYifEyy2Cq0HOdWw0QYVeHMd87rMCR9Mjx9Xywt5qHVDiJyU4oCxLq
	 YwThhHxEBMmRLjLos4g6jT3pfdJYxMn5ANcCLj8vKuOlb+fZqi72h3ZDztG3G06N6O
	 MW0/v+aQLRj8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE99B4064A;
	Tue, 24 Nov 2026 13:36:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 59916371
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 13:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B57580FA1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 13:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lrIjlE4szHLp for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 13:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E594F80F90
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EKO27zbw; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=e3IdggZ5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E594F80F90
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 13:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795527413; x=1827063413;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xTGgVEAqY3rfmo7gxsTzb7Ov3snTs7qNhdu1hAX4CPM=;
 b=EKO27zbwqKN8PGjTtjyyKg7WEBB3l6kRa3YKHRHrnL1bStI8ZzIEcmfZ
 qsfT/mPgrTVblfrxV26hdx12WZeJCjlD6hAALfx/QMLAwy3dHMaznDe1Q
 /NG6sK/XPv11ox6Gbif63xvBpW8z6xC5bR/GL2VLxakVKXs7XV2UjJ3mA
 cUHUVCxwpqEgelgU/uHVDSjt1gpuIhN4sh19X9aQsa+Dovm7P2UUC50cf
 VoBf2H1M0FFb+jvjK4XBlatKZp5L7x6cAtj1P6QqRd6/wU5Ib1Y4MCPlF
 6xintfS/Be/bQSnSvGhoh4xcaOCpBJkyiDsf/gBTBYKmRDFHUlJNWqyJE w==;
X-CSE-ConnectionGUID: r1g6kazjTkSo6CTscuCkJQ==
X-CSE-MsgGUID: G55XisuIR5CFnC7y/xKjZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4423623"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4423623"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 05:36:52 -0800
X-CSE-ConnectionGUID: u7FJsXRRTlOwe/bv9lS8bQ==
X-CSE-MsgGUID: bjdLW+KhSuiuDvd4VG9HDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="13253910"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 05:36:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 05:36:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 05:36:51 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 05:36:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh+rH8p2T7j36IQ3GY7bjJzGp0v8T381kEtpUgiiWbU=;
 b=e3IdggZ5drCF1gseAHJIsueKxdbgkvB0/caKCMJPpw9N8Swon6YMQL1iQYoEZqdeYkcT0+HcR4nQ4l1imGQhVQqZ9yOZw8xL1PWDQJac40MfvfASt4FFYfyEmslfOtOIZUv5XNWZNHe80+uVwtfe+XXQ6NYhF+WX2arvDlNUgrM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by MW4PR11MB6885.namprd11.prod.outlook.com (2603:10b6:303:21b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 13:36:46 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 13:36:46 +0000
Message-ID: <f2f4f1f1-4b54-43e0-8e86-a76c9ba1506f@intel.com>
Date: Tue, 24 Nov 2026 14:43:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] eth: intel: fix unintentional symmetric RSS
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski
 <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <ahmed.zaki@intel.com>,
 <jacob.e.keller@intel.com>, <intel-wired-lan@lists.osuosl.org>
References: <20261123205600.1794292-1-kuba@kernel.org>
 <a4e78445-d0b0-4347-85c3-acf0184ff66c@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <a4e78445-d0b0-4347-85c3-acf0184ff66c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR05CA0348.eurprd05.prod.outlook.com
 (2603:10a6:20b:490::18) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|MW4PR11MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7927c2-3c2d-4bee-96a3-08df4a2ffc18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261102123227099003|10067099003|11063799006|4143699003|261021123027099003|56012099006|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Kfq7A+jcQFZ6ApDsn3xwZPPjz6NJDofPpqpP5V4qNxK+cFAsSGnYFbPNFgXXAsSwpGXYz2Csg+Tl7nMbBjcDDbURg6tGl+4JWju4TvKbDsI+rNy+4nNtQrAybhdRKDSbUr9CjkVeEaHaV9B503GfHbIyA3lSItTKrXjEVSB/0ujYJ5vdSB4AG1uhjNhE7D4tC/RU+PYSVdKUEjJBTGqtKtsMsxlZav/3yFOkKXOFctCHAuB1Gx9LQc13Z2bNIpDMxiteX8cOtOj1JwEhuER8a7k4nm0I5bec/98qMNtcvbNbHF+WamMSsjy8/ZiioBNxZFPwS13HucO4qMkBTYhHzu63euccbf9oLghnV2hdgIFtQHI9AnpdNKPO0AyWk86lbGViIzsdttwzYqCVSpzw3GEKpHqGa6w7gGi2/p6BhHfVGC0laG6XdCHbJWzpRNs0Q0w824Tgv60v5yts9hdV0XrYL1EgyI8588L2AE83E7PDu+pwpEwoGaLT1u5ag/XS9UsIpvTD3wNZCbo7dpt7zMz2SgN4+xrKB3o8QL7OLl5xWmouV+SyeOyUFdzIx/GQo3n+YuauptsmGjQzBjC/MDnujK6wNQFvseoRJCtsHS2PPR+eiMftqIT4Kk4wto3t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261102123227099003)(10067099003)(11063799006)(4143699003)(261021123027099003)(56012099006)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnRpTFhjQlJSWktFRlJZSkFlYTlxWEVRclRxMnBLNndTQVdwc0xJajh0d0lM?=
 =?utf-8?B?TGxuVEJjRGlFMkptSThnd3VOVjhvVi9aVGNnOUR5eUtJbEZHNGVIcHQ0MnFq?=
 =?utf-8?B?Zm5EYU5kQ0QwcHQyWDFWQUhkR3lRQXVmVzZrd0lJZjZoV2p1dWxuTlUxK3Nl?=
 =?utf-8?B?eDhSQ0tETXlCR1NUVVcvVng4NEFJUTdoVldPeTgyUkdXZ3FwS0VlK0p3d3hO?=
 =?utf-8?B?bkczUXZvL3hPMk8wN09kV2FhYjhQeWNzZnlMWFhIUnA3RE1vZVhCNTc3M0dB?=
 =?utf-8?B?T25sTy8xTzcwS3JlQkNWQ0U5Sm1KdzBRYWVaeGQ3dEtrRTZMK2V5VVpMbjhN?=
 =?utf-8?B?WE90c2dRaW1GTWhVZFNjQUNIblpLVHVhYU1GTGpoaTRsUmtoTzM0VjdkenJ1?=
 =?utf-8?B?bmFpeVR4NVl1c0dldlM0TnhoUzREcjU2UVlMSjkzZGZ1V2lkNDVRNmdBU2Qw?=
 =?utf-8?B?S2RoZHB5UWJ4SUttaUgxOXZpdUYwRFJwd3p6SmFVTjRqOVJWRkJiZnJteGRR?=
 =?utf-8?B?ckxJQjJmRnNpLzkrS1ZqS0dJZmZRM2pldlFZUHJFZ3VWcTdGL2ovY0lJQ2dD?=
 =?utf-8?B?THpRRmN4bjJ6NzRnSjBKWlUzK0xLVVBPZmJSaklBOEx4VXFNODZNNE1XWEh0?=
 =?utf-8?B?SitmM2xuSGRWMzRobW9FSjEzWkdFdGg3eW9RUDY1dHgweXZQOTVZWTRNb0sr?=
 =?utf-8?B?d2ZxRmJXVTNrUjBIUkZHdWRVN2UzMCsyTDRiVnZCb2RwZTR6WlZjc0ErYktW?=
 =?utf-8?B?KzlTaktxOWtraFdFMUtCakRWOXhuUWF1VG1xVmxrY0JzY3dzVm1sd3V6Zi83?=
 =?utf-8?B?Ty9ud290QXJERXdhWnR0alliREhVeGxRSlFXRVVtN2VCMmtTdER6YTFhMk83?=
 =?utf-8?B?VjVLNVFlSjFWQzg5VERCWS9RM1dMNmw1MEpONWpvY0Vhb2g0OU9KcHZ1bUxN?=
 =?utf-8?B?K3FhSW1adE4wSndLTXVXeGNHWU0rUDhWRVRhb2h3eHhEdENNaGQ4ZTBrU1RQ?=
 =?utf-8?B?VUlIeTlWUWRReUU3YjF1Wi8waDJydEV3QTRQelhCSEhFVXpCNy90dTBodXNh?=
 =?utf-8?B?Z2VCdEVnYUNmcER3L2RiWWVleHZ3MHJYY2xoUUtRdnVtVjI4OFkrRXo5Z0Nu?=
 =?utf-8?B?bUUrTzc2b2RtZEFjUlNGZ0VBY0ZVSy9oR1FEd2gwbjFYRE1JOWJqUGtXWGk5?=
 =?utf-8?B?MVozZjNZY1VlYzE2OEh0T3VXN2JRcFMvV0JjTWZLWUxWUEZmc3lxWFowWUpy?=
 =?utf-8?B?cCs1dnlqQ28yQUFrMStaakNySkRYL05zditVRkc1ZWppcmREL2puNmQ2VmJs?=
 =?utf-8?B?RVIrOXM5NWJGVFVwLzNIaGpSNUpURVA5QkhrOEpmdEQwQzBrSWxtWk5VR2VI?=
 =?utf-8?B?MURtSlpqY1k3aUZQKytiOExLMGI1Tzhtc0xMMFVhS3lyR1AwV01Id3ltdGFM?=
 =?utf-8?B?RHM3cDZtbFp6RTluYnJBWVI0bU9NbjJRTEI1SVcwQkVkbzBRcndPRmVVN2Vv?=
 =?utf-8?B?WHFpZWRIMzRmanhrYy9CSW4xSEtXbE5FL1J1TThFT25uaVNyTDgvTTNpWUVK?=
 =?utf-8?B?TGVra0FOZHJZU25oK05FR3ZRWTFpTnJsQUJBOUlWb2hFUEJWU3pQalMvTVRx?=
 =?utf-8?B?dHh6S0lValEyblJ3eEpwTGRQZ3RubGZmdk1YcEVWRVAyOTRUTkRBRHBYOEdU?=
 =?utf-8?B?ODkva2hQVWJQQjMwa0ZtU3V5U2pHbWkwTGhIa2h2Zm5TZzZrL0p6bWZGYkhw?=
 =?utf-8?B?TFdGdEVoTjRzb0VDeXZiVjZIclJxUTcvWEs1blE3Zkt5SXdFaHA1dDBCNmpa?=
 =?utf-8?B?UFgzVlQ4c1g3ZUtKZXpqaGx3WVE4Ym1UUkhOWm9Sajk5MTN4TGh3aHpqSmNR?=
 =?utf-8?B?a3FzK0hHQzRpNmcxTkY4UEdnUnR0Sjkrb3JQbTh6RHNXRW1rd1BFV3BPb2Rs?=
 =?utf-8?B?bDBTY29pRmpidW5VQW1QWEhqMkp2NnJIRnJuWnBlcU5kdzQwdGJGU3M2SURO?=
 =?utf-8?B?SVk5VFZKdWlOb1lHR25mZXptL0E5N3ZWb2FhSW9TbU1hU05qY241ajE1b1gy?=
 =?utf-8?B?ZVZXRi9WYnNkSmIxSElTemdhdE1RbDJzbW5BeFIxZk1CRG5xN0lyUmlQV0Zp?=
 =?utf-8?B?NUNuMWl4d3pJeTBzcFN4V3VpcUZUVGlHdHNiZU80S2VVRDdPUHlXMnlQK1pZ?=
 =?utf-8?B?QnAvdmVDSzducUFKUzhlc3VyWFdtbjE5ZzViV0ttamhQdUZzNHh4S0xQNnlV?=
 =?utf-8?B?eTZDc1FxczZHQkljNHVEMEpwVXNKdlNtWlNtSXRxVTUrZlA1STN0MjgzYTlL?=
 =?utf-8?B?ZnB1N2ZtOWNiU29jZ1I2ZUsyK1ZCUUJyeTIzRUJDdXFxQzI1ZTF6Ym1Ld29C?=
 =?utf-8?Q?tZwuZsMEPtgQ2s7A=3D?=
X-Exchange-RoutingPolicyChecked: dqwbJ+Bgsdx2jMQqiCSXNz6tAS4itwgb3fH2P/JuRAakLKk/xNwhI1KHaers9a8zg9L4UFk7K6ZvHtvb6QEaoLxXa4P3Kxx1r5ZILxrAck1x6z6N2oYUZGC1AecTUTPcKefg9FK5GAo8FO6NkYhwz+d4O5+iluuu2oAn7/+q0w+K7ktcqCJq0ouUGdtA7whyLprWFBZfIhMJAxop7gCaz/DZk3d/WrI5mqOEWeF05G8bCmUM2Yo4fdHT4Cc1274Qkyq49ZAaaK1f1zSFzLtF0UNXaCU7QOmX58axUfcQ2xfq3OxtGSHPw4DtDLzxHGE45o/BNSXA4i5jzIGd5fC9RA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7927c2-3c2d-4bee-96a3-08df4a2ffc18
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:36:46.6187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VwGBkAY3KUZkwgXye1Zi9RHkmTO0i8MuyMTErHZXhjvBowp+M3CSQeqv5bKhsPSEP0DxvjhafR9fv3jYmCXiSGlVxpjyDT71GdLTFlyaAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6885
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

On 11/23/26 11:46 PM, Tony Nguyen wrote:
> 
> 
> On 11/23/2026 12:55 PM, Jakub Kicinski wrote:
>> Fix Intel drivers not handling RXH_XFRM_NO_CHANGE.
>>
>> I had an urge to "fix this in the core" and hide RXH_XFRM_NO_CHANGE
>> from the drivers, by fetching the current config instead.
>> But "NO_CHANGE" values are already part of the driver facing API
>> (hfunc has ETH_RSS_HASH_NO_CHANGE). Besides we can't _completely_
>> hide RXH_XFRM_NO_CHANGE from the drivers, since we want the drivers
>> to be able to populate the defaults for new RSS contexts.
>> We need a "user didn't say" value there.
>>
>> ---
>>
>> Matt pointed out that the upcoming RSS sizing series breaks
>> NIPA tests, this is because the fix we shared in June:
>>    https://lore.kernel.org/20260626152636.1e48330f@kernel.org
>> or Maciej's version:
>>    https://lore.kernel.org/20261007200311.730443-1- 
>> maciej.fijalkowski@intel.com
>> is still not upstream!?
>>
>> Recent discussions suggest that Intel maintainers may be willing
>> to ack patches on netdev directly. Let's put that to tests.
>>
>> Note that I think this is a major bug likely to bother real
>> users so I'm targetting net. Przemek's series will have to
>> wait for net->net-next merge.

will do

> 
> For the series:
> 
> Acked-by: Tony Nguyen <anthony.l.nguyen@intel.com>

works for me too


> 
>> Jakub Kicinski (2):
>>    ice: don't unintentionally switch to symmetric RSS hash
>>    iavf: don't unintentionally switch to symmetric RSS hash
>>
>>   drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 3 ++-
>>   drivers/net/ethernet/intel/ice/ice_ethtool.c   | 9 ++++++---
>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>
> 

