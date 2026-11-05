Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BE606A334
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Nov 2026 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=FM+YV8Jy;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NFFolPXP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7542B404C8;
	Thu,  5 Nov 2026 18:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z18g1IlrIwAo; Thu,  5 Nov 2026 18:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 94FCD4057D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793904378;
	b=ZUcYkN3XoZWM1gys+TFBbMZ182jLqOFRShRgAyoOpd+epIVGEK/FrbrxWQDSz0KPwUUR
	 6zLClhGhLhO6RaZsMLbW9yP2Qm4tTsimV4pzTq7zsub8PMLAML8uFoClC2tTGAIvgM/j4
	 DC7bZ7phFEiBSXXTUP4zXWwPlcSLnAfnnv1EL9EPXNz98RN7aB1tz4H07OWolACTYha3Z
	 JV01/omk19+Zy/ffZCSjde/VK1lFwrQMJj/ZTeRzVWBU3YilWtPvoRLEP69F1iUgN6HOj
	 hRUwf7/uhW6BgOx64i8Z4GWHt8i6p49PbvrMBsATJajZl+Nr1rbD50Oq5JvEshIy9qQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793904378;
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
	bh=ad5YBXy4eW95TRlbvGkNl4UBpwccs3myMfEwz6m8TtY=;
	b=qhcENXM8qP8sDHQujmDAO01mC9CBHe+mu0MO0n5MfHDrZXwonkNbgiZvMDJFjDULmXU0
	 LZdXnc0WOseM1T3rboQhOZZUCpSxW6T+LscNpagMNItNJagN/q6Vgwd/THIvTZeUEGdiU
	 C3NvEbaYnQ4Nvj04Tz9ty+TNjVu+BilcC1pFogk/KMbyWiZ2VPnVn9sxYbvPcZaMYYKjW
	 fk8VdCNPa8tgqXVT2FRfA32tLrFKUD9iGXUkk/DfRb9WUmT8slpnjTNJ9RCOYK1urQtGt
	 IqhYFspuq3MmW0Ze3ONoFYKIqBuJE6uCQ0L52+Sq9ZB3m+vF3vc4A2/edf2kWQ+tVVA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793904378;
	bh=ad5YBXy4eW95TRlbvGkNl4UBpwccs3myMfEwz6m8TtY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FM+YV8JyKLKHPj+5SS5b/0evgjZtUQSMKyqep5SdpzGlZKRQC5x3CUre13Z4s0Z1Y
	 eKIhY6tPQVU1WpuQ/rLM1ldoGn8GGywENC/msP6UZarOtnB8vpBwjM9AtpsP4XV561
	 6udrwmbA97CrjC1GNhj8YUc2WZta2s68XCYQWXbX5+FXNJfZ9NU+uCruiMBywmnrEc
	 NWfQlIwQiNjp0xXK6Ku93/EeEeNxCKECf16pekV2qlOD9NjBwmJT9CzWfDdoxYwRPW
	 wukTvOK8yX7Eqpt0Ca7sB56hk7c6rk+N7VurB5xccpQp0WCv56ESlF+MA6CHh7WTxy
	 us3UPI/edD8LA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94FCD4057D;
	Thu,  5 Nov 2026 18:46:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D35D7B7E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D021660885
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hIr5B8OrI_kO for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Nov 2026 18:46:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B71516085B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NFFolPXP
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B71516085B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Nov 2026 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793904377; x=1825440377;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VNbuT/I9tKSKKDCrv1zY5jAXvp49R5J70Rp+7aH2g4I=;
 b=NFFolPXPYyuMogjT8/mqapwaTtCjKS0D/M2wF2RzDsW9wi1hLVxBL6hu
 +Q71TuXkvz4hfZ1hlb0wwpamGPOvs4C5JQltv0c+czu7xIaMV6ALt6Y4y
 b7blq2h7LWb0aZzgwAfb+4A0ve7Tu/KVnZBQlA+kefEBA1so4doYKl+bY
 oV7QedwnFZfP6OEH88daXWhmDUUo5qdYSfnax7RJNqgdTrdnUIp+AbPbs
 wROIcKeTLIJJg1b32kXav1llHR74PkxSCRwETeMrlNO+zYUrpx0Un6e3f
 08FpWTwXLWpvq+zPHC55Rt3xrqlNAp3bOblDnR1dDK7c5mL2hzicX78jk g==;
X-CSE-ConnectionGUID: INH687UDRnOss1jXRwwjkg==
X-CSE-MsgGUID: XQWPH5jpRWSZG9KcmYXHZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2609163"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2609163"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:46:16 -0800
X-CSE-ConnectionGUID: ITZSCNawTsOdvrA9IFzqoA==
X-CSE-MsgGUID: WOVXnu6dS9m9o6hHzuCMrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6974890"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 10:46:16 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:46:15 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 10:46:15 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:46:15 -0800
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ2PR11MB7619.namprd11.prod.outlook.com (2603:10b6:a03:4d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:46:12 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 18:46:12 +0000
Message-ID: <27edd1c3-c5ae-4d23-9b54-0589ac690dae@intel.com>
Date: Thu, 5 Nov 2026 10:46:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 0/6] ice: fix DCB lock ordering
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, Petr Oros <poros@redhat.com>
CC: <netdev@vger.kernel.org>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ2PR11MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: bbee094b-fea5-49c0-9f95-08df3b6d104e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|261026140227099003|11063799006|56012099006|261026121527099003|261022105027099003|261022075727099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261102130727099003|261028144727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: BrHgpY6Yvf23ynPKIAL+ejAZDlb+cL4D2JTv+d1zTeSce8ruyX4LpFojoKkXbkygl29/1if+PNr/KoQuQSEXDiDNHfUwz7c/2gUhElPJ5imxWq2c7BgyD/FhjOJpfv2hy/c2IVRjIoPPJSDoArrIVpfVn6SKzTOWvO6hx9V+kvQqY4tAj6Qld0hiMf/07mEJo+AHVt1YF9y994oHobK6b/e/g/hmaPoJO6pC+Nr/D9S1XHu9dXDhI4Tl2rWXNNSz4vuTAGZ2SjO5/4MPXK+JP5f8XXLJBH7Ol6MhItRiBRDV0I908o3btqcX1vzlgC9f/RL6sd2D9W3oECna2i3/1rDXrcLJr/UCStTHjNHXNn5jP1bGcKINrF7b8Pc4gtDvoEqaA8IOBG3DWjQXTxks5z7onxs0CcwbX1Hhb/HEggduqIE5CBBfBMNARBQbqRRhdcKEc45SVDV1T8lMzJMRy2cW4Memdge79PfFmhC88Rxw6Nbcq5afU5FZvxlcp1MKMXypYHe1Lx2nUd0UG9G3qhArpgtODRtQq5N9LbcWQT/RlUGvlOivV7wMM+vLmmMy5Cay+Js5TqzcqMY0Ry/dLc3rwRIMMgaK+3ae7i6KTNtDyBXwrlnIvBNz8FLHFxWl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7381.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261022105027099003)(261022075727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261102130727099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGkzYU5JeUNyUlJXVEZRdWVxWUpxdURtTEkxb0dWZ2FaKzNFWC9Pak9RMGhz?=
 =?utf-8?B?ZFNZL3dxdFFmcFlWbmZmWnVJekJ1L3MwNXZzS3dsSjBiMWswTm9SSTcwUXov?=
 =?utf-8?B?b3A5dkhLYlZIY1NHTmZXS1llQndsMFF0NVlnWTJVcjZFSXlXRzdTU0VkT3Nv?=
 =?utf-8?B?bUhUYlU4QlA0V3gweXF5ZVF6UFZNejhVei82QkZjV05vUnY0THJURWFOR2Qv?=
 =?utf-8?B?Q09aZGJGWmFKZWcyQXRCZVFJYlpxZDQ4WUpBVWFkNEs5WHgvOWZ2YW9MOU5Y?=
 =?utf-8?B?OWkvK003NE9PWG9KMC9uTGl1TEFCL21vbzRJSSs4VFBKNW5wa1d3OWdWeGZW?=
 =?utf-8?B?eUxqa3hvZHdoRHkyMnVZTlAyaE9MaHpBakIzQ3FEVVBKMVVaaGdFdEtqQjhD?=
 =?utf-8?B?S0pHZVhRV29wanVlajhYbldYTGRFMHZRcWN6N2dIeFlFMVF6WU1xK3M2UGpx?=
 =?utf-8?B?YUpSMElmam13U2xaKzJ2WmN0ZUVvSWRvM3NseWpvNmZBMm5KbkhsNFZDcFo2?=
 =?utf-8?B?UU1qZlFaVlNYVnVEM253QzBGV2lUSFpQMkZJTVZyWGNYbWZSZ1BPSkw2WGRQ?=
 =?utf-8?B?d2VuODZWYms0eVFqTHJUZlBVTVB6bE9GeVZXVkNOYTUweHlYN2lOY0NiT0Vx?=
 =?utf-8?B?M0dGYkhtYlVZU1REU0x3TU0xaDl6UUdLTWJTZE8rZ1ZybzJzVXhBLzY5WjB5?=
 =?utf-8?B?VGFac0lzR0hFYmVnWHFuYjg2eHV3SzRzeGdjTDNMTVlnZzZDL0lWdEZXNlRq?=
 =?utf-8?B?ZHhjTkVhTW16blNid0cwblpHYy83bzVISWYyU1dtdGx5VTQ3SkxKcC91aDN0?=
 =?utf-8?B?K29NbVliMVJQVXFEcHAxVDRXakxZdkxqd2J0VGI5Nm5JQjBNRFIwRDl3RUZ1?=
 =?utf-8?B?TWlWcjA2UkFZTVJPWXh1M3NadG1TVXNOT2tlQ21YZWdFbVlHb0l2S0N2bW1D?=
 =?utf-8?B?NFh4WXMydnVidG5SWFRCNWpVN0RTTzJnT1lkbG5rdnArQzdSR1hkSzJ4U0Z1?=
 =?utf-8?B?SFFVS2gxc05FdEhUTEk3bVp1d0NDL0lSMmZ2QXFCRVJ3aFdYWURDS0NKQkN1?=
 =?utf-8?B?Q2g0azVjQ3B6b20xVkxsRUJxaDRzcm1DeEVOcFZabmVvUTU2Um1WWGhOWUk2?=
 =?utf-8?B?WVJDS2FHQVFqRm0zQ3JkZVNJNjh0cURXTHA4WVZQS2JMTDJjeTRDT2taNmxE?=
 =?utf-8?B?YStlaWFRelovaWZnSDRVNUpwaUdINVoyVmlIcjFqSWxtUFhqWE9sQ1ZrN05m?=
 =?utf-8?B?SWpUaVpzV2tqZHRLS2F3cFJreVl1bWdnRjViUUFSN1Y1cSsxVkQ0QitIb2pU?=
 =?utf-8?B?c3RuaC9qSEZLSG8vZ0hYaGw0Yk9LbE96b0VPWVZ4d2hNS0RWbVhSNjVyRW1n?=
 =?utf-8?B?Y04ydXg2bnBIbTd4cXYwZnlaRHBCWUZ0ekJjTVdvOEI2dmpVZEllWStFckMz?=
 =?utf-8?B?K0Z0aGs5S2F2MGZvQ0l3aG15SXJOZU5hTGRUa3dTZlRHVXJMRkI1Mnk3Z293?=
 =?utf-8?B?NlJpRTVsZ2hhVWdCT29KamllU01RQ3R2YzM5ajU0U0Foc3FhTmtMcnExWlAx?=
 =?utf-8?B?RitJSlRWZnZ3VnhUTDA4MllZTVl6ODlDL1MrL0NES0RNdnhnUVdmb0JBQldE?=
 =?utf-8?B?OHkvWXNUUXdTNE5zZENNalVGTmlxY3Z4MElxTVdzamVPTXp2YXBab2ZsL1pG?=
 =?utf-8?B?UTBaOGF2aVhqRjMvdWRUVTdvdGRzK3JlT3JLWURMQW9ESERZR3VYMHUwOFln?=
 =?utf-8?B?VG1JNGRkemFVdUlnSnFtV0RwRkJaTHRJdjF5TjAzQ1FXTXdra2lqMUN2dEVO?=
 =?utf-8?B?YmZWdzhTOXlKVXFEUzNsRXNBY0kyNWg2ZGZsQm1SK2VHcDlrNzRnd3BEbk9m?=
 =?utf-8?B?RzhFTnUzTmM1c2d6MldrZldpTW83MUI2RjdvUkFBYk9NVVBRaU5XekdKRXFy?=
 =?utf-8?B?c2hlbVZEM2dDazUraGVvMFZUM1hEUHZiZEFHM1Yyc3Y1UFkyVkVxSVFBN2oz?=
 =?utf-8?B?cDVvSWVDc1JSNG1DRlU2OWMzSjVVQ2J3ZGFWYjVFRWZNYXZldVZ0bGpTSFBl?=
 =?utf-8?B?WHN5UnJSUUJ4QTNsMTYrcFlXTWVmNTUyMWpXRC9GcTM1YmtsMDVQYyszQWlP?=
 =?utf-8?B?SmlXTEtJR0R0dGllWERKYWRQMXF4NElKdU1LQUtwOUdQcXhxNHBHVEJxTnh0?=
 =?utf-8?B?OUpqL2h0cWxRRWJpM1I3ZStwdU84SjdmbzF0THRnTUp4L2F6STRPbFpBNS9E?=
 =?utf-8?B?ZXBuV0FxaFNIK0lPNlVOQWVWT2dkUG9nUXVobTJYOEZ2UUxiVko5dnBnVXk5?=
 =?utf-8?B?NjNzcXBMNVAzaG5SV240YXhaYlN3RWRlNDhtUDJ0SmFoUHNYaFd5U3VBMUhU?=
 =?utf-8?Q?H2Rbsy2QLIQRZe9I=3D?=
X-Exchange-RoutingPolicyChecked: i/ruOBfawodLUlhWMKxZDZ/T12Vi8/zvtvhFdInVTqMSOH96JttAA7gqS5agTwj32z/GFxOxZK2RoGHUJqCmXbtySGC6EwZCBAa9ohnVx6VObG/VRJM2cl8bnWYQfdXMOHf02Jgk1qD7xMtV6iTXKqwNsxHlnXyQ54e6Vb/RJ7jcS8ju7xtC1TrTtHe5xiUbOCYn7Ho6PgXc5tFT6fPEjSVG+fhBN8F5ODRRMo1qC0lvQdFmWcjTvf/ocPT2K8pDE8NXg9m0Aqxir5Nz0XZKmyYO76gBd5gKOzLsfE7nBZx7F5Lg1mKBpjxG+3DhpoU6n/2DQrLD46yeJuSnBd5JXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bbee094b-fea5-49c0-9f95-08df3b6d104e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:46:12.2298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho8TxFY98OqA6olZztfUF0YImAemcfIaizuccbEgrfYM6gVYhJcQ3wiraHNSdOXenNJxZ+dpgvtNoZl7SOl+02PnZXhqrLcG8KC5Wvlzgnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7619
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/2026 2:50 AM, Przemek Kitszel wrote:
> Fix deadlocks and lock inversions around ice DCB configuration, between
> RTNL, pf->tc_mutex, the PF devlink lock and pf->vfs.table_lock.
> 
> RTNL becomes the outer lock of all DCB configuration paths. dcbnl ops
> and ndo_setup_tc() already run under it; patch 2 makes the LLDP MIB
> change handler and ice_dcb_rebuild() take it too, so patch 5 can drop
> the now redundant pf->tc_mutex. Patch 1 goes first, so that a dcbnl op
> does not wait out a reset, whose rebuild now needs RTNL.
> 
> Enabling DCB in switchdev tears down the devlink-rate tree, which needs
> the PF devlink lock and pf->vfs.table_lock, both taken before RTNL
> elsewhere. Patch 4 only tries them, and only when a tree is exported,
> which it tells by rate_node pointers, no longer left dangling by patch 3.
> 
> Patch 6 is an unrelated fix of the ice_init_lag() error path.
> 
> Reproducers are in the commit messages, each verified to trigger the
> lockdep or KASAN report before its fix and not after it.
> 
> Petr's "ice: fix RTNL vs auxiliary device lock inversion" [0] touches
> the same ice_setup_tc() and ice_pf_dcb_cfg() code, so one of the series
> needs a rebase. With this one applied first, his patch 2 is not needed.
> [0] https://lore.kernel.org/intel-wired-lan/20261023070258.730168-1-poros@redhat.com
> 
> 

FYI, this series did not get any reports from Sashiko, and Petr's series
did. I think that one will need to rebase on top of this for ease of
application if thats ok? I've made some notes for Tony when he gets back
next week on this.

Thanks,
Jake

> 
> Przemek Kitszel (6):
>   ice: don't wait out a reset in ice_dcbnl_devreset()
>   ice: take rtnl before tc_mutex in DCB MIB change and rebuild
>   ice: clear stale rate_node pointers in
>     ice_tear_down_devlink_rate_tree()
>   ice: don't block on locks in ice_tear_down_devlink_rate_tree()
>   ice: replace tc_mutex with RTNL
>   ice: register LAG event handler last in ice_init_lag()
> 
>  .../net/ethernet/intel/ice/devlink/devlink.h  |  2 +-
>  drivers/net/ethernet/intel/ice/ice.h          |  1 -
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  1 +
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 52 +++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  | 46 ++++++++++------
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c   | 35 ++++++-------
>  drivers/net/ethernet/intel/ice/ice_lag.c      | 15 +++---
>  drivers/net/ethernet/intel/ice/ice_main.c     |  8 ++-
>  8 files changed, 108 insertions(+), 52 deletions(-)
> 

