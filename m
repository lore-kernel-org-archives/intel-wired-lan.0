Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CB0C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Aug 2026 18:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58D6240572;
	Wed, 19 Aug 2026 18:01:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i86sIhdqZqw1; Wed, 19 Aug 2026 18:01:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787162466;
	bh=+W1VSMfPEgufAMTIQqHa+swaZ1EU9GVIpXYOLDMJTlk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dFVvEabyHapwsuG3zyJ6mk9K1E0dt8299vf3Q6TJbBbHoN1ckGezpYYjOUioq6iNG
	 95Clo1sOGdZfbQmMNqeOVokP6C0rxVMYPVXxII6z2KEUF7YITzrJQDmSd7FcTBE/ZE
	 PoJBaoULDQcGVNyDFDhBU6Z0DUPM3TqI/9Q7N6A1fvzm33mUNEXxRPo71F2/aPrwYi
	 FJIBW4UOQaoGnIdP/gaPega7/5jU1lV8IdhI7MxRo5sdDf6CHe0Ml6vtdqBBKZmv91
	 Iv9rsikQYLdEoux+1Z9hmKQfXYeq5ADRMKy1d3npVQrO8qeNeqJo2T5rnR1P8qenL5
	 vW6OZMbBTf9mQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 967ED40338;
	Wed, 19 Aug 2026 18:01:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29A0A265
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 18:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FA9280B22
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 18:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v-1TsrmyUVtH for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Aug 2026 18:01:04 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fUn8LbQ+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23F3680B36
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787162464; x=1818698464;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lYKPyHY7b+SvpXjO5kEfFxVXn9Bc1x3TyKl3sEyrj0k=;
 b=fUn8LbQ+iN+b/ja857oXywHFPohO16llRekf7HIjgLjr4FUvgakCC+KY
 mAM/avWHWbXgBjeiBbp1tRWAHTTsWjpjhZQUh2h50lLuAruYSsIOvsNku
 87EwD/ODTlyt+NrxbePMBEqr526E4/7jnjnk5Bnk6KpG72Oqmb5QiBzHf
 O3GgZPepPUNhDrlFyAslEU1TEFreqMqS5XeUyd8Ulicer2mFy93bWZYGq
 SzFSRaNVdedjj5iggBb3zXbCq07yzFpQKUiEd1ZDmj893PVkTHXMRr1c+
 pO0x1/8W5WgJTLJLmSs6rq+9xIfWhu5THsfo9B6nLJatVx9TIcrxpQ2oC A==;
X-CSE-ConnectionGUID: E3KnHv3MQpCqwZwK1plA6g==
X-CSE-MsgGUID: uozycykgQyyL7hC1butfxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87707972"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87707972"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 11:01:02 -0700
X-CSE-ConnectionGUID: YdRAW3MGQjyGSuInELMw3w==
X-CSE-MsgGUID: JSowq45NQjyCZds+E4N/8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="265167126"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 11:01:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 11:01:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 11:01:00 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 11:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyA9LCUGIF2ZO58GXJTJbE2X8TGHMyND0UDc2HV3BEqnjxGMaue3U/0Za1DFQxIvaTFbYoSbS+L1UBz8FD+vNkcKLnjTBtpqNDCR5VsN1HYSRvfkqjaOXGdaNvmRfT8k6hhs9llOyWBZnsoejWHwr+fIqUaaujP1W2WAIgJYr2EZS2VzlapSWBuUxdMb3NPmrYHqKkNhPQIbJufYa8aCKFlDRe8Rscm+POgeS6JmoDBRIwpnKdD8/wcLaiB0BwgNyDwizxvcmuxnj4vIWiMIzQtHEomhigKH8/ip55r0VK4zqIf12MqpwaaLmIZnOx1GoXaasje3l1+Najm0CMPb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W1VSMfPEgufAMTIQqHa+swaZ1EU9GVIpXYOLDMJTlk=;
 b=UKpm3nEV76dN4GwO+4jQ4EGbop7Ug85bFW2dq/ALvskQXYokSZ0mj/FytfpCGm0iUg5MU54xAoFrzSXcLjGjvzH2rAaY3Vyb6yTT5XC/+MczNaI77Rdq2879ClVpDjPtuWZjWeYaA/1un8E9+Tk4XXxaiw/iQeyN9PK70WWdQdLI4+Bcof2IPDX7BsmLW1H+UmpY8atQjhfs9YeUUCb9Zjcpe2erMPOqqtyiTtpGBS6pOc+Cd+HEwDDZ5K3+bnT9LRR2TiKoO0ADxX+HOjOwfqhQoo5cNR6tS7R+sDfsoTxgs/MkOKmSmSEYHT6EauV4kBLDjpKxjxVQsAhYnUH9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MN0PR11MB5986.namprd11.prod.outlook.com (2603:10b6:208:371::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 18:00:56 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 18:00:56 +0000
Message-ID: <de19e575-9ede-43bd-bd4e-00b8f4dd7afe@intel.com>
Date: Wed, 19 Aug 2026 11:00:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: allow reading the last byte of the NVM and
 Shadow RAM regions
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Petr Oros
 <poros@redhat.com>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Kees Cook <kees@kernel.org>, Robert Malz
 <robert.malz@canonical.com>, Ratheesh Kannoth <rkannoth@marvell.com>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
 <linux-kernel@vger.kernel.org>
References: <20260819082458.665947-1-poros@redhat.com>
 <98034c58-cb45-4367-a074-bc654af1ce77@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <98034c58-cb45-4367-a074-bc654af1ce77@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:303:b7::34) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MN0PR11MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: 71286229-bdb4-4678-2edc-08defe1bd114
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|10067099003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: KhJzDSWIJ92qa4NjVB+EBbEw1CSr2F4zDMiZMwbr0a11DsQHe2o/aKGCO66p21M+Vp8TP4I/YFCDkPFkF++AFKAa6ziy2vxwULNjMJGAtR5uY50HO8gVfHMtX6KzAzZR1TJntVUP4kj90Kx6UQY035sRpluMbWTvUeJNTp9LmhsUNUa05FucYb71nN58XkQ+Mq1AWUYlRHbHHuoLlyRIO0sW0ydXdAfdgBEfKtMwH4EFef3DJ7saqAB5s67U2Z9qmGTuKC3ie2AiLaLaPWkmG8gbJmJXEbl5S6ZGRiDttrLJmwdAUrX2XE6/9+6MdfrnjQ+YkF+H6avSGQbFZOGPXJJSsk8XH0YzcEAMc9FIPhmg2GM2ArLAPIIKPvZHmCCO8t44/dUCDfEyliQxQkX4RCN/FE2TVeS3i3PIx32sjfxTXUVy5Hl9r1ZXw4GKuKFZhq3CmjfgVvCZhQexBnviMbjeUC94MTSFGzAgwwmGTvna8CBY3wSu2+pBwPNBVot+5Z3rUQtXdkkTiPKYnOAkbheF/vWyTXBpxtrBxpYG44nlpnLZEWWc9Gs/bCvi5xw+m8sgSWGzvHsMY38bpmzXlZ+/7i+euDZ9QYwTtEZdAePzhtmp1ujh76t1zf1RDWSE2BWB5BGe1qsBbtgWOF5kJsKrpfqaO5Q9rStlC9IgZgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlRzVkptcDEwejBlTUtWajRxd2VrZ3NqRTVhY3JaNXdUa2xQWWVqWEhrSm9p?=
 =?utf-8?B?NkF3S3BybWt6WXp0ZGU3TGJXcUVYUVlaTDJhZWdZVVM2b2pmd3FObFpZUXcr?=
 =?utf-8?B?dmVJODk1bnFNZTM5YVI2aTgxS2RkVkFzTEl6c2NSL1hhWjdUMFdTVUJFNnQ2?=
 =?utf-8?B?SlRUZDgvT1paNmZYSFBuL3ZEcElYRktLN0RxODFZek50NmxselB3SE82a1hy?=
 =?utf-8?B?NTN0RHU1VjJMSDg3OGpNUVdrSUZkNnloaDEyTHU0WXFwR0NxdExtZ2pZUlND?=
 =?utf-8?B?UjdJRlpJMUp3cnJXa2hQT01MNnhNOXBCUHZub1BPNlR3WGNjK3Y3THBDYmwz?=
 =?utf-8?B?Q0dlZXErK21ZQ1lRdUV4K3ZiTmI1NU5EM2puOGFTWEVuMFVYeTFqaHNtc2xK?=
 =?utf-8?B?U2ViVGp2dE1kRldHZStUT0hvaVhHV2t4YjljZjhjRi9iek5zbjZOVXNJUitV?=
 =?utf-8?B?TVJTVmM4LzIrZDRCdlBwdnhVVjZXc1BmNEZrbG9Wd1F1L3dBVVFrazlZNlRi?=
 =?utf-8?B?a0h1WlNsRnhHb0xza01tRDFORFJvdjNuL0lZM1FoNVJjeW5kSXpMZHdJOG51?=
 =?utf-8?B?MU5ZSGJ0a1J2MkF2cndCZGhNTGlUWk9UT2J0aW4wTEplVytTaUw4S3ptb2ZM?=
 =?utf-8?B?anpZMGI5RncvWFNqWmZDOHBqZkZsdzVEamxaZmprNmZPOHZkYmJZOEVyMXpn?=
 =?utf-8?B?OEhJaWxIUlVWa1VETGR6TTdqNVlUVHJpZjdwdDhuWXh4NmJkOG5LT0lzNmI5?=
 =?utf-8?B?c2FEemhxdkViVkczYlN3VUt4K2pHTnZCa1BQbUdFUmVYc2FpVU9VWGloM3Vj?=
 =?utf-8?B?eWJPUTVXOXdrVGxoRXE1cE5lSDR3ZDZzU0cvNU1OOHlJTUlkak9EMWtHQWpm?=
 =?utf-8?B?dEdyT3ZvMG9tUjNDMjljQVI2Ky9jNUxnendIeHFmbWQzcDYzRHNQRExwZGV5?=
 =?utf-8?B?QVU3MWgxdUhnaFBMc0JDV2dyeUJzS3oxc0RnSDFXbTdMQ2p3TnBEandDdk9X?=
 =?utf-8?B?NVFFSndxOHZCUWJxd2tsUVEzNklEZmw1VGZ0ZFJvZ2wzTGV3SklUbHZaM2xW?=
 =?utf-8?B?dDAxVzRRWmh0OTAzZU93NGZyY00xQ2hPald6TmdMR0UvK1haMm1SUGFYMU0v?=
 =?utf-8?B?QXpvMkRybWFVWE1udTBSbFF1NWRjQjJxU2FlYVJ2aHZtYVB2a2Zvem1jWC9k?=
 =?utf-8?B?V3ZNY3c3dzNLc1daSFoxRnRpQ2xlRDBzQW56c2M4aU5YQUFYeUd0NlRjMGFw?=
 =?utf-8?B?eXptZkFDYVpUQW4rUENwVG9GMXpLcEFzS0srK081Vmgramgxd0dVWUhtOUhz?=
 =?utf-8?B?eC9ZcWhoRkZ5UlF6RGlMTHVvM2JxQVB3ak1jR0Jua3RudkoxbGhjcXd0eno0?=
 =?utf-8?B?SDl0MzdBSDI5aHRzTkp0N3VRL0NiS2tVd1pONm5sR2FSSU5jTVJDckk3dHlE?=
 =?utf-8?B?bTBUUVRpaTJZbW1qTzUrS1lZVXNIT3BXVFIwRWNETWtlU1cwR2lLSGRwRExN?=
 =?utf-8?B?UDdxUWNxT3F2ektzaTZaWFgrMmJrMGNBbU0xVGxydklKT0JVc1FtaXNwcmYw?=
 =?utf-8?B?L2FUa2ZaNzhHUGlVKzk0Um4vbXNBNU9WbnkxTUcyZWRIdWFydm96Wk9wR0Ja?=
 =?utf-8?B?Q3k3WEFVN2VHc1Q5Z2Nadkl3OWRGUTQxekM2ZU1nb1NwMDdKczlzeTNBWFhL?=
 =?utf-8?B?QVRTd25QQ28zdGhFT1FBcDNyaHBjSmtWNmhQQmpKSGFsclZKdGVrS1NTZWN1?=
 =?utf-8?B?d2VTa2JZR29aWXlzTE45eU1HTUtBWU5KSmNHb3FzTHEvMmZsaDV6QnhocDI0?=
 =?utf-8?B?M205K2NpSlhaejR0K29qRklXSE5FcEtmbmdhQkxrOGk0QnBKWTZIRDlSTE1l?=
 =?utf-8?B?c2tCQVVZUVJVeFBMU2FxbVovVlJKNHJTY2ROUzBiNlpGb1FINW9FMnRBcXVx?=
 =?utf-8?B?NXZ1akN1akl3N3gzK1FXUlNwVHNUcGJ4SFVDMm40OGRJRW1DcGxxaVhreXRn?=
 =?utf-8?B?TGsxOUxlMWhRTGpBYmgvTUFMRzlhMGNlVnZYVk81Und3bkVjd0VZc3kyV2Nm?=
 =?utf-8?B?ak5WMTdUOWR2NXAwemlDNUdrRmc5bGFtV3FoSmNYVHo3dGRNWnFVb29GMXRM?=
 =?utf-8?B?TUZNbEZtV1RmYnV1YTdzcXlwclFLT2VPbG81UzBYVHd0NDBtVU5LN0dYU0xS?=
 =?utf-8?B?bWNUMnZSNlJTbUFxZUV1ZzkwR1QxL094alBDN1V3cllGblNGekx5eklCL2FL?=
 =?utf-8?B?UUhONUJOeFFzcmJBTGRhREloR1VUZUkzazZYRHhuOUN6R0YrbXZHZWpwR0p1?=
 =?utf-8?B?NEFIcWVjTDZzbnZ6TWViV2lPZUFHLzVzRDhnNHJqQVphS0dtbG1DQUxjc1JJ?=
 =?utf-8?Q?Eww3nOg57QzFLDxg=3D?=
X-Exchange-RoutingPolicyChecked: sghKtisfjE82Ruz4ElsEL0EK/SgRquVdR+tUoSuz68Xjc+BfHXCNSIcLX2ispLS/Nxh9IF0XyIvYLM7ywlqKZQen5tYmguaQ50Dlqp4x7IocAZTp1j/A4q3q4efIby6PIVsqcqsrzqDYiSCaoE6NrbEj1CZyCmsZeJD6fId5bu050EfdXUTb8ytKGpCHYyq6HKBB8ZHGH9NkDnLI+zfIrwIJCVVi3AcO491TIgH/TiYsrrMRzNsTPTtJrnXmYwj/oyXCOZA54DmBzIUW2EfJbjB7DFQBBmZTNUatGaoSp6X9uL+UtHnTxNQb8SKC/C2dnU8s0i0cHQ5yIw0r5X0u+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71286229-bdb4-4678-2edc-08defe1bd114
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 18:00:56.0890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1frk+ioSWDclLrdjfGe8hOPEiglQk9ykzTkyHsnIu6SVEp31dki4ZW1z0pViYhpKbKFOl+j0Ua2W5oSpILZPtGcLamLu9SgBq1p/XSFg9Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5986
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

On 8/19/2026 3:54 AM, Przemek Kitszel wrote:
> On 8/19/26 10:24, Petr Oros wrote:
>> ice_devlink_nvm_read() rejects a read whose end lands exactly on the
>> region size, so feeding back the size devlink itself reports fails:
>>
>>    devlink region show pci/0000:04:00.0/nvm-flash
>>    pci/0000:04:00.0/nvm-flash: size 10485760 snapshot [] max 1
>>
>>    devlink region read pci/0000:04:00.0/nvm-flash address 0 length
>> 10485760
>>    Error: ice: Cannot read beyond the region size.
>>
>> shadow-ram behaves the same. The regions are created with those sizes, so
>> a read ending on the size is the whole region and has to be allowed.
>> ice_read_flat_nvm() uses > for its own Shadow RAM check, and so does
>> ixgbe, which grew its region support from this code.
>>
>> Fixes: 3af4b40b0f2f ("ice: implement direct read for NVM and Shadow
>> RAM regions")
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/
>> drivers/net/ethernet/intel/ice/devlink/devlink.c
>> index 8c2b63eef82bd5..a52b6044288975 100644
>> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>> @@ -1953,7 +1953,7 @@ static int ice_devlink_nvm_read(struct devlink
>> *devlink,
>>           return -EOPNOTSUPP;
>>       }
>>   -    if (offset + size >= nvm_size) {
>> +    if (offset + size > nvm_size) {
>>           NL_SET_ERR_MSG_MOD(extack, "Cannot read beyond the region
>> size");
>>           return -ERANGE;
>>       }
> 
> Thank you,
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Oops! Thanks for fixing my off-by-one error.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake
