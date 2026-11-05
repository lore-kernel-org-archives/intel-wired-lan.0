Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20238606A326
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5WE0coGF;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TZxmdwzH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED4778118F;
	Thu,  5 Nov 2026 17:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IT1IY_HFE72R; Thu,  5 Nov 2026 17:59:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 89EBB81150
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793901563;
	b=ajhn2F2uzLc6JuhmDrXBEkFRQ2FJXmzfhmQIm5CXGtumnFLC2vpWSohgDU8w5fbE3sPF
	 KdVteay1EgUdD+RMiUHgEjt7Hzl9eoZ/coO4SulKSkiBwrQC4X4vRoD8HHgtKFZNAumv1
	 B11b52pjOUBjOaM7ivIRiFSYHvm6WSKfSf3X1NUGKpHk6TbyqI46Pl5097qVs4yJQPoTP
	 Eml+mCedy0iKMJrtQedVWw5KJmldXk2fNdGTDy3WQ4EeXDMxan4rVIc2REGkHs58HKwyR
	 25ty+xhxd48tw45IwvQWOWZzGrlLFdfoJEuAKfCIDkKcHSI1syxAzDvKOqf0O7QuR0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793901563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=oi+vfDo3IbgA+S0lo64D94Z5lKVmCeQcVPmZB+SFP20=;
	b=rLCKlPOdyIIyEQOQc+s5L8+xx95MaHeVh77+JDwj7fvVHS2LiGKQx+cPrf8O6Q/KbKUg
	 Or95SrziIH7b+8rVA9HS/JfSXvyzDGqRpik71wn4wF+HbV0Iwth0VD1hrtSbTm5YS4jYN
	 nMvgUdcPDw1BtMh4KpqoNV3/pD7R8/DNbRCutgbYZHazfRz0G8PKMSydtTXSnfCHp26di
	 fljm2qoSLgP084wZNGji83sUwR3gw05LihKMS0PTNObvqS3JhkHuB993nVOAiqAaNRBDz
	 qD7Ot43q4bN2aUXLZs81Zv1siQ2OIfUK4XGZdiVOvkhfuq3b2A3asNdfi7Q+Eoj6CmA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793901563;
	bh=oi+vfDo3IbgA+S0lo64D94Z5lKVmCeQcVPmZB+SFP20=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5WE0coGFUUtNZY76wTa/W6Tt6jUf8B9H30ukLbstsTrQX58atO7V9qPPA1mnAcXXA
	 PbJJRqJLqfGgV+JtAstLarGJlcyjs964XHyjeTFiMdYyQtnLdVAbsSo7K/+HiVb4gM
	 kgRVuHqD6Jg/U1V7UcorziJb9tn+9M8XLKRW9TaE6AQTqO5uO1PyUUIl27u6U4gFiM
	 VVwNEyBPb/mbh4k8NwXMa4TI2RUCQGR0pkZs8jZpClWAmKeC4hQC/bR29ctEkDbSMi
	 Id2HnF9CEwRP2fnYs3Ggdp2K8ALt//CoYeOBTFGmSd1eSnRCo+GibAbiw9tZusgQ+y
	 RIqKBCIqzx/jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89EBB81150;
	Thu,  5 Nov 2026 17:59:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EE0B2AC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 17:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 003B440093
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 17:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LBbP5gyJmn41 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 17:59:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3029C40012
Authentication-Results: smtp2.osuosl.org;
 arc=fail smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=aleksander.lobakin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TZxmdwzH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3029C40012
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793901561; x=1825437561;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gOehMFl5L5oEOGwO7JS5sIrTd1xvI9yC9IyxXwRFilQ=;
 b=TZxmdwzH/4QSYqBRnTGP2MYOjdeP62ihwtpgwiVgDnYV5L6/YSIEii8Y
 2XNzKcvjC8ZfG1lFSWvOI5H47IZnMP3F91L+jbrCktH4w94eubV32yFKL
 uODvo9ThFiZ4+F/QAaWx3ryThTBAENOFJw85TNPWAM0nv3ZUmnZtDDYPa
 HpqWonZc+ERd6EI3V2pCLV7wnxT7H3v2IvZ9PzUF8IT5CqefvFSgKIsZ5
 jX5TB/vltrdRQUryebmFJ02WWS1+sPNIjEFMljqkrYWQVCWSJvEC7DgjR
 emPWJD02RDyKn7+h43VSQnQ5NLISg2jJsX4G37pOikY6BuRixjqSQ0Wcu Q==;
X-CSE-ConnectionGUID: bFyZ2La7Q/ezUfvK/Zi99Q==
X-CSE-MsgGUID: e3MjgbzmTJC3SemUhy9Sog==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2724004"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2724004"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 09:59:05 -0800
X-CSE-ConnectionGUID: DNeMEMU+RR6MsxSKzKeWHA==
X-CSE-MsgGUID: 5e5F/HJLQMypkgkCm+srYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7088775"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 09:59:03 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 09:59:00 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 09:59:00 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 09:58:58 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7571.namprd11.prod.outlook.com (2603:10b6:510:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:58:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 17:58:56 +0000
Message-ID: <253b8e81-825f-4d57-977a-7065d763b515@intel.com>
Date: Thu, 5 Nov 2026 18:58:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: fix Rx byte accounting for dropped XDP frames
To: <Dominik.Dvorak@econ.muni.cz>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>
References: <20261105-ice-xdp-rx-bytes-v1-1-63da7b5e3d76@econ.muni.cz>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20261105-ice-xdp-rx-bytes-v1-1-63da7b5e3d76@econ.muni.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0295.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 586d742d-332b-489e-45c5-08df3b667602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261026121527099003|11063799006|56012099006|261026140227099003|261022075727099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261022105027099003|261028144727099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: M0Z5SGGlbYY/gz4SeppPQt+hbNWOx7mpJPNMS/nGc8YpJmqmEbV/fQNTCro7iFZ1+md7VgGQCqYXwlvMmewUWT2/tJ7CEYjgUVwRWlGZm+DaO1bSTaNh8z7KSd5M1p4aFHSfwV5EhGLe+hREBLvGfHBnGpjqqkTsbTTBxDKhzxTydJVr0ZdM0ONnuJhGpmQOiJBgvMkjCaebGkchdDQxvheBTBd01IAG0wXvjrCUGAQgT9WclMwy96a90JFk13CJCi6ZMD+EUNQnyA1drqUDsGTkmuleiHsRgCCDFfzO7rA67p/NZzaMFDHJ9ksHovV5TlAybM0a2wD1Ar+9FgM/XTLQO9uJJ4+STkjjL2AB0GSzlwJ83fRcl/b/LFhJ90JYSfC9xDnfk4r+3Gxhc5qzZpZ5N/JcRgdPMvbSsdgymQm19UcCDp9/Do4SuAUZP48BiaaElAMG3qori15RwMFaWWMLvHA0zyeP+8b8fEPCud4SWgtaT8hvP615y4g6kgRretY2jhQBxsBs01WyQYG3xc0xdozZScsU/VlPFwNIOmEXqNog9txah5JIzo4tWR1Om4E7lkNqeB7kj79ZOeJdJDS0qGdVGay0ZOuM/79FM1M+ND+6rsAMyx0aIfRbU+Hx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261026121527099003)(11063799006)(56012099006)(261026140227099003)(261022075727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261022105027099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlpITkFNWVBMdU96cGtSKzlmbXl1cTk3Tno4MVpTR3ZONDlYeE9OYldCM2lS?=
 =?utf-8?B?R0F4UFQ4SVI3U3RaVDBKQnFRKzZISkhETFJFclRMckVsS2h6UFJhS21iSXpK?=
 =?utf-8?B?MzZqemRxcnZPb3pMZGJYVDJIVHpPbk1ZeGV0aHUrdG11L0FnZGtZSDk5S0JL?=
 =?utf-8?B?aExDSFBoWkU4OVNzZTVaaitFTmExSmE1dTYyUU5HZnNnNDNXM2QrbzMwSmJm?=
 =?utf-8?B?SHZCSlFEWXFKZkh1V0VwYXEycytHUjljb0NZUlkvYlcwUGhMOXVTb3BVM09n?=
 =?utf-8?B?bUpYMEtCcmNpSm56TnM1MWZKbjl4dm5lYks0TTdkMis2QnZYZ3ZuekZ0N3g5?=
 =?utf-8?B?bUlVbXEzT280ZTYzbmtqVGx0UFJiUGVDNHhISkVJSFh2V1Q0OU50N1hlayt0?=
 =?utf-8?B?WE81UVRIQWlkSSt0bGE3aWh5djh1Sm11UEM4S0k0QmdrbFVSSkNab3JTSTE5?=
 =?utf-8?B?WFdGOGJBamx6Nmo3dzlyem1Ma05JRExLTkVkWk1TK25yamlXbmJFaXg1eUNt?=
 =?utf-8?B?TklEQXZhUXV2N09CblBCTjJMcFBEeTIwd1JUSUZ5UmRjblh4a1Y5c3lqTHQx?=
 =?utf-8?B?NDdSS3RkdXNTanpXMTBoSjAvaURLMk9GMEtHcURERkp0ZUp5R2M4dTJtZWIv?=
 =?utf-8?B?blJad0JiNURhTENIeTd5NjlUMmdUVlhjSXRUYUU5WGxYem5FSkozWEVLbkg2?=
 =?utf-8?B?T05meG5IMW43UzVpSWVmc3Uva0RHYUdqT3ZWWlpLVXhIKzVBZTQvM0VXaFll?=
 =?utf-8?B?QkthRitaeWh1MU93aVM5WVB2bmQ2Mm16MGRMTlUwbHRoS0FHYmdpUkl4S3Z3?=
 =?utf-8?B?cnR5dHJzcStTWWJjdm51T0ZxSTdTam1EUVpZdlN6TVp0Q1NScFhIaUZXeXZD?=
 =?utf-8?B?ZC9oOGF4a0Q1WkpvZ2F6RXNEM3ZvOVR2Vy9nUXFiUWVhMFVtWTFLakYwaDJH?=
 =?utf-8?B?WFdGZmFiVEhmTlFrcG9pYVhVTVI5OEpUNWhxbGdDOGc3cUc2allWVUhvcmFx?=
 =?utf-8?B?VmY1VnY4aGV6NDBPNTVENGZibjhMbFZHQmdkbXpWRjl3TXFoV2pGb0xDck0w?=
 =?utf-8?B?QTFlNmVUaEdlekxmc0RBWVVqS2FjZVBSdDVDYnhGNDBLYVJ3bURKWERuWWt6?=
 =?utf-8?B?YXVwbm5YeWlPQjV0UTdBcmlsdW9ReFpRVVc3MUZ4ZmhWdFdDZmp6YS9TeWhn?=
 =?utf-8?B?d3J1V0M5K2svTVlOaTdSRzNid3lxN1lvVmJTaGFCTUVGY2dKc1RESEFHTURS?=
 =?utf-8?B?U1N4NVdjZlI3QmJTbUxDcmNGMDB5NDJQR2FYQlFuUUFSYS93WnAzaHlObjFo?=
 =?utf-8?B?dy90K3lrZXVHRldRbFBRY0ZpQ0lKYnQrR0hBV1I0U0Y5WG4rbSsrajZsUUhQ?=
 =?utf-8?B?L05pYURsaHp4TVAyRi9uNEs3TGl4YVdhZlpvVi9ORDcraHg3N2MrenVFbkM3?=
 =?utf-8?B?MjRnUENrVFEvL0FqNXlCQnhIaC9PbXExeVpZNkxZbDdrdCsxY0tvTk4ySlJj?=
 =?utf-8?B?WlpUU2NrSWNxdVlVa2VLeTBFL1JlUTFEV0xkQ3pHQzBZMkVYSFpCZmRWK1Jv?=
 =?utf-8?B?UHlwbDBhWFJuWStoeWhlT0tDQytIRUoyUUlEeGV3SXpHbWJ3ZVBCaDRnUTkw?=
 =?utf-8?B?eUxta042SEJtVWgyZnNhbi93STlZejhOZUFZN0hzL294OUh5QWFaa21WRHVs?=
 =?utf-8?B?cHBLY1dHRE1ITVFUNUJDL3EwczkyaXdwSFVFMGFiOW1JSzQ1MHFiblk4UjM4?=
 =?utf-8?B?SERIMEhuTGc1N2hUbjJRem9VQ0dqMS9CMXNlOFd2RHhDclIrenB1Y0MxZHo5?=
 =?utf-8?B?SXE0MW5md2FwZXE4Y2lMYzRoaDJ6TzBlVFVtNVdWajNjeit1V29JWml4MHQz?=
 =?utf-8?B?UnJwNVl1VEFoeXJBSnNxWk5LNHNEWGN5MzJIZFdCaDU4b2paaDFjSjNucjRh?=
 =?utf-8?B?WWtyTjJlRHp6bUp4YUtGNGo2Q0M4eVEzWE90RW1mVjJFWEE5NUtJeWkwZjgx?=
 =?utf-8?B?Tkwzek81SzJ6RTVRMFFsNFV2bXRleDZ0T2UwV0wwa01YaEd0QTdlTGhnVHps?=
 =?utf-8?B?ZFpiWWFVNjc2UG52SE1vMUY4Q0h1bjR2S0RiZVNMUllPSFBkSnp2cmtqN3d3?=
 =?utf-8?B?YU1sSlovOTdKUEN5dlJIcHB3WnJvdS9GeTVKNWNSSzROcEY4cTJsU0x1LzJB?=
 =?utf-8?B?dVR5eXN4S2FrUXByY2pLeTBWOXBFRjIzUWN3QWR0TXZGanBETmpKTTZhY0Rr?=
 =?utf-8?B?bytTZFF5RzBYNFBoOElTNWNPaFBJNkFYMzRIYVZRUjl0VzQvZzBUMEdKaE5U?=
 =?utf-8?B?TGEzeHhoYVlZbnZRcEE1K3EydUg1ME05dWJHMXdUeTJ1QVBjMUJMNll2RnVX?=
 =?utf-8?Q?XAglWjPG5nXUQK+Q=3D?=
X-Exchange-RoutingPolicyChecked: OHfVNoTNHie96OlLYZE6X81AwSSl24kdivH1tl0vy2vqEjR4fmBVEpQswzUxvZ4sjDtUGlsCukoZnTrui5qQdTPfcFr0C0KpZwEGiywmIrNJ0VEExJjrtfbZBMkIpO51kNUxAeRFfycW6oQ7EZVTebcNQiqs0y4RnxQtLjNDJekrVXaNwNWStKPU6kLi/xE2aSuziggfTvzgZ2E0bvu6vXihqDrc3kl6AvJXKBpgh/FNj+z0fi74VodcgXqI0t3dfgalpj9frvT4GTAxVkUR9+ma1s2NArOSuDKspR62pLt7excaslVi6YRkypOp5JsN5DqQ2kSH4q49U7kU2fzZpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 586d742d-332b-489e-45c5-08df3b667602
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 17:58:56.5070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwccNKc5GHGCYSXeGa3rlSg9YFt/6mQTN4eJ+p7vBMvQI8vnXIsVxHK2yGz0CM12I7n7baBYZDtFKZ45JDQkxYNabUl0faJSVoPrxzoaVOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7571
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dominik Dvořák Via B4 Relay
<devnull+Dominik.Dvorak.econ.muni.cz@kernel.org>
Date: Thu, 05 Nov 2026 14:21:15 +0100

> From: Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>
> 
> Since the Rx path was converted to page pool and libeth, ice_run_xdp()
> returns the buffer itself via libeth_xdp_return_buff() on XDP_DROP,
> XDP_ABORTED and on a failed XDP_TX or XDP_REDIRECT. That helper also
> sets xdp->data to NULL. ice_clean_rx_irq() then calls xdp_get_buff_len()
> on the same buffer to update the Rx byte counter, which evaluates
> xdp->data_end - NULL and adds the low 32 bits of a kernel address to
> the ring's byte counter for every such frame. For multi-buffer frames
> it would also read skb_shared_info from a page that has already been
> returned to the page pool.

[...]

> Tested on an E810-XXV (7.0.14 kernel, same code as current master) with
> an XDP blocklist attached to an 802.3ad bond: without the fix, each
> dropped packet added about 2.5 GB to rx_queue_N_bytes; with the fix, 40
> dropped packets produced no such jumps.
> 
> Fixes: 93f53db9f9dc ("ice: switch to Page Pool")

This might need `Cc: stable@vger.kernel.org #` with the minimum affected
version, so that it will be picked for backporting. Recently, the LTS
versions got Page Pool conversion backported, so this fix is now
applicable to them as well.

> Link: https://lore.kernel.org/netdev/DB7PR03MB460158B90A64D025962670E0D5772@DB7PR03MB4601.eurprd03.prod.outlook.com/
> Signed-off-by: Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>
> ---
> Based on the stable v7.0.14 tree, which is what the affected box runs;
> the changed code is identical in current master. Tested on that box
> with the fixed module built against the 7.0.14-26-pve headers.
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 4ca1a0602307d076153f77671e8c9a6ff4f8dd28..f62a1bb7bbca579b43fe2f4c8e1946e65b5cea63 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -968,7 +968,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  		union ice_32b_rx_flex_desc *rx_desc;
>  		struct libeth_fqe *rx_buf;
>  		struct sk_buff *skb;
> -		unsigned int size;
> +		unsigned int size, len;
>  		u16 stat_err_bits;
>  		u16 vlan_tci;
>  		bool rxe;
> @@ -1028,13 +1028,16 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  		if (ice_is_non_eop(rx_ring, rx_desc) || unlikely(!xdp->data))
>  			continue;
>  
> +		/* ice_run_xdp() may free the buffer and clear xdp->data */
> +		len = xdp_get_buff_len(&xdp->base);

I would simplify this further: add this to @total_rx_bytes and increment
@total_rx_pkts right here and remove separate accounting for %XDP_PASS
below which uses `skb->len`. Both are +/- equal and since here we need
to call xdp_get_buff_len() unconditionally, we could update the stats
only here.

> +
>  		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
>  		if (xdp_verdict == ICE_XDP_PASS)
>  			goto construct_skb;
>  
>  		if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
>  			xdp_xmit |= xdp_verdict;
> -		total_rx_bytes += xdp_get_buff_len(&xdp->base);
> +		total_rx_bytes += len;
>  		total_rx_pkts++;
>  
>  		xdp->data = NULL;

Thanks,
Olek
