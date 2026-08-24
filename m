Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC71C5DF81
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 23:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCA7C60674;
	Mon, 24 Aug 2026 23:37:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YwMDdruaBTRf; Mon, 24 Aug 2026 23:37:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787614622;
	bh=1Xb8GluMSe5FMwWusvdyRrZO522r2Z87QVofjd6bSos=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cLijINWTc+eeBc/6ZvqWOy5rgNFWnY05/u3GxJtuIc/Lz/IUWYa7J+bZqENBinBaq
	 MSxKu7jXn42hwMec2UWcdDVzHcoqpZVY5NoU+ihh+hHtsGObjQsJaV53ROyeutU8he
	 /gZRCrG5waW8GCzH8IgCibbz2RqrJNm5FUnZ08GlHl1sQvoy4nRaz9kue08BpdB/8o
	 uXKHl4gjDkenTH+A/I/Eg04/Nxwvf7ML9hU5NZS3wb9JYFPxdiAzWgk3Y0VLXaQnpN
	 Yxl3RWDt8DEGb8BRwJL93IzoQ4hb4fO0bEzsrXEFIdnwR/eu4XoIFqH3RNlejx1b7I
	 /pE8/xilrY5gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEDC360667;
	Mon, 24 Aug 2026 23:37:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93334279
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8862580D10
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:37:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id POruZwii1hZC for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 23:36:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=P58UJMYD
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3ACA80C25
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 23:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787614620; x=1819150620;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Emo9IUQu7AMP9r9dAp6Ny4aLQUPsDt8gPr9++LKXSqU=;
 b=P58UJMYDkzl6RnTIcUhrwtxhnyEBpBh9MOe/oCJ0qpAga2ZHygIjhfdr
 cMMvttHLJWWdB0sKHm/jDwNMHDZui8b1k/T5OHU8owaR5Q70H8cr/MjE/
 m6F69iaazoKdYvqjyjqNBQTq3/IbYc3WqmEJs8NYyA13C+sDxFJmnykhp
 NMSarygqZMyip7srZXi5i828Kojn+Dvof8ySu3p0gYdBQnunfk8szr2yf
 Vq3zzCXHWSy/P+lms2zfFYSaWU4Ab8ugUQteIhBVcyi35Yl6vG46zTUyQ
 lcZSt0kWvNngm7X+comJUJC6n3XfHFQdME46hJTiNUA5n2/wGl77484UN Q==;
X-CSE-ConnectionGUID: Tg3gwgvXTMe2BEGu5/vAWA==
X-CSE-MsgGUID: u5geH9XcQu+CoS5E3HHiRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88091708"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="88091708"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 16:36:58 -0700
X-CSE-ConnectionGUID: OCPhmLO3QTuu1gQEXspEMQ==
X-CSE-MsgGUID: sxXNNtReS965l3m7cuetoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="305371675"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 16:36:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 16:36:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 16:36:57 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 16:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf8oDEo/aYHXBarjLXomql4jfZzj4sRaX60eahHE9vGQAWmiY2bdLDw5Lf/8Y+h0eqg1ATHjgTxiH0e9jtV03g6wKt+IvNdiyr9LJh+BbuRHju0E3Mqk9mNZI9zHhQivVG49lRA4xi7Aux5foQ99pHKor5Jk9D2zTx1A1R/34hw9SOQi1pcdcQOWXaBNkOvRrrz7qdnMB6CqP0sTBHBMWnI5ELmpk5hmh2/pwKk+AMziBr54GGogAov4UJyZevXb+kobDspS8bH2xSfPt0Ed9dgwmPN5dIUd1p+naougLeL1xiHYNJYJVim4O7Bt3plCdb5IjWCujxS3YtGEgfxxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Xb8GluMSe5FMwWusvdyRrZO522r2Z87QVofjd6bSos=;
 b=yVFUOYB+2mGU6TZs4X0sHDRErn7Wuk4fNbABTyZUIJWKiAewevO/m5PaDbaC4wDnO28XTt0K3ME9mZkM1iFdy4/H3xKPYMv0b0nHuUKQ882hZ1JtU87TRuUlK6ye3F516l9jW4QZGrHsxEyZVuNmn6SBzVJ53blJSnj70QD6jQ+ZT1CbGiuGi/f7t4EIjceEpMVYFokfr0GbhaYlIzYsmWj+Bj9hALY0mwAPBrPwsl1ptLo6jjCj/VZriSH5nyr08bxZX56svSagb30PSwdBjEYDkuw6nNQlrFMGYY4oaR0k5WEwAjXAL98+fFqvgbFDwl9Gutx+mRCjfdxbUelHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MN2PR11MB4597.namprd11.prod.outlook.com (2603:10b6:208:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 23:36:49 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:36:49 +0000
Message-ID: <659ce543-a6b1-41ac-b0b2-4640af341bc3@intel.com>
Date: Mon, 24 Aug 2026 16:36:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 01/12] ice: use reference counting and RCU for PTP
 port access
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 <alexander.nowlin@intel.com>, <kevin.bross@intel.com>,
 <ranjit.cavatur@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-1-9d0731eb4858@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-1-9d0731eb4858@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:303:85::14) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MN2PR11MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b587ed-6ec2-42d8-650c-08df0238918b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X/g1nY3kgVWpO5WOvUnn4vJAr5WHmvxlckhCns7FYEDcmAGXS78Tjzh4rVdqvO0VkW6zaWCOR/c4P47k5mHZyetIMCewhf9d427teQXYxPetTVTulnO5D8S1v1as0KQdrpUopl2rem7+vuUUMgi0R0+BsH14Ce8Vo2fretyrY/m7bNtHpNXK30dZwlEHSxdvWKtiMNSvxFPvgtCNAfUcfH1x73Fb5P6U8VkD7/9AaJa41k04eJuvebi/E/I2MQ9xLifiBxHcqZXQY/07R8Q6sqt5pQX/Oh1O0qG9nmywU8gXpkY1h+xBWxdXIivxYwHRtUZtfo1h9NUyT51ZpoE1mnfy9HDzXL3bQVfDK+dvarlZY50Xzpj1HM3WZdSWC1H8wZiNwygg8wYjk2swd3wQcl5aKkofNi/l3DDBm29mujKXZX3ytvyNCUj+y6SyVTo8zPCa2yS4DrawvlYc9RFDc3StcXlBFsW6Q/NGfGX+GFnQ5ZJZCZYUAuLIBm0GWG8abLCu7gEurJqH/O4OfudKpYI/f/eCSYum0N+/emLyRqyy9lM5JHX9Uen4Mh+0tSjpPvB9S9GK5t6dbVUs18R0qibvPGtnoLCgKUYe6O4fTNm9PcQgWnbIO7W2fr03ty5P1DKJjd9OFcvX7E9tl6lNFW6c5vGUE/AYPJ57hfUaMhs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXpGVmUzTXdFTERSemtNYU1SSjZEODhMclBiUDhyUkRteUIvVFhCck16S1dn?=
 =?utf-8?B?Tzg1ZFVKTVNVc2h3MjdpTnJrRmpkdXBPazNXWmU4SmJLN1lEOTFaRjlSaG1t?=
 =?utf-8?B?REkxVXFSRGw5QjZHOUEzOGdlMWdtSE1CUCtVODJ5NTdjMnpxR3hpSlV3cmxF?=
 =?utf-8?B?bUs0RktOeFFjNnFodXl6ZkgxbUtCS0Z3SjhRb3YwYW9MektvYWF2Q2kwYm1H?=
 =?utf-8?B?L3FIQXBQS0NSb0pWZExLSmVtTmp4QndQOHA1N05Gb2lCbFNPcTZBTkpKeExY?=
 =?utf-8?B?em9mN0JGZENaRmM0eUtTYzNHK2Q3RkEySmZ2T2JyaHdFY1E0NVc3VUk2TFRK?=
 =?utf-8?B?RXFKOUduVVFEL0ZtL09UQTVWeDI1MHdkK1psWGZSRXVGU0pzMWZvSGJGRjBt?=
 =?utf-8?B?SVR0Q1Y1UDF1U3B4YnNwQkYyOUZQdDlnbEtXVnQ5Y1dSUjNUY3dqMThsTzl6?=
 =?utf-8?B?b3BaeGoyU2d3bEdJdjV3WlRBM2g1S3lXY3dzMndMb0h3Y0MremdDRmJQZGd2?=
 =?utf-8?B?QlVUZzdhaGptcWNMejArcnlLSmNaODZBdVFNUVB5a3lnMVQ0WkxxZ1pERUhL?=
 =?utf-8?B?UkorcGF0ZWhGdjhYQ1lFYm9scWJRencxM0tFRnpVS3ZVWFB3WDhRNmt6QnJj?=
 =?utf-8?B?WFlBbnA5bnZ2Mmw4Qm4xUzZtWDROVE5iT3U2MHQzWmJrRXcxa2FYVUJ4SWNi?=
 =?utf-8?B?dHFqbzgrN3NSckFFcDg3dlgvSEt6K2t2Sk8yTkhFL1lCZy93Wk9JTzJzdHJ1?=
 =?utf-8?B?U2wyNk9TRnhlQVRtRUpZS3JZV0I4RXBnR2VUOGRKUGZ2cG9jbmhUS3JoSlBp?=
 =?utf-8?B?THVzM2E3enpPekEza2JhTVU1NnZYMlJzeTR1VlVLdFZJaGxXVVdsajB2WnpW?=
 =?utf-8?B?ZjBLaUZKaWl5Z2ptc2R5WkZMekltdXFPOUpEM1l0KzEwL1J6UU1RWFMzREVm?=
 =?utf-8?B?ZTFScFFxN1lMNzdtQVpUcEUvdnJFRlcrZi8wZm02RGRsLzFMVk0yb2I3cDJi?=
 =?utf-8?B?QlBCMkZ1eXpBWkdxNmRUUEYzeElLVFlmcGJIMWZFc0Jic3hnOG1IUnh2Z2Ex?=
 =?utf-8?B?dno4cGMwN3hkeWYzb2FOK0dORGc4OGJQMFNpdXozZ0s5Qk9DRE8vQkRjTGFq?=
 =?utf-8?B?djM1WnFLZlBKVWdMU2FtYUFNZkRVaXhCWm5PZEY0MGF0ZkFpV2xaN1FldUJJ?=
 =?utf-8?B?bHFUeGJEZC9WVzd6K2E4Y1JlemdZWG1TKzEzb0w0VTdvSTJPUElNTnBFcGRn?=
 =?utf-8?B?WWZCTk1jaVpnZUgrdWxOa3c2bWFpQTB5SU00VjE2R2NNL3NpTFBIZ2E4dzZq?=
 =?utf-8?B?ZGVGam9CVkxTbll4Q0IzOEtRNXFJSzkraGZSY3lra3pqSUlGVENub2dZT2xs?=
 =?utf-8?B?M3hLRlkzMkNjTjMyRmhTeUxBS1FvdVVnSy92SVdMd0FMckNIQWxwUERYV0ZR?=
 =?utf-8?B?cGxVdHY5SGhvSllhdlROYno1dmx0a2VHN0FNTllWVU5KbHN3U0kreGE2V1lp?=
 =?utf-8?B?M2pOVEx5RmkrWW01L3FaZEd4c3dmMjNtcGtPWEk4di84TTZLNHBPMWtGc1Ju?=
 =?utf-8?B?ZVRyWHhPc1RRb3VWQ2V0RTRuNGpTSHBldEdzMW9QTG52dDFBS0s0eXpFRjJh?=
 =?utf-8?B?MFVjV3F0R0szQXdvTFROb2liVEY5UjNkbGZxc3VyYzdudWE0Y1IwdTR0K0Jq?=
 =?utf-8?B?SWNlK1dLZ3g3KzJnNkJaajhWSk5WNmZobTA2K2JjdGU5UjY5UDRiS1Z5TzNp?=
 =?utf-8?B?YTdBWjZHSCt2RXRUamRmT3ZVNjdqaDZrWG5IRjF6RkVkd2taMllsV21FK1hw?=
 =?utf-8?B?REZ2Ni9wUmVHb2ZvUmxvMjlZQUtrQUdhb0hIMkRpZzFUZVc0Qm1SNjk2U0dw?=
 =?utf-8?B?cWpVUEZIaHFLRVNyMHpyaTNrN0FhVDBlQVBaOUZTVVovRUhDK2RpM1JKS0dw?=
 =?utf-8?B?QWxudVR3TmZaOUdiQ0VrRHg4MFljeSthS2VNWjg2VEVHQ0NSN0NBdDNLVDc1?=
 =?utf-8?B?M21SYWlRc04wdk1rMU9IenVBN3BuYUNnaUY2amJBUVNzNlB2MU1nSzU2RW13?=
 =?utf-8?B?aVBsdXZkSmwvWVVSVkE2WFNnSjY5eEJYRWlqajBLTEg4aUZYRFdZNm03WDdr?=
 =?utf-8?B?elNLM2RBUFNWQ3hiQzFubG1obHBKMThtaGNXTU5VYmNvdG5BVHQwSVdNVk9J?=
 =?utf-8?B?VGQzK0w0NUtDblY4cHhHQ0xFYVNKNmdNckl2bFlkdXNyd3VSRlpCMVBkQ0xI?=
 =?utf-8?B?UTFrdGs5TTNaMkVWSXlnVmVWanlEQU1LN3lUU1JlMGgvcDFyeEREZGJXRXNq?=
 =?utf-8?B?bHdmc2diaU1WeTBWYlVSc21zYU0za3Jkd05tV0dldGJqZGZDS1dPdz09?=
X-Exchange-RoutingPolicyChecked: 1nVV+P+U5CGpKLIRy5XB4tr3kQz/QCILXEYIrNHt0CkcuwNu9e16FfiOyuaXCC78QBssG96Vll1znYrRWhGvrupx64knMY2oD7NfIpOezf4RzHWjBm1Tw5d1gQTvNdaD+rSpna0odK0QFU22qLC2OqNubsudCcwuF9/bfM+CM+vLrLLVq/ERrHIJGq0jBzu9S6hHsUY9adt2Bx2AqwLoPDXQUYNGmbM/aQeu0jOLlEkxntc4JF0HK40apjtWEe5uR4rUTYKHmHuy3e2BM6uwiM4zgstPmBm7k5g1IoyconLPGRVU2iBv50ckvM8YB61u8YK3/QqgGX/nsd6eh2D1rg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b587ed-6ec2-42d8-650c-08df0238918b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:36:49.4992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+crtmOgq2nbrB0HFLmwuHW2djh8Md2ecYKgSec1PaYpZ12EPgtABZAGV5dChsQ10DXivWKpYQdaPxP2VWeMX/UWZ/PAAz1n3+d0HpLg3M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4597
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
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> index c4b0da7ce20e..da2003ba3bb0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -673,20 +675,33 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  	pf->ptp.tx_hwtstamp_good += tstamp_good;
>  }
>  
> +static void ice_ptp_release_port_rcu(struct kref *ref)
> +{
> +	wake_up_var(ref);
> +}
> +
>  static void ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
>  {
>  	struct ice_ptp_port *port;
>  
> -	mutex_lock(&pf->adapter->ports.lock);
> -	list_for_each_entry(port, &pf->adapter->ports.ports, list_node) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
>  		struct ice_ptp_tx *tx = &port->tx;
>  
> -		if (!tx || !tx->init)
> +		if (!tx->init)
>  			continue;
>  
> +		if (!kref_get_unless_zero(&port->ref))
> +			continue;
> +
> +		rcu_read_unlock();
> +
>  		ice_ptp_process_tx_tstamp(tx);
> +
> +		kref_put(&port->ref, ice_ptp_release_port_rcu);
> +		rcu_read_lock();
>  	}
> -	mutex_unlock(&pf->adapter->ports.lock);
> +	rcu_read_unlock();
>  }
>  

Sashiko says:

> Can this sequence lead to a use-after-free when advancing the iterator?
> The list_for_each_entry_rcu() macro evaluates port->list_node.next at the end
> of each iteration to find the next element.
> If kref_put() drops the last reference here, it wakes up the teardown thread
> in ice_ptp_cleanup_pf().
> Since the iterator thread previously dropped the RCU read lock via
> rcu_read_unlock(), could the following race happen?
> Iterator thread:
>     kref_put(&port->ref, ice_ptp_release_port_rcu);
>     // Last ref dropped, wakes up ice_ptp_cleanup_pf()
> Teardown thread (ice_ptp_cleanup_pf):
>     wakes up from wait_var_event_timeout()
>     synchronize_rcu(); // Completes without waiting for iterator thread
>     // Port memory is freed
> Iterator thread:
>     rcu_read_lock();
>     // list_for_each_entry_rcu evaluates port->list_node.next on freed port
> Is it necessary to use a safe iterator or pre-fetch the next pointer before
> dropping the reference, to prevent reading from the freed port?
> This same traversal pattern dropping the lock and reference appears to also
> be present in ice_ptp_flush_all_tx_tracker(), ice_ptp_restart_all_phy(),
> and ice_ptp_prepare_rebuild_sec().

I am not sure there is a problem here. I need to investigate carefully.

I think there is a problem here because the original logic was built
around xarray iterators which may not work exactly the same as the list
iterator. We currently remove the item from the list before releasing
the final reference.

I believe that worked for the xarray but doesn't work for this list
based approach. I think the best solution here is to follow the guidance
from Documentation/core-api/kref.rst under the kref + RCU section.

I will fix this in a v2, along with any other issues pointed out by sashiko
