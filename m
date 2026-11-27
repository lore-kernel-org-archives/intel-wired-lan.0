Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73144606A330
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=owKb3vJm;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b5Km7ixM;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=EFpLkNlT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C05D40A34;
	Fri, 27 Nov 2026 10:07:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aUxIHU70RZes; Fri, 27 Nov 2026 10:07:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 95CBC40A2A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795774040;
	b=slgHz+KeP5bJ2W5Vn+PID+bYOHjIae5GzlhtUhbHE3D2g+LZpS2NT0DxQpK3FhrbpLyY
	 eJY1XgT/OmBptkOMmayZf+s4bmrXX7E+I9PJLH5mIw4C2AeSQSYpet0N8LQlEEfX3UbP9
	 yPO0vRqVEqcx4zLkBpGqtSfnZoS6n3P6XlBOR/CTQ3ADh3aF5DL5a6BALvfu6EeMevVC6
	 RaHM9XfFAbVxaG0XtZpApUYkP+OBETASqeNmy2EhlTed3NY0nzysjWs7jS//J3R+vQKqb
	 tQFO1SCt09cNg1MZ3u6oO9dOwoj9DRRtql7lD/YDnkAMYSr8uDphLQF6VJIz1W0lx5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=BH43gHMOue8kgOs02cKRrM4c92afWaWF2raSnTjV2LM=;
	b=d8R54m209c4hMGNnrq2rq0hRprGHWsEqLXzei2ry8XrN3sFJt2H1bXw0ohQAlZvwVJvy
	 Y0bz6GBCNiicBc6M6Jdshkg9fwEycx+1OyJkcpq/qBw1Ip5jNMaphj5e4NjVidz+OkydT
	 tmwvWIpacrr6Iu+CsSwQCu/Gjz9rCDAucfLvrWOQlSjWNgPSUZpnev+RwMnGW1YL1yFrb
	 yZGTWYN3P/jaLvsD40BgzGW0ydh/MCNLFCTaAf2R4uoVZO7WaUKgi+qbMXD4N6/h/81c0
	 Nx3si9NSOPMex51IokxEDQUF+8f5FbwgZWkPucOqyYSUuwplsxhQT/rYs8UD9vOgqjg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795774040;
	bh=BH43gHMOue8kgOs02cKRrM4c92afWaWF2raSnTjV2LM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=owKb3vJmCfntAoWDkLYODcT9C35M4UliQsHS9d9JB/S72+GNNSfr4FkGOAuYkgCdi
	 16qIDllyhk0IJ8CIMsKrd9wT7JFcSOQdb9KM12bHqTOfbYURC5SJUV5REysuVhttLV
	 kOkjZgMfFsA4A1qLy6BYHVmFLEIC59k2hzkJv0L6edNFKP5MatHU4qfFVu+HDQC5aD
	 Vh79l+50a8OCmlj+q09xiwvewnthSwUa/hn2bmPsSfUOdcnz3r3bF1tWTeBH3fFVG/
	 d8XQ0bDcjp6qQU7HOfjIxadGif8ixj7jBPw+V+L6+0nVQAfxlS2romBpwpV7PSsehh
	 RoyAI6VrgMpzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95CBC40A2A;
	Fri, 27 Nov 2026 10:07:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 19934D1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 10:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F36604008B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 10:07:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wAcpU-HT4ZRB for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 10:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B52F94004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=b5Km7ixM; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=EFpLkNlT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B52F94004D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795774039; x=1827310039;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DnThIrOn4J2BXC/64ZyJIpDFnx/+ha93czLT4AlbAy4=;
 b=b5Km7ixMN4zN5avjIhDgRJmjtZUuEeMdpdsaucilzfrh+7C6tji65P3F
 kj885A2K8j0Qe+0lzDKqPgTZKLc8E6yxj++TLje9khK5ZeQcCiJLPrfts
 ZjOP7whAlmVcXfr7QYLp0VqT8vBXuSSa+S8LIG2jfPnaKeZ+UeSS+ASt/
 Jr5AySod7YD62ZYkVFVDXdAbigQ1P5PccITjWpArXusWOh/iZ834EnzaU
 wfvDhjc3AyrRrBzYdQbt+OHPImcDHqVHKELJySlGFe93lTCxlqcYk+HxO
 YHeTci1PUErMydNJ3381EuI4CLLInYYF72iRBDHkPhon2E8slJzouHA9A g==;
X-CSE-ConnectionGUID: JgzM/3VNT1KrVvP139gTWg==
X-CSE-MsgGUID: HCfWGuTuToW4SlNWU8I/PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4701241"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4701241"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 02:07:17 -0800
X-CSE-ConnectionGUID: 887V5x7YSZiqeW8PLpNdVQ==
X-CSE-MsgGUID: 2in11+xMShOmSBMdcxJZpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12250933"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 02:07:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 02:04:52 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 02:04:52 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.25)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 02:04:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH43gHMOue8kgOs02cKRrM4c92afWaWF2raSnTjV2LM=;
 b=EFpLkNlTL4ZvmYUtEZI/7IU+wqFa9Jmco58zQ3X7dOjz5XiFhkBUx5gFQsPTfvuHsigbzzRdAxpU1DrBFx6o8cT6DREjVdqVrphBNnkzMvd4VIKvAYMrihcmPq5GDGFwBVMREg/BQmS1nYlUraTy+8fYSVBPP4GRxB9RgpZfY6g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 10:04:44 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 10:04:44 +0000
Message-ID: <66f02676-a5ce-4e5d-9bda-26e23fe91418@intel.com>
Date: Fri, 27 Nov 2026 11:04:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: Do not free a preallocated node in
 ice_sched_add_node()
To: Yuqiang Sun <izaiahsun@gmail.com>, <anthony.l.nguyen@intel.com>
CC: <m.wilczynski@samsung.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261119055731.55798-1-izaiahsun@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261119055731.55798-1-izaiahsun@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0207.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::9) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf5b06d-3881-45b4-86fb-08df4c6ddc57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: KUeudCpUTMUuy0w/4aK8h/C5aVecYOZMyIYZs+1IBcAO53aDZwIos6B3ioO8gqO5JI3z6Wzc6ojF0VwOfMlDxzHQKKhzzyzDMdszJOqZLgDiFaZgWX0gzBTHsjLJ3PdWmq56r9LvJGegGSyTNLEOYK9BU0eYhAUWpItu91FDNNBXZSAV1K1vY5PpkAwCqD9p3/aGvgyVfaiHC5BMcDACeaLWQ2ubJmvUkHPlNy/oQi7/x6FTeG/DG9ucuBdexW8O94HGiM6r6pwvivtwSKRfcWlQZAyh438NbXZ0KgcUxfEkybtLRyS8dHlMbVjtC6fg386yt55LXT+2IOstYV5lvZsG/j/Dh6SZoPqAFJWYlkJMQWhVMg+oLs+cl6PFMaGof9Sl2cks892vlxI4S+1UnwJvyr47xeAkVA9Z/ZTwU9NFTlDXvpoPEF+7l7HfLzZSkePe32NEw9nrDZhpEy4x766AbFOmto59kq4G0qrYxgM0QDGnaU8OiN2ijqwOf8+V2QNBZVOMP3+4La4EDyT/oVGc4uRNkZ1twIcuTXE1B7WRnb28jEqlsEypEmjE+zD9ectXZ/7Me4zpeIqGCnHg9BKxWnHp13Rbp9rPA2Y77j/+EWqgEgoLP7zs9EkHBBw7ljZGiXUvc3A58pPE9GgNyXjsGk7hxdoMQap8bSwWM+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0VDREFSRWJEYktuczRrRzM4TTdaOGhudkNiSWgvNUxiSXpiU2VmL0VySkwx?=
 =?utf-8?B?WkJjZHRRRWc2N0VCdjF2Z0tMYkl2dXNEZ3J4NGM2dVpLNU4zTjRocU82T2N1?=
 =?utf-8?B?L2xWQ0xtK1lWYVhOZElKNkRDN2xVVThReWQ0VnJRdjFGcWRPTHg3aFExMHlK?=
 =?utf-8?B?Tkx2MHBKbUVZamU4TVlnMnRYb2hBSDRtRkNvdUtJSE9TWlZ3a2YxSytCeHhN?=
 =?utf-8?B?U2YyNnpOcmY2Szl3U2ZCUmxzdzBlOWdTU2xOYjhSSnUySDQzMm9PRmdpdHdJ?=
 =?utf-8?B?THQxRXFCMXRVU1M1Y3pKK1NLYWl3MjFvR1NSNTRaanZaZ1F5K29RcDB6bFBj?=
 =?utf-8?B?eURWV2dvOENSNDFDbXp6M2JHK1VqNytkOG0yaHBqQnNBWW5Qa3I5N0FIZ0xW?=
 =?utf-8?B?Z1VmOVY0c3RYOUlxVDAvVCt0Ukh3UXJkN2UrRnE0YVdLVFJpUE84OWFUc1BT?=
 =?utf-8?B?RU1sL09Hd3ByRElNTllRSVZGakt0aXVid1EyN2Znb3ZZV0F0b0dkZHlsV0Zi?=
 =?utf-8?B?ZmllZEN2QzF2dmRYQklxbitZSDl1dExtSmJUOTJiSHQ3aStvSE9xVmNTa0dR?=
 =?utf-8?B?SC95TlZMZkhQOHVuODBPUDFGdGNzbWVzTmk5eUJWK01RdUhKbG5ldW1ZaGV1?=
 =?utf-8?B?RktYdmFCUXRtbHErdUMwajlqODVyanIrOHlKY3BvUFNhWHhzQkJsTFNSbmNl?=
 =?utf-8?B?Qmt3NmFmREsrQjV1YTRqRG9GYkowbUQwR3BhVW9WVENkd3ROWWVxS0p1ZlZ6?=
 =?utf-8?B?amxQK2RqNi9zZldnclp3RW5PcVYrWlJsOEsxaWVjL3RIcDQxeWczdU9GWXQ3?=
 =?utf-8?B?YVI4c0g5WkFhRDdUendQcVVKS1JVaWRmZ21mRlVLNjhmNTQxU3FWYVVyN2tk?=
 =?utf-8?B?cDJmYlluR2d5OHZuc1BDZXgyZThHQzVYWG5uUW1LZTZVWU5QcUIyWW90UVFt?=
 =?utf-8?B?eHpzR3MrTFRMc2ZaNkV5QmVxR0xDeDcwUE00dmRPck5QVjdQOXhJdy9RUWlx?=
 =?utf-8?B?YmhLRTlDV2tWZEs2WjAwaER6cUdvUGRDR0tyVkhBVmJGYlJWMjQ2cXgvZzZy?=
 =?utf-8?B?ZU0vNGtmbGpvbUtXODZZRHh1UklCdFZxVjNkWitxOFBXRVdIRkZ5MHI1M0xF?=
 =?utf-8?B?QzhCVkVJaWpzVThNbHFnSTRRU2xIeTJMU3MxSnArVUloODdFbmM2aWhvOXlN?=
 =?utf-8?B?cjc4Z0ZrSGtQQzBkNEo1MGNtQVFkR1ZnU0pOaXA3MmN3OHdneWVjWmppT0l5?=
 =?utf-8?B?OUtyNkQvRDFLSk1SdUREMXlaUDBIRlQ5MWhqWURjRzVZNEJ2clFMTTBZMzZC?=
 =?utf-8?B?YUxlUlllbm5IdEFtVnkwNEZwUkNMdWcyUFV1TXdad1hsWUljaWhBRFBzQ2hv?=
 =?utf-8?B?TGZIWENqQjRNOTV1c0h5S2F1U3VabHRpU3R0eHlVWWhGZHBjZU5wNEJ1UkJV?=
 =?utf-8?B?Q251MkhhcXhlNkx0WFJWNkhxR0JiZzFrTjA2UWxUVHBjMCtjU0lHUnMreXVI?=
 =?utf-8?B?OHIvVDgyOHhGVXlobE94WldPRll3MXVyem9wNHE0OS9PdWhmR3ZXVzFHeStZ?=
 =?utf-8?B?WkVMYm5HOEZPcmFaaERtWWxnR0xjWXBhN2F2N1RtREltTDF2L1hyckExcGcz?=
 =?utf-8?B?MVhIOE83TjkwTEZsWVljajV5dHRnWDgrWTkzc244N082L05uaVNBQlo1dndE?=
 =?utf-8?B?ZFliREt2bTJSYmkvbk9vWXY2VVViZG16SDRYQmJMRkFPN1JiblJwNGlWTWNR?=
 =?utf-8?B?M2tYdG96NHlJZnlKRmRmek0yTW1Sby9tSFBGV1VvRlVqY29ab3RxdWVDQXNZ?=
 =?utf-8?B?MU1GWld0VWM1d3hjaFU4QVJDVTlUdWR3Skp1YlhTTjk1Mm1qZWxzaWhZanFD?=
 =?utf-8?B?ejIzdEcwWDBjdWJoendyMklNMHZzTnJIMWxDZUZXb3krZnJmM25aV3FCanlI?=
 =?utf-8?B?d3lOQy9rWjZUeVZMRjZOUEVvenQrWTdhN0NLaTEvODh0bzZQSkZpVkY1N09W?=
 =?utf-8?B?WElzdlVRbEVPL1BaVFRMcmZFRHg3eVF4REF4RHBuSnYxVWxSRUJlWGNlSHpS?=
 =?utf-8?B?M1RkcjEweVhCakUrTUVNcTRYZVpoV0wwOUQzMEZPYUZiZUFFNXJVcExIdzFw?=
 =?utf-8?B?L2VoZUtJNFB3RWErMXdOakdXbzRIQk5TYnJ2Z0hPWW9UejU2Y3VwVEwzbC9D?=
 =?utf-8?B?bHdTY1J5ZHV3WVNZNkVGVyt2MlBvQTE1Qnc2UzM3WU0xeXpYZVZ0SEJ6Rmlu?=
 =?utf-8?B?SHZ6dVl6SFN3bzlrTUtzYmdFK0xueUFQRlF6OXFGaC9Ua1Z1SmhEM3ZDUWtH?=
 =?utf-8?B?Q2Y5RGVOWXp2QThpZ3hTd2VXVzJxcXpEcC91ZEg4WjhLTHZ6d1REYUtRM1pE?=
 =?utf-8?Q?03scWLR5YmuON6Lg=3D?=
X-Exchange-RoutingPolicyChecked: INBHHwHmAnvL5z5FPNVCf4ccugpfMbunX77hM65lblw+ODNKqJt1sjRwws79iu17n+DuT0tmH7VV6WpbRpax3zjDXkc99Sw5LI7taHpjdab6T1Lk7d9DG42Ql3TKgonOS/0e/dHM4/3q100znCiQTB2DQwKGO7UgQZPXZnwHDNX4X1lT6VPRpnZ0R0cgbmFWJQa8pGrGKgp+Y7LHSgXS4qzIo3RgYHOkRYy4hLpgxk76UBwnt1xP95tZOmty2gv6J0BLFiEf6wRoGLW8zkzAlKcXdMZU8cVH/cIoqS9v5ovhZBeulUirym+THheoKMCcpLe05/uB7NxJHJtRtCuVFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf5b06d-3881-45b4-86fb-08df4c6ddc57
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:04:44.3964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cMBX0Vsrg4E9g/GHBVIDS3KFLFhgu25GVxIEO6KW4jh5LaDUvV7ZgpVA27Sm2joISYJDtIq9rXGenOkdVLhCogoWm+OGPFe+Gj/bBb49ZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 6:57 AM, Yuqiang Sun wrote:
> ice_devlink_rate_node_new() allocates a scheduler node and stores it in
> the devlink rate as priv. When the parent is set, ice_devlink_set_parent()
> passes it to ice_sched_add_node() as prealloc_node. If allocating
> node->children fails, ice_sched_add_node() frees the node with
> devm_kfree(), but priv still points to it, and later rate operations
> (setting tx_max or tx_share, or setting the parent again) use the freed
> node.

nit: commit msg is too verbose

> 
> Only free the node when ice_sched_add_node() allocated it.
> 
> Fixes: bdf96d965a20 ("ice: Add an option to pre-allocate memory for ice_sched_node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>

Thank you for the patch, and props for resolving Michal email to his
current company :)

> ---
> 
> Notes:
>      Bug was found by kbound, an internal static analysis prototype.
>      The fix was written with the help of Claude Opus 5.5.
>      
>      Compile-tested only (x86_64 and arm64 allmodconfig, W=1, sparse): I do
>      not have E800 hardware.
> 
>   drivers/net/ethernet/intel/ice/ice_sched.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
> index a5c7a4e1ceba..dba6cc912b7b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sched.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sched.c
> @@ -210,7 +210,8 @@ ice_sched_add_node(struct ice_port_info *pi, u8 layer,
>   						   *node->children,
>   						   hw->max_children[layer]);
>   		if (!node->children) {
> -			devm_kfree(ice_hw_to_dev(hw), node);
> +			if (!prealloc_node)

this is correct in machine-code way, and shortest possible C code, but
semantically wrong
the condition should be `if (node != prealloc_node)`

> +				devm_kfree(ice_hw_to_dev(hw), node);
>   			return -ENOMEM;
>   		}
>   	}
> 
> base-commit: 6055ab4d82e42de89871db03045b568ed706ef50

