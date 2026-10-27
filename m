Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73795606A31B
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=owPp372I;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WjLFXUrz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 511DC60719;
	Tue, 27 Oct 2026 13:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q20hSa6oR8Dr; Tue, 27 Oct 2026 13:14:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9DD1360725
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793106893;
	b=qormckYs+3eDgDv1YG9foG7szjBHDP5P/0fUhoqLQN44pZW8zJvnCjBkjuA8v0u2xdBj
	 Co+SiyXieLbsKwg7MJdn0ncTj7XWOpAKiBz1iBQypqXOkzExbInEup9D5NKkHAx+EFM1d
	 egd/GA5Oew27CanoNkmvUm5SnKp8aGsxnbPPVcCRNOIe0f9oEzF+eX9QA9spij8ofZfqy
	 kYnA1jzpwTm0m6M/QPzRVNrbTfQZpN5uk3u7F7v2hOjKUv+xjKwtwD6DmVGVs9Sm5L+Dm
	 IrgKxxfZos/Zp+3ToCH9wa96slvn3kH4HNgGP+qGRyqVM/DLRqmvK5EQXjRi7/SJjrQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793106893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/7OMuuSjcTLM4kS1VbgkZSpDElNoTTLKJM+Ikb15YxE=;
	b=VJk/eoaUDwZOMocRaFQ8G+bgdc51RCdhPJ9FBVwzjXJLtkk0gWR5Th6dWixCRqcnRLxP
	 6JsppuNSv8DrFPCfG+XbS+OC16BLolP0fAKXUUvSf1ZreOC3JKWNI3AYUtUbvMi4lRq1u
	 hcHrVGf09b0hFatkHPf7M4Q0Y2E7HJoPUJ1dIqqUat6d0txd52Ow6vdJJf7YbhOlR3upw
	 e1uOxcNz53FUBOn4dzuMgVrpKfA2ZeFT2LmKEC3rFL/nw1qpUsoyvkxD5S0Mz/EG/ELDK
	 qS3nrVB8UxvmLv5dT+HxP6Qmh8paXzGNcGfevkEzvCSh3vt+IzMuo5hfRkch9dW2SCQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793106893;
	bh=/7OMuuSjcTLM4kS1VbgkZSpDElNoTTLKJM+Ikb15YxE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=owPp372IfdeVi5ewnwYX94ETQitaTV1f3tNLuWSp99CGmM6gEt8WS/LM+wiCEMDuv
	 ema5UToesAmApyTBnqn3hNbo5aNwLVNQ2k0VaTuEHMoNLdr0DJCtrhM6UDny4fymGy
	 n4VJBRW9gOrdMbmf1JIJlviB2kSvUbAWD0tQiOhOVjG3BT2GsvUxbwJ0alUdJlIIW/
	 uV3q67oNzQna7IiUK7/XRlu7SnGWc83Y39Q6WfWpMb+O93LLD3LltwchHJU/BJ1Rbk
	 1k9eOEVPIAyoA+C5gQJal9mJRU7DPuXC4RJcVvBs24fLwLp0GgSW6oUswQpWZyVOTH
	 f1MgPna1UXeTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DD1360725;
	Tue, 27 Oct 2026 13:14:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6242A3D9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 13:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5074F80D59
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 13:14:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2OFDhGibOGEE for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 13:14:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6E80880965
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793106890;
 b=AWDSxfr4tGx+Vrs0pSgN96GogAgvKVCa2AP85gCSrjzMioMnj6z/CvIQsovoYJLuwSmR
 sDLoH7B91S4uJXShbcjhKlbesjYJXyBNB/kJbKYHYQD+Ty9/57FuYbenWNyQNJewuF4u2
 NrC5q8JV3KefahFmBBmMULpHS5m0OxsLc7UYg+mj62EWx2YUYyUEiqC0oext/er/ZIqM4
 ZdQQfKfFiKsE0Ubw6TB92caapl0CJ0WNBI4Zfsf/wRYSzJFmYkgf5wRt+qfH1lo9nKP9v
 yOYH8oPbp7+/4vqA+QL9ECxb4upVjO8XrSvZKOuIRHDgp9z9ZduBZgkNOH31fbzSS9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793106890;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=/7OMuuSjcTLM4kS1VbgkZSpDElNoTTLKJM+Ikb15YxE=;
 b=p7Z8NdPmIlLLT9i7386shW5i5uzQhWnG8GMND03t6k7/dD6k4wbyV8W8bAmwxuB1gIky
 uKCozf6587r+XItcHLj8nBcjaufnHveE7aciY8hjDTtf8l8hXwYd29Xd0jlGf3+qjw4de
 EDKMbPZ48S+K1yxvi2gQiUbOy8+c2juG0pkT3gvjZyl+jvA7m17k3YR2EUZkqvlPyZ6p0
 R33ApL4fyFsUPDasvPdWfh+MjfWZ8VKaCDzVl7Ll7VVqeO4lypques+7o/rsIKAWMx5vJ
 4jcGyfiqKhNSgu4iV0oH8z+zCfYAZSKvyiOuRc8QeJaf6JLXzBzbgbuq+Y1/CatixhQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WjLFXUrz; 
 arc=fail smtp.remote-ip=198.175.65.20
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WjLFXUrz
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E80880965
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793106891; x=1824642891;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=eyKo68wmlYCpARDyHFM2mh36beM365PCIG9GaXT7hlM=;
 b=WjLFXUrzQtgSMm9aJLO/Qj/eRToFr1stCK5xvg4cU0nAWRSrx4+zAIfL
 BhLfBeEvJiqIWj4EWdyb9MVKK/Rc6NySrvtcpdg03sU6QClqBmymJiN5k
 95Hrc33e0WMXupBATy2ACwyAJERpMw9TAdUue4J9vGb2N8CPwTPeqSMjp
 6ulhr+GYVALnf6wdnmT+Eltr+MEJxebA+ffMy5V8nSJN3b6j027UVMvgD
 mAGbKJsJmZ6M0t3WppHtqzG7H36fP0woHmq1pqiZ47hC+2m8fbMkClEiS
 IH6s/L3QluouG55B/sHbt1yeQb4picE5OYHL/cii6Yw/y3e9TGuSRBqRf w==;
X-CSE-ConnectionGUID: pscsFE8kQgS94773a8s2GA==
X-CSE-MsgGUID: 3y9kZ/EUQv63TL+8enhULA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1826814"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1826814"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 06:14:49 -0700
X-CSE-ConnectionGUID: xeMidwFFSuOco9W5Me2YkA==
X-CSE-MsgGUID: MzV4OpJBSQCE8vEY9AShIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4878354"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 06:14:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 06:14:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 06:14:47 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 06:14:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsCwZrscMtID0I0shxqjWFbQ9ASSwRh8GcdtOy29TjmWqjWe4oHJWBF3Wqp3sgR0Vm7kypCn9Bzu2hQglO/+23qqJFxYhJbAAa1d5JMoA+KsFVgRgANYKUMi745fSPcWtMWtRaTZwKAN6jDYh6Q42t5wKV83qejNKf7+DBARdLrhrzc4n+5wr3DV/IC3xXDqjdIeUrKqm/aYAC5LZm7MwrSMBGpJMb1+QkhWSfbYIEi6HpOQkOc7aoBUmn+e73SZjiYdAUCiqh0/jbcc6qiAtzoo9mlVDwQWE0sQf573DlwsCj/PF8IHmlHXJwjikR9+2VhAotRqClbwChOLKKlWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak/5ajdyvZLGKWMncK4ytvOvkCIJbUMcpapm1vZJsSU=;
 b=orJ/6J7ll/tQeklAqK+LiLwZTzkJSOBll+CXBodunBBJPuohMw15Eh9ZZ1iqp86kIdzDumGAVjBBChKi1kn1O081kojjAK4xhLaMot0JgqKIYQLPCCyZIEAsPAqsVaduJ0jEy8koprY+S8CqSrSDzC00We426aZ3iwX6sxl0Vkow7GRlHakRA6Vw1i9Ow8bhSFKrAu8eaUkLdogErDOY8Gde9RUtQGngE2IkB3C0x937O8hsek3Tj9NnDFBH+wbXhjMDQFkpKLjQiSv6wX3Uc0K56x/TosXg6zGuZXLKWCevpHXFOC4UV0/YX6//98E32BZkR/HPP6M5i6BxBQ+R2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SA3PR11MB9463.namprd11.prod.outlook.com
 (2603:10b6:806:45e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:14:45 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:14:45 +0000
Date: Tue, 27 Oct 2026 14:14:40 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: Eric Dumazet <edumazet@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
 <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
Message-ID: <auCjwM+9Y0v+kg6v@boxer>
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
 <20261027121442.907414-3-magnus.karlsson@intel.com>
 <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
 <CAJ8uoz2J5EbN++dts69BVJoAW8+T3bEtgHC-t3EtVtURQH-QWg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ8uoz2J5EbN++dts69BVJoAW8+T3bEtgHC-t3EtVtURQH-QWg@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:10:234::22) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SA3PR11MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: 31997e93-ff94-4a2b-0e25-08df342c453a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261026140227099003|4143699003|11063799006|56012099006|261026121527099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|261009223027099003|261022115727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tmXci7A0HCMMLFqOLoZRjZbpuW9n0Bwr/8BEYB1rNVNylcZqxqdG8lQOMDD3I6IUM6a0XRKvFMDF2Nb8OIozKMv46cfc6rA2/ypa2O7KjAvVywPPD3brcunOTRr1JJiWm+iw5FLxw07D+BpYMX9uJBvu7ZDLUMmBwUDU2TjWl7xp8O8L8PrBHuFRQ68wHZf7HrX5a5JGnPIG8bphOxQYvg+lvSFAq3D0ejXJl/A3ZLQih7RidPIEcCv38QQCKmYBZ1KO1kGtkroMp+Sp0WlZgVWwt6MLGuyiRm/Kmrs8o/5Wcc58o/hyxF5IkjzSl8CRy8C78Z1vTTJ5jGIXdpqg6fcWqC57xzEsvjgyqyNBjeCYRcy2tr2o3dRadg/8SPoE/avdN8Og3AcW6C0HG15KmZ8U5Pl1/NXSXmwtHKCodH/HgYxXC75RkrehEOfufOFMKIiUQXNVncsiI6o3ecdeT+M4SkGhG+4P+PJwffRLlfVRzOseegRPWXSReDk1p9WlOW5wHyWZKgZKFQvQ6fffjyqOih8JZaU596Rmr/xTF0cWUfsW2sdxxnraL19IwR6Fc3E1DAsNB3BMkF9bAC+xIKRbH4oCLtk2uaJP/7hplUevVqNBHqUxWD7vXp9e32RmyOcJbDUYDjKCzs1VsY7bJrlG72DU2lPp8s3M5QJiTq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261026140227099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(261009223027099003)(261022115727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NeA9X6I+kblnXUq3qOFhc/lgon8GF7a/+w8sYKt1iQCaWWayNZ5zH8SAAZ?=
 =?iso-8859-1?Q?tNZKQi8TzZg0G4kmEyScSNaTsCH/FphfEwPhEoHSZ9wvg4rMnd6BXMpY52?=
 =?iso-8859-1?Q?dE1clalKUXYBRy4q2vZ38H375uV1DgjXJB/jM5M89vo9doMF9QLxSSKJYs?=
 =?iso-8859-1?Q?kWe5q4cqKNZZ0xYV9u+w4ze+tzH6kFUjb5qLvRYInx3Zw5svDvXiMqOx5G?=
 =?iso-8859-1?Q?Ejyhly5UYpeWz+VwA+umLxn5Q9R6stvq5nAiuUXjgiYBzYwus0GDfvrFTl?=
 =?iso-8859-1?Q?3pFxECEonkCFjwy4iZzjIiY1f5fhf0cV0fMV/bHBt829buJtaKy73bQqCM?=
 =?iso-8859-1?Q?SEwdc5Q826LU4js3+gjwwsTEXefospkKBAbPATK4wajKy1EZnS9zGRmCat?=
 =?iso-8859-1?Q?Dxg1UH3tii2WYqeiubn93/EQN9wR7sV3YBXdbrx4WOyBibVMKX70bw0w3D?=
 =?iso-8859-1?Q?ZO+1X7QloUrhv4PZ7Rga45Shbi5+x7TP96YjfguNJQ0U3MbA0HqcD3C5/Q?=
 =?iso-8859-1?Q?yeZCDYh0gPVDyO2gcQUQprBLLB1+4wakaDM2Ihz+NKmYkzV4d3hiqKRc64?=
 =?iso-8859-1?Q?Vop3YxcrufbqzjrvPj3XHucclMjUl32Wwmp58Wec43OMaAkPMI1BXtbORt?=
 =?iso-8859-1?Q?zEiDw4EZvd9yPQU1FsuX0TWeU4PPl4veY6IXzKELOeKXe3r4L0SESIZCYj?=
 =?iso-8859-1?Q?8gOG8ix1rtgz9cGq77Sqz2GRLzSXzBsB5/eMdpZWhLYpWjsCCgNQs3tMCj?=
 =?iso-8859-1?Q?XJr0HGrvnyRFDvtzFQ3urBG/i+tx2Ys2I52BoXabr0v7ZrlopPH583EgzJ?=
 =?iso-8859-1?Q?aO2IGVG9x6n/nUW6oBThObRFq9ZXedd8fpwtwaUyy/deFgtbw61ibRSJZR?=
 =?iso-8859-1?Q?KHuAZ8geiDTz5pcPYcHAbm1Mf048PsRstxOHbgRsnlZf0fYwQpY6rsoueo?=
 =?iso-8859-1?Q?s/oofmTsjAkgBbrhw+fFietKNPww3EnA5nYP672BYNmN/l0QAMcyHQGNA1?=
 =?iso-8859-1?Q?Bt/mUtdB2fMsZVBULc9t4Tgtjb+FM/gMhF1Q6JhJaPyycVUgJec6JBeCvr?=
 =?iso-8859-1?Q?ZdpUZJYMqvXEaHOQl0MBbJj91qbbhgPhSt+hkZCPcQjdYXZGEAO5h8Rhhj?=
 =?iso-8859-1?Q?DXUpn1YmZbqoQNTFbxxbu7fzNUAvlZWTgUwC5dDQ/OfWtALuq8GCn46AcN?=
 =?iso-8859-1?Q?8tD1ltULkTR3Nu6GgMFBlsTPFfta+vFI0V7A+BCdyBzxTTvPHLZ7lLLNZe?=
 =?iso-8859-1?Q?BRmxQkD4OaJxL9SQlUeW8KO1+GDTdNb2RPnXCfgntDuzE8yksbVT91V91A?=
 =?iso-8859-1?Q?dtHKgABsLvHecCHgLVQmXhRSsh+8oXFIDzNeW6Zn+CEDL6fdrBLq59V35H?=
 =?iso-8859-1?Q?lCfzU/8kcu5iWqqiTzuQUUgvBWioKEEto1dd8tWb3m2ek1WHzOpRCYYSnf?=
 =?iso-8859-1?Q?4EautSpbvruE+vGbrQm7ws/foAe5JL2e1f2Y+aYj3enPaWB30gzCrOhmPY?=
 =?iso-8859-1?Q?/BTNbiOEJrktIYH65yTXqQiWbYNOdRidUFokFJ/GBg0Krkw5XU8rQ17Obq?=
 =?iso-8859-1?Q?B6XQa5+6fBjlQ7XVjiERFP73EGn2584BcxTfJJeeZIkvVidkac6NmwMK5d?=
 =?iso-8859-1?Q?mpVLlLBlTmLrRlxfngtMc1Uao0THRgpwIw/X9FFAL8OA8GQyL95u+qwEWP?=
 =?iso-8859-1?Q?g2oQcc9S4U6cjdCQdUVwDNJHD6xh+9XV+DSFJDGTakpMxORnuYm2GnkxSJ?=
 =?iso-8859-1?Q?KeDS69mgwTsj5+tmLO33QkSwV0B3N/scOp3r3ZFU1KcjReM7tiUuLQeQBE?=
 =?iso-8859-1?Q?z/AZFItRDsAlLvjlYZMjlktZEczqJgk=3D?=
X-Exchange-RoutingPolicyChecked: YqK8MoEMbT8szk4qEgActWYaRLpL7ym6bGgJJMh61NnvOUj33/OFmHLIEFddW/Yj2j11Tj1M4hDvH7YBGJvOdeTTFC9Ijzs+yoFCPN+3iouer7LhC22ME4UzLlX2jwJS+Vjwzqfw21zSfohkvsBg7YlNdP0GHZj49E2qiN8DCF+9t+diw4rBQK2wvDyQuobQ6KcFRG6rvdyYv7qUh//tW7Qjqz8xwEfC8cfw09rBYdGr5K9+gNMDYu0fNTzHHuH1Y/8M+L9TSOLm8mXlKQHZf6x1RIqmDYB7ZH/ah2DQcX4hGBCYTn/+nZyA1LANsUyLYqUase/jtw3qG3WQIxrm3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 31997e93-ff94-4a2b-0e25-08df342c453a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:14:45.5190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+BZb3pc0+fyFcApRMy4UkNAZZWX9sXP0Qm5r56J98JjDvq3Tq+x9ed9BhjuJ2Q1iJWcF3rQJJYnXDl/QnxFhedEmV3VB9ChjyzlJJSssDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9463
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 02:56:07PM +0200, Magnus Karlsson wrote:
> On Tue, 27 Oct 2026 at 14:43, Eric Dumazet <edumazet@kernel.org> wrote:
> >
> > Le mar. 27 oct. 2026 à 13:15, Magnus Karlsson
> > <magnus.karlsson@intel.com> a écrit :
> > >
> > > That USO works for 64-bit systems is just pure luck. Currently, the
> > > computation of the UDP segmentation header is performed using sizeof()
> > > a pointer instead of the sizeof() the UDP header that the pointer
> > > points to. Since the UDP header happens to be 8 bytes long and a
> > > pointer is 8 bytes long on a 64-bit system, this works on all those
> > > systems. But no such luck for anyone using a 32-bit system as 8 bytes
> > > != 4 bytes. So fix this by using sizeof() the UDP header that the
> > > pointer points to instead.
> > >
> > > This was found by an LLM while implementing something else that used USO.
> > >
> > > Fixes: c91a4f9feb67a199c2 ("add support for UDP Segmentation Offload")
> >
> > Missing prefix? This was really:
> >
> > Fixes: c91a4f9feb67 ("iavf: add support for UDP Segmentation Offload")
> 
> You are correct on both accounts/patches. Do not know why I missed this, sorry.
> 
> Do you want a v2 with this added?

Current policy is that you need to wait 24h with posting next revisions.
Eric marked it as 'changes requested' so yes, you need a v2.

You can add my review tag as well, thanks for auditing intel drivers
against this bug.

MF

> 
> > Other than this,
> > Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> >
> > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > > index 8982cf75466f..2c290d7788d2 100644
> > > --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > > +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > > @@ -1807,7 +1807,7 @@ static int iavf_tso(struct iavf_tx_buffer *first, u8 *hdr_len,
> > >                 csum_replace_by_diff(&l4.udp->check,
> > >                                      (__force __wsum)htonl(paylen));
> > >                 /* compute length of UDP segmentation header */
> > > -               *hdr_len = (u8)sizeof(l4.udp) + l4_offset;
> > > +               *hdr_len = sizeof(*l4.udp) + l4_offset;
> > >         } else {
> > >                 csum_replace_by_diff(&l4.tcp->check,
> > >                                      (__force __wsum)htonl(paylen));
> > > --
> > > 2.38.1
> > >
