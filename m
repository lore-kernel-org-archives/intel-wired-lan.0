Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8639C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 23:51:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0CCF6068D;
	Mon, 24 Aug 2026 23:51:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oju7RjHQVFLb; Mon, 24 Aug 2026 23:51:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787615512;
	bh=pwWiJyCjxTwXAQYGSnNncufmSss5s1WYS0UVEJhyQpc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FAPs0tnsO0yrfJIlknz+Jinh/Xh+/zc18aUpgG87w0jeoSCzFiOlMv6ntVSApYGP/
	 nBL6h+/LExNRUkJXxWWjM3518u1k6IW/7gyhye1HdHjHF4hWh3NYyiGzX0ouKeIAs/
	 ndYh5S/bUcO1FC1ddi9h3y2QmySkzi9hj7267eb/Ma5I8EZP5sLT5wBdbUIHPsRssL
	 /XSqSrFRZEJIw+4T+eYe34V4u6v9kEZGXAYUVk+Ei8ZlQiygygoZUsIb+oR2yjEgJy
	 9aSXUzK9rSdpGfekSZ1HoiuHPXnqDdDqmM7fTTt3IyEQsdKNuGlAUnvCTMt2e36KaQ
	 1hZA+R4sMQk3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AED360667;
	Mon, 24 Aug 2026 23:51:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E9AF279
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F352480D10
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSBo_Eh6Kpxl for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 23:51:50 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MgjurD1k
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2E0080D07
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787615510; x=1819151510;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=noIzB2FeNtBMvmouBHV02khElz8ZPzLA3TW3MsIVOTM=;
 b=MgjurD1khuzQbBFiaWCH6wcL6WVHEZerP45+OhPiF3/29kXZ0ZJS1/ss
 9OUAJugAI+xy/6HKQ8E4fWH2VfeQALq73D//4tw+pY2rERwwSblJGtqBE
 pI0UcdmPt3dIl0mwQ2umlaEUKTcnM5QIs1i1QF4N71335I0RoSYYt3dMx
 MdJwZtV1kOF1LuQdP3pmkkcMtBWrt9towj2u/aykR26uLII3CZjldM145
 1SxkNwYTf3Zlv8E8jiepk2bm9YAoEE8asmG7pYIGP+1J3zCFNQu1C8p98
 +XnlNCp4uWu6XAB6AbSyDtU0GdFn68HZOXn1ZSgAP9WfPKjt6PzYr7//f w==;
X-CSE-ConnectionGUID: qdhI24uLSbq00Y71uj4zDA==
X-CSE-MsgGUID: 81BR2ghOSLGvPXc+NeDNOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88001513"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="88001513"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 16:51:49 -0700
X-CSE-ConnectionGUID: a4tWDyULQS+ZPz/7D0g0CA==
X-CSE-MsgGUID: DiwoTCfZT7iPCH2UZU2/RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="272345508"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 16:51:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 16:51:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 16:51:47 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 16:51:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrLYtd0VUg8jPuHRb0N8mjnEWGZ+iMQJxq0WhvNnYL0ZIXNvcCgWwC8xy7gcU+UXOrWpM4gaCk+jhMsfn57E6j/WVQV/MBhEteEkC9QiOsAQIqm5+CJGAyoyeHEN1mrAmgsT6E8tqbEm7pU1S5ipS2v9xCHT6or5BRN10F3wx5rvrBIzcOSXI4MJU7Mry89Z0vklo7VzUEwYJCS6D7oNhSAel8GA2TH3rxNNKnxNcAkUgnV9g/X+xI76dPRjIzBYM+HbTUXZKLGwPr+lrHVlNX8ycFqYKQOMVwTzugAzt/BLNKLXlJ/1mt1yjnIyb+4W9s0vMX+V2U9S6YVULSPaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwWiJyCjxTwXAQYGSnNncufmSss5s1WYS0UVEJhyQpc=;
 b=IyNw9vegudckZM0hpBK5kwl+DVCYLQVQTiiLD11k9QC372yQ/BMWanzx4//fotrJHtqpCghV76DaWaH9Geq/2JkGfnvzol5uU+zL5/UHaDKo5xCTTGqkevHXpqpcOtcgk0tfKeVub8fP5wj9oy2lCg/zVNOX/VCAONJWyDKoUnJN5ao6cQ0F0pOvL8veAoSTku7rabT51XKHdMwFF/+yyziDCWvmpZABB3pTveoa6qgb+FCsvU49LIp51l3UgTu17PoSa1wJ5Vg50hdRbOk7sFVDQI8hWa31HY79lQ9QzR4dXDvROSiojD22nlGeA0RR0vv3rUclRzMm1U/7JF0i4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 23:51:39 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:51:39 +0000
Message-ID: <1d5d8fa4-1b48-4ad8-ba67-d04f704921f8@intel.com>
Date: Mon, 24 Aug 2026 16:51:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 06/12] ice: E825: clear PHY_REG_TX_MEMORY_STATUS
 prior to soft reset
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 <alexander.nowlin@intel.com>, <kevin.bross@intel.com>,
 <ranjit.cavatur@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-6-9d0731eb4858@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-6-9d0731eb4858@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::32) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MW6PR11MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: df411f76-9726-4e41-66c4-08df023aa3c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: J4pVWWYTJRbbUEaVinzBDNuuhcEjGb4UjzB3ejzq8rhrQ41LFh8Q9Ww4WL5lQf14LUVst7G1ol07vQYmDlKvlekGq08sGU6XQ7cTM71XkGVC1ns0SuLDJBhoik8cORUxjd/pNRR9sf9evgRbm9spezEEagOHBYfc5sOOD1RUElOvJ5/10SQai+7uk9xHLthmzWDeDrbnW2uFDWowGpUG5/mRvYDUMM6/CyMhFkiSGKI5FlR2cRZGb7dCw3fF+5n0TRe8WApHhk7J3TlLSVWQPN3R+Xam987DcJyiSz8ZgyIG16fWWGdAOntabsBRKnVe0XxYkqwr2h0Tisph/bvyuqvbIxNpXwGN7IBsIH9d3PtnM/750EG5xPMJEt7EFPMkEUDb/MRI//EMiWABioLMQKM8ZvD/lEoxPKyIjnj+zhYGx72KZ92z8ggDkyg//X3sGjHxmUb0bSUIGi77Qk4x25bxT4ECjjfZivGFomBEMsk7b8HXVufsmYwtOk3GXkj0fVenMNMhMb39HZAGpCLTT8jo1aBCEKi+suBjMki3Z+rETuteuNOiycVwCW8r8btlh5ywnQFF8V4bwbxlErI6JBHPy33bPuw4BFHcP3i8Po5jwpVUdS/n7AmDk/rYkyKiijv1h59IhP8XTJwegSE9h5ZxZcUtGIKYFgJe41fq8tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2pZZldwZXZsUlVVdGdmTVZwdGxmMXRVWEpWQ2hqWkpEM2NEbGp5RFIwSmt0?=
 =?utf-8?B?ejN3aTJ2MXY2QXZHck9lOGwzOEFxNy94eFRMZmVnd01oQmJ0WjV1b2pzbGpo?=
 =?utf-8?B?Q0NSWm92d2dCQytkZHFZVzBMM1UzMXJrSktodjBxOVRucHlHNklxMkprY0ZO?=
 =?utf-8?B?aDV5NVpJQTJXTzFTY2QwVUtOVDlWTlNqUThZUjdmOTY2Vm8vaUU3dUtacmlV?=
 =?utf-8?B?cU9UeFVSRnpyRTdNVlhiRHd4aUhXMHM4RCtQM2J0eFVpK1FjVFlKNktxcG1I?=
 =?utf-8?B?MkZ3aTA5SDJJcTVZNHUwQkYvQm96Qm1zbUQrWVg1TjJNblIrNmRqK1cya2Ny?=
 =?utf-8?B?ZW9HY293VXZwZm1ZSHZpdUp2Rjd4LzdHMVQ2T1BPRFlYTUVOWmUrSHpJNFFo?=
 =?utf-8?B?SnllMXhySXZ2OVFqQWhKVG1sU0NXNW1vazlSN1VYcGZLUEx0TTBTR3FhbGkv?=
 =?utf-8?B?MXRyZGJweGVtWUZzK2hNTUxLdDVITjkyZU8zbVdpL2dESHhCR09jUTV2bHZC?=
 =?utf-8?B?dnNLWUl6SGZzUkwxNUxLNjFnMkNsMTg1UW1oZGRkOGhvelllZ2hBZ3U3anJH?=
 =?utf-8?B?Z2xwVkgyKzRzUklOeGV6QXJPV1A4a2pUWFQ5MUpZMjFMOERaYm9peFFHTjc5?=
 =?utf-8?B?Y2w4dnQweStkZDU3WSs2WGhiSWN2WHN5Q0JCUHFqdThPdzBNNUpncjlqckxC?=
 =?utf-8?B?R0phRVFFMXBkNzN6eE15Y0IrWjI5YVhKOTYwVU5jRG9oT2J1ekhhUFVnTUgw?=
 =?utf-8?B?MzhJc0VCd090UmFOajY0ZThVTWorUE5vTThWdWhaYUhTZkVXVTFLd3NqMlAw?=
 =?utf-8?B?OFNCZlNEOUpuNTd1UldHRDdGY0Y4cFhTamJ0RWVJTGZEc2NXYm1lcFhRWnNo?=
 =?utf-8?B?bkhSRlFIcExtWHZyeHBKKzEwdXFycklMQ0hxM0poMnM3c1ZKd0JvdjZuMTl2?=
 =?utf-8?B?RnJHbGZWUVYrdEtwRWZJcmdOL2VXNHJGcnUyeldFVmNtSXhiMHFMNkpsTVF0?=
 =?utf-8?B?TTRCcDVtYU55a3VLaXhyWHhIY2VKUjIwVU55WlNtVGs0eEFTRC9kdE1DWFNM?=
 =?utf-8?B?MFYvbHBKR1lqbm9kdzk2THpjMno4MkluU0tLQ0l1NGdpdHF4SmNLRTBZUGY2?=
 =?utf-8?B?Q2tsaU04VjQwSUh3Q2ZRQVZkSWJqTGtZNzVDS2Z4dWI0NE1ySjR4RVZoR2Fm?=
 =?utf-8?B?UmtkS3dVaE85Y2hOM0ltMUFrYklUSUxnVHUwa282ckphRWk2S0FvNFYyUkIz?=
 =?utf-8?B?bUlGekgvbktrSkx3NW1hd1lDWGJyZWVMa3NkKytsQ1lsNmpNM1A0MCtma0tJ?=
 =?utf-8?B?UG5DcWx4N1BwY0dtUVpQK2dyQ0VnSlhRUW9wSzViUExIK3VyRlo1aXRJdldW?=
 =?utf-8?B?VDBkUEVNQzR3WkppSXc0VFd5L2NkYmJOVnBJNnRTcFNpWUxlcnZaUDNPVUdZ?=
 =?utf-8?B?Q0xzSWthQ284cVpPVzJCVDBhNmw4ZkVzbW03WGo3Tjc1U3AxRzZpa2gxUGwx?=
 =?utf-8?B?azhYbk5QdTZ4L2NRT0cvd3JrWVBFSzVLMndQdXYwU0xkUFpvZG5Cb3JmR21X?=
 =?utf-8?B?OUN6RW11T25pdkRhWjRGS0RDN0ZrNFRnR1JHamNDVnFFRng2ZjdENFlRclpW?=
 =?utf-8?B?Ty85WExGWDBGZVkrdXBVckl2VmNPQmhRYmw4bUwvdVNMNHozSEtmb2JsQ1NU?=
 =?utf-8?B?U0JZU0RzcXprbkMxaVBoUDBnWkxGeU9ncG01NllGUFY5TGY2NXVqTWxQMmND?=
 =?utf-8?B?dkh2K0lsZDFDeW5pWlB3d2JsK2R0ZGNZZnlEc2x0VUorbHl2TFA1djJ2M1Ju?=
 =?utf-8?B?WElLUTNiT1ZVYmdkbzk3Z2NtTmxMb1dEQWwrUmdialZVWkxlWXltNTZnV3Mv?=
 =?utf-8?B?YVJxQm96djBwdkp4ZWp1U1lYcnp3eWJ0dkllOEhMNzc2dVZNMFp6RWc5Mm15?=
 =?utf-8?B?OTFSVFlQTDhXTU9CSkExNGtYWVBrSnNkUG5FRFdRN0VXSWtpS0FVRzc5SzBO?=
 =?utf-8?B?TUpSN3o3b3FEYzNPb2k5U2o2SkNHSm9JSUVZNHYwaG9sSThFelRieXNRTFhY?=
 =?utf-8?B?QUV0VWxjRUVBZ3E2S2dTY1FaaUdwQWtWTlNrQTJ6TUZaTWs0a1NFSEM1dTlO?=
 =?utf-8?B?OGowK1MyR3l5dHVZUzFMa1Y2TVBnWmRTelJxcXJMenRjWEVRQ052dU9HRkdE?=
 =?utf-8?B?MmZZcmllUkFpemFobllKWlEwZGMzeDdtMFlqRkdOWGpzelpBZ2s4Qk9nTTdD?=
 =?utf-8?B?MHhzSUhrcGFINWMrSHpSU3V4ajRnekVTMzJMd1RiRGdwd0lwYU1lNDh3aDBx?=
 =?utf-8?B?akYzOTFncVQ1L3NDMjFWVFoybzJhRGo3VFgyemdPMHFQaEJxWTEydz09?=
X-Exchange-RoutingPolicyChecked: chA+nx/rMWKJCttRQ3OrKyw09+DDgC386uhGnbkTWjnV6/AosTICeGUNVpP4yNP5FPC+X4TGix8hRUxRaS/WIvSE1sMV3CiLmRUWb6x7wU95KIFNEQJiQNe452a3K7DgClR+qJaSuYJtIJrFEd9fiP5gQ8+S+MJhQJb2DBoV5EY9ru+lsDvll/08TTVQvp0/XvcGJIikZe5KTTxHeG+4+oqA87a5J3yuGJ9asQOPLiTVkTmQXTO+BUGSxVnYvPah4KHCHgwCwnhDXSN2QEoY5H+ByGKtRgXGhfzJwJl7bVZsHWfYXfPlXGEUSiQzjex7V+YI98z5FIftWy7nfSneKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: df411f76-9726-4e41-66c4-08df023aa3c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:51:39.0497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOHYamuFZoZyGCqP4uJYQ9tKxZ1b5/yCfoUS/yTL6l0TDoiqubipnQUoG4awnhIjQ5f3XVWCGNHQy+pmYmMXl9JTitR3s3yz0GL3olWPN8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
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
> The drivers current implementation of ice_ptp_reset_ts_memory_eth56g() is
> flawed. It tries to clear the timestamp memory by writing to the
> PHY_REG_TX_MEMORY_STATUS region. This does not work properly, as it does
> not trigger appropriate PHY actions.
> 
> To clear outstanding timestamp memory, the driver must read the timestamps.
> However, naively doing this as part of ice_ptp_reset_ts_memory() is
> problematic. When reading the timestamp index, hardware kicks off a chain
> of actions including clearing the ready bitmap index, and decrementing an
> internal counter if the timestamp index was marked as valid.
> 
> This can potentially leave the internal hardware counter out of sync with
> the actual number of timestamps. This occurs because the
> PHY_REG_TX_MEMORY_STATUS region is not zero-initialized when the device
> boots up. Instead, it is filled with garbage. On a cold power on, attempts
> to read the stale data result in the hardware triggering a counter
> decrement for a timestamp that never happened. This underflows the counter,
> and prevents new timestamp interrupts from being triggered for real
> timestamp requests.
> 
> We must read the PHY_REG_TX_MEMORY_STATUS in order to clear stale
> timestamps. But doing so may cause a desync with the counter. To prevent
> issues, perform this clearing always and only right before initiating a PHY
> soft reset.
> 
> The soft reset will clear and reset the internal counter and the ready
> bitmap. The reads to PHY_REG_TX_MEMORY_STATUS will reset the region valid
> bits ensuring that no stale data is left behind. This combination ensures
> that we always have a clean slate with no stale data and with the counter
> properly reset to zero.
> 
> Fixes: 3ec46e157c7f ("ice: perform PHY soft reset for E825C ports at initialization")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 89 +++++++++++++++--------------
>  1 file changed, 47 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index d48eb3c61823..b7d217ac31f3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -737,24 +737,6 @@ static int ice_read_port_mem_eth56g(struct ice_hw *hw, u8 port, u16 offset,
>  	return ice_read_port_eth56g(hw, port, offset, val, ETH56G_PHY_MEM_PTP);
>  }
>  
> -/**
> - * ice_write_port_mem_eth56g - Write a PHY port memory location
> - * @hw: pointer to the HW struct
> - * @port: Port number to be read
> - * @offset: Offset from PHY port register base
> - * @val: Pointer to the value to read (out param)
> - *
> - * Return:
> - * * %0      - success
> - * * %EINVAL - invalid port number or resource type
> - * * %other  - failed to write to PHY
> - */
> -static int ice_write_port_mem_eth56g(struct ice_hw *hw, u8 port, u16 offset,
> -				     u32 val)
> -{
> -	return ice_write_port_eth56g(hw, port, offset, val, ETH56G_PHY_MEM_PTP);
> -}
> -
>  /**
>   * ice_write_quad_ptp_reg_eth56g - Write a PHY quad register
>   * @hw: pointer to the HW struct
> @@ -1139,8 +1121,8 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
>   * internal PHYs of the 56G devices.
>   *
>   * To directly clear the contents of the timestamp block entirely, discarding
> - * all timestamp data at once, software should instead use
> - * ice_ptp_reset_ts_memory_quad_eth56g().
> + * all timestamp data at once, software should instead perform a PHY soft
> + * reset via ice_ptp_phy_soft_reset_eth56g().
>   *
>   * This function should only be called on an idx whose bit is set according to
>   * ice_get_phy_tx_tstamp_ready().
> @@ -1152,11 +1134,11 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
>  static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
>  {
>  	u64 unused_tstamp;
> -	u16 lo_addr;
>  	int err;
>  
> -	/* Read the timestamp register to ensure the timestamp status bit is
> -	 * cleared.
> +	/* Per the PHY spec, reading the timestamp memory location is what
> +	 * clears the entry's valid bit and its corresponding (read-only)
> +	 * ts_memory_status bit.
>  	 */
>  	err = ice_read_ptp_tstamp_eth56g(hw, port, idx, &unused_tstamp);
>  	if (err) {
> @@ -1164,32 +1146,40 @@ static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
>  			  port, idx, err);
>  	}
>  
> -	lo_addr = (u16)PHY_TSTAMP_L(idx);
> -
> -	err = ice_write_port_mem_eth56g(hw, port, lo_addr, 0);
> -	if (err) {
> -		ice_debug(hw, ICE_DBG_PTP, "Failed to clear low PTP timestamp register for port %u, idx %u, err %d\n",
> -			  port, idx, err);
> -		return err;
> -	}
> -

Sashiko says:

> Does ice_clear_ptp_tstamp_eth56g() intentionally ignore the error from
> ice_read_ptp_tstamp_eth56g() and unconditionally return 0?
> If the read fails, the timestamp memory valid bits won't be cleared, which
> could leave stale bits intact before the soft reset.
> Additionally, unconditionally returning 0 here makes the error check in the
> newly introduced ice_ptp_clear_tx_memory_status_eth56g() loop dead code:
> 	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
> 		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
> 		if (err)
> 			return err; /* This is never reached */
> 	}
> Should ice_clear_ptp_tstamp_eth56g() return err instead of 0 when the PHY
> timestamp read fails?

It makes sense to me that we should bail here if we fail to access the
device. Presumably multiple other accesses would be failing but I think
its not correct to hide the error in the clear timestamp function. Will
fix in v2.
