Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C07C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 23:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 664F960667;
	Mon, 24 Aug 2026 23:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xrjeWqk1SUfa; Mon, 24 Aug 2026 23:48:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787615320;
	bh=IT5mnvw2gSxtfFXq6XlEiWF9B9JvCvASB9cTcyT8t2w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0idzTMcKsI0kdRXIVuaLHAExGSyx63D4K2CZYqXKSjjbPRAcg6w40zyP+pjBB1Ekx
	 XTmOR0zBwxMtyYXNzgnPaUeFQgqofdsl3RCA0jOM8XQ5J2K1GKd5q9L1muw6zN4ev9
	 cS7sFPWacG+7o8rQMBZxGxEcWvmlgFR+Cr7UT9mwsleIaUBqBn88w//0DFrA3Tv4O3
	 do3DCi+c47ZaQJmjc7INkWjDtPtH47D6HBwRL6AXkMTFymWsQBA77Op4koO1PofFVv
	 7tYOsJtgwsOc1jZiu/7VnbtIpVGLKToEr3uNIF6xwK8bxBbHWCSf4N8CapLUpmduF3
	 9qJPr9M8vR4Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ACE460672;
	Mon, 24 Aug 2026 23:48:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 135D74B8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F318260672
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oVMgg7dGSqBv for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 23:48:38 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nfepEQEY
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC4F96063A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787615318; x=1819151318;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=T0rqXWX+9OEARFVxzGtUY/hE6I7o1jwGI6dKLZryCx4=;
 b=nfepEQEYvwtwQGzW3CfmC2a868c2vMXvvoDDD/PhmwUaLmpz0Affw34m
 TLpPiucE6R7TkWiBs1SbVOOPi5rTbD4PAbqh4wWTpVYfj7/pdV3g0ICd8
 DSgeQXEbDYMmLoiOtviSC/1k1O09A38rRa/fp+enfjpPmjfwlAn3i7n4h
 5gfqEbyHjVfs9ciiHmL+RIkXSXmENUPOW0eRdT4AovsbIkVL6KhSudvr5
 Pc4yxZ2SYxqMoxqCfB0dT67MCuhSjFZgUtyMC1mUzZ9QEvjvH4LAzVm9H
 OzCyQ73fyU2qzKbpUmfiBn8I8qwps3Lp1cwMKFOCheFYi8hMGe39jdetL Q==;
X-CSE-ConnectionGUID: E2TiAlz9Qk6axAmvzkbrFA==
X-CSE-MsgGUID: 7YNXp5LhQPi5P4Pupvh0vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="113615200"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="113615200"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 16:48:36 -0700
X-CSE-ConnectionGUID: WvAEZSEjSryXSm8wlXQhng==
X-CSE-MsgGUID: 0n2qLbn7SWu0ZzJRRaTrnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="269086213"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 16:48:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 16:48:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 16:48:36 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 16:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyOfEZJwsjA7OLUS63S0DNKQYPGf1xMgSf8Y/Sviw/vpisWUAO2xtxcVFOo4dzaE/SmmCdQiYozZuP4YBInmifn+jWgzE158Wcm3hi6T12bEpLepv2u2zn6lqxY8Zf12q8fybw7La2Cdej2mDj+CAJUmifhECBFH76fhFV57XEY+bWgNG80TyCifR4a1Rct01VHtXeiT3t8HqjN18zmaJCkcHcQ7kGlqmCoWbP2iSvuqk1ujqJvGATn3+gWopFqHfevBhnyh9mAisSbRzv2+2bvJuyg5mPrujJWRFSJUmfzcNdyCxW+tNRflz+TJM2j5wno2fql3TCQaMBCHsD/Ziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT5mnvw2gSxtfFXq6XlEiWF9B9JvCvASB9cTcyT8t2w=;
 b=Z+6rUVwAr6kLPzuUZid1R8n7jyKcoiF+nvXqxCre1FxjUXShTjEtYW3rCS/TBXsf+cv6y1Cbacp5mkTOzhHnMLYdOAAxdA1KjjF1fulP7+KuUZW44z0iKcUieJQBbGYbhcB6kAs0k068fRznpuuwI0zCj9i+G4pd7vYknanbfgOq+CwLuMP7Paz/5JwyNMj06sD6Umj1HxUYj69A4hv6f8qd/XSuJl1Cf87zL1zIXMcPZoaAyRrnFPMsQSq/Bmw/rThdR1rIhoNOc4TPxVOCTRzWBOy+vmwdZFvjjhSk2Y/81N9Pkm5pim8RRn2bHJLFVhl21OO5IAhxLlqZg7LrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by LVUPR11MB9592.namprd11.prod.outlook.com (2603:10b6:408:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 24 Aug
 2026 23:48:33 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:48:33 +0000
Message-ID: <fe1d1e1f-be5f-40b8-8b2c-f3b13cb75309@intel.com>
Date: Mon, 24 Aug 2026 16:48:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 04/12] ice: call PTP link change only from link
 events
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 <alexander.nowlin@intel.com>, <kevin.bross@intel.com>,
 <ranjit.cavatur@intel.com>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-4-9d0731eb4858@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-4-9d0731eb4858@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|LVUPR11MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 0680a8af-7476-416b-af93-08df023a34ee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|4143699003|5023799004|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oXZtYluJZIl0+gvDIIrz17DsyBZrxkXsZ5+vGa9ikEuJHpwfujAdnul2Bcnt5GK1LwZG3UFzhSepyNfERcwfIf+5+P6t7Ked3lLQMBammuu1oG9Lcm/i8LP/E1IrDgeXV4U0/zJvDqJYHrTHqLTIVcPvcuxrSMcpS6eS6KJl9NVoskS8PnvwWJ6hgKyIhf9wjijReDV6k6e4UA7zt4KzU/tPEKt1hZb7/8FdEMx8SpO9CbbeibLjBAX1ARs3jnh+vr50aXO28MfrEy6SE5eHIRvTkeOohfjfF2af6Y7JSiqU0BhaQLR1+N7dXzcky3h2snEdXiod8JRRNZIxhbypGWydJkUugeCtIEGr4J82jiJWhsm8JnIaGpzH79HME12fCrE2uwH8gMSzgNGciorik0VecUkQoa7W2z49xBdsNzi+ERYP0p5ZQiyfCMdEYwfM3zfopTqgZl13HEqWwiLMdSk4ibWSqcT9MEFNQ4zVNveFtCZ1UB+u9idSWtzIeld+PgM4uhP4Dh5thbJa0Qa+GFO6gaDOmvmejPK+DTxAwoxTGkVP2GEtBkqwKimNxTWr2IjWcRm2vf9dt8S3U8pPyca97ZuXP2IAfLb+yvrytHEDd3T3GYWcJBRBP4o9k3sDfQGSUvwuBF3hmvaFzGvBu48SuDjHRxk/pavUhJH1uOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(4143699003)(5023799004)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkYyeGZ3N21vNWFmVkVTYXRuamdUblVXOGtrcjdzMFd1bFl2cVN2MTVrNVBj?=
 =?utf-8?B?RFU5blcrRU0vNmdIcUxMaFdHWkJjMHpaWGRGNGNtV0s1VFc1SnM0K0cyS21W?=
 =?utf-8?B?dkVzOGVGQTJDWlF5TEtBdkphQndoWGZ2RU95TXdVVDA1aUdIemZaWlVhZWs0?=
 =?utf-8?B?SG5oY2U2Y2lWVlByZHFHdy96TVJjUkxFRGFyYmh6Z2lRL2dsSzFpWVdPV0pi?=
 =?utf-8?B?RDQwaWVjU00yRGRpZ2trVVo1MTZoRSsxSWNtNll5MXdFeXBiME52dU5IcEhq?=
 =?utf-8?B?V3Y2dkx4UGZLd1lKQkFtSHR3MThKbUxvV2k1b000Vlg3QlpQUXczRXBGbndX?=
 =?utf-8?B?bG9hSUozSldUSjNtN0lHV3FHczE2Zll3NFlnZnBSYVhhTVRIalNzYkV5aitW?=
 =?utf-8?B?QVB1QWVkUUJEQ3A1SUlVclhIZ2JzZm1VM1lMc0ExWW9oUzVwekhRR1RRMmhn?=
 =?utf-8?B?TE93bzJtYVNxL0NqVlc0ZEdpZlhEVVhaVWtzc25iUHlaZzJFNzFJbUZ2a2ZW?=
 =?utf-8?B?V0pFT0ZEcWVFeFlmZDRUWGlSb0NaUzRuamlTM0tzM0d1VzBXbnVncExNdVZ3?=
 =?utf-8?B?R1ZnYktxOHFnMHdZcnhiZGh2V1NlRmNsU2JROGxxSDRldHpFMHVvajNMRE5Y?=
 =?utf-8?B?Y0NrQnUvVzZJTEJNRXNqN3J1ejBqcVByMEhjZmRNZ1d6TEtIb3pNYnRhSWlo?=
 =?utf-8?B?KzI0aWZNck9qYlRSeTBpNjdYRjNOSGdncmFEUWR6cng1NEsvYWNzaWtYVTRu?=
 =?utf-8?B?ZVNZVitySCtFM1o4Rll2V2F1Unp4bnR3dE1jRHJ5N05iZGdZV2gzeTlEckJl?=
 =?utf-8?B?ZmdkTU5kVmppSkl0cmNSNkE0QitwZFI1YUY1VEdxRzY5ZWRmRWpKSVhkRzM1?=
 =?utf-8?B?ZzQ1NDd3Z2daQjNGV25ZazRMMytHUy9zOURUTG5ucFJDZjIwMVE4eitNRkxT?=
 =?utf-8?B?RDlrV3BqNXJJTUV2bHkxMTRaMDhYeGhSWW1Db0JmTkxZQTBrR3ZyMnVTZmRV?=
 =?utf-8?B?dWdvQW1NVVhJQmUrRFRzUWZ2RUlZYWRmbkFqc2I0b2w2NWVicXJ2SFFtSnpy?=
 =?utf-8?B?NGNBRHVzaERUM0x2L01GeFdvbitLMGpoMnpwVitlc09HNExIb0NTM3M3R2w1?=
 =?utf-8?B?OTVzV1ZOdlpYcC9wYld4czJDQi9iSzEvRFpTMFYyMzk4aEtZOEhZUWxTbTJa?=
 =?utf-8?B?QUdManQvbmN5aytqN1pqcW5rMTRaTVM1TnFmUmZIV29STHp3UFJIdUh6TDhi?=
 =?utf-8?B?VGpTVWpOakY0RUJSbTF6ZU40N1VxaEI2akJGeW1ic1ZOWVFwL25TbmNhdkRv?=
 =?utf-8?B?RUduMDlHVEZTb1ROODdaMk1uZTBkaEtqdVpRZ0N2RjZoR0lsOGJna29DZ3ow?=
 =?utf-8?B?dURnNGd1SFlXS2ViN3d1TzAyRkR0eU5KQVlOdkx2SmpWb3NTa00rb1c0YktI?=
 =?utf-8?B?YXdkQXl0a09QMGwxMThwRmFFNWZSaVIvS1Axb1U5Nkl6Tkg4NHNIWDNTeGVk?=
 =?utf-8?B?UFJKNTRpMGRSc1hSYk5IRUV2c2RxQTE3N1FNYy9zNnNtK3UzYVVKRnQvY2Za?=
 =?utf-8?B?VzlWOWNBN3FCU0lzMFI2SUIvd3VFczA1ZjZhV0ZabGRGSE8vME95NUNWWFdT?=
 =?utf-8?B?NmpIbDlOQTFBQkt1VEtMaVErT0MydzdHSVZKRXd6SnNDREQzOTlOLzN4NDZW?=
 =?utf-8?B?Q2hVQUN4N0xrY0J5RUIrbWl6VE9HdEErQithS1Nmczhqcm10Rk9TL05CalFj?=
 =?utf-8?B?cEJmSHQvYkl1c2dNUXgvWUV5VGhzaHRXWmpTYjdrOFZncVgwUHpnWE1CRVJt?=
 =?utf-8?B?dng1ZlRFUVQ4QW9GbHdSR1BPN2ROS2xWR3VIS3F4ZFB0VzBiN1loL1laQS9r?=
 =?utf-8?B?V2IzUzlNK1VTOXM2NlVRTGpGbVk0bnFpa3RhQzFXdUhEN28vWmFoVFE1dzEv?=
 =?utf-8?B?VWlSdzlkL01rRTdOdE1LNWtJNHFSTW5HN1FMSjNrbCt6WGpybVlIcitRZWw0?=
 =?utf-8?B?NFVBU3llZU9kekwwd2ZaZ0Q3Y3lsSHZCUjNhQWtNOURpamUvb3cyUXNsSXlW?=
 =?utf-8?B?L00ybWhqaldZczFTazMrOERtYnluNmdrcHpiSktZbmUrcTRWMzVtUzlnMzE3?=
 =?utf-8?B?UXVXQklxRk1FdllHdHdqVlJkS1FmemhTcG9QdmRLV1FLRDg3d0dKQzdESUpG?=
 =?utf-8?B?TTdpU0pEUDgySUZOODAyTmRVMnphYnNQNlBNMFl1cEN3cVlLVURZU0FFR3Z0?=
 =?utf-8?B?U0J0UG9PQjg4WmQ3M1RBb1A4UGthbHpGQUZmQWJVZU9VTE40a1NVN0EremE4?=
 =?utf-8?B?T2NuWnNydEhiSE02K0h3TGs4VFBPclJBN3VPNXN0SHJjS1I5c215Zz09?=
X-Exchange-RoutingPolicyChecked: m9ZirrQA39n0/Gl6I9IetiRLcHHjV+81TOJnsPSzhsog9JcxPSsP2i6+qZqAXFtilWRLRWeIYu1kXscnhh4wpu19fCXQmbkNAs0iZfmG5UtnFAg2KnFpjwp+8qoftpt60ulkXoi2yV2NRNsbp7w0xhG/kUw7kByK9Zq5EP9H/cLI0GpCC5sc1yF6lniRUFt6Alr1CPj7x+kuHiUKrTd6JWD9uMmdfHPPIFhk2Ut+n2fv5grNwCecr5ZTQ+BKDJzLn0bFEannuTda9jfnDbxSFJS+vXPz9yz2PtWWKt41goHpnORVzR3H+oEqhQ8mLVAqFhVGzMbkTUb0GJ08x/3KvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0680a8af-7476-416b-af93-08df023a34ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:48:33.0605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfxiGO8JK2D4U+DR8L3XWbYPUnEYrHU9BQZuk4xCqFVoDUpZNuVgUp6/WJh7zaTMAKRhN9BWPN6n6SamgHfRggEYzM5cYKBPRL2mrvmRDnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9592
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

On 8/21/2026 5:13 PM, Jacob Keller wrote:
> From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> 
> Remove redundant ice_ptp_link_change() calls from ice_up_complete() and
> ice_down(). These duplicate the call already made from
> ice_handle_link_event(), creating three problems:
> 
> 1. Double initialization on link-up: ice_handle_link_event() calls
>    ice_ptp_link_change(true), then ice_up_complete() calls it again.
>    The second call re-enters ice_ptp_port_phy_restart(), re-setting the
>    calibrating flag and restarting the PHY timer while the first
>    invocation's offset verification work (ov_work) may still be running.
> 
> 2. Premature cleanup on administrative down: ice_down() calls
>    ice_ptp_link_change(false) during ifconfig down or reset preparation,
>    even when the physical link is still up. This clears timestamp state
>    unnecessarily and can interfere with ongoing PTP operations.
> 
> 3. Ordering dependency: ice_down()/ice_up_complete() are called during
>    reset sequences where PTP may not be fully initialized, creating
>    edge cases with partially configured state.
> 
> The link event handler is the correct and sufficient place to drive PTP
> link state changes, as it reflects actual physical link transitions. Remove
> the calls of ice_ptp_link_change from the ice_down()/ice_up() flows.
> 
> Initialize the link_up in ice_ptp_init() and ensure that we check and
> restore the link status at the end of the rebuild flow, ensuring that we
> initialize the PHY timer appropriately after a reset.
> 
> Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it void")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Signed-off-by: Petr Oros <poros@redhat.com>
> Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 11 +++++++--
>  drivers/net/ethernet/intel/ice/ice_ptp.c  | 38 +++++++++++++++++++++++--------
>  2 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..bb631ae9e67d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -7794,6 +7792,15 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>  
>  	ice_update_pf_netdev_link(pf);
>  
> +	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) && pf->hw.port_info) {
> +		bool link_up;
> +
> +		link_up = !!(pf->hw.port_info->phy.link_info.link_info &
> +			     ICE_AQ_LINK_UP);
> +		if (pf->ptp.port.link_up != link_up)
> +			ice_ptp_link_change(pf, link_up);
> +	}
> +


Sashiko says:

> Does conditionally skipping ice_ptp_link_change() here leave the non-owner PF
> PHY timer stopped indefinitely after a global reset if the link remains up?
> During a global reset (like EMPR or GLOBR), concurrent rebuilds are triggered
> across all PFs. The clock-owner PF iterates over all adapter ports in
> ice_ptp_rebuild_owner() and calls ice_ptp_port_phy_restart().
> If the clock-owner PF executes this before a non-owner PF has finished
> ice_init_all_ctrlq() or cleared its reset state, the SBQ command fails.
> Previously, the unconditional call to ice_ptp_link_change() masked this race
> by forcing a successful retry. Since ice_down() no longer clears link_up, and
> the physical link may stay UP across the reset, the condition
> pf->ptp.port.link_up != link_up will evaluate to false, leaving the non-owner
> PF's PHY timer stopped indefinitely.

I think this is correct. We need to ensure that we restart the PHY
somewhere in the chain after the CQ is active and the timer has been
reconfigured by the clock owner. Will investigate.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index b8647a39db6d..8aa49dda90a2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1327,14 +1327,14 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  	struct ice_ptp_port *ptp_port;
>  	struct ice_hw *hw = &pf->hw;
>  
> -	if (pf->ptp.state != ICE_PTP_READY)
> -		return;
> -
>  	ptp_port = &pf->ptp.port;
>  
>  	/* Update cached link status for this port immediately */
>  	ptp_port->link_up = linkup;
>  
> +	if (pf->ptp.state != ICE_PTP_READY)
> +		return;
> +


Sashiko says:

> This is a pre-existing issue, but is there a Time-of-Check to Time-of-Use
> (TOCTOU) race between checking ICE_PTP_READY here and module unload?
> In ice_remove(), ice_unload() is called which invokes ice_ptp_release().
> This destroys the PTP port mutex and the kworker. However, the background
> service task is not stopped until ice_deinit_dev() is called much later.
> If the service task processes a link event concurrently, ice_ptp_link_change()
> checks ICE_PTP_READY without synchronization. If preempted immediately after
> this check, ice_ptp_release() can destroy the resources.
> When ice_ptp_link_change() resumes, it calls ice_ptp_port_phy_restart()
> which attempts to acquire the destroyed ps_lock and queues work on the freed
> kworker, potentially causing a use-after-free or NULL pointer dereference.

I think this is best fixed by having ice_ptp_link_change acquire a
reference using the kref in the first patch to ensure that the port
can't be removed until the function exits. Will fix this in the first patch.
