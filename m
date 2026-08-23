Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6695C5DF8C
	for <intel-wired-lan@archiver.kernel.org>; Sun, 23 Aug 2026 13:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65CCB6066F;
	Sun, 23 Aug 2026 13:27:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PAJfM4ZYVjRc; Sun, 23 Aug 2026 13:27:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787491646;
	bh=k3HTa0ViaT7j3sR/29HigqjG3SuAL0LfrHOmTK/g8Gs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M4EtQnS2nzANXD47F5PpEv8QjuYIwiIRJmNj9rb9wjOVczOmpniAyMeeDPMeWxeKP
	 yOV6b3UsPeLtTNAoe9SyvGgSXWJtF7ROgjTzTb46c79djjYutdbhvErROfpaxs4Nho
	 GuZeqJpNqXEBSgLjT/GgO2wc1FsKl016zHKtcVfmAHbt2geDzE03ImojdgPhcr3dLo
	 mfkepas85vnk2P2Qf4sfo24/oBvzycrW2S2gP97mjBns0GehXjrTjE3I+Zj+nJpXMB
	 mHU3bt3G7hM5QY4PYHpa+EoTC4y5v2Dl+zW0I5TQs7ECEC65iW1kqcdtDS/4KRWHZx
	 rPQQqX3xYgGuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75DED606B6;
	Sun, 23 Aug 2026 13:27:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 859DF336
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B628606B6
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:27:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 61QbkFzrmXX6 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 23 Aug 2026 13:27:24 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=V859DwLY
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B95C6066F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787491645; x=1819027645;
 h=date:from:to:subject:message-id:mime-version;
 bh=Yx9TpKsmEn0/vVtyrkLUwDLcw4EuRwvifUiRc3emvL4=;
 b=V859DwLY+Bb1a58zsPnWFpSyxCbnRiUPIyvckHUYSixzwBXUSdIJ2YF3
 WYK1OGkljVKWy9ImWwsOBR6zYkIWuRj7CQ5LTSlNPLVPQS+Ig6cii8km9
 tTk7MiZKS3DIqfHIkTz/Hu9n9ZfdhzJsMSdrsrAfsqB1XaObayCw3mDaW
 wfcssEnKf6QKG5dnCLaUam+lqW88EnSceKl/HnTxJ3KJaaL3/5/MtrPoM
 yAXpSHrYzXzRv4LZrrGeIxo7zTFS5QdWKX/2jw7yCUxCLJxd9Hyf8l83B
 3YAZ4ixwggeGBnS96/Sat6kC/yKbLdn7yjuCCY10s4pBQVQWq6FwUKwIQ w==;
X-CSE-ConnectionGUID: sQCmJmMcQlqR0dLXVXpG8g==
X-CSE-MsgGUID: aH2SOB8WRnKiss/TFwxfsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="88021532"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="88021532"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 06:27:22 -0700
X-CSE-ConnectionGUID: W3SycJAMQ/m+wC5fYSBz5Q==
X-CSE-MsgGUID: l++cx4icSXqP5EJEDGWYng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="266247134"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 06:27:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 06:27:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 06:27:20 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 06:27:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxU1TJIWb1YZv300EpmY7FWN4UaU3o6mJoJ2SBUrBkbCpVhhciT5Wh64/JSSpMqy5Sv9sZtiQfVCYoSF9Ls8XSy3lkFStygbydau6UvFsBQFrLIqoO3rqxeZ99N3VhUjCb7KgzXq1bVoGj3yZvEEtT93MIKOZz7QTsVs/tvHR4OUaw7KYQ30a0qWi/bZjNAtGaggGBNzjR1mGH/3DPusCGoIHG8udO0rTHvP4ZRjdRlPjW0LhmO0w4S7yJtbq5c5F+D/lSjAxY5UBmNvNKgeKObDMBTh1Ndoard+6Cf9zjC7tZAqgbSF9qhRn7++/X4mDGIy1stqDk6WgTqBvBaxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3HTa0ViaT7j3sR/29HigqjG3SuAL0LfrHOmTK/g8Gs=;
 b=TPd8zI4Z+XTPOqQVFbX8bHFkLCeSxBkvSr4vBbA9cM2s3SOoqfjPVjeAl449hS0yn7ta1NOiBzg7pna7GWgJVqYdibTSeO2BPHEyTcL0IN6wBGvK1rHKLJuMMtWHm/tTUCFyUKf+KE7Fe9iRdBqmbDTgfDQhH+Fa83PTqX6DpmROtMztEjbWzehTsZI97qEU5heeTyT2vPtMTHwCfLQskgDXnncliKe4ZbkXesD7sbJkXce0e4kbdlpReug93DG8WBMrO1oxT13g3HIes7YH+aJ+R8QtX6HbxNZFZfVFzHhmxcprCPhKsdk7ySShWFYoeQC/i1s958fQ8RoFdEUYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 13:27:18 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 13:27:18 +0000
Date: Sun, 23 Aug 2026 21:27:12 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-net-queue:40GbE] BUILD SUCCESS
 da433400639095b05ac2551f9efdadbd19bfc504
Message-ID: <202608231248.jPuYxszD-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TP0P295CA0057.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::16) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|BN9PR11MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: ee753293-f6fb-47f2-b3ee-08df011a4150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: FvzNCNQYf0BZSUxkNr4UkB5EPFnkrxqu+NOEQtNFtwz3S7T+6StmT1o+1dZEpB1Y/967Rzb0mUoh+D/t7cGw4607YMPmOzyCTowNt/lgCBEo51qazZB51UsEHU/CFjn3NC3nsIi7JRuuITJ6aftQm2jQ+4kk226cijBAsxS0MZkrid9YBW3CyvE8uMV3992KNTh5BfAP4CO7unsaZ4mJgWCe16KyTsda/BrUQfuFdNuobcZGXXRrM/a3EXlu4nQkSli1eUEoizJ2oQRP/SLdlt9GIwSLQPkbVCMaF5GlSC17UvkqeB4ojTpzxRDTQPG7+PPjfuBrBDfU7cDYNY5SvumUx1P1xhGuut4C52fiKQ4LOCjFjtDxksobyyW9Qiln7z4cNoP/kzhhvaF7hlxFDVXj7xpfyCJxJbXDLVjx8ZFm1LDwK9zvo55j69nQcQSAtNu+D8ug8gD8GsFu9Ou6BMgp0zhKSs2/vNdZChSdyDuOc9P5lRHNJDuwErqi8Wb8ogFkqprPe7kaqiAo09ohtbPAAw2HiHuFMdcZQRZD/OE7fdpr2X4FYZtYpvkom8j/JTLObrlnU1skYLd7KyowG50Hv3xZeQUeU0qLDIvoea8T0CMHPU9KzpG3XHbNnWlSW7qm7Vr3NsWgTK9lxD+LM1Pirzwc9ptfiNZbWksvJ/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5214.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p9nITJ46aLBNobTPN2EDwDkrsZLK1V0VRptSsPx5LXDzX7QPZEegl8WkmswV?=
 =?us-ascii?Q?ydaSxXKe0bwb16c8tgzfL8X0o+1ETwYlpjVCixNDnnR+eXpiSNVLyMpxULn5?=
 =?us-ascii?Q?2gfNgjAeiHdKeY+B/n6lma/UlWVJp/9d0DWViK/rMblIeMFuFD3IBL7Bh63w?=
 =?us-ascii?Q?CSuxqKYisWWhwFbNUWY5eMVwLuCUk3lD4ILPy4STvdgQ5B8JR1tLX8QJAHhH?=
 =?us-ascii?Q?v+NYLVDvS/YU2fWzwGbikOafzMV0O+pjEpfiEKgUm3uTDG3mFDPHSsXjuNfC?=
 =?us-ascii?Q?MbTnr5kFAFTfcrszwtdX42haNHKlwoFIAuDVUOU0fB+A/EdiczL/hoO5M9K6?=
 =?us-ascii?Q?Vmdb+aBUqkh9Hy80zELlkcn9MEgB99w0Tm021WAJKAdZQ1D4sIpDIHuxmtGk?=
 =?us-ascii?Q?/Tnt4rha1R7QGKNUzkvMEPw3Wt8bF1YasUIJNt7CB1VpMcwmO6l0GaLItknR?=
 =?us-ascii?Q?/qM5K6Fo04kFd6bhfHJDt/Pjd3XRxiKP2Yk1pdeiepk9+zkIgbctQgwDrZqg?=
 =?us-ascii?Q?/ORefq78ly0+77KupdnneD/UnXw97gZGD2G90Qa4JVg6DXxbsfTPcRhx9OdY?=
 =?us-ascii?Q?ZCz3roOqFiCGYPEsak2g2sp2CRmABMrFUNt0niS7KVB7ZT1HTezs+n6DD31O?=
 =?us-ascii?Q?k1aTSuhf3YvcNg1AquBJBjCUcVDRmeYSTJrdce4zzMfjjUGQKOXlY/MFZ6MP?=
 =?us-ascii?Q?eXl84wVKsP4WQSlK/2PzvEplpHdbozQH1WUXR6KrSNSEuB4zcWUcPNYAakw6?=
 =?us-ascii?Q?T+C1UztBz3k1C+dbQpjv/2HR/oiYE3CarB7+oUsh37b4srkjVp2VKDfmhChD?=
 =?us-ascii?Q?Mo3krSRjcb0Y34qM1m97exz7cFyWWzpAYQcoZGIfJUbEi3Z2OSOfk11o0nWk?=
 =?us-ascii?Q?BlCI8TuIVxCMcCqls2Wp9CjniQ6Yx1mYAGt+6uP+kNWsEvknl2h1PmH4ISJz?=
 =?us-ascii?Q?QxQTV99n12F1NWdadhPfgpJhP1YAWSEcBkdHXYv1c21uwgOepN8BsMcquXUW?=
 =?us-ascii?Q?/MIH2iccApk4MCMA6JcOimPh0G7nyNe1vvKoaw+xN13jZ/tUrnznxH5GlzXS?=
 =?us-ascii?Q?EXePQgCOku3jHTOZth4jIrbKQEdOTcLZzok2R/GNHGl7YEaMg4JG5T5LBX2d?=
 =?us-ascii?Q?TOvuRDHij3yZjUE7L9Mca8Y/ozXHGeVKiuCxVDNhp1501tqU6f5bwJQi3RPV?=
 =?us-ascii?Q?FpG/bh5hDsDiKyX/pMUBw0qBbs2kTeFpT23CjX1zq0VUbvwMamAHmSEuAyOO?=
 =?us-ascii?Q?8A0thOnI5saDHWPhmje0ebnGxSr+puhTnJc+DNlr7mshXBe9VZhGurAYnv2z?=
 =?us-ascii?Q?IPP9GqMBF5Vvsw1smH/IDnIKQ1/9uO4XFntEKl2EB0VXqhovjoAc3z/qOvnn?=
 =?us-ascii?Q?FPmY0PUJF4/Ebgbrv6IhELwVvj07ACzNyyTiK/zARn+lnahesJtOhg7EA9k3?=
 =?us-ascii?Q?2RG3R+WASOzWhMgRd0YqG0gY4U4uipyNYyWx2i4QJKtfJl5Ce7IR+eeoYRdH?=
 =?us-ascii?Q?jV4yL7nhFxYgPNSqOr/eoz1OrpB+Vd6i1cxfIkRtHa5vHuBhTEAfO4bPdNkk?=
 =?us-ascii?Q?QeDsU2gaKR5BFNIMhGhdr127qBCanej+LALPzyp4itcldafAsfEaGViPRs+a?=
 =?us-ascii?Q?I9KPeCks+VuXHJ7kt0jN0uhdr3yB/q9NjC67lr6s9xdbJkQ61e0tv5b+jRxC?=
 =?us-ascii?Q?R3ibdXL0LplpCDEZuIphd2Aa7U3tKoORs13IF71puWCfjkKePadJE84e6XNe?=
 =?us-ascii?Q?2TWFOlLXkg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Ccheq90pWOPsbGSMsiZMAPZZ1uH4pGV73Mq3jLuKFLL3thGxIwE4ejU/I6b5vsRIQ11tEdcdAkv5o3RpgQosgcP4s2CpbhnDlhDcR5/qIX9qcjiOjOab5WtFjX4e3TtN5qz9ydeqUAKq+X0mpUBvXVnQPQ2ZwyDUIcDdLEGCVf8tW38Z8okltDQR29bFxkEywBP0ZNVijWhERnEkKWMyAtT2TQoDNACzsWHr0MA/1/7Y/+Tn2cRz1Yhn9Shzz8ERM/B0p42yuFr4/kSRCUC8OPDG8b+LvVrTwjPp/YrmPEHR05vgXhsrx+syAS/HaDWa7vOFkTwLYAVgmSJT1q+Nig==
X-MS-Exchange-CrossTenant-Network-Message-Id: ee753293-f6fb-47f2-b3ee-08df011a4150
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 13:27:18.8612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iDw40KPSZQRHnsOl/Vq59tUxFndEalRfu618Run8N+0nM8e+MKwi4wNsr9mVBNrJBUxLGGfYY07973i3qtQhQ==
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: da433400639095b05ac2551f9efdadbd19bfc504  ice: skip unnecessary VF reset when setting trust

elapsed time: 1479m

configs tested: 189
configs skipped: 1

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
arm                        vf610m4_defconfig    gcc-16.1.0
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
parisc               randconfig-001-20260822    gcc-15.2.0
parisc               randconfig-001-20260823    gcc-10.5.0
parisc               randconfig-002-20260822    gcc-9.5.0
parisc               randconfig-002-20260823    gcc-10.5.0
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
sh                         rsk7201_defconfig    gcc-16.1.0
sparc                         randconfig-001    gcc-16.1.0
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
x86_64               randconfig-001-20260822    clang-22
x86_64               randconfig-001-20260823    clang-22
x86_64               randconfig-002-20260822    clang-22
x86_64               randconfig-002-20260823    clang-22
x86_64               randconfig-003-20260822    clang-22
x86_64               randconfig-003-20260823    clang-22
x86_64               randconfig-004-20260822    clang-22
x86_64               randconfig-004-20260823    clang-22
x86_64               randconfig-005-20260822    gcc-14
x86_64               randconfig-005-20260823    clang-22
x86_64               randconfig-006-20260822    gcc-12
x86_64               randconfig-006-20260823    clang-22
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
