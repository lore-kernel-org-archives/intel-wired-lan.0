Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A1606A31B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3lSd+sqw;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eQo410Nx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A8176088D;
	Thu,  5 Nov 2026 18:43:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o9ktbzmOvfuD; Thu,  5 Nov 2026 18:42:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2E9F607F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793904178;
	b=anw4GtFR643nad9c+Yi+hi86aqCkeIyyNdxysKrEylV18KA6UkDJLbsldEyHsyHELS9a
	 WrADWauMtb/p6A7yikSv5pOdi2zwm3YKc7l4NDr/3+VX2DNRbvFJ8DlhJPyxW1Ph7qXVR
	 LNUOGLaO4Px39DbdNeuPIZcRyB6yobts9GOmReN8d6hvht9Psc0tpP4v59sIBt1BiM25U
	 jehT9GKznC9+wYsy2XKzgok3uXK9i1pr+oyqLZuFC8GmNeOLUFABcVzy2uV9yf9fkaYcR
	 TL+ZA9Iqt2rwqXuya0h1iJWVTohHLqIEPt1AFL0DiddVmTxF/nNBRNY0lb6n0NfY3uA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793904178;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=9SmqEGdP+631kB6PBZJ2mtBtf4cfHY0e9UYnCq7R/ws=;
	b=WNRNm1OuZ/MLvoCwDxye7YzFgTfzrtLW/5VA/KwWD2l/S38WSV3OBagTX7YxRvIMImDJ
	 FY0EZ+U5+ZgdcBRpOEKJL57uAZTtrHjnzqfEICzhhYO58YrWFPhCsxe5PmbJtzkj1HAAq
	 lwjN874unbjiGwqaKLJubIRTfspEpIxFUeKp0AbJtiICqD3qPiIczJCJpVe0Ganh/VEDs
	 H3n4Uaw3ILSFb8lcccdzm0GI4DileoI5ydkNscCCjupPNIlYpfauo+L4dQaVo2CXFt/qR
	 HERskPX8JiKBGWBUvtSdBlnN2Kq6Rv+5Pz4Efn7OiMkqiNDYpmxOQxmlGnYXTGg+m9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793904178;
	bh=9SmqEGdP+631kB6PBZJ2mtBtf4cfHY0e9UYnCq7R/ws=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3lSd+sqwaMepBE2vBib70ARaQ7UwSn9+8NKTQ2eHKgltHwjHcruA6oNeYqXYz8fN8
	 4J+drh65f/Pr4vJjTsZsykR2VEahXK5r75q/aMkIkigs+YVD1HxzQI033mxxuEdUR/
	 OOfRRmsl/QdHbQJsuXkCurGyPyhXXsXc0GWjnrkzdEhFMb8gsQNGwDKpGwQ+GFTyPB
	 OThYlhk6cmwvcVsjTC2xnk+NxsGHx4kvKocmr07K/aiijdTb1GKCOjU8ijI2RAeK1Q
	 rd+HfkJtEwcy+h/bV8G7ZLz/D04yWaqZOSHVBcojNQ3X4SN9NzPYIlO589WFN7c7Po
	 j9AhULO12Ok3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2E9F607F7;
	Thu,  5 Nov 2026 18:42:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EF00EB7E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D484F407F5
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:42:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qwVKkUS0cIfe for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 18:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4E1F1407CD
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eQo410Nx
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E1F1407CD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793904175; x=1825440175;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=znfnaOn8E+yX6aGwPPgMdewTSeItM0Hq1pdhwn3cyvQ=;
 b=eQo410NxCGi1XDixZ8mCABCurLANH6EXtmjFUqdHB9X4B/2n97DnRpWU
 8Yq6LfON9mpjbWkn1fZ6hsAYgbL9oC3dbDNbEeUCJIwWKMkNOisWcucEq
 XDd1Du3uJRyFFsCBqWrJXeEtme6vICMpV8+QjPMKlXCCrLNDGI+E4i4ay
 UYW/3Jo3/qmZnSy0ERk9s+WoQXdh7z7Uk2DwDGHu3q653jyIfe+OV0JU7
 /2qYs7gDNTYBOR/duW+qrVmvUnxQe/jdFTS+nQLVYWz63RM9P2i4HiLZR
 b4ye9/aL8z+2njEbXWTI4qCUIEdUcBXf+xTjz1sFrboq4OqsZzQVn1qRA Q==;
X-CSE-ConnectionGUID: X4y1B5xDTj6ULGQj4scbKQ==
X-CSE-MsgGUID: YGBQ5xwkTnaOMqd5Knz/mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2578808"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2578808"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:42:54 -0800
X-CSE-ConnectionGUID: 7KMfpjOISpWWpyeOi2wqfA==
X-CSE-MsgGUID: t0J6LnuJS82XqhgN+rtuSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7400097"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:42:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:42:53 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 10:42:53 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.19)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:42:53 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CH8PR11MB852307.namprd11.prod.outlook.com (2603:10b6:610:32c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 18:42:50 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 18:42:50 +0000
Message-ID: <15958f48-e342-4563-903d-db044c6c0db8@intel.com>
Date: Thu, 5 Nov 2026 10:42:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 6/6] ice: register LAG event handler last in
 ice_init_lag()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Oros, Petr"
 <poros@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, Sashiko <sashiko-bot@kernel.org>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
 <20261102105346.30739-7-przemyslaw.kitszel@intel.com>
 <CH3PR11MB566895166EFE8B499CA2AA74AFE5692@CH3PR11MB566895.namprd11.prod.outlook.com>
 <3a4b6204-fa1d-4052-a5ee-c0c056b0e3de@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <3a4b6204-fa1d-4052-a5ee-c0c056b0e3de@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:303:83::12) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CH8PR11MB852307:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8156a1-abdf-4bbc-4408-08df3b6c97b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|10067099003|56012099006|4143699003|261022105027099003|11063799006|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261021123027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 9rFKmgTEiSgB4hhm3kdFbWGkT0vMmq+Q77dXxkHBl+dmiZBEXUTEKHJ5zzdIsydWnxdgOKjq7HKjSzjzhU9po+RT2eTya/k8qLWqLbinIfUhh9PWVCpgigGnJ52rmdJjE/Ir3Tx9UDTFD1ASapSv/JcEDafVTf6B0Y5Lk2wQaWBPrdx+YtPeYpKNEg5JlCA8G228MFL9SbFjk3ATMBOXtW6dK+DqZ24so7RlgExIiEzwkEjXChI0EZ/0oNmZRhPakgoohmR9eu6r+eiCzxFgmACGCrA+CVyEouq7xWQRWtTEYEwL6m8eu4P4EzzozjguRjd/5NvL07T9dXDQqvypP6BOjv77lJb7/4SDP1YxCdRblopg8c7yV3gwDiSAefJ8d2XDsPju6nkyKtVDiMHjhHylcJr5l32tKwgMfDic32psenLFEeivgjcPI47g62tRduTnSZ/EqGZEwdCVplWenRRGcg4jhom3+ReoxxOz7FvP213roLLROhToSmW+TW1kC75Qq4AvNAmII3kZr47hT2MnZ2X2/DkkE7UuoYlX/L46SkBs+Y6RMCmAJEjpOu2R1kFsul9cIKakuujP4mbyowF4HShI/2YDxKyYMeeGt64=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(261022105027099003)(11063799006)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWdEcFl0QjRoM1I2WjFxRVpCN1k3akVMY0I3QUVQdWY0azEreStMc1h6Y0V0?=
 =?utf-8?B?SzZDZWFTMW5OZVVjMDBmVWkwTkoyNU9ZWkRmQmh5ekgzZ0pDa0ZUWUhHUkdu?=
 =?utf-8?B?Y25nRmNsVU16SlZpMnRqcU0vUEliNkZlSE8yUnA1KzZyeGtFOVFqQUJNbU5C?=
 =?utf-8?B?OGN2MjZiaVUrUDZOQ2RYeDhEU3BMaGh0THJDT3loQmNMcDU4QWFXNS90bEh1?=
 =?utf-8?B?dHljdnVBOWg1VThqeWVpbkxONGRTZi9rbHRSd2x4eEErcXNra3F0QXJxRVpN?=
 =?utf-8?B?d3psQkdGTUdEMUpQYncxWTB1QkdyREgyWTd4TzVjaTNPK25MSG9lS29uVHlW?=
 =?utf-8?B?Y0FVYVVvUk8xU0YvT2VPMWRrS2k2ankxbWYxbGRtT3AxVTVwelFaV2hRY0Fl?=
 =?utf-8?B?R2IxZDk4dUIxVEdhUUdXYzhRSzE1WkdFSHZIMHptbHM2cHFkbnM0ZDhYUXMv?=
 =?utf-8?B?SUFCdDZrSXpGdExzeDJ2MDl1OVpmT2E1bXBpUTNSOW14QUlhVklxcG9tN0Uy?=
 =?utf-8?B?RGlCS2JONVlicmdNOXlvSEhvdUM5VkFoZDZNNm9SUVlMMEhBZlB1eEtDckpt?=
 =?utf-8?B?NGg0Wnl3ZldldVVtRkU3dGZEM0phbC96WVRadFcwaUxadWFWWUd4ejRsclR4?=
 =?utf-8?B?NGE0aVVIeDdybzUwRlV6YkZuMDM3UW1FYTVQNjhRbjE1NjNScUMrbjBGcGQ5?=
 =?utf-8?B?MmQzWVl1Rko0KzIxZVRYY05EWkgxY1ZjNmRmOEp6bVRsSmxDQTlxaWN4WmRU?=
 =?utf-8?B?NW5UVWJhcy81SkpRNkNXdWcwNUhBbWxmNTZoWDRONS92ZldYMC9WelRqY3lS?=
 =?utf-8?B?SGNoY0UxTUNIdWd4M2tmSGZVRDhzQWY0cDZzYU1EL1hndWs0RkdSdXpXR3Vq?=
 =?utf-8?B?Z0xMbEtUVWlGT0VXZzUwOUhSU05ETFVPZm8rZ3JLV1JGbTdaQlpsdzhFTm84?=
 =?utf-8?B?cTE3dTVwNklFdFZ4b21OVVlGaUdzTTZFRlNFdTZ2UFNsNU5ZQWdkSnp0bUxj?=
 =?utf-8?B?VFhkMURQdVJkR2xPZHp5RlhYS2w0Z282bitWVHA2TkJTQ1MwMkF2TlFoMnpl?=
 =?utf-8?B?T0NVdTdwMEpYQSsxYzNzb0hMZDlGNm5SSHlVWVVIYlJTcDY2V2hRRkdwM244?=
 =?utf-8?B?VW5GcytvVlFpcTg4NTJrRGdEYjFlZFdhcXdZU0VwaW1IaENjOFpiekQyM05V?=
 =?utf-8?B?MWF1ZmFPYW1VWXpHYUlLTlpURmFkU2dHVThEbHB0ZU9XVktyUTVSektzM3ZX?=
 =?utf-8?B?bnc2VjBJYTNkMkJKR04rSGM3cHN3MGw0R2JyaDZGVVpPdDFhS0FUSkdzZDJI?=
 =?utf-8?B?QWttdk5IVkdFUEdhKzVyN1VYcGkwYk9lUzAvajN1ZXdKZzVpVjlGdVNMdVJZ?=
 =?utf-8?B?c3YwZDlYMi91T1NkQlZaVzZ5SHRRVHlTbTlwS2MzNmh0SEVIR2lzMGFHSUxK?=
 =?utf-8?B?emdsN0JDd1M2d295NkUvUTZDNC9jYUxpdGRURTN3ZCtUTUhQNVNTbjlONnNn?=
 =?utf-8?B?N3l5MEhnYzB3L1ZKaEx1T1NoSDg5ZlpXUFJ1ZUFNOFlkbUpBUk1jL3lsbUNl?=
 =?utf-8?B?N3l5cXN3bG0vbjhKem9jNWZRcVZCc3RaK09zK3dZNGQxS3BBbmlOVSsrbk43?=
 =?utf-8?B?R0RqODFoc1BjeUllUlMxUTR5eGRnOWpVRkRnS1d5WWZDbXkzTjRaVUo3bHpR?=
 =?utf-8?B?V3kycUxXbFFCT0VyL0JSMVowNTZmWXNIeC9nelpXUHplT29uVUQvc3NoRVdi?=
 =?utf-8?B?SHYwZDVlaks5NkpQMFpvR3o3QVhSMmdZZkxmcjVPc2VPSmoweEVQcHltcTBG?=
 =?utf-8?B?cnFFdmt6MG1FbjhhQ3JIaStSWkpUUFB5bUNQUUtuQU1PZm9zd0VwenlMcjdK?=
 =?utf-8?B?Z0tqR3gvZFVqVUptNzlBWXN3ZXh3ZHprS2ZKWnJTOWlsa09qbnVTa1pGMXRM?=
 =?utf-8?B?bDRKcFB4MUNuc2YwM2Zqc3REZTIxNGFJZnlMdUdzOFhPMDI4T3hWZXhSZk5p?=
 =?utf-8?B?T0Z6cnlxSzEvWU1FeUdXNmd0SHJZQUVVRDl0bW9iK29rcDhyWi9uZHZ0M0Rr?=
 =?utf-8?B?a2FmR2loVjVDR2p4endWeGVwblNhTEtZR2txbm9rWHhUbk1rTW1YTCtmN3pO?=
 =?utf-8?B?WkRKOG1QOHFudHMyR1VEZEpNZkZtWDBDMkZIb2NycG9idElRMnNLQjk1SzlH?=
 =?utf-8?B?akRlK3FHTjZSNW44V3RFWUZ5Yk5vME9TUUQza1g0dTRTK0JaWlQ5bE4xdjM5?=
 =?utf-8?B?cWYyanRybGJNenpnTFdHSUVZUGx3LzRldUVhcXN5LzBlR1JlVmw4M1NyS3R3?=
 =?utf-8?B?UFZNNHlGVllmZ2dlQlJHY2lYYWU5U3NNNlhLQ3Bkak45U3cxRWVSODQwSFZw?=
 =?utf-8?Q?x7yq/zzCnTfXbSco=3D?=
X-Exchange-RoutingPolicyChecked: l64LFfU9+XvaO+xhzimxWVZhlqctmF+vgJAn1gni8l67FNxJmy6Yn9PkJOKiIjFAYZ5+bAKzC4P/YPTDbgY6iJKEFTCszmnfstIN7TuC1clX0DoAyQv7EP10cQGD/9YFl/NkvlP5f61yFYCS8ARaXrMP7RN+gu359lXYKww/ZFfGZzMnrQXA67qQsf8EWszYI4inkQoNmH/VfWp+PJbKVWCL/AVZjUl8PiQxI+Z6z3GQGoxF6gMW7v264bJDC6ipZSKSMdjMCKsi2i0p5wUMCyv54qHzp59v5oTRs4jTkD6uksJdn7cS7/sH4cpHro2Fxb3n+vZ24ZSn9YXga/+nyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8156a1-abdf-4bbc-4408-08df3b6c97b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:42:50.1862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hg5gw6+pzSRpB6bQ2lFGxviqeJz8RCMbW3LDExz/AqnqOuNq/glXIL50gbRzovcjSV6kVnjcE+PZSy7F6kS6/NvkA4qCUxplGmpWpQgSBoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB852307
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

On 11/3/2026 4:42 AM, Przemek Kitszel wrote:
> On 11/3/26 12:23 PM, Loktionov, Aleksandr wrote:
>>
>>
>>> -----Original Message-----
>>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> Sent: Monday, November 2, 2026 11:50 AM
>>> To: intel-wired-lan@lists.osuosl.org; Oros, Petr <poros@redhat.com>
>>> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
>>> <przemyslaw.kitszel@intel.com>; Sashiko <sashiko-bot@kernel.org>
>>> Subject: [PATCH iwl-net 6/6] ice: register LAG event handler last in
>>> ice_init_lag()
>>>
>>> ice_init_lag() registers the netdevice notifier before it creates the
>>> LAG recipes, but when creating any of them fails, the error path frees
>>> the lag struct without unregistering the notifier. A failure of
>>> ice_init_lag() is not fatal to probe, and pf->lag is set to NULL, so
>>> ice_deinit_lag() won't unregister it later either. The next netdev event
>>> then makes
>>> ice_lag_event_handler() use the freed lag struct.
>>>
>>> Register the notifier last, after the recipes are created and associated
>>> with the profiles, so the error paths have no handler, nor queued work
>>> for it, that could use the lag struct or its recipes. Free the recipes
>>> if the registration itself fails.
>>>
>>> Fixes: ec5a6c5f79ed ("ice: process events created by lag netdev event
>>> handler")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Closes: https://sashiko.dev/#/bug/linux-e0559bca-fcfd-4435-96f2-
>>> 15f7e3d74184
>>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> ---
>>>   drivers/net/ethernet/intel/ice/ice_lag.c | 15 +++++++++------
>>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c
>>> b/drivers/net/ethernet/intel/ice/ice_lag.c
>>> index 08a17ded0ad5..c4b8af01e2af 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
>>> @@ -2601,12 +2601,6 @@ int ice_init_lag(struct ice_pf *pf)
>>>       lag->notif_block.notifier_call = NULL;
>>>       memset(lag->sec_vf, 0, sizeof(lag->sec_vf));
>>>
>>> -    err = ice_register_lag_handler(lag);
>>> -    if (err) {
>>> -        dev_warn(dev, "INIT LAG: Failed to register event
>>> handler\n");
>>> -        goto lag_error;
>>> -    }
>>> -
>>>       err = ice_create_lag_recipe(&pf->hw, &lag->pf_recipe,
>>>                       ice_dflt_vsi_rcp, 1);
>> I'm afraid act_act_recipe is allocated but never released on the
>> normal teardown path.
>> See ice_deinit_lag() it has just kfree(lag);
> 
> you are right, the code behaves that way both before and after the patch
> FW resets those via PFR at appropriate moment (appropriate to ensure
> correctness, not to have clean code).
> 
> Not going to change that as part of little fix.

Yep, that should be cleaned up as a separate from this series. Will
apply this to dev-queue.
