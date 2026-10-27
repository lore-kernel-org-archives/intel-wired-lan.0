Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2334606A31A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xNZJK38c;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IroqPUec
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D24F406DA;
	Tue, 27 Oct 2026 09:11:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FpT-IVpVc1Og; Tue, 27 Oct 2026 09:11:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A53D2406CD
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793092290;
	b=ZqmKQ7jfB6JQ1Jo/8/ctXrW1VNf2/GHYuU8j6Q2y+kWnxoQSkD6zJ1VWmM02wh3Fue6u
	 oq1GnoekX8q5R0LLfWKZXogiYa3j6Lec5OsW5/qnN/d9YshRjMg+AR9hHyxqDYZvRFpsX
	 LInG+w24YJmfdkPGxtXVsplycVvUBZ4Wg64h35ThsEXGOAedAyi4aAH/Npe5bM/nDhu39
	 GDJY75VBMGTkOzRa2UbmmNJRgHqCYvFBycvVbgGP4cnp4sWQuTYAFaWnZr5yn0JOfh7TN
	 feVdkbkBhiy/lCC26UGgRj+CzZUmrPTgMnKJqIo2Ar+wxZWJkUYPU7Yn76KObRwVkwQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793092290;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zc/dd75ya5663ZliA+VTJJF4MpjlpBVOdxpMiUVoH1o=;
	b=phyRJfl0c1l4xiQ70uWezqNU6t8HbfjaEdZF7HzG4yrV8ejIVzKliW0FRJfZQIOJ3uv4
	 Zfwd1XQM0GcWtE8kfPg5P7t3g3sEHxL85OTirhFZmJfHkifhsk20gPZQBilttdIRLYIwl
	 pWE++FRs9jf6AJ3SlRwxAzy/YNBsvXHtV/YmCVEtrfFsEeeRRav7OTMY2ejuqJZRqIiGD
	 LfD9SgTrB6NPoYIyQKNd9lemSi2U9OEzdITHfsLIc7RAybT4lPStN468CKfkpDJHLDMRf
	 O6IRgnCRfvpx+p8YZBg7Wu6fKqNGP0uiywz3q6Ds3N1iGI9ikpzw8+Vt1paxYM41lyQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793092290;
	bh=zc/dd75ya5663ZliA+VTJJF4MpjlpBVOdxpMiUVoH1o=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xNZJK38ccHx5sddPLIHAwmte76CmIEOkT7W0lN/LEuqAj79qOSRbgGenuqtTDmWVB
	 qFp6KkEbfIeDG9KVIcR+FguNmvw7rWUq0klNOIuvqcAjX4vZ+XgxAFJR5C6IxC+jTJ
	 PKHQ0dfeKgHEgmH+lCp6lwJ2//dwKeIZuy6CWmTu8bFavvy7vrS53SBHLE16qGYFNk
	 ud9j4WsqpKObOCq+HftSson47Em/IClePjZC1QOh6bNOv9AJID1U2zkLEx2y09LR14
	 oqQtVZSE1WRfIgf5FJm2newwPAf3/3FrCxrv5ffZbfvJ8V5Q8f0Ky1tqbNV/OzjST9
	 BtXV/LrSI0l1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A53D2406CD;
	Tue, 27 Oct 2026 09:11:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4764E1DE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 09:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 393E1605EB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 09:11:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tYgNo8rgDDlA for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 09:11:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 04CF0605EA
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793092288;
 b=VWhSm6gAgPv6qxFjK/d97D0FJO30fq4IBXljfGDSJxFod9uNooiE5k9NPAi+I80WBt3P
 DQIGi9IjqFpz0recHkllQn3k0dBlKHZSFhqU8kSsau01mq1CckDPYUruU/pYETKQrcKAq
 tedd3wMrOg+UVuAIutX3WyAKdJ9hT4Oe3AEDTUJGe7b7ARy7tgDyOKXN9jDP6JS3+tclo
 A7DV6AdW3SPPK6+cYBLk+vMUUCYiZTdIDLB2U3aJ8C/gLZird1Sg3IVY8saUwVEIGO7eF
 6LP37Cz5JdHscazWKb1gb/FEawiwPj4TmY3/OGN4nzeK6dJvEF0JPzj7whrmJZpaTWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793092288;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
 References:Content-Type:Content-Disposition:In-Reply-To:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=zc/dd75ya5663ZliA+VTJJF4MpjlpBVOdxpMiUVoH1o=;
 b=BIrrHKW5jIgvH5o34UJ9hRbfD2eNDAlbfMrmtZqAWROdr8WCyZr55CAW+OSEItRjmln9
 QXzFxuYx+cfO3NSc+SwPA1PbkojhKgnQQkjggo42ZtG+CdzgI5AZYK0OTVAQvPUIS+OYQ
 cplGpk1ZvBvDBUc4cuW8RJV/oDVi4scJpcRVRvBeQHSDkLli6zseBHQi4A3E0nQacgv0a
 c4E5SEYZtm4blO8ASOctbhNmQASsT6MWC4ipNEqtkS2Q4Yyf65/Y2LjoyIpkzRnaZQ3Fb
 B9DoExQ/RNuBPhhhw0ec57Z04s5hn/nSj44HH5cAOA8N5RN3PxaHabloOmQ4CchnSMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IroqPUec; 
 arc=fail smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=larysa.zaremba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IroqPUec
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04CF0605EA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793092288; x=1824628288;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=20xiOXZW5uTchT11ddO9jwea5CvrcDOoVZYyiz0tF6A=;
 b=IroqPUecLvYS/jqcrd72VOCNkl2yI2yDGHWyGhIyBI0Ksi1vROxTXHft
 PCju9kVqmUuYjAXx1ZUp3C7ixgIRqp9IbaY+Vm3aC/QzbWlA5Z/qbAygD
 yFZyXZ/Yo5rvFPa+dp21c9yllnwEVsNmCjQKh7KV7qsfEnMVFkLZQoeZj
 VkRF1ESPT9t1VcYtqerXarQGEx1fq9iR6IOgEBqqnL4esZdRmfjE6Zxxb
 FIc04EbGoCRN3v8nYtDUdF9h+1BFFcbbP2+BYmsNruEzkXdjcLablviJw
 PGR3LWMPlosW3EogGLxE2haxtbC9x68VXh+nofPeCxWsZYb/arClhI4Ux w==;
X-CSE-ConnectionGUID: amv7gxi6SaeHf5iGwfhRHg==
X-CSE-MsgGUID: F1TqjM0vTIiMZ4wbPQ6DNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1663276"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1663276"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:11:27 -0700
X-CSE-ConnectionGUID: /4vxixbkRxysp8TQHZsX2A==
X-CSE-MsgGUID: 9svXPmfpS46tZklLhTyhDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4491222"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:11:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 02:11:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 02:11:11 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.17)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 02:11:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lk4j8vnOgXgvledybXEHaX/GhUG4joW4aVqP/jl+rSs2s8le0802dEHvZJM5NuEa+fH375u2KBPmxf9B96jsrVF5ZH88znWuiJfenJJ6kAqXEXAyy5n6GoIIwr3gsLSdwL+Nqq1omMspetDBt1quvcsldthnWAT0OOZeK8XaN3TvlU+ZLnE64Md54Ua8HaSXGtkxE5Yg6XGKnYS39USeV9KB/RCd2XtsNIcuWelA31T+9L2Ao11bxWRU8lfU8qCoWDcgwBHy3L6cUM1jbaUZfWDNBneQ6wrjdNdaEARHqfpmMCpq+m1i0YaoNCwHA4O0jyHm3JVRkZErJG3oFRjWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zc/dd75ya5663ZliA+VTJJF4MpjlpBVOdxpMiUVoH1o=;
 b=eIGq1ookTG+TRrdj4JyTgiSRjAMl4/q13bKUNkn2WwtPsP8D71LrZG1MQVhLJ3AwjQfIFjgCRzZwFMGqaEb9hE2TKBmWFjNu1ij4VX7gLiR+uwbJO9pkPiqN8R5c2G0fY77ABVJftF2Yg0Mu5pcWuuNm7GotbCRSpZA7TXlPKlYkEQY31Re1f30iBC28l2IZM+zlC2x4GLcbbqkd23TKe/8obhR5BE5fsozEOQiC+Sf1iJPpvjnNrKEplgTMpIi2iCQgXx6mdptskXtTa6UW5ld9yJTj7I9yTaA3IC46TF9GFGfmyk3cpX/bM25yja9prWr7LM1GzGDgbWKwZRLX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5363.namprd11.prod.outlook.com (2603:10b6:610:ba::12)
 by SA3PR11MB719904.namprd11.prod.outlook.com (2603:10b6:806:53b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 09:11:09 +0000
Received: from CH0PR11MB5363.namprd11.prod.outlook.com
 ([fe80::7c3f:4695:868b:ec9d]) by CH0PR11MB5363.namprd11.prod.outlook.com
 ([fe80::7c3f:4695:868b:ec9d%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 09:11:08 +0000
Date: Tue, 27 Oct 2026 10:11:02 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Emil Tantilov <emil.s.tantilov@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <phani.r.burra@intel.com>,
 <joshua.a.hay@intel.com>, <horms@kernel.org>
Subject: Re: [PATCH iwl-net v2 3/4] libie: release all waiters once the
 transaction manager drains
Message-ID: <auBqpvpNx3D1e1Sl@soc-5CG4396X81.clients.intel.com>
References: <20261026221908.24690-1-emil.s.tantilov@intel.com>
 <20261026221908.24690-4-emil.s.tantilov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261026221908.24690-4-emil.s.tantilov@intel.com>
X-ClientProxiedBy: VI1PR06CA0132.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::25) To CH0PR11MB5363.namprd11.prod.outlook.com
 (2603:10b6:610:ba::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5363:EE_|SA3PR11MB719904:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e10fd3-aad8-46e3-878a-08df340a3c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|23010399003|1800799024|261026121527099003|11063799006|4143699003|5023799004|56012099006|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: /X4RFWw95UVUu7Vr5zQmOsrWwzhWb9GeDzFW5xIsH7Z+jPtMtmejLPEJMO638e00OCYT3oOabrY29f/w2cy7gRM6jsp2MMWBWI5aaVCJt9aA4JUbdtfRKWlics2maH5hQ5EkVORV5ZcC5+h8lLrDq6F4oXAlTqqso0icSpt518UQJG/tHJokUe/W8C6DV7RTaGZk4DYdKN6r372cHAjFtH9WSTUBXSb19z+osqc2GA+UfrQaHoR1oC8cOwwuwHQLEfn7sS1FPrAGYOyYowcop8fDF8b2JiQ7laNjTl1/S4UsLDqSn6q0MG6hw+lpTk7DE2NtzxxMMuayiwT0+kcjcqS1KcoAUSuxGQM3BBaxMnhSA7GOLgyo4CL/yv8V3Q0+z87ZonzDb+fATy+BWaSXBU2bPMg8GNzlKRmaCJxSkGjndS2Wrb+aBk/hf502Llw0serrVqRsGnvFs8KwzbYix3acsqF/Oq8ksK5oNT2t85gbAlpiTqwPCO6VDx4Zwlwqp3IU3M579Fh92OZUebjpWGGSOpNXWJvshNrgi9gqNjXtnVe8+bD4i9lVc2MArU8Ya7pkyMJf/8ooAZ+bnRdeg50NLZ2yDr79BX0V1xMQgCTTTR9PDnaOmn0XmudaevlEJgNOjP850u0fDY//E/nfv9o6wwmQOaIpGPp67rOoBHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR11MB5363.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(23010399003)(1800799024)(261026121527099003)(11063799006)(4143699003)(5023799004)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CNseVYhLzxmnU6sScPtvlhSTZk1QzpqeIOb6X2OnE6LHgAQDvip0gDTSWD/r?=
 =?us-ascii?Q?uaGLtLHFrJCG2P4GmOVQuFVLBIDy7UDhVmIrR48lWZAsP9pWGTPDZShmjoL3?=
 =?us-ascii?Q?77CgSAE6mUEMRiPnO7pW6YxkHcmIluL2RgL9t0w1ayNNhu+Y4vFzY0YUd+6N?=
 =?us-ascii?Q?0gEAzof96SyLJrnVVZPl8K6PQ+XLD2vvpAvy63MrQs401IBO1dEdkgTwYq34?=
 =?us-ascii?Q?LE72aZmHWUuXDXVWVdgFzSSDAVFmTZRaTlqEC5hRqoHwJFkEjW6cTJ1qwZ+n?=
 =?us-ascii?Q?pAuRGQ6YojsVtxllzer/qhRezwXONeF/eixmuTojlgmPM1UyzJe5q7L8qHXa?=
 =?us-ascii?Q?mJ3wslLhCFaunMY7+h8cIC3CeYe0Ym4zG7tOVnbaiV4ZoYUC58OE6fvMaptY?=
 =?us-ascii?Q?wak9KrX+mrS4d8YO1nSviooMDAIjc5WBotRvI8noC9gLJpc1ALv+mnukU826?=
 =?us-ascii?Q?yh+r8xqk/efSN5hKwFY4ZgQdf1tVbebYDaT6BpijpZYRntXrw8ohLel0T7Di?=
 =?us-ascii?Q?tW1GFZB34zMBToyFZcdiBK8bx1wMVlE5aNIPNko7gmSVkiBuG/06wy62/pj4?=
 =?us-ascii?Q?ihA1KbKPAelwwB1gy3qjEnl7FjyLX6rY2QQyDHXCo2pXgMPGOX0JEYctQ3+2?=
 =?us-ascii?Q?Y37YFrofZNfGRqi18XOGcFH3UWG0Zxfou1YqQy/STNmu6Vn3+TOfCZcZSLs9?=
 =?us-ascii?Q?nq3zfaJsDToLSuQUb8PiP3gfl4jZTKXhA4ROFw9jgT/PwHxkbJgCItUD2XXm?=
 =?us-ascii?Q?ILNma6tqjCJyz1kzj/whc9mW0HJT6CVAcAqn87IXElJ0uqEwbbLs/6J4Xb/C?=
 =?us-ascii?Q?GnESL2FeM+f3kZ50Af3xA7GfvYJuWPct18UIwNNOovxZq8hXecNtpTil04wB?=
 =?us-ascii?Q?Te5OYHmKi31ifJEcINe0cKtVGyWMuak2Bs9YOKz6zex0i4mP70NvBrji/aty?=
 =?us-ascii?Q?otl1OMOOd66tkDun1ePOMMxip8vDq0UW6/sw6XwCqDyTPqeGPQ0IRRnFR727?=
 =?us-ascii?Q?mKqjBPUnUEEKxDiJtW3wf2Dr+wO68YxLZWrO9c7YsgTp25hz1iEwQQBRzvgw?=
 =?us-ascii?Q?/LQ6k+jJGc2Rv6Op+XSU4bbspGhtpjNSziam9o8KcO5rxvDzY1aNp4mbjFQN?=
 =?us-ascii?Q?QYIm6SUHXIZ8caEnwxP8qL1WDHe94pUQufAA+7TCR8F6egjAgj3mqSEAtu2l?=
 =?us-ascii?Q?5ChZoGoGry4lPKy3QLVBnUN0DP4P87bFwA3Y9SDNFc2JHAZCrdA4W7tsIgAt?=
 =?us-ascii?Q?+20WAXYMbjZGUZZApyEUtjkHkgKsHv1++E16V9HZ3GHq480Q8rRnEQ42ySoL?=
 =?us-ascii?Q?hIofU7ORlP/KTsrfi6V3afChg/OUF9jQMDZVhLo3Q+O9ESN/O8ZM/t2zgc54?=
 =?us-ascii?Q?aWncx7Hs0Fr1BB6mHBt6xv3+Luunb/4wwyzNugPQ5lKVNtIgjiZ7PsF7a1Ya?=
 =?us-ascii?Q?Don5dH40XOjRCJZRfT6XqJd2v3CspvCrc96Hd1aCsPBLhY5TNpy/RtSOVkIK?=
 =?us-ascii?Q?CmzkVnTa578dgLBLGYK+bPnQp9onL5NHFeAxNQiqfFuCKglsE9BXIgIDzYkc?=
 =?us-ascii?Q?VtLRValLdI2G177UoPW//fohFwrvVQa8iLACb1+Cy5mzBR4hkXRV9xErJ26l?=
 =?us-ascii?Q?e2IE3byvGpyIFFeyllsJSsw+A3pL/Qr98R2L3nwu84OTXrLMtS8Y/KLjKLSS?=
 =?us-ascii?Q?aDu89c8FEGPw2b9hKI/ne3eJIwlqvU8U0mvt8Gw+afIRxOqGPddYSsvGMe0D?=
 =?us-ascii?Q?YmN5kldssT5ruQDl+7goxMtkUq6ScqBCIyFhpmM2GGNkOYw+P0/olZ1ahh5R?=
X-MS-Exchange-AntiSpam-MessageData-1: Icl0MRSTJS4+B1D/qbt69Kvr46PwRlkWZAg=
X-Exchange-RoutingPolicyChecked: 4clMJ+jQUUxxUUHrm9txHTWiWgL0YBAMc3BFVVTaJbJlXS3PCNGspz+Rv48qJBhqvavThCJ/n5WrhSt+6TYA9O6f7nbBizAcFfHj2kQJ/TGdpaB45YGjg3UKgOjp1FOutsRKPr89zwB01O7x1SM+V/Yvk+5tdM8oCzfwQjVwNrkcXRRlQYzmCJneIgN8ktEjq/dmkEo95uOxZc4AIF25FMsdAGwkHWBJ5qOrtgkat8Qn/V3Dki//QYG26u61P+os/fyNrgKlb2aVXwLjhiLrnOYIFty3G9/cWU5f4pqFYbzy7xLXSpFRTTm+hNkJeHHWUNpkbXdrI78R0gJFvPleXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e10fd3-aad8-46e3-878a-08df340a3c8f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 09:11:08.2524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAGwbDghBfdKabK/UiId/Nf41ID4Rv+xndzv7VpIkr3/XF90+qS998v7W+TpBurd7MOchLmmLyU+/0Vua6kVdK/ZOr9DDMCIwPfnQhIZgnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB719904
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 03:19:07PM -0700, Emil Tantilov wrote:
> libie_ctlq_xn_shutdown() waits on xnm->can_destroy for the outstanding
> transactions to be returned. libie_ctlq_xn_push_free() signals it with
> complete() when the last entry goes back to the free bitmap. Once the
> manager is shut down, libie_ctlq_xn_pop_free() hands out no more entries,
> so that point is reached exactly once and only one waiter is woken.
> 
> Nothing restricts libie_ctlq_xn_shutdown() to a single caller, though.
> If two threads call it while a transaction is still outstanding, both see
> the entry in use and both wait, and the one that is not woken blocks
> forever, as wait_for_completion() has no timeout.
> 
> A drained manager stays drained until libie_ctlq_xn_deinit() frees it, so
> signal it with complete_all(). All callers waiting at that point are
> released, and later ones find the bitmap full and return at once.
> 

Yeah, I should have used complete_all().

> Signal it before free_xns_bm_lock is dropped. A caller that finds the
> bitmap full then knows the completion has already been signalled. That
> leaves libie_ctlq_xn_push_free() holding the lock after it has woken the
> waiters, so have a woken waiter take and release free_xns_bm_lock before
> it returns, the same lock/unlock pair completion_done() uses to wait for
> complete(), see commit dec13c42d21a ("completion: Replace
> spin_unlock_wait() with lock/unlock pair"). Its unlock is then the last
> access to the manager by the time any caller returns.

The way you phrase this, the locking change seems redundant, as complete() 
provides the same end synchronization. I can't see a scenario, where just 
complete()->complete_all() change wouldn't be enough by itself, so please 
describe the problematic sequence.

> 
> The manager must still outlive every caller, since a woken waiter has to
> retake the completion and bitmap locks before it returns. Spell that out
> in the kernel-doc: libie_ctlq_xn_deinit() must not be called until every
> libie_ctlq_xn_shutdown() caller has returned.
> 
> The next patch makes idpf call libie_ctlq_xn_shutdown() from its service
> task, which can run concurrently with the reset and remove paths.
> 
> Fixes: b4ff4e626a7c ("libie: add bookkeeping support for control queue messages")
> Assisted-by: LLM
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/libie/controlq.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
> index 6214fc036ce5f..9bcb022ed9782 100644
> --- a/drivers/net/ethernet/intel/libie/controlq.c
> +++ b/drivers/net/ethernet/intel/libie/controlq.c
> @@ -735,13 +735,10 @@ static bool __libie_ctlq_xn_push_free(struct libie_ctlq_xn_manager *xnm,
>  static void libie_ctlq_xn_push_free(struct libie_ctlq_xn_manager *xnm,
>  				    struct libie_ctlq_xn *xn)
>  {
> -	bool can_destroy;
> -
> -	scoped_guard(spinlock, &xnm->free_xns_bm_lock)
> -		can_destroy = __libie_ctlq_xn_push_free(xnm, xn);
> +	guard(spinlock)(&xnm->free_xns_bm_lock);
>  
> -	if (can_destroy)
> -		complete(&xnm->can_destroy);
> +	if (__libie_ctlq_xn_push_free(xnm, xn))
> +		complete_all(&xnm->can_destroy);
>  }
>  
>  /**
> @@ -1171,7 +1168,9 @@ EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_send_clean, "LIBIE_CP");
>   * @xnm: pointer to the transaction manager
>   *
>   * Synchronously terminate existing transactions and stop accepting new ones.
> - * Async transactions are discarded without invoking resp_cb.
> + * Async transactions are discarded without invoking resp_cb. May be called
> + * concurrently, libie_ctlq_xn_deinit() must not be called until every caller
> + * has returned.
>   */
>  void libie_ctlq_xn_shutdown(struct libie_ctlq_xn_manager *xnm)
>  {
> @@ -1218,8 +1217,12 @@ void libie_ctlq_xn_shutdown(struct libie_ctlq_xn_manager *xnm)
>  
>  	spin_unlock(&xnm->free_xns_bm_lock);
>  
> -	if (must_wait)
> +	if (must_wait) {
>  		wait_for_completion(&xnm->can_destroy);
> +		/* Synchronize with libie_ctlq_xn_push_free() unlocking */
> +		spin_lock(&xnm->free_xns_bm_lock);
> +		spin_unlock(&xnm->free_xns_bm_lock);
> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(libie_ctlq_xn_shutdown, "LIBIE_CP");
>  
> -- 
> 2.37.3
> 
