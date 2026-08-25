Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB35C5DF9C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 00:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7517660674;
	Tue, 25 Aug 2026 00:24:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5k51FUhqo4iO; Tue, 25 Aug 2026 00:24:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787617485;
	bh=APnQLEojM7XnPdh3X+gA+py67Dj85Y0JcAa56x82g/A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NPxHVIq5jPRJhMvRaGUlCcB7wIJKNcHxunGR5n1ReltmhfvO6EagyW/rRiHtb2rzx
	 eQycJ8q5s9z249veKJsMla7Q3IptllnI8xEhBgZF+DdvhzpWGvxJHrFo4DZbzCEqAN
	 Fq+cOLSmR55DFeJnuketmciYDadhjA4GayJ/JZoGQi/H7VT/moUcGBVcl5PWdGp5Ot
	 Lw3M2OraixJM+xVZJdrkmIg7ReXjWkEw9+zHkgWT7ZZMZ3zfAkzDHUbEpTDEP0oiVS
	 +BbHPVXQdiHBulWRxiesI86g/b0yFr6iB5lx1LgAN9IQkrrjUbRUeH4oEXyIWGl4TK
	 upJUWZ9RMzNxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0757960667;
	Tue, 25 Aug 2026 00:24:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD8214B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3A454005F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:24:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tvwVQ1UguZcE for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 00:24:43 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=POxD5RyM
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AFDA040050
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787617483; x=1819153483;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zkDduwOtDdD8AzSFvhAQR/pmV1FXalKeoh1ZSPkhCnA=;
 b=POxD5RyMAKQPIymdsWQjusj52Nfs9iZ9B/+8OXKk25Je/C8+/chWqLR1
 bXk2xwLT7N6jsir9jt25A1C7GW0JJn7kmIo7FPZsg6PKgul5H35ide86c
 SwBD9IA+BVvJG47Dkfti/y0XEtHa9wHWxvdrOfFMnV99glXwRVbLy6V8P
 rUjCMf/DRZ+3RB87WcTZBmbRSzIzs6n+R+B2vq1pouzDJq99qLvnzfex8
 0JeZxsMYYr71X9vYlcWcqoHCHzgYTyVv0YH4jj8jFfBUVpkC7daxZmHSi
 4ev42RSpoWwVAkuYHf2c/pgBzo0W1ACcUybwXjQxySJPZRPLEESeAwwso g==;
X-CSE-ConnectionGUID: OkHYKnEzRW+TMdff0R27rw==
X-CSE-MsgGUID: bOjA7PUwQdmF67Ynnoel6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99428438"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="99428438"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 17:24:40 -0700
X-CSE-ConnectionGUID: hT3Lkne4R3qv6oAFOxmk7w==
X-CSE-MsgGUID: 7lzxvMN/S2CNEuBacwUTng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="305381907"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 17:24:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:24:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 17:24:39 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:24:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSvLoa+WYFfwYokHcmJZEe2hN+Q9ijsLdOjuWLxpIaZhkz2vN9gwJKv2HT7vdL5MSaVzcsos3TtXZIJujdc5aVAC4SpyFn/eNxaC7jnarsKphuCfhqAFxaVRraJmQiZQ9ddWN5tgUqABes5Hq/+I+AF/+MfvuEx99tafaoF1VeXnuuuL/PJW6AclOBKvMIGiRfIUAOUVDGyPkC97sc0+1F9e2K3Evj2iGC/VqHeLHMyYyhs6ZuoA30r96NPlvaPzx2lRt+5s1cQUlw22TsTy54VRJuwivk9BxqIenumxs12/anUceK7OH/b+6WOKBKkXs4c29QA6Rsm9rw5cQLm8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APnQLEojM7XnPdh3X+gA+py67Dj85Y0JcAa56x82g/A=;
 b=wmsllMKxLcGTcwVoShRRqgmSGaif6q/TDCcAmA74uEMxH0qwr7tzYERqXdcFbrC7OK2mMWttRPrYAtqaJ0+MZKeq51e/gxl3iQhbLabNa5JPRjmH8ZtrrF/QW81ZeGmkIsvCgZxMvH0kkN782f3Bv78wyBzFJ0lC4tgYsvogHoUHlb+8LWD4IS3B+qWuAu4zifEK/q9fdbDXSN2WBMo8Ie9Q1ZN0BYABHJ7exVRSqGNxy6+0FFelfd86fMEoezAJb21bqcW+OWt8OsM6a9Hjb/gaflmg5Qa7UuvYAnhUmQIoWIkwl24smepPiaUfFSOTXxWnpGra7VX9LWNgaKPS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA3PR11MB140164.namprd11.prod.outlook.com (2603:10b6:208:548::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 00:24:37 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 00:24:37 +0000
Message-ID: <75884c38-209c-476d-9796-50255a200cbf@intel.com>
Date: Mon, 24 Aug 2026 17:24:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 11/12] ice: skip reading Tx ready bitmap on ports
 with no timestamps
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 <alexander.nowlin@intel.com>, <kevin.bross@intel.com>,
 <ranjit.cavatur@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-11-9d0731eb4858@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-11-9d0731eb4858@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA3PR11MB140164:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e480de0-f669-43d2-36b3-08df023f3ec9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|4143699003|5023799004|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: vGhFxqNakHQSzTmH9DQ7P/QpHoTSITZbY0PwF3JqpP858SDRCtjf2HRArkUFbxXn//OigUSsX08aQitAvHv1n7KIONn1Lm/76iRYWRUqOoj5Ikghb7Gy3IPuQll9rpNaK56UlZqNIpOgaf58l871o+l3AOBV3yqSrofn6t88s3kZWC5O++25Fsy8JAo/3IfOPjfZaxH70bLQ1IUQP8gFn9aw29HPv9EDImBJ8Gs00a1jv4NMUERIpRYGwVDFAlWHhXdKkIdfEGpYT5Uw5JRLZm4wP9ySpIeVJheVwubuffDKjQv2I5ZiGc1kBkw4hd5HYe1e/uQXsCcuSlkMKyOoAOSo6JPzGTUEFaDEFDUu89E/fE3FR9Yqzh8Z619X5zj7irPjVdE3ZH5lnFLV0rxZm5wD/PO3sbLNnUbiBQYyVSB9fJ30SUzyRXe7b/j5GaaW+BdjZhtpAuf0jHy6j6KsmSw/IgHJ2REZmc9y2oY1sf0M6lPnnpOsU7IuSd9DhbFkOJ7tI13MaXzvjp136HRdtPfKiEQ+49ez+QMns5DtSHcSDcp29CZxqQ/YCZtBN5g9fCy9thKaL50y2PqQgph29SRG8BRx9RaBkzrdSTOrPtoUsZWpgRPY4TiCoV7UI15Un0xq1H+i7QDMuJ4LVbfC5Rq++/z8YV403t+g7fllzdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkRLdTB5c1FHUUxyN0hOTVpGaXFERU9JQlNuVTkyVUQ4cmNrdHA5Q2UwZTFU?=
 =?utf-8?B?a2lQQ003YkJmRVE1N0xJTkFoZHBPaWRrZ3podEJMeHNabldaZVd3QnVYY2lR?=
 =?utf-8?B?T0RTU3lCOXFaTnAzQmcyWlg3dklIRm5nK3dxbWtOU0U3dHRFR1YyZ21vUUJp?=
 =?utf-8?B?K3Vlc0o1TlA0bDdvM3BpWnZBU2lWcEQ3aEVuaDV6ZFc3ODFYcTJnU1VXZC91?=
 =?utf-8?B?ZGlkUjk0S0pOZmxrK2NXM094ZG1zRVJtakdVZzM0UWtTaGh3UWJkb1ZFQUlz?=
 =?utf-8?B?V1kvSWpNVjRIa0o1UkRTdUx3OHBVMlh6M3VYZlpEbEJEL2JUbUNiQkwxSkgy?=
 =?utf-8?B?dXFLUGFJNTFTdHJTQkwwQUxhVVM5MWxXUENweGNORFN6cGdTTU1qMHF3Uklo?=
 =?utf-8?B?L0hzaXErV2hpUzVrdU05TUZ6L0ROK1hwUDc3OFFTUGF6ekFJeHVVNWZMazJa?=
 =?utf-8?B?TGJuSFBpMmIySi9yKytkb2Rma1cwbjIvczJQSHNXMWE3YXdnU1lkQ01oZ2Ns?=
 =?utf-8?B?SWVnQkNTcGQ0MlRob21tQmdjaURzWFpmVTJqbzJGR2hoSFVkbFJMN2lwUWJ0?=
 =?utf-8?B?OStvQkpLazlGKzhWVkpkQmR0N3J3SE8zbE4zL1RWWXBZSUxmOW80RkpJV1R3?=
 =?utf-8?B?QWdlSlBNZ3VyTmNyQlViWFBZeDBYZ2pXQnZBTVVCMjN3aE8wTFF3aElxd202?=
 =?utf-8?B?TU5DMXBRMFlrUCtZb3dmYUpueXZpT1U3MkNYMDlaMG1OWXNwZ0NQYVNPN3FQ?=
 =?utf-8?B?ZTZCeTFWSWZ5M3RIeGp4dllJdlEvRTY1MGhmeStzVTVGamdJcWxXTDNnOGFn?=
 =?utf-8?B?eEhJK2RLOVpyQ0dwc21zU0hPakZYQ29aWUdJcFh4b2pLTUtLTG0wVmZmSEhU?=
 =?utf-8?B?NTR2cWZjNTl2bVJVMG9Gak1sdERTdDVCTUJsNVBRRktmcHJUNmU5N2lQOU8y?=
 =?utf-8?B?VnY1R3kvRUJsVk1RTWt6L2FmMEVXVFBMeHYyY0grMnlUdXRVVXhER29ZT0I0?=
 =?utf-8?B?M3k2TGlxczVvVzV4TEtmeXk2aVp1cVI2QU1WVnVOMjZTdnZia1RUZmpZaVVI?=
 =?utf-8?B?SXZqaWNXVGdyUFQweUs5NVBna3NaWHA5YTRrVm1pNk9BdWIxRGpVVy9uWHF3?=
 =?utf-8?B?clVsd0wxZnlHSVBIbUplYWh1R1prSTdRNi9WeDUra3dMTGZ6bzF5OWhKVGh2?=
 =?utf-8?B?SjhHQ3A1eEZaT2tKT0V1WTJUTjNST2lIR05rS1RUMEpxRWZDS2N0WTMxYm13?=
 =?utf-8?B?MEJYL0czR3dKcW5yVkdFdG1WVGduYzM3RzZpSTI4KzlLZVlzcXB5dmhNbHpZ?=
 =?utf-8?B?VzRrYkVFckYvTkd2WlRNbkVIUi8vTU5EaVBYL1ZGY1hRWkcvWmdWSS9Wb0ZX?=
 =?utf-8?B?R25VTFlEeXVFeTJhV0NWaVhHcm14U0s3UHdHbys5QXlNdGZBMTBmOFlLYlYz?=
 =?utf-8?B?dDRFTDl2ZXEyNWwzOUMyRGNJY0kyM2loRFNMdXpkc1l4MmQ1WmgzaG4yVUw4?=
 =?utf-8?B?eG9mcjZ2ejgzWHdNUlNnVy9EVTZJdVFoTkhqbXVzY0ViQXlaMUhrWnVrUVlG?=
 =?utf-8?B?SXJjazB1N1hzWXpFcWlWUStsaW54VTVxcE1QZVdCZEtjLy9HM1RlN05TRTVn?=
 =?utf-8?B?K1BjTXNEWXFPWVI4V3hsVnplTW1raEZLZlErdnd2N1hBVEdibE1lUlBwWG0y?=
 =?utf-8?B?OUdQNHJZOXY1UmxMOE05YklRLzBSOFdXYjQvQnA4WHFLc0FlN01vYlBDc0FI?=
 =?utf-8?B?TXlnM0gwdEJMZTJxY05nK2drTUJTMTdBTE1sS0R6WkUwYXVLNUpZU0VNZkRZ?=
 =?utf-8?B?dlNxbnhQOXEyTS9JYkdvYzl0UENacFB1cHlaN1MzdXNTMEJ4U2Y3UGlISEow?=
 =?utf-8?B?bHJla0tnYVhGTm0wT3V6dGhzMU8wRHc2bGFtUFJQYlE0RjR6aGtaS3I5b2Y3?=
 =?utf-8?B?UHJXODdUZjZSdWV3eEdIY2RSMDhtSXo0Zkx3WnJZM05PaGZWRWJqQ3NqU1Bh?=
 =?utf-8?B?NWJvaWNBOXBxS0cvOHZkdkFxNWt2c1RFN1RqSndtZzdiVlU1MWNUN0lpbGI0?=
 =?utf-8?B?cWhXS1AxUVVHcFUzbjdnWmtXUGI3T2M1NU9YWENVTnpVRitDRzZHeEw2Sjkx?=
 =?utf-8?B?QzV2TWkyWlVpUzFIY2FWL3JWZm5ScGFHZnZnWStlY2hkdDhTTUNYdTlPZzZ5?=
 =?utf-8?B?WDl5SkNMTjBPY3lXUFVMZmNZUnJab3cvSytLSWdRd1hnYmJhTW5YVDJ1L3l5?=
 =?utf-8?B?K3YyVnZwL3RObzlwcG9WR3lENTFoL2JZb2trYUY3R2k5MHpUOUF2V3lWVnJk?=
 =?utf-8?B?c1hKaEpuMnRWdDN0Z0tvMzRVVWtWeks5TGxadysxdnZDQmp6WE1Idz09?=
X-Exchange-RoutingPolicyChecked: b17UdpLK0mCCimDEbLCECvtG1S7tti7YEBakqdzzUS/ZYAbzjGMle6NXKbM4Z8+Xcdf5Mv8f4KmtgLTIArDn+7MrpxCRVvMg5cJ5qqFFtgtyQU6xCx2AC/QzGn06ALq2xPUo8vGRpglJK3zzXK8NGHl3SOPtgLrAIM7QsH/StB9xbDmEffM18AuOYP09px1QWFNTMkqVzX1clnW92MnBQmnEsrz4OdZfR8bMfRTxjFDQ5FgTlYVrRiHQTOBLx9+9FF/kyi6UShUKbGOhZy2Kj9eiFEGLMsIp1gdqL6D7sP9MosivaWzuPM5RnUp2AQFPy3/UZ6KL5VapO4GKpurf7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e480de0-f669-43d2-36b3-08df023f3ec9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 00:24:37.0928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4Vd8rEh2IWC6tqMXhRiMH/XN1DF+rAHZYClJHXlp7jSaLKDoHTkxBEGQ+tfRNB9nAubJmagzKdZqKLL5BlecjWS5oc2nbXRhfOW56utl4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB140164
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
> On E82x devices, the interrupt for Tx timestamps are handled by the clock
> owner. When an interrupt with the Tx timestamp cause is fired, the clock
> owner PF iterates the list of ports and checks for timestamps across all
> ports.
> 
> The existing logic reads the PHY timestamp ready bitmap before iterating
> the list of in-use timestamp indexes, even for ports which have no
> timestamps waiting in the software timestamp tracker. This has a
> significant and measurable latency impact on reporting Tx timestamps.
> 
> Check the bitmap and exit early in the event that there are no timestamps
> waiting on a port. Observant reviewers may notice that the check is done
> without acquiring the lock. This is fine, as the only thread that can clear
> in_use bits is the miscellaneous interrupt handler. Whether the thread sees
> or fails to see a new outstanding timestamp does not affect correctness,
> only determining whether or not it should do extra work.
> 
> Using the ice Tx timestamp traces, with a simple ptp4l setup the average
> latency appears to be around 175 to 200 microseconds with a few outliers
> taking hundreds of microseconds to be reported. With the check to skip
> empty bitmaps (and thus skip reading the ready bitmap for inactive ports),
> the average latency drops ~50 microseconds.
> 
> Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 8c2dd83d8d6c..b337247c94e0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -573,7 +573,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  	pf = ptp_port_to_pf(ptp_port);
>  	hw = &pf->hw;
>  
> -	if (!tx->init)
> +	if (!tx->init || bitmap_empty(tx->in_use, tx->len))
>  		return;
>  
>  	/* Read the Tx ready status first */
> 

Sashiko says:

> This is a pre-existing issue, but could this lockless check of tx->in_use
> result in a use-after-free or NULL pointer dereference during a cross-PF
> teardown?
> In ice_ptp_release_tx_tracker(), a secondary PF undergoing reset sets
> tx->init = 0 and frees tx->in_use:
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_release_tx_tracker() {
>     tx->init = 0;
>     spin_unlock_irqrestore(&tx->lock, flags);
>     /* wait for potentially outstanding interrupt to complete */
>     synchronize_irq(pf->oicr_irq.virq);
>     ...
>     bitmap_free(tx->in_use);
>     tx->in_use = NULL;
> }
> Since synchronize_irq() only waits on the resetting PF's IRQ, it doesn't
> block the clock owner PF which runs on a different IRQ.
> Can the clock owner PF running ice_ptp_process_tx_tstamp() evaluate
> tx->init as true, get preempted, and then dereference tx->in_use after
> it has been freed by the resetting PF?


I believe this will be fixed by the patch which removes the call to stop
clearing the tracker except on load. I will investigate if we need any
further change as there may be a similar issue with teardown. We might
need to synchronize against the clock owner IRQ for ports using the
INTERRUPT_ALL mode.

> This is also a pre-existing issue, but does adding this early return prevent
> the driver from recovering if a hardware timestamp takes too long to arrive?
> When a timestamp request takes longer than 2 seconds, the software drops it
> and clears its index from tx->in_use:
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_process_tx_tstamp() {
>     ...
>     if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
>         drop_ts = true;
>     ...
> skip_ts_read:
>     ...
>     clear_bit(idx, tx->in_use);
> }
> If the hardware subsequently completes this dropped timestamp, the ready bit
> will assert. However, with tx->in_use now being empty, the early return
> prevents the driver from calling ice_read_phy_tstamp().
> As noted in the driver comments in this same function, failing to read valid
> PHY timestamps can cause the hardware interrupt generation logic to become
> permanently stuck on some devices. Should this path ensure orphaned timestamps
> are still read and cleared from PHY memory?

If hardware somehow holds onto a timestamp for longer than 2 seconds the
logic we have already fails, but we need some cut off. It *is* possible
that a timestamp never happens if it occurs near a link event. We have
no way to be informed by hardware that it won't complete a timestamp. If
we do nothing the more common case of a missed timestamp would lock the
index indefinitely.

The assumption being made here is that 2 seconds is sufficient time to
be certain the hardware will no longer complete the timestamp. I don't
think we can make the software robust in both ways, and have to make
some trade off here.
