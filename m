Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C152EC5DF81
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 10:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53E7A6061A;
	Mon, 24 Aug 2026 10:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id axgT0RRDviPO; Mon, 24 Aug 2026 10:09:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787566183;
	bh=4xlI5uP196ZzsIbDFNY6QC8xCVgLsQLCwshuDKoMpNY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WilY7Ua37SJLuEfe8R4CvX2D0IDcZOddlbqze6mPzUdj0MmGKNwx792Ft1F1mZ7KH
	 YqshuYB/lorqBW+8sEdSmRwoZRaZneCJOjHM1WsaGd+o5sZr2nmnWVt4Htn1rA2wX5
	 UdPty9nYGR9y81QH1zCuctiU2K8wUJDNndfkyh3zPDXqdOiwED0UtSueXUVWSo6abL
	 CoOX50kkPKmqwqjDDMFeSwdq/QDzyLHcJbr9daomfxgBP07Wyef2tH47w85RGKAXxn
	 cw8Ey4Ynt7uTESOx2LObEEMiGotbyOilHmXR9gfKJjmaljNFy9iD64Tl6ksbE+7gfb
	 3AyfJdJcI8gsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E254160614;
	Mon, 24 Aug 2026 10:09:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EAA734E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 10:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24BE880C09
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 10:09:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GIxxssH8LsAY for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 10:09:41 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XeXPHo9/
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D69F080BEC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787566181; x=1819102181;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4xlI5uP196ZzsIbDFNY6QC8xCVgLsQLCwshuDKoMpNY=;
 b=XeXPHo9/E86x355ruhJHdDy028beJJGGc7Vh10+8T93gCDsnCDR3yBDQ
 fXCSFvCIicC32Lp/PmTroZ7NQJUlyu+1BQ6CsOfX5B2ptEGbc0udMTUHf
 bczf9BgBySVPVONpfxlrYXOhKwJmLQr1eEjBjoH2tJfyMoOVja3lMGsnv
 4b76/ae5V7npuwsMhfadCLANCEbxIKOLwAfey31C70cpSxVzlq4q37cU0
 2NbKroMUe6Bi/993RWedM1tRp2eGgSXTjCol+2ZaIBj7rbfh+lMhOGhPG
 fUrYCTfUUoP3QlKYLlN4+dbDVXoSusdMzIO1OB05Wad68PP9qRHRc4nYs w==;
X-CSE-ConnectionGUID: R0eq71j+QTGd3HrZINqgQg==
X-CSE-MsgGUID: lVq2IBFXSk+TMHj6cxWtwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="86965434"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="86965434"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 03:09:40 -0700
X-CSE-ConnectionGUID: dNjRSUTgRZ+/bY5HBRY87Q==
X-CSE-MsgGUID: ipT3VB4GTdidvb6HNUHu0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="305167105"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 03:09:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 03:09:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 03:09:39 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 03:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsMLznkFb3gvkVP2EkrjIuicvgdU/rQ7QKgd/TE6jdQ4deNh1a+lXRr0X9tNR19Iu64WTN730PqgADaVh3r1ujr2j9YiB75JxeHIkF3pc8PAoLzb2Gu2/zNydbbCPpOsuxkRERWeun9uQBw5pdXRZq/oQOsy7q22tRWV9Wq3cfZ6T+MxxAvV5V0ZWVAc3cD1SB/YZpse71Gzokzu2Zcje/MRyQ3LVjcQD6eho+0A9UUi9lqogbkjn0k4n6uUsdvZC+98FFWbYltMWfOqEZB+wiCN81TGLRlUWVrpyE375WF9Mr1WcwVT6sfF5eYByO38ltdFRv9NxZbcVgYEP5ocGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xlI5uP196ZzsIbDFNY6QC8xCVgLsQLCwshuDKoMpNY=;
 b=nLDP5oHSa5eAMq1jOmAonXUK41gAzbCpOhRMnx7iCakKitXb9/fZeSdaIktOT1DeFZbiydNokAAPIufYBjBOOH/32VQSajlPQvKwFUQQ7g4qerFfYNbGScZrifJvzvMVnAdgmybghZ8/1Ox60h/Xcru6kkhkPnzUkAOv1dvmsZM3JLROY2qqAF+QjuuagD/Tdoh2hX4duSVVRxhgnPTXBxGcQwtbT4VDbRsnZsaq07o7/YGWw4Ry7B10oq0w+sKSf6fqzx++0GbFD08p1RKrgN7LAtCH2+qj3Iu4RL0Q1daQvacfZyn7bq63L0AMPnIswi1yPh8DAnFw0h27wehW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SABPR11MB9940.namprd11.prod.outlook.com (2603:10b6:806:4ee::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:09:36 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:09:36 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
 <przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "Oros, Petr" <poros@redhat.com>, "Nowlin, Alexander"
 <alexander.nowlin@intel.com>, "Bross, Kevin" <kevin.bross@intel.com>,
 "Cavatur, Ranjit" <ranjit.cavatur@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>
Subject: RE: [PATCH iwl-net 12/12] ice: don't clear in_use until HW clears
 ready bitmap
Thread-Topic: [PATCH iwl-net 12/12] ice: don't clear in_use until HW clears
 ready bitmap
Thread-Index: AQHdMctffSrW6/d//UiOt3hBJNGlaLas/IWg
Date: Mon, 24 Aug 2026 10:09:36 +0000
Message-ID: <IA3PR11MB89866D71CA16D531817E9E52E5A02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-12-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-12-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SABPR11MB9940:EE_
x-ms-office365-filtering-correlation-id: 3cb3b42b-c4e2-48a1-3a6c-08df01c7cd6a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: DdCE6A2X1YwRk+LY1+v5ufNhpruyhFm/LntSH2yXvmGTgTmsm4Ex58MZJ3ecBWQKpPMXXGV21mV8ese/C4xqUehXVis9rGLmbYw9i7cgkUH/KtLkQkMfnFIM+FObxeBa1XXzbeQAGviUKore1o3YpaZhLswatlkrveAygdQsyLwg19HQQzDchmp22RfdMGRVF8dIS2jPbz15xinFXRIbiiyXgzzIn/0QCX2L+DODQt00nPYAEd0NEYgqDoae0eZds0zsYBQ03910to3CUIf8pUaqYHlRY3ByGN93qjrnlYxXKQqTtXqTQtx8y897cTVXoLN/37ygsvZEXtRZdDl7pZ5ThRZWkqzHIPQodSikrXuemRWbngpYZxHNeWvZwhG/mS4KdM3Li3EVHpcJ4WDWshOV93CCo9h7eZMUcVHPJJ+p6CZqXv8Y4tcvPoRXL/qyNp7MR0K/Dp51vvlqWFHabfOfOvXt9ktS+H8zUs4gCW7nU7f7WgmMNBSlb6AU5y5RtZIbtm+FKOIy9jCzEJwjGoGgBNv+WRTCHQimHulREE3QYtQKhU4cVeAz4TlJdjVTumCrNW6z/HcqXMsDpY3Y3ZwXPEGl23lo25Olee16TKjwKT3bw7fCZYIuHTb0miFtw6sphoYKv9qHRqoBMvg+yYmbl9nEIA72+Q/vsa4r5Bit46GfYnZUydPqMOJqxMi4uKCb8McR8rbH5dopeb/hZuIyYcd1iK1CRsgsE7HwCNg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFhWbTFjTEswSWhudkFsSVY4YTg3WnZTemJyS3o4T2N1ZTRXSzZ1U2JhLzNV?=
 =?utf-8?B?MkNhZTcwZFpRTUpCbEN6VFBHWjJKZWNFWlkyNytaeFpYSUhHbDRlQUVNSzhW?=
 =?utf-8?B?NWpUVThrZGZhTSs2bTRHOUszbHFpa2tHTkVnNm81MThYR2VHZDlJaUZSQUNN?=
 =?utf-8?B?eGZYc25JZWNyQjNWTjlmc3NYdDFNRmpXM09jRCtLY3BDU2Z5dll2OTNpOFFR?=
 =?utf-8?B?eG9SQUUxZjNWUHAra0lCWk9aWE83U3FsSHEvMVhabzRTc3JUdW1sM09zLzl2?=
 =?utf-8?B?SWJ5UU5vS2NZdE00ZnBqM2w2azZ3N3d0a044a2htY3g2UG5EdVl5V2dRaXha?=
 =?utf-8?B?eUZxRktITGY4YkJEVjE3WmNKVFRQbVdscTVyMzZyV2VGdE1pMGVSZmlXUDRz?=
 =?utf-8?B?KzhCRkhLdU1uOW8venh1UnBjTU85UjdJbzV2Syt4anA0dmQ5QloxY1NKWSt1?=
 =?utf-8?B?OFBUVmh6YzQrYUFHbTlhU0xMeTZ1d2J5R1diUWZJUGFHVFJCUUJhZFo4Z0dF?=
 =?utf-8?B?bjF3SXh2Mkl5L0g0L2ZVcnpQMEZsRFR4aCtkWklEcUNselltSXlUL1hPMmNx?=
 =?utf-8?B?UHdqWHpmREV6K1hjaWhnVTVrMFFPbVRqK2M5SWE2Q2s5K25wamZqZHhxWThX?=
 =?utf-8?B?TlhwMytPb0F0eUZpRHBVTnZqc2hTMUZzSUsxRGhUYVdWUitwTXRYQnVXMngv?=
 =?utf-8?B?TU5DbmtEMmFjbnJVdzNoTTRiK2dscFVSNVVpbkZZQnBMVUE5cHhhaGhMRWxl?=
 =?utf-8?B?d3lHd1RHd2dFY0tKSkFMemFEcDdqOUFLOFZiZWkxbW9GZnIvc0VqMXFlbERF?=
 =?utf-8?B?WjdORWRMMDk0SkFyUitLdlp5WWI4dExsZ2h5c0RCd2NYUDNQeEU4QVd3eFNM?=
 =?utf-8?B?RDRkanRwQjBrcWtqaVIrajhab1p1Qmo0NzV2QUZJWXJLaHo5VGZxZ3RTQmVR?=
 =?utf-8?B?Tkp3MDJ5OE1JRkZocXF0OVlCZXVxdlZ3Y3VtQkNRS3lrRzF0QUZwTzlVd3F6?=
 =?utf-8?B?aXpUNUd3ODdDNEFhU1AxZWtVTG8ycHJsSmZuT2RKd0hXZnlKdlR0RWM0bThp?=
 =?utf-8?B?elpocEI4dTlBcmczcGhWNGJkblkyYXcwVkU2SVovWVZIUE42SHA0ektFWmRh?=
 =?utf-8?B?c0N3Y2piaHpxVFdtb0ZrVWFkSVpZTE1Ccy9RbHlpTVVibk8vZkdRRDhzaDgz?=
 =?utf-8?B?ekUvOExBVWFUSUhUYWRiK0VHVkRsZG9iTnVueldSM3R0eVZ4SDBhRmJoRDFU?=
 =?utf-8?B?KzZiSVp4SStyZ2hTN0YwTEtHS2VVdEdNSlVDT1FEZElka1dxYXR2QU9vbUxi?=
 =?utf-8?B?Q1FSMzJVaTZweWE0KzZaRkJrZU53bUZxNm9xWlNwcFdXSTR6TVR2RFBtQ1hN?=
 =?utf-8?B?ZVg1Zlh6MERWRkl3aDRuYzc0azcxMElaS25NaGo4Vm9Wemluako1UFNNYXdx?=
 =?utf-8?B?dDdOY2FEU1BDZGF1eHhuOXlQemZUUS93QndqRkRRNFBoSEplVWZiTUExRzU3?=
 =?utf-8?B?UzRxZnJXS1Q4cjN0VEEwSXhZakxPMWNzckhocXRmdk1YaXl0WGh3L0V2V05X?=
 =?utf-8?B?Z0NKUDZpQ0JCUVRYVllZOGdvcGFOOEQxRmxWQkhYOSsxRzloZEI0MS9SU0ZS?=
 =?utf-8?B?Q1RyWFVob052OFluZDBFQ0tZZFVIUGFyb2xadlZGZHJDOWEwSFRMWU5xNXdh?=
 =?utf-8?B?RmE4RGFuVFZzbkp2RHk2aGlTdEg4cnl1QzB6SkxyWnhnZkYrMG4vYWx4cGVF?=
 =?utf-8?B?S1VkY0RMNTBIYnZRQVNyTi9mbWdqZDZHN3JaaDhDV3NDL3d1WVI4Q2J6QnhI?=
 =?utf-8?B?bkU0aytrQ3JtS2VtNXVTWkZFcHlTVEhGZ3FGNnF4U3FHYjhDeWdYcFliandK?=
 =?utf-8?B?bWxsQzhOQS9aSXh5ckRreDRVSCt0Q2ZuOVFqdURTZVZsR0lYdW9NNVJIUndi?=
 =?utf-8?B?UGpsZnJQUVo5SXMzQlJpNkpScmVsWGFUdGkzc3hYcXluMVFaYVBRck9rQ0xu?=
 =?utf-8?B?aXJFK1dOKzlzUjJKRk1zZ2dHOXVqcDFXYk9JMzhOaHBTZjFacHNEMmd4NnRG?=
 =?utf-8?B?bFVyUmU4ckJ6MmxLVmtXRllYanlzbGlLVDVXUm4rYXBZQ2kveVNUeFgvbS81?=
 =?utf-8?B?QUhZZWs0b1pyV0VkdG1hY2V4dTl2UjRNeVZlRXpCV0ExUnQwM3NBQ2FDK0Yy?=
 =?utf-8?B?d3IwRmhxbkFOeWxiVG1pOThYdlA0VVBjU0Ziejd4TnMyZE51eVhmYUtnUG9v?=
 =?utf-8?B?MmM3SXU3UVpBQmVZbTg3OU9PNzZFWTJKRllScHo1Smk3NVgrY2g4SXdQWE45?=
 =?utf-8?B?ZEY1VVlrY2grRDVDdFR0c1lIcDRJb0RUMUxJcVdRTFdIdFdaTjh2OUY3WFRy?=
 =?utf-8?Q?3QDB8YCSEWleOvDE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R93bLnk73xM+0fbtaTBWcGuKe4edm1vugPftBQ+wf5fQkYQdH6feBZAqNFhcuWvcPAU0rK8M7sN0HuiQb+uz33sW8iZpdGkUHH2l/jOv0HsPMEef6CBZ0AibOQMkpI+BifFMg8nqlHbKimHHgbrvJ//uls8Q0sB56dGpenJN2W9p9WbBeNexiJmyBTUG+6imKRQAfH9yhsrlI197q89CCROolfHpcymBQ/dmxLVDCGpTk1dISBOTADvaFldRkjVVXikzhZWnOAvaXAqKo/hSf8PaLjcDMlUn0OVi91LoBo4tPai1wjhY0eKXTtZs5jHrVY6FlNoqkxmOaFDc3tlZgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb3b42b-c4e2-48a1-3a6c-08df01c7cd6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 10:09:36.6096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7G8YBsRJN069bXudglxutoJnrYM/nntjSOX9waHb53uTmSbZQzpjqOdHkYdrQS9OXRHFWvjawMJRB+3T7hniMapQc/QAkUYxETSqc+uy5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9940
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgS2VsbGVyIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBdWd1c3QgMjIsIDIw
MjYgMjoxMyBBTQ0KPiBUbzogSW50ZWwgV2lyZWQgTEFOIDxpbnRlbC13aXJlZC1sYW5AbGlzdHMu
b3N1b3NsLm9yZz4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IE1hY2huaWtvd3NraSwg
TWFjaWVqDQo+IDxtYWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9u
eSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtvcmJhLCBQcnplbXlzbGF3DQo+
IDxwcnplbXlzbGF3LmtvcmJhQGludGVsLmNvbT47IE5pdGthLCBHcnplZ29yeg0KPiA8Z3J6ZWdv
cnoubml0a2FAaW50ZWwuY29tPjsgT3JvcywgUGV0ciA8cG9yb3NAcmVkaGF0LmNvbT47IE5vd2xp
biwNCj4gQWxleGFuZGVyIDxhbGV4YW5kZXIubm93bGluQGludGVsLmNvbT47IEJyb3NzLCBLZXZp
bg0KPiA8a2V2aW4uYnJvc3NAaW50ZWwuY29tPjsgQ2F2YXR1ciwgUmFuaml0IDxyYW5qaXQuY2F2
YXR1ckBpbnRlbC5jb20+Ow0KPiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVs
LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgMTIvMTJdIGljZTogZG9uJ3QgY2xlYXIg
aW5fdXNlIHVudGlsIEhXIGNsZWFycw0KPiByZWFkeSBiaXRtYXANCj4gDQo+IER1cmluZyBhIGxp
bmsgZG93biB0cmFuc2l0aW9uLCB0aGUgRTgyNSBQSFkgaGFzIGEgc21hbGwgd2luZG93IHdoZXJl
DQo+IGl0IGRvZXMgbm90IHByb3Blcmx5IHJlc3BvbmQgdG8gcmVhZGluZyB0aGUgUEhZIHRpbWVz
dGFtcCByZWdpc3RlcnMuDQo+IFdoZW4gdGhpcyBvY2N1cnMsIHRoZSBQSFkgZG9lcyBub3QgYXV0
b21hdGljYWxseSBjbGVhciB0aGUgcmVhZHkNCj4gYml0bWFwIG9yIHRoZSB2YWxpZCBiaXQgZm9y
IHRoZSB0aW1lc3RhbXAuIFRoaXMgYmVnaW5zIGhhcHBlbmluZw0KPiBzbGlnaHRseSBiZWZvcmUg
YSBsaW5rIHRyYW5zaXRpb24gZXZlbiBiZWZvcmUgdGhlIGZpcm13YXJlIGhhcw0KPiBub3RpZmll
ZCB0aGUgZHJpdmVyIG9mIHRoZSBzdGF0ZSBjaGFuZ2UuDQo+IA0KPiBUaGUgZHJpdmVyIGhhcHBp
bHkgY29tcGxldGVzIHRoZSB0aW1lc3RhbXAsIHJlbGVhc2luZyB0aGUgaW5fdXNlIGJpdC4NCj4g
VGhpcyBhbGxvd3MgYW5vdGhlciByZXF1ZXN0IHRvIHJldXNlIHRoZSBiaXQgcG90ZW50aWFsbHkg
cmVwb3J0aW5nIGFuDQo+IGludmFsaWQgc3RhbGUgdGltZXN0YW1wLiBBZGRpdGlvbmFsbHksIHdp
dGggdGhlIHJlYWR5IGJpdCBzdGlsbCBzZXQNCj4gaGlnaCB0aGUgZHJpdmVyIGNvbnRpbnVlcyB0
byByZS10cmlnZ2VyIHRoZSBJUlEgYW5kIGNoZWNrIGZvcg0KPiB0aW1lc3RhbXBzIGluIGEgdGln
aHQgbG9vcCwgd2FzdGluZyBDUFUgY3ljbGVzLg0KPiANCj4gVG8gZml4IHRoaXMsIHJlLXJlYWQg
dGhlIFBIWSB0aW1lc3RhbXAgbWVtb3J5IHN0YXR1cyBhZnRlciBlYWNoIHJlYWQNCj4gb2YgYSBQ
SFkgaW5kZXguIERvdWJsZSBjaGVjayBpZiB0aGUgaGFyZHdhcmUgY2xlYXJlZCB0aGUgaW5kZXgN
Cj4gcHJvcGVybHkuIElmIGl0IGhhc24ndCwgbWFyayB0aGUgdGltZXN0YW1wIGluZGV4IGFzIHN0
YWxlIGFuZCBza2lwDQo+IHByb2Nlc3NpbmcgaXQuDQo+IA0KPiBTdGFsZSB0aW1lc3RhbXBzIGFy
ZSBhbHJlYWR5IGlnbm9yZWQgYnkgdGhlDQo+IGljZV9hbnlfcG9ydF9oYXNfdGltZXN0YW1wcygp
IGZ1bmN0aW9uLiBIb3dldmVyLCB0aGUNCj4gaWNlX3B0cF90eF90c3RhbXBzX3BlbmRpbmcoKSBm
dW5jdGlvbiBhbHNvIGNoZWNrcyB0aGUgcmVhZHkgYml0bWFwLg0KPiBJbnN0ZWFkLCBtb2RpZnkg
aXQgdG8gb25seSBjaGVjayB0aGUgc29mdHdhcmUgdHJhY2tlci4NCj4gQWRkaXRpb25hbGx5LCBz
dG9wIHJlLXRyaWdnZXJpbmcgdGhlIGludGVycnVwdCBmcm9tIHRoZSBJUlEgaWYgdGhlDQo+IHRp
bWVzdGFtcCB0cmFja2VyIGlzIGNhbGlicmF0aW5nIG9yIGhhcyB0aGUgbGluayBtYXJrZWQgYXMg
ZG93bi4NCj4gQ29udGludWUgdG8gY2hlY2sgdGhlIGhhcmR3YXJlIHJlYWR5IGJpdG1hcCBmcm9t
IHRoZSB3YXRjaGRvZyB0byBjYXRjaA0KPiBjYXNlcyBvZiB1bmV4cGVjdGVkIHRpbWVzdGFtcHMu
DQo+IA0KPiBXaXRoIHRoZXNlIGNoYW5nZXMsIHRoZSB0aW1lc3RhbXAgcHJvY2Vzc2luZyBubyBs
b25nZXIgdHJpZ2dlcnMgYQ0KPiByZXBlYXRlZCBzcGFtbWluZyBvZiB0aGUgSVJRIGR1cmluZyBs
aW5rIGRvd24gZXZlbnRzIHdoZXJlIHRpbWVzdGFtcHMNCj4gZ2V0IHN0dWNrIGFzIHRoZSBQSFkg
dHJhbnNpdGlvbnMgdG8gbGluayBkb3duLiBPbmNlIGxpbmsgaXMgcmVzdG9yZWQsDQo+IHRoZSBQ
SFkgd2lsbCBiZSByZXNldCBhbmQgdGhlIHN0dWNrIHRpbWVzdGFtcHMgYXJlIGNsZWFyZWQuDQo+
IA0KPiBNZWFzdXJpbmcgQ1BVIHV0aWxpemF0aW9uIG9mIHRoZSBtaXNjZWxsYW5lb3VzIElSUSB0
aHJlYWQgZnVuY3Rpb24NCj4gZHVyaW5nIHRpbWVzdGFtcCBzdG9ybXMgbmVhciBhIGxpbmsgcmVz
ZXQgc2hvd3MgdGhhdCB0aGlzIHByZXZlbnRzIHRoZQ0KPiBzcGlrZXMgY2F1c2VkIGJ5IHRoZSAi
c3R1Y2siIHJlYWR5IGJpdC4gV2l0aG91dCB0aGlzIGZpeCwgdGhlIENQVQ0KPiBoYW5kbGluZyB0
aGUgSVJRIGJlY29tZXMgc2xhbW1lZCBkdWUgdG8gdGhlIElSUSByZS10cmlnZ2VyaW5nIGxvZ2lj
Lg0KPiANCj4gTWVhc3VyaW5nIGxhdGVuY3kgdXNpbmcgdGhlIGljZSBUeCB0aW1lc3RhbXAgdHJh
Y2VzIGRvZXMgc2hvdyB0aGF0DQo+IHRoaXMgZml4IGNvbWVzIGF0IGEgbGF0ZW5jeSBjb3N0LiBM
YXRlbmN5IGlzIG1lYXN1cmVkIHVzaW5nIHRoZSBpY2UgVHgNCj4gdGltZXN0YW1wIHRyYWNlcyBm
b3IgdGhlIHJlcXVlc3QgdG8gY29tcGxldGlvbiB0aW1lLiBJIG1lYXN1cmVkIGENCj4gY291cGxl
IG9mIGRpZmZlcmVudCB3b3JrbG9hZHMgYm90aCBiZWZvcmUgYW5kIGFmdGVyIHRoaXMgZml4Og0K
PiANCj4gICogcHRwNGwgdXNpbmcgYSBwcm9maWxlIHdpdGggfjE2IFNZTkMgbWVzc2FnZXMgcGVy
IHNlY29uZA0KPiANCj4gICAgIGJlZm9yZTogMTU5LjQwIG1pY3Jvc2Vjb25kcyBtZWFuLCBzdGRl
diA0NS4yOA0KPiAgICAgIGFmdGVyOiAxODIuMDcgbWljcm9zZWNvbmRzIG1lYW4sICBzdGRldiA0
My40Mw0KPiANCj4gICogYSBDIHByb2dyYW0gZ2VuZXJhdGluZyAxNiB0aW1lc3RhbXAgcmVxdWVz
dHMgZXZlcnkgMTAgbWlsbGlzZWNvbmRzDQo+IG9uDQo+ICAgIHR3byBkaWZmZXJlbnQgcG9ydHM6
DQo+IA0KPiAgICAgYmVmb3JlOiA2MDQuMzUgbWljcm9zZWNvbmRzIG1lYW4sIHN0ZGV2IDM0NS4z
Mg0KPiAgICAgIGFmdGVyOiA5OTAuMTMgbWljcm9zZWNvbmRzIG1lYW4sIHN0ZGV2IDYyNS42NA0K
PiANCj4gSW4gdGhlIG5vcm1hbCB3b3JrIGZsb3dzIHRoaXMgY29tZXMgd2l0aCBhYm91dCBhIDIw
IG1pY3Jvc2Vjb25kDQo+IHBlbmFsdHkgb24gdGhlIGF2ZXJhZ2UsIGFuZCB0aGUgc3RhbmRhcmQg
ZGV2aWF0aW9uIHJlbWFpbnMNCj4gYXBwcm94aW1hdGVseSB0aGUgc2FtZS4gRm9yIGhlYXZ5IHdv
cmtsb2FkcyB3aXRoIG1hbnkgbW9yZSB0aW1lc3RhbXBzDQo+IHRoYW4gZXhwZWN0ZWQgZm9yIHR5
cGljYWwgYXBwbGljYXRpb25zIHRoaXMgY29tZXMgYXQgYSBzaWduaWZpY2FudA0KPiBjb3N0LiBU
aGlzIGlzIGJlY2F1c2Ugd2UgaGFuZGxlIGFsbCB0aW1lc3RhbXBzIGluIGEgc2luZ2xlIHRocmVh
ZC4gSWYNCj4gdGhlcmUgYXJlIG1hbnkgY29uY3VycmVudCB0aW1lc3RhbXBzIGJlaW5nIHJlcXVl
c3RlZCBhdCBvbmNlLCBhbnkNCj4gd2hpY2ggdXNlIHRoZSBsYXRlciBzbG90cyBvbiBwb3J0cyBs
YXRlciBpbiB0aGUgcG9ydCBsaXN0IHdpbGwgdGFrZQ0KPiBtdWNoIGxvbmdlciB0byBiZSBwcm9j
ZXNzZWQgb25jZSB0aGUgaW50ZXJydXB0IGlzIGZpcmVkLiBTaW5jZSBlYWNoDQo+IHRpbWVzdGFt
cCBub3cgcmVxdWlyZXMgYW4gYWRkaXRpb25hbCBQSFkgcmVnaXN0ZXIgYWNjZXNzLCB0aGlzIGNv
c3QgaXMNCj4gbXVjaCBoaWdoZXIgaW4gdGhlIGNhc2Ugd2hlcmUgdGhlIGRldmljZSBpcyB1bmRl
ciB1bnVzdWFsbHkgaGVhdnkNCj4gbG9hZC4NCj4gDQo+IEhvd2V2ZXIsICpjb3JyZWN0bmVzcyog
aXMgbW9yZSBpbXBvcnRhbnQgdGhhbiBzcGVlZCBoZXJlLg0KPiBBZGRpdGlvbmFsbHksIHdlIHN0
aWxsIHJlbWFpbiB3ZWxsIGJlbG93IHRoZSBkZWZhdWx0IGxpbWl0IG9mIDEwDQo+IG1pbGxpc2Vj
b25kcyB0aGF0IHB0cDRsIHdpbGwgd2FpdCBiZWZvcmUgY29tcGxhaW5pbmcgYWJvdXQgbWlzc2lu
Zw0KPiB0aW1lc3RhbXBzLg0KPiANCj4gRml4ZXM6IDdjYWI0NGYxYzM1ZiAoImljZTogSW50cm9k
dWNlIEVUSDU2RyBQSFkgbW9kZWwgZm9yIEU4MjVDDQo+IHByb2R1Y3RzIikNCj4gU2lnbmVkLW9m
Zi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyB8IDU0ICsrKysrKysrKysr
KysrKy0tLS0tLS0tDQo+IC0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlv
bnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pY2UvaWNlX3B0cC5jDQo+IGluZGV4IGIzMzcyNDdjOTRlMC4uMGU0NGVkNmIwYWU4IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5jDQo+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gQEAgLTYyMCw2
ICs2MjAsMjIgQEAgc3RhdGljIHZvaWQgaWNlX3B0cF9wcm9jZXNzX3R4X3RzdGFtcChzdHJ1Y3QN
Cj4gaWNlX3B0cF90eCAqdHgpDQo+ICAJCWlmIChlcnIgJiYgIWRyb3BfdHMpDQo+ICAJCQljb250
aW51ZTsNCj4gDQo+ICsJCS8qIHZlcmlmeSByZWFkeSBiaXQgY2xlYXJlZCAqLw0KPiArCQlpZiAo
dHgtPmhhc19yZWFkeV9iaXRtYXApIHsNCj4gKwkJCWVyciA9IGljZV9nZXRfcGh5X3R4X3RzdGFt
cF9yZWFkeShodywgdHgtPmJsb2NrLA0KPiAmdHN0YW1wX3JlYWR5KTsNCj4gKwkJCWlmIChlcnIp
DQo+ICsJCQkJY29udGludWU7DQo+ICsNCj4gKwkJCWlmICh0c3RhbXBfcmVhZHkgJiBCSVRfVUxM
KHBoeV9pZHgpKSB7DQo+ICsJCQkJc3Bpbl9sb2NrX2lycXNhdmUoJnR4LT5sb2NrLCBmbGFncyk7
DQo+ICsJCQkJaWYgKCF0ZXN0X2FuZF9zZXRfYml0KGlkeCwgdHgtPnN0YWxlKSkNCj4gKwkJCQkJ
ZGV2X2RiZyhpY2VfcGZfdG9fZGV2KHBmKSwgIlBIWSBwb3J0DQo+ICV1IGZhaWxlZCB0byBjbGVh
ciByZWFkeSBiaXQgZm9yIGlkeCAldVxuIiwNCj4gKwkJCQkJCXB0cF9wb3J0LT5wb3J0X251bSwg
cGh5X2lkeCk7DQo+ICsJCQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdHgtPmxvY2ssIGZsYWdz
KTsNCj4gKwkJCQljb250aW51ZTsNCj4gKwkJCX0NCj4gKwkJfQ0KPiArDQo+ICAJCWljZV90cmFj
ZSh0eF90c3RhbXBfZndfZG9uZSwgdHgtPnRzdGFtcHNbaWR4XS5za2IsIGlkeCk7DQo+IA0KPiAg
CQkvKiBGb3IgUEhZcyB3aGljaCBkb24ndCBpbXBsZW1lbnQgYSBwcm9wZXIgdGltZXN0YW1wDQo+
IHJlYWR5IEBAIC0yNzY0LDEwICsyNzgwLDE0IEBAIHN0YXRpYyBib29sDQo+IGljZV9wb3J0X2hh
c190aW1lc3RhbXBzKHN0cnVjdCBpY2VfcHRwX3R4ICp0eCwgYm9vbCBpbl9pcnEpDQo+ICAJCWlm
ICghdHgtPmluaXQpDQo+ICAJCQlyZXR1cm4gZmFsc2U7DQo+IA0KPiAtCQlpZiAoaW5faXJxKQ0K
PiArCQlpZiAoaW5faXJxKSB7DQo+ICsJCQlpZiAoIWljZV9wdHBfaXNfdHhfdHJhY2tlcl91cCh0
eCkpDQo+ICsJCQkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICAJCQlyZXR1cm4gYml0bWFwX2FuZG5v
dCh0c3RhbXBzLCB0eC0+aW5fdXNlLCB0eC0NCj4gPnN0YWxlLCB0eC0+bGVuKTsNCj4gLQkJZWxz
ZQ0KPiArCQl9IGVsc2Ugew0KPiAgCQkJcmV0dXJuICFiaXRtYXBfZW1wdHkodHgtPmluX3VzZSwg
dHgtPmxlbik7DQo+ICsJCX0NCj4gIAl9DQo+ICB9DQo+IA0KPiBAQCAtMjc5MCw0MSArMjgxMCwx
OCBAQCBzdGF0aWMgYm9vbCBpY2VfYW55X3BvcnRfaGFzX3RpbWVzdGFtcHMoc3RydWN0DQo+IGlj
ZV9wZiAqcGYsIGJvb2wgaW5faXJxKQ0KPiANCj4gIGJvb2wgaWNlX3B0cF90eF90c3RhbXBzX3Bl
bmRpbmcoc3RydWN0IGljZV9wZiAqcGYsIGJvb2wgaW5faXJxKSAgew0KPiAtCXN0cnVjdCBpY2Vf
aHcgKmh3ID0gJnBmLT5odzsNCj4gLQlpbnQgcmV0Ow0KPiAtDQo+IC0JLyogQ2hlY2sgc29mdHdh
cmUgaW5kaWNhdG9yICovDQo+ICAJc3dpdGNoIChwZi0+cHRwLnR4X2ludGVycnVwdF9tb2RlKSB7
DQo+ICAJY2FzZSBJQ0VfUFRQX1RYX0lOVEVSUlVQVF9OT05FOg0KPiAgCQlyZXR1cm4gZmFsc2U7
DQo+ICAJY2FzZSBJQ0VfUFRQX1RYX0lOVEVSUlVQVF9TRUxGOg0KPiAtCQlpZiAoaWNlX3BvcnRf
aGFzX3RpbWVzdGFtcHMoJnBmLT5wdHAucG9ydC50eCwgaW5faXJxKSkNCj4gLQkJCXJldHVybiB0
cnVlOw0KPiAtCQlicmVhazsNCj4gKwkJcmV0dXJuIGljZV9wb3J0X2hhc190aW1lc3RhbXBzKCZw
Zi0+cHRwLnBvcnQudHgsDQo+IGluX2lycSk7DQo+ICAJY2FzZSBJQ0VfUFRQX1RYX0lOVEVSUlVQ
VF9BTEw6DQo+IC0JCWlmIChpY2VfYW55X3BvcnRfaGFzX3RpbWVzdGFtcHMocGYsIGluX2lycSkp
DQo+IC0JCQlyZXR1cm4gdHJ1ZTsNCj4gLQkJYnJlYWs7DQo+ICsJCXJldHVybiBpY2VfYW55X3Bv
cnRfaGFzX3RpbWVzdGFtcHMocGYsIGluX2lycSk7DQo+ICAJZGVmYXVsdDoNCj4gIAkJV0FSTl9P
TkNFKDEsICJVbmV4cGVjdGVkIFR4IHRpbWVzdGFtcCBpbnRlcnJ1cHQgbW9kZQ0KPiAldVxuIiwN
Cj4gIAkJCSAgcGYtPnB0cC50eF9pbnRlcnJ1cHRfbW9kZSk7DQo+IC0JCWJyZWFrOw0KPiAtCX0N
Cj4gLQ0KPiAtCS8qIENoZWNrIGhhcmR3YXJlIGluZGljYXRvciAqLw0KPiAtCXJldCA9IGljZV9j
aGVja19waHlfdHhfdHN0YW1wX3JlYWR5KGh3KTsNCj4gLQlpZiAocmV0IDwgMCkgew0KPiAtCQlk
ZXZfZGJnKGljZV9wZl90b19kZXYocGYpLCAiVW5hYmxlIHRvIHJlYWQgUEhZIFR4DQo+IHRpbWVz
dGFtcCByZWFkeSBiaXRtYXAsIGVyciAlZFxuIiwNCj4gLQkJCXJldCk7DQo+IC0JCS8qIFN0b3Ag
dHJpZ2dlcmluZyBJUlFzIGlmIHdlJ3JlIHVuYWJsZSB0byByZWFkIFBIWSAqLw0KPiAgCQlyZXR1
cm4gZmFsc2U7DQo+ICAJfQ0KPiAtDQo+IC0JLyogaWNlX2NoZWNrX3BoeV90eF90c3RhbXBfcmVh
ZHkoKSByZXR1cm5zIDEgaWYgdGhlcmUgYXJlDQo+IHRpbWVzdGFtcHMNCj4gLQkgKiBhdmFpbGFi
bGUsIDAgaWYgdGhlcmUgYXJlIG5vIHdhaXRpbmcgdGltZXN0YW1wcywgYW5kIGENCj4gbmVnYXRp
dmUNCj4gLQkgKiB2YWx1ZSBpZiB0aGVyZSB3YXMgYW4gZXJyb3IgKHdoaWNoIHdlIGNoZWNrZWQg
Zm9yIGFib3ZlKS4NCj4gLQkgKi8NCj4gLQlyZXR1cm4gcmV0ID4gMDsNCj4gIH0NCj4gDQo+ICAv
KioNCj4gQEAgLTI5MTUsNyArMjkxMiw4IEBAIHN0YXRpYyB2b2lkDQo+IGljZV9wdHBfbWF5YmVf
dHJpZ2dlcl90eF9pbnRlcnJ1cHQoc3RydWN0IGljZV9wZiAqcGYpDQo+ICAJaWYgKCFpY2VfcGZf
c3JjX3Rtcl9vd25lZChwZikpDQo+ICAJCXJldHVybjsNCj4gDQo+IC0JaWYgKGljZV9wdHBfdHhf
dHN0YW1wc19wZW5kaW5nKHBmLCBmYWxzZSkpIHsNCj4gKwlpZiAoaWNlX3B0cF90eF90c3RhbXBz
X3BlbmRpbmcocGYsIGZhbHNlKSB8fA0KPiArCSAgICBpY2VfY2hlY2tfcGh5X3R4X3RzdGFtcF9y
ZWFkeShodykpIHsNCk5vdCBvYnZpb3VzIGNvbnZlcnNpb24gb2YgcmV0dXJuZWQgLUVPUE5PVFNV
UFAgYW5kIG90aGVyIGVycm9ycyBhcyBib29sLg0KDQoNCj4gIAkJZGV2X2RiZyhkZXYsICJQVFAg
cGVyaW9kaWMgdGFzayBkZXRlY3RlZCB3YWl0aW5nDQo+IHRpbWVzdGFtcHMuIFRyaWdnZXJpbmcg
VHggdGltZXN0YW1wIGludGVycnVwdCBub3cuXG4iKTsNCj4gDQo+ICAJCXdyMzIoaHcsIFBGSU5U
X09JQ1IsIFBGSU5UX09JQ1JfVFNZTl9UWF9NKTsNCj4gDQo+IC0tDQo+IDIuNTUuMC44MTQuZ2M0
MmY0NTQzMWQwZg0KDQo=
