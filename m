Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D052606A32A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vhUjqtGn;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QzBeCkkM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEDB960690;
	Fri, 30 Oct 2026 11:45:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RJQXEDbICw59; Fri, 30 Oct 2026 11:45:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CE3E7606B0
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793360732;
	b=YWeaKag0+fyRu2ZR372MDvV2/dEauJSZ0H9cNkHVTO9mbosk9mtQf1DCKctBo5tc3+ul
	 6Fza/jZtP+lAuq6eeu46Alu80dIa3TprI/ubJU6S1BhSHQGCKlbNvSBYAqhPeuAtqftII
	 pN7JxsVIxD1tQASyOQD4mrqOfHDak95FTQUZWxgMqMqDj/xi0X1PWxWcKm+UJ2cSHhzFj
	 RveA63rCDSTN1lXHKLMVBPNQVZAJYoif7e/dcb5yKOJ+RycejuIuwWtokOez+/DVxUKt7
	 gaI0/DW+om/wQPMQo3kZPnBGMmx/W9lCCf2OR0hx7MeIIc+QsqyBNRC5WiTtZZvgmtA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793360732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
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
	bh=AnNXoHL0cdu3LEJGfT1inBTKQfT9y3/paQ370q3oO9s=;
	b=ZAd3wbb0dZVktqHucHPzGEau+ce6AkTGFYuaY4bzG82pYc0hjqe6P8KtX95zrDtyKI0F
	 QAgyJC6VcSdNct/KvjbHvX3IRWKoBZH9SHLt11+1DeV8m4BCb3LI9DmL1NOmm5QaRCkrn
	 dkfDdDoeWDo5idkiynF2zQ3yEZNvZ8bPYh/j0Z/J/sCV+lMyxjsFC28yHB+eJcOk/lE7h
	 8ocHCnCzvrX2ll+6amYs7SCVOeOFQaDeSHKGbwbUUpHhA/0SPYeKM+eE5r2E04ARL0T52
	 LAw3R8j9vEXX9mD54I5evmJR83c6/+TzkgvzB3UpIDpQBPmWuhE0lrSVlRausDIYBkA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793360732;
	bh=AnNXoHL0cdu3LEJGfT1inBTKQfT9y3/paQ370q3oO9s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vhUjqtGnMiLOLUGy9oqAPyixDAM5UjMgYs8NEsRGP0E5a0TkHsZBItRCSQPQjxTyy
	 qsovv4OVpyzCqOKsLr6KDdVq6o/LiucF7igg8UeosOB1JihUUmyhUMCbuhWaMNYZ5E
	 iSjJipG5moKUoHnLvjmsIfSo93vyj6UXm0U3u7x9wmna/b/Of1CGDkpJeTwQRUOe5h
	 wy4l9XohKlr3evVWoI9wHQBaVh2safhHLGFH/NZB0lCf5+S++GJbZ+e6T7lMLCCkLc
	 S+2qU1QF4SUhoTB5/S64af9foXF9mICT4i531hhU5X3wMO5gc8WiS1fRwsBnLooWWu
	 od9z6qwbpyeAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE3E7606B0;
	Fri, 30 Oct 2026 11:45:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B36794BC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 11:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A586781109
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 11:45:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vq0qUOeuChsD for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 11:45:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7AD8E8110C
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793360730;
 b=UtP+g29kPndBeVgYMcDNT8rWZAVU8wV9k4+k25S3t6SMtrNojNe8rz7qmMZnwevCKjw3
 8HLF7nJagW61s1/vfzo6PNYTnFDoMkvC4klR/g6O8tP6M7O/efnfN+TvkY1bnXkGN0Gid
 mm4bdM6nNpeN2y9Z/5mLHexP3wRHbMHOn/b1Gx9TPhnE/XRt/Dqqp8QALKIxvS5rrvBn5
 E14L9k3pgDPWGqMFjEymBTfLtYX3YAF4FRpwRQPeIy9iarfZCzkuHlXzUjhoCbEDVK6eE
 GVa71PIVOJ61bGkvRdDsirr0nx6rL8krcbanqJvRqLTGvsRvPEZNDw5RcKoah+pd9bA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793360730;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=AnNXoHL0cdu3LEJGfT1inBTKQfT9y3/paQ370q3oO9s=;
 b=IPXUApEqdgE8QoZDC9LmJfrt7h1erv71ZJlb7w0bGDgAtRQkqsli5yEP43y/x1Lc00gn
 7lt8Uu9wJ8y6M7z+Sqf0TgpTljbEfXN5LnSNihJcYfpN5Xd1znAT2qMBUA/L60GfZWZRS
 XSlK0kQ6jIRuABtB0V8oRYHN/6feHFZNyFGtiKYkgCuFZ2KVmsvgChNN5XLR99y00Oyt/
 cqlksobtOQPeUobYVRJXxiuOB+sRI8NGmuFQd6H5jTBfyR9+53bpOeK4Asu7dKt7bDKbQ
 /Sqv5VfYVPJrsPJ1MmA93O8tS84FFVqf9Dwr3RyYv2+j5ZgruTuBNaHwQxcaviI3Yeg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QzBeCkkM; 
 arc=fail smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=QzBeCkkM
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AD8E8110C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 11:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793360730; x=1824896730;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=33odBxDbfCtqAGjDaIxXJ8aeilBi62EovulKMq7HLgo=;
 b=QzBeCkkMt+3skbMn1nsSQpS+AtL4+P/wuNIAUbKks4BHR5esJPER0vVO
 3grAaL1xaWQOlEPW9kLpGjgZp7WfD2XavuljK8i3/a3O0sTXtAV9X4uEb
 StcgMqtCX484YqxS+q7qK66aWj6+Oc3vXJ9+oRpWyggsZ5Z5V+75RvaZ9
 Hcw9xgmIycJ1V7kdQ9N52KxXRyQpibz0BBDPFqDJud3ALGkjUlTUvDLZ1
 OVi3BArQmIrujOcZZl0rqvJMr/d+52/GEdjm168IeKmb/sGwsfNo0UTz0
 CzspMsTfdQNLHWDVKN+2nk1mLpQvDdoDnbRe4nL13mchJK03D0fMSCKVD A==;
X-CSE-ConnectionGUID: gYpapzUES8G+NzuEQehMCA==
X-CSE-MsgGUID: ObQwML7LTQGPTMepEti+Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2013604"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2013604"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 04:45:29 -0700
X-CSE-ConnectionGUID: 06d5krC6QjmN312D38vcMA==
X-CSE-MsgGUID: bEUgbpNJTkiu33VtnoYOxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5294337"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 04:45:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 04:45:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 04:45:28 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 04:45:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ockryBVGE9XYc7LpLYVXnd2ka25zafvcbi+Tk3ESoc3o03sJ3775U8dCTxiiDFbs2PbocqFIdw9DlHAwkwq45jQWthAqQxKA8a1yOsN9188hYBXAj2gP7TcvFnXOapeiMDHtg15MJdeiZqegtQG3F+mASDBpUzmr+IP3vKJcwDBycwHNG67bf7WnXbQB/2axJSyjTY9d0A80RHp0cwI0Xk/Pa3vTk1y01pwJtz5PbrT/DGfURBK/9+HMfxl+of/47gVaMdOZn3H9Ik4+mNj2d0RQfCrsaQ6Siue3DqefRXcclqf0Aba/M7xY904YXIWkosn3oTh/Ooq4o8AnOkBMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnNXoHL0cdu3LEJGfT1inBTKQfT9y3/paQ370q3oO9s=;
 b=hSs4lHuXRedSe+PtcbvqCnV4BPwyoKZfchpENr5shcTVczxsPMONbH8s9fdzKox5s8szrKqKKUUmnn1AK8JOQoQ0GuAUWYflBvROlhrvI69AJ3GicC8Ff1lZKRYQaOU/9uBME3Vt842LBFXkalM/+/kV1atAP01tK/A8gcMdPJU6VnisPhOnOT9S0n8ed9VNU48S98Bvza01KjxTW8d4oHdArvtihNDCln5ys0F30HqnErfES5cJM0y95H0Pi50wTN+/RoQewit/YxeSlsZLl4+wtTOpwvvD84hJEghbugJmOku6NJg1VTjfvYosat0tHM2T6di0s5MNRaL3CXY5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by PH7PR11MB7028.namprd11.prod.outlook.com
 (2603:10b6:510:20b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 11:45:13 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 11:45:13 +0000
Date: Fri, 30 Oct 2026 12:45:06 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <p@1g4.org>, <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, 
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
 <sdf@fomichev.me>, <vedang.patel@intel.com>, <jithu.joseph@intel.com>,
 <andre.guedes@intel.com>, <aleksandr.loktionov@intel.com>,
 <avigailx.dahan@intel.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v3 1/2] igc: only strip RX timestamp header from
 first buffer
Message-ID: <auSDQtz8l8hzzr86@boxer>
References: <20261028083344.3047350-2-p@1g4.org>
 <179331704005.3134.12545545223659652020@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179331704005.3134.12545545223659652020@kernel.org>
X-ClientProxiedBy: DU6P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::18) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|PH7PR11MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: caadc383-e7b0-4a11-c142-08df367b426b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: p0N+k6ORprg8lLM2d7UMZJoDE3GW7FbmiPvDkEJ9rcxJk4Pg7xp+v6H8IQpgm2H/s+MnNCnWJWbehX6OKvsiOxEnlC4DzPLpJs1JiFgQzcdrUtH8ahQa3/YyRB02VyqMU/LmjtGDsQalBt8QpBDD4MUjTBFpKOTV4Cszj/TP/ZwvjiE7mOYpIxRPwotIRc9Z9CmkRiuGTqua82yysnXlzbC8txF/JR+dr1mI3VUR2VhlZMvWbf3+Aaywtxt08aLHUTcV6qVPZwXED3w1NmUbQuPxGJRKgNpHHMwPntjIBcKcmeqHASfxKZBExc8srPzYg+s+6s4zhM7cUFt3t2UQMLu+gzZJnFKNfm6TxBMl3h1U7ORKHUV4nPY5BFoKpDik+DibGGs99R2Mts4FFgwneodIOG9Bdo8+8tQWvw+HmrTQ59LxxgnBGWoHUIhyjSwJWTJWGZWO6DJXUrtT0g8nor39/eCjQkIU+OyZVYHjMPJ2Stz4MJR/QZ5Bv6NaOioF8/QSr7tEndRF+5J5Hn7at+SyAeAPWMESin6DSdQtJcNVB9jPKmYwptXm6XeZZBnXWPulMnwC5E05ohHRZk+AqIqyyU8Bi0bakyE6Q/i+CGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2NIaEw1emFUM0Z1R3JoS3FOazlrdFNNaVZvbm1UOFJoM0c2QjQvRnJpZzNV?=
 =?utf-8?B?eVNBaXFTMmlaNHpqOFk2ZVJEZ3ozV1VaNzNVNFBBanBMU1JGKzUrNTVtUi9m?=
 =?utf-8?B?YlF0MkQvZVMvc3BiNmF2OFpaUGlXUjZmRkZtZ1lxQTlKZUVqWHJqeGZyRjdh?=
 =?utf-8?B?aTJpMWNxY01PTGg3RkVBZ25tZXpDQXAwa3NSdCs1Vk94Tmg2U2thM2xBTGpX?=
 =?utf-8?B?d2FyOGx6NHBsUmxMWEc1QWMydU53VjJib2NUOWUvVkkxRWtiSzE2amtFR1ox?=
 =?utf-8?B?c1dCQWdtcGZYUEdzNGlaN0ZRRFlDQTRhUkhWWVNFcklWeW4yaHBobmJ5aXJF?=
 =?utf-8?B?WTk1WEkvNmx1am5uRXZkbC9yUWZhUHpjUE10dFlFMFozS09OR1J2cTdLTlM3?=
 =?utf-8?B?bHdubzRMV1RlUzI5N3pUbTZzM29McllZc3QxQ3h3L3d3WlFZSHh5bUxGMWFN?=
 =?utf-8?B?d1JoeVhCYit6MFZXOStlYmdIVTQ5Zmk5czVTSlBnOVhNOTFRd3N6N0c5Rk9U?=
 =?utf-8?B?aW9hZmU5cE51N2V3RWVnTmJrWVIxaTdHUVZ2alRXSFNna1IwSXhyMytvQ0J2?=
 =?utf-8?B?OVdQallUQldBcHZFV2QzZTJxVzRMdjJDOEFBcTlXTnV4VmVTRk9Camo2VzVE?=
 =?utf-8?B?TkNEZ0ZzUUFKQ1dqLy9odUNhOTRMNExCdlI1Wlk4NmU5NS94VDd1VWpPV0Qy?=
 =?utf-8?B?U1o5cFN3U3ZrclpjRFVZMTQ3ZTVQOG8xekViQ1REdkloTXlmUHcyQ1RUdFcy?=
 =?utf-8?B?SGEwdTZreDdWeWFrSDF3QWd6RzRiRWtrdXQyVW90SjVlVlBNc2MvbFNrMmJG?=
 =?utf-8?B?WHZPR0pKenhrS3gzcVJVODRrNjcxK0lLVHBRMnpuMC93M1NtWGNaQkJMcEll?=
 =?utf-8?B?elBkdzBhOW45SzhwVkV0UTZ2NjBXUnpjU3FkZ252YjE3bGRuVU9BdTN4YzFt?=
 =?utf-8?B?eEt4TEZkUlcvV3EvVUI4SWtpMFB1R3ltTm1iWTVOcHJBTk5KQnBJWUFuK05z?=
 =?utf-8?B?bEVvNUlRbXRnZCtoM2x6TUZDZ2pJTWNQU3JXZ0xQUERYTzc4OXFlVmtXeFcv?=
 =?utf-8?B?ZkhrcGpFV2luWFBvOERaV0hVTktlYnpScjRoL1owWEVZMk1iMzNOQUJ1d01y?=
 =?utf-8?B?MVJYaFN1Q1B3NjlPTTlZWFdQVW9OWXNIald0ZU9aMTd1NlJUQTBVMThQWWUz?=
 =?utf-8?B?SWpkZDNuVkEwTzNIMmVUQ1NSWC9IWmF2MGJsaEdKTFMwdEdNSGVpZS9ITU5L?=
 =?utf-8?B?d2pPUzJYcXBCbnFrR1hLa1l2bG1DaTJmM3Z4MGdZWmhNYUVQNFpZK3dEWC9x?=
 =?utf-8?B?bis4UVpvdlZDaXRlZW93b0JsTEIyVFZqTmN1aFVpeVlESWdsc1V1c28zMkdi?=
 =?utf-8?B?WFk4a20zWVIvbHpVcW9TQnlmRjBKTkR1cmtQc0M2NFBoSUx1Q01wQzBadkFq?=
 =?utf-8?B?L2llQit0cWlETGRDc0l1eUNWazJGN2dVd0FsS0VjUU9xeHI4RHQrNkV0RXFP?=
 =?utf-8?B?VjFpMnBlYmdpQ041TW1CUWRSa3d1c0FXN01IS3VYdm8ydmFVNFZ2LzFFaHVB?=
 =?utf-8?B?ZUJWZnhjakZmM1pycW5MVnZTZmFXMWdCZXdPSmNvbWRiSFIvSjVaZWlLYW9x?=
 =?utf-8?B?aTlXYXBHekVaNEFoQXdQbVBzcFFuTEFuR3hXK1k5ZHhJOHlZTXhaNC85SzY1?=
 =?utf-8?B?dWo3UTVHUjNLVFFBSSswR1FCNWJEZC93YUVPY0o1RlA3cGZuWXdiZlVPUlkv?=
 =?utf-8?B?NUFJRVF4V1YrZ3pJOWZCcHBiMklYTTVqWndQZi9XelAyVEx3WUNyZFp2M3N6?=
 =?utf-8?B?ZVVoaGc2Y3RoUUs3NWlMUElRK3U1bEtJczFSNGlkRmpQQmtBblQweXJjSWYx?=
 =?utf-8?B?aVVGNVVZY3FBMHdkdnQ2aytyR0s4VTdiQi82TVptMHltRzdYYkRocEFpU3RR?=
 =?utf-8?B?NEhIWm8zaEowaC9PcXlJeWR2YjFWSk93djR3b2NwLzlzclJMR2toaDZGZUIr?=
 =?utf-8?B?OGQrcWRhOGdSY1daYXhCYzdsUzY2TzNUbTlFRnY2dzVNYkhEQlNjRUVuc2dG?=
 =?utf-8?B?NFI2Ny8vQzQvNk1WdDdxUk4yUDIvcGQ2N0JZeXo1MzNhOVpKMlorQXlCQkE3?=
 =?utf-8?B?NWl5VFErUXdwTWRab3oyeXdrVjZvanFNdk1RQlFIK2JwUUhHNkFtQktIUU0y?=
 =?utf-8?B?RkpGL05ta2pTQWR2bjZBeFlvbUxhUE0xSm9MU1A1R2lHQ01mSG8yUElkN2N6?=
 =?utf-8?B?aVlqNGNEWERTalBaUHg0aW5YNzdEbjNZMDFzR2tyK1lZT1FITHptRS9UNm9r?=
 =?utf-8?B?RnRSQXIvV1RwTTkzei9BdmtNUGJHWnFNeWwxSWRKMEFtem15akRQZXFyY2Vk?=
 =?utf-8?Q?FWvmzszsc3OkULGo=3D?=
X-Exchange-RoutingPolicyChecked: HtCAh7TiyBvtUysKdmcRJEhehGFO4JKJIo4sH7Kb8Ve5jkEPO3cAsQmga+p6o1zqEw1h5cHWcjKPNscVYw9j5Dy/gQeC+LyC9+gYiLNOqnycVVPY/eQgrnrfbFi/Sk6QwyZqvOQoT5hEs8roSxrQXwH8VObjX+QPhQYAFCHZ3xoVIrmXhyslDkOaz5G238Dj2iUrb2Qw5dlHx9JRcrmiw9oHbXT84Whcyt0yZ4pEiAuLn2LpedA4tBu+4z1lU5rhitCL6R4/Ho3bruQ78lAbqLMDy00HuXDi2mXxF1Vvlox1zp9Ji5D/pu0LijdK2w285BlPy85eD+zHnzJ9azViqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: caadc383-e7b0-4a11-c142-08df367b426b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:45:13.4201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdTYhuJ0OmZd33fkVHsCe7mSLkQDmKqnIY1sMwATNin8Wt5EU46ObZ9WROat8VLdQFoDI6jDOK39Ip9bweWE0C2HPQRuq079n/0IFIqE7jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7028
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:37:20PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] At this commit by itself, the new first-buffer test `!skb &&
>   igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)` in igc_clean_rx_irq()…
> 
> --
> 
> igc: only strip RX timestamp header from first buffer
> 
> igc_clean_rx_irq() used to subtract IGC_TS_HDR_LEN from every descriptor
> with TSIP set, which truncated multi-buffer packets. With this patch the
> timestamp header is only stripped when skb is NULL, which the commit treats
> as marking the first buffer of a new packet.
> 
> Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl/
> 
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 1fb5f3cbe93c5..41b293dc10c3a 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> >  
> >  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
> >  
> > -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > +		if (!skb &&
> > +		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> >  			ctx.rx_ts = pktbuf;
> >  			pkt_offset = IGC_TS_HDR_LEN;
> >  			size -= IGC_TS_HDR_LEN;
> 
> [Severity: High]
> 
> Is skb == NULL a reliable first-buffer marker when an XDP program is
> attached? The commit message says:
> 
>     Only consume the timestamp header when skb is NULL, which identifies the
>     first buffer of a new packet.
> 
> Suppose igc_xdp_run_prog() returns IGC_XDP_CONSUMED, IGC_XDP_TX or
> IGC_XDP_REDIRECT for the first, non-EOP buffer of a multi-descriptor frame.
> Then no skb is built, and igc_clean_rx_irq() moves on to the continuation
> descriptor with skb still NULL:
> 
> 		/* fetch next buffer in frame if non-eop */
> 		if (igc_is_non_eop(rx_ring, rx_desc))
> 			continue;
> 
> The continuation descriptor still has TSIP set, so this check strips
> IGC_TS_HDR_LEN a second time. If that descriptor holds fewer than 16 bytes,
> can the unsigned size wrap here?
> 
> The continuation buffer then goes through the new-frame path:
> 
> 		if (!skb) {
> 			xdp_init_buff(&ctx.xdp, truesize, &rx_ring->xdp_rxq);
> 			xdp_prepare_buff(&ctx.xdp, pktbuf - igc_rx_offset(rx_ring),
> 					 igc_rx_offset(rx_ring) + pkt_offset,
> 					 size, true);
> 
> In that case the XDP program would see a data_end about 4 GiB past data.
> On XDP_PASS, the same size would reach igc_build_skb() or
> igc_construct_skb(), and the __skb_put() there does not check it.
> 
> At this commit, XDP with multi-descriptor frames looks possible on kernels
> with PAGE_SIZE >= 8192. igc_set_rx_mode() only clamps RLPML under the
> small-page #if:
> 
> #if (PAGE_SIZE < 8192)
> 	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
> 		rlpml = IGC_MAX_FRAME_BUILD_SKB;
> #endif
> 	wr32(IGC_RLPML, rlpml);
> 
> On large-page kernels, RLPML therefore stays at MAX_JUMBO_FRAME_SIZE while
> igc_rx_bufsz() returns IGC_RXBUFFER_2048. igc_xdp_set_prog() only checks
> dev->mtu > ETH_DATA_LEN, not the hardware receive length limit.
> 
> This needs RX hardware timestamping enabled, an XDP program that returns a
> non-PASS verdict for a first buffer, and a peer that sends frames larger
> than about 2032 bytes.
> 
> The next patch in this series, "igc: fix AF_XDP receive buffer size for 2K
> UMEM chunks", adds igc_set_rlpml(). It caps RLPML at 1526 bytes whenever
> XDP is enabled, whatever PAGE_SIZE is. It is called from igc_setup_rctl()
> and igc_xdp_set_prog(). With that change, XDP frames always fit in a single
> descriptor, and skb == NULL becomes a correct first-buffer marker.

Wow - finally.

> 
> This patch is tagged Cc: stable and could be backported on its own. Should
> it depend on that follow-up change, or should the two patches be swapped in
> the series?

How would we make sure both commits from this set get actually backported
together?

> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028083344.3047350-1-p%401g4.org
