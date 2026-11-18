Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABBA60A2603
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Qa1JW6mH;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WEBrkKPL;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=L2rdzyGA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 021BA8121A;
	Wed, 18 Nov 2026 14:27:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vvLTTiXhsHPo; Wed, 18 Nov 2026 14:27:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28D5381225
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795012040;
	b=ppqFqRGy+yCEdbSg1p81IQU9ECkuXW3jDGi+DzDDQR9ZFXMvxdEpCk4g99pw9nACnRJD
	 VDeSeiNYqZlvNtm29z5NPudfTbQo9BAu8R0jydp0LUm9EznsVVp12t2GFD48EpHJyPzdu
	 oFi8JrjIoeSWBQkpNHhbR+lV9OFOeEVrPpLHbofAM8pYBxTZIjMQcUAZvJNNc2qMuaeRO
	 bQ88DMsxSKV5KhCaoi87jb+EW8CIXgH4MQ84Uh0PmNamEnRx9EI5IdwF37brGte9kcCwW
	 CZVfXa0EJRoxCm9kWfGaYL6t2w/wpfr7jtxQTPDPic7nNFQ39S2rhDrLXF3fgCky4PA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795012040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=vEbhJfZkTtaPsgQxZTNygKGDVLdH6lTT/fSGmFBELCM=;
	b=KSXZURwV5cNQaWWydUZtT+JhEdqjG6D/tDSVVxpIUMNTRyj//9LCyX6P/S50/kIk7L/3
	 KHSxQOLvxdOSYCSsGaLRxQL/XeTW67t+MDzJdbIZ3bHtE24WPwWUcxYgLshQmnbfyEPIx
	 g4jdtuzQOk0n78OjrPR/OzU/1oBXqpKl4yu33J3NOMdJLXzj3WSqQ29AihBRBrPRtQB4/
	 5XFy2rSYViwE9HB9xKJD79hhCKQJIFlXKTGtNjEx74E5Hvf+JawsBZRPhh6P2MHBUAoOQ
	 lMV6dvOWo8BLGu37EKfDiKaym2ivSJf34F+kk6L+bgSBU03DFPFCY6DDIqInKdQHvuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795012040;
	bh=vEbhJfZkTtaPsgQxZTNygKGDVLdH6lTT/fSGmFBELCM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qa1JW6mH45lSQxRMlynPkuQxxG3Lb49MuQQm/bAqNh/CPUxziM8txgbCLg9mviQvM
	 x0t4h6mi041b8nZH/3o8m0Pmst4txyFdfcvhCCPTTCWkQeSTiQXbhkmC/SCMHFamgj
	 VH0F0RPZoV0BIzJs9efY2MNdqpXk5tUJT6Mgy5Sf32zKVl7Dkp1EcyR+vNK+HwAW58
	 gLdoa7Eq69A3B3dQKrmmlRJdMLPrWymTOAXcBtt5xGhc2va+mKEnpfPqiAD0hl9LPE
	 EyzvXAw9fKJJQB1sywbRBmmLQHsTzuwf80ycRnlnPv9TAVKaDp+AppHEWfMvopJH+x
	 mB+Uim8vX6YpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28D5381225;
	Wed, 18 Nov 2026 14:27:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6341D70B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49C0540A06
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PDxGBbhbNuQx for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 14:27:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D4EC1409D2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WEBrkKPL; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=L2rdzyGA
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4EC1409D2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795012036; x=1826548036;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QPut77wSD8RQBCrb9zNz3a8wB6i8wRK7pyeHuElZ9hQ=;
 b=WEBrkKPLQUYQ0aUOemP2F+SO+metU51C6pzmKmn7a8xS+Z61RRK5vT5i
 I+LSisLoYTXK0fja4BlmA1O1C+XO8/rOqrj/8Y0GGNxrW4TQdQPT3gyvX
 2j1ZyU6l3nwbkqC46uVOU1ZAp/Cb3YeFkOGAtFAgEdddF2OdkIu5d2rqb
 AvwWUfmz1H5sWzm29x/dsyasjGkCgW/LX/MNc0WaBWlB3cPj2VhBiYOfs
 WSymIdz+Wt8Pkxy5/D0Hh9CMuegrQrj6Mhq3Qwb3sV/BOJuMCuFRE3A2a
 TQfyyGNqa57XGg2SSHwcAuBU8bkq8rxiDKC1QQzJftznNFUtsIxPt4RFk w==;
X-CSE-ConnectionGUID: +F9PlmYRQKub9akutapwHw==
X-CSE-MsgGUID: ZynEtr01SGGPT0ouBanxCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3682595"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3682595"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 06:27:12 -0800
X-CSE-ConnectionGUID: 92i958B1SyShWLJXocqghQ==
X-CSE-MsgGUID: htqMjrgSQ++EDB8Wl4r6Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10242924"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 06:27:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 06:27:10 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 06:27:10 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 06:27:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEbhJfZkTtaPsgQxZTNygKGDVLdH6lTT/fSGmFBELCM=;
 b=L2rdzyGANZ5ULR94vNfXXA/5LuxTm8j55XOhwcTilb6Anp1o/5btq5eysnv3pvrFv+te+8U3Ru8OJwVuklaNOcuavY4BGSSHLVQspoQU5QS88KcPq1ivzxxJkqYL7nRTGpRsWyWw2/69KZYIt+ZAHvjABeILSCm+F/QPbhINWfs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by LV2PR11MB9597.namprd11.prod.outlook.com
 (2603:10b6:408:379::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 14:27:02 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 14:27:02 +0000
Date: Wed, 18 Nov 2026 15:26:57 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>
CC: <magnus.karlsson@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: use the queue pair's XDP ring in
 ice_qp_{dis,ena}()
Message-ID: <av21sWxL2vEiJspz@boxer>
References: <20261118135952.1063685-1-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118135952.1063685-1-magnus.karlsson@intel.com>
X-ClientProxiedBy: DUZPR01CA0149.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::25) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|LV2PR11MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: 0402d941-fcdf-4b18-c78e-08df45800310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022115727099003|261022105027099003|56012099006|11063799006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: t8BQX3pmN7pDqVBYbyvniFZ2GS07FC9n5sJdfUOGLEOUQ4k4chqREjtbqD7M30c59T0jzHdZNOWG9aBRtlbelqnRLdVx83wSACGX9M5bJ+JjU2JPAqzpH2NLpp+dzp5ORgSMfRdkQ7vn8A59jT7RB0yiJ8cziQ/gCNM/fjR6x/T/njjw3CfAKUCIAGpdhnEjsmhqUtaIx+kaNC/5mTkv3W4v26lswxk4WB2VJlOy3FrnZdFG0vw9jJhbgnBqnSgYRK96buQ2wdKTGhPcGtNVF3SSlC+6QvaMHb+nP7l25/xOtbuAuJsekM1lzoE8z6SZcG1PyZFNl4KVkkwRvFaH6mrG6+0xBPYHey8KvD5VrfuWFePKvc6x1rq5CvB6Hw8EurAj/uT/DVhwg5aWtSXFHpJHg6kalg/V43TOTyQxk4wcB45tVNB4YD8LxUmKsz/liXU6LRSl9PO+yWnlscqFxYtQSoC+iTzT2A7eFCy6Y1zYfOvRTc4L6v6MsIsF6aABGQbf6nzIjyNuVPxsE04ElLCzhkdt4UsCu6o3LfL0cCXhH9s8XDxrSowHwbTQJEDvpmoEth4REH31oT2/MinwJOwCxUKOjbwT0ZyKtvQOyk54fGpSv3zf9S6q2XdGy8Eh8U5ukDKT2aHxdi9sg/SuKKyYA6e5cHDxe636GQ8jKHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB868673.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022115727099003)(261022105027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fozEMrw9pqe1cAdZHnmtCSafgfP6AQ+XTdpBpv9dtLvq5lydyWo+JlD5S0GG?=
 =?us-ascii?Q?Y+LeFNFLvpYNLIglhXRNPxGdpz4iCyxl3WV1cZA2Y9qhH/oSLzF4U2cFlkxY?=
 =?us-ascii?Q?3s0ui2SMKcIm40FJ7BNe6tS/zbK2heHsEv0oAwdUw2HQwP9bJwtqOtAr8WBM?=
 =?us-ascii?Q?2xO1zyaEFGgeknbP3WtCHVjaVr6mZSGH+qeBkr+TuO74Z7XAPl7SwL4t0Nzi?=
 =?us-ascii?Q?tYHIYjQYkufcO7vNEP0dC20Vxxrhn55oBnCsHYjDVk3wx2cmkKTRrHdOcPEs?=
 =?us-ascii?Q?mvg+6dLG/8Pi24kPTq6OFKmeFl48c/0tZirv0FOrdMwbYPZlzlr6iUdw7QJI?=
 =?us-ascii?Q?TiNDZp3XF5zd3/C81R8rfA4HbMRllm19aOo9yIi68SZj+DKoZz4KlKtUPX36?=
 =?us-ascii?Q?dV1GMQFAiySwFw+93MPmmzB7P1059YQCAcYHW1fzrQQ60gddihQEmd9sWKQX?=
 =?us-ascii?Q?2f4z1cVcLI4bun6S6vz168u75VVK71UnzW2oyNNVaOJWvz9+V/yuLIDIGUcy?=
 =?us-ascii?Q?hUU+kuxJTPo9OtzkzeUkxHyAyw4WXJxDL4M0rJTcMokCqh5DMt9cvtFTVG2u?=
 =?us-ascii?Q?aP0gIbgbwtu6f7K+4aAV6UuqjDZWVY2SDzVMr66Gvl++Pp+DExCzRD1yiwkD?=
 =?us-ascii?Q?pzt7o3lm7vtZIXiQl9SY5LxXVgyYjxPhQmz4QQP7dPRcq9ktmsV9SwNhAiy2?=
 =?us-ascii?Q?mjPfy3/f99CXJ9oZg6/oCv2AkRB2R/4ov1lqoU5zQTPkDHp1+66FG1vSjWy7?=
 =?us-ascii?Q?J/8Sqs4WHVj9P0wvIsmIFaQD32naTf42TVhwuNr6BmccCZUoYl4G1Kiu9nw+?=
 =?us-ascii?Q?fUBYONtizdVriMOTSoIgB2u5l1giQvuBqhhalHxTEpjoZd+ykJwgg16N2GMP?=
 =?us-ascii?Q?75qbvmbtBdnMYwpLeeapqbS+HLKw4x7NzWPjYu6bepFuoHsjvO7ZkLHzzlQ5?=
 =?us-ascii?Q?cTcyDzHfvuDX9CEPCxnMu0tqbcAyMbKRfc0y5Z9qPjiqsxKnqNjtyUI7nFue?=
 =?us-ascii?Q?2cqRLPYohSa39AwvS2KHYmw0hUZkfTXQYSp0lsn+vTm+PoGnv2h7ju1o0r3N?=
 =?us-ascii?Q?669rU1NfMMalQHMDQDoSeo/479YDqcOEBxxlU5/KWqPPsyXrPHbtty+1pvUY?=
 =?us-ascii?Q?brWUeFB523rdIA/5hbjPn7MNVzYvpaKVFxFmKooBfPpbwRxz38w/PfacarzX?=
 =?us-ascii?Q?Gk7b1OzxGzIY3lezhbni5MV0cCDTpcrMaGBdaLp/zJgNuMCE+e52Guz7k9DQ?=
 =?us-ascii?Q?EkE7EF4mzRkSzpDC7kiuyhLjdZrmi0bfNQca1xabe10kOUqV4m/aMrKDaSZa?=
 =?us-ascii?Q?M4EbdjUgiYyu/0pqPYyZpqNthfkX0/hSe2HY6aL2syiG6F5cILNUk1dguTPQ?=
 =?us-ascii?Q?sfSOu4GZIZUARm+67eqPcJbCpgUvQOQq3DJdGzG3P9tHnmKOO81CHffL8PRP?=
 =?us-ascii?Q?hIkh1k01HSJZW1cb7SPvAlx1wgXJ2csYwR/VZW12I4PDdUfBvBPLsqzLcslT?=
 =?us-ascii?Q?MjJ+vxmLRHLUOhk/Czy2ldyflS4KsSEQAUoFw7e7aUqb2p3MNBO6XzXRB0dg?=
 =?us-ascii?Q?Sd+FQ5UMOYaGBU8u7kutMVCOXRAHe1nTHmyQF7cJe1eea1WgzGWun6+eWeNA?=
 =?us-ascii?Q?jcBy1sEtX8DG2+R3rXiqE7NFdhqQdLoJ+LGKeKQ3lJCcC7DR2WqJ0QzoOTRi?=
 =?us-ascii?Q?jmPZeqoDcWcH4Ofr0fPClUO2chdLgJYUWTmzCtZHu7HbZc8cQAEypEfZiv3W?=
 =?us-ascii?Q?ArqUC7wdekDke8tCl4zB+iQymRKplfg=3D?=
X-Exchange-RoutingPolicyChecked: s0+L8egh1tUo+gfAYqLF1e2gaqe1aAJP8UsCFhC8Hd3SSdF6LiH7zy+jUj4+aE60q967eWwQRZIEmum1R//43niVxhJesC6e0AVbTLZEBPh1JJhlhBuTKYj/ipkm3+m87dY2kh7c7gupHQFSAcat7zlYC9ceCra1HbHW8BtZGE1WnwmUm7C7TS2K6Mq2RNLfq8pmQ4IH/IB/9no4dDjfpfmnozxwZk7MrA7EUvcD6tG/rxg0MJyxJZpzliKQ2i2/uH7zQ8MD+40UT/q3BE8zAFR8e8K8ue4tIaYi5X77nERCpEUZHwPOFLq1zKIjcQQN60UbcMXoPYpkzV3Cag4aXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0402d941-fcdf-4b18-c78e-08df45800310
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 14:27:02.1081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX/RK0HkNfb3XGAFIlfcZ3HJWVhUm+RIq3JyTI51IdeYNU1qOMh7m5vRAXQZwl4P/EXlvcWafJX5lzmQWr60+A8uOaLEKFxbSFmT4R6x29k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9597
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 02:59:52PM +0100, Magnus Karlsson wrote:
> Since commit 9ead7e74bfd6 ("ice: xsk: use Rx ring's XDP ring when picking
> NAPI context"), an Rx ring uses the XDP ring that is first on its queue
> vector's Tx ring list, both for XDP_TX and for AF_XDP zero-copy Tx. With
> fewer queue vectors than CPUs, a vector carries several XDP rings, so Rx
> ring N then does not use XDP ring N. ice_qp_dis(), ice_qp_ena() and the
> ring cleaning and stats reset they call still operate on
> vsi->xdp_rings[q_idx].
> 
> As a result, a zero-copy pool is attached to and detached from an XDP ring
> that is never stopped, cleaned or reconfigured. At the same time, another
> XDP ring is stopped and cleaned, possibly while it is in use from another
> queue vector whose NAPI context keeps running.
> 
> With 4 channels on a machine with 8 CPUs, for example, queue vector 0
> carries XDP rings 0 and 1, and Rx ring 0 uses XDP ring 1. Disabling queue
> pair 1 then disables the NAPI context of vector 1, but stops and cleans
> XDP ring 1, which vector 0 is still using.
> 
> Use rx_rings[q_idx]->xdp_ring, the ring that ice_tx_xsk_pool() assigns
> the pool to, in all of these places. ice_vsi_cfg_single_txq() checks
> its index against the number of LAN Tx queues, which an XDP ring index
> can exceed, so configure that ring with ice_vsi_cfg_txq() directly.
> 
> Fixes: 9ead7e74bfd6 ("ice: xsk: use Rx ring's XDP ring when picking NAPI context")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Yikes! Good catch!

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 42 +++++++++++++++++------
>  1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 1667f686ff75..aa0ad313a97c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -1386,6 +1386,22 @@ ice_fill_txq_meta(const struct ice_vsi *vsi, struct ice_tx_ring *ring,
>  	}
>  }
>  
> +/**
> + * ice_qp_xdp_ring - Get the XDP ring used by a queue pair
> + * @vsi: VSI that contains rings of interest
> + * @q_idx: ring index in array
> + *
> + * A queue vector can carry more than one XDP ring, and Rx ring @q_idx then
> + * does not use XDP ring @q_idx. Return the XDP ring that XDP_TX and AF_XDP
> + * zero-copy use for this queue pair, as picked by ice_map_xdp_rings().
> + *
> + * Return: the XDP ring, or NULL if XDP rings are not configured.
> + */
> +static struct ice_tx_ring *ice_qp_xdp_ring(struct ice_vsi *vsi, u16 q_idx)
> +{
> +	return vsi->xdp_rings ? vsi->rx_rings[q_idx]->xdp_ring : NULL;
> +}
> +
>  /**
>   * ice_qp_reset_stats - Resets all stats for rings of given index
>   * @vsi: VSI that contains rings of interest
> @@ -1393,6 +1409,7 @@ ice_fill_txq_meta(const struct ice_vsi *vsi, struct ice_tx_ring *ring,
>   */
>  static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
>  {
> +	struct ice_tx_ring *xdp_ring = ice_qp_xdp_ring(vsi, q_idx);
>  	struct ice_vsi_stats *vsi_stat;
>  	struct ice_pf *pf;
>  
> @@ -1408,9 +1425,9 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
>  	       sizeof(vsi_stat->rx_ring_stats[q_idx]->stats));
>  	memset(&vsi_stat->tx_ring_stats[q_idx]->stats, 0,
>  	       sizeof(vsi_stat->tx_ring_stats[q_idx]->stats));
> -	if (vsi->xdp_rings)
> -		memset(&vsi->xdp_rings[q_idx]->ring_stats->stats, 0,
> -		       sizeof(vsi->xdp_rings[q_idx]->ring_stats->stats));
> +	if (xdp_ring)
> +		memset(&xdp_ring->ring_stats->stats, 0,
> +		       sizeof(xdp_ring->ring_stats->stats));
>  }
>  
>  /**
> @@ -1420,9 +1437,11 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
>   */
>  static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
>  {
> +	struct ice_tx_ring *xdp_ring = ice_qp_xdp_ring(vsi, q_idx);
> +
>  	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
> -	if (vsi->xdp_rings)
> -		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
> +	if (xdp_ring)
> +		ice_clean_tx_ring(xdp_ring);
>  	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
>  }
>  
> @@ -1435,9 +1454,9 @@ static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
>   */
>  int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  {
> +	struct ice_tx_ring *tx_ring, *xdp_ring;
>  	struct ice_txq_meta txq_meta = { };
>  	struct ice_q_vector *q_vector;
> -	struct ice_tx_ring *tx_ring;
>  	struct ice_rx_ring *rx_ring;
>  	int fail = 0;
>  	int err;
> @@ -1447,6 +1466,7 @@ int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  
>  	tx_ring = vsi->tx_rings[q_idx];
>  	rx_ring = vsi->rx_rings[q_idx];
> +	xdp_ring = ice_qp_xdp_ring(vsi, q_idx);
>  	q_vector = rx_ring->q_vector;
>  
>  	synchronize_net();
> @@ -1460,9 +1480,7 @@ int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
>  	if (!fail)
>  		fail = err;
> -	if (vsi->xdp_rings) {
> -		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
> -
> +	if (xdp_ring) {
>  		memset(&txq_meta, 0, sizeof(txq_meta));
>  		ice_fill_txq_meta(vsi, xdp_ring, &txq_meta);
>  		err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, xdp_ring,
> @@ -1497,9 +1515,11 @@ int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
>  		fail = err;
>  
>  	if (ice_is_xdp_ena_vsi(vsi)) {
> -		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
> +		DEFINE_RAW_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
> +		struct ice_tx_ring *xdp_ring = ice_qp_xdp_ring(vsi, q_idx);
>  
> -		err = ice_vsi_cfg_single_txq(vsi, vsi->xdp_rings, q_idx);
> +		qg_buf->num_txqs = 1;
> +		err = ice_vsi_cfg_txq(vsi, xdp_ring, qg_buf);
>  		if (!fail)
>  			fail = err;
>  		ice_set_ring_xdp(xdp_ring);
> -- 
> 2.38.1
> 
