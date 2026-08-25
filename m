Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340B5C5DF9C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 00:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4A2C405FB;
	Tue, 25 Aug 2026 00:11:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0qjz-Mzy4zvA; Tue, 25 Aug 2026 00:11:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787616674;
	bh=W1TZJt4u3p40OKGi6Fxaf4/dz6m8j3YqJ698gGznn6M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SI42UMK4b/Dis7z6WVALbkl18dNklAxlvaV7xWJdaYf/Gj65odX+GlmoZ9bF+hLeW
	 2++HnWZBGa6HWvLkuYEJwCfdAzn9fCzgdOpFMRKhyVuazS8GVNEIgFUVSygdwG7HyJ
	 sHNlTu3eWNMUwLeWJbZckS39DI/8xLCj+wDrHfPO7Qmr59b35Ak6+7J/QCT+1iPLSo
	 oLPzeW4p+Wo6lGuK137vwNRq0w+NuE7mU+4QEy6La1vxW7Z+QQ2krYgqFKBgWtzbji
	 q9D5490lGfZwN7kHkUaPHUeKEsF98V6CdIdpsDHNnxOV5HusLm25spBj0IqapdpO+e
	 NVzJPR4Nbxbug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F80F405E7;
	Tue, 25 Aug 2026 00:11:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FE25396
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4184080C9A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:11:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6q7srP61x3H for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 00:11:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fkdJEJq4
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81F8B80C74
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787616671; x=1819152671;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=804+vtmysRVvTJv3Ol/y9OzmcUN/ISzYOhL6Ab9DaTA=;
 b=fkdJEJq4iEVHS4nSr0fQ3e9NAUc0XsAoPzSTKxdhdaZHRfE/kOfNonpE
 Axu+xuJGIhbLMkApj/x33AmPAs4mArJwMGAdRPGRX5tCHHeHLtor1SGZu
 +6+mPFduX/Wps9e4f2lLkKarFrRo9Sp+fm/kJO+xKXNrKgqmOjy9Esjxa
 vgSNfVSOqubsyjJGgd+UzhO6qfOsbzqztwPP9JYWErfkWdCBiiYXILbUJ
 w1MpyyGHvYkdQCWI2AOkjIAn8BibF9iqCycqpJlNUtM8sgpYiKt6DZFZY
 QAqQTpfbhS7qsVcwzwtXNLyAgKNtqEMJDgPN/1VBdueO6V44K2rQkMtnD A==;
X-CSE-ConnectionGUID: yTEjE1XFTSioPapONngrFQ==
X-CSE-MsgGUID: V4kTvYkbSxOjf2aNxl6M4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91894230"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="91894230"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 17:11:10 -0700
X-CSE-ConnectionGUID: pckOIfn9RL+03FD0sTyMhg==
X-CSE-MsgGUID: ah2ic1Y/RHuWjXmwwB+0/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="270603874"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 17:11:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:11:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 17:11:09 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:11:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slRGGhvIIOZGlScKUNeU9Pftu4im2EWDsPCuX0ZHK1FjLcZQXSxSLSqu4Rx12GEYvMTgE0I2LZdJxrhPDwzqipyo9tZ30cUA17TZ0RFyRbDBcq4z01Dc+Fu61UEAGpoX6cTskMIoXR50S6fyMpBg/S/EumlSKE0sfjhKkTF2m2KsKZAA+J2QGdKwRqfaUNV/PymOdFIeq7nH16Gkr+r7bposjNVoZpbeOqWYRGCZjPfonmLl73LGvrTp3BqljuNrwNm6yf0gBtfyVBdJBM+e0R5ZHq+B7BsPtwt9oJy3OHnGVSD/UNuTt03c6uarIAiuXG2bKUR+CuE5Efi3hURqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1TZJt4u3p40OKGi6Fxaf4/dz6m8j3YqJ698gGznn6M=;
 b=bv+SaBJsnWgsoiAsSN4rodLv+GYit6a1LLPWKivGAmXBzLbCQG4tB7FJnzMWpTp4ior1ajJ4b49pUygNfG+Odq/u/yIshL2jA2zrHLsPmrlfvKLvIAvGV0SLirmEYmMKPEqLa0vy3uOeDa2ebDT+oE7XGlDtDq65/R5RCBnBbAjYrTs8/5T/5Pt+FTYp1JaZbFQBISD9d1DD37OATngwMfGUA9PGpZDL64HZSnJjVlke/IXELsOX1zpqbXau5KJ9RYoEhaSZtiSVitsYVBxuhkEOFsfaCjg9gTKuUYgnw2RWuJpy9iMNjYGW65U0Nlr1BaTGLr3B287QefRDeYq8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MW4PR11MB7055.namprd11.prod.outlook.com (2603:10b6:303:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 00:11:04 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 00:11:04 +0000
Message-ID: <02599f0b-f064-44f4-b7c1-38de2d8b7239@intel.com>
Date: Mon, 24 Aug 2026 17:11:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 09/12] ice: keep Tx timestamp slots tracked until
 completion or timeout
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 <alexander.nowlin@intel.com>, <kevin.bross@intel.com>,
 <ranjit.cavatur@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-9-9d0731eb4858@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-9-9d0731eb4858@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0143.namprd04.prod.outlook.com
 (2603:10b6:303:84::28) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MW4PR11MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2d7ead-4e31-407d-52b0-08df023d5a5f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: f8WkWvifZyH00DmHlwLjU86HRtXJN0ktWVVQWzX2aMQHMsWibRtlgx0iXrulqaYZA3T+kESwT4+5Qe/EmKQ1OJfFnCPQYZK7TVnLT0sBokFnmU2KXXAY/7PnP/wz4YaB48ArSJezIUzLSeL7Hh1OiRd4yUaAriGhEW0QVTqLeqwvD2uNDAhYDaTRCJTI2huksjBwHlYVDNSZV/Z0cUB8fR00bFz+xhRWEJjfnI8G6vvix1UZErqimZqjIs8eZLIbBLwbRwHfWxhyfQgjjIkwauKx7gfx7VzODcPXt0dDuUvKN7Wn+3n1ZLR4xAjuLa0AA3tBQyml6Qvz1wfU8TLuiJUTL53nBGziJuARLbYOR1MJlwrDKkAquXh0SC0olKhwAcNJNneGIpLxEckWQyP8qH+SjB40k6IIulK6c7uAGSCUt+EYEJZqq/VB0FYSYwaIkVIEvb0Go6Kifzwl76WfIXR3aJYfF8UgUVkqfauIRaOhBphiGhMAn+aFzsFd/12N2fFyHAVV6jCu28Lqh0vYYQ2ZKC/2IJYi8L5gd08aC/ZUB2vOUfR/5xjdhy4TFeVUCfKXEhtuoae714LaWhLmjW9Nf9zwBe+uWg13TmWmgJEcLVyQW+AykKLq2DA5s6L73F4rw3vRAv7momNFp6OoPVJiL5j0Pl4j7lcvc17yZM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0MyUUdFSUZiY2J2OTdWWjdoR0RlaTl5SWYxM2U5REYyT1kydjBMVGVZWnV0?=
 =?utf-8?B?RWtwWVhCZ1BCN0hBNjZFUXpMWTlnYkFQU3FRMWNEdDEvL3I2Y3BKcFJQR1J0?=
 =?utf-8?B?MmJHTFVLeHB3U1RaVEoxSHRtQ0lOb1B5T1FhZ3Ywc1VFTnNXUEdNemgrbFFJ?=
 =?utf-8?B?ZGZidUpqcWcza0ZqQUNKS04ySnY3bWQ2dnRoU1BBM1VyKzJNem9GVHFySm8x?=
 =?utf-8?B?ZW1nWWNZNitHNjdaTDNUblZMVzFlazRSNXFIUmhMUTI0clp0WkN1LzhKOXgy?=
 =?utf-8?B?dTJHbEk3VTBkWDU3WmxONHhsQVBjd0pXWVdRL1ZBYkNyQXlJMmJUVVc3VkVL?=
 =?utf-8?B?c0NUdTFySWtLNjJJYytTbS9JSTkxdWRwbEwzQ1NMTm91NVIrR3RjKzBZWm1p?=
 =?utf-8?B?NXUza2g3bkV6SFNGNkRWQ3czVnlFRUlROEt5NWhtcEduOW15R2RSNGhNMTBE?=
 =?utf-8?B?SEJPUFhjMndKT0JDTlBaL1NwaytORmtXYlAwekc3TDczZ3o5UHRGZlJKT0Vq?=
 =?utf-8?B?enhHbFlBdmhsbXZRMWJrTmVBM3ZOVUtoSmtrcE5rMFVaSUUrY3YrTi9rc3U2?=
 =?utf-8?B?RG83Zlg0czlmbmJLWXRzQThneDNQWXI5eGxFdU0rT1hDOGNqTFZsU3FVY1Bt?=
 =?utf-8?B?WmVsaVdHY3p4QzhYRldVTE4rbmFraHNWaEVkNnBDUFZpZVVqTVF2MjMvcUhI?=
 =?utf-8?B?aWJEQ0N2c2xRdXFxSEc2NTVubFdFYTlqU1hBWE8vVmMxVVJpOCtLZkhWYmI0?=
 =?utf-8?B?Y3VxK1dma3A2OUJMU1JMQU4wWEJXZEFYTUFhSmt3TnlSZ3JpOFdzZGU4eUd5?=
 =?utf-8?B?NVNlREtmbmU4UVhjaU1oVzNWMkE5SUpqMGJSQnRsaEJvNW1pN25DL0lHRU1Z?=
 =?utf-8?B?Y1NWdllmSEhVR2x0MmMwdkxJRk02M2RYMWdmUkEzaW1GT0UwQkVPK3FXZXNy?=
 =?utf-8?B?YitsTHpUY0NEU3Y1aEdsQkRqNy8yTThWR1FGc2xaMWc5RzgvMktWaHNoWTVC?=
 =?utf-8?B?SmZCQncxR2NvL3J3VXI1OVYvL0crMnUvejZpbjNKZXBHTEZkbnpINUVTcUdO?=
 =?utf-8?B?bnZtM0pKVWhEYy9vcElpamRpYkl3NlFWckJUNlBDRHNyNWk1dmx4RnVCTHQ1?=
 =?utf-8?B?Q090eitkcFlQdE9GRkd5RmFUT2VCVi9uc3hFcmUybzBzbmVYbmlZa1VlV1Qy?=
 =?utf-8?B?WmZDNWxuR1J3ZytYMnBiM2hmY05ZcVdLVEU4dFd2QmRtSEdQdXQvSjNVdnZs?=
 =?utf-8?B?OGNLT3h1OEdqdnJCUGVaZUZrZndpaTF1VExuVU5sSVVnNnJaN0V2ZStyMG83?=
 =?utf-8?B?L3ZYeDRLOWk5THVhdU40KzAvK2NvVnNyOHR2S2tzQllZQkU3ajNPbHMyZlMv?=
 =?utf-8?B?Skh1ZmNvVHBIMW04VWhrUVowajdBSUs4akt4Y0tXVW5QYWRxVkxVaDZjYnBq?=
 =?utf-8?B?OUZUUVNtREQ5RjBDZG1FZkF2cWZHQnpEZVdGYnRQaFhFbHY3S0NFRDJYbms1?=
 =?utf-8?B?ZXJDMlhZb0dZQXp2eTd5WUhqc1RhSlBxVmoxZ2RaY3lMV1ROUytWYXN2Vjh1?=
 =?utf-8?B?QnZXUlJzMTBWZDEwc0VUb0hITFhBeFU3VlF6NjljL0ZTUEo2RlFqRTE5UHVX?=
 =?utf-8?B?djRnMENZdVdFSEpMa0ZKQ24xbUM5T3pqcnBRUXN3QVZ4S3lEdmVuRHQzaEZ3?=
 =?utf-8?B?WE5LNDJnTVFjVDRpaHp1VGNVOWFsM1lGZ1BtK2dzRmJRSzdseE1sQlgzWUpz?=
 =?utf-8?B?OGhQUHFyZEJJUDNjeml3d3FTWU5ZK2p0WGhZNEpHRlp5YklHRjdCa1Z0aGF2?=
 =?utf-8?B?Y09UamRuRHg1VUpJcnZaeXdwZVByTnhxZEZuL0twSk56TDMzbWdCZ1NIWk1X?=
 =?utf-8?B?K3VDODlCSjFQejAvRWl3UmVoeHZjZ09JcGg1TmpoUU1tNDAvQXFWOStwQUlo?=
 =?utf-8?B?TWRHSWt5M3R5MHc0SkdOZUFKa1lnMGYraGhRVTh4TnowTHB0L2t1Sk1pblJP?=
 =?utf-8?B?bFBpY0ZiU2d5N2ttVkkvNFo1TTRMT0lCMkJVUkUwU245NzdsZ2szbnVVeE9P?=
 =?utf-8?B?NGdycktob0txUmpJSUxyWFl6SlE2Y2J3b0ZzVS9BeldxR0h5UE8vVTlhS3E4?=
 =?utf-8?B?U0pMSWNXVHFXaE9teEUxeGJMZ0N1UUU1elQzRnFLVDNUQis5bG44T2lZQmxI?=
 =?utf-8?B?dklsYmhtTldZcWhJTVpHL2NFZFJIaHRXWFpzSWRiYmF3YnQ5UmhUa1R3YXVH?=
 =?utf-8?B?MzNUdkg5dWlmbWFvMkNGR2lxcENpL3hhQTg3VG40QjBPTEY2R2h0OHk0R0hN?=
 =?utf-8?B?b2ZvNGphalI3OFFCSUljQjBoSFpjdkNhbFA0dWsrcWZSNmxrUlpxUT09?=
X-Exchange-RoutingPolicyChecked: ZBaxH7UgWc/XuOH1rWeKGCbryqoGOc9esXkYplcoC0JXVMuwYeavUTjq4UtjGyQdR08TxmBiGWYKknpjLwsQBJPGDCnX5DiVaEJgF1gudTYEG3bnoj4IRpukm/hmU+dllUKOXsJ7BOqZ9mqVKQhNdOZBZh5O7x8sAffj4WgmovSaJ+S6+Ms0hHuH5tQd5EKwzobtakGdtcAYeiVHXCckMEE5+OEDx39KNrMmGMT4VOOnmB9e89eEspiBW7Jzc1WfjdkYGzOnSznAK9ulpFGmDtAKORKM7/lRy3LCKJCCyfkr2snwBeHSgqvmBN+6RYCzTBA1ltGz7E/R42kzdE9jMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2d7ead-4e31-407d-52b0-08df023d5a5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 00:11:04.3801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wN7LwUesEnrm+NsVoFpOZWCWAB1B+Q64MeHANZiuyLCyl7x2FCNBObUJcfB/4LbGQPeT/ysr9XrsPMfIV699YRNRqzdLK5kSvtgunXJ0cVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7055
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
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index a049dc7a2241..1a9bf8839404 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -581,14 +583,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  			return;
>  	}
>  
> -	/* Drop packets if the link went down */
> -	link_up = ptp_port->link_up;
> -
>  	for_each_set_bit(idx, tx->in_use, tx->len) {
>  		struct skb_shared_hwtstamps shhwtstamps = {};
>  		u8 phy_idx = idx + tx->offset;
>  		u64 raw_tstamp = 0, tstamp;
> -		bool drop_ts = !link_up;
> +		bool drop_ts = false;
>  		struct sk_buff *skb;
>  

Sashiko says:

> This is a pre-existing issue, but does the lockless traversal of
> tx->in_use here race with new timestamp allocations?
> In drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_request_ts(), the in_use
> bit is set before the timestamp start and skb fields are initialized:
>     set_bit(idx, tx->in_use);
>     clear_bit(idx, tx->stale);
>     tx->tstamps[idx].start = jiffies;
>     tx->tstamps[idx].skb = skb_get(skb);
> If this processing loop runs concurrently in an IRQ or worker thread, could
> it see the newly set in_use bit but read a stale start value from a prior
> use of the index?
> If that stale time happens to be older than the 2-second timeout, the loop
> will set drop_ts = true, acquire tx->lock, and clear in_use. Depending on
> whether the new skb pointer is visible yet, couldn't this cause the new Tx
> request to be incorrectly dropped, or its skb to be permanently leaked?

I think this was pointed out by a previous change as well. I'll include
a proper fix for this in the series in v2.

Thanks,
Jake
