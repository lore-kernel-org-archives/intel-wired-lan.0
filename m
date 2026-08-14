Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F33EC5CFC1
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Aug 2026 15:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0174340D5D;
	Fri, 14 Aug 2026 15:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i1shZxuZTJDu; Fri, 14 Aug 2026 15:44:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B065E40D2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786722291;
	bh=x5TFcj+dnZXKq1m5Q6nIrcGk8b8aIVbLQe/FFlenyy4=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MccX8qclarxdpm9ibDgPbXb5zcvgnXYhjPVlLRls/AZ3JF19OSFrZvsT4657gVnxf
	 D0tUJvoIL6hrW2hfqr1wm9tArBSNLbZ3Zt9MVQlDx9TChFNT1xxUwrBmmClXNn3A0a
	 u/h6ZrUxX46648+m2wZ8Xr5um+LwvE1ih71eB9/Y6sksMbuA8tSypL9oi3130uBZ88
	 nv40GGMXtMxPUMklMgJvSOtK7RZKk098ET9pt9fJnZG6l+FOmkauivzS0Ls3Kpar5e
	 lhVq94pmInJs04NEP4su0i0rERsz4eYC6ZnJs8bwRdOF9DdsnhJ/ZHg+bVDdHd6hMf
	 9QPuRQZ8USplQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B065E40D2D;
	Fri, 14 Aug 2026 15:44:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C5BD62B2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 15:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2995400A4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 15:44:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2h4W3UgfHo0I for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Aug 2026 15:44:49 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D39654005D
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D39654005D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=R1f3R1ci
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D39654005D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Aug 2026 15:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786722289; x=1818258289;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x5TFcj+dnZXKq1m5Q6nIrcGk8b8aIVbLQe/FFlenyy4=;
 b=R1f3R1ciRk8lo9VuuG3JiiZZIey5pwvMxsAJgcDFPybs/K1VHiq+YeRU
 nCsvb7F7ARspcjFLpKKvbn6T/c1mF6IXyJCoUNrC5hvjvgQsy8HSaFgJu
 IIR6Cd/2nkPpRhbpIDmfAGbPQZhGAIVZA5vyavyqaN8TInhT4DUSB7pHj
 /C0kcTHbq5NEfLCe0ACRh+e0d21AJN9dkqzDDtOO/9gz8sOO+hpbakqWd
 5EBi5HRNBC+a24mmo3wlxFWyS0HjRCvIKdSsygYPqiAxLJ9q6UPRkiTVH
 9+khrcahdcslWF8ENJaNWWR3Z2H1VH/s9Yk+HfkJ/Fokd/DRMgqoruRU2 w==;
X-CSE-ConnectionGUID: m6qZpWiiS6uhevvxHDtikg==
X-CSE-MsgGUID: fHBUMmvYSBSeqQnB0PWoTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="98660038"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="98660038"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 08:44:48 -0700
X-CSE-ConnectionGUID: AckQrS1pThO7hmwiSgEPgA==
X-CSE-MsgGUID: R9FQ3vPdQhGwcp5r9E59Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="267742458"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 08:44:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 08:44:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 08:44:46 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 08:44:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbPXJD8RdYoRW1lQLWTocivHgQFyGFMir+NaqeZ/ju3YHAh0IL2yDdhalSLFY3eym4POJsuJOMT7KoMGMxsv3lV9yqqyyS7RD/Tr5Fcv7S+eZDkzPhRD/tveEq6zTll46UuKVFiQpIctAwx7GGxAv/lfH56HVOpukRHYc8GS8RS9CKqxMi25OXhohlSuwX/blYiE0F8wWWrj3CPUMEY22R8iSCaLCD8Prb/UoZQZ8tBwMbv6xgl9lyQukkjv1j6L08+IIaQJRpIT5N5KSMH6vp984wcHnupjeZHR+RCeKPgfFMHXexhTygTcOXgbSjiImxL1DiW4w/hy1AD6nAqZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5TFcj+dnZXKq1m5Q6nIrcGk8b8aIVbLQe/FFlenyy4=;
 b=kVRwFMjRYRsPVxCJJKueNrRojfOOLyxpIXwvfyUd9tz5mY0KPYBRNPmChErEx8SqF2EzMxnIoW45nyfYICzt0VrS0GNgK90E8dfd+cURfk4EJxk0+Tw6nLIRR1lx/IRoy15zh3F6xriwKJO4LgDEA3aiLL7YxoNcZzKGVNgWtwFojjpm8V3oQxmtBsIC7ws/dciymhbhdspQpSAJDaloiG2nLWz9yUtX06iFR73eYraUx5C7Q5wlKscyUvEly4qnXCCApd6Y0T60ugFohy+sDpKM6ltP1VgoVGw/jCcV02Et/71q0NfacZKW+Ycg5XzFoZhhVV1XUxebSPnhkdTXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DS4PPF641CF4859.namprd11.prod.outlook.com (2603:10b6:f:fc02::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Fri, 14 Aug
 2026 15:44:44 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%3]) with mapi id 15.21.0292.024; Fri, 14 Aug 2026
 15:44:44 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Olech, Milena" <milena.olech@intel.com>, 
 "Tantilov, Emil S" <emil.s.tantilov@intel.com>, Mina Almasry
 <almasrymina@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ijae Kim
 <ae878000@gmail.com>
Thread-Topic: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe
 failure and on remove
Thread-Index: AQHdGFUgbSQp0uR62U2CV57JDEogH7Z615wAgANyMgCAH40KAA==
Date: Fri, 14 Aug 2026 15:44:44 +0000
Message-ID: <SJ1PR11MB629769E42A2223130F20915A9BDA2@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260720143511.43408-1-mhun512@gmail.com>
 <IA3PR11MB8986986280690863E016ACA0E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
 <CAGEsz8HNGUXsiZ_4Eg6atPjzWnTbWoxDwGVybgks3DmGhyH-=w@mail.gmail.com>
In-Reply-To: <CAGEsz8HNGUXsiZ_4Eg6atPjzWnTbWoxDwGVybgks3DmGhyH-=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|DS4PPF641CF4859:EE_
x-ms-office365-filtering-correlation-id: 7d32d2cb-04e6-4da2-8ea3-08defa1af647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: EImBzzxv3s4eknVb13q9fzVd68+3Y2ggVAx6hlXP2/duKNpj/UGzPy89e2cbq5NclkBxNBMJC3XsKm9+mf+KvNSDUSc86T7Ig5hkAAxux+37TbzbujVKzYt+N0hHJpEK5OZvXdIHnl+O5ZixnkMyY3kxAwNky5FF3mcGF/f1bwZtQfJwkNV2Bp28Q78AlWqU7zFiaE8DXGkQtOkNVnfjvtiHwqFUoUYb+HV+SUYTklsNyUde7IcQZV9Rp2uiwQRyiZ9bY/+8ISv20/T/ExYlQTCAzgwZdQqv8SFPgfwRNs1R/p3n6oOR3r72cvO6dm8ef5VR16cRdGJnyDQ72njwz+E6s5ejsy0ynjsS9KCbdWAvrF/W7D93wDEJwzHW/gtGwKhR5mQHlz6+6yYyuPqVnNzKWiOUwOIP2g5C+YqI5M2wUl/5VYyBYQelyB+K+s1uHDW8B6A5wTm0ebSanFBYluXidUPt3G+e7sEkOMT2ROw6dtMXPnsORHTj+mY0I6ZYS5dKztbnE6W2NOMZFukDC2Ymc+0WYgd3YbpP4SpDRduSGMSPovDrGuD3pFh8exUljaYORUANO1BHOIIPCk0J5Z+5XYW6D6SpOPOCLd08CnsFxemoSKr1twlDK4tHImtVAZEsE0F5IQpKSdznH0mTbk50XbAnnzWCrSb/r3mhl+Nzsxf6W9ODqmHfYIWjlDgt/Jl+B9fy8wkaWLex4UexzDfWgi08LbdMWvcdOOF320M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6297.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGRsQ3lBR3FENjQvYTIvVzhGTEYycDl0WU5aS24yOEZia1pDMm1DUlVDU1lj?=
 =?utf-8?B?akVvTWdCTHlaQkphclp1QVQ1ajIvWFN5UmJTaDBSUnM3eGp1U2lCRXBzOW9V?=
 =?utf-8?B?M2Y4VXZRdnMzN0VnTHVpaTNpNEhCUm5QV290Tlg4aW1TSFM4UUhhNTc3bU9V?=
 =?utf-8?B?cU8rVzJmc21vY0xqZDBZQTVGR2lQRXBNa2xpNDZ5SS95T0ozMy8vWHR3cDNC?=
 =?utf-8?B?NVFmVkVoZ2x0SzIyQ2g3YktJM2F1ZVpwVlJNNHZvbE9XTHZ2RGl3TkZNeGYy?=
 =?utf-8?B?eVZwSC9NUitIdEx6Z2VscW5UcE1VT0FaUDFPUWM5WE9jS0kzQml5R0Nia0lY?=
 =?utf-8?B?eTVSeU9QNzJWdldybk1sTlQ0MFd5c2xYVUlsMCszcG1RN3Y2UFFIaVBMd1ZI?=
 =?utf-8?B?ZDRTQzFvWEhGajRpb0FnL3VuSzhEeXQ5NmNacXc3dFcwS1V5SGV2UHM1bkFX?=
 =?utf-8?B?RDRaVSthSFdIaFFBYU9UMzRIVHlYSHpwN2VKTzlZZEx5Y3BTMGk0UHY1SHBl?=
 =?utf-8?B?WlBrcWJuQVBQT3U0MWxzZldaaVdiSlAwdVF2UitKZThjSkdGTWsxVmdkbzg3?=
 =?utf-8?B?Sm1mNEpiaVBWTHI3akNjY3pya3F6WnBXVmZ4anE2YzhhTXZIb0ZLcW9WeWlj?=
 =?utf-8?B?RE8rZGYxMm16dzhQdXNROVVyM3NTTVF1cmNaaE5wQ1doZE5wT0xMYkZwTTha?=
 =?utf-8?B?eXB2Yk5ZdzF5VTVnVGRHcUJDVXdZY1lsZitxeFdYbzdObmMvR2hSRFkycm8x?=
 =?utf-8?B?SEpyeDZQRW1xRDI0T09jaEF1bEFOZGRTeUEvRDFRWTc5c3hTTG5rQmlnak43?=
 =?utf-8?B?TDVSSHlGQVFkeXJZekYxcnc2UitXY3FYS2VSQm82R0V5TFNSWWNTSWQrK2R5?=
 =?utf-8?B?YUVEa2piYy90WEFtYTRXamUrQVlwR0I0K1hoZEJyNkVsLzQ1ejZRSmd6dkI2?=
 =?utf-8?B?MzlITmNnWmxjTmgvWWRKellnYUd2UWJzNms1TURnS1N6WnJWMnM2WXR2eHBz?=
 =?utf-8?B?bjdwWVVzVEd1OVBNMGtCNURoM3ZjRnlSSVc5OGZtL3lYQmwyWW5uOWlNOFY0?=
 =?utf-8?B?eGpjYUltYVYvL1RIZmpvQ1R3dlZscmZvbjBzdE4xV25LL0JONUlDR0JpRUFj?=
 =?utf-8?B?VjNwTjNnV2RBZXVJdisvUjlQRHNCc1VvQ3RCMnFHdXFUb3VETzFpN0xLT3kv?=
 =?utf-8?B?eE4rVjNEY3JWL2pJTng0Y21zdWl0K29uUStiRG1QUHN0WllxOFUzSXJ0SzFC?=
 =?utf-8?B?enE4KzBQb0FEN3daRDJuTmdsQ3FFQW95K3p1eWdPVlJqZExKYmJ6dCtib2VO?=
 =?utf-8?B?MGJRcTVqWXVxc2xnazBnQTlSWkorRjRVemxQeG01c3A2dlhFMFBPVFh0TFRN?=
 =?utf-8?B?aHVxWGlpSjhFdGhMdjN2N2hyN2tLa2J3RVdmcUhPdndsUEZHTXIyZEIya29S?=
 =?utf-8?B?T082dHNWRldHR203RVkyWkxxN3ZrcTJVQ1gvb0hoa2JrSWY3czVsa1ltVnpX?=
 =?utf-8?B?VXZPVHd4VmVmNGJlM1grQjdXZW9UMHhsL1VDNTRHQkVsNklZdEVLRGFldjdG?=
 =?utf-8?B?UGJlUTcvandrK0xEcjJvZEg0L3B1aHYrMjBvbkhsSWdZWk5LRVluY1RVUHc3?=
 =?utf-8?B?NU5RUjVsSFNwZExHN0t3NWFsRktFdUl4MmIwT2N4S0ppbnN6b1FZam9BdmlU?=
 =?utf-8?B?cVdzejdLbG1CVm1OamlOWitNcXpJclRDUTJiRDByNU02blAzTjVxVkFLbjZB?=
 =?utf-8?B?Ti92QU04KzVNZ1ViQURSVFpsWmJ0QUs4WmF4by9aWkIxMTdZU1JhZ2lHK0V5?=
 =?utf-8?B?OXNGL3h5Y1daRWYrRnBoWUZ6TWszbG9hbWN6cm83SXE1TW4yWjdiSGRKYlZu?=
 =?utf-8?B?N3diRkdVVnY2a3IwNXltN1lkWjNDRmhCcWFHSW9MZlkrTzY2YXd3djRZOU1k?=
 =?utf-8?B?TFR5N042MktENE4zSHpqRWRUaXZhZ2Y4MWswcXBPMEpZZkd6ajJEcGh6N0Qy?=
 =?utf-8?B?Y1ZBVHNRajRYTkE1Tjc3VERLRkpEcDhqbVpMK3pnNmpqZEd0S2lLN0dVanYz?=
 =?utf-8?B?bnVCb29UNjR3Y2tPaDhMOWV1R2tqL3dnT1RFZjA4R2k0ODZhZENUK3Rjcko0?=
 =?utf-8?B?VWNmQlhROFhXS3A3NmZrRC9vbmF3eWFLL1I0NWZOaEpiYnRTUTN3RlZOZ245?=
 =?utf-8?B?RDZGS2ZBNFFKR3RTbC80UWpIU3BmbUZEZGVVdVIwZXcrTGVya2dOZlRMeHo2?=
 =?utf-8?B?YndMK05ob1Y4S3lBNnNuanh0S2JIemEyUGtBNU14MlNJeE1tTE5wYkdacUUy?=
 =?utf-8?B?dXJqM0JPM2U5cTl2QTluQXhUalRYVmZ3QnYyZithb2VwTGtkVm04Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bs4Fvt9N226JiezY1yO1xDniHIjThBk/InujjgYmjQF3qemOzRDO2ag0qmfpgt+0R0AFZ07gsYl89qUCeUXGHF0zFSpdGiHlAodF+V0Og5HZNnUW4gbBJGtMBVtkZcdrdCpNDsL2qBwIgPBDcD9kghknHzDWyzF6a9Z5DJaCO2fG98bWzM0o9o/uies/X506pTPUjXICrWxzv+KTSWYXDOw9vHw0tMk3bcer4hgxKs/GgkuS7OYe/IZkxJ3HtVn4tPBdzuInxqPBTjjZKnWkkeePvO8B/0x3c/HGM2eLciwK9olMRaEBoSLrwH8UKfz3MPzaOuWoWINd9/UdX2rs5g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d32d2cb-04e6-4da2-8ea3-08defa1af647
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 15:44:44.0874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDM8iRTHHSAmZO0CY2xYICwmuNBfc+e3/TIJhICWDJkijca29rIBsbLGYCxOJ5kUiyM7YwMfNXbA3ibSBuKKdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF641CF4859
X-OriginatorOrg: intel.com
Subject: Re: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe
 failure and on remove
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBNeWVvbmdo
dW4gUGFrDQo+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDI1LCAyMDI2IDY6NTUgQU0NCj4gVG86IExv
a3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gQ2M6
IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWws
IFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBpbnRlbC13aXJl
ZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgT2xlY2gsDQo+IE1pbGVuYSA8bWlsZW5hLm9sZWNoQGlu
dGVsLmNvbT47IFRhbnRpbG92LCBFbWlsIFMNCj4gPGVtaWwucy50YW50aWxvdkBpbnRlbC5jb20+
OyBNaW5hIEFsbWFzcnkgPGFsbWFzcnltaW5hQGdvb2dsZS5jb20+Ow0KPiBBbmRyZXcgTHVubiA8
YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUyAuIE1pbGxlcg0KPiA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViDQo+IEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+
Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBJamFlIEtpbQ0KPiA8YWU4NzgwMDBAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW0ludGVs
LXdpcmVkLWxhbl0gW1BBVENIIHYzIG5ldF0gaWRwZjogZGlzYWJsZSBQVE0gb24gcHJvYmUNCj4g
ZmFpbHVyZSBhbmQgb24gcmVtb3ZlDQo+IA0KPiBVbmRlcnN0b29kLiBJIHdvbuKAmXQgcmVwb3N0
IGl0IHVubGVzcyBJIHJlY2VpdmUgY29uY3JldGUgZmVlZGJhY2suDQo+IA0KPiBUaGFua3MgZm9y
IHRoZSBjbGFyaWZpY2F0aW9uLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBNeWVvbmdodW4gUGFy
aw0KPiANCj4gMjAyNuuFhCA37JuUIDIz7J28ICjrqqkpIOyYpO2bhCA2OjE3LCBMb2t0aW9ub3Ys
IEFsZWtzYW5kcg0KPiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+64uY7J20IOyekeyE
sToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGludGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5v
cmc+IE9uIEJlaGFsZg0KPiA+ID4gT2YgTXllb25naHVuIFBhaw0KPiA+ID4gU2VudDogTW9uZGF5
LCBKdWx5IDIwLCAyMDI2IDQ6MzUgUE0NCj4gPiA+IFRvOiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50
aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVsLA0KPiA+ID4gUHJ6ZW15c2xhdyA8cHJ6
ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IGludGVsLXdpcmVkLQ0KPiA+ID4gbGFuQGxpc3Rz
Lm9zdW9zbC5vcmcNCj4gPiA+IENjOiBPbGVjaCwgTWlsZW5hIDxtaWxlbmEub2xlY2hAaW50ZWwu
Y29tPjsgVGFudGlsb3YsIEVtaWwgUw0KPiA+ID4gPGVtaWwucy50YW50aWxvdkBpbnRlbC5jb20+
OyBNaW5hIEFsbWFzcnkgPGFsbWFzcnltaW5hQGdvb2dsZS5jb20+Ow0KPiA+ID4gQW5kcmV3IEx1
bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMgLiBNaWxsZXINCj4gPiA+IDxkYXZl
bUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFr
dWINCj4gPiA+IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+Ow0KPiA+ID4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgTXllb25naHVuIFBhaw0KPiA+ID4gPG1odW41MTJAZ21haWwuY29t
PjsgSWphZSBLaW0gPGFlODc4MDAwQGdtYWlsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtJbnRlbC13
aXJlZC1sYW5dIFtQQVRDSCB2MyBuZXRdIGlkcGY6IGRpc2FibGUgUFRNIG9uIHByb2JlDQo+ID4g
PiBmYWlsdXJlIGFuZCBvbiByZW1vdmUNCj4gPiA+DQo+ID4gPiBpZHBmX3Byb2JlKCkgZW5hYmxl
cyBQQ0llIFByZWNpc2lvbiBUaW1lIE1lYXN1cmVtZW50IHdpdGgNCj4gPiA+IHBjaV9lbmFibGVf
cHRtKCksIHdoaWNoIHRha2VzIGEgcmVmZXJlbmNlIG9uIHRoZSBkZXZpY2UgYW5kIG9uIGV2ZXJ5
DQo+ID4gPiBQVE0tY2FwYWJsZSBkZXZpY2UgdXAgdGhlIHBhdGggdG8gdGhlIFBUTSBSb290Lg0K
PiA+ID4NCj4gPiA+IE5laXRoZXIgdGhlIHByb2JlIGVycm9yIHBhdGggbm9yIGlkcGZfcmVtb3Zl
KCkgZHJvcHMgdGhhdCByZWZlcmVuY2UsDQo+ID4gPiBzbyB0aGUgUFRNIGVuYWJsZSBjb3VudHMg
b2YgdGhpcyBkZXZpY2UgYW5kIG9mIGl0cyB1cHN0cmVhbSBwYXRoDQo+ID4gPiBzdGF5IGVsZXZh
dGVkIHdpdGggbm8gYm91bmQgZHJpdmVyLCBhbmQgdGhlIGRldmljZSdzIFBUTSBjb250cm9sDQo+
ID4gPiBiaXRzIHJlbWFpbiBzZXQuICBwY2ltX2VuYWJsZV9kZXZpY2UoKSBvbmx5IGFycmFuZ2Vz
IGZvcg0KPiA+ID4gcGNpX2Rpc2FibGVfZGV2aWNlKCkgYW5kIGRvZXMgbm90IHVuZG8gdGhlIFBU
TSBlbmFibGUuDQo+ID4gPg0KPiA+ID4gQWRkIHRoZSBtYXRjaGluZyBwY2lfZGlzYWJsZV9wdG0o
KSB0byB0aGUgY29tbW9uIHByb2JlIHVud2luZCBhbmQgdG8NCj4gPiA+IGlkcGZfcmVtb3ZlKCku
ICBwY2lfZW5hYmxlX3B0bSgpIGZhaWx1cmUgaXMgbm90IGZhdGFsIGhlcmUsIHNvIGd1YXJkDQo+
ID4gPiBib3RoIGNhbGxzIHdpdGggcGNpZV9wdG1fZW5hYmxlZCgpOiBwY2lfZGlzYWJsZV9wdG0o
KSBkZWNyZW1lbnRzDQo+ID4gPiBkZXYtPnB0bV9lbmFibGVfY250IHVuY29uZGl0aW9uYWxseSBh
bmQgdGhlbiByZWN1cnNlcyB1cHN0cmVhbSwgc28NCj4gPiA+IGNhbGxpbmcgaXQgYWZ0ZXIgYSBm
YWlsZWQgZW5hYmxlIHdvdWxkIGRyaXZlIHRoaXMgZGV2aWNlJ3MgY291bnQNCj4gPiA+IG5lZ2F0
aXZlIGFuZCB3cm9uZ2x5IGRlY3JlbWVudCBwYXJlbnRzIHNoYXJlZCB3aXRoIG90aGVyIGVuZHBv
aW50cy4NCj4gPiA+DQo+ID4gPiBUaGlzIGlzc3VlIHdhcyBpZGVudGlmaWVkIGR1cmluZyBvdXIg
b25nb2luZyBzdGF0aWMtYW5hbHlzaXMNCj4gPiA+IHJlc2VhcmNoIHdoaWxlIHJldmlld2luZyBr
ZXJuZWwgY29kZS4NCj4gPiA+DQo+ID4gPiBGaXhlczogOGQ1ZTEyYzU5MjFjICgiaWRwZjogYWRk
IGluaXRpYWwgUFRQIHN1cHBvcnQiKQ0KPiA+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBJamFlIEtpbSA8
YWU4NzgwMDBAZ21haWwuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSWphZSBLaW0gPGFlODc4
MDAwQGdtYWlsLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE15ZW9uZ2h1biBQYWsgPG1odW41
MTJAZ21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+ID4gLSBS
ZWJhc2VkOyBhYTg2NzFhZjBjMzggKCJQQ0kvUFRNOiBEcm9wIHBjaV9lbmFibGVfcHRtKCkgZ3Jh
bnVsYXJpdHkNCj4gPiA+ICAgcGFyYW1ldGVyIikgY2hhbmdlZCB0aGUgY2FsbCBzaWduYXR1cmUs
IHNvIHYyIG5vIGxvbmdlciBhcHBsaWVkLg0KPiA+ID4gLSBHdWFyZCBib3RoIHBjaV9kaXNhYmxl
X3B0bSgpIGNhbGxzIHdpdGggcGNpZV9wdG1fZW5hYmxlZCgpLCBhcw0KPiA+ID4gICBwY2lfZGlz
YWJsZV9wdG0oKSBpcyByZWZjb3VudGVkIGFuZCByZWN1cnNlcyB1cHN0cmVhbSBzaW5jZQ0KPiA+
ID4gICBlMTA5MmQ1ZTE1ZTYgKCJQQ0kvUFRNOiBEbyBub3QgZW5hYmxlIFBUTSBhdXRvbWF0aWNh
bGx5IGZvciBSb290DQo+IGFuZA0KPiA+ID4gICBTd2l0Y2ggVXBzdHJlYW0gUG9ydHMiKS4gIFJh
aXNlZCBieSBUb255IE5ndXllbi4NCj4gPiA+IC0gRHJvcHBlZCB0aGUgdjIgY2xhaW0gdGhhdCBw
Y2lfZGlzYWJsZV9wdG0oKSBpcyBhIG5vLW9wIHdoZW4gUFRNDQo+ID4gPiB3YXMgbm90DQo+ID4g
PiAgIGVuYWJsZWQ7IHRoYXQgaXMgbm8gbG9uZ2VyIHRydWUuDQo+ID4gPg0KPiA+ID4gQ2hhbmdl
cyBpbiB2MjoNCj4gPiA+IC0gRGlzYWJsZSBQVE0gaW4gdGhlIHByb2JlIGVycm9yIHBhdGgsIGFz
IHJlcXVlc3RlZCBieSBFbWlsIFRhbnRpbG92Lg0KPiA+ID4NCj4gPiA+ICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfbWFpbi5jIHwgOSArKysrKysrLS0NCj4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfbWFpbi5j
DQo+ID4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl9tYWluLmMNCj4g
PiA+IGluZGV4IGFiM2M0MDkuLjk3YmFmZWIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfbWFpbi5jDQo+ID4gPiArKysgYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfbWFpbi5jDQo+ID4gPiBAQCAtMTU5LDYgKzE1OSw4
IEBAIGRlc3Ryb3lfd3FzOg0KPiA+ID4gICAgICAgbXV0ZXhfZGVzdHJveSgmYWRhcHRlci0+cXVl
dWVfbG9jayk7DQo+ID4gPiAgICAgICBtdXRleF9kZXN0cm95KCZhZGFwdGVyLT52Y19idWZfbG9j
ayk7DQo+ID4gPg0KPiA+ID4gKyAgICAgaWYgKHBjaWVfcHRtX2VuYWJsZWQocGRldikpDQo+ID4g
PiArICAgICAgICAgICAgIHBjaV9kaXNhYmxlX3B0bShwZGV2KTsNCj4gPiA+ICAgICAgIHBjaV9z
ZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsNCj4gPiA+ICAgICAgIGtmcmVlKGFkYXB0ZXIpOw0KPiA+
ID4gIH0NCj4gPiA+IEBAIC0yNjYsNyArMjY4LDcgQEAgc3RhdGljIGludCBpZHBmX3Byb2JlKHN0
cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiA+ID4gY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVu
dCkNCj4gPiA+ICAgICAgIGlmIChlcnIpIHsNCj4gPiA+ICAgICAgICAgICAgICAgcGNpX2Vycihw
ZGV2LCAiRE1BIGNvbmZpZ3VyYXRpb24gZmFpbGVkOiAlcGVcbiIsDQo+ID4gPiBFUlJfUFRSKGVy
cikpOw0KPiA+ID4NCj4gPiA+IC0gICAgICAgICAgICAgZ290byBlcnJfZnJlZTsNCj4gPiA+ICsg
ICAgICAgICAgICAgZ290byBlcnJfZGlzYWJsZV9wdG07DQo+ID4gPiAgICAgICB9DQo+ID4gPg0K
PiA+ID4gICAgICAgcGNpX3NldF9tYXN0ZXIocGRldik7DQo+ID4gPiBAQCAtMjc5LDcgKzI4MSw3
IEBAIHN0YXRpYyBpbnQgaWRwZl9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gPiA+IGNv
bnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICplbnQpDQo+ID4gPiAgICAgICBpZiAoIWFkYXB0ZXIt
PmluaXRfd3EpIHsNCj4gPiA+ICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8g
YWxsb2NhdGUgaW5pdCB3b3JrcXVldWVcbiIpOw0KPiA+ID4gICAgICAgICAgICAgICBlcnIgPSAt
RU5PTUVNOw0KPiA+ID4gLSAgICAgICAgICAgICBnb3RvIGVycl9mcmVlOw0KPiA+ID4gKyAgICAg
ICAgICAgICBnb3RvIGVycl9kaXNhYmxlX3B0bTsNCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4g
PiAgICAgICBhZGFwdGVyLT5zZXJ2X3dxID0gYWxsb2Nfd29ya3F1ZXVlKCIlcy0lcy1zZXJ2aWNl
IiwgQEAgLTM2Niw2DQo+ID4gPiArMzY4LDkgQEAgZXJyX21ieF93cV9hbGxvYzoNCj4gPiA+ICAg
ICAgIGRlc3Ryb3lfd29ya3F1ZXVlKGFkYXB0ZXItPnNlcnZfd3EpOw0KPiA+ID4gIGVycl9zZXJ2
X3dxX2FsbG9jOg0KPiA+ID4gICAgICAgZGVzdHJveV93b3JrcXVldWUoYWRhcHRlci0+aW5pdF93
cSk7DQo+ID4gPiArZXJyX2Rpc2FibGVfcHRtOg0KPiA+ID4gKyAgICAgaWYgKHBjaWVfcHRtX2Vu
YWJsZWQocGRldikpDQo+ID4gPiArICAgICAgICAgICAgIHBjaV9kaXNhYmxlX3B0bShwZGV2KTsN
Cj4gPiA+ICBlcnJfZnJlZToNCj4gPiA+ICAgICAgIGtmcmVlKGFkYXB0ZXIpOw0KPiA+ID4gICAg
ICAgcmV0dXJuIGVycjsNCj4gPiA+IC0tDQo+ID4gPiAyLjQ3LjENCj4gPg0KPiA+IFJldmlld2Vk
LWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4N
Cg0KVGVzdGVkLWJ5OiBTYW11ZWwgU2FsaW4gPFNhbXVlbC5zYWxpbkBpbnRlbC5jb20+DQo=
