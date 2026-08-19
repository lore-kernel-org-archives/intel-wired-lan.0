Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A765CC5DF87
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Aug 2026 10:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CA2C80DE8;
	Wed, 19 Aug 2026 10:53:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LGJX6qXsJ9zt; Wed, 19 Aug 2026 10:53:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787136788;
	bh=WXCknDNcacl0u4h/kh3WMb0T15INhuNgpNwS29p9ggY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8aAqn6Use4XhkmDEpm6GsEfbP3hJgNZRC38rpvLfR3vgvOZ7XJ8dB8gBpkrJOyEaF
	 txXb2DwTf4V39tQXa5witjfO1FFng/4tS3emPNYSv1ZqKwCK7f+ngDBwLmYAxLG1rT
	 iClh+r9y/VdZoMHg9X3QrTGuReftdBJEshudD1Q0k+RigDtabfLITvg8WqFyDx8EIo
	 sZqSep7/IWOA7M7MMkCs7Oau2WgSM8oLbs17EqHaFB5NHUKr5gO5UaXSwD4qQzKvxU
	 tOc/WrtSHNrFWOlq50Zu9gBzgVhUcId4oQjDTh+ze/9JTkEC/JH3w/LBGx7JA54VbL
	 ZvqikPr/jt4Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9863180DD0;
	Wed, 19 Aug 2026 10:53:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE6061460
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 10:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA06A40093
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 10:53:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fCArXrJXHf9Z for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Aug 2026 10:53:05 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kd5MrFl6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C75540029
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Aug 2026 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787136786; x=1818672786;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XF318ruA3t3KMNWJWWhPMSmwAw/cZ2133D1UrKNgPKA=;
 b=kd5MrFl6/D2g/NLZ/y7Gr3R3LJci8JBigE1GuyKehmj3YINEIVwjtZqu
 puielqaiQ6DIEO3mq5A2pAonHHqC9Cw3P6khRJgT9IWIrcZwxoGON2uJe
 BH7ZLLVEDx6HBR02CHmWuzb+zDYB9KfpcD2VuzE+v1OVCKrRot3y/UkwZ
 zCG9tY2vs3S6l2YZDRkT3HQivgk87rnWXgCqWiBf/fRzUCx9zP+Q1LMat
 pZbZynLGRQ1nODFydEG36TS+TH8r4jEm7KX29rdaSVrE5BaXT7JeLTnks
 JHJIV+AvzrAz0U/ETvyzHCEGu2Ee9dscfvIQOTFAp8zW4CMyNZmsFl8Bo A==;
X-CSE-ConnectionGUID: 7/SNWJYUTrqrWNhYJdExuA==
X-CSE-MsgGUID: 3wgU0IcNRPuDoCh+rlZ/jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98807285"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="98807285"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 03:53:04 -0700
X-CSE-ConnectionGUID: 7ulKBWKQQkOfo+PrfqVGcQ==
X-CSE-MsgGUID: KA3VSa9wSzWczjhTXjIkkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="262886281"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 03:52:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 03:52:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 03:52:55 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 03:52:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W84dfPlaL+5NfLZ6FIBUw2GJ6TONSfNUipV5KqMbCSbdFkIWDgdHIU1J776jExkvTXkYySZXXCwLe7g7uNNrdhZELemrNg9WjTOJPg2UdI7sE5Tvphb0wpzjQK37lcDiLtmoTGK9blwKhZSLAvjigCLowhVbHQqIdicoxaHm1XB2kjse6Gnb4vSUt560k3p5ehH9BHnKIzTBRpfqvVLHvcZN4j0I8wcWfV24qZ8QLMU7FvFwQ8uthyzXnPy8kf2/CAviuW4Eo/sIwSgyu5vbchDBJiEptxe4eIPrcBJ/MehgGlhE1/V8k/Rut9nYkZSxvktr59hiTD3GpNnyNnoRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXCknDNcacl0u4h/kh3WMb0T15INhuNgpNwS29p9ggY=;
 b=cJc9XTJCnBCsYhytjs3dGbLYUCQFhEEdAgguOHoNk8YfmMwZl8NtBM/MYEL58XNlq7pctpjD3IwpKadv0I11Shsb50jSxTvHBqZKgXWswgDlWP0xtUQ2EdZg1y5EmWTR+BDCjuRNCmgiFHC0KkwbgG9ZQk8lo21GLPQ/1qwnxY5ADqh/ZYIZVSbHY4gZUbH7qdIOBTCTT7r/55WbYbtyFqfHiLmUNLPEMezFfXy8COZz/iL99fxhEp0li1ihVGEcM5+0ueQMdlGXTlK5iUAe/pcMkSITuEmcWj8C2ul0YlOEaGbSxOrM/yjngKrSvX4mZMePzlSEBtJGYUTwP+xyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by MW5PR11MB5788.namprd11.prod.outlook.com (2603:10b6:303:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 10:52:46 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 10:52:46 +0000
Message-ID: <98034c58-cb45-4367-a074-bc654af1ce77@intel.com>
Date: Wed, 19 Aug 2026 12:54:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: allow reading the last byte of the NVM and
 Shadow RAM regions
To: Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Jacob Keller <jacob.e.keller@intel.com>, 
 Kees Cook <kees@kernel.org>, Robert Malz <robert.malz@canonical.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>, Daniel Zahka
 <daniel.zahka@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
 <linux-kernel@vger.kernel.org>
References: <20260819082458.665947-1-poros@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260819082458.665947-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::16) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|MW5PR11MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2759e0-ca81-40da-39ce-08defde0008c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bu4BWsyP1SY4tIale9otO1wY8Z2GSMnvOi5dCUxxYuIyaU0zjmZAriYUeL1BAkCqk8Xq2Pp9UXJ0CtRM92eOJcp1pub61ab4zmLe9It5UE4Zs5wjFtyHPgxZdvdhx0oQhrv5US2tk33bqhe8Z6psEAj2VT0lkHFwZMxkbinXcmbGEPkNPTo7SE0GSptUhcrW006VKNM3OR6qLNwQvBppMEwxA/EFb5bHf4AEJlte9DOmO48EE98b73fQrI8CSPkaRY7UBi8XedumqIjBVo8VrSTOQST16MHEkcsZupZMIAfHCRwqwCLEw9G89V0U0+hvHqn1aQra+KaTa/rcdsR2cZJwrbe+EfjFFsFeJUDkE89td6whLVBNT4wt+blcuzW4HbJxfTW3mJ4v5HU82jdiDBdtU5bAYHZNV3lm8n/OW8R4H4D0KK5/tKL7g/pSlsPfcNSv+Y2Y04uzgDVjfV4EP40NBPHRgiAHAgAvBW2rIqLT+qcl7efPorfiARpfacDsiZ39QJKedlCfKbYrjMyxVDIv/rDaEzk3KD4hldr3iM4qS/XRrpyI3dxsHKPc09C9eJINCC/hDO3yqPk3B/S+zr/04mIzOxV1Gr2+xQMu5k3I2RmmlfWSYQ3zs291iR27wm4ZL4yNObCsV75NX1NMYw6OXOoo8yP4lBW0K6rRsHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWtpY0I4KzU3UVFLTUpJM2l4ckk2K3N4S2JnWnQ1VU53c2FNZHlkOC9PWSs5?=
 =?utf-8?B?dGR5ZndqckpIbzh5SlZwMEd0VE1EZzFBUmdrOVRQc01iQkhTNDdhWnZCcFB1?=
 =?utf-8?B?T09PY0RGL2hqcmR5RXlTSEdlWll3RVY3NUdQajNUWm1RRGl1d0tiVDQ3bVRt?=
 =?utf-8?B?VnpKZEpCOGNEL09mTloyYzdQcldvbU9GdjV3ZGRMdXlOL1hnS0s4OEhPMk8w?=
 =?utf-8?B?L1JVVnhvN3FrYlpOM3Z6WWRodEdjaUUrUHpWSW5TMFQvd1IweWNxV0ZSQ3pE?=
 =?utf-8?B?M1lYTVI1ZTU0Z0F2cmVvS2tEcWJybXRVbnRZTDRWSlI0UmgrTkd1czVMYU9O?=
 =?utf-8?B?aHVpVHpXUERvZXJIR2FoZHFGNmF6WFhqSXk1Ykt6bTJMQVVCSklyUFNHUm42?=
 =?utf-8?B?cFZCZDFUcnlhYkVYVFBMY2IranRHSTV2cWdHMlJzNE1qSCsxUnYyMzV3WXFQ?=
 =?utf-8?B?cEh2cHFNK21YbS85ZXdlQTJWQU1XV1IwMC9tWEZZRkR6eFVSUDBZWUx2ZkRh?=
 =?utf-8?B?VG5lNUI1L001V3NjZFpRMW10WU05ZVlDWnNFNEpGZllLa25yeXNlZU9MOUha?=
 =?utf-8?B?QnBlaFFacFZheUZ6aW9lUkhHSVBwa055YitKaXBWL1BaekRWa3NZdHJKbkl4?=
 =?utf-8?B?ZGQvNlhmT01tWWp3VFhZRkt6aGZNdG55SDNaQ29UQWlpQ3VPS3Y0bVdwbXdL?=
 =?utf-8?B?UGpxb1dVUjVDRGNoN1E1eFhkSE9jMU9CeEh4RVFIUncwVmZaaGFMd2p2M3F1?=
 =?utf-8?B?T3NuMnkyTlpjb0pXbmNjSUE2Y1l5L2I5NW1QV0pPU2pFWFNUdHVDbU1Cdk9h?=
 =?utf-8?B?RndoZERCaVNBYzFkOEk2MWJPNFlaYVU3UFJSdWkzempoYmhWcUJXV1VrcGlx?=
 =?utf-8?B?TmsvTWVvblp0MG5rRTdydW1uTkpOR3A3N04yOTV1TUZSV3dtOGtLaVI4amRk?=
 =?utf-8?B?REU0amdPTlUzVFUxem9Ldi9NWHU5Snp0OWUrRm8zcGRhc09teC9sQ3dYWVRK?=
 =?utf-8?B?ZStrZjI0NHltZDdkczg5eEZVQTBTSzJHSlJPMWVlSW5WdndCTGhmRzVzNHM5?=
 =?utf-8?B?UHNaNmowa3JZdjhVWk4xS2RJeHMzTzE3TkZaRWsvTUZ2Y2M0bFExNmNoWGQw?=
 =?utf-8?B?Y2tQaW5zMVFySTRxaGFMRm1jb3czR0c3K2FTcm5TUUM1S1hjQXZYamFSMW9s?=
 =?utf-8?B?RThqY09Ra3FKckJRUHdPZWRwdCt3S1gxYnZXNFJYZ1ppcy9tWnh2T0ZnWEhx?=
 =?utf-8?B?L2VVQkdxZXpKSGtxUzhSbHN3VjJmd2xmcDYwKzNjUHRobUhsaXVOZTcyK1hm?=
 =?utf-8?B?T3ovV2VNM1JsenR2a2dXY1AwckZ1ZzBQQkRhYnQ4MW5yWUU0cW1zWWVKK05o?=
 =?utf-8?B?TlJkdUJwdWVZTy9GclZUUExlS2ViOVVXQjgvZzV2OG1JeGl0UnNJbFlVdG5l?=
 =?utf-8?B?RnZMaVZsb1kzMkJnQ0dCcWw4Z3o1dFoxeEs2cVNISE1uYkFWaGJYQUVzNFJ6?=
 =?utf-8?B?TGtGaFZNQzhPNGIvMFRSMS9STHgzN1RTOUlOTHF2d3ZmbW5zMTlFOWhDc01s?=
 =?utf-8?B?VExXMTk5bG9VbGNvZkoxVUNXb0YyY1B2TjcxdUcrakcxL0k2T2tCRVhJMllW?=
 =?utf-8?B?MkNrWUVyVWlhMW5yanljYVNFR3ZmdXVhdHZ6a2JIL0ZHekJ0NVJjcm1vTGhM?=
 =?utf-8?B?ZzYzcHp5NXU3ZCswRWRVWEZnU3Z3dkpuSTN4VEJ6OU5lMEhIdjQwbUNSVjE2?=
 =?utf-8?B?ajlNbXBabzNKaUhFMUp2UnlVbnJ4U2IwYy95WHhZWWs5N1BLZFhKSVFoMWdx?=
 =?utf-8?B?QXF1YzU1ZFNPL0cxYmdSeXNXZWZSVTl0NmdyUy9WTnNsanIvQUFPb0Z0L2Qv?=
 =?utf-8?B?ZTVrZEFNZHh0YzN5ckZ3MVJyeGdSVWZJb3lVRVpsbkhYMCtRTkxjZDJSbU4z?=
 =?utf-8?B?MjA2UnRxT0JHS2tNdzJhYWRqUXpXbm5TUUtqS2JKbCtMTTdhQ0RoTTFPMCtl?=
 =?utf-8?B?T2hzcWMwVENlMkRtUFpFSFZob3Y2ZEdjTWplRW1kL1BhMGxvY3c3YU9xNXhO?=
 =?utf-8?B?b0ZUQWdhaXgzT3BoS2NZd1p1UmF2YlZVdW0xUTQzcmR3T0NiY210eVhacmw0?=
 =?utf-8?B?Z3ErdmhYa1BiSFNtR2R3ekJGN2cwTkVGT1F4TkkxdTBRanVXRm5LdzI0VWoz?=
 =?utf-8?B?Q2xoL2YyWExaUDdTc2w3OFc0UEhKL041aC81Q0pWRmxCRU9vNEx2YkEzUHdI?=
 =?utf-8?B?NXpnVnVlUXRONXNHbmZPZlVqM2FNNWkwZjVscDV2OGp3MDJkUWxhcXNHWGNw?=
 =?utf-8?B?U3pCWUR0bHVlTi9Wak1wSVhjbmViNHlaczEwMkFCdlQ2cmp3Y1VLMjROMUJv?=
 =?utf-8?Q?sTdT3UCm8SknLe7c=3D?=
X-Exchange-RoutingPolicyChecked: tPCtzEkKnTO/jmJHclD+X+ERvW4Yt0Hxe4vaZUg2BRnR2tBYWQ3eoBaASZV8WtoWsXLqPT6NvYaAYRSOjJcgQHxrnWue8qGNP5U68um+sEmRO4l9uOrTsI8WRafoHPDNUzaRfuZ/JTDxCTYcoPFeCjifjG0nfaBATrQ3evv0IaSYxHY3qveRzlia4BnBdc1iNxiWcp5YvEhqwbZMmms/EUAkwSTpWtvtQjR8ULlieMDyu4mE+w/UccFopQGUgPbx/RZg+BZF4KIzEn/TjvKpktq1Vi6n8AZgNoJ7kz66SIcyla5yKrJRRhjEhcly199iVfG+osFS7BfABYQJOa37hA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2759e0-ca81-40da-39ce-08defde0008c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:52:45.9556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1q+QY3GP/zQeh4X2zMF8vK3fUIkRgIlXKnNIIUAva1f8cVMQhDtLAqOFKNI3WfPf7VnW2EtWHthhsOA5xG01h0lCYl2p++ihk/QTh1IRk9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5788
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

On 8/19/26 10:24, Petr Oros wrote:
> ice_devlink_nvm_read() rejects a read whose end lands exactly on the
> region size, so feeding back the size devlink itself reports fails:
> 
>    devlink region show pci/0000:04:00.0/nvm-flash
>    pci/0000:04:00.0/nvm-flash: size 10485760 snapshot [] max 1
> 
>    devlink region read pci/0000:04:00.0/nvm-flash address 0 length 10485760
>    Error: ice: Cannot read beyond the region size.
> 
> shadow-ram behaves the same. The regions are created with those sizes, so
> a read ending on the size is the whole region and has to be allowed.
> ice_read_flat_nvm() uses > for its own Shadow RAM check, and so does
> ixgbe, which grew its region support from this code.
> 
> Fixes: 3af4b40b0f2f ("ice: implement direct read for NVM and Shadow RAM regions")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 8c2b63eef82bd5..a52b6044288975 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1953,7 +1953,7 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
>   		return -EOPNOTSUPP;
>   	}
>   
> -	if (offset + size >= nvm_size) {
> +	if (offset + size > nvm_size) {
>   		NL_SET_ERR_MSG_MOD(extack, "Cannot read beyond the region size");
>   		return -ERANGE;
>   	}

Thank you,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
