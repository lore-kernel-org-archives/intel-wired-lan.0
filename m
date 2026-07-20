Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777E6C44521
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Jul 2026 07:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CD8A60675;
	Mon, 20 Jul 2026 07:40:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wlj8ftTYKYIz; Mon, 20 Jul 2026 07:40:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6594A60661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784533201;
	bh=v72roHPe7xlDea8c77tYjYzNo3TEcXJj51EEVu26PuY=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9vlIdr6SWVTo6AcMFRNwX9Xl7SyerMRwYiuCdfU0zIeNrU5UsJbVzrNrQNNy7yG+u
	 1ah1nrY/fOrHSwjw0K6Q0/SzdjHge7K/+oHV1tmoiuq5z+x/0F4Lwm0EHth0hJVK+D
	 3sqYyvfeZjwm2u9iBjGHADvWyVHb9NNgJFhOZLLNaHQnk8y8Uus+DjiFdBM7JfJQHB
	 koLG3zDuaDhSeQ8ltboVL4w4ZRA8QM+q7rHr5Vp5HucKbUGlvnbHHf1yek0sCmAA6d
	 eQTuUf+V7xP4lUfOErDlONbDh9ULjBR9GBKcr+S4NP/eHfTiitzxvrXvONtSQWYnzc
	 sZ3ZepLjoIacw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6594A60661;
	Mon, 20 Jul 2026 07:40:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 936211F6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 07:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C2224004E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 07:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DeqPWWZDIkdo for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Jul 2026 07:39:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5838040025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5838040025
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5838040025
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Jul 2026 07:39:58 +0000 (UTC)
X-CSE-ConnectionGUID: /ZQx2wWaQwOK/fqxXx9qxA==
X-CSE-MsgGUID: awyWQGGzRDem7b7YnGflLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="102654417"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="102654417"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 00:39:58 -0700
X-CSE-ConnectionGUID: Eep6tNHCTReLQt1ts59zhg==
X-CSE-MsgGUID: jn/HzyTUSvGFyek9S6ffGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="280661204"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 00:39:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:39:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 00:39:30 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:39:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bumMOvGYDdjpza5wWasBjUk1iSt7UeLVIvl8hW7ura2Un9UnDylRad1Sko1Oe1Qi3TTiuQh6gNkhg5cDbwIa7Lh6rBpiPeDNKi7nFoE+Cbp4auGxuaIJ6vDcOxmhaxib8bVaHJVdxJWFZluxJzIYMTJxU2gKUYUpwVMTuucMbubRK452bVn3zxtJ0b8n/3XmpvNcSRotSUtmnOyvaKti+SNdL2r09cMCKGiw0I/0npXO9g1n4eZMsQ7gQ7lh4W6YdeG0EaMP1SJcIsyNfMBYTMXAXlZJ3z3vE/kLXv2JtTETczULCGGW6QTjKn8NaWdWFwaAIIc8m2JRwU6AyJNnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v72roHPe7xlDea8c77tYjYzNo3TEcXJj51EEVu26PuY=;
 b=lsHwKOJLQB7QV04raqmoq34R/t4Ca6sdYLNKyMk7o2hzP/haIIAr19t1APRvqiPcpaNiWYUk0jh4ri39S7UDRJntOMUrp/UAVggOJcxuuPGqAJ1ozQ5hHGO181u5Je6ofgtGc9k1rWuVqBD1t/Hs1QAwO0i0QWhakU2VVcBEMdVZ4CKmzRASfNMk0Jt3lChvBckbfkB8QaEmJtYo6R1nKSInkaSFubz2H2lduk2DWF0eak3qXJD5xDR5ApkOZh2Cu1h6AYlrdq+Uh3ckuJ8WXZ44JTOEmE55MnHRQV3gFMX14BHYBgsRA0b9V10DBvokdCEpzasZSWo3iWbRWdPqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9514.namprd11.prod.outlook.com (2603:10b6:408:2e0::10)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 07:39:06 +0000
Received: from LV4PR11MB9514.namprd11.prod.outlook.com
 ([fe80::79a5:106b:2126:a7fa]) by LV4PR11MB9514.namprd11.prod.outlook.com
 ([fe80::79a5:106b:2126:a7fa%5]) with mapi id 15.21.0223.011; Mon, 20 Jul 2026
 07:39:05 +0000
Message-ID: <c477f099-c365-496a-bb5c-ae8d27d7916f@intel.com>
Date: Mon, 20 Jul 2026 10:39:00 +0300
User-Agent: Mozilla Thunderbird
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, David Carlier
 <devnexen@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <aleksandr.loktionov@intel.com>, <advoretsky@gmail.com>,
 <stable@vger.kernel.org>
References: <20260712132242.223254-1-devnexen@gmail.com>
 <alSzCokS7scCoza7@boxer>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <alSzCokS7scCoza7@boxer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To LV4PR11MB9514.namprd11.prod.outlook.com
 (2603:10b6:408:2e0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV4PR11MB9514:EE_|CYXPR11MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 21272b39-1fa5-41ad-153e-08dee631f9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: kD0uONYDkuP9/4cDqY5H7YRNrfRCSoeAND5dF/xmz1kduxknC3X95v7wNuWyNpvjsAX8UOkekmV/hRXB3oahWt/jUDxMMlT3AD21/jMIQNsC+pcqMhC187542Tog/PoL/sSoeTaq+YPKSX0EFnhQjBy5O+/Vr5nreB1/lv1/0sDT6ysCCFnkgKwjVk5RN49GKpymgfiYYVJ5/GVm9P3tiuk+gk9x8Q/HJyNnLo2jiOhbxMdq1SMEC5lVdiGxlKqknxkLqz66JbYPGmj8KQgMfc2Q1bmsV31yT8Axtncjxmyy3+dBiyW+sMUdAEleK6CNiVgZhZRtn8aWsmdqLv0O/WbE/xDl0GazeNC00MFcIVgPym5g2XMKGj4Xvi2Zx8rHbJ8eB36oi38aDp6IWKkNib9fyPRQLTOMs1j41c0wR7Zky10AjZ/6EtgAHUBA/MN9bxF2glp3rjoW1Y+T0AU+5jTTMHN5KnD+zxmK0c7ZEO6ge8rzNHnK2B3q1Cxotav14w52vV14WV8AXcQawuDxoTOwb7lrV3zCtg7p3V2f/nAUxSt8waD08tLuJCF8OjP2FKSju/LC7Ts6FAkxhgPCJUmsPN38+xazCY0fhydn3eTG53mInr0Zi0ukh5k1bbL8m4OWQHYf4YnGIUB2P1+6EX78NHxNz6U6S930AO6aPY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV4PR11MB9514.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJRS3FWaWdvNnpLYm56Y0lybzRmNG1Yb2pjekpjT3FJdDRTQnZZanM0c0JG?=
 =?utf-8?B?cTNmN1RKUWZDTi9VZjczZ25IUGpNalZUaHBqTUVLLzZESWhQVFlDcmxLSWdT?=
 =?utf-8?B?eG9YenB2Lzg5VW9kaEEwcXJsSUtrYVhYcDdJSlRJV29USjlSSisxb256Yisx?=
 =?utf-8?B?dVkzRHFLZjRCblVaQ3FjcDFHUm94QldUSHRiMUlxeWRUYWdTSWZHaU8wSm1I?=
 =?utf-8?B?TmVJdVVGR3oyQ2tSTnBsWUVGNloxL1hIRXVrMVA5UUlVQjJGUzlYd2wvbU1n?=
 =?utf-8?B?UlRCYWd2bmxBMFZzUkxvNFFUWVQ1dDVXcXh0VjdJN1JpcnlsanNkaElxZVJG?=
 =?utf-8?B?Y3IvZXUvZFp3bXhCOGViMXQyVXB4SnE0aWZPNHU1dDM0SGdaWDVkcGoxZ2Uv?=
 =?utf-8?B?b2ljbXZjNkdZSGdTUzY3TzdpUkF4clhsV3BzTG5hbVRaQnlqK2s1czNqUjc1?=
 =?utf-8?B?OURva0VkdkYyaEVtd3hHTWFEQitUNE9UVG03THVPYlNaZ0lkTFZJcGMrMlgr?=
 =?utf-8?B?dEUzYzIyY1gwNlNBVS9RVlpwK0grbTQvZ056Z2lsQ25oRGpIdEcyNUkvSnZj?=
 =?utf-8?B?VUlMdGZoWXVZUWI2anlseXVtTE9mdHJrT2t3K1F4S002ZEZZazRBTUkvR1px?=
 =?utf-8?B?dkdPWEN3R3UzZm1YaFoyT0phRnI3N1l6MHVGUVNPMDBjMklucWJ4RFZmWVp1?=
 =?utf-8?B?YXFaUjVCa240RkV6Zm8yeFRlbGtESUJuZGg5bzQybVgybUhZVC9rdXpHWVpt?=
 =?utf-8?B?NXhISzQ2emVrWjZCclpwNDRrNURjN0d0SFBGL1FNdjJEOENLZ2JyNWJOektB?=
 =?utf-8?B?UzRhUXhhM0lnaWgrbGhFc0Zqbm40YlNicy9aQm8vZnlka2kxVVlONkRWdnRo?=
 =?utf-8?B?eVFqdXNrWWNZUjJiWE9YblpHNWY0aC9Bb09YL2tJd0llMDFvN3ZBSzR1NWV3?=
 =?utf-8?B?UXJKZUhhUHVXOWVKSzVtY1dKN2o2WDR1c1VTeXhDbERPU2sxVzlzS0VuZmV5?=
 =?utf-8?B?MTJ5UWZ6TEQ1dXNISmRaeTFnYzNUSkNZeWl4OTZUd2lMNGt2ZUlHQnpVTDVy?=
 =?utf-8?B?RXJ4MzJvQ2Q3VlVvenFuOVExZS9sb1BEdlpZcXBMZjJaUUNKYmJ4S0Z6Z1kx?=
 =?utf-8?B?ZnM5VEtZMmdSSGI1Z1cvd25VNmZmV0hvbGU1Ujh4dWVZbUdodjRCTk54czFT?=
 =?utf-8?B?Q3JCdktFWHM0Y2QvYTlZMHpJaDVQU1RXaFpxQkNHeWlUMU9MYmlkWEwzNzYv?=
 =?utf-8?B?VFFNd3Z6UGtQdGlrS2pCa3JtY1RTUlJMdUh0cTdIQXVJMFUyYkpxRVhyNHEz?=
 =?utf-8?B?UHg3elEycjlrSE5Eb1E3UnZENWdQM1Q1VHc0LzNKL2o5bDByL1hZeG81L1dE?=
 =?utf-8?B?alhXUmtIRVEyLytVR0p1QmY4dlJaVm16aE5SSktBTklDS1M1YTlsWHBJaVRD?=
 =?utf-8?B?NUVXTlh4YUdLWThwTlRqVWJrUXZkRndLZXBYNzZWRFJPSG5KWEdUSFdqY0ht?=
 =?utf-8?B?cDNYbXlTY0pLZTNVK1l1UC84aGlPdlFVVzQ4ZTVyaEQrWHFUMFhNUVRGdXVI?=
 =?utf-8?B?ZFdCNkR1ejFjR0JCOGxqSmdmaUVuYWgvb0d6YVRBbUhKK29McXhyMXdPMjky?=
 =?utf-8?B?eXpZOEs3dFpDMUVvWmZramV0V2V5Qk5sK0d3MVk2SWNUZ21ncXJ5Ni8vQXQr?=
 =?utf-8?B?OGRaUUhsMWJtWGdIdnFhRXRhTDBRYmRaWVd6Y2hhRFJUSkFESXNyTnpYNUk1?=
 =?utf-8?B?czZ2VkV3TnFlK1dISDBrTll1THlzTnYrbkUweC9uVFU0MjVwbFREN0pYWkhO?=
 =?utf-8?B?RUFka3EzWUZSSnhvT3hPUU80ejdqV09tK3JGVjJMTHhXcFI0Wjc3SUl1NzUz?=
 =?utf-8?B?VFIzdklJeU5nSFJuTi9Va2JpQWZ1Mm5hQXlZZm8zRGplTTYzRndTVG1UcGc2?=
 =?utf-8?B?K29UVFR6ZTZpd0dJNWtZVldWY3Q5YlVzK0I5ZDQ0UW5WcVJBOVVzRmlUSDZk?=
 =?utf-8?B?NGtPZGhEWWNKOXVHVUVWYXdhWlJ6UmMwbmtJV1AvZGs1QTRWcmEvaCtTS3Fs?=
 =?utf-8?B?VVhEMWE4MFJYc0NSNGZZSDV5LzZGWlIyN0NraFk0R0dPWDJQZXFLNzZRdGFP?=
 =?utf-8?B?NmRETzR5OEM5cytjenNvQm5laFVsWDZDU2E4WWw0TTRib1B3enJUcXZ0SldR?=
 =?utf-8?B?NnROSmpXZHZ0NWpxcXVGc0VweUZHSDRhQ1VSbUNpcExvWVg2T0ZjVVVkb0Np?=
 =?utf-8?B?aXA3WG5lU2I0c3RhWFhQSmtnbGtHV3gyQ0xnMzZLaVNOV2k1Y0hKYTlmQ0xZ?=
 =?utf-8?B?SWJVM1MvNWNwZzB2ejV6Z0wvYjVDSW52NDJLY3FVdmp4Rk5UV1ZXZz09?=
X-Exchange-RoutingPolicyChecked: bZ0FFICALVxEZONJVpC8yBBPCPx8g69b8VZQbyI7rQrFJernxM7AOw6ta/E0G1IqMaLvU0bipQePMNmhH0I+hsx9bzZ89vK1c4GQEbDeEVr/bqcWeUVaZ32hiAWZ6vg/1bNWjkT42oiGPWi+29kHKe+zL06jwDOOXoUQ+NR7Ee5/V4sghtAZ74/mPfjcF7jas1M2HwNEmnZPB4dfEEUEWujQjspmrO1wl8MHssIVe8/9bjO31aBO3BvP58q+bbXxJfLCxpp0v1O+5pt9DFGe85zSl5UXjJvxeWEXW4As1yg7RlTQF6VK8cFvyR65D4LH+PBdd3RFBhZCp7q8mXm1TQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21272b39-1fa5-41ad-153e-08dee631f9f4
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 07:39:05.6326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvWSvV7ibYHKokQIvuno8TAEVpegtc8O5hpv1HYlWGGMjR9x/qisbL0Kcjn8czibjq04IuKvwz0b/28oib2DKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784533199; x=1816069199;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TRiB9M2MpfofpMiiTkchGiTlx/DDjDSK8QoLVmnE1co=;
 b=oK3i7q1N+BHb5SUL+p4KyO2D740BvHolC+TmiQ0UbC8iOt2qKX4rtaqt
 X9iCogI1WHhSoJ9bpZaWrteQZ2stOwk3r0tvfAq+ZNY/s8AaFT+Wz+s+u
 yg8OZavXTeEYOxDDkvX8MiM4+sNXt2ziKQKx6nMobAgkwrEfg4j5o6H4n
 5zLd11Dw1LTSPj1HsFJPUbhQduf25LZ2p4OayM+PGXDSlowM0S0mgfRN+
 toSCp15DEWNSmVJkWlxaTNtPdHUYhPEiPYN0PuXHfXfWEU9DF4eQPO4aj
 jj6m98EmeVNyCHZaoQJSdYMweUMT3mSlNy2actsxhmn6/7fTIeo18mnpC
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=oK3i7q1N
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH net] igc: remove napi_synchronize() in
 igc_down()
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

On 13/07/2026 12:42, Maciej Fijalkowski wrote:
> On Sun, Jul 12, 2026 at 02:22:42PM +0100, David Carlier wrote:
>> When an AF_XDP zero-copy application is killed abruptly, the XSK pool is
>> torn down but NAPI keeps polling. igc_clean_rx_irq_zc() then returns the
>> full budget on every poll, so napi_complete_done() never clears
>> NAPI_STATE_SCHED.
>>
>> igc_down() calls napi_synchronize() before napi_disable(), so it spins
>> forever waiting for that bit and the interface never goes down. Drop the
>> napi_synchronize() and let napi_disable() do the job -- it sets
>> NAPI_STATE_DISABLE, which forces the stuck poll to complete. Reorder it
>> ahead of igc_set_queue_napi() so the NAPI mapping is cleared only after
>> polling has stopped, matching the recent igb fix b1e067240379.
>>
>> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
>> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Carlier <devnexen@gmail.com>
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> This is a mirror of what Alex Dvoretsky did on igb, correct? Did you
> reproduce the same issue on your side or is it a blind shot at this
> driver?
> 
> Regardless, I think it's a correct thing to do, but some clarification
> would be nice.
> 
>> ---
>>   drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 2c9e2dfd8499..b3883a5a7d7a 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -5352,9 +5352,8 @@ void igc_down(struct igc_adapter *adapter)
>>   
>>   	for (i = 0; i < adapter->num_q_vectors; i++) {
>>   		if (adapter->q_vector[i]) {
>> -			napi_synchronize(&adapter->q_vector[i]->napi);
>> -			igc_set_queue_napi(adapter, i, NULL);
>>   			napi_disable(&adapter->q_vector[i]->napi);
>> +			igc_set_queue_napi(adapter, i, NULL);
>>   		}
>>   	}
>>   
>> -- 
>> 2.53.0
>>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
