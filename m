Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930E7C5DF97
	for <intel-wired-lan@archiver.kernel.org>; Sun, 23 Aug 2026 13:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59729406C5;
	Sun, 23 Aug 2026 13:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oTKsotgfff6k; Sun, 23 Aug 2026 13:31:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787491886;
	bh=UxgnWS888QthhdG1CKizqkkNtw5ExtVCMfiJ0CoFFUk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zURi/0IHKNCQiI+azrhQKJdnm2CGIotl6or4O8qZCNbNn7koXT4W3z/1ETL8I9ldJ
	 XSYIGXTgvPgPz0UkpM+0VTXZ+FhhSRVp+MBUgiUV3Ir9fAjTg4wThLnu2UVU0ijIje
	 X9eGi66udHfkrC4iit9RMat8V6cyi9j+vtXgzdk5w63W0I5B2KJLvWdzjDPj9Lcks4
	 atpUsJ62KzxGXK8SmhtbtIO3mj2YqaHnL6KfZ6EJ8jYOZKV2nAmszNBmIAECWnKUbk
	 tpWHR9so3DCAk7kkG72CRFcEcepga2ll4yt+ZjrTbX2xnC3HsEUa165+qsHls4r0bd
	 /pgJUJ3cScpGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83AE0406BC;
	Sun, 23 Aug 2026 13:31:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C83982FD
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE30380E1F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:31:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qgs_mEDFHK91 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 23 Aug 2026 13:31:24 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Z1kgy+Ma
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98E3380E25
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Aug 2026 13:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787491885; x=1819027885;
 h=date:from:to:subject:message-id:mime-version;
 bh=bOR1TS7fd1BnWYtywn1NuY5iHWM304YEoXuXnKNbeyw=;
 b=Z1kgy+Ma1X1J5c3e3hUbNWhgSbhQMcgzLo3eEo+saW8W4WRBkzaXRene
 hPke1tQW5mInjULXLYGd3wo1hm9FMn8TeWMlZMArMVsoU/AJHz/mMJtEJ
 ia4TJffrOtMikrE7Ao/i0Oz5TmAgZQ9PtZk5K5GOHcXmVb9cP66KYRRfm
 5gYTzUMiaU77hKQw9/bcrrBVPHA+3NSCMdun8C/n5BwS2U36PYjRzbCYX
 jB/UYkB1+3yfaz0IFUPIArN9HJXIiDCF8x3A1ohfuAxdKeAGGFv5MGCNb
 p4BMUiOO/c88iSYbQ+Clto0E+eEtNX6EWYHGF6XGVjG7QFJyCvM32kIN/ A==;
X-CSE-ConnectionGUID: Nm1lprZLQfS7oxviEW9oAQ==
X-CSE-MsgGUID: OM3akXo+Rr+2HO0KloXByg==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="88021735"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="88021735"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 06:31:23 -0700
X-CSE-ConnectionGUID: gZatMrC6R7GPCulTIlO2sQ==
X-CSE-MsgGUID: Xz4cvhV/QxuDk4mEbg2wsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="266247897"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 06:31:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 06:31:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 06:31:22 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 06:31:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxG4SeKrrbOrlXLfowileq4Xu4dmgDnswNc1CtRxiIqzTMMxD3ONBZ51s74urpgl0LDG1+IMKgJAIRgGI4xGRyQnr5BJ6JlEbapn11K85T9D/IMgt1hQkWjv9gRvS2BVkxDUilqm0beeVXJYLmV5+lKflKYBBeh+2b1lKW/K5HPXKFbNmZ5ExZQ6eKbRKiYlLvP1LeOyF1X1/DoWXSBL2mvlyJ8+t7qi1QRDfdnlsrOFIFV0wEeR+k/vdfG1DnZ1tJE54VG38LZVhF/+Osufz1oJD556GyQHcYovpQi+YBxlfhLLL72F5iET8Q0cCgQX/Dy99Y61CFp6YGJrAxaWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxgnWS888QthhdG1CKizqkkNtw5ExtVCMfiJ0CoFFUk=;
 b=MYTEKkZq1KNEBL5Dnh4uNCwbMAULIM3LmZVU0ct6mnWfXXSo4xQzm9Wz2INbDLfK83INHRLaDolfiie6eOCQN2GjXDAPFnX4KRjtl9425U+BZ/Ea3Ig/Ne4q/o4tJHBHnuQxh5dDq8i3JvKF+szuGhzP6ESmCc3uwNnAZRJfpvm+5mBmXTzbV09nGHPYgldeFgaQKLBcP9vEfsYs8AfUaLXnfz3otLtgDXVEgFSQX9XqEBgBmsuOuZ3lN1JRJHmwY60LimbHRlB0pszj0NmuvmJAuhr8Jm+n7viGZB2AKmcebcW2Cey4VJLMwJyYnWA/H8vYDGMELLvqX7UzdkwC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 13:31:20 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 13:31:20 +0000
Date: Sun, 23 Aug 2026 21:31:11 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [tnguy-next-queue:dev-queue] BUILD REGRESSION
 ddb94d444660e7d658d02c10e6ddd5125178e1aa
Message-ID: <202608231245.6NuaZhii-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU0P306CA0056.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:28::12) To SA2PR11MB5212.namprd11.prod.outlook.com
 (2603:10b6:806:114::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|BN9PR11MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b87f35a-55a5-4c12-1f82-08df011ad0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: p7qtGmXHLLAM5Mq7L45HKTI9Q8sjFx4KHKYbgWswmIx0qXwqyZmOHfNieF4eJKiJ5lDxwR9RY3RAMbEYSgvah7bZLE/au7Ow/LutOanzGNvOXnOo+uor/s77N4svBka6H/WXkP8h+ncJd6Jp3sHxStROg/IaU7DBC5dOncpjafaY7HJ9rGBVPmrIMeSYI5v3ynNDZoc5O9G8nOWDWAYE2sFeNr2Y2MjCDrx2+En8WGRiFeHUxFPtBcPcCStOh9a3R29AeMyEJ3KckHMwD8dFUU4FWgSbXKaAtbhtXaAVuOSBrLECNabsdl1jmU+gnOcOuoPz8OA7nuHVEwnM9a5I8FTPzn6Tj145bX7AofSzkCXmKPB8dlN7Vv5DoINnBQRKHz7qiHVFnz66bW0WVpzqzt3NwxCaEyx0f2SLeivBafkFbcop0bzIlCrOTfZPIKfXuFv7+F1zYAbFJrMoTRiMn7PC3OfQ4jt/ZVXggd98GS/MRCAXADlv7z6SPyXirXXKXPNXVJaV+n7j0sYRCD3nkFyb/QfRl5p4EQcVh80ysAO9bPoyoKuZpLmj0SyqoOT1SBXo4jsNmBDLfHRY9bvgQZESWY8O0GhM5bdKOCqVjO4lQYG3dhbFIngIgMpyuIx046LFH6EVwj5L/2g/idkzcZV9aMgcoz6I3cxJu/Rgtyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5214.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QGk87f9b95Sfip8TUYNTuUgAhUEO7U55PVoTFneoZFMXVanDgSC154VoMtb1?=
 =?us-ascii?Q?sNMW7/HAH1Ov4J2iSF6QbO32sF9j8IIVmbPXkU+UWSZ3SpaDyXdYvOvQWy3J?=
 =?us-ascii?Q?b1V6uh0pqg7Wctb6TY9+nl8adxSy3G8PWKJw6pYuxooAr/+b44CHj+zo1JS6?=
 =?us-ascii?Q?v1iI3vFE4GZYc+fL4VHcsapQH+5qkg66ZbUpAwFqq43Hp9uUr4rONPL9bCA3?=
 =?us-ascii?Q?6OnQW4kFc7df0dQrIUg7xHB0X3kEnOxPLxks0PokjzitmoNECHyd/6gmZ4/Y?=
 =?us-ascii?Q?xLqXBb2yBlhBW6LIirs1HuTWP0UqVFWGbhQqD1amIcVoKrAfJYz6BIrRhdO7?=
 =?us-ascii?Q?YUBg6TGTmJwK4cHko5kdQ2gXu+VP9Cp4XqsLhTg8xFGYQzxk3R+5vkIhACGF?=
 =?us-ascii?Q?zT4lTHqPINUh0rx5zeVligtcv+lUrHApS9xUvuIyeMFeOt0BZ6WczA/S2c2G?=
 =?us-ascii?Q?4fdxzu9SJvl5rAD4l/FcKrGIpfec324la6CXTAA53Fp7RH5BYVo0bgfZM6IV?=
 =?us-ascii?Q?ENQBuYnDi2y98SCBnR3ySADGbECafYW+//NylfBoK4Evt6cWw603DaxCrGh0?=
 =?us-ascii?Q?H8wHOPSSZuKw0dhP536FxfZn66LANBLZ34HJfd/TDKgeQMl6qvmyZg8S5ynZ?=
 =?us-ascii?Q?ToOxKm7T7RJfgrNRUca8FRB5YDP9Y1mRdyQqlr2A2NDbBE6alau4hEcorqQR?=
 =?us-ascii?Q?DvEm5E1fEyoKs41l5mgQjO2bc+aQMNCN3Cr+iI0+slaItNvcMvTBqlGqQ5ty?=
 =?us-ascii?Q?PhXDSTNafI+mfKWLwy2lmmWw587qq4fhIuOLoz72IPauoWWrQAmdcekVOHGh?=
 =?us-ascii?Q?xYEs9RcxeTJaBCyw2WCt8JvCGjRvE/55Q9RWb2bC9e4u2VsoHNqk0yjDoggF?=
 =?us-ascii?Q?ZDIMAto4cwWDMh2U27kAjb48f+6hxR/psMZrU5WpArZYDlYGh+5dKMHXn4uQ?=
 =?us-ascii?Q?anCY9dG8TziuTbBjn8u3zeOoeb0FY15DGC/DQY2jIrdFQWVitRuH0r+Wf0RW?=
 =?us-ascii?Q?lnFvYvKtsdA2LysvKuxAgRohp8iBP9iq56SOunAK9m0NeTWCpkBnkA/8XbEp?=
 =?us-ascii?Q?2hb/ppvqdBTkw1kZzsOv3WbD8qdVR/lbuH3BQdiypD2S6XaFntG6RX1VvkjO?=
 =?us-ascii?Q?f3vAwtgSIHJ+6TaYA5XvTZXgziFebYDrgQEbwjOEf4pMRxnqutVEK8wTd9Tm?=
 =?us-ascii?Q?AP8IXG3UIJyFWaM34/cw5fJ/3OsLSgI0O26rE33SPvXf7G30+uG3/w8fGhm/?=
 =?us-ascii?Q?X3AGjqB1QEhpYRFRH9VXbx0727z48v1957JydNvb72gUOzE19TBxlJsDnMHV?=
 =?us-ascii?Q?uOBakTtuvkR3t0SUcoFF2N4VYGcAz2ASIQv1jysmuQwrBzJnSRGF0tEEx2U4?=
 =?us-ascii?Q?s0FFW0E+TcX4BuhMWI7paixh/jSQqkAq63WmcoutbfDzmQ2bOrlpMCP+r9qw?=
 =?us-ascii?Q?IwlgyLkl9lnjChbd0pVRLQNXwqosXt4wHu1Nw9Bn9cNDQb6IhKTNXKC83LXZ?=
 =?us-ascii?Q?scLGaS4hAXPqm7yQW3xLINossQmLDqoMtUqoFc1pb9Xypg9rgKyqDmqMlR+a?=
 =?us-ascii?Q?GJO9M/X3QXAJmZv8jheDLrVQet+Kq7XD/uwCpRyL4uNAdmnZ3zgs+FUcQJL7?=
 =?us-ascii?Q?I+qGq5u7wql4zDO4582o19dB+q2AVhuuH7rOqT8AaGwDP5c1pvwdjdjCmchx?=
 =?us-ascii?Q?nFBT1vGM//3WMPrAdQdwc/yn2ekVVZ6cb2r/XHxh1mDjr5H7ioGX/6DROeo4?=
 =?us-ascii?Q?rgxWJIYpeA=3D=3D?=
X-Exchange-RoutingPolicyChecked: DApRktXbmeiO+lYWI0cJnjF2NspqOxrpfXrBoE37L2joB6b/dtd6VYuOQ9+6AMHRhuynLQbGhh2h7MtEoEq8XNVaJoBgDR4do3rFjzBFTUUY00xsAQ88epECi9QbgPwMgusB4++QlCji8O7rnnhgRgRX2Hv8cYXAknPP6Z1ZjH6q4U6SkBL+UtquRREDU2Nt7Jcnm+5mPvijbwIaaTZmUom7ON51VjAnV3JbS1xf/2sxoM8EVZuKotp1FdUTsvww58xapNvqs7eofXPi/tVFi3Q2swtdfQrKDUL+ENKYM82nQKMZu1r+LmWoVRpebVATesyvbtrFfsF2Zd/LGzwbiQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b87f35a-55a5-4c12-1f82-08df011ad0fc
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5212.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 13:31:20.4583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJQ7mYV06O7slqlz4o/VdTGW90wHrJ65rRROljfDdFcFcQ6Zx2cQFnLGg55k2hdS+2+Lo06b3RfUDEJ3LXIhVg==
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: ddb94d444660e7d658d02c10e6ddd5125178e1aa  ixgbe: implement Total Port Shutdown for E610

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-allmodconfig
    |-- drivers-net-ethernet-intel-idpf-idpf_virtchnl.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc
    `-- drivers-net-ethernet-intel-idpf-idpf_virtchnl_ptp.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 1476m

configs tested: 111
configs skipped: 1

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260822    gcc-10.5.0
arc                  randconfig-002-20260822    gcc-10.5.0
arm                  randconfig-001-20260822    gcc-10.5.0
arm                  randconfig-002-20260822    gcc-10.5.0
arm                  randconfig-003-20260822    gcc-10.5.0
arm                  randconfig-004-20260822    gcc-10.5.0
arm64                randconfig-001-20260822    clang-24
arm64                randconfig-002-20260822    clang-24
arm64                randconfig-003-20260822    clang-24
arm64                randconfig-004-20260822    clang-24
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260822    clang-24
csky                 randconfig-002-20260822    clang-24
hexagon              randconfig-001-20260822    gcc-16.1.0
hexagon              randconfig-002-20260822    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260822    clang-22
i386       buildonly-randconfig-002-20260822    clang-22
i386       buildonly-randconfig-003-20260822    clang-22
i386       buildonly-randconfig-004-20260822    clang-22
i386       buildonly-randconfig-005-20260822    clang-22
i386       buildonly-randconfig-006-20260822    clang-22
i386                 randconfig-001-20260822    clang-22
i386                 randconfig-002-20260822    clang-22
i386                 randconfig-003-20260822    clang-22
i386                 randconfig-004-20260822    clang-22
i386                 randconfig-005-20260822    clang-22
i386                 randconfig-006-20260822    clang-22
i386                 randconfig-007-20260822    clang-22
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260822    gcc-14
i386                 randconfig-012-20260822    gcc-14
i386                 randconfig-013-20260822    gcc-14
i386                 randconfig-014-20260822    gcc-14
i386                 randconfig-015-20260822    gcc-14
i386                 randconfig-016-20260822    gcc-14
i386                 randconfig-017-20260822    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260822    gcc-16.1.0
loongarch            randconfig-002-20260822    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260822    gcc-16.1.0
nios2                randconfig-002-20260822    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-15.2.0
parisc               randconfig-001-20260822    gcc-15.2.0
parisc               randconfig-001-20260823    gcc-10.5.0
parisc               randconfig-002-20260822    gcc-15.2.0
parisc               randconfig-002-20260823    gcc-10.5.0
powerpc              randconfig-001-20260822    gcc-15.2.0
powerpc              randconfig-001-20260823    gcc-10.5.0
powerpc              randconfig-002-20260822    gcc-15.2.0
powerpc              randconfig-002-20260823    gcc-10.5.0
powerpc                    tqm8540_defconfig    gcc-16.1.0
powerpc64            randconfig-001-20260822    gcc-15.2.0
powerpc64            randconfig-001-20260823    gcc-10.5.0
powerpc64            randconfig-002-20260822    gcc-15.2.0
powerpc64            randconfig-002-20260823    gcc-10.5.0
riscv                randconfig-001-20260822    clang-17
riscv                randconfig-002-20260822    clang-17
s390                 randconfig-001-20260822    clang-17
s390                 randconfig-002-20260822    clang-17
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260822    clang-17
sh                   randconfig-002-20260822    clang-17
sh                         rsk7201_defconfig    gcc-16.1.0
sparc                         randconfig-001    gcc-8.5.0
sparc                randconfig-001-20260822    gcc-8.5.0
sparc                randconfig-002-20260822    gcc-8.5.0
sparc64              randconfig-001-20260822    gcc-8.5.0
sparc64              randconfig-002-20260822    gcc-8.5.0
um                   randconfig-001-20260822    gcc-8.5.0
um                   randconfig-002-20260822    gcc-8.5.0
x86_64              buildonly-randconfig-001    clang-22
x86_64     buildonly-randconfig-001-20260822    clang-22
x86_64     buildonly-randconfig-002-20260822    clang-22
x86_64     buildonly-randconfig-003-20260822    clang-22
x86_64     buildonly-randconfig-004-20260822    clang-22
x86_64     buildonly-randconfig-005-20260822    clang-22
x86_64     buildonly-randconfig-006-20260822    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260822    gcc-12
x86_64               randconfig-002-20260822    gcc-12
x86_64               randconfig-003-20260822    gcc-12
x86_64               randconfig-004-20260822    gcc-12
x86_64               randconfig-005-20260822    gcc-12
x86_64               randconfig-006-20260822    gcc-12
x86_64               randconfig-011-20260822    clang-22
x86_64               randconfig-012-20260822    clang-22
x86_64               randconfig-013-20260822    clang-22
x86_64               randconfig-014-20260822    clang-22
x86_64               randconfig-015-20260822    clang-22
x86_64               randconfig-016-20260822    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260822    gcc-14
x86_64               randconfig-072-20260822    gcc-14
x86_64               randconfig-073-20260822    gcc-14
x86_64               randconfig-074-20260822    gcc-14
x86_64               randconfig-075-20260822    gcc-14
x86_64               randconfig-076-20260822    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260822    gcc-8.5.0
xtensa               randconfig-002-20260822    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
