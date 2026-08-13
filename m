Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5562C5B572
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Aug 2026 20:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98A46813DC;
	Thu, 13 Aug 2026 20:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KiInJStDcDpP; Thu, 13 Aug 2026 20:01:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63033813CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786651281;
	bh=kVherjv5eEqi5/HJqC7d/ZOqIQTEoahZX6KNYc/sDv4=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wog8FJ4QTiuouqDvcp+Kr9oZPhgSzqyghUUZI4Bk3S4SroJgfQ65cLGo/WZj4hZ/Q
	 T5zJcrAZLWeSYiZAkmDKCVy3yXDFRtp3ojhKXT8vvv/Horjh9JVdiOb5qRw+2q3yDU
	 /lPzeuX+7hqw4rBmG0q0SMTIx4+xfuTfQOGKyGxKpEn3YLu8V1kFiYUWG8Y5XFjXOG
	 oJi3xQQgou7rQesAIQg3IA+ATOskcKexVUtDgOx26DirjREHQeGrA0Vz/WiD6jiWan
	 /CxQARlDlCxAg53KFrhB29Sit6DS0dDLzLDOE1qSI16SyXh8RP1KBdgxc0ndewK8yZ
	 lP6KeWpccekVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63033813CA;
	Thu, 13 Aug 2026 20:01:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48C3B194
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 20:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E72C60686
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 20:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6DPf8KfbDR6D for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Aug 2026 20:01:18 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 825AA60661
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 825AA60661
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QukOPQ27
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 825AA60661
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 20:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786651279; x=1818187279;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kVherjv5eEqi5/HJqC7d/ZOqIQTEoahZX6KNYc/sDv4=;
 b=QukOPQ27FD0bCanPf/7mmtMagupDEGStCW/K8mqCH8YRUxCZHENwEeLk
 XWZfik4w8kcR5QMXysyoU2Yl74+GsAdQBd4UeELqPiPR8EUnrPtWbEyVu
 Ge19DofBFpncNzIKaiVGfDydFnq54e0/XeA0u8ka4zcqSgYpdoxYUzUYT
 bTvmldGLUxqksi7hAwsy9NgCsvTaa/eOya1zcuB0OYPHbXIXJwXP5N80j
 20Q6Yo08qLiPZxxHAKMnxvEe0zsviYvIAaqiVuCFTFncmu1dZ3ebe/sSw
 xMGDTx4pKYkMRDsn22GxwFuxMlZA6oTBocBImxYLE43o7Bw/HAnWlhRD0 w==;
X-CSE-ConnectionGUID: XiMfSndIRLyb2yXb7Ea+jQ==
X-CSE-MsgGUID: +JYyRWwbTx2A+VAI3V6o7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="74773234"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="74773234"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 13:01:16 -0700
X-CSE-ConnectionGUID: eiBTZSpeRiKtTJSd2MYksw==
X-CSE-MsgGUID: /jXd/w5PTfq/+Xp8UnKS4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="262712103"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 13:01:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 13:01:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 13:01:08 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 13:01:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8kD5x8KuiCynPlYaQasOFFRSTFWhtMtlOspAKn50sXGKkvjHFhIvvH4DLR36egAe3c2PaGLrOrhDeqPmQ+xp39SYPOTsWrsB0HoQoQFDqT5Wg+inCQO3+d537+CIFolHALM3bi2pXlPy6FS0NTVumVOSVtmHVRBrpZFsOsqAhyj0v1umBGDRCDR+CZ0SZJkWF23+eZAMw2PWPO5VC2bcj4YB5F7CMWQaOVr4C7UrwF8SzlYFdWJoiAkfTCEYVZ6GkeH0rkUvPrt8A/a63oi1jUVq4CuVhQfzPt2b/nW3/mf2RQPxfg9tyTm2VBLFqM+na+pjP7DUM+teXZcz9jzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVherjv5eEqi5/HJqC7d/ZOqIQTEoahZX6KNYc/sDv4=;
 b=pNJWJwm/85TysHdkB/kJVDS2madTlRiZTjcVyzIS0ol0JBF+2yh08VeKb34Zqg6tVyafnvXuwHEH1YI6K5e0h/5+FStyp2betQovbsV4V9msWmEfDb8/g7fLui8aZDcX/nX6RA4mkZFl6W970ZF2Z8EdNysI0YQSe/elCLUFQBwzZxkwh3TAcbrcq7iMRVBf6B1YpXE6G35liLOrFbGJMjzc4XZDlF/9GTF4wd1C7dChpV9/lfKLZcYc6vni3WI194gC1gcsnhn2PuziYO1jA3APYWtPucV1I9J+WU2X4hy+nmC1a8jZbj5G5dB256/ldKWBCQQN02Pp/RvxNr6V9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 20:01:05 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%3]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 20:01:05 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Hay, Joshua A"
 <joshua.a.hay@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: account for VLAN header
 when parsing RSC packet header
Thread-Index: AQHdHhtsk1Sfrom3/k+wnJDkVoH3zLaGGVmAgBZnNuA=
Date: Thu, 13 Aug 2026 20:01:04 +0000
Message-ID: <SJ1PR11MB6297C2F56DE43C5C71ACBEDD9BDB2@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260727230848.1557452-1-joshua.a.hay@intel.com>
 <IA3PR11MB89867614C1641C49AAF96AE9E5C92@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89867614C1641C49AAF96AE9E5C92@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|DM6PR11MB4740:EE_
x-ms-office365-filtering-correlation-id: a1e63ff0-bfce-443a-5ee6-08def9759b9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: Lm2nhUKmuT+5DXoX1TcnMfCw5/BTNC4LIK58vvs8U0d8wyIKbJS+AX3kyRsaRe2MNCu/U7pGyfq6XzbIPxaCC1adXZyKrbG7oFn4pP/GashFKG5cgmgU4cTgTDEjF1t/996bdemEyLSyWLfAXireSBIeZphrehxWh/y+hox1fbmYDDw5bzItzx+y4VeynOZLCjcnvQKLq/Rjs0yxnFL1KT3A17quTpVYWxol1LRzcb462MFN2sSAjgWXNbFlbNUCd5offrlPf5DMWbAY6P5GleBLeSz+kHdma2d7feNc08NLiWmaR+g0JOFO1E6W0GL3Z5xR7pYMqfU/PRwj+gqW+S3iarmdkI/SabySDWheKutAz9+f9+lt8ykDHowxRnEKGDnWBnD7ZRv5PA1Kk2ZkryDCEhvBAapXE1n8egBApgmud1L1UzwSnz/Sh7u4d7Tz6IxB5PeBHFWdXiRfhvpyOWH8QxLms8i6Ie6nF38u7pFdrZ3pfq3jJm/WMwKuzJnXwlpp8SjvTQ0XPXv4m3Euz0+9K9wBoTq+Wb4YdlCu7OiJaBdMlArdsRDUgr0Q/vtq7uAPCvtcY1zC8zbSO2Gu1Ulg+9fJPPXrcA0azPPArC4ocO14RCX3Fs2zJWsM3PDYiNnZ7iaWMAAk3tCCtxgy/H2g0S7EZJLtXJyX7aFA9fjSwy6iR2/RrAzpcRHWexv5qx1X5EoP/s3G5jvE73JWtg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6297.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6tFRWQrKClewfjRiS6fPDenUmWz+SogpQORRwBiZ+x0UeNUa++8Fw9HQ62ja?=
 =?us-ascii?Q?gHQ/IXAVVRhHpx3wYK4qS0x3OAt31cW0P41iMM3nA1xI+1glLzYte+veYQYR?=
 =?us-ascii?Q?BOnIdtSo2fQim8FcxQgoOt+BTi5wtrvX5KPEvnOYX6jnvsvmYj0Wteh4egz2?=
 =?us-ascii?Q?nPWaGxS8OX3SZvFS/7+DqhwuaOXuCq1bMmi4e9PGOYP9VUypZ2GfX+iA6WKx?=
 =?us-ascii?Q?/shlA/McsRxAHIBjNGiF99V/d9dEV1Oti37yY+HsFrvX+GCK7hZ5kU9vbeKy?=
 =?us-ascii?Q?3MB8tvVEHCb6J83ZjmrjSujEXIUDUQbScIEWNfBVkxfGqm78nOxbj07P43jn?=
 =?us-ascii?Q?oCZ0sMJuYwbNJ1p7E3GqWgffSP0x4W6tKDxOzxcBv02Cs88jVRb3AfSBhddk?=
 =?us-ascii?Q?EgkmSjc7zOb2NVkKbhJFlodJY5tKTosIOBWRfYsih1Z6Lz7g7zjPFgEz/Vqo?=
 =?us-ascii?Q?XqebB+iaPLGraeTrom3lVeu4pDowjzbEXzs5T9NIcAT5J309eKowBAL0FsUY?=
 =?us-ascii?Q?B/dKwiDsg7J/uneIvIJodnczzWt/GS1ZC9fYFSoWJ3Z3k8LjKiRSEVzn5xwK?=
 =?us-ascii?Q?Zav7vSGxiLu7u8a8sNp16AyEcM3AbGx618femSLMwg/j7Cne3u9y8ckI0yhr?=
 =?us-ascii?Q?Z07VGW3eu1kpzCCWadXsUgFDZAPJoE1X7PfwT+e1AJTujWeWFgE5tV3V7CrX?=
 =?us-ascii?Q?QMjOciDZ1JKqpAk9LMIKQpWHZJA2FijrpdoH1n5poFIBg869Sb7MC2JFfskC?=
 =?us-ascii?Q?AnYd+Eon9S8iY9ESda/nLc9tBRlmYoWSwj5jzCnhTeWIknPU7zBj/N4N4OoK?=
 =?us-ascii?Q?Qe3AOjCkNNb/nashBMvkVoqjvW+zdbiWFF8tqm2Yyp9YM35jevU3oPT3WHfy?=
 =?us-ascii?Q?Ud2yp4jebL3hhYeuQd8S5HQtswSbPT/uNuzNPDubVRre1htrayQT3vaaqcFP?=
 =?us-ascii?Q?/ejy/bOWHvCVT75D95MDiR6HGHGLSEuUkCVf7uVe7ihx8kJLDVMF5seS+RIa?=
 =?us-ascii?Q?uPuHXAEuLyYiwsYhlr19w/Atzj5+ObXmvqCEZSM0+GJWrasn/Ep4tijT+N6f?=
 =?us-ascii?Q?nLUTrT4Mgy36483miRsFWhM9Bx7qaIKKkxRlEPw7ZjKImGtd+jyjdJ7IjXyu?=
 =?us-ascii?Q?YJcrb5iF3UCFnOx6QbbtNMhgCjFl44NWDO0Evg/aUEbB25/6auFYkIF61a7b?=
 =?us-ascii?Q?Q0V7X0WpWq9/BZk4cJZax4x863oSqFu/X5wjHerI2MkPs3Zu6YWW4sDut99L?=
 =?us-ascii?Q?AQkTdY2wVUcFo+Cf4Q4/FondG5/p5Z9nsH9JKW9aFmTpGQDYJ0MrC3bU4Ih6?=
 =?us-ascii?Q?dSDz5moGbXB+KGZF8pKdOogS+umW9T6a1WsfBtMj7RTaxKd5/nJgOcnAn2LB?=
 =?us-ascii?Q?0iqy3z+JA2sakk+9XXxdhdnJwrdWPfLTGzt4sBf/9StUzjDhy7nlDtrlBiZ/?=
 =?us-ascii?Q?8jFzMiBZJcP3XEFikEnGCAt+3QOPu0pHytp9NSMHIL+ppHGNUhy7f1Yogvts?=
 =?us-ascii?Q?MesevpJgoP2sK8+m0IsX4yw3vCEnDQqonLsRk1w5ubR9CwT4+kyO9etZnA7v?=
 =?us-ascii?Q?3Ka2YAwdVWU7XHuq//7XMl8mfFQ+Fjdw5v0pezG0AruShP2zIrKu245niUm4?=
 =?us-ascii?Q?+o0AJphO0ZqPfJz7u1lLuprwCvVThRgfluBclZRYL8ZnVy0S8sEysQ/1fFm/?=
 =?us-ascii?Q?jkpccoVSFm9T/qQZvDZZFdxp+BJmAkk/U+Yi8TSl9uMMATiljhk0R6TBwUSc?=
 =?us-ascii?Q?ivouK6YJaQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ozKROE4mWiISJrBpY/C1zZMerQN6+asOPk5jYvW27XDpT54KioydCDP4aRogalVpnQU5AiXyWocwsWFKyuphXwYe9q8FyWf2QWVSWaQJtg/2xIGVFDB0/QbxoKZEiGDxTlBW9Y0Ep0DJbYFFLp8pYaeIgJ2bbcviiVX/BRKDQtiS72jt8uh3rhBjt6h174v1xWTxEZ3u4UtiMUsmqi8/ohoN+nT4sCuvhl7m2R8BZmaY6Q35UAz8no/8aFA+04fgKk5O6WOMgWeJTueRXtG5cPz9jFA4Qvazb8jmrNouHaUzk/ADAOPNVKlekqExROdq9jGJdws4erJ7/9erYmVNuA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e63ff0-bfce-443a-5ee6-08def9759b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 20:01:05.0167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2MN2e3hoI5gUWmaW96ccuLH9CSgVAfY6HiQjExVMc0R/eF5gj0phP5yF5Ckx71XTxdHWNNXK5IvdPXIkGDLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
X-OriginatorOrg: intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: account for VLAN header
 when parsing RSC packet header
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Thursday, July 30, 2026 6:53 AM
> To: Hay, Joshua A <joshua.a.hay@intel.com>; intel-wired-lan@lists.osuosl.=
org
> Cc: netdev@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: account for VLAN hea=
der
> when parsing RSC packet header
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Joshua Hay
> > Sent: Tuesday, July 28, 2026 1:09 AM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: account for VLAN
> > header when parsing RSC packet header
> >
> > While parsing the header of a Receive Side Coalesced (RSC) packet,
> > check if a VLAN tag is present and adjust the header parsing
> > accordingly.
> > Otherwise, Rx TCP traffic is completely broken for any VLAN interface
> > whose underlying interface has RSC (rx-gro-hw) enabled.
> >
> > We only need to worry about one VLAN header since Rx packets with
> > multiple VLAN headers are not candidates for RSC.
> >
> > Fixes: 3a8845af66edb ("idpf: add RX splitq napi poll support")
> > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
> > ---
> > 2.39.2
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Samuel Salin <Samuel.salin@intel.com>
