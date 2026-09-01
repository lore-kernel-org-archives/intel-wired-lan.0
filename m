Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F44C624D2
	for <intel-wired-lan@archiver.kernel.org>; Tue,  1 Sep 2026 12:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA3A580B0F;
	Tue,  1 Sep 2026 12:41:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dkAfcJlKV0NB; Tue,  1 Sep 2026 12:41:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788266496;
	bh=w4G4cgi+8vs8xfoR5aQxsAFdVHXfm1TzR/WG8az1H0U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yxJO56OfUfv3tKu0aADx2EmDSQUO1jNqy2y5McjHryh8mHr3pbbY7NrVEoJT9gbH9
	 ypPE7Rw2AgqVtssMJTle/uR/48w59zfiojDgCfDLscRyphSnzAO7gdYE/2YzD1q9H8
	 QFL8OQxDZw9t2Azv+/Ym1TS1hgEoZrBTG/MfJuCukMyXYgB16nxpLjka70HnKEoVlM
	 VZp6cfhsaAV3kK70tnw+pj/tQ1ynBmPUXcOpIeWdgtZZ34MeF/pdfGPfwvuu2EnHji
	 FEZ4PD8GuuyAdGHy61x1UKn78jEqwDUw94uTeAbYr/V7ARVFDuCyUI8jTLUs4nzmCP
	 3j7UPIh10Wn9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F14C080AD0;
	Tue,  1 Sep 2026 12:41:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 712F3363
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Sep 2026 12:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E6F5605A7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Sep 2026 12:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yqZmExhQ4pMO for <intel-wired-lan@lists.osuosl.org>;
 Tue,  1 Sep 2026 12:41:33 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=We6k0T3j
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84E1060698
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Sep 2026 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788266494; x=1819802494;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4zYRdq6jGGm1rJcnFmhNYOAUTA30/pablK4AoPSc3Io=;
 b=We6k0T3jLmziyC6KHHEp0js7VWsX96RaH3Zx3yFTLVSK1hOV6QEF6FY7
 1vaFNut6/Xd0ZYJ2y4+ttftEqUicWVyM87L0IraFJph+9hbN0+HLrYgS/
 TxUlj4Wgothhg6K85TeAO9o0QUOs8olXlw4p14IitD2QLzek/9m5OYGa+
 K8oy24PLAhQKplIsEuG9lir3n4YviKxyGOSGOtRnvu8s3jNVxdHVtu8pL
 dEP5lY6ia5GfbR4oZMDV5ZQzbZ21HraJjBVYR5jNccBg3KRyFpRGWKQUb
 ML6c4HtGv5Qp10HG23nNP/coNXbZhN2ukbMyJbcwD3nfGwM09Rz5pbrju w==;
X-CSE-ConnectionGUID: o7XpDlyNSwOQTsxJX43NwA==
X-CSE-MsgGUID: FlUahpN9Qgm6cFekTnYZrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99853670"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="99853670"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 05:41:24 -0700
X-CSE-ConnectionGUID: ebTu0NBER4qwmBALPmhydw==
X-CSE-MsgGUID: R62VWQirSzeuYbYMMvNIkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="293921064"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 05:41:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 05:41:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 05:41:23 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 05:41:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEpUeHJI9azFJ6TBFRV2SGbXI/BcWe5s4nBOCqvjIHRY3ZGYapjQW7CLl5bkhLMXC0AnhA0TgnC937PhKLyCHc5kRw1I8GktQXGeBf75pXgY4eL8oUqcPphI5cp2ze0C4FkeuUEFUoBG1vlE4W/NjrSG56O09hqkpfsqsedL3TzB0TDjyL35GO0pSPFsGNLdevkILsh5dZo+xOR2HEzp3eNgzK69fTIp87b7Ex01DhN/pVLKxzl/jHgzWYe9rBq3nSZJjISujRyiVgNh4KOCtgkrrk/IEYbTCGWhormEM9GCvuhPJ0f/vXkS2OFPNa2DthS8twQVgPExZh7QGTE2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4G4cgi+8vs8xfoR5aQxsAFdVHXfm1TzR/WG8az1H0U=;
 b=twYOeQmwSJyahf5j8Jj+k3oAna2LxlUEa204Lbf+Sp+WXboOh5braeqRVpVgfFmDRE/7GeAPNDyb7AtnLBD1M+bSl/XP+O/OTv2aeRryKt6l2Zd8zy7dUCAgqu2u45QYPiHALxCidhgt1I4INW1COxYSOIECX8x++eOVlHYiHcIDHhJjkssX64Fiu8Ckrn1HVc6YMr3REjf+hXeFJcZwlRReOvO71dajHWgk17jM8zcPufD5UQQDA4gMPP2KKPFdE1uU0A+AfQG/TUPmAPZYgch8gE9ZgugWziBEHFQtOrIbLtpyF2Ab+QpnBAoc4zx+uWZV7pZ791M3Vcbn8KyyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by BL1PR11MB6003.namprd11.prod.outlook.com (2603:10b6:208:387::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 12:41:17 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 12:41:17 +0000
Message-ID: <db7fbcb4-743b-4ae6-9893-0e09caca15a9@intel.com>
Date: Tue, 1 Sep 2026 14:43:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 1/3] ice: Convert ctrl_pf pointer in struct
 ice_adapter to RCU
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>
References: <20260831161100.216773-1-sergey.temerkhanov@intel.com>
 <20260831161100.216773-2-sergey.temerkhanov@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260831161100.216773-2-sergey.temerkhanov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0126.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::7) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|BL1PR11MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: ec500ca6-2df2-4ec8-b422-08df0826512d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|4143699003|10067099003|5023799004|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3teOKJ8vSMNbcR+xT9cPLBGwRWLTuk6CjgomvV0nNb0gkyTgMlYW1fcrUq7toXufNHWAfiT0+gUYQ2WWFiQUzvIB+F+LUVZsISjtEA7676q4kQpjKHqelC8lU1QNZd2PrGfj60ethdg4BvSRNugi/VUuYTG3I/oMsVdXHLJ4RHRhaDLIYA/KV5FkK/7IaaiPjmUsrZNkiaq/DWFqDMmZCUOi08Wfjt7TVTGLOrNBGcOHFhKdN3xnipYS/+IIBuS+CGK0qK0ykYLWOxZCpmLod8C5Gr/xrPptZt3+xyWywybLLLnWMrLSCLXMOqchmGd9DaQ5Q3xBjoLNcLqqQc977hyVFzHgh2kFjkWmO6FLb5NZ0X8XZ6WH1v8OVwSL1qraxLWDO3X5TIlMnG+7xFBHvC3egrwJv+9tK42s0mCuDRtIB0CS1LdTOLvBqRp7zA/824GnPE07RCwkG+2XR0RXvGrwoo8owB/GVCF/B34vXH+upbefWjL6MoFZG3Z+5skNuc+dyOec49UomAgwlwhEMf+QJhyb+QYLrjoqa39xf3itaRaryMlgPVdIZfg4A31qrbl0ZOna6xkPxVTowECit1wI9yUsBSlzm2F7V6tlKtfjFSxvAICFqSgxXtF/KVXdDA1orcPD9AiN+cu8ebOueQQnxMO859yfEwMCgFL4J6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(5023799004)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjUxTGZ4YlV1ZzdEQS9Db1pWbVgvQUhtKzJpL0RWTlJPS29VNGo1dVA3TGN0?=
 =?utf-8?B?UHpPa2pSdkQrT20yRGJTMTVNcmV5aG5zeUpSY3gzM2lsci9BekJRTEF2cVZB?=
 =?utf-8?B?NjdkVXUwdWlDWS9pZjN1OW5wSTZIR3Fqai9yeTRFSndTTGNQSVZUYmRIMnNK?=
 =?utf-8?B?RGxEdXRoOVNoYjhLeGI3WjA3amhnYU4zejltTFdNc2ZVQVdUTVEzT2diYVF6?=
 =?utf-8?B?Y0VuMnI5YlltMGpZY1pVU1ZrSlIvU3BxbURlOUFheW1Bejk3Nmwxa3Z1amNo?=
 =?utf-8?B?MVdLS2VGeGtQUnZGTkFPdldVTitlM3NVand6V0lHZnhUdklIR2JiN2I0N3dD?=
 =?utf-8?B?cDJ2ZVl6dG94aDlFYStTR0w1YjU4cktaMFMxWkpmazNEcVR0eGF2bitHU2pB?=
 =?utf-8?B?Nmd0S043UWZrZ3IwbFozWkhPcTE0bDFDV1kvNnFuZnhzOXJxZG96clYrQVR6?=
 =?utf-8?B?djBVeXYzTUdKWFMrNFJiMkVRTU9xaUFhTkRGU0hGbE1CT0U1Z1docXk2bEZy?=
 =?utf-8?B?dFFKR2dyQnI2SXI3djB6T1BJOUJtZUFsQWhMTnR4bmZ6UjF0d3BWOXppTUpj?=
 =?utf-8?B?TldodldNd3BZeFZPbDh2c0hBYmxGMG0wYlFVdkJWMWdlUGI4QzEvUVpHTTNM?=
 =?utf-8?B?OXBiNEVUQXBzVmdtQTBqSElrMUhpNEVQQUNKSGRkVG5udGxxcStudXVWZlMy?=
 =?utf-8?B?Ulk1VVNEQzJmZkFGaWp4M2daNUV6cW9tN05WR3lETG5sVmxtSXM1WnQzQ0Mv?=
 =?utf-8?B?bisrRzQ1UzE4RHkvNGRya0M0N21mS0RFNGFKK1hvL0VFNjFDR0dEZHJ6dEI1?=
 =?utf-8?B?a0Zqd3pkaVlhSlZ2K0swUjdqbklsb0ZZWjVNUGdqZDRSUFJFUU1NYUVJRmls?=
 =?utf-8?B?bTBDNGlYZnhFbEdPSmp3YU9DOGl3c0xyNGNLbFV1b1NIV2xHbVV6YjA1VS9q?=
 =?utf-8?B?SmxFelkyL3dtK3RtTFpHaUt6ekpTVExYejJ0N2RCZ0pMNXgxWmNXV2g1VDlJ?=
 =?utf-8?B?YnBHMHFRVEw0dlJ5Ni94c0JncjBtZ2JObzVUdURjbUFySmVlcXprTVZmbFQx?=
 =?utf-8?B?VDM2SCs5ajNTYkpTT3lDeUxZaE9TcDBlckVTbXhFYXJRbGExNVJ6NUlRTWZi?=
 =?utf-8?B?a3RQeGZxbW1zYXNobE4zdTdNblA4d21DdWV4c3FWL0JIZ3VUZXo4NkU2Z1dB?=
 =?utf-8?B?MVBQeGl1NGdnUWQzaUNoeGEwK1VFTGtZSHBOdUJmdWhlMlN3ajhhbU9nbnpz?=
 =?utf-8?B?M09UQ1hoOU1kRjZMdVE5aWVXeG5wMlI0R2l0Zkc3L1VFVWg3S0dFR2N2VFJJ?=
 =?utf-8?B?L2cvaGsrYkQvRSt5a2NzNFlKMVNlajM1MTZNMDJQNXhCb2NjaGx2YzdkRVov?=
 =?utf-8?B?R2REeklqUHJ0eTJBcjFadnhybnVlY1VqOFBLR2hLcWhBWmVBY3Fuc2VPbjA0?=
 =?utf-8?B?VDFBRC9NaHR3UE1zMk5HYUNmSm9sd1ZITDFxbXNCQm5pNjlnRWtVR0hENDJz?=
 =?utf-8?B?bnBJbjZrTVBpSjBTQndpN2NSRHdYR3BYOTl1NnBjSzQ0ZjRqWWxEQlNqekpC?=
 =?utf-8?B?OUU2dktEM3pQTEN0S0s1b08raXJ6cHR3cUVqRDhKOGZRQnA4SW8zWmlOUDVX?=
 =?utf-8?B?WUtZMXlJcTlra0I3d2pDNlBoZUxmSzVPNlgxS3hHQUVOMzdLN0FUWXpiVmdB?=
 =?utf-8?B?Z2kyVWFvZnBDRDZkM1d3Ym5vanBFdTM4R0Jua2hoSlVxRndNeXdEaXpFK09q?=
 =?utf-8?B?aytPQW5DNSsvVG5JNDZST0c1SjQ3RzhTQUdNa3g1STB4SjQwekN4SXZUc0M5?=
 =?utf-8?B?a3g0bTZmdFNUUktPZXh6bWZWQ1MvWUhSMGdERUp5ZFlrWEVuSHI0ck82KzNU?=
 =?utf-8?B?UW5VRU82RzZiS1FyNjdZMFpHbVlReDZ4R0tFNDB1bFRqaG8weWpUQUYyV3lo?=
 =?utf-8?B?Z0dLd0FpVUhiemlTT1Y4NWJSWlFWazdDdnVFL1Mrb1oyblBuNFZqZGdaSERz?=
 =?utf-8?B?bVorRlpIUW8yL0tGY3VPcGltekJTTFlzRnpNWU96VFBpU0NEYUxaNHhwQ1dV?=
 =?utf-8?B?cmh1N052eWlCQUgxWmR6Vys0ZE9SSTZ4cy9OUU8yNUpyN3hPNmVJK0NJb201?=
 =?utf-8?B?RytRM3draktwZTVUMForY0xWRmptSU9WU1UzenRIRGNXWVZMS0FrUTNieUJ3?=
 =?utf-8?B?N2tDaHRkSnY3S2pObHJJZ3VxeDBLK1QzcXVKYXhSUGllQnVXbUpsR21RQ1A3?=
 =?utf-8?B?QzFxYUs0ak02YkpZYzNET01NZ1VRYkU2RXFLWkM0TGU3Qyt5RzFFWldqOFFy?=
 =?utf-8?B?WExNemZWN0V2RVZBM256WklYeXhPNTc4TUkxcWIxSjNsWEFGZjBuUllsV25s?=
 =?utf-8?Q?IFqdkcE7wIkrtiIs=3D?=
X-Exchange-RoutingPolicyChecked: rYBZl2JWsBURYkiAH2GOyqnAJG+BeFQ8u9WbolGnVewCNM4L+jnBD89RJdVsaVQR+5zg8dVwK6xub2q0vxgZS1f9icKphdZixQHdnsoAlydaiGmqSRKrGqcDaf0IfnVPkoX35+M/FFlsQcmOTJzDK4zhumTiMInB4XdNri+77Cb1Krn0r7qlfLlTgWwkNEtKkGAWR/f2Zpt5l1/gerJSqrbvSV4xhzw1mNusOvk+HF2k9XGVunTZJgRq5WV89v8mrQi0RT7ndAftIPEZ6BRgW3/F2zDa/W9P5EEtMrl3Ytm0mWkzpDs9iAXcuq/4cnMeOv5izIxlSIcmNbNCGQm9Jg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ec500ca6-2df2-4ec8-b422-08df0826512d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 12:41:17.5764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vP54Vlw5b0DXXG8wzkJgAQIQUvXht5U9tLV7sI/THnnH2r5ueyYwd4eFJaC0QOxps2AX+AQ1CfiqYYqgwTQvEy1X7rVqvyN3Z7X1jXVhGwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6003
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

On 8/31/26 18:10, Sergey Temerkhanov wrote:
> Use RCU to ensure the consistent state of the control PF global
> pointer contained in struct ice_adapter. Enforce RCU usage on
> the callers.
> 
> Fix a potential invalid pointer return due a TOCTOU issue

this is rather convincing/self explanatory
but the rule is "Fixes tags are for actual bug fixes, not theoretical
ones". (same comment for other patches).

Would be best if you could describe how to trigger the bug.
Or just drop the tag (since you target next- anyway).

> 
> Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Tested-by: Frederick Lawler <fred@cloudflare.com>

[...]

> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (C) 2021, Intel Corporation. */
>   
> +#include <linux/cleanup.h>
>   #include <linux/delay.h>
>   #include <linux/iopoll.h>
>   #include "ice_common.h"
> @@ -335,6 +336,8 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
>   	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
>   	u32 cmd_val = ice_ptp_tmr_cmd_to_src_reg(hw, cmd);
>   
> +	guard(rcu)();
> +
>   	if (!ice_is_primary(hw))
>   		hw = ice_get_primary_hw(pf);
>   
> @@ -353,6 +356,8 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
>   {
>   	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
>   
> +	guard(rcu)();
> +
>   	if (!ice_is_primary(hw))
>   		hw = ice_get_primary_hw(pf);
>   
> @@ -2004,6 +2009,8 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
>   		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
>   		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
>   	} else {
> +		guard(rcu)();
> +
>   		zo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_0(tmr_idx));
>   		lo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_L(tmr_idx));
>   	}
> @@ -2173,6 +2180,8 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>   		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
>   		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
>   	} else {
> +		guard(rcu)();
> +
>   		lo = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_L(tmr_idx));
>   		hi = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_H(tmr_idx));
>   	}

guard() looks well suited for your use cases

> @@ -215,15 +221,18 @@ int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
>   void ice_txclk_update_and_notify(struct ice_pf *pf)
>   {
>   	struct ice_ptp_port *ptp_port = &pf->ptp.port;
> -	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
>   	struct dpll_pin *old_pin = NULL;
>   	struct dpll_pin *new_pin = NULL;
> +	struct ice_pf *ctrl_pf;

RCT rule counts whole line length, including assignement.

>   	struct ice_hw *hw = &pf->hw;
>   	enum ice_e825c_ref_clk clk;
>   	bool notify_dpll = false;
>   	int err;
>   	u8 phy;
>   
> +	guard(rwsem_read)(&pf->adapter->ctrl_pf_lock);
> +	ctrl_pf = ice_get_ctrl_pf(pf);
> +
>   	phy = ptp_port->port_num / hw->ptp.ports_per_phy;
>   
>   	/* Hold txclk_notify_rwsem for read across the entire critical

