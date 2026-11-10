Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246C606A33A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hLhA7z3I;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJguvN0j
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4153E60847;
	Tue, 10 Nov 2026 15:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uyb5PYolHGQp; Tue, 10 Nov 2026 15:14:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 617126084E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794323691;
	b=oD18Do41gG36pxmsP99on72LvFuwBcyPwJew77UUseGbZYuy+XmdqCX0YIEO1Nt1MVwg
	 WMNJt/9kqvxWqa5ydm1Bz+VUJn8nYjYW3nagsh1jHPJvcjE/g6jGgC3FCZ4BpwkRS0doM
	 UBFaQc9oXcy/8ISFewquWTqDV3vdWhuCK2Hv0lbmLekzuBYHF3i9WTGz8afj7pGz/9CCC
	 CJ+BPhczE9j4DcI9HuMsfbEKPe2jDBIlFDMNCN7qJn6PXFg6DZUCDtwszDlyowdsKaTRa
	 xwDu0PxoxC8J5Gu8n9ZhsSP5E+kTRqKDRXk8UlmVITk9kOAiuo/Quo2wZ7ksXlVpcDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794323691;
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
	bh=TMQpbWXRMXvMDMJ+QMM/RAAdpW1HCOkEavEIrrS7hZ8=;
	b=SZqI1qzkQuuKrY44XU4+gOnUspBH5f+3gaENmtubWL6GkTVXzIFmRcsr+8GMtBRLHpJK
	 vxLkZb1D1UaKPnBAwL86ak32lltrDlxKFHh9Asg3FoRHJl9y1IyYYzfHtIEy5vsrvnbuv
	 O4gM/YoXNpI5wsUYAcrsvbnVPyN8oe7EBgNXrq6FMR7U1xtyR3OhR6Adh/S6NSDVFmz4m
	 4yixlbp1WaaB+ybsCL6e2621mlIxnIRtwMmHxrwrzXM3sOL2WfaGjIkzzTCtypBND0clZ
	 hKKbjy38CJh5iFVuz945GzY1HMi42gYyEOxgewBEYysLPLOFLoi1iBFL6iA4mraZuMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794323691;
	bh=TMQpbWXRMXvMDMJ+QMM/RAAdpW1HCOkEavEIrrS7hZ8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hLhA7z3Ik9Z1HnGds3nMoymnqsMRO17Y3JXpEdAfaMoHAkf6qTmpw0ECMLdoRAOgy
	 uh3nqOp//tm6NMAag9ZmAn6/Z8+f3J4dpHC/yZYPxIh/rYirqWLcnfKwwoeFs3VdMQ
	 C7+a4mLpZANXUrUdBz/yT3cTb7517DAobm705jJb6uaAAS3a+fGpapjqgEiJ+kLv7c
	 buLY27sncKIhjFXlKcNH+O+D735prDfFYcpnxiiO9TWOYnH2ONlvZs+I05H/yK4eL7
	 ZOaZZAwj0QqNF7rJsM4Kj24FN2f3Vxn1H9qYdcOrwF3aF1vyguUz27j8IYrYe9+zJ1
	 J4M6xIXfQPiNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 617126084E;
	Tue, 10 Nov 2026 15:14:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E75591FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 15:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D89AC8121D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 15:14:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eWO2ftoPCSbX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 15:14:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B897F81202
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eJguvN0j
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B897F81202
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794323689; x=1825859689;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AJvuzfsogg/vm9OBwFqRHyUMhF2t2Cyi7alQUsc0tag=;
 b=eJguvN0jvLPoknw2bouKPbf3tECH9CzQ6++rPzoyF1MqOfeK4M81KyLJ
 an9D/S+Ut0nHPbFbqdFBkS5H2uxBIqpednGnuu4ALMjYlHbfPKqObiFjw
 U+yx1tTJ6pcdgky1XAn+LNXjl4Cdp3wc8ciyZJwADrhk5cAF4HEbWz7zs
 COdiFAnXXPFjG+X+fn9x8CcJN3fk/XmvNcJeZwiaQFrwm8vvKhlsrlyej
 +nCdZ5hBcuTYSX6VTxLp52+6lmUnMkdqbV6vmh7nnA2L9uZZOPYUePEg4
 k4B/FY6E2jEYaSK+unvAjv+3tPtetLy8K4thL3Z9k4HlEOBvz6LrEm6pu A==;
X-CSE-ConnectionGUID: +8znSTDBRD+IL2J2QjsARA==
X-CSE-MsgGUID: r4RDD2kURiqFDpaRMP2RkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2961319"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2961319"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 07:14:47 -0800
X-CSE-ConnectionGUID: 13A8pPafS6S6IxlqoSLKKQ==
X-CSE-MsgGUID: bHAY97L6S7qWaaiDLKu4pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8195771"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 07:14:47 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 07:14:46 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 07:14:46 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 07:14:45 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB9722.namprd11.prod.outlook.com (2603:10b6:510:3a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:14:43 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0592.009; Tue, 10 Nov 2026
 15:14:42 +0000
Message-ID: <3d14c32a-62cc-40cb-bd60-2dc13b9a2e41@intel.com>
Date: Tue, 10 Nov 2026 16:14:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 0/2] libeth, idpf: use GFP_KERNEL for the
 initial Rx ring fill
To: Luigi Rizzo <lrizzo@google.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Luigi Rizzo
 <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, Joshua Hay
 <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261103162326.3615979-1-lrizzo@google.com>
 <1cfe950e-50af-4120-87c8-375f67eb3e01@intel.com>
 <CAMOZA0KTYjRGuD3axNKaNb-o5=c8Zt=zG4Q3JFxPbWuBVu5MKg@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAMOZA0KTYjRGuD3axNKaNb-o5=c8Zt=zG4Q3JFxPbWuBVu5MKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB9722:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b06ff0f-7fc4-4155-912e-08df3f3d5845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|261026121527099003|261028144727099003|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 37o/CD21WQWsiT2D072o20hXWHde3d57EQRveVbdPd8baCO9KYUeYeMEzYJMzLV/2F/GGox+vNhJRjIwHrLo5B0Lgyw/nAmi7EirsncZ/BWs0G2+eByLcJOJRhD57c3D8FM7nt2MWD9/4uJpNNccI37JDzE6ju3tq1AzYZ5MJfR9uJqHuQ5QoWMc9anQVYgAKlvhhaH8p+P7wyk7zcZrH9UiU/vN1HzKL6QgwN10ZGiKNWSc6FteNxxvep4sKBZoU4b5JA1su3TqMFx9gofuEfzXlDCO59ppCDCSE/vbeOZjbMx410SP+xPRma5bet4TzCoBl3PWYNSAoKb1Hg1TlLQiXmcFcHR9R05AGjZSw6RWeum0z/ijNVRMg3fD7qItT4N+NtossJ6Lj+5MClqbO/ItHCXNvQBbfS5PmIdIa0gcNJjrk0Cvz+s/SfNlh5/Ytt5yM/A9L/Gzi8bPnNlNGY4Qgp4JL7d/ejLkzI6YH0+w3NOItV5gZckx7WgzsnzNqDuML3430xRQp+4eMM3H47Nqwl9Qy3m4fP0WUABHWBqIkjkpZG2zU6pYj6pULRM2Qq4P6DDsiUeGGGKKnNWvONQV4RdSABknRURVhsM7YD8qpnwVG5t9lrXMiXxXcr44
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(261026121527099003)(261028144727099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3pZSGhGQmtGYWhiQ0w4ZWtKMzQwbzhzYXNGWFQ5UHBZcWNaNHU5YjQ3V1NK?=
 =?utf-8?B?a3BoVlJzZ094VGdLK0RzMG9oTmltVzdCRTZJU09RNzBHV1BTMFZkNXZLK2do?=
 =?utf-8?B?N3h6M1VvYUlMdSs1WjF4UVJER1g2VU1JdEZLN0NQL0IraTFVVWVpemRnN0tH?=
 =?utf-8?B?QkhSR2NSckZ0SCtrM1gwZUpkY00wYUdMUlJzU0FYMFFuNkVyZ0ttRU52ZG5x?=
 =?utf-8?B?L25nb1RvVEZvZmEwVS9NZ3cxWUwvcndBcmNlWnYyY3FleFlBNXRTdnFmQVBk?=
 =?utf-8?B?Qkg2VlRta2xRRWExTkM1dldPUXVXMHRpclVFSVFhazZsY2IzTWs5MEJOb3NU?=
 =?utf-8?B?RlJpQTUwYnl0UEhpdk04R1MwZHdqOUFKWk9nYXdCTzVZdS9aZ0FjZy9oUjJL?=
 =?utf-8?B?NkQ3Q2FVS3kvd2JHTlhkZGhoMURJWDl6aUlyRXVYVFJXblJIS3VkOTJWZmRI?=
 =?utf-8?B?b05MZEpjZTAvTUkrRnFFdVhxQ3dEYnlDVDhLY2hjZUU4MWhQODFIL1J5eHdP?=
 =?utf-8?B?VVF5YnlGZDVrTWdCcitxSitRZVdET2tWb1g0ZUZSZDFQeXJLQWZaTnZuK1A2?=
 =?utf-8?B?VUpSRWJweENKVWxUQkxzZUtkbGxJdWRsbE1Cd2hvdHN4Q1l0YmhNNGdSdnZY?=
 =?utf-8?B?emFKS3dnemR6VkNseWtTR2hHeXRSOVcwejB3blh6SkZGZDUzNFl4VDg5MVhH?=
 =?utf-8?B?bkVrSDRXSFA2Sm1MYzNSemNtbHlicHNQRVVTRVdJSE9RK1lFWktNZVFPMEtv?=
 =?utf-8?B?d2hGZmRvTUNDUkUrSGd4RDZ6WFNESi9ndjIzSWE3YTFSQUc0Qm5KWWxidzdT?=
 =?utf-8?B?OFJmRi9URG0yU0F3bTFiSzVDRGdwUWt0bHhteWhSamc1N1EwdWlMUEw3RmJQ?=
 =?utf-8?B?ZDRHaFUvRnFLa0VaME5UK1VrOEN5ZVhFYWxNSlBpYitydXJiKzdGNG84SURt?=
 =?utf-8?B?NHV4ZjlHdDRzVm0zWEZ3SVNVRTl1Ry9RS3BLV2xYUVpIK2hEZDlsckFhYm14?=
 =?utf-8?B?UFErMXBRYXRuU2R5OGFIRElzQ0hpK01XTTJYRG9EWnZkM1BuYS8zNTBmOEdT?=
 =?utf-8?B?R1FRSlZFeTdBbVUwbFcyRG90Qmd1RnJxcnJQMlZISDFHdVpDNUhSSUIvSlRH?=
 =?utf-8?B?NWZOKzdOKzZzZVR1dlBzd1NlNnptdmFHU2pBRDN4RkE2ajBVWlA0UDVHcVFZ?=
 =?utf-8?B?bzBMVmx3NE8xWmJ2czVJYWdtWUYzbWdQaUJtTkVvTldGRVVwL29XUU95enRu?=
 =?utf-8?B?Smd0blN5dXowajdTRGJVeEhCeGtQZkViT1hZZ2laaWxYUDQzUFVGRm5VVEJq?=
 =?utf-8?B?dU5qR2dha3dzRHluWGpZek9ZbnZTUDg2a0tmSGExUnljNEhuUVJ5dkY2WWFO?=
 =?utf-8?B?NEptZ1lWVEZrQkZJYUNBU1FJK09vRzJhWHJic2Y0azkreC9kMC9qUm5DMk1x?=
 =?utf-8?B?YnFTSXVvL05OeW1IQWxoeTB4Y2pCbUUrVFZKTHFFNm5YZHh3b1NEaW9wUmla?=
 =?utf-8?B?VWJsTW1ZandoN212RGVrNnczeGtjZmpmMjNoMHVMc1h5TFUzWnNUbXBoZS9l?=
 =?utf-8?B?TDBkV3RZTlBIRDAxUW92K0d4U3QxWU9oUUNCdHFlM1F3Q3Eyamo1L2JiUGkv?=
 =?utf-8?B?UmxMTVZzdHU5TEpGM3Vpb0JFNGQyS2xQbGxyS3hCbHprZStRUUIwazJUNys2?=
 =?utf-8?B?N2NyeWw3NjFXQms0aFhqeHpEU3pwcXVYY1pOeFJ5MGV4TFdqMGhpR0tlc0o2?=
 =?utf-8?B?R3k3UTU5Nmc0TEV4MEpPNHppVk1ZdlByRTlsL0NaMnJmS0NVTlJlNkladkVM?=
 =?utf-8?B?TmtHOFJHbWxvVUNVSmZoRllCRHJTN01OU3A1K1lBTDljckpaaVZBa1l5TmNO?=
 =?utf-8?B?T1VFV0txTDBpNHFHaFlUVld4VTNicVQ0S1Y1WTR5c1RaWkJQYTM4akp2Z01E?=
 =?utf-8?B?WHRsRW1EZ2syb3ZONmVINHRXTVVJa3VnZjc0SFZWM1BmK0F1djB1MGZZemtS?=
 =?utf-8?B?MXp4VHBwWVd5STdyTm12TVgybEkzZjV0ZEcrWlZiaTZDOHpUa2dmSmpidVVp?=
 =?utf-8?B?SFo2NmgxMVd5T0NxYWdjd2FwcUJHRXVCNU12NkNPTXVzVTBkNzNEaHJ1Z2ZY?=
 =?utf-8?B?WkN1Y1ZVSUhuaHJoOWtGYis0N0NFRXZMLzFrYVg3YnNRZmR0ZXNHbDVvZEk2?=
 =?utf-8?B?N2pidVcydW8vellJeDBNZFBCY0ErZlowWFltNUkzQmRGODQwb2JZZ01kYWRV?=
 =?utf-8?B?U1VjWVBCdllzeWJTVkNMNmZucTc5MXkzbXkxemFjbXpCbVBJODVaUXdyb2tE?=
 =?utf-8?B?N2s3dVpmdEdDNXZUT1dJb29UVHRIM0lTUW1uMHE0S2w2Q2dtelBvQkdxVnMx?=
 =?utf-8?Q?Ky/cLYAtuKJuuMso=3D?=
X-Exchange-RoutingPolicyChecked: UIJlz6RQTVGZiOHom+LG4dBm0e+D8Zx21ApTk92sATVxnzhmHKh/wOYDyYxQfDumuQJBD4sq/CQ6EIt1qNqhbr1tVJBFpMADHpN2uGUqO6kokxNoK0A62i29tAh+T1BBSzy7iqu5AVVirQHGndShFUqzMayPFLMupHTkVLJvju/CAr8iYzSzMAOlemeqJgIu1o5tC03W7TuMVPbUtnX3JwW7Cc2xnUFCnDPOfy/uTE1sDPJgfHkgM5WjJkxvl5J6gTLQOVhkW68A/EUZgncMIsB62bplrznRhhgrDH6lPo/nHCT9xEPWLMDOLSwx4BWiOCORpvoditHFYdN9ANJl0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b06ff0f-7fc4-4155-912e-08df3f3d5845
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:14:42.0411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVTfcPUEuMhOugqO3MVYlVVkPrLVWlyEoSlNINMs3tsOqHRZLjp/3KeTm7dIX5Flj4u4xLSCYXWvKGzFWTfDSF00gY039G5o2erDi0Dcv6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9722
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

From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 9 Nov 2026 15:53:55 +0100

> On Thu, Nov 5, 2026 at 7:08 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Luigi Rizzo <lrizzo@google.com>
>> Date: Tue,  3 Nov 2026 16:23:23 +0000
>>
>>> libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
>>> driver fills its Rx rings at open or on queue reconfiguration. That
>>> fill runs in process context, right after page_pool_create() and before
>>> the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
>>> needlessly restrictive there: it can neither reclaim nor compact, while
>>> the initial fill can allocate tens of thousands of buffers across all
>>> queues.
>>>
>>> Patch 1 adds __libeth_rx_alloc() taking a gfp_t parameter and turns
>>> libeth_rx_alloc() into its GFP_ATOMIC wrapper.
>>> Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
>>> to GFP_KERNEL.
>>>
>>> v3:
>>>   - rename libeth_rx_alloc_gfp() to __libeth_rx_alloc() and put the gfp
>>>     argument on its own line in page_pool_alloc_netmem() (Alexander Lobakin)
>>> v2: https://lore.kernel.org/r/20261019210604.2433620-1-lrizzo@google.com/
>>>   - split into two patches (libeth helper and idpf consumer)
>>> v1: https://lore.kernel.org/r/20261016151835.2500807-1-lrizzo@google.com/
>>>
>>> Luigi Rizzo (2):
>>>   libeth: add __libeth_rx_alloc() to specify allocation flags
>>>   idpf: use GFP_KERNEL for the initial Rx ring fill
>>
>> For the series:
>>
>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Looking further at the problem, gemini pointed out that libeth_rx_alloc()
> is called in a way that makes it easy and robust to tell when it
> can use GFP_KERNEL. This would greatly simplify the patch.
> 
> Alexander, do you like this version better perhaps ?
> 
> cheers
> luigi
> 
> diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
> index 5d991404845e6..38c0e5066f0ef 100644
> --- a/include/net/libeth/rx.h
> +++ b/include/net/libeth/rx.h
> @@ -104,10 +104,17 @@ void libeth_rx_fq_destroy(struct libeth_fq *fq);
>  static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
>  {
>         struct libeth_fqe *buf = &fq->fqes[i];
> +       /* fq->fqes is zero-allocated and pre-filled in process context for
> +        * indices [0 .. fq->count - 2]; slot fq->count - 1 is first allocated
> +        * in NAPI. Use GFP_KERNEL for initial pre-fill and GFP_ATOMIC after.
> +        */
> +       gfp_t gfp = (buf->truesize || i == fq->count - 1) ?
> +                   GFP_ATOMIC : GFP_KERNEL;

The fact that `fq->count - 1` is only allocated from the NAPI context is
idpf's detail that doesn't belong to libeth.
Even though this is way shorter diffstat than the original series, I
prefer the original as it doesn't change anything for drivers other than
idpf and allows specifying GFP flags manually without such guesses. This
change introduces new branches on hotpath for each driver that uses libeth.
> 
>         buf->truesize = fq->truesize;
> -       buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
> -                                                &buf->truesize);
> +       buf->netmem = page_pool_alloc_netmem(fq->pp, &buf->offset,
> +                                            &buf->truesize,
> +                                            gfp | __GFP_NOWARN);
>         if (unlikely(!buf->netmem))
>                 return DMA_MAPPING_ERROR;

Thanks,
Olek
