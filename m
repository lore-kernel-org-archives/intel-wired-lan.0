Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B596BC55ABA
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 11:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69AD980B52;
	Wed,  5 Aug 2026 11:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wSWnu-eA-Ecs; Wed,  5 Aug 2026 11:56:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D572580AD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785931008;
	bh=dcyET0QzsLRwzerHoax2iYuB//3kKv9xVwWMOYuSdAE=;
	h=Date:To:CC:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o9B7NYHQJ+TNEGrUDbBYe0SFgGb4LfrIKrnItaqJ/nkvWH817GMsy5Ne+p0/vn0Wf
	 ORmoMd8iBsxJhm/w4Bh82UDWyXrgvkDL8OYkhkBUly4vJdhlNtwUl+s4nksnos7MeT
	 x3qUxEH03nCxjHtfk8NdGoOFVqTq7alSe6Tt0Sz4NVQN/oXHpi/hTVXLBVcuL3BGDN
	 qmvCsbo9wsGsRwx7Qqnj7CKou12K39D1NHJ1iXhYv+8hKw93iC4g3qkuyDia+EBRmn
	 Bwt8YhIQESQIxOKSg/WJGyuFz9tPtxJPvJyd/U8nnhHAc333q5YynQw6tf0uEipB8/
	 q5wycd9EbjNuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D572580AD3;
	Wed,  5 Aug 2026 11:56:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CA17313
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 11:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E65B40067
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 11:56:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3IqrU9gVXVNT for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 11:56:46 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8EF3340061
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EF3340061
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EF3340061
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 11:56:46 +0000 (UTC)
X-CSE-ConnectionGUID: SzGPJgWATdGvqzTgeGen6w==
X-CSE-MsgGUID: 1bn2RTyTRBepXQHmL+TB+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="109290045"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="109290045"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 04:56:46 -0700
X-CSE-ConnectionGUID: snih4xH3TMyJ4JrlsLa1pQ==
X-CSE-MsgGUID: S6YEx7khTpuJOa+w9I+Y9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="265631546"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 04:56:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 04:56:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 04:56:44 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 04:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNdRIuz1YfzRhnkMAxSPk+By1QPylLpcxNe4yPbGrhh4507aw40xwfJCz4s2/8w/ZjvMdlKveaHW3/RZhp2EfKPnattckSma1aLd3/tRwUchYN6eX6gSDHjeMhn35SRrJYqXu2HaUSimdHvk5QdgNKkvmxdCSbSNV5d9Eo7XqzA2O5xXy/tZ456u0gkUdOTHOd6zI/NLyyxvNkgRDuPHlo2CBJ5g45FWjlwZwCE9TMwg5ImB4mshfc+ZaSiI3i27tswa7adU7QuwiH1FaQ74tSzFXkGyQ4EIXns+cdDgoFGdHQ6s2s370Lh/JOsp9Mk/VnR6Gzjex0Rll0KYOP3r0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcyET0QzsLRwzerHoax2iYuB//3kKv9xVwWMOYuSdAE=;
 b=p++gTfimmBebRqpqGpHjZHwfjgP5ASGthVfWXZmKym15JDG5tNAf+Pt4dOJvJsqnVU/0A/uhUbbycMKZKXZe552FUTTb9b0Mx6mRz9eUj9OUqY8Q2UDX0mv86EW/rkxln+ZUppxhqfN69sDDrHouLsA4/4BEmthjgNH+4Nvqb2w8vHSidGkPfUk6JY4NGU1402iBTe6lcgo1DKuyW8nulaLQs91gsDztdIVi97HcUOb52LkcXWDeR7TqV+xbSydHCEeIFAiud/FUA9E1GxJV1ANA0/FuMTah24VFwPP3NkgAM0kSn3CG+xAYzIcCBxSNHY9nIxClzrDXs7wVrcDf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by DS3PR11MB9867.namprd11.prod.outlook.com (2603:10b6:8:366::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 11:56:42 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 11:56:42 +0000
Message-ID: <8f35edd6-6b37-4575-8a30-558ae0dee0bd@intel.com>
Date: Wed, 5 Aug 2026 13:56:35 +0200
User-Agent: Mozilla Thunderbird
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Ally Heev
 <allyheev@gmail.com>, <linux-kernel@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-0ddc81be6a4c@gmail.com>
 <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-2-0ddc81be6a4c@gmail.com>
 <72754805-575c-4568-9dab-514e1b758847@oss.qualcomm.com>
 <ae840989-03df-4e84-a9cc-46c51f6dd44e@oss.qualcomm.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <ae840989-03df-4e84-a9cc-46c51f6dd44e@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0033.eurprd04.prod.outlook.com
 (2603:10a6:10:234::8) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|DS3PR11MB9867:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d908f9-86d8-4d0e-c12d-08def2e89d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|11063799006|10067099003|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aTT7rLDbijl4CrlEfYtD76QQ4zqe/1xQTe1ZLtwPCLT39aGSxCrokKY9o84YuzteaqOh4LJsDTxsFsAej/Wgsy3CpWtZmW3Sjx30XeL3QR7rY+3RX0V5o17vF1Bj35CUZiqH8xwaYhKNjB5nxF4qtKV776mND6xouVwGeXRaQnAlKbIyuzGVr1tCx8R1KuymvQ0HVGspyOwBMm67GvEa8CLARfQ5UhJzLg+g8ePt5lGZIz47EPfEHY4kktJGa5c9p4ZvPeFywk/KS1vv0N2fC0V4StghVbtjoSPMWitbf+g9TFdvrk3H3wKhf3U5iExgcJnkk0FZMU70GKxrJta19aGVDX6sVY/Jk66Of8vMwdpcBX19mEXh7VO2/wfHLAdpCakEwROizMVi0Hy4dkXLZhsa5uGxUVo5iLvk8vQduVdyLEkTrxTXajORnuXSRwuV6D6D5deF6uNLkCCtQKw9IUuGH+Rkhfc8NYoeU3b81XAOJhmx7khzFBYsWji8XpPbtorPNO9z5yP+WQnD9a2en0hypqR6DOqU/V+UD04TM0KCfLzALW0yYl9+6ugdwelG3PNmPwHk9KCZwZtIpjcRLCZFqKOh39xuh/NHi4QCWpkvK8vk9A9X4Gjhcgar1ABHaYtW1w8gYYm8fgUGX3UeBr4lzkMYK8+1H2nuPcic6LY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXlUT1dOTWVGdE56dW14OS9uS3NzTityVExyUCt6alZoRldQMEsyRjJyYWlh?=
 =?utf-8?B?ZUc5MDV6MlRtcHFkZTZVY2YzZVZTWmYwYXNNR3dteS9CNG1ET0U3RjdZN3cz?=
 =?utf-8?B?MGdRWnIwRDdxSTZmc01GOURXNWppYVFheHNkd2VqYjRRM3ZlTlRrT1lFQnQ2?=
 =?utf-8?B?amR2ZG52elMwUTV0VmpMalVlaFF3cVNnbUUrNThtTVNVVkNaQ0doZlhaZ25R?=
 =?utf-8?B?L3R2QlNmY1BOOXF2aFY3U0NycitySS84a0RTZVNlQnZwc0hCRjdGMWdxQ0JU?=
 =?utf-8?B?VUVvVm8zVE5uMjlRcTl1WXN2cXRlcTY4czZuWjFvNVNRdDVVUFExRkg4YXA0?=
 =?utf-8?B?L2RKUHdGUWpPUWlueFQ5NG03NWt3V3FTamRyU1NUbEhtNzB5b3ZYOWNYU0xm?=
 =?utf-8?B?c0tPYWNxQ0NCN0pieUFyN3pGTDdNYUVUQ3RKdyt1c2dlRzRiakJvaytVNlQy?=
 =?utf-8?B?K3FaM0tOdk11QW5POXJ4R1JTa2Z3ZmlVTi9seTF1UjFWZkl3a2o0MWFLMUdm?=
 =?utf-8?B?M0pyOXFCUHNmZDhoajB5cDBaSW9nR0lOM0ZEKzVxL1VRWFltMVIwc053S0ZG?=
 =?utf-8?B?Ri84TzRiMUtUZytsbWFqY2tVcHJXR3FPa0dFQmdyU245Q3BvTW1ZYmF0cXQw?=
 =?utf-8?B?SW9BSXpKNm95b3g1eWVieWZacEVKMFBlT1dwK0V5RzJQSmc3VkJLcEVjQk1E?=
 =?utf-8?B?Wkp5TVR4WkZqUGs2RmQ5MU12RW1FL0luNytQbWZDTnJrMklMdi9DR2xjc1Vm?=
 =?utf-8?B?M1JWNXdXN3FRNVlkNjhsRzlpY0Z1K0NSODljNHhTWGRaWDd0WTExaGxvT3I0?=
 =?utf-8?B?L2RMV3VnVUdSTEcwNXd1Vmg4dmhtWWk1eTV6aGNmcGZHS0g1MDc5WDhzTVBD?=
 =?utf-8?B?Yk9FcHZIVGNYZWwwaUx3TjB6MHJ6Y290RGo5aDQxYWNFYmJKdW5OanVxWGlK?=
 =?utf-8?B?VlpPNE9XM0ZPNlhIcGI5MFNZS281SFRnRFBvNE5aN2dZeGcwa0NLTXM2RFNP?=
 =?utf-8?B?REN0RFlmbnJuOTk5Rk5EZTJSMFNRRHhmbEtOUnB1a2RKc3p4ektsNTY0dExw?=
 =?utf-8?B?MEZYLzBobitOTjBKU0p3SkF5Mzc5RlI5V2JwZXA3Rm5nVlBxRk4vQUJIMlN4?=
 =?utf-8?B?S0VZUFlSeVloTDdOUW9yRm5JWUhmLzdQakhLRFRFVk05ZDlia0FIeDlTRFZz?=
 =?utf-8?B?eWtZYWF5Z21LZW1xT3k1d1FoellCM0pOd1JadG51WnRTbS9OWWNMVnVrTHFL?=
 =?utf-8?B?ekM3RzNzbmlYemQ1Q1BKUFVMYUZZVmZhVjc1OXJOYWluamlxemxadG9sQXpa?=
 =?utf-8?B?QWpuMVdsdW1WOVZweWV1ZEJsUkIzRTVaMEhvSkhpMTl2cTFnc1lKMTlkK1lJ?=
 =?utf-8?B?RTRnQUl2Unp5UHJOZzlPaXNFNTErajdiTEtyQmFhSDNRM3kxWHY5T3VPNlk2?=
 =?utf-8?B?Y0xqOVppZEJrMDA3anBXU1ZOdTQyd1NiZmZiMUlwTDlIN3ZlVHVxS3hMZkNm?=
 =?utf-8?B?aVdpeTQ4aHZOTWQxdDA1T1BGcy9CbFlqbXFGbzNaUktudCt6UTI1ZnFVZUFa?=
 =?utf-8?B?a0dUZ053Mjc4ZktySUdTZmJjcTQ1bjBFQkRUSkpuTDYrMnF1U3JkcGZ2VmYy?=
 =?utf-8?B?eTJLMDRVaTFOaTlGZkFJR2xEcmVjekZFb05zWjhoUjVXakxoVmR3bGY5VzBu?=
 =?utf-8?B?bHpFTUFMZUptWStkVFJXMHU4YkgweDIzYmJlSTNzbU0rWDZKTjJhWGVNN3Rp?=
 =?utf-8?B?WmhWYTJ1Vmt2UkVaMi9lVmtSU01zd0daNytKSG1xaGFVT3dIcUR6eVRISTBm?=
 =?utf-8?B?Z296WVMzbE5rb3FLRkxyZDVHRGZDZXFFUkovU0FKZ1d3WXU5dmtPMHREWkNv?=
 =?utf-8?B?OC9aeDl4aE1CbHRjMENnV3Vxd3ZJSnpJV2VPUVpSRkJ1bmpjUlZ6WFFXR3Jz?=
 =?utf-8?B?U3dmbTRJSHZOWUtYVzY5bytqdEc0RHFFYnNFN0oxTmw0N3R6M1RFQjdTQVdr?=
 =?utf-8?B?VTZvaWhRMmlMdWtveHJzSTgrajVNcUoxN0FMSVhTLzdUckZvQ2xwQldnUXl6?=
 =?utf-8?B?djU1K0x5NlhxMEpLNG1IOWduNkZkTWZYdURyWFd2dVZmVmNaRi9RRCs0OVcr?=
 =?utf-8?B?cXpXV0lXWGphbWFxZEphSFdnYVZWM0RRN2pRbTVUZUc1VXVHNEZFMDVzam93?=
 =?utf-8?B?SDNsc1FKYlgxV1J0eHdUV0dnY01QTkIxYWRhMlFvM2pMQU9QWFhSenZDSTZN?=
 =?utf-8?B?T1NIVTUxcnEwYWpaV24rL05pUEhrZmkwb2NQT0txZ056OE83eEVnd1gvTTdM?=
 =?utf-8?B?Sis5WEVYbTRWdkF4L1BaeEFYdUFyNnBHWWV6RE1YcU1BYnhhVS9ueWdrMkJH?=
 =?utf-8?Q?yqzpyElfiRqc8r44=3D?=
X-Exchange-RoutingPolicyChecked: dEuMhoD7Guma/8XDBCboQ14LCT194jUZfPoYo4bT9+6xcvBTJQklmq35aE9SCHaUz2h1TmDIVwjdWD0YV/o6fY1vePcIYzhWNm4CnN1IOzUpU3ImQs8HV9HHuEDg2SGD1D2ARLuHhTfDATf656/ReOiTCxjhgCecnatkjnmWSFOA5CCKYRYfakGF/6A75BlddUe9lB4VBLrSTdKBU1Sq/OnP9NI7J95RaOpk84wjIvKsEGue0No6xG0jdK4esul/7dH+K4vDEv69tZzma5n/gmLa/0Q1hn3/ikePcgZ4GIV28yDDgDTfgCrVGHlfFX1slZyL7mcHlI6ACNb2oY91rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d908f9-86d8-4d0e-c12d-08def2e89d6d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 11:56:42.2734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/Ap8RCuUQYOPOy3rXYcsmk+TxD7fEwimokvMKZL0IUaUdm0dsK8YdZWvli+FCTw+DQCq76FPgl9Hn9w5sAR7e5UCCoPiMTjrX7IYV2kGvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9867
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785931007; x=1817467007;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6ZFAMR+ANMJv5Lh8g3+qt0eNuresdjLYOLkb1sHQYU0=;
 b=RLAgUmWMP2/ItA8fYBl1xZ/1hln2bnqG4Cc3b3N3ptVK5SuMXQARjQJo
 OIFBrak1z+mg7DTC+9mxwNYoTLjAlIcwELkrSztTUclSau5SK/rSsS6AC
 fzFv2RRuJGir+gkyadfuh1lzj+lun10WgHouqSJyuOyA4arh7KGCau5fR
 pgbkjAOsp+NJLJdPeU/PPduYm5ofQqBo4fAOzzZDblrY3OJgW+VFSH9HF
 MmDCBXlcm1ZSPKC1Mx+/IevhENGYM2ySkssi5x+nIM2GeJNdS8P+qrezB
 khWiojhqC+nNtBwx+Rmnwi9U4XZ4gsQLILpEWyPaX64WgJn9KsRfpv8V9
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RLAgUmWM
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] __free usage
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

On 8/5/26 00:56, Jeff Johnson via Intel-wired-lan wrote:
> On 8/4/2026 3:54 PM, Jeff Johnson wrote:
>> On 11/16/2025 7:56 AM, Ally Heev wrote:
>>> usage of cleanup attributes is discouraged in net [1], achieve cleanup
>>> using goto. In this patch though, only uninitialized pointers with __free
>>> attribute are cleaned as they can cause undefined behavior when they
>>> go out of scope
>>>
>>> Suggested-by: Simon Horman <horms@kernel.org>
>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
>>> Signed-off-by: Ally Heev <allyheev@gmail.com>
>>>
>>> [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
>>
>> <SMH>
>>
>> If using __free() *correctly* gives more readable code, why wouldn't we do it?
>>
>> The only problem with this function is that it doesn't follow the guidance
>> from cleanup.h:
>>
>>   * the recommendation is to always define and assign variables in one
>>   * statement and not group variable definitions at the top of the
>>   * function when __free() is used.
> OMG, not sure why Thunderbird showed this as a recent unread e-mail.
> Please ignore this noise!

always happy to see some __free() advocates :)

perhaps with our new meticulous friend Sashiko __free() would not be
misused anymore, especially if we let them know the following quote:

 > So just make the rule be that __free() without an assignment is 
simply > a bug.
 >               Linus

and the resulting "less code" is always better (if only to fit more
data into the AI context window)
