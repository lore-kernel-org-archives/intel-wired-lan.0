Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF26C5AC7C
	for <intel-wired-lan@archiver.kernel.org>; Fri,  7 Aug 2026 10:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E51FF40A12;
	Fri,  7 Aug 2026 10:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uNvZ_s-74t51; Fri,  7 Aug 2026 10:56:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9AE240847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786100201;
	bh=P0lI860LNZyKuNg6KCaqGa887mUZ1+lpNq3bQxZAICM=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EzLxPqrKJbsthRaPCjKcmCj9aqag4kr0qBYNiXlFBwBtYTdjab6zuC6FIm4b9Cb/v
	 5V3qZsnHbG4+R96jgtDvmgWssW2VhxZPb+eVKw5pVubKHX/mBSOSuWwjCU36RAHmMa
	 2WooQTF6TZtYj9Y2hAVhujcfGLsUPSV7MARFUEz2Wtr2/EawQqQPl7LIL80hfNPLYP
	 JDUYqIc1we8OucIMkZR6lHp3lE2p4axCyrdvNIGPfeyL1a+qX6d0jtwEpCqssVnthn
	 aaCHqCcuHJv7mcQCQfdwhJp74taTW8L6Y+H6lGyqLd52bvwKxoP2MOLJDydCv52FrD
	 fEmgkSQNMibWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9AE240847;
	Fri,  7 Aug 2026 10:56:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 12BA4D3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 10:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03ABE40167
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 10:56:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ly12q-huBUoe for <intel-wired-lan@lists.osuosl.org>;
 Fri,  7 Aug 2026 10:56:40 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CEA5040064
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEA5040064
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CEA5040064
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 10:56:38 +0000 (UTC)
X-CSE-ConnectionGUID: BrPaVhIQQlGOfN0BBwIasQ==
X-CSE-MsgGUID: RD0xtISPS7a8nFlSzILRkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86557807"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="86557807"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 03:56:38 -0700
X-CSE-ConnectionGUID: Gd+Yt8gASV6J4WPfZRh+nQ==
X-CSE-MsgGUID: vvLI3x0nTSi0ZNmqVyJ71w==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 03:56:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 03:56:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 03:56:37 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 03:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvW/QCbmmYsifug3iZ4270LfmaQ9S5gUTbfl8ERhJRt0cOPe2e2kSAsZ+qkz+rnmDCmKD4oCuli85YuqnI9QUdoUD0Dsmo9RJkgBmahB1tZsErvPLVcdYIcGBuvPbJnQiwFLQJv5A7S+vHJP/GXPmzQqNZdMG0qhElfK/G3F9tkDSqVjwWviRy6XxflidHhrtHRnuMHqpTsYEm0rP2LUL+t9rCz9gV3pykLKz7eYB72+gMXKpReVm0lRQiA3KZcw2G5Yy8yoZg8097uzWmNzpPnbu+JeSvc53QBb3duPDIYtTRhygG5SZotHPS+lclAvt1E7EpQ/wSo/6ZYgzfu/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0lI860LNZyKuNg6KCaqGa887mUZ1+lpNq3bQxZAICM=;
 b=ALRABaCreiWBgtYY0QQbAQP7TlpDmFj7Mw6NfEVKCAELFwgLHeZ+QK8EUp7Kx7YrhJ12z5NR9o1i0ICqCWpVq0qsPF0qCF77dbAqB5zQEHZZsrTIrYnX56oWRotn3Ywd/npDMCxnm5aGVJuR32JhfO2nFHxrY96gCjClmky/TMd8xI9kIw0r0fb2lGK0dAmvJNHblHJPcbsL8PWt3Ho2z5PfrrlBEkeysBX019eju/Q2Vi5jZHvJB1jUWFT67JfosgkFbewDCS3XEQSGukVWi2fuI3jvG8OmQ+EbZyTbngx6pkkELoNlvXar2b0fzFfJpKbG2gBardDzGvmPykAqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by CH3PR11MB8187.namprd11.prod.outlook.com
 (2603:10b6:610:160::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 10:56:34 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f%6]) with mapi id 15.21.0270.017; Fri, 7 Aug 2026
 10:56:34 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ivy Lopez <skunkolee@gmail.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH] e1000e: fix incorrect modified flag
 check in e1000_read_nvm_spt()
Thread-Index: AQHdJckVqL2dnhokukK8jxDxTHgqUbaSawfQ
Date: Fri, 7 Aug 2026 10:56:34 +0000
Message-ID: <DS4PPF7551E6552AF076FA235232DAB1E95E5D12@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260806172452.32139-1-skunkolee@gmail.com>
In-Reply-To: <20260806172452.32139-1-skunkolee@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|CH3PR11MB8187:EE_
x-ms-office365-filtering-correlation-id: a38bc3ec-7411-4a39-ebec-08def4728be2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: tHCdCcmMytmyfuIxLgURSzSMaFR9MRvc6xOYtZgPfQRDQoEmLfTdNEqxYqeNzL3tNgN0kgI4v3nwyUuDA6XcAOwjHJSejDuZCubh7+ZjAWy5z9z0kQvQDT46NIC74TfVqyydgIV3a5t5n4Gg2qIBmHfrf0G9PQutMXwSNiszdW58UbuY4HQxeXRLVjun6HVHG5oGYiTh61x29u2uURxCm1cfHPcpAURrYDlyU81t7ZkSzxMqWjpfY5C4GpG6JQKs1eGnO+wNCMRrHbE4Of0qXdWuvKTY119VbVE6mKfRcIlA3qCjMxN/MXUr0sopK0wo4FTlQMAH984VRzsMxtu/08yzvOMmugTDHOxcZo/BB/5aEJr5hH1HS6S4YmV5WxV5xDJhAoAWFCNWLPJMiTms8refwMAeo0xLN8nWrvlJScVYf9kbv5OxrVumMaUP4f2D0LC0t/R8kJU0dl8CyK1nWM/ArR6ItAKKdGRnUCQgi+A+0FIH0RaNH+pRoQ3k99GvjxnfD1Wpg4PJLQiu9jYyhBvqTWUVCRfroTiC8YtWAi694A746OrnB/sNDGV/N9XZKirksPV9CPDr/poIs5Wn7mTQ2uja7f9V4bQdqPild4E4OtVsnRpZd8nw6rzRBD2qEiMg5lysHG6U+PMMtSwsQ3wu5BSYQFYMBXKd0V+Ml1OojwxwnddcJ2A2S5p9xhC15otML49Q/lxcS67hEfbpeHgg/ej4m4be91kPUsgII4o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF7551E6552.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gkcHuTVFK6HEGp/uc4+mxV9mjSq/kV0s0vMqhQI8cFHIywTPuNUrNTf5Hheu?=
 =?us-ascii?Q?MMHRBwiNK5u1EAIcKhngqFiroU11O7SzR6X47GxNX6ezQ5zJO+qfnqfJE1X3?=
 =?us-ascii?Q?FM3sCkT/eYzjIQcrj0ZNyYR6wXlhCXjl28tsvKNRYFT3w/DAulgzxAJjgDaP?=
 =?us-ascii?Q?HtRqcn0ErtNR2FbZyoe5nyKJmXm5ckkF5094A1XR8/wdmkP4ti6Bqg0gqbbj?=
 =?us-ascii?Q?4yqk+YTld60nZncDqkvHxEa389FO+cfnZpWHD+0iETPmSBcON2ZTbsjELuGG?=
 =?us-ascii?Q?R0ytF4bAOLFxPIx8U8sjFCtcNPhRdrPxEyv/vveRAhBFCf/VhGrsgi14AhUc?=
 =?us-ascii?Q?2RRBtjRX9fG5M2TUhh7kJz5iJhAzzj5uKrrnZxE8H2md54kvvcCexQSMtBGv?=
 =?us-ascii?Q?v9jtZxauiFgHAux7KdT6EkXq2yWqQkUWakW7t5PMN3HS4MORbOoBB4DSu1Ik?=
 =?us-ascii?Q?YqReCjQcvBGT2WKxcvURYEBQ7Tii7YTm8h9yHACvANCLI85oHoT8vdCMiFEs?=
 =?us-ascii?Q?vxv3ghnHjNaVTzT6jrDqwXUYubUD68dtaHcguK/3UE8A03JHb+mq6bRXdm1w?=
 =?us-ascii?Q?/78cNE1n1MWaDqpiRu7tMa/4MrT9s+Ey7LK6YgtNoadLxiyRIVANxijcAofE?=
 =?us-ascii?Q?MUKb3g3YLSUYMTOYT9M+htWCoqPREIDqhBy8Q0hXaztiDrCiH4PTGTRY3BM6?=
 =?us-ascii?Q?X3+1+gHqQqUKPfLGpvC6U0q6u9lVPN1YSj+SpkB6Ykr4DKujLq9G3oqR2Ol4?=
 =?us-ascii?Q?hx57rXXOxVg/QITL2DvPCyzt8QqKs7oYi4BdW3Ho49a+pyDdknADKSBaoZHM?=
 =?us-ascii?Q?vWYf3qnvGI8oYtcTozjUHbkJEaVIS92tBhVdSTPRKgZmfWTpcKFG7ATiRF3S?=
 =?us-ascii?Q?9V0uPcbjCBJ4+gcKNcr7eUzxCTakrrUYRJnTmPPlm82HCDD43ixoqPMNYEZJ?=
 =?us-ascii?Q?+zFbKd6xKFFXTe9UQySuk7VNUZUkQR5fYYcJbfa7sz8qf5/ylRiGfOc6IrVm?=
 =?us-ascii?Q?2y/dGLXwDJJ0gANUSbws3Tw4LUeBGl+u3Fjv6qG1b1dBtzmcQRHWH+F+4rcZ?=
 =?us-ascii?Q?S35Xb0zkFxu/rJvx1EjkNsur0giP64RMHojl3+qS/+3PGqX+oUJPsD1RxX7Y?=
 =?us-ascii?Q?finuYYNiU6Tv8dhNDnCxAl+keqycCHBIxKb2VM2Udshv4NBmwJarp71SVkfi?=
 =?us-ascii?Q?fEQRxR0spAzdap7S6QZY6ZAjvVm6mXxhGtie5MKMQbtq/fz6suQGvEtna1D+?=
 =?us-ascii?Q?VyO/SFIi8eGfAfjHQSzy+1jgfeurcxVCZW8TvQ1/LNYzsRaj5scQzf9grVej?=
 =?us-ascii?Q?fUiwLwvDPCxxFwkF6CmwkAi1LSHLcTqHd9E/iKKgdTB1rrgGLQydRS5D8hvS?=
 =?us-ascii?Q?DSsnEne8k7z5EoeCUN9bYaVKl0Ig6ov/ObsZhdNyYAwibulwhvUf5+7FJhvk?=
 =?us-ascii?Q?6t4zUgf96hgTfGiBW8kEhcUDox0iRxDPVHlSvMxO9PAIRgeRC5q3HMfdY+ay?=
 =?us-ascii?Q?CMy+jE4N7wfL+HPacpIx4JBqI0eZLH+yUdlR1bHTuzXN5eQkquFBM67csU5M?=
 =?us-ascii?Q?6JnspAqSucQLbl4bX76yvyGtdibr/GajUrqoga9MF2IMrAHMMXCrbYMPJjzu?=
 =?us-ascii?Q?8wOdPlrgkGaC0pbKLicmX0dNnfxJ42eHIA118ZOTIpZelRFWfIOs63xi+opW?=
 =?us-ascii?Q?EBzhPB4WFlpQolG4+t7ptheSusynq9tmsibTxk7BLsZTn4fcSvxzEkBp7cMI?=
 =?us-ascii?Q?WbqCeR+PFw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TtQC5e70c1qdpIUrmpxMWEOS17rm+ja0CY7rWo8vUYCE0xLro/aF9NLpzZSxSHq4QNbJmcmcaaCfIlXVNCaw0P1o7hJtTfnqhyQjb6RonbU8Os4yt9vrJAv/ZvrBikLWRlRrjw8/qpIkPwmDXWkga+v1WaPfFbcdx56NJ95WZoRjW/AyyH8XEFvoJLWAIqYDXLWpnuJJIz9NNoPfEOmdlB+OzktuVhBBz9yVhoZwdWC+mGr3uv6Nd/0Z0YUjdnk6ywtaCTvx7JTK9DWSVzkNQb1MCmiYyar13hEawELY1pA75utZrwMVtafLXh//jQC07OjcP730jDZ/orvdiV7JWw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38bc3ec-7411-4a39-ebec-08def4728be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 10:56:34.3442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /E6b7JMGL1aQAMJZ4F60cWQmw4Z3ayDQFlPccgDwOJB4eFFB+GSqpzq5tFIxRuFJkNB3MpON8VT8SWRpZjo5BvdhmjIIQyUYK3vbOHuUQCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8187
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786100200; x=1817636200;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+koQOZBWaoEmKLEYdEP6rk5g4dnJKM57NPzF2OLUc6M=;
 b=S86CYZhDuBPqz2Rrq6SzihFPJ47hHwgQTj37Jd5yk5Tfr6WgHNQpLDZV
 6nhtEAq1EPho/wtLIze6vxQBILkZDZ37bgcq5NTSE8hGHLgOEiTjw32aw
 99P/WrspyZg8HIpiocKxlwcG/MZZizqltk0RtlTWcN475ADfo3S2Gt8j+
 nJ2qOUeG3eYsnh8UgBZskIEQ661eqT9l/GECB1idbIFoMJJJBrPNYYtte
 Aq7Sj3VL68VqfspXlHG+SszKGwu4AXsVW93xsHrIg1Kr10uswUZY9UvQI
 0TfUdE+UAts9SmE9AUrNAgGSYF9RdGXzdbDzZX2TKYyVYGvAMLb0IyQ0F
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=S86CYZhD
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: fix incorrect modified flag
 check in e1000_read_nvm_spt()
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
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Ivy Lopez
> Sent: Thursday, August 6, 2026 7:25 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ivy Lopez
> <skunkolee@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] e1000e: fix incorrect modified flag
> check in e1000_read_nvm_spt()
>=20
> e1000_read_nvm_spt() reads two adjacent 16-bit NVM words as one 32-bit
> dword for efficiency. When deciding whether to use the shadow RAM
> value for the high word (data[i + 1]), it incorrectly checks the
> "modified" flag of the low word (shadow_ram[offset + i]) instead of
> the high word's own flag (shadow_ram[offset + i + 1]).
>=20
> This can cause silent NVM shadow RAM corruption:
>  - if only the high word is marked modified, its pending write is
>    lost and the stale flash value is returned instead
>  - if only the low word is marked modified, the high word is
>    incorrectly overwritten with the low word's shadow value
>=20
> This function is used on all PCH chips from SPT onward (SPT, CNP, TGP,
> ADP, MTP, etc). The bug has been present since the dword-read
> optimization was introduced for these chips.
>=20
> Note: this was found via code review while investigating a separate
> reproducible packet loss issue on I219-LM (SPT+ PCH). Testing showed
> this fix does not resolve that particular symptom, but the flag check
> is still a genuine logic bug that can corrupt shadow RAM contents and
> should be fixed regardless.
>=20
> Fixes: 79849ebc0e06 ("e1000e: initial support for i219")
> Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index aa90e0ce8aca..87cd1cdc6f10 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -3473,7 +3473,7 @@ static s32 e1000_read_nvm_spt(struct e1000_hw
> *hw, u16 offset, u16 words,
>  				    dev_spec->shadow_ram[offset + i].value;
>  			else
>  				data[i] =3D (u16)(dword & 0xFFFF);
> -			if (dev_spec->shadow_ram[offset + i].modified)
> +			if (dev_spec->shadow_ram[offset + i +
> 1].modified)
>  				data[i + 1] =3D
>  				    dev_spec->shadow_ram[offset + i +
> 1].value;
>  			else
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

