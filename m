Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991B5C5DF9C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 00:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57E954052A;
	Tue, 25 Aug 2026 00:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ZpPUw4w3b7y; Tue, 25 Aug 2026 00:17:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787617065;
	bh=chkDZ42P8bP0lb+RYEcrDyntz6eyh4CFt13QWhq6Rc8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G+SSseQYFrnVbcw7iAP+YfXU9VEOGoSEWI++tHlfqIFIKijqLmDXBRHF6MH5jnga1
	 j/SzdmNhIK9H7uk/hmcpuj0notUecwiNIJ+JtrgUvKK+h0yHsq8TN8sqkeqOvgtp99
	 4DRdwixmlQE4/l0JfDctCnD0EvQMcJZKauTsDbrC2QGLllQCbwVqjMaLSOy+1ZRrNh
	 S7GiKQGXi4nhC7AsRkUNxT2/9Kiq1jrk2DW3vv/Dq40Rt0+D0lPe7Dn30TPxfsLl2t
	 3bWiecpvIzf+gV54bdF6GSDZhpjmaQVuwRizeVZsGhOXiPvcL6ztDMVq5WMsfy6DTj
	 lqYh1n+GMc0ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A2DA4043E;
	Tue, 25 Aug 2026 00:17:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E69FD4B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D76DE6063A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vz4LrU2-oJwH for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 00:17:43 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CjFE74hT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C925D60618
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 00:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787617062; x=1819153062;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dj54Qhk4C6HqgKaiZPC4tro2HTNftlFsajRVGq3NxLA=;
 b=CjFE74hTQCMjfvwAAT3SOtQM7gIRCBAOyrIc4edZcajHODWZr5valxHD
 qSLjPx0aMSPtGN2zRpS/9YT5PSmQTC62k2uVQ05Y/sBEJPud4a/+EO53A
 98bJBTsXOM+3HJ8RG9RM8CfQmcAr+jMiPu5FL+5C2mPJhtGiLVGD80ZVk
 IBHL48zSPcKKxzULll+EJHfaXr0YrGJwAWgCjGdZrYrfT6O2BM/4M38GZ
 2HZRsG/46eFpKyXPyeTy2Utjwi1UBx6qfq8C8+qKee4eUmPdp/yQ7inoF
 rtMvwJOeHMuHG3oBy5pyX6a9IxboERvUnXQCT0gjauEkJo5vDyFhZyins Q==;
X-CSE-ConnectionGUID: y/SS0OgLT8ayZIqG9O3I4Q==
X-CSE-MsgGUID: BIbeoZTZQFa9Mt20WAxWnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87204739"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="87204739"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 17:17:41 -0700
X-CSE-ConnectionGUID: HG3uXFO9TaSe+MLFNuSajw==
X-CSE-MsgGUID: Y5k15f8CSi6K52YJW3Qo+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="262837335"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 17:17:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:17:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 17:17:41 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:17:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZysUodLVRNXQcy4ZeneAqjO6JpHQDin7hp7RWIAL3JzbRPD2iqw3XWes1IgYDxRoQ/OZU8cV/vMZwbIzLtkKri6oEtf2bfsULQOAbttkpT5M9Z+9wocSlWIQMquKtUqLN3z+488m8Ti5dryCEvd+1DCb+6dS3j3pvjGT71nwXwaoXMqYqMYC7yY1hKqFVlsx+IRM81oF4JtzgHyzjHyZsT+jNlBA7FyyjhzBnpBVA+LkKhyzsF50ChV6l9Qozg80VfC4KnBERI91Qo7qHpWuluKiVJcWUu7I3insbzm4YvRs0DjrHs+siZkbT4UanZ5G3Ot9etByUEAfOuoZzBskOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chkDZ42P8bP0lb+RYEcrDyntz6eyh4CFt13QWhq6Rc8=;
 b=jm1gekNJMtdo7VU2XA12z1aVFJ4AwwlUgXQ4XLL55feaDHfuGW35FPxoiBVIs51UF8ptwDLpPjyFvj1FWeAIZQEygQKsIawBxQrw7hFzptbzHYl5qXw/n5wfa/hjVyjfxjrkLYX1CHaosiMMYKaxQEiq2Ne6/4ze2hCaTJcGkeWfvFrK5vqRQDYUeJrgloo7xJbSasgxBhcFblzmN6AsCm0PO+YBiqAQesphHrjreYhq57Usy1aPtqnjBOaEEmAWRrLF/GdEpdtuSsUpgy18/DpaDGsL4KPF4pLzBIcYTc9N5VV4Vih8e9LZ8nwtih1QUvj+vnr8774xaUzna0m5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DSWPR11MB9763.namprd11.prod.outlook.com (2603:10b6:8:355::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 00:17:39 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 00:17:39 +0000
Message-ID: <9773d301-867a-418c-bc9c-719ab51b4023@intel.com>
Date: Mon, 24 Aug 2026 17:17:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 10/12] ice: remove unnecessary discarding of
 timestamps after clock adjust
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Grzegorz Nitka
 <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 <alexander.nowlin@intel.com>, <kevin.bross@intel.com>,
 <ranjit.cavatur@intel.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-10-9d0731eb4858@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-10-9d0731eb4858@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0153.namprd04.prod.outlook.com
 (2603:10b6:303:85::8) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DSWPR11MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: edf9f69c-7c0b-4825-16d6-08df023e45a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10063799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7CTYodTTHKKxz3WYe18NBDcy5q8gRqrPqnYpGiGTPx6LDEz03G0oVYSvFYO9VeExmVv5zCUzCkO3aHNWDe/ILLWrjDAhCmgNu+ayOakViXQr+f5BcrRglZUt9rvplFYDLfQZN4TjJvtQyBD3KifNnNOFDcpuXOKysZQ24ascSaLzk1TNFJ8M1OmcN7bt+IHkbQ4CwUAeRHbvEhyJOpniBYVRGl/Zr8dVwqW/so1hq5/Np6odCDlutRTqf+nP6x4elqj6epEHkkWwkak5V/dPQYpEMhq3cm09kgogHLUmRzLpR49HB2c4YXslrkvwDIQz4EM9IO8Vm7N9d663nwXuOX315BNLNGcxay0RAqr85GRTSws5PUCgAwscWaKhdstCveP8HI/e6kHmdH7kKXYhcmIEoN8dSwHh6axAjkQW8+P+jD6we1hT9/CCFoScciGI9kAtjseBRb9Qcz+20rPjY3tgTAWqJnJo1WYV8TR9EHb+AwWNSYY3raI5osJvAJO0mFklqz84GpXbLY/NEothLPjipLc3/xuOkP87g2LUsXvpza+jgb2DZtXnzB5e5Bqto6TwBtdjJSVOhF84q8o9tMYN/k3FbfOy1mKGCNkj9l5PV+Tnh/7944aRBPafaT2srfSJp0nmrCrifOk/nkhEbArkS6w+dd8RQFwOhome6ls=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10063799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2tmUXZza0VhNEZ0dHpmTG5jRURRV2VoQnpRTTBucUEvT0NpdjJLYzZvQ0JD?=
 =?utf-8?B?TEJFNk54NFVabTMxLytoYUxVdHFSWmYxT2JLY1dpenVoWFk3REVzNlJtejNU?=
 =?utf-8?B?WVEzR05KOHRUVE9NclJGR1puMnZCVzZpZUxCc3lSSnlncTVaK21wV3ExZDlF?=
 =?utf-8?B?L294cVZRT053ZHBVRVlUL0ZPU1F2K2FIVGQ2Vm4zSWY3c3NXM1JZRTVXaFZj?=
 =?utf-8?B?OTBjalpnV2JDbUliakxZSkFRM2pvdE95eWtTK2JIWHhyM0hVMjExKzRBS2dv?=
 =?utf-8?B?NEozYkp2Z1hGaGkrdG1aYmpTZWlvb1Mva2RLNmJKQjI0ck1IS0NCWVZ0T2hF?=
 =?utf-8?B?U28rV21wckZjYTB6SG83MXlmd0QxRjB5ZUVaUHh5ZjRHU1BIUVo0L3g1M1V4?=
 =?utf-8?B?cXE2c3g2NHRtaWRwWStQbE1wa3JJb3ZQT2hDYlppak84WkE2enVuWjViZDZC?=
 =?utf-8?B?Z0RXOHl6V3NmYkYyOUQ2SFY1MXdUSVZoUk1HYnhVK2ZmZVlUdGw3QTRVZTJi?=
 =?utf-8?B?ODRGbXpKNUJNQ09HdmM1SkJ1dDlwajhQV1M5WThzWW9VSlk1Y1krQTd6T1hk?=
 =?utf-8?B?akFMTzBnOGgwMU5GbkxmdFV6dlBSU0diZHdIRXVIamFyOTNjcGJnL216VVJD?=
 =?utf-8?B?L0ZrZzRUME9ZcEYzdHFWcjdjWW82MHcwSlhELzV3Mmduc3pYZDRoOFh3Z0dz?=
 =?utf-8?B?SHBQQTlKV2VLTlJvVEFlbFZnYzBrMGRqa2VDNXp4QlBTNXllOVVxN1dIOVBw?=
 =?utf-8?B?R2lYZ2U2Nm9hcm55M0h5OUp0TUpxQTdkeUFZK0RYOTRVSlN5amtBdUJNYlJ5?=
 =?utf-8?B?S1lVRHBWa0R4bWorbUtqVktuYWdUZmdCSkRYL05tS2FLcVFjMFVvck83UXFo?=
 =?utf-8?B?QTc0amV5S1RYZmRkN2JtZGM0R0lIT2RTZFVMSG5HRnkvb1ZpNUhucisySlVl?=
 =?utf-8?B?ZEJuaHhEcFlTMW1NVjEwbHl5N3Q1TWNSemttVzVWL1lJSVlSbkVVMjRQZlFR?=
 =?utf-8?B?ZFp5dkhMQThRVGhWYTdKWXJPS1hEZFdlUVRIVmc2MFlHSjVpQWc5K3gzN2hE?=
 =?utf-8?B?ZnpYM1Q0bE5xdmV1UVJQVGNTdkJaWStoMEpaNGRscVNYNFplRWNmSmdYMkg1?=
 =?utf-8?B?anQ4K3hsRHdDV1B3SVVCakxMUk9iOEdzY3N0WWlZemFSN2QzMHpnbWhwaW5R?=
 =?utf-8?B?MVZRTlBSeVNjMWF3czIzNk03OVltZzhZRSsrVk84RDhQZ0l6VnhVNzdXV1A0?=
 =?utf-8?B?ZVg0Z1pmRURoYWxnN3I2NWpBSmNvMWQrdlIxVzA0czNtVGs1dlpxYmhLL2cz?=
 =?utf-8?B?RFkvdHBGMGNyUnFVNzZ2RGJJVDhWeUd6NE9kMDVwRXFpemk2bk9UM0hsNVMy?=
 =?utf-8?B?NVZxaFpjbEhhU0hrVE1YTHNPZ3dDZlFNUnptdkNmdVFGeTVGbTR0ZlR4YThN?=
 =?utf-8?B?KzBGcG9QNngyZjVEeVhHNDBsc2ROUDJNTTFXWTdwQmNzZWVRb2F0a2hYT01y?=
 =?utf-8?B?ZEk2K0h0Q2tOVFhQTnBGNDlwdFl6SXd0c2NNVGNWT1kvRGNTY3hiZUwvMXJ1?=
 =?utf-8?B?aWhKTU11WVMvSmxaK3p6Z3A2UytLT1ovNEJKUjlUZnBQVWYvWncvZTltZk9X?=
 =?utf-8?B?S3BuZE1odFFRTTMyK2lNdVNIbnV1MFdlaXZqUFFNNzdXT1FRQk9LV01HTU1W?=
 =?utf-8?B?NXRWM1I4d3loT003VWtLdFltRDNoZUNPL25vTzVPcFBTS2RuQ0w3QnlwT25C?=
 =?utf-8?B?NGpqTVhtbmNoV1VwVmR0QUpWOEkycW9RQ1A3dDRJekMvYkVVaGxRN3NaTXda?=
 =?utf-8?B?MEd0TUJGcmdLV1BESXFMZ1o0QUV2NDRxUzhMenZNczAwdTNmditMVnpBWWlB?=
 =?utf-8?B?Uk14QnVUQTNPbUR5ZTMvalV4VDkySDAweC9yNUpLNHk0SVZoTDg1TGJtUTlv?=
 =?utf-8?B?aTlEVEpQeVJmUEFWSnBKQ2lDM01LeFFveDhqTVR3bVNJQ01JUUNmZFlYYnVT?=
 =?utf-8?B?Q3VTQ1FtT252S1VpWmNTMEZpR0MxQ1pGQVBadzBBQ2x1WWZXZkRCY1BBUlU0?=
 =?utf-8?B?QWVCU3dleGRJU1VGZFFrQklxSEdwc1A5anBZS1ZIc1BESGhUeTFwTHg4YXJm?=
 =?utf-8?B?bEI3MVk0UDNMbUI2V21jcXVoVCtCMy9Sbzc3WVpPS0s4T2pXODNjd29VU1hr?=
 =?utf-8?B?NEVIbElET3VrVDZUNjZZei82aWdHaThtaFRZVHYzZ2VnN1ZtMzZJdXZRS0x1?=
 =?utf-8?B?ZVRpSS84QVVQaEFnMlVndFZ2ek82QzNQMGRCNk4rbHNRemxLYXBESDRVV3pn?=
 =?utf-8?B?Umppb29wRXkxcHd3WmZ2VGM1bi9KMDEycVBXU29PL0hidXBDQy84Zz09?=
X-Exchange-RoutingPolicyChecked: WwAFg14wuN5tNGJNU8Y18RGk7yKnYlOWybxqDPnU3ZKGRabYum0CsG2dJUGCB3U4IXPtl0F737qicFBGlOfe/G9/v+e8sCZ4TvECcAVpu3cQ931enNpIop8+xjWRZiDOzsPIMRGYJYrpG6/rf7KER9NnLLGgyl1FS91/ZvRfkSwijIC5iz4hmidBiQl6vPahAj2OQwPDNWHR6TJZKHnEI3uutQiGm+Nfnz/5FuXglbSxFsbHX2RvlzIobFs/cALplQtIeqF0/laeEh995MBr7sD5B0tlCfTA9L56TEF978AW0Eil1+K5pShhoyrzLeUsJdL/emB+FgR07msaJCVeQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: edf9f69c-7c0b-4825-16d6-08df023e45a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 00:17:39.0847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGytyFlQqOb+tbDAoVTjiWcbWMhsJcEiXQt+y+KwV6wNRrNGfg9ln5TeQ2qIbwLGWNB7ZAuaBm0N3Ejn7mSHRgctt2TVWdui5F/8NadVRuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9763
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
> The ice driver currently discards any outstanding timestamps that are
> happening very near to a .adjtime or .settime callback. This was originally
> add by commit d40fd6009332 ("ice: handle flushing stale Tx timestamps in
> ice_ptp_tx_tstamp").
> 
> The original motivation for discarding timestamps was that extending an old
> timestamp using the new cached value of PHC was a problem, as it could
> produce incorrect results. The change did not describe what such "incorrect
> results" were.
> 
> There are no such incorrect results. Extending the 32 bit timestamp with
> the new time value just means that the timestamp is reported in terms of
> the newly updated and adjusted system clock. This won't produce incorrect
> results or problematic timestamps to applications. Either the timestamp
> will be extended with the value of the PHC just prior to the time
> adjustment (if the timestamp completes prior to the adjust callback), or it
> will be extended using the new PHC value after the adjustment. In either
> case, the resulting extended timestamp value makes sense.
> 

Sashiko says:

> Could removing the stale flush logic actually lead to corrupted timestamps if
> the time jumps by more than 2.14 seconds?
> Looking at ice_ptp_extend_32b_ts():
> ice_ptp_extend_32b_ts() {
>         ...
>         phc_time_lo = (u32)cached_phc_time;
>         delta = (in_tstamp - phc_time_lo);
>         ...
> }
> If a time adjustment exceeds 2.14 seconds while a Tx timestamp is in flight,
> won't the 32-bit modulo math wrap? It appears reconstructing the old hardware
> timestamp using the post-jump cached_phc_time would produce a meaningless
> value rather than a correctly extended one.

I no longer believe that result would be incorrect. I don't see other
users of similar logic around struct timecounter needing any similar
logic. The users of timecounter are very similar with the only
difference being that they maintain the "upper" bits entirely in
software, while the ice driver has hardware maintain them, effectively.
Perhaps I am wrong and missing something? If others agree I can drop
this from the series.

> The timestamp extension logic is very similar to the logic found in
> timecounter_cyc2time, the primary difference being that the ice hardware
> maintains the full 64 bits of nanoseconds in the MAC rather than being
> maintained purely by software as in the timecounter case.
> 
> Indeed, I couldn't find an example of a driver using timecounter_cyc2time
> which does discard timestamps that occur nearby a time adjustment. The ice
> driver behavior of discarding such timestamps just results in failure to
> deliver a Tx timestamp to userspace, resulting in applications such as
> ptp4l to timeout and enter a fault state. Reporting the extended timestamp
> based on the updated PHC value isn't producing "garbage" results, and
> doesn't lead to incorrect behavior.
> 
> This effectively reverts commit d40fd6009332 ("ice: handle flushing stale
> Tx timestamps in ice_ptp_tx_tstamp"). However, the stale logic remains, as
> we now use it to inform the driver to drop timestamps which might fail due
> to link down.
> 
> Fixes: d40fd6009332 ("ice: handle flushing stale Tx timestamps in ice_ptp_tx_tstamp")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 1a9bf8839404..8c2dd83d8d6c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -826,12 +826,10 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
>   * ice_ptp_mark_tx_tracker_stale - Mark unfinished timestamps as stale
>   * @tx: the tracker to mark
>   *
> - * Mark currently outstanding Tx timestamps as stale. This prevents sending
> - * their timestamp value to the stack. This is required to prevent extending
> - * the 40bit hardware timestamp incorrectly.
> - *
> - * This should be called when the PTP clock is modified such as after a set
> - * time request.
> + * Mark currently outstanding Tx timestamps as stale. This prevents the driver
> + * from reporting the timestamp to the stack. This is called to inform the
> + * driver that a timestamp is expected to fail if it was initiated as the link
> + * went down.
>   */
>  static void
>  ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
> @@ -1049,13 +1047,6 @@ static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
>  		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
>  					   msecs_to_jiffies(10));
>  	}


Sashiko says:


> This is a pre-existing issue, but is it possible for pf->ptp.kworker to be
> NULL here during driver teardown?
> Looking at ice_ptp_release(), it destroys the kworker before unregistering
> the PTP clock:
> ice_ptp_release() {
>         if (pf->ptp.kworker) {
>                 kthread_destroy_worker(pf->ptp.kworker);
>                 pf->ptp.kworker = NULL;
>         }
>         if (!pf->ptp.clock)
>                 return;
>         ...
>         ptp_clock_unregister(pf->ptp.clock);
> }
> If userspace calls adjtime or settime concurrently during this window, it
> would unconditionally call ice_ptp_reset_cached_phctime(). If the update
> fails and falls back to queuing work, could this dereference the NULL
> pf->ptp.kworker pointer?


I will check this. I think the correct answer is to kref on the port
access to ensure that we don't finish teardown until the function exits,
which would be included as part of the first patch of the series.
