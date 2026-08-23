Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FD1C5DF97
	for <intel-wired-lan@archiver.kernel.org>; Sun, 23 Aug 2026 13:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B586380E27;
	Sun, 23 Aug 2026 13:20:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VlcVpcrb236Z; Sun, 23 Aug 2026 13:20:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787491256;
	bh=fmxD4pwM1rpDGZ6DROksjn6Wl12R75tM4X7pLnx3j/0=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KP48ttZzTj1OhaB/9DjRTv0oFhUlk9oeCz8hVGEX/t+cSg9jOrK37FgGxy9uKovIS
	 Xb7KLY7w1NVrdxiDsJ03qblJU+V7Q1/22j53FLGieZ0MsDjIzYgng+zWstnxNt/c6W
	 tXs5SsslXqTiNAeH12M/f/nXsr/swDTee43oKnXqSehFdhXCIWl6enpVVBY3yWxw7g
	 XdJrgguSZfB5GDS0//u49iyyGF7e7aIWGXVd/yyNAF+QVeDaxtN2HBjEEBnAdV1ngl
	 ql/Fs51QOJFaJ7vIUxL/OVhwOSS2zBJcjD4eGtUqqXTCVogT052xAEv3rLbn1T37He
	 rdu+7yI70JAMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3447680E25;
	Sun, 23 Aug 2026 13:20:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 56C69336
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C8A2606B6
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:20:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id otCjvPuzQqv4 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 23 Aug 2026 13:20:54 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GTsl9ObB
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D310E6066F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787491254; x=1819027254;
 h=date:from:to:subject:message-id:mime-version;
 bh=fmp4SFPqPPAHjmDXv+tJDzkFA3za5/LteV4vgjLsGoM=;
 b=GTsl9ObB6qFHEAJaeGDSPHaXl0dbkhwJa+nTmN5nXqhK8j8NghkOVnKz
 78KaE3f9nQmApkwi2Uupb+/5G7UWXo/GrIdjXwFJPbDAJ/wxsbseo4xhF
 +wNshd7Z8Cegi14srL+TGwO4aoQIbQu3oj+8ABKAJwVpV6GRFThuN2T6Y
 GN9a2vrD/fDlW1QWMSd4YO+xq94hd4WBv8t/KUScRGU7oQsC2d6N/V9cv
 Vh3z+yY12X7jNvwrD6hROBy7gBD8H4rZt6FHi1/qFgW3+7qaUTIAZ9IH/
 kRB8DUDubRGvOV8pkMGklqpapYcB7YZzPbU3UvCiy9Vo1oLqyQVJF8MkP w==;
X-CSE-ConnectionGUID: a7MfymfJTheTtJXyUyL7lg==
X-CSE-MsgGUID: +TcB1HszTcmCTfYyGrtQxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="88021164"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="88021164"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 06:20:52 -0700
X-CSE-ConnectionGUID: 7MvLLT7eR5KQKUa91/OZNw==
X-CSE-MsgGUID: EbO+ex3vRJ252s846py/rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="266245679"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 06:20:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 06:20:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 06:20:51 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 06:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUP/1Z+wa68Yey9rs7cuDkBG2YDLmsQXfi3EhO7Ru+Qzpx2Ntt/WD86bu+U6OXMMMgQuoT86n+gUQ8PtjO3k7aEdArZsJVy5TsXI69u95xSdMBowla5bNd0Jo1wHtBuZlTnvc5ExCcQ4DpbzC/ngOMt6vNW8JxhY33YOnIyUpL5wndkHfSK19IuaL9a8es/WQ0m4eAafyX2Z/nctUmcsQFVHgkHddoziTOqTTul9tDaao7segxHsdqbEqQy1wpe1QqqZyNO5GSy2XAmPv3b7JIJzfhubn9cRvzKfGW4F0bmREmLAGZGarQh5n7er4U+1yGoRW7LdfkVJse4hfMy43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmxD4pwM1rpDGZ6DROksjn6Wl12R75tM4X7pLnx3j/0=;
 b=T3QZtC9hWc8i03JWkRZPMZwyNKsNWFM/Dww/YM27Jnlsvo1Vltx2tz/MQHYyiAes59AGaihkCTIwW8i7jGFLg5CP5aL4JFvIbM65DXrDvfpxxcHHpveLTySB49nNr8BlM2AKhFYcGzZheBnZ59iD5+EyZAcERgjH7Ea0zE/EOis7eli5TgjDZFvJLiQ7duVCPbLEXKAgCLlZ6x3GbIKahxbLw4nf88E4rm0T9OrrFvOfrfF+BovN2WGtPgvvAbW6iPG5nST6XTfXdyajx4+lc2cyYdTHxK6CpgAS1czb2pyGGHVn83BEtQK85nV2oLUd40c5/pd+vW/qJZYrPDQ0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by MW4PR11MB6569.namprd11.prod.outlook.com (2603:10b6:303:1e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Sun, 23 Aug
 2026 13:20:49 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 13:20:49 +0000
Date: Sun, 23 Aug 2026 21:20:43 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:dev-queue] BUILD SUCCESS
 632804b091279a8b4e169b3a720cc6bb42048ab5
Message-ID: <202608231210.HsnKI8fP-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|MW4PR11MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c1a4aa-1bb8-4ba6-72ee-08df01195922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: feRsvtIYcCXwCMyjM3MwZNBWPwlCdSPZpBLeQHJ7BGp5LcS3rPU/b1UG/VyjuUJY22mxroBHv5XS+OHswiQchB1QdUKDk7JNZghaIrb/ReWMszmXay4hv0BC8BpB7Z1RB1XCgWFWxZZ1YIg25fn3h7nOkptCcV4N1YP3HJkDDAxaekAfPPvIZvNXqe3qMzqQfGcpAWGM/qot2DsC5g6xe5Y9RJCoruqplzzMstQjwsY7MbewRTZEuZAdw/pHaqKCp/9/H/QRg/oRd51PxWIJCEk/64V/NvONA7RopeatJiYExA7e90PqH5rLWv453CmCLnwswFi+o9dsAkFc1FGRXyvCPfn0mGe44DOLRmELoNEezvA01BAezX3BY3ryu9Sf51HIUlmDQaRAhTPV5uNtPn2fJmRJcDWKiXb1zYYoGyi2C0VUihEv1PLWm3xPCnxgyKS5QSBj/qC1BKIjUsBw2bWNg9ue+WS4oOaXKYasanXBWyRD+o6a+J4WS4AHhC8hF3OMQRsdGV2JTvzfSSM3huODetCCecypNK3KsQR5GQKPwnzgsgkYuTuwbosNqsdkS0bciaOwbn9lHDUO0FXZjEvDL1GUYvvoLuNHWt0M7XtNcy4exzVak7/bHYUwiDG2QC4rrd4SYlH3q5HffgV0ZYlppAl0hAIoc8YxfzG+55Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5214.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AIW2E825jUfqKvyS8PBphYKjA/RghMGAaf2zmTZmq+87+0iawonAK4Ro874T?=
 =?us-ascii?Q?BcLb4LcHWksMGY7gYJbP9COelbnU+mjCz1uGrFflbSPcIBru6v3Bvpo/QsX0?=
 =?us-ascii?Q?9iSsWxBvlhq9xVZss3aVde6gpB2bn3ROP1OWjNR55dKw0tiSKGKgKowqzJhN?=
 =?us-ascii?Q?aihA5CFaee8eOJUJoVr8NrgJu4vOC8OUcrjYcm2D5Q8iINnGOU7vtFotIiRq?=
 =?us-ascii?Q?5RR43aWqQXQCPCHP9h3CHNUJudop0bEa5Drc8FbD5hurpVo1tEVptKRYF+jF?=
 =?us-ascii?Q?Wrnim0RAZvWFKLLrI7vCDfj1KoYIgTVdJ9rWyEMWSuV6FGAGK2HUqYMZJYhI?=
 =?us-ascii?Q?2Izw56WPr+bABtqmTuj1nNIl6XtwS7G70o90gU+4K7l5Z3ZDBB+bCD4kDHND?=
 =?us-ascii?Q?ONz3F52jm6KolvrTdDvdHsOMJ4A3tXyA8vQFr7Yv1tKVkSIFNPQ40bCbrWeT?=
 =?us-ascii?Q?2YrMjEN39LY+DZsCmjznehEMv9iZKGssg2DbY4K/WDXhVcEH6YsIainxQ88H?=
 =?us-ascii?Q?IQ7TZ1G85uJ9TPce9eAw4MJSMgIxpRN5FCtUPq7so7kgT9G9EyehqQty0EFb?=
 =?us-ascii?Q?gSn00Ob/Ih0y8sxRSPMgYCl7s2Z8rmL08CKNY4nw9HecR+BVKeCLNQHEGRr+?=
 =?us-ascii?Q?I/8UjYy+h09V1hwlTg/wCD6LYjQUbBKB4UX2Boc8DZhqiwZdR/ie7AaU+uM8?=
 =?us-ascii?Q?d40SuTa1QVxaM/vHx1gmg2/bGKbgyYIB7K2YDrDES1lb8G1W72em8IPbVgo0?=
 =?us-ascii?Q?ZAxtJeOABc8NOo9NfMiZ9hVG1Zhjf7WdvFbOFlaav6WQREOnlSjGsoAH9wFu?=
 =?us-ascii?Q?FweLszDwMVlxYUXAnsX5AIIBUOhwyoxuuZKAoztF2de0pHMENitfnRXWIEMS?=
 =?us-ascii?Q?LAGGppJf3nKL9N+7PkXJo7Lvqm6Y01/ItJfFrSXj6h5PhblS0J8snW1w5pz3?=
 =?us-ascii?Q?o/T2Ar9VdVTrI998I9fkuuAHbPBh59WNgZgA4W8tHNUue3KKvwuyfF9zxYHS?=
 =?us-ascii?Q?ym3weHpwGxNsLNrNfBMDANTXma8WXU9w6PDcsBRXp5G/vlfAG9HIlB7qIGT+?=
 =?us-ascii?Q?x6WX8JrcN6M0E5ETLotLoFpeFh96SxtVQA5KNsI+TND29ejlniOyrTQpjR2v?=
 =?us-ascii?Q?65aujJaSQ7hhL0ce3tTDA8gFt8DTNJfKvsg3hqPHfyscENddfhung2omReSV?=
 =?us-ascii?Q?lez/r4uJ1TBh/tz+bQedN6PumBXFf+I+kLjoZ3yzBLglgKHr73xrT/uEYlJj?=
 =?us-ascii?Q?2Z8JRcoYeRCwveWgZJeFEHf/4Cx9DzIcsKXwjYVFJ9L+7gUaYN/aP/d6uvRE?=
 =?us-ascii?Q?DcBLyf9RRJtLnNkc5v4u4JoE/X7Slztx34wlhF8V4Q841NYtdl2Jnq0wMPBk?=
 =?us-ascii?Q?lB64hto+LxN1jJFTKDfObl/AwhzrCMHN1qn2xjokGYUuNMXUaE4w9jxfk5le?=
 =?us-ascii?Q?EfbiU/xJi0Nb8wVjvpulFli4phWPQeEnSzMz4GPcpo4X13VQAJrWZohZH3UR?=
 =?us-ascii?Q?q60Sd0ce4ZUaebyIi7mE/V1Ovfixhi3w9ortM+7P4OEfvAa2eDY4I1nFc2ZQ?=
 =?us-ascii?Q?5hI6fzHhhHUP1G9lubcmFI6dEvCbbY60sQzLIHr9KGw+f9432WlTcNyyxRAA?=
 =?us-ascii?Q?2V4IhqKU6GwnFKZPp6XpAi57hpP8qy+YihtGad7bUWUu8rfcHSfmoLEAO+Qg?=
 =?us-ascii?Q?m9UC61gr5s+ixuPuJ307DhoYVAg/JKNVpdLZtaJ552Qx+2RXBjUanj/0/c+F?=
 =?us-ascii?Q?cagGT9jOFg=3D=3D?=
X-Exchange-RoutingPolicyChecked: TLKiLs/PpHmiEHsgY9ImOMs/79W98Zz/mTRo3s/JkCVIaRCXPdeFeA+RRJT6T7Tq5ZBHc+6XpBp/DTyLdsoWAJPA7i4buyXf7HzXkChskWa098YtH/7jKQd/hVkWax9F3BjEZRosMLsfjAxen9d599pyqppUZrYDCbGgq7VrtS+ZHhFPqbLZXxs8dLSwivW1XC5mRS8qFq7N2Hve5MejIKYUt7+qzCI1ApORZQ0Dt9zceygBIjCtTh1jnP0o0lALXjRYblNE/052pE7cYaYLWT17lQDxR3s8h+80ASgOQlMma9QuQf6KhvM/6YYu7urTR/VeTWsTbW6CYQ0EmzVe3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c1a4aa-1bb8-4ba6-72ee-08df01195922
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 13:20:49.3219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNZ7YP+yezn10DLGAwQK9U3GpczqeD+HuAG8edJV+4IkjjyJS8JcxSf6+I90b2Fd7IHmcP03ZprMv5UfnCpGSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6569
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 632804b091279a8b4e169b3a720cc6bb42048ab5  ice: allow reading the last byte of the NVM and Shadow RAM regions

elapsed time: 1479m

configs tested: 184
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260822    gcc-14.3.0
arc                  randconfig-001-20260823    clang-24
arc                  randconfig-002-20260822    gcc-16.1.0
arc                  randconfig-002-20260823    clang-24
arm                  randconfig-001-20260822    gcc-16.1.0
arm                  randconfig-001-20260823    clang-24
arm                  randconfig-002-20260822    gcc-10.5.0
arm                  randconfig-002-20260823    clang-24
arm                  randconfig-003-20260822    gcc-12.5.0
arm                  randconfig-003-20260823    clang-24
arm                  randconfig-004-20260822    clang-24
arm                  randconfig-004-20260823    clang-24
arm64                randconfig-001-20260822    gcc-10.5.0
arm64                randconfig-001-20260823    gcc-15.2.0
arm64                randconfig-002-20260822    gcc-12.5.0
arm64                randconfig-002-20260823    gcc-15.2.0
arm64                randconfig-003-20260822    clang-24
arm64                randconfig-003-20260823    gcc-15.2.0
arm64                randconfig-004-20260822    gcc-12.5.0
arm64                randconfig-004-20260823    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260822    gcc-12.5.0
csky                 randconfig-001-20260823    gcc-15.2.0
csky                 randconfig-002-20260822    gcc-14.3.0
csky                 randconfig-002-20260823    gcc-15.2.0
hexagon                       randconfig-001    clang-17
hexagon              randconfig-001-20260822    clang-24
hexagon              randconfig-001-20260823    gcc-16.1.0
hexagon              randconfig-002-20260822    clang-24
hexagon              randconfig-002-20260823    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260822    clang-22
i386       buildonly-randconfig-001-20260823    gcc-14
i386       buildonly-randconfig-002-20260822    clang-22
i386       buildonly-randconfig-002-20260823    gcc-14
i386       buildonly-randconfig-003-20260822    clang-22
i386       buildonly-randconfig-003-20260823    gcc-14
i386       buildonly-randconfig-004-20260822    gcc-14
i386       buildonly-randconfig-004-20260823    gcc-14
i386       buildonly-randconfig-005-20260822    clang-22
i386       buildonly-randconfig-005-20260823    gcc-14
i386       buildonly-randconfig-006-20260822    clang-22
i386       buildonly-randconfig-006-20260823    gcc-14
i386                 randconfig-001-20260822    gcc-14
i386                 randconfig-001-20260823    gcc-14
i386                 randconfig-002-20260822    clang-22
i386                 randconfig-002-20260823    gcc-14
i386                 randconfig-003-20260822    clang-22
i386                 randconfig-003-20260823    gcc-14
i386                 randconfig-004-20260822    gcc-14
i386                 randconfig-004-20260823    gcc-14
i386                 randconfig-005-20260822    clang-22
i386                 randconfig-005-20260823    gcc-14
i386                 randconfig-006-20260822    clang-22
i386                 randconfig-006-20260823    gcc-14
i386                 randconfig-007-20260822    clang-22
i386                 randconfig-007-20260823    gcc-14
i386                 randconfig-011-20260822    gcc-14
i386                 randconfig-011-20260823    clang-22
i386                 randconfig-012-20260822    clang-22
i386                 randconfig-012-20260823    clang-22
i386                 randconfig-013-20260822    gcc-14
i386                 randconfig-013-20260823    clang-22
i386                 randconfig-014-20260822    gcc-14
i386                 randconfig-014-20260823    clang-22
i386                 randconfig-015-20260822    clang-22
i386                 randconfig-015-20260823    clang-22
i386                 randconfig-016-20260822    gcc-14
i386                 randconfig-016-20260823    clang-22
i386                 randconfig-017-20260822    gcc-12
i386                 randconfig-017-20260823    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260822    gcc-16.1.0
loongarch            randconfig-001-20260823    gcc-16.1.0
loongarch            randconfig-002-20260822    gcc-16.1.0
loongarch            randconfig-002-20260823    gcc-16.1.0
m68k                      m5249evb_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260822    gcc-11.5.0
nios2                randconfig-001-20260823    gcc-16.1.0
nios2                randconfig-002-20260822    gcc-11.5.0
nios2                randconfig-002-20260823    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260822    gcc-15.2.0
parisc               randconfig-001-20260823    gcc-10.5.0
parisc               randconfig-002-20260822    gcc-9.5.0
parisc               randconfig-002-20260823    gcc-10.5.0
powerpc                mpc832x_rdb_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260822    gcc-8.5.0
powerpc              randconfig-001-20260823    gcc-10.5.0
powerpc              randconfig-002-20260822    clang-24
powerpc              randconfig-002-20260823    gcc-10.5.0
powerpc                    tqm8560_defconfig    gcc-16.1.0
powerpc64            randconfig-001-20260822    clang-24
powerpc64            randconfig-001-20260823    gcc-10.5.0
powerpc64            randconfig-002-20260822    gcc-12.5.0
powerpc64            randconfig-002-20260823    gcc-10.5.0
riscv                         randconfig-001    clang-24
riscv                         randconfig-001    gcc-13.4.0
riscv                randconfig-001-20260822    clang-17
riscv                randconfig-001-20260823    clang-24
riscv                randconfig-002-20260822    gcc-12.5.0
riscv                randconfig-002-20260823    clang-24
s390                 randconfig-001-20260822    clang-24
s390                 randconfig-001-20260823    clang-24
s390                 randconfig-002-20260822    clang-17
s390                 randconfig-002-20260823    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260822    gcc-16.1.0
sh                   randconfig-001-20260823    clang-24
sh                   randconfig-002-20260822    gcc-14.3.0
sh                   randconfig-002-20260823    clang-24
sparc                randconfig-001-20260822    gcc-13.4.0
sparc                randconfig-001-20260823    gcc-10.5.0
sparc                randconfig-002-20260822    gcc-15.2.0
sparc                randconfig-002-20260823    gcc-10.5.0
sparc64              randconfig-001-20260822    gcc-8.5.0
sparc64              randconfig-001-20260823    gcc-10.5.0
sparc64              randconfig-002-20260822    clang-24
sparc64              randconfig-002-20260823    gcc-10.5.0
um                   randconfig-001-20260822    gcc-13
um                   randconfig-001-20260823    gcc-10.5.0
um                   randconfig-002-20260822    clang-24
um                   randconfig-002-20260823    gcc-10.5.0
x86_64              buildonly-randconfig-001    gcc-12
x86_64     buildonly-randconfig-001-20260822    clang-22
x86_64     buildonly-randconfig-001-20260823    clang-22
x86_64     buildonly-randconfig-002-20260822    clang-22
x86_64     buildonly-randconfig-002-20260823    clang-22
x86_64     buildonly-randconfig-003-20260822    gcc-14
x86_64     buildonly-randconfig-003-20260823    clang-22
x86_64     buildonly-randconfig-004-20260822    gcc-14
x86_64     buildonly-randconfig-004-20260823    clang-22
x86_64     buildonly-randconfig-005-20260822    gcc-14
x86_64     buildonly-randconfig-005-20260823    clang-22
x86_64     buildonly-randconfig-006-20260822    clang-22
x86_64     buildonly-randconfig-006-20260823    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260823    clang-22
x86_64               randconfig-002-20260823    clang-22
x86_64               randconfig-003-20260823    clang-22
x86_64               randconfig-004-20260823    clang-22
x86_64               randconfig-005-20260823    clang-22
x86_64               randconfig-006-20260823    clang-22
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260822    gcc-14
x86_64               randconfig-011-20260823    clang-22
x86_64               randconfig-012-20260822    clang-22
x86_64               randconfig-012-20260823    clang-22
x86_64               randconfig-013-20260822    gcc-14
x86_64               randconfig-013-20260823    clang-22
x86_64               randconfig-014-20260822    clang-22
x86_64               randconfig-014-20260823    clang-22
x86_64               randconfig-015-20260822    clang-22
x86_64               randconfig-015-20260823    clang-22
x86_64               randconfig-016-20260822    gcc-14
x86_64               randconfig-016-20260823    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260822    gcc-14
x86_64               randconfig-071-20260823    gcc-14
x86_64               randconfig-072-20260822    clang-22
x86_64               randconfig-072-20260823    gcc-14
x86_64               randconfig-073-20260822    gcc-13
x86_64               randconfig-073-20260823    gcc-14
x86_64               randconfig-074-20260822    clang-22
x86_64               randconfig-074-20260823    gcc-14
x86_64               randconfig-075-20260822    gcc-14
x86_64               randconfig-075-20260823    gcc-14
x86_64               randconfig-076-20260822    clang-22
x86_64               randconfig-076-20260823    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260822    gcc-9.5.0
xtensa               randconfig-001-20260823    gcc-10.5.0
xtensa               randconfig-002-20260822    gcc-8.5.0
xtensa               randconfig-002-20260823    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
