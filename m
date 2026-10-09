Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5784ACA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 23:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0815B8146D;
	Fri,  9 Oct 2026 23:11:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ihW5QPhslONZ; Fri,  9 Oct 2026 23:11:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4ED988146E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791587503;
	b=RfSshaCAkkITL17oUCBPQcHPf4pQmF8S+5QkgpqBvd2YwQZN1rK4Da7nClhTcsVhs9Gi
	 eaDLXjB2ee7hLABFrQOd5k08FspRn7Smjg31dggUKgmPgvTX4ETjxumcOyUrWPYmutCbV
	 +cr+8pv3nL7LfXow6rlsQ3D7NV2i6/EnKAskchXVZPhnRgi9JFBAXWwJqfYBXTkVvF+Pi
	 cwpNwCHUNaw8x+o4K9JdKDEe4lXLGGd5BP24iUBOeAikeAMm6OWqR9HvL+XYpPX0YPU9U
	 /F/K7xG53PLAGf1H2MWpNd+TS5P9LRh9aA24nI5R1HUqxFvfg+Ekeie9JyVHKHaOwdg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791587503;
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
	bh=/rGHiayUUjG7kVgeNvG9IiVrWr+FA0ZMIm0Hy9VrejI=;
	b=gTIoumkkzTk2tAlGgrCRUNXHPGqrN/v2jSFiUrzeADDC30GSH3eEr876FYTOgOK/jbBQ
	 GNGtuhIQ31EHuM9RQsu9WxSZJA/4X74mVDW5e1OHA2aRLEpvfa+Mml4J4jqa2bpkeh1Fr
	 5Agw/DIRDUud/aIJ9pmtej4GU5chWR9vNRp6KTwF2jju6CA2SxUcNMl9T/48xjfyyMk7s
	 z7xfqvTcZhthheXqwv8hN3nwjKqbkn6pIbUKlQwVAIz0hRkZvRpl0G/ILcGdVwqVtRZ2n
	 lrzRYK/wosuRFwD7tbu6u7rltQWUDOpASTCNfSLgPnKYvBy8KX+EDUP4zBUl3WGCjhw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Tu24ctp/";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791587503;
	bh=/rGHiayUUjG7kVgeNvG9IiVrWr+FA0ZMIm0Hy9VrejI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tjee4nTZV6RAEKuy3jNsO1Wj/jOe7B/h38twPk12Rg01qR8xrWQ/jYRJzeOLiG8Gc
	 prmUwf+LcIsQmBuXTAIJ7Ptx2SLO6O4YqRj3ZYGKFfVHz+X57mwBCQqSPjiKhO4itP
	 +9vyJHWzn039R6smHN8Q9E5U02OiiYcJoOPoJkmW6BLPYx8/ZdGWycPz96sfXiMwGI
	 9XJ5B9LVuOoTC05oSY8S6nMtKgb5h/UPx4lSYnwI8STaQMGfc0Vi1eleDdYWKrDn2a
	 ZVi4HnudtWvd38jI8B6PjfV+QeQDjyrvXWy2z7z5Bn5Fi2AyS5GE2NSbyiSA+5IdbZ
	 R97GJlCHpAIbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4ED988146E;
	Fri,  9 Oct 2026 23:11:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 069301DE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 23:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E11B38146E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 23:11:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yLvxV-mKLg0Y for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 23:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 835588146D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791587501;
 b=EtXDWuwNt0NaC/BBuccPoYVEFuv2rPz3zp2EJGoU3oeRHgx+gj04M0yaQlc4ceyA2IWm
 S/mHsxEl+LWzhzAaM9anWcgJTDW0JCquGyAh4DF8uY6DHar1tRmWc+svTp29dA7uBoW3v
 rEM1T5p7uXNgZDruNMXXumKr2w98gI01t3/+0Q4yERc1nqGDMGVY2AOEjT3SCRjTcZDTs
 TxV7rY7yKr7uQlbmVbDq36a07qGka/4H+FAW/Rg6GqI+/7TRdMfNuWrjIrNbw3FOW6ntJ
 3gbO1j7ROONdQmQhShOROza/AYVT1wwPqGC9Ts9woSpOH+IbOuc6EF5YHZGmJrgtdvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791587501;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=/rGHiayUUjG7kVgeNvG9IiVrWr+FA0ZMIm0Hy9VrejI=;
 b=q3LW0Fpn7rlp1CpPDJmMjron3EiRJtSEfi7LEw9Bs9jDraG7M+N2sJDngDph5dcSivxZ
 qSeJ1cPW3xj/nbsOHMXnDtfoxCe+eqhZfH1P3waUqRup9v3dvoikGSAqVMPYtNxIdM+Vx
 gnKw8vL2w7HUfyVkU0trqorBmDd92aVVohUPzzPc8v0RjK4lUmtTVJsFNLgRn+d30I7S/
 AzQoiT0nnRAwyPMgh1kxeBPXNdSxyN4BlNDPjfcs4jDzC40/qCPP60NOlS4un9lTJtS/N
 9TGHggCeSimul4zKIjoGRQxVysP3JV8IQW2nTIqlrPNPVqtX+x+eFO062Ww/t5yZAug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="Tu24ctp/"; 
 arc=fail smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Tu24ctp/
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 835588146D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 23:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791587501; x=1823123501;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qpEKygQjZpRx8BXjwWU5dwoRgIXwEMT1mavp9FSM4Uk=;
 b=Tu24ctp/ixNs+EHgc3tPNH0SoNxtDitY1zoreEuU2V3CwNkWDgwjSD+p
 mLwT5AnfW8Y1cMh1v42aD96VpAhU20tUw7K6Ujl2K4roXmLGxdkZlK3GT
 5NVf81qHA8O8faqaKnIM4P1gIZvykh/c1+QiBBJSSDVlTBU6bQf/+1xep
 1EfJLyPgfWb9tQXSo9d8ey8ktufbOZwVckZuB/+nVLS9WpWd/EhFpdPJO
 RKNCcSOclv/tVv0+ENtypZutN2u7rT5ZWhYk2/UWv0+w179UNKxogffyc
 i7s86UA63po+ov31miJXIqWGBD1VTSNJCIPoocjfmVymdGaTopnyBL83y g==;
X-CSE-ConnectionGUID: anrMgC+hQEegN42CWb4USA==
X-CSE-MsgGUID: PYL0J3DJSMCF3OFy+HewDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="279757"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="279757"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 16:11:39 -0700
X-CSE-ConnectionGUID: fVvkZPleQEeTNCoTV/aKKQ==
X-CSE-MsgGUID: KUGGFJ/BS7u/RK6eF/mLyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2170774"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 16:11:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 16:11:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 16:11:23 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 16:11:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3gvi2mxZc7czBn3IIZLaepLND2CdyMufDUmS/RI0F/FBUT+Z+TqfX7WUFcURaqtb0brHYqZ1EBQ/J6BpNIEcWJk1THrGKDfntWUh67GL17VoKX0h3A0qlmd3R1q6BIktUVhpBdDDlKeCZX0tI7hKzOEplH6oB1JnY5+jjiXfFCF6xPLSw3VJrFOhEhnDPKZi3ACbG/gI0OAqcJrFkf+FwbThBZOPmjyasL2vfSsbBu1fNbIDcMfg1yVzlFOycGFlVWeQh0oCwciFEgkoZoxu8u3t36sK6cLOPcizXqFq9qp5CeB4akJvxHUO+pw0yyRApUXHeopSt1vokSCjCV1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rGHiayUUjG7kVgeNvG9IiVrWr+FA0ZMIm0Hy9VrejI=;
 b=apJfxPgrSBTLC+drctPG5U+9D5nvI5uBXL5ZE2Ay53dTGM1vI036TYNDV9pkPxJDPh249ZaSX5rBYNjFknC3/d6lmVBP878ZqvSFvvW/koPmF3aACwwxNDqhcEusESpyeufoz2onT/xwCVe5l1/e47Ql5VHv1wKfzPE1Lx6/ucKY3D1YV1x/JGNryRQgjfk46Y0xvY8c25Xhl4aK0e+oldSX4RmnXU5pUmXQG6tN1CqknyWL6BFt5Ly7RMdkn/fC2BgVFz1k7O0+dSOajddKH3B+PMjSicfRdkYkhO5ZVSs3I8la10GNkIeGcc3Olzuk0yQw2x6W/XsgF7i8SjqYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 23:11:16 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::7b0c:7df:21b8:dbbf]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::7b0c:7df:21b8:dbbf%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 23:11:16 +0000
Message-ID: <033cb9c9-4a2c-42d9-b71e-bf14841d06d7@intel.com>
Date: Fri, 9 Oct 2026 16:11:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 2/6] ice: count number of VSIS in agg_vsi_list
To: <sashiko-reviews@lists.linux.dev>
CC: <intel-wired-lan@lists.osuosl.org>
References: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
 <20261009-jk-cleanup-vsi-aggregator-nodes-v2-2-313964c25c7b@intel.com>
 <sashiko-outbox-166033@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <sashiko-outbox-166033@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|IA0PR11MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 266f7588-2c02-4d4c-b0d7-08df265a9efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: xI1gqjo98ieKAiqHa53uYuPLZE2EAeCq1IBlNibMqDR5wvl7Ew+Fc3BUsJE2AVHodhCCFeZXKrl+nkKd1quecDctCMFWgAS9wZfOV88aCRRVqALSPyMYK67M1ADpla9T6V6umXc244h8oUrE46ZWDffIZ1jexETVHJEoJOCOglE161dg7GZ43CbPUJ49Jgc/G1O6ubrWRZd2DoAzfSwiewioR3vShp2NjelhWe1vpqvfPm65PeiYTSVsT9Z3yDH+SiYTa8GS9MApNslDGA+niCcwh5ItneHuT7fa8UXMWAhPCl35Mqkak7HH52P2XThwd7rBjbb9w6KclXTZqHF4/L8slbbTVoVo7r8R4NdmUSJJ+dcUtlQOKMddqGcitqoQiTG+4wjr9JYLco9ysRWrJSSXge4hmQuFyBTzzoxbFl7XpgXUd2M/zi+QhQB9La2M9d3n/s/6ZEPoFoGiXmLRRakAGQrMOE8MMAUFelie/YjqvDhKpeRTrV9t90wdbHKkvVcU6OJQaAc4x20vnFmo9h/zaYcMhv1Pfp4G0+EEo1lVFKH6dGJ92JpoibdJ55HvRm+HXuVmWYTczEpICb2X24QNAphjmWk0fjQ1I80L1jARHd07qFQZtHMroBkp6vSitWF164tO0Mr7ysPEqDyBhHntnCD74tef61RZx46h4mE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7378.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnEwelB3eFMzUy94Tm0vZm1sQmEvek0zL3hrY2E0dTJib0FpS1ZnWHNVMkt3?=
 =?utf-8?B?MnpWSHA4cUdTZ1phbFIvNEgram9uUktaQ0l4WWIwdGMvWlUwb3hSTFMrUVJk?=
 =?utf-8?B?ckpmT0NobVlWS3lNUWtCdENVV3ptU3NsZUJMOFBYWE1GcUFkcFVlSWVHcW9n?=
 =?utf-8?B?N0dSYW5mZ0FMK3pHRTZNSlhkZHB0amZTZ2J1cEhBbjBtMFU4amNoWXBRR0ZT?=
 =?utf-8?B?US9QdkVPdzFhZVdKcE1Ya0I0eHp1WCtZaVRudk5SUDVpZktTL2xWREl5dkxv?=
 =?utf-8?B?RXFEVUFCVWpoTW5WZkp4bkdCcXJNTWIzWXlGQVZJQXN1bFJXVUloZjZ5bEpY?=
 =?utf-8?B?VTVxRmxZN25wSHo2SVlyR0tCV29vRmY3SU5Ua0ZJTjRGSktYMTdySlRaSHlZ?=
 =?utf-8?B?WWZ1bzlta2JHZEV6SHNwakpXcDloQlZPUGxCWDBPSWYrSkNtczNpTEhaWXJM?=
 =?utf-8?B?WTg1MTJ5dmphWCs1TFhmcktwcHkvb0g5K1UrM2lOZVo0bG1Ea0VHdTFmRnQz?=
 =?utf-8?B?TTlwZnRLSkt6Y0JDclpYQmJDYVRMZklXUGFDek81SmwrWjBSanZ2cWlKaUh0?=
 =?utf-8?B?dGovZ2U2QVhpM3BHYm9CK0I4bzJjTEVIWGRkQTJGelRuMEVkUzRuVlo2R0dr?=
 =?utf-8?B?TEJLRCtFV1l6eE5IMWw5VVEyTFFnOXdmbDRPU3FkZlRKWmdiSEJ2aDhvZER4?=
 =?utf-8?B?WmhxSjFkbUN6QUlzVkZKbUo2TDZXREVJUWFiRHJVTmtLMUpxUXNkbmlBeEVX?=
 =?utf-8?B?bG5vTkw1Ukl2UEZGeDB0YzJsZVIrWmlmZmFud2M5bm1UVmtTRGt1NTdWYlJH?=
 =?utf-8?B?RnY4NURXbE9UZUsxeWQ1NktXNnU4dHhiK1JWcXJJVUFGeEJTZjdHK2o2Ymdm?=
 =?utf-8?B?UGVkUGdzNmFXYjcyNHJMTHhtVmRoOTM0ZDMvc2xVL005dGp1TFQ5UXZKa2pm?=
 =?utf-8?B?SmxOQ2V4NDJHVVNrUXZiWHovd2lNSFMzOUtVVkwxaUZPK0pKQWg4eE01SUFP?=
 =?utf-8?B?Yk10VjhVMmNKNEZ0ZmQvaDR5YlQ1ZEtoeWFHeUtOaU1kbldlZXZRTVNhWXRu?=
 =?utf-8?B?Ny9BYjhoZkdOUlRzeFNVVndDZEcyWmhlaHFHNlBWWWFsRlBuNHdKcllxUXRt?=
 =?utf-8?B?a01JdHRieFVUNEdKRmtvcWIzSFhCWlpVeC9ocFBzeVlzbTdaam9QOXovSE44?=
 =?utf-8?B?UjUxYTZ1MzNicWtLaHJORlBKY3dzNzU3QVlhWmpJUGdMQXczeDVHbWNrRURM?=
 =?utf-8?B?ejhvYkhqU2lYV3JMZHo1TlA4OW9FN0k3cGU2M1ZrVUVNYk1aQkk2WnVod2tn?=
 =?utf-8?B?Ykl2dmM2a2NDRVRGNzJTYVVzQzhhVXBHUlpGV3NGNkUwdHlPbDR2UVNIV1h1?=
 =?utf-8?B?MUgvTlJTNmd5SlNQSjJCbjlNK084Qyt0czV3THZ6QkduejdNa3V4SCtiYWJ1?=
 =?utf-8?B?d3lDVnJEQ0FUKzMxOHRyVzE0N01DdjNwem9JYTZpVVFRWGpRZ2czbWhnMXRU?=
 =?utf-8?B?RnI2KzV6K281SnlZSTdZL1JLYU8zck4wM2tKQ2tCTDcvLzRrc1pGMkN4TUFP?=
 =?utf-8?B?RDdLMGZyaVU3dEI4bUkvUTFvakVTSnQ5Vmw4M0QwaEFaZUlRdkFuTm94QzY3?=
 =?utf-8?B?S0Z0YkVOQlBoTHlKemdTVTgrck9TZ0ZGb1hwS291OFNrRE1kSmdQQ1hnYnl0?=
 =?utf-8?B?cDVTVVFLaU9MWnNUSnlLenpxZVZIWmJDUmp4d3NZNXg0RDZGd25ITllBMjZ3?=
 =?utf-8?B?c1NndmcrWUxVODFmNWlpTU1na1ZZV0duTnZsMVFhOGNwVjhVbitKM2F1VUd5?=
 =?utf-8?B?YUlET3poUENldXE5Y0tocXZVSkZWRk1IMDN4clpCZlpvMzdCL2FQS0xLRVVz?=
 =?utf-8?B?czRjR2ljZjhGU0tzcmFWTjdkMWZ3aXhNZng2dmFsZXhaOXFab01PTXVsR0Fu?=
 =?utf-8?B?WTh3UWR4WnZzTnFhY2Z4QnExUkJ5cHovUGo3ZmlPWnRmZGRRbEYyRUxCTFJv?=
 =?utf-8?B?ZjM4ZFp5eEM0eUk0eFZEaTJvamMxQWE0Ynowai85WXlUQXdMR09DU21NVHVo?=
 =?utf-8?B?bXhBZmdKVTNOTFdzZmRvbkNFcWR5NHd0THg5aWQ4T0VJV0I3eFVFdTFwdEhR?=
 =?utf-8?B?MnBRWElMcGdFV0d6UitlMEluOUJJR0xxZE80aEp2cFhCNFhwZ3hzL3U2TGIr?=
 =?utf-8?B?VkVtVTBxZi9FUU5RaVVUMkRpTm1pcFRDZWNCbk9wMzlOcjFKWnR3MGxIdUNl?=
 =?utf-8?B?NTFNUVAvQWZSeWc0ZndBcGtSNGcxTjRRcFJ0azgxMlgrVVdNTWVXd2N2cGRJ?=
 =?utf-8?B?bysrR2JlNXF1WHZ0WlNkLzhlbWRHY1lmbmVwOGNERndNUG9TRDkrZz09?=
X-Exchange-RoutingPolicyChecked: aDxMiFqTqWYE6QSV93B+pmT2lIwFnfvxaaz/lwky43OEtSKmdypxt4xVHc7NqqVPR0JxhxVM4e6OND9XP/CZqYnfk3FB8xQYFG4s2DFSddPAZ4ryVaUYj9HrhGeSSDr9OQPhufWz7LjJlbCRojHU9snQJ/RzefwXGPvrSB0YidUUk+xTNB09GmYuo+ZsbagbHEPUu4uBiBsWcCb9E78SoVj3I76ZZdxhs7d/gdW3ZZmZq+uWYRNwlVMqrRQzyvBDR4A8ey/TaarPEdxCfzKHNGNEp6gxlZBDSpCcp09mrPjyTazy0IZW6wtbs6q6syHUTQ2+PUKKHLJtJBNyqj+xxg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 266f7588-2c02-4d4c-b0d7-08df265a9efa
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 23:11:16.7638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ja1jrJpNB0dtM6Tf7Uz8p+nn2AzN3onOdxMY0TuSJMOGB0ohEfdlYU9jPK0YYLHGddXiAQEXs9M5aCnekhnq0xqFP6Nb20dbkUXe9gI6OZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
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

On 10/9/2026 1:27 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] ice: num_vsis inflated and stale entry left on VSI move failure
> --
> 
> commit a9d16d503219ec18b5a73776a1a7f4b0b851cd1b
> Author: Jacob Keller <jacob.e.keller@intel.com>
> 
> ice: count number of VSIS in agg_vsi_list
> 
> This patch adds a member num_vsis to the ice_sched_agg_info structure to track
> the number of VSIs associated with an aggregator node. The counter is
> incremented when adding a VSI to the list and decremented when removing it,
> avoiding the need to iterate over the agg_vsi_list.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
>> index bcfc9db69e17e..08d0f685f6c45 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_sched.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_sched.c
> 
> [ ... ]
> 
>> @@ -2915,24 +2920,26 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
>>  		/* add VSI ID into the aggregator list */
>>  		agg_vsi_info->vsi_handle = vsi_handle;
>>  		list_add(&agg_vsi_info->list_entry, &agg_info->agg_vsi_list);
>> +		agg_info->num_vsis++;
>>  	}
>>  	/* Move VSI node to new aggregator node for requested TC(s) */
>>  	ice_for_each_traffic_class(tc) {
>>  		if (!ice_is_tc_ena(*tc_bitmap, tc))
>>  			continue;
>>  
>>  		/* Move VSI to new aggregator */
>>  		status = ice_sched_move_vsi_to_agg(pi, vsi_handle, agg_id, tc);
>>  		if (status)
>>  			break;
> 
> [Severity: Medium]
> If ice_sched_move_vsi_to_agg() fails and returns an error here, the loop will
> break. Should the function roll back the agg_info->num_vsis increment and remove
> the newly added agg_vsi_info from agg_info->agg_vsi_list before returning?
> 
> Without a rollback, a stale VSI entry with an empty tc_bitmap remains in the
> aggregator list, permanently inflating the num_vsis counter. If subsequent code
> relies on num_vsis to enforce limits like ICE_MAX_VSIS_IN_AGG_NODE, this could
> cause the aggregator to prematurely reject new VSIs.
> 

I'll have to check this but cleaning up seems reasonable if it can be
done properly.

Honestly the entire logic here feels like the data types and
abstractions are not very good.. but its been difficult to try and take
incremental steps forward on fixing it :\

>>  
>>  		set_bit(tc, agg_vsi_info->tc_bitmap);
>>  		if (old_agg_vsi_info)
>>  			clear_bit(tc, old_agg_vsi_info->tc_bitmap);
>>  	}
>>  	if (old_agg_vsi_info && !old_agg_vsi_info->tc_bitmap[0]) {
>>  		list_del(&old_agg_vsi_info->list_entry);
>>  		devm_kfree(ice_hw_to_dev(pi->hw), old_agg_vsi_info);
>> +		old_agg_info->num_vsis--;
>>  	}
>>  	return status;
>>  }
> 

