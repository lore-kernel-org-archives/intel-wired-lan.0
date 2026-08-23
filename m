Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CD1C5DF8C
	for <intel-wired-lan@archiver.kernel.org>; Sun, 23 Aug 2026 13:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFC9F80E1F;
	Sun, 23 Aug 2026 13:28:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m-MUDbQoTjqQ; Sun, 23 Aug 2026 13:28:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787491695;
	bh=70INqnqKmerqkqIL538Z5heiJIks/1w72zI9A1kRdtk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2YabMhYUnT51xQH7TGaUC3z7n7S26pA8vkdt5GUbBBUc8yAVvSutVwZKYKo/B5GVW
	 rKwHfr0gZx2npjCUVM6P7ilVem90QYhC/8/gdrsoOFhyNX7au89HyK3mDcE7xlOf0V
	 2jBc/7Q9xCFS6WNyTXOQAGEyLb5QAb4FWEARavw12z7Lt0Homlflo8d5XYm+7yxq64
	 RpmrWR4F2SmkPQXcvwHl2912SUoz5nbgoSP6G3cQ0SEuo+Eew1w+1XSot9xK0gmvy0
	 8JyaAZ15eLx+jmPsvFV5zgVXgvQZ2pFZWaoNiFsJcVhZGA0Of71/AjMRPlRJEfqBLv
	 EAkIGe/zgzwMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89F7C80E25;
	Sun, 23 Aug 2026 13:28:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B0162336
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 964E3406AB
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:28:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KUK87-7Qm_t for <intel-wired-lan@lists.osuosl.org>;
 Sun, 23 Aug 2026 13:28:13 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PkwwAvKC
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F4A0406A2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787491693; x=1819027693;
 h=date:from:to:subject:message-id:mime-version;
 bh=a/Yj/GvOJuS2NCo/ncKBC0VrMTa3etlnbBVNqK+xzjY=;
 b=PkwwAvKCWFKG9MDfAricfzNtrfLV2Zh8FKJXyI03G5R0q3RJp/x9hYrr
 MMWzAIprfoIeKs+M3CvohtVEaj4V7/0PZhn16pwxTj6mJKIpjcDUsZPxm
 x57uT8LHcxAmp0Z3oCWLysM5PZS9wdy+jiAnzu7OOYgMbw58UUMRY3M7Y
 BJ9Ko3oPF3gDr7Mt+i9oTrThkc5Ku6E8KQaZp0MTay02EkTYEYdGOh6Y8
 1OzxrQAeu28kgk+1JYQObTTJib6Zk1oOCHPtZYHCI8O2iDNgnR8KIxIYJ
 0+zNJoYykLNuSlxEHaB5DAjXaF29wGgSiUFXfAi7dGpJICUrrkkhbG++W Q==;
X-CSE-ConnectionGUID: DEsNkFkzQSuCf/hJntZzdw==
X-CSE-MsgGUID: Qrunz7soTY62UY7vZ0VuJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="87823224"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="87823224"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 06:28:12 -0700
X-CSE-ConnectionGUID: Hhpa7WhiQmeAxNn3obOd5w==
X-CSE-MsgGUID: t60oY5t1S6iQyCTkPFRFiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="263510416"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 06:28:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 06:28:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 06:28:11 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 06:28:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP+FpV6vDno5urP8T0snSt9qMdYoCkVxW43/ewLR3zJ5ubYRZ48dxMQfA+In6pnNAA2IMZZ8HmJn9HxBhSYkyHCqke9y0c0k/3wTYrdBazjeezREy3+aPbmdaD3xev4AqHdMbJkYhkfj/SIifcVmjcnR8E2gnj6nsiVnILqUDZjeAJKgjw3JDy2UwD1gS8uv/dpu+PdDKM0/L3ExGp4Q9VSxIocOtC0P83FLItcL1Sx1eb1sKHlOgvEjYaH4WED7VkbBVzTdYX1Yp1HZyDnohlNWLVBsCcsRQn54c5dKEKEnbqDAYrW6dvz2Ob2on2PCnAQGftfWrLduAL1QQp8CHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70INqnqKmerqkqIL538Z5heiJIks/1w72zI9A1kRdtk=;
 b=deYIZumfd7ICOp6qRDycxMsoXkOy6jMFE++q2dMQSJevYTIYG7TQU0M9DxFgXz3YBVulbk9Nr6XojYc+EVqvJ3rX/tLH3JR2Gj5vCkixj3TDSy4k1MxvNJGLNSIrtpH1hWg4zM5thHTKHzQagffxcNMUDzSjYVS8GsCPbkeqabZvBemF5LTvmMIDWw1uTlIi+4omr+a2TS1tjAz0JDYoOOKg7MsDja47M7TwS+SGHkpL3Z6vVHZtEm3QMcy0PFSamBxuZm4ovI1D+6YfdRbGBXS7gjVvI99V6Wys9mjN74S+DkCe7nns+ceEpSTWbFZiytqqqLTEN4Mw46nRev8vnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 13:28:09 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 13:28:09 +0000
Date: Sun, 23 Aug 2026 21:28:02 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:10GbE] BUILD SUCCESS WITH UNVERIFIED WARNING
 746fc0787f616da418ffc04a110296fe95d53491
Message-ID: <202608231242.2Bv1mOA4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TPYP295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::15) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|BN9PR11MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 75873914-b540-4693-e294-08df011a5fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 0hcbw7ukBRRPHJKKOdao+E29ZnMre7Pz/ZmBgrYUekjv7zUWpXhjefHTzTUIDNGrQ5XyFGAL9/ehkQsz4zn4TShBCgYwir3ozVEPOhifFXj2ZWTMWA0pabX8ba/NTPWhk9/abnahjhP1CKvE5FdF9lBEovASGzB3g6rb3ooiUGck7Gtx8BlYYq9MptkOLIEnGTM2KrYPPrFr0OjTWdBlC1vue8RsdJueK+XQD2auXEPeAzKMwO/SgW6k1Ff7Axoq8y2uDQoU2Lf2SZ0L6YEpF+Pl+8jzJAC2tDk/jFzZkDG60cZzSC/BGfu9VLpmKkp4aHsRpxxGd02e1i81LVAsYWaypevRnhaHhQTLJCR+/x2OJhjz++OWD46qMgreL8WKBB0TG3+Lq75taoJSi0mzOWu45Rw4W1iHhEOqvLb1Ad/66PBFwdqhwh5EJzJk1rsaddW3em2z/QLYnggChUA+QnWSaceVnxM8RDqZZ7IaNNDXyPaFfA5NV9GRFGOFil7f73eI3FsRbfFUOHUZl4/kWehuZ1rbQWvF29TdVebUS4V3cmQ67dUr845WIkRuYHVB8Mkd94O/v0oLDqoOPSAbuwdo+51uDYLN7O+6O9EQL+bQXEd0ZfN0dELAOwq+uZfmdy/QdAoQlAmrnTJoV8APX/oOPkxUE3IL+JAUi2syX+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5214.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IdQdOxqI7/2+YAofyI7INT3/1Ip9GTVgY3gzXfSvX6uqhuJS2f9cYCTVoclx?=
 =?us-ascii?Q?Uqp3GqGQ+sdoO6iKJmtDXcXbuRb816MHQ21Uua/4xtMSnCMJvmR0PGq8td3/?=
 =?us-ascii?Q?Syusg98faKTf4z9Dhiv1NmJUFBYResXTrGsyWmBWpWYRjuFXdgBn1XYantBY?=
 =?us-ascii?Q?tbi/6oc4qtg4C/uc7z2vX4PeDdSerIbkeQrhmFoH2eTzUx3hG/uJCY/UCf7D?=
 =?us-ascii?Q?OMVa6myg7mgNuouPriNH/mi6SnLYrespqNGg6P2U/EHxU0g3TDwuqN0t/Khs?=
 =?us-ascii?Q?UwhRuAQuAJstcnQO+UYRqXJ26w7QzdK5Ztzdb31xmveNDmDF/DUYM7fX0KR3?=
 =?us-ascii?Q?eK8acKWSIMPADQp780U5bHXa9IDwHPUgqn17S4gAfy5ordxiiDw3FyrBGdPi?=
 =?us-ascii?Q?lPnBCFHQEAgdjm18PZAG8AbgYpSKrpD7fZKZ+pJHWFLvGLWWOjeSQ/VH4K8M?=
 =?us-ascii?Q?lTJkAqhZTl4XOesiRqF32I2asR56PF/IvENzW4vTy+SWe7ZAJ0WTiyJS53Om?=
 =?us-ascii?Q?SG0wM7aXWsVAcUX94Ai3UED5R+KZlrq1FluxSsX+n5f3vwyb97Cg1IwhZgy6?=
 =?us-ascii?Q?b+GKyxgGvy00Hw4fLrRvaxins9ukUUyRI9RskUysy0cz4RQXociLaeEH7W/w?=
 =?us-ascii?Q?1eby0I3yFYasYqoiTkovkFMs8GigL72np6z9u/YYhxbYsjn/FMSSRVTzt1em?=
 =?us-ascii?Q?2GtDYF3SboUvsqr3SrAQEUDoFfGYZdXbiTY5gqerlxMUiAxwZwliUon9Mvpx?=
 =?us-ascii?Q?Md2BqoJJiK7Y4s4E36Uxqnp7GT2m878eAHej0eKYCrD990qae1GxfRXbAcmt?=
 =?us-ascii?Q?MOBAzBdoR0eOdys0XmSD21dri1dKKUVdQ1ZvXnKY5Q70uIY43gIFKfnErO8W?=
 =?us-ascii?Q?rbfUy+1nLAyKJg03baHglk4gX/vT/hklaUo4IXfpT7XOG/P3RnNBoKThKAAZ?=
 =?us-ascii?Q?k9Zn9/K9Y4c8DT8qUbOglaWM1/7i9hev/mNbA6ythiKvpUpvq77c2oTG6U0w?=
 =?us-ascii?Q?HWs19kg5E2jrfRzQLPmoNFyG2yME2dtw3Ur6Qg22pYfdWwfYvhUgW4eEqk9i?=
 =?us-ascii?Q?ijADajmwILdJMZwH3YqoIk6yFuUc9aGhDkqViWoNypWl9WlKvGWpmfcQMLWy?=
 =?us-ascii?Q?Pq8gUTgvvH/UDAAR2gvCzIhyGI0ICBrvzWcDMgZ3cUh/JpC937xF1/McvVby?=
 =?us-ascii?Q?EgImPJcISRWcWFlJeujfVaxi55eM+sxFLfsBmz3AteT50Ra9duGHNKcrorJw?=
 =?us-ascii?Q?2x9LVXAvcSegzycJklOVaTihtF+gU8ugToFuzEjYLE6YhfDlEO6EdtqKxJkc?=
 =?us-ascii?Q?ImNzkdDSmyTuDqFVt2vWvgsHs7KCdHAfuam+Q6hToqY5EkRGAfao/8gVhsgA?=
 =?us-ascii?Q?HE8SXWClxvP34oM5FiVoYOiBu/qBn+/5k1oLGAVEY8ejG/KLo9zcDN5MMERy?=
 =?us-ascii?Q?fubEtiQRppkCCydC5C5lMtxoti05H1S3ldfrgpVUzoV/dqRQBFHrluWIr0zo?=
 =?us-ascii?Q?rS3TeFrg6rdbu8YaT9PSZLY/RBB3EFYsG5GZ15TEjEH7Lfp7Yrs+40chiSaQ?=
 =?us-ascii?Q?hkCE2jdwLjKCSEgYu+LuLDebW3E8Zejvo3NSM690EthbBdu6UIkMsXpVxgpi?=
 =?us-ascii?Q?J/X3D0jWj84lWJCCeebX6TeSntSBKXYF6w8GfiHUW9oWLjdFQ7fTm0o+VTHO?=
 =?us-ascii?Q?zIC3dDPCSXXO6HgnDbrPYrp69ohpWJGXV2qHkgSxn/ggHyaJB1CS0XY33Rch?=
 =?us-ascii?Q?Krn1O//bqQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: EXRgRo0b3q5udQNGUCtrHmi143swjmXsVMKGu4dGn90njRAGWZqNQtj6NrFP3qSHKAYSbfQLm9lW8cEIzxvUHjq40f61GCnID0qIq0LemrZAotM9fSbPdtkdr06egbMlcsbvvGnzAJkAs2HMEM/1QsUr4E6UqKYHdhQPqqsO4hBEo1zzUlx2ySU5hj2/HDdnGB4ZkTBi6oo9CI0cEFi2fwitcjGGXVj1s1l2to18plyMrRzkAe58xQA96ZPVEAEWHDvpEsyPfbODXYvmYVcQPh1iQ5we0lR7HkPRgTVernd0gv4/GiiQbC64YGWhKPDFmS4ld7nlCvRqo4ZItgza5w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75873914-b540-4693-e294-08df011a5fa2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 13:28:09.7619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6Tz73QXf+MZ48bySUvunm9M7KdkdPIrHMZd4oD15rKgTO+FpyYxttVbPNtn21q232eu2y66FPhEhDmUvmuY0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5241
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 10GbE
branch HEAD: 746fc0787f616da418ffc04a110296fe95d53491  net: usb: cdc_ncm: add Apple MacBook Pro USB product ID 0x1902

Unverified Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/202608130505.TCb1foou-lkp@intel.com

    net/tipc/node.c:1099 tipc_node_link_down() warn: inconsistent returns '&n->lock'.
    net/tipc/node.c:1099 tipc_node_link_down() warn: inconsistent returns 'bh'.

Warning ids grouped by kconfigs:

recent_errors
`-- riscv-randconfig-r072-20260822
    |-- net-tipc-node.c-tipc_node_link_down()-warn:inconsistent-returns-bh-.
    `-- net-tipc-node.c-tipc_node_link_down()-warn:inconsistent-returns-n-lock-.

elapsed time: 2638m

configs tested: 264
configs skipped: 8

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260822    gcc-10.5.0
arc                  randconfig-001-20260822    gcc-14.3.0
arc                  randconfig-001-20260823    clang-24
arc                  randconfig-002-20260822    gcc-10.5.0
arc                  randconfig-002-20260822    gcc-16.1.0
arc                  randconfig-002-20260823    clang-24
arm                           mmp2_defconfig    gcc-16.1.0
arm                  randconfig-001-20260822    gcc-10.5.0
arm                  randconfig-001-20260822    gcc-16.1.0
arm                  randconfig-001-20260823    clang-24
arm                  randconfig-002-20260822    gcc-10.5.0
arm                  randconfig-002-20260823    clang-24
arm                  randconfig-003-20260822    gcc-10.5.0
arm                  randconfig-003-20260822    gcc-12.5.0
arm                  randconfig-003-20260823    clang-24
arm                  randconfig-004-20260822    clang-24
arm                  randconfig-004-20260822    gcc-10.5.0
arm                  randconfig-004-20260823    clang-24
arm                       spear6xx_defconfig    clang-24
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260822    clang-24
arm64                randconfig-001-20260822    gcc-10.5.0
arm64                randconfig-001-20260822    gcc-14.3.0
arm64                randconfig-001-20260823    gcc-15.2.0
arm64                randconfig-002-20260822    clang-24
arm64                randconfig-002-20260822    gcc-12.5.0
arm64                randconfig-002-20260822    gcc-14.3.0
arm64                randconfig-002-20260823    gcc-15.2.0
arm64                randconfig-003-20260822    clang-24
arm64                randconfig-003-20260822    gcc-14.3.0
arm64                randconfig-003-20260823    gcc-15.2.0
arm64                randconfig-004-20260822    clang-24
arm64                randconfig-004-20260822    gcc-12.5.0
arm64                randconfig-004-20260822    gcc-14.3.0
arm64                randconfig-004-20260823    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260822    clang-24
csky                 randconfig-001-20260822    gcc-12.5.0
csky                 randconfig-001-20260822    gcc-14.3.0
csky                 randconfig-001-20260823    gcc-15.2.0
csky                 randconfig-002-20260822    clang-24
csky                 randconfig-002-20260822    gcc-14.3.0
csky                 randconfig-002-20260823    gcc-15.2.0
hexagon                       randconfig-001    clang-17
hexagon                       randconfig-001    gcc-16.1.0
hexagon              randconfig-001-20260822    clang-24
hexagon              randconfig-001-20260822    gcc-16.1.0
hexagon              randconfig-001-20260823    gcc-16.1.0
hexagon              randconfig-002-20260822    clang-24
hexagon              randconfig-002-20260822    gcc-16.1.0
hexagon              randconfig-002-20260823    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260822    clang-22
i386       buildonly-randconfig-001-20260823    gcc-14
i386       buildonly-randconfig-002-20260822    clang-22
i386       buildonly-randconfig-002-20260823    gcc-14
i386       buildonly-randconfig-003-20260822    clang-22
i386       buildonly-randconfig-003-20260823    gcc-14
i386       buildonly-randconfig-004-20260822    clang-22
i386       buildonly-randconfig-004-20260822    gcc-14
i386       buildonly-randconfig-004-20260823    gcc-14
i386       buildonly-randconfig-005-20260822    clang-22
i386       buildonly-randconfig-005-20260823    gcc-14
i386       buildonly-randconfig-006-20260822    clang-22
i386       buildonly-randconfig-006-20260823    gcc-14
i386                          randconfig-001    clang-22
i386                 randconfig-001-20260822    clang-22
i386                 randconfig-001-20260822    gcc-14
i386                 randconfig-001-20260823    gcc-14
i386                 randconfig-002-20260822    clang-22
i386                 randconfig-002-20260823    gcc-14
i386                 randconfig-003-20260822    clang-22
i386                 randconfig-003-20260823    gcc-14
i386                 randconfig-004-20260822    clang-22
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
i386                 randconfig-012-20260822    gcc-14
i386                 randconfig-012-20260823    clang-22
i386                 randconfig-013-20260822    gcc-14
i386                 randconfig-013-20260823    clang-22
i386                 randconfig-014-20260822    gcc-14
i386                 randconfig-014-20260823    clang-22
i386                 randconfig-015-20260822    clang-22
i386                 randconfig-015-20260822    gcc-14
i386                 randconfig-015-20260823    clang-22
i386                 randconfig-016-20260822    gcc-14
i386                 randconfig-016-20260823    clang-22
i386                 randconfig-017-20260822    gcc-12
i386                 randconfig-017-20260822    gcc-14
i386                 randconfig-017-20260823    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260822    gcc-16.1.0
loongarch            randconfig-001-20260823    gcc-16.1.0
loongarch            randconfig-002-20260822    gcc-16.1.0
loongarch            randconfig-002-20260823    gcc-16.1.0
m68k                      m5249evb_defconfig    gcc-16.1.0
mips                        bigsur_defconfig    gcc-16.1.0
mips                     bmips_stb_defconfig    clang-17
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260822    gcc-11.5.0
nios2                randconfig-001-20260822    gcc-16.1.0
nios2                randconfig-001-20260823    gcc-16.1.0
nios2                randconfig-002-20260822    gcc-11.5.0
nios2                randconfig-002-20260822    gcc-16.1.0
nios2                randconfig-002-20260823    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260822    gcc-15.2.0
parisc               randconfig-001-20260823    gcc-10.5.0
parisc               randconfig-002-20260822    gcc-15.2.0
parisc               randconfig-002-20260822    gcc-9.5.0
parisc               randconfig-002-20260823    gcc-10.5.0
powerpc                mpc832x_rdb_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260822    gcc-15.2.0
powerpc              randconfig-001-20260822    gcc-8.5.0
powerpc              randconfig-001-20260823    gcc-10.5.0
powerpc              randconfig-002-20260822    clang-24
powerpc              randconfig-002-20260822    gcc-15.2.0
powerpc              randconfig-002-20260823    gcc-10.5.0
powerpc                    tqm8560_defconfig    gcc-16.1.0
powerpc64            randconfig-001-20260822    clang-24
powerpc64            randconfig-001-20260822    gcc-15.2.0
powerpc64            randconfig-001-20260823    gcc-10.5.0
powerpc64            randconfig-002-20260822    gcc-12.5.0
powerpc64            randconfig-002-20260822    gcc-15.2.0
powerpc64            randconfig-002-20260823    gcc-10.5.0
riscv                         randconfig-001    clang-17
riscv                         randconfig-001    clang-24
riscv                randconfig-001-20260822    clang-17
riscv                randconfig-001-20260823    clang-24
riscv                randconfig-002-20260822    clang-17
riscv                randconfig-002-20260822    gcc-12.5.0
riscv                randconfig-002-20260823    clang-24
s390                 randconfig-001-20260822    clang-17
s390                 randconfig-001-20260822    clang-24
s390                 randconfig-001-20260823    clang-24
s390                 randconfig-002-20260822    clang-17
s390                 randconfig-002-20260823    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260822    clang-17
sh                   randconfig-001-20260822    gcc-16.1.0
sh                   randconfig-001-20260823    clang-24
sh                   randconfig-002-20260822    clang-17
sh                   randconfig-002-20260822    gcc-14.3.0
sh                   randconfig-002-20260823    clang-24
sh                         rsk7201_defconfig    gcc-16.1.0
sparc                         randconfig-001    gcc-16.1.0
sparc                         randconfig-001    gcc-8.5.0
sparc                randconfig-001-20260822    gcc-13.4.0
sparc                randconfig-001-20260822    gcc-8.5.0
sparc                randconfig-001-20260823    gcc-10.5.0
sparc                randconfig-002-20260822    gcc-15.2.0
sparc                randconfig-002-20260822    gcc-8.5.0
sparc                randconfig-002-20260823    gcc-10.5.0
sparc64              randconfig-001-20260822    gcc-8.5.0
sparc64              randconfig-001-20260823    gcc-10.5.0
sparc64              randconfig-002-20260822    clang-24
sparc64              randconfig-002-20260822    gcc-8.5.0
sparc64              randconfig-002-20260823    gcc-10.5.0
um                   randconfig-001-20260822    gcc-13
um                   randconfig-001-20260822    gcc-8.5.0
um                   randconfig-001-20260823    gcc-10.5.0
um                   randconfig-002-20260822    clang-24
um                   randconfig-002-20260822    gcc-8.5.0
um                   randconfig-002-20260823    gcc-10.5.0
x86_64              buildonly-randconfig-001    clang-22
x86_64     buildonly-randconfig-001-20260822    clang-22
x86_64     buildonly-randconfig-001-20260823    clang-22
x86_64     buildonly-randconfig-002-20260822    clang-22
x86_64     buildonly-randconfig-002-20260823    clang-22
x86_64     buildonly-randconfig-003-20260822    clang-22
x86_64     buildonly-randconfig-003-20260822    gcc-14
x86_64     buildonly-randconfig-003-20260823    clang-22
x86_64     buildonly-randconfig-004-20260822    clang-22
x86_64     buildonly-randconfig-004-20260822    gcc-14
x86_64     buildonly-randconfig-004-20260823    clang-22
x86_64     buildonly-randconfig-005-20260822    clang-22
x86_64     buildonly-randconfig-005-20260822    gcc-14
x86_64     buildonly-randconfig-005-20260823    clang-22
x86_64     buildonly-randconfig-006-20260822    clang-22
x86_64     buildonly-randconfig-006-20260823    clang-22
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260822    clang-22
x86_64               randconfig-001-20260822    gcc-12
x86_64               randconfig-001-20260823    clang-22
x86_64               randconfig-002-20260822    clang-22
x86_64               randconfig-002-20260822    gcc-12
x86_64               randconfig-002-20260823    clang-22
x86_64               randconfig-002-20260823    gcc-14
x86_64               randconfig-003-20260822    clang-22
x86_64               randconfig-003-20260822    gcc-12
x86_64               randconfig-003-20260823    clang-22
x86_64               randconfig-003-20260823    gcc-14
x86_64               randconfig-004-20260822    clang-22
x86_64               randconfig-004-20260822    gcc-12
x86_64               randconfig-004-20260823    clang-22
x86_64               randconfig-005-20260822    gcc-12
x86_64               randconfig-005-20260822    gcc-14
x86_64               randconfig-005-20260823    clang-22
x86_64               randconfig-006-20260822    gcc-12
x86_64               randconfig-006-20260823    clang-22
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260822    clang-22
x86_64               randconfig-011-20260822    gcc-14
x86_64               randconfig-011-20260823    clang-22
x86_64               randconfig-012-20260822    clang-22
x86_64               randconfig-012-20260823    clang-22
x86_64               randconfig-013-20260822    clang-22
x86_64               randconfig-013-20260822    gcc-14
x86_64               randconfig-013-20260823    clang-22
x86_64               randconfig-014-20260822    clang-22
x86_64               randconfig-014-20260823    clang-22
x86_64               randconfig-015-20260822    clang-22
x86_64               randconfig-015-20260823    clang-22
x86_64               randconfig-016-20260822    clang-22
x86_64               randconfig-016-20260822    gcc-14
x86_64               randconfig-016-20260823    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260822    clang-22
x86_64               randconfig-071-20260822    gcc-14
x86_64               randconfig-071-20260823    gcc-14
x86_64               randconfig-072-20260822    clang-22
x86_64               randconfig-072-20260822    gcc-14
x86_64               randconfig-072-20260823    gcc-14
x86_64               randconfig-073-20260822    clang-22
x86_64               randconfig-073-20260822    gcc-13
x86_64               randconfig-073-20260822    gcc-14
x86_64               randconfig-073-20260823    gcc-14
x86_64               randconfig-074-20260822    clang-22
x86_64               randconfig-074-20260822    gcc-14
x86_64               randconfig-074-20260823    gcc-14
x86_64               randconfig-075-20260822    clang-22
x86_64               randconfig-075-20260822    gcc-14
x86_64               randconfig-075-20260823    gcc-14
x86_64               randconfig-076-20260822    clang-22
x86_64               randconfig-076-20260822    gcc-14
x86_64               randconfig-076-20260823    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260822    gcc-8.5.0
xtensa               randconfig-001-20260822    gcc-9.5.0
xtensa               randconfig-001-20260823    gcc-10.5.0
xtensa               randconfig-002-20260822    gcc-8.5.0
xtensa               randconfig-002-20260823    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
