Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7910C5DF9C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 23:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9173D6063A;
	Mon, 24 Aug 2026 23:39:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vs7610G78sJ8; Mon, 24 Aug 2026 23:39:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787614752;
	bh=nSijiYLZERzQTNBeQNl4VDstGyLiIWcfDGcOP7+2CE4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hM/yXyWgroGYjG769AIkzP/zMBmzsHTrHj+dcinZzw4bVrTXDeSvqqofF94f2AbKf
	 CHYimgJ5kwr21v0c6+AvrXU7WMRwO726+7uFW06L5msw18/lqImC4iFfUbMMX+Y4Z4
	 0oean8nBlTvisRdPhaGD0LXpHRl3o2tSHqGmV15qj+j8Rbtu5mx2VLGfS5xBvLsEOp
	 F9Q6BqjnqGnsIM4DvARIqy2QrUqP9FOQaA0WUsmO8cKGll9GRcpjyDNPv4l+02ltsO
	 CkPQLZsRej6wQ+JzhH14UO3M1k/JJwrEX4I0PXfdmgxmC5lelrMVpBZRCxXTu7c/DY
	 PWyw5c+jt03eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAFC760667;
	Mon, 24 Aug 2026 23:39:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F0954B8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5098660667
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:39:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLQnEbF1T4H9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 23:39:10 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cZMFfP33
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6423C6063A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787614750; x=1819150750;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VgNL60A7D+e+Ej8x+Ed/2mf7VWnKgE0hRGSS3UHZkfI=;
 b=cZMFfP339TmAZVj6A6H59q91wuQapFq7HfQDLXDIXa3BY8x/DkZ9GWUA
 2lTRFzTIjx8eRJJFh1sUffCSxT8h8DJ2QLZtPfy4tskubcPPywfGbFpbt
 RFnIWYWKrhvrcWko6ssnKP2cMXrww/jfEwv8I83NcSKbndvWLLOj1ce08
 mus4HoTIknZZuTD1bt41WfUR6rhxprO3GXKmTws61H2jNZaDJ4QcpEDDf
 BJadEGEBp44Xs00wVdGgLLoP3q7fVjwJmKvMjAZErku6oizPasaYA1Lbo
 SolfSqR6Sm7czAEdrm58e12f+AtDLR79YxWwGbb4aN80yWQ1sF6Qt9q5y g==;
X-CSE-ConnectionGUID: GqTVLHYCToKJmjmiXT0h4w==
X-CSE-MsgGUID: PRT+PIsbRjeS/ulyxXInWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88134261"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="88134261"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 16:39:08 -0700
X-CSE-ConnectionGUID: JnFVW4jMTHSE7g2scm3x4Q==
X-CSE-MsgGUID: ALMELuKwQ2aT1JhEVd1HtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="263399216"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 16:39:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 16:39:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 16:39:07 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 16:39:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddQa35DnCWsUFOR0wSvKM65escYAjw2+iEMi9EtToNLXDnvIO2NfNCBjie/+AeguZpH4BZyjq7UySnGNXNqc7x3UkKu13SrJIs9fb7/4+MkCSCjF4BVS43sxCsJePLGa6QXyjso6CxXFUZOgvG96ReLER1l2QwHbh2QG+DRqwxcT47wRaaQpXSsG6wbDD4HetPUkSTs8PXFvTJoR8Dt4o2XQHqq+SsOPauBIVzrkaX3YQJ5OovEcXDJvsM2PSwwWKvwl/ZwjuNJOQVYwvF8yOoulQalk0NBilsPrEhjslW3r9HaNJbX96LOlj0ykRM6tCPT/WZkGys8nXm2Mr08rlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSijiYLZERzQTNBeQNl4VDstGyLiIWcfDGcOP7+2CE4=;
 b=OkkaVL4UZdVfhArFEPDJ3WjkXc+S/MYZAK56ijBWTTHdrh5r25DVKTzdljY6Q3n92nhZziqIb6jrqqeNSVBrP631R/pHFAFQkEPoEWJUnC7tL5Cf1LiI1AagZiBOCTtXZ1vPiWJ/fHcYFCKBdTJJmIjVf6OSgq1/nAxfgmtWmU1VjJiuMvI5hhhc+iJ+0R0iOQwkSfyrGLA8cM5PhXm9tQnbpOXWbTB0XUMSs6LRvgZnO03be5AWMdW11tp4WmGNNj9d7gOnWkwpycYlCsdIkr4E1LlcIbuOYQdogDS3GxzMHPDKT1B2IMu6GPoCVOUr6CHYH1YxNwTP3cGqAYzuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by LVUPR11MB9592.namprd11.prod.outlook.com (2603:10b6:408:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 24 Aug
 2026 23:39:04 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:39:03 +0000
Message-ID: <3114c0e5-f7ee-4b49-9171-ccfa09a3aa70@intel.com>
Date: Mon, 24 Aug 2026 16:39:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 02/12] ice: E822: keep Tx timestamps disabled
 during offset calibration
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>
CC: <netdev@vger.kernel.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 <alexander.nowlin@intel.com>, <kevin.bross@intel.com>,
 <ranjit.cavatur@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-2-9d0731eb4858@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-2-9d0731eb4858@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|LVUPR11MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d3dd7a-3d86-40a2-a50a-08df0238e183
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l2UL/iistidumCPGIOaLw/AWVsgEw8YdcphvDJN66pLQd9hcgfGvjlkYtIMgwc8Aqpktya+SkDhTvP/bd3RsljB9rvA49ItcXxSuTGhOnnE6e++HCyGWerl5Ss7evudp+lAdKeMNyBSMY5O2Ah1khovTZgmULFeANyAwCB8H08MwJu9JBULON7B+aU3X6pGy4MNrkzXjdfojrGbGkxM995Ke/giqmVf45FIQN+ebhdMfRL45OvhqWkIysp/WRER7qi4qXqNsIkU74FhWiQjXNLTcUrEoPmcp3GXcTKy44Q2fZMiWm2r0z+NYMW3SGNuf/prSegdDM+nrtCjJldmPa0J8NwxQesAfwtmR8gzP67lV+ZyZeYNvZ1fw3+H5Y57u1ZlanGaRv6u/aS7LyLuDuU27imdBUM1fxCxet4BaeQp/lROWMExSv1wQpKJAoBbNEq/ZdMTUkxZNHIDBZSZr4QnQ9fMCs4qTSTAQYhf7tYs7l4JkQV/0v0V9ZYlw47jiAl2Ms8fCHXcGYhh/4faxDCGpY5v6jcXgLyaPlrP46nNEp2WXIlzwoFDdnJYbC9fbZ439sMK00qd0ye7xIonkMfEHzkJqF5kEXyvgZXW8IdPnlATZ+5HkDOPZhkF3j054NSgXZsgEPEww6nU/KjxyHHe4Mo9F2YYAmNMPU+dHRdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjNRbDF2TXJ4ZUJXSnc4UTJEcjdoVU9UR0FqYnZPZHJnelo2amFYdTBjYWlZ?=
 =?utf-8?B?TG9FTExxdkJaWk1COEtPc0grUjhpTEZBMGV0Y1ZnYndncjhhNWpBcDVscm9R?=
 =?utf-8?B?OC9Mb294RWlZTmdxbEZNMUV6YWVaUXV5WWVmdFc3UVpKUUIwd1RUanBnWmpl?=
 =?utf-8?B?TnNPcUZQcHVoaVVSdUJ1VFpHd2hnTFArdWJxUVB6TXRuR0dCblBxSUk1L0xR?=
 =?utf-8?B?dkgrRldxSDAyeEhIRUZRNGRhR0FXV3JSNyt2R3NqeElBSGVlcnBUVVNRQkFW?=
 =?utf-8?B?MmNBSC9qNDkyTkRXSXpyVWQ2aDhwclprR0tlU29ONW54aTdoWUpXYWdtMlF1?=
 =?utf-8?B?UWc2ODNDZVRiL25LSWZ0OU5QYWsxM2ZKaDRlSzljeXV1M3FYODY2R1lJZWVH?=
 =?utf-8?B?STNQbjNuU2tuZTBxRFIxRHlIUjBhMEdvMlVscDY2Uy9ZNHBZOHJURTNGMEps?=
 =?utf-8?B?Y3Y1YUpmanJaL2pRNzVpT3NPUEdNR01iSkEzS1hwVlhKM1U0OXZ0YU9KeDB2?=
 =?utf-8?B?SnpxMm8wdTVUc05Bb2VMUFlRNFA3ejlrQUloakM0MnVSTWxVazAwVFNXUUNk?=
 =?utf-8?B?WlJDTElHc0JhWCtjalZCbDRnT05iM0V6U3BHdWVMTzdTZGh5TitXM29ES1hJ?=
 =?utf-8?B?amF4Z2pCQ1IzS3VkRGs2T205YTRZTGt3cE53Z0NOdWNqZmoxaGJqREs0dFdy?=
 =?utf-8?B?Yk1wejRRL2szWWNYV2p4dnZOWDJLM1AvNVVwdkNwTWI1RU0wY1phNHFFOWZB?=
 =?utf-8?B?MGpoS3JNcVFlbndWSVZTM2trcENNZCtqZEpWT2NkZE12V0lHMm9WVk9WWnAv?=
 =?utf-8?B?WWxTNXV1YzkvUHExOUh0QnlqdTQ3c2lqRnhQTEpaM1ROMVIyUm1jMnBiQnNq?=
 =?utf-8?B?Q2NJSnNkMkNYUEZNRjJNQWxxNTBOSmNFeEplTjQzRk9TN1hrd2xod1U2dDRS?=
 =?utf-8?B?ZGxGb1NkTHovRm90VXBDYkNhbFFjV0xQdzFjRFJFQmRPUUtQOXRCTWVZbWlM?=
 =?utf-8?B?Vkp6ZlZiS1d5SHp0QW15ZFQ0TkROOFB1SjROTFNTcjIwKzVWVmIyamJqTFFu?=
 =?utf-8?B?ektUR2tZcmhWTFVLQ0lTR2VaSFpmUkJEVHVqc2hxdEhySEVOb0tSQVIwRk14?=
 =?utf-8?B?czFyY0RZU0R1Sjd5bk5aVUFxak5tSHhuNnU4QmZmTGtqTnZtMEV3L3BFdDNo?=
 =?utf-8?B?MzVtRks3K2ZuS3FuOXQ0UUs3cE50NUx6TDg5bGRqSStHQTEzVW96WFpCN3VF?=
 =?utf-8?B?NnZzWVZNL1pKaE5RWnlseGd0eklpcE1XSGp2cXdvUmI5YWpIc1BvaktQV2Uw?=
 =?utf-8?B?WmpOdUNTV1kyNjNoc1lnQ3piRkZTNy9vdGxERUVpOGZEazl6eldDcjNPRmJj?=
 =?utf-8?B?Vkx6ZjF6VkYrNk9aMkhkb1AxOXJIZExpQXpCT2pjV2F1Um1HUmNuSEphOW5n?=
 =?utf-8?B?VndhV3VuaU9MZGRyWEtiQlcrZUhnMG5YbVdSdHdtbWlRaVR0S0hVWVB0RytT?=
 =?utf-8?B?NVhzdVBHWFAvczhieG8vUWYydDlSZ3BJMzFKbnl6OG5Ua1phaFJ0dFBGTGdV?=
 =?utf-8?B?YTc2YWl5V1ExUXlpLzl0NmU5U01WN1lpQWs5WmthZitBa3ZKU3c3TUNDdVV4?=
 =?utf-8?B?cy9QdWQ2ei9tQms0R1M1SUlyeE5ocXF6NVhDQm8vVUlnRW52ZW9rWGg1dHFO?=
 =?utf-8?B?RVB0ZTZvRW9aWksrbE5ESXZudHJZd3YxbFhSdVBXNGI5a1hNMURwSFV3YlVF?=
 =?utf-8?B?d2wySWVNWU9HekxpVUVDemt0TE5pZTN3czlUSW55allZcUhSWGdGMFc4alhI?=
 =?utf-8?B?ODd2ZUpmdDg5MzdQVitjRjU3TFJXOHFvWE9qVFhpWVh6Y3Fqd2lHeTFWSGda?=
 =?utf-8?B?THFkeVAzN3k1bWVNYUI4SFhqeGxXTzRCdGhienNoYVJ1YTJsSHJid1RMQjM0?=
 =?utf-8?B?VHkybHRvcjlpRDM1VlVFdjY2Mm1GREJqMmlOSnU1MWswWlZyeHdTM1ZLOVhV?=
 =?utf-8?B?Y21MWUlOZ3VVQ3R2VWhvMTliWXFhWHhUVkUzMVFxQnB3OGJ0TVJaenZaNDhL?=
 =?utf-8?B?NTRKdXBVVzdvUURnUi9ScVR3NGdFSjZuRDBsQVdXN2lvMjhBL2ZXN0tZeVhM?=
 =?utf-8?B?Vk1haU4yUjRHVG9JNHFacFE5RVhFa1lOdWRDZFJjb2UvcTFNUjdWOFo3SzYw?=
 =?utf-8?B?T2RodjU5L0ZaazFjWHNKSHFrN1NsU1BjckFvQkxlTmhqWWlVNHVVdWR3Sjc5?=
 =?utf-8?B?L2t2K1d5cWpKcWdnWlRsRkU2MXZSc3k0YTgzMVNQR3RGcVhSdHkvb2h2eUxF?=
 =?utf-8?B?dzB0OXAyS0M5TElwd1NCbTFtY3N5bk51MUl1Vk9HQjhqek5jTWV3UT09?=
X-Exchange-RoutingPolicyChecked: GCBRG1vv64aJDXYh+fezg9036vyxGRtFhl03+T4cJt+7dinDf0WkV1h9gOnlZ+OA8659EV3OVRsHMfjgyzGpoB0ELTSRhQOwV+NVF2R3k7ZoUUh3eAuT18GM8QYQwRfY06anIu4wRBfnkCyjCUYpo4E9qe5Fco6E4SYuOD99LUsqEJ/CQSXRjehWRd3zdqi3TqlAw/g2aztnat+2GSl4C1GPCxEDLwdYoEQBtbdTs0YDnqUnDcip6c8hvJD8sJxRxO00ju969VQfyt/o4lsPFPrrY+DGSyGVeWiYQBqKoJcgFjccevbFsAx0z/tgrpZa2f2Vb1hiKxKMD6pNyQXx5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d3dd7a-3d86-40a2-a50a-08df0238e183
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:39:03.6341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68h8dDukoE6R3P7w6nzU5idrc+uyQskgUAstOAUJCqClZZcbU+ZvMo5SzPofnplbkk6YFyoLRNicxqkCezQ93h7Th0Z/mPKbrJR6uust61c=
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
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Do not clear the tx.calibrating flag immediately after starting the PHY
> timer in ice_ptp_port_phy_restart(). Instead, keep Tx timestamps
> disabled until the offset verification work (ice_ptp_wait_for_offsets)
> has confirmed that both Tx and Rx PHY offsets are properly configured.
> 
> Previously, tx.calibrating was set to true, then immediately back to
> false right after ice_start_phy_timer_e82x() returned. This allowed Tx
> timestamp requests to be served during the window where offset
> verification was still pending. Timestamps produced during this window
> use uncalibrated PHY offsets and can produce incorrect values.
> 
> When ptp4l receives incorrect timestamps, it may reject them and wait
> for the next sync interval (typically 1-2 seconds), compounding delays
> during link cycling. This contributes to the time transmitter port
> becoming unresponsive after repeated link down/up cycles.
> 
> Move the tx.calibrating = false to ice_ptp_wait_for_offsets(), after
> both Tx and Rx offset configuration has completed successfully. This
> ensures that Tx timestamps are only reported with properly calibrated
> PHY offsets.
> 
> If ice_start_phy_timer_e82x() fails, restore calibrating to false on
> the error path to prevent permanently disabling Tx timestamps when
> ov_work is never queued.
> 
> Log a debug message while offset calibration is still pending, including
> the specific Tx/Rx error codes to aid debugging stalled calibration.
> This path is expected on every routine link-up: ov_work is first queued
> with no delay and the vernier offset cannot be computed until at least
> one packet has been transmitted, so the first several invocations
> normally land here. Use dev_dbg() rather than a rate-limited warning to
> avoid emitting KERN_WARNING on every link-up during normal operation.
> Log a debug message when calibration completes successfully.
> 
> Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 36 ++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 1d647ccce7c4..9d99cbb42463 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1266,13 +1283,20 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
>  
>  		/* Start the PHY timer in Vernier mode */
>  		err = ice_start_phy_timer_e82x(hw, port);
> -		if (err)
> +		if (err) {
> +			spin_lock_irqsave(&ptp_port->tx.lock, flags);
> +			ptp_port->tx.calibrating = false;
> +			spin_unlock_irqrestore(&ptp_port->tx.lock, flags);

Sashiko says:

> When ice_start_phy_timer_e82x() fails, does setting tx.calibrating to false
> cause timestamp requests to be accepted even though the PHY timer is not
> running?
> If tx.calibrating is false, the requests will be accepted but since the
> timer isn't running, the hardware won't generate completions. This appears
> to cause skb references to be held until they time out (e.g. after 2
> seconds) rather than failing fast, which can exhaust the Tx tracker.
> Since the next call to ice_ptp_port_phy_restart() would set calibrating
> back to true before attempting to start the timer again anyway, would it be
> safer to leave calibrating as true on this error path so that subsequent
> requests are immediately rejected?


This was done intentionally in the original patch and called out in the
commit message. I don't know for sure which is better. Need to get input
from Arek on this.

Perhaps its better to just leave this disabled since the timestamps
won't work properly until the timer does actually get initialized properly.

>  			break;
> +		}
>  
> -		/* Enable Tx timestamps right away */
> -		spin_lock_irqsave(&ptp_port->tx.lock, flags);
> -		ptp_port->tx.calibrating = false;
> -		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
> +		/* Do not clear calibrating flag here. Tx timestamps remain
> +		 * disabled until ice_ptp_wait_for_offsets() has verified
> +		 * that the Tx and Rx offset calibration has completed.
> +		 * Clearing it here would allow Tx timestamps to be reported
> +		 * before the PHY offset registers are configured, leading
> +		 * to incorrect timestamp values.
> +		 */
>  
>  		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
>  					   0);
> 

