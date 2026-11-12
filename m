Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638D606D561
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=X7rrJGFE;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mx21cUE1;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=S2+uoaF5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E4A840B39;
	Thu, 12 Nov 2026 14:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 27QCiIxOb9SG; Thu, 12 Nov 2026 14:22:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 49CC940B16
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794493331;
	b=abaYQ5GzwH2/zI0oVkDOMzE0M0SdabzET+4MfUn88MAyr5WcU9W4drby2jQtsMVtyrsD
	 HV8Cy55Ekf8qaJ2iSIjDKwF0VXBjFiT65Urot/H+MBvTLai27r6ZTvBsMiCDIElkhm/4j
	 TluvwxueKrWZ1Y97XfvBxfUGpj4L5UXfstqL5UIHnxRSW3ZcZPuDL/+ICycocT+swlJ3n
	 GUIdU6KyZs5YodMXMMiRVQnr9OQv27G7jcGp5stCBQtRlISzPQQNN6s7LDLKGMJ9kRd2K
	 rKZ4TnC2PDyCND0emk/WwozI+J/v1iFQlhyQkVUhT+9ZRlBIF6D0Ix8ZkdE9w1VvXGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794493331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=isGgluWijRVbNy48YicCH0auh5Jb+EEdUGwHHApsAcU=;
	b=HUL68jtKWIkLReU9vaVDig+esrWKVnyiLy1qWxsp8a9IcUsPdFM73xikjQcU4IeRbjV2
	 TeKktqDDpihiHv9X0EU/HB1IJyB71NulgILxkoIvM2Z/ME/PUHANYUY4It4v+neJfMJeb
	 ySx2u4G+6sXbQjEEPWf37rBR0aDKwINRkMPy+Fdp8JXjnQ5Cb815RtvUJZE+UO+tb7JZi
	 NGgKt9UZ5GnAJ+3l2TaraM3vJgFSe29LUVtQ3kZZ/lWv5J9TSJWvZjNUzOFjkvHEx5fuE
	 cY707zLLzQTPbJPWnP7ERvJAECPnvKUR2hLz+l3iH7SWrZgaDPfulLtpCcde4RbJROA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794493331;
	bh=isGgluWijRVbNy48YicCH0auh5Jb+EEdUGwHHApsAcU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X7rrJGFEZlqXuRY5GBQrvguoQjzTxTT8c1Lnc1eM/W+0rH1pzmVk1oPrr/Z9G6oQT
	 pEKeDHBiErbEFHg/VcgTTAecDyOagZn3rgc1UIjyu4oYfKaeOscXVLO8rx7qPWHSI8
	 bpywCOsDBKTOC2tYvyeJEpw03Z1zIqwYZsWBX3UyMRnNTabPfoiBVMdIV7R98YDoAg
	 TfZi2roazu5DBfNG8OwKfJra/wB5ViuKCF81cFi9MGDj8QlcI29tIQwnSmjMdm/3bB
	 +n/FKxp/j6zReUY9elORitksDqcmCdT45l9N1eyvJPgpQcA2ss188ePpnZJ8p2/fhr
	 9ZM7YQjcMCKWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49CC940B16;
	Thu, 12 Nov 2026 14:22:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF7ACF46
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 14:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4E9B814BB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 14:22:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id llSNkvPr9O_p for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 14:22:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 30C0B814BA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=dima.ruinskiy@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mx21cUE1; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=S2+uoaF5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30C0B814BA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 14:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794493328; x=1826029328;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l/AH6AOu9yNbTgWZTswIDC+DUS+mDKqNHmx+vb8zbZ8=;
 b=mx21cUE19jtfnGxlQg2oA98yUjKApxGQKNMXZEHnmn2EmN57ALkIo15H
 YvQgyPkfL5rN0/Sm4EiyiU23IOOOZme/FhAe6e3NeL2f3NIgNFlvyJEK3
 c1lzmOX82SzBJMwjhKtUC4zmT3DrMVUIex6EibHP8SMM+muu7FY/E9QAn
 DnIqllmrKguXFT5Ax+IaFpdVMNCLBuGytFJI1F3rgJH7XG2drZibo0aP1
 5AkpF0HUlPDasYqNVRqCkUR6FZJAKc+RA5bUtjIJb1VNHK7uFTaXdkAiX
 hA6cmHtP0cvTzMfinm+UGKiAeECYmmXUGqK/KWANPwvZbUCfbcmsn/ndv g==;
X-CSE-ConnectionGUID: xvIOx7uwSNG/cX0S6pY35Q==
X-CSE-MsgGUID: wFg0aophTjOm2ZPo5pvUAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3304912"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3304912"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 06:22:06 -0800
X-CSE-ConnectionGUID: ERGGdjpSTHKLkw5rle8WNw==
X-CSE-MsgGUID: 0kB0RzUgTUOu9sV7arCOfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8564126"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 06:22:07 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 06:22:06 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 06:22:06 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 06:22:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isGgluWijRVbNy48YicCH0auh5Jb+EEdUGwHHApsAcU=;
 b=S2+uoaF5MkEFk8+b93fyf6XZzo+VjuDy4J5aC0kcG225Hns3BDWe4vvbzSoEL4rP4hyI/mqSwfonZy9ZpHcMBaynZkGiVdgWRY93Mufqv68MKIorzZ8DX6sfDOPVm6jX7Esu/UW3ZC/0kMe4yEYY7w1pSGSyexiUCYAPAOvkJhQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 14:21:57 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 14:21:57 +0000
Message-ID: <87fa6cd1-9a98-4c9b-aab3-6ac782c413fa@intel.com>
Date: Thu, 12 Nov 2026 16:21:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] e1000e: I219 with jumbo MTU: RX CRC errors for unicast DAs
 not in the RAR (promiscuous/bridged ports)
To: Andrei-Alexandru Bleortu <me@andrei-z.com>,
 <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Vitaly Lifshits
 <vitaly.lifshits@intel.com>, Sasha Neftin <sasha.neftin@intel.com>
References: <20261023222252.2528909-1-me@andrei-z.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20261023222252.2528909-1-me@andrei-z.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|DS7PR11MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f88db40-fa4c-477a-74da-08df40c84f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|6133799003|5023799004|11063799006|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|56012099006|261021123027099003|261021121427099003|261021135927099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: QPZ0MATskQDGb6KvpJMQdwPjP9VPc/qE05f0zAkLcAbZOTL9kzXUSiX1TDzgctpSSimb7aLM7GCESaaQ8c/MFPgjNthNRm6WHjjsQ2ov4VnS36OuOvIipKyJGyRNsIOrL1SQ9Z1jtzBHE58t4gKF1XHUZAL1W3UladVnTMReO4hDFxPQyqbBDx4Sge8GynK4y9P5Hkbv7G8Af3u4kgVLloRq/pr22wDnLOpnB2TtrgneZ37n0k0GnoklzNjZnjccvVy3rFKUHqln+td67PIqJNUBV4d2VCga5UflQVlRi8hS3kvPdYkv/sxFAo94l8Yys3NISGszL5H6fTtgEN1j++fU7jg/A59TAYTZBVD7lj1kadG5jJosJpCmw3u6C/2oELv7WJh9NODKQeZ8+pAZZKBUZgSfbEva3SisX0G2O5QqhonYJA2RnVLmtv3oZcMZ7Z5UgE28h5n0qBVU9qyDto7FejGU0kJMOaQXyNASxU+GbD06/VHE1d0u3noEuRTzpeDexpHSJhjkCgPgsefUo1gQw6JEnKQ7IiEkcH1UhFYRYKDBAYTYaDwibM/HrMy7Jzd13fvecUxQlgPi6qJ+zf+LTZfEcFcoiTb95SRlpqQfGPJyMmvIX8NCD1c2rvT9oJPnv5k1qMnu6knndhEGaZiyfBm/lWZ2PgBop7eGeyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5630.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(5023799004)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1JJMkk2c1VITjBaS1p3SktTVW9RR0FrWSt1MU5INWxVdmlWblJ1N2JvNHJD?=
 =?utf-8?B?Y0FLNlZDKzl4N2ZHQktWdmZ6R25uT1Q3YWY2OHNXZ2VvVkd3ZTFzYUVSTTdD?=
 =?utf-8?B?TGVoNm5ucGFLdzg0dmF2bnluLzVCRDA0Nnc4SllRN3U1RlcyaTZ6RkRJTWhZ?=
 =?utf-8?B?MWpsbUFWSFBXRUtnSVhhdHVBdjZEN3ZTZmRpcng2RDBBUHhXa01UMG83Y2ZJ?=
 =?utf-8?B?MVJ1UlJMMG1GNUd5MHcvTWZXbkVRZXkzR1ZiTFpIR0c2ZWFqMFdMRDhrTTFK?=
 =?utf-8?B?TXVENGswZGN6TGRMSGVTa2wrOFE4SjVRd2htSXYzcWJkK2RsNUU1KzQyK0hm?=
 =?utf-8?B?WlNsYlhwVzdrbEcydDFnS1ErR2lpVFFtT2hOWG9mMnczRDFXb1FDU1RmM3pp?=
 =?utf-8?B?QW1FelplWE44b2dRQUE1dHIwTU5yb0FEbTR1cUp3MERRTXRWdFh6K0ljOXM2?=
 =?utf-8?B?YmswQ3JHa2Z4NVEyREJQbGdlOU5DaXRYNFBneWtubHZSbVFNMHoxbDcrWnRX?=
 =?utf-8?B?Zmc2ZGsyeWY0S2c4SnV0aHpEbzhmc0hZc1J1SDVmcENLakVMeWIwZC95MFMy?=
 =?utf-8?B?VTFvTS8vbWZCM3RXMndVTnBVTnFXTWMydFZiWnpZYmdndG5WUGhMTkxIbDd3?=
 =?utf-8?B?c0xrdFAzYUw3V0V0bElYUEVncGRVakV4empLM2o1NmVZUTAzY2k5SllSNTZw?=
 =?utf-8?B?d2g1L2l3WlA3RVpxTWFiS3lSclZKUVdwRnNyL09NMmpxdkJMSHRUZE1kMG5Z?=
 =?utf-8?B?aEt6WW5qRFlCNjVVdWYwdm5DU0tRdExhTHhya0QydTZzcXBLK0Q4alBPK3Z1?=
 =?utf-8?B?b2RwdWpKK2xQNzVJd2x5Vmh3VkcycmJMeWwxcGE2MDJlaG9FdVhtVmRHYjM5?=
 =?utf-8?B?VFRZY2Y4M2FYOWFMWVRiQzA0MmU1YUFFTFB0UE40V2VBQi9nWUg4RTZIZkFn?=
 =?utf-8?B?UDdraTlBZmkyWFdtVUFxb1lJNzcweUZIa2ExcTAyc2FLV1kwWDZ4eC9oRWl0?=
 =?utf-8?B?R0FHMFhXT3VxS1E3MXhRT21Bb3Rlak80U2pKSGZDVG9tcG5STWFDNkVrNjRI?=
 =?utf-8?B?NmtXTFptSDQ4Z05pbHVROGM3U0QxNHRDOHViaVFmNTFzc1dSVWFHcWhjMnZJ?=
 =?utf-8?B?RHdMYzVJR3VHb0JxY1pkamJJZXBpejBuRnI0N0pxbTQ1MUVHTjQvWlhmaGRL?=
 =?utf-8?B?L0NwSHBnRnZKenNUTHFGNlcxVUJGR0dYM0JoUUttRkRVeVJjbWNYN1hDRUZp?=
 =?utf-8?B?OHhaV3dLVUUvcU1CeWFXUDZaQVBwajlacGlJQkcxbmNxSTNEVU9qV21aNlY5?=
 =?utf-8?B?UlMyc1ZOQ2paN1BUMTlxM1N2OGEwODYxMFBJSElhSmd4aGpIZlIvMzZHRmIz?=
 =?utf-8?B?bDJHVHVUbWo2U0xCdGhQQ1lMRkRoRGVHdmxRaXk5ZUxCWVFxb2N4ZjRlZ0Y3?=
 =?utf-8?B?SG1kaE1SU3lVZzU1VzQ1WDJ1dHdJZXhqQVdUdnhaWDhQQkVOaTZjaHdQSzND?=
 =?utf-8?B?ZUZKaHErU1pwTGJVZzZiYVVNMWY5SmhWWnJvclJ2ci9jNiszOGtEaER1cUhx?=
 =?utf-8?B?QmIzRnRvZ1dqZlNNa3lrSEtUTGF1ZGFxUGdFUFNjUk8xdUV0WU50QnhsSG1x?=
 =?utf-8?B?bHgrVHErTzA5R3FKN3ZQbUxwZzNkTmVXd0VrTDB4M3hMSzBDYmc5OWhhcHgx?=
 =?utf-8?B?VVhHd0ZmNGE5MC9ld05KZXJuQTB5ZWljVmF4bGV2alNWQkZlYm5Ud0hnemJO?=
 =?utf-8?B?OUxIODdGS1pOaDNTZ2Q2L2VpaytJVnpZcmNSN0VzOGhzTjJVUG82eTZtU3Jj?=
 =?utf-8?B?MkJtWnY4SlREYUVrZjREYVlIR1oxNU1Zazk0NmdRaEthZWVuVWdyTE5sZXRw?=
 =?utf-8?B?SG5BUFJGTmo3UDJ2TGZQSDl4WHd0YmdGNGdWWUx6bXJwaW9TTGNOY2lvejdI?=
 =?utf-8?B?blJMV202Z21kZ1VyUHRBSGV3VDJ6eklXd1lTa0dHdUJaWFArdnpXTUxlSE42?=
 =?utf-8?B?MVl1bzltYWdqOGdvb0N2alFIbDFtNGY2R1ZzVEFnWUoyQWdsMjZxU2VBeGVV?=
 =?utf-8?B?WnpST0dzRnlQNHlRTFlTOEd0ZEZmS1lmQWVreG42TUxtUFc5ZFN1UUpuOFBo?=
 =?utf-8?B?U1FURGNzYS82amhkTEJad3RLK0Z5ZVFrUU55N3NDaVhHYTI5NFFTVFBVOExi?=
 =?utf-8?B?YmZHenI1WWZpZEZFOXBTT09ubHhFMjRqRnRzblpVcjhPYU0wRHhXdmJTYWFr?=
 =?utf-8?B?dkRpbWRGaVNnaWh6VjVyZEg3cHhRUGRyN2pyQUlGUENNMmdDUnhRRzZGN01p?=
 =?utf-8?B?NjQ3UWNrMnZGNHplV1gybXoyZE81N3duSUdZVnpYK1lmTklYRUFsbmlxemdp?=
 =?utf-8?Q?1GRSwZaMAJZd0mEk=3D?=
X-Exchange-RoutingPolicyChecked: rBkDnxD9b83WRJycnufOkI3JFmMLD6PVvGlpWrQuMNLfz9fFuSDvYg/YOi6Iu+FMES2YlfkadQWgOTx0dRZLoh5FYN/eMBr7Bo3ELVqyGcXAvjgUAsoEd5u81aet4RkZBcMXYBS4vttr7DbtJEOPrGz+q5rceWvcvuVoFE0h9Qz7zRgkd5CANtxSdHAsI+/ywLkeoZ1sOeSlZmUfkusP1lv2w9bixlevYrRRw7bdwJmDKAx1ZPC0KtrRqIgxHvnMgb2rIZZpgpJu+jN67I8t33Ny0jnFFixkIpkikMgolpMJta4j1Zuaz8SrIhWOS8jZJ/jxb8EzbcWCGmFoRBhPXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f88db40-fa4c-477a-74da-08df40c84f0d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:21:57.5211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icxLgwSxXbgCtHZd2h4htjDJ3iAkyaDBcGQ5zdWzPFWKGqoD8kXEggIVtFveeqfyWtuMHv2SumFUZK9pHeQkeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/10/2026 1:22, Andrei-Alexandru Bleortu wrote:
> Hi,
> 
> On I219-LM (8086:15bb rev 10, pch_cnp) with MTU 9000, frames addressed
> to a unicast MAC that is not in the RAR fail with rx_crc_errors at
> roughly 0.1% of frames (rx_errors rises by exactly twice that; the
> length and alignment counters stay at 0), while the same stream
> addressed to the port's own MAC is clean. A port enslaved to a bridge or
> OVS is always in this state, since e1000e_set_rx_mode() skips
> e1000e_write_uc_addr_list() under IFF_PROMISC.
> 
> Hardware: Dell OptiPlex 7060 (BIOS 1.32.0) and HP ProDesk 600 G5 Mini
> (BIOS R22 02.24.00), both I219-LM 8086:15bb rev 10, NVM 0.5-4. Kernel
> 7.0.14 (Proxmox); e1000e_set_rx_mode(), e1000e_write_uc_addr_list(),
> e1000_rar_set_pch_lpt() and e1000_lv_jumbo_workaround_ich8lan() are
> unchanged in net-next.
> 
> Setup: lan0 (the I219) is an OVS port, so IFF_PROMISC and RCTL UPE|MPE
> are set. A VLAN device on lan0 carries the host's IP with its own MAC
> (different from lan0's). The sender is behind 10GbE switch ports; the
> receiver's switch port is 1GbE.
> 
> Test: 1 GiB of TCP (ssh, MSS 8948) pushed into the I219 host, counting
> rx_crc_errors before and after:
> 
>                                                host 1      host 2
>    DA = lan0's own MAC (RAR[0])                  0, 0        0, 0     per GiB
>    DA = the VLAN device's MAC (not in RAR)     438, 429    416, 417   per GiB
> 
> Workaround, confirmed on both hosts: giving the VLAN device the port's
> own MAC, so the host's traffic is addressed to RAR[0], brings the same
> test to 0, 0 per GiB. Frames to the MACs of bridged guests behind the
> port cannot be helped that way and remain affected.
> 
> All of the following are needed. Removing any one gives 0 errors:
>    - frame size: path MTU 3000/5000/7000/9000 -> 0 / 0 / 80 / ~370
>    - back-to-back line rate: the same jumbo frames paced at ~1000/s -> 0;
>      the same 1 GiB from a 1GbE sender through the same switch -> 0
>      (only a faster ingress port drained into the 1GbE port produces
>      minimum-IPG back-to-back frames)
>    - a DA that is not in the RAR (table above)
> 
> Not affected (each tested, no change in the error rate): CPU C-states
> (holding /dev/cpu_dma_latency at 0 -> 380/GiB), the disable-k1 private
> flag, GRO, cable, switch EEE/jumbo settings. rx_missed_errors stays at
> ~0, so this is not an RX FIFO/descriptor overrun.
> 
> My reading of why (please correct me): the I219's PHY-MAC interconnect
> runs at 1.25 Gb/s 8b/10b (datasheet section 2.2), i.e. no headroom over
> 1000BASE-T. e1000_lv_jumbo_workaround_ich8lan() copies the RAR into the
> PHY (e1000_copy_rx_addrs_to_phy_ich8lan()), seeds PCH_RAICC(i) with
> ~ether_crc_le() of each RAR address and sets FFLT_DBG; the PHY register
> fields described as "Crop ANM DA Jumbo" / "Filter on 1Gbps ... jumbo
> fix" suggest the PHY drops the DA of known addresses to gain bandwidth
> and the MAC restarts the CRC from the per-address seed. A frame whose
> DA is not in that table gets no crop, and back-to-back long frames then
> overrun the interconnect.
> 
> Two consequences in the driver, from reading the code:
> 
> 1. Under IFF_PROMISC, secondary unicast addresses (a VLAN, macvlan or
>     bridge MAC on top of the port) are never written to the RAR, so they
>     never get the jumbo fix. This is the case measured above.
> 
> 2. Even without promiscuous mode, e1000e_write_uc_addr_list() ->
>     rar_set() writes only RAL/RAH (SHRAL/SHRAH), while PCH_RAICC and
>     the PHY's copy are refreshed only in e1000_configure_rx(). An address
>     added after the interface is up should have the same problem until
>     the next reset or MTU change. (Not tested.)
> 
> Possible directions, if the analysis holds:
>    - while the jumbo workaround is enabled, program secondary unicast
>      addresses into RAR/SHRA even under IFF_PROMISC, and re-run the
>      PCH_RAICC + PHY copy whenever the RAR changes;
>    - for DAs that cannot be in the RAR at all (bridged guests' MACs, or
>      an ME holding SHRA via FWSM.WLOCK_MAC), is there a hardware way to
>      sustain line-rate jumbo for them? If not, a one-time warning when a
>      jumbo MTU is combined with promiscuous mode on pch2lan+ would save
>      the next person a long hunt.
> 
> I worked through this with the help of an AI assistant (Claude); the
> numbers above were measured on my two machines.
> 
> I can test patches on both machines (Secure Boot is on, so that goes
> through a MOK-signed module) and run further measurements if useful.
> 
> Thanks,
> Andrei

Hi Andrei,
Thank you for this analysis.

I am vaguely familiar with the limitation. As you correctly observed, 
there is no 100% proof solution because of the promiscuous case, but if 
we can achieve a small improvement with a risk-free driver change, I 
agree that would be a good idea.

Would it be possible to ask you to run a few additional tests, if you 
haven't yet? According to the current custom, the proposal is also 
AI-assisted.

Test 1. Add a secondary unicast address while jumbo mode is active

a. Bring the physical interface up with MTU 9000 and confirm jumbo 
reception is enabled.

b. Confirm the physical interface is not in promiscuous mode.

c. After the interface is already up, add a VLAN or other upper 
interface with a distinct unicast MAC address. Make sure that address is 
added to the physical interface’s unicast address list.

d. Send traffic to that secondary MAC at the test rate. Record CRC 
errors and whether packets are delivered.

e. Keep the same configuration, take the physical interface down and 
back up, then repeat the traffic test.

The useful comparison is live-added address versus the same address 
after interface reconfiguration. More CRC errors before the restart, but 
not after, would support the stale-workaround-state hypothesis. Please 
note if adding the upper interface unexpectedly puts the physical 
interface into promiscuous mode; that would make this a different case.

Test 2. Change the physical interface’s MAC while it is up

a. With jumbo MTU active and promiscuous mode off, change the physical 
interface to a different valid unicast MAC while it remains up.

b. Send the same traffic to the new MAC and record the counters.

c. Take the interface down and back up without changing the new MAC, 
then repeat.

d. If convenient, restore the original MAC and repeat the live-change 
comparison.

Again, compare the live change with the post-restart result. This checks 
whether updating RAR[0] also needs to refresh its CRC seed and PHY 
address copy.

Thanks!
--Dima
