Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E16FC5AD5A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Aug 2026 09:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E038F608B2;
	Wed, 12 Aug 2026 09:42:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zXobSBfUneqD; Wed, 12 Aug 2026 09:42:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F1AB608AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786527741;
	bh=XNc1zU+FRbw/IUel+zE+LgaIJfnInf19uQ2PAfws2xc=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fqxIZS9Ai3xZ+OG2QaKoddvLuNnkJ/R1JBGzv0DDLWqdB+wdjmSrFIsIdTcqmM9S7
	 RLmJZG8yYz34kpzQgECA4npVnucTPDi+h6tzRi+tFQCs0ggfw/pokmAHJDu8wKc2IN
	 rSbzHtajUUycNZU8/EBGtTBatNHmMQnLPBcBJiO51bMLI2ia4lV9D9/B1Dr+K0ezQF
	 qO5yfTHVxVS+3AUFWOFNW5Ws9r0T144eT+7i1HX0Ah466PSx1UpMUO0plwfcsjTsZ6
	 qR3vHYRyJOx2FzR/DddqeUaRHr9/2e7cPtPj8fGnxVqbGrvHmyVzoH7z0IZBeuYcIG
	 +MosJMqiQgxjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F1AB608AD;
	Wed, 12 Aug 2026 09:42:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20C241F41
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 09:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F09F7811AE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 09:42:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DhwIP4KT9wqe for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Aug 2026 09:42:19 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DCF5C811A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCF5C811A7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCF5C811A7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Aug 2026 09:42:18 +0000 (UTC)
X-CSE-ConnectionGUID: j43nH7PDSBOALuO0hZVN2A==
X-CSE-MsgGUID: f5zdfh1zRoCY0WwPqKdlOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87096873"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="87096873"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 02:42:18 -0700
X-CSE-ConnectionGUID: hZtYOTD4TmebCVGNOGtIXA==
X-CSE-MsgGUID: 5PB8CAV8TuuxvbVNnFuujw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="267092962"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 02:42:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 02:42:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 02:42:17 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 02:42:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IguPJEEury+d5AwZd6zb6dP0a9vgedTAgxYgsM1tcqi8a/FGcvGxeTw/djFy0sUmN3AFjHuGwhoKOAGGCxI/OfkylILEPiO0vuF2BcyRTeX2dk5htneZCJP2ilEBGPsMqBtAuGrwtJ/9qanwnfYyYIGNvfsdS9bhmfQwMdrZhmtRQeBKKqID1BwfS8cC+AGfYjIucimkD8q/IQsCVuj+Ld5qKQDzVRRDuLv3FaZmbuB3oovu+Ckt3t7mBODpcMow/EzbfGsy2Qa2bkMch/j08zQjgHROPWjEcSFK09bKDFamQqZABzi/TqXMjUnmb4kE4BiY7XGYT8At0f3CQ2/e0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNc1zU+FRbw/IUel+zE+LgaIJfnInf19uQ2PAfws2xc=;
 b=bXM1rkqrVGmWl35X921+VtVrLCmgQPAehJqNHp4+izD+wlz+bnHPva1v+4+BNH5ptnow7SKv9g/2jcUygQSpTT/QJ3eSN+OdYesBhSMRnrmJfdizAPeaTV8ZzBAAplR2Q1yuo5YyUs83fQmGktlQnLvwfSwQHrwXJYEclPUK/56aA+V/1kmWytQw2p+ikwC1lNbVrbC9XS8+dwMmRsSrb9s8gCB3ZbYj9c1sEPuxIyVyZCBavhBRKkT/soH+xD/i5x9sXMz+DJsrgPKh475PcARbCABCVYVEIleFM7X423lcbG6q5Alns0ISI4U6OZN+Ma0Tex/oNHiKQMPo+lvzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by IA3PR11MB8968.namprd11.prod.outlook.com
 (2603:10b6:208:57b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 09:42:13 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 09:42:13 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Machnikowski, Maciej" <maciej.machnikowski@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: Recalibrate PHY after
 settime64 on E825-C
Thread-Index: AQHdKea+MnmbTikz1kizSFTDZwi2+raaKcuQ
Date: Wed, 12 Aug 2026 09:42:13 +0000
Message-ID: <DS4PPF7551E65529058EA8F3867BDAFB22BE5DC2@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260811231058.220370-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260811231058.220370-1-anthony.l.nguyen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|IA3PR11MB8968:EE_
x-ms-office365-filtering-correlation-id: 26b64200-ea0d-484f-803a-08def855fcf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|10067099003|5023799004|11063799006|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info: PFjndkgH3gv8ayTTIFFjWec8u5cXt1XhevvN3LZ4b/tGyGr8LZUiqSletIf+OVkKpgI/NxczAwNt14W1zc+MvUGHDvp0jS1G1/i/BjTfYHwuuqL1Y5Rb2EhOtimvK3owR24joCWuQmIsJcBOC0Nvbq0esgu/F23XLiRF13j9KjhVt9CkGJgiAqlzeMS4H310sOLrJc+BmL0YuewX4ig7PSa5J5FuO6sOqENgXJcrGmLpvfjnLo2OJdEet29ptNC+Twzz+hryQP5lGVGTsVnMpWH5r4CDKNUy2joUi3uXOn7yaN+FZmFd+jbO8WVPoI3icx2XPpzQbjJbIAqf1r4rKtUF1BUg81p6tRZZEx095EbxbO0HdL/VV3/iiYQIkoT7s5RfYAbYqzAJzYGAyvosBKPmsRcVD+91fXumD7IOkEVUaUwTdVREBHlWUsXLAfJD1CzVAjD/a3dCk5J/PY1bK149cCQlbTEY8vFPH4DlKdYCPvnyUT5z1eu+i6U7UtLZNkc7n30hwC56co84AH3Rh99tQXG2S+Wgdr77LHkIIH2aWOlYEeV4To5STeEzITKaeDZa2f8Zxo1UH2MnW4kkpT8V/hv/7VJq3WMLjEc7VKtVXZtcXDAZMgyt8zhE4+rVSGA/xRZF8br/L2DLAT08mxOlxujav1EDQTbPc9UntLiQF0rAMjz2mvA6SmLD1jZ2Y2j23kG+RZNe10cm2hVkxJVzmDCpMpI4/Q5OBgxQR/o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF7551E6552.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(10067099003)(5023799004)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lNk3WGqPtlogKDP+H5MFt7c1HfL6km8/eXpI2uF8HPZFAgh2nPW+3laBpdyR?=
 =?us-ascii?Q?kBc7nlZbsLL0EO9Zi4kWEz63Oka3xZchSZaczRF7+zspWNay8BQE1vZPsm+r?=
 =?us-ascii?Q?OsB3QOtI5hMOQKSSgis22nasEI7CXg+y7R9HEMmfQRqUiq63qN+Elr3wx1MH?=
 =?us-ascii?Q?jXL2AkpcXzsomJsroqfAXmnUhNHzwDptPrPyjigFycQTeekzngxsBW9RAGzJ?=
 =?us-ascii?Q?E/z4Ptpq2O/1kK2cq/5mnUY2C5q689ogcy9Pc9TfG/M29rxu9jtxuciSN4yx?=
 =?us-ascii?Q?y6kUuatmHftmqVcfpKICJKRHUFQw+zlVsi8LTTlxB8RWXA2M2sbmFyZdH2jd?=
 =?us-ascii?Q?bC+lTxX3pJpBLp3jp8rd/gw6tP6FwleJ5ek2yJ7ktGuJDR/DXWllLzqD+R7Y?=
 =?us-ascii?Q?Jxl2uoGXMjM6HQtysskuQy6mahXIbvzrZqwyJcdLRyzjL2nYxUqQyV0Jrwhc?=
 =?us-ascii?Q?CuDlEUngE2vacuPlZYr4Z46TZsP2sx5A8DjY0McxCqEay/+ILZvi3xIGRDZT?=
 =?us-ascii?Q?/KWx4X3wThHbToQVIxf8/qVkbk+riAIH/jAPvXiQTOu7RF4V1JGeqAn7n10t?=
 =?us-ascii?Q?0lNoW0HkeR8G5VgkRoOsjhneZz9SqF6j/md5QbtjZPAInka+LRyFp2KAhyko?=
 =?us-ascii?Q?w9s/KNTs570u31TedfMlB+pOBEwfZhlpWx9C44oEBJ8FWsL3hw3CeIBKNfu7?=
 =?us-ascii?Q?9xf3aBZMfxePjVZGt7SKbsKhTB9QHW82K4ibQdSr3EFunqxtIzJKdj7Vgysj?=
 =?us-ascii?Q?K4FlJJKbyefGmjD4+CoaqAM3Cg7Uf3QYe7slkxzLU2htX0CARPDQk8dOVoxg?=
 =?us-ascii?Q?GIc9YN6M7cJxyuCDb8cwJhiWe8OlOX+x3ut5OA7zPMafskueYkXpNULE6GfS?=
 =?us-ascii?Q?ojEp9RtVXXnB8cpNqsx9ywsdfD/IQ3FYE6N115VNdG3LmxRJAGK2JUoT5evD?=
 =?us-ascii?Q?qfHSGZiAiHIIS9/a2ID9/IRsjUOXioXhZx67z4OJyulqw7KkNXF/fyD5TRgO?=
 =?us-ascii?Q?EODFKutIrnUFj1HrhgjtxQIU2Qj1dOewUD61G14ilWf6OX7t7hJHBE6PsTsR?=
 =?us-ascii?Q?NmH6VLlcH6YJEDDEH/DU5yMeCZlT4EXMDc7j1xR1ngkSyjZ0oUY25OX+K0u/?=
 =?us-ascii?Q?dxHWIibPjZ4BgszusK5X0KYxK/nTxN6FEFTbU5FFx7AklhgW/s8P3u5bnL5l?=
 =?us-ascii?Q?sckv4m+tUH88CBPLQ0pCpBVem5ontpQ8DqVV7+rlb5DkMcbGO6qLnBw2sa0F?=
 =?us-ascii?Q?/cETxJUQyykg2UdcN+vqNagtRiwEzHau8saj9dVaOjrlBBIBd+DLctt89r45?=
 =?us-ascii?Q?4UhL6eCkJrhuFq47TgdWFlZZVjfiIJutqhUFeykyxYtpX8PN1Pkxux5oI5Y6?=
 =?us-ascii?Q?Ulqk+qwBtD6bKiq3Q7TpPlJr93cH3oeR6FDdYccZY6mpPiB7L6oStqwrc9RL?=
 =?us-ascii?Q?uTAKHF8RklWP6/6QRp9v4DHeW+j6Fjena4nkR0yDC3C0lBQXncoj9gPzshBI?=
 =?us-ascii?Q?iiofmfekhXFbCNGsFjymPgN0ImtelFVZExsfrXX0fCxuaxsFdHpKQSJn4hNp?=
 =?us-ascii?Q?O2STq3rMhspcspMV8YTQGDETNcZQhIUuSD7q9qNak/ILfk4Rp3Lz0k/w2uh+?=
 =?us-ascii?Q?OQgh6CLHFUgjDu7hWvrm/F9Cpefi1jygoVcJZijjTMwEewYF0JStRyZdfZZW?=
 =?us-ascii?Q?/vRXS5KNPh8poPPJ4oPAUp5n+ELGR0U9YpKOQQ4xLD/PpSgO2aa2eTSsN7Aa?=
 =?us-ascii?Q?o/zKg/DPUyhrXsTgmuLkqOSlzWgZKW0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OFXHQGNmHyEWuBCeDGMi8iJ6h8PPugxas5nNU+Maang1ILaONfw92V4GbtkOHTmcZbI4rEyvC9Lpxk+JQK/RVFyfL+A4v7ygc5ySeu9aogWxfmeza3KmgvcA8lnCgta5qybXlttxuVMnsGrPP5fhp3AiargIiAl8sp7XVfBoPhx/Jm/WVY1PwD2u/yraEG6QDRKKVCjHrPWcXk1/YN4Lay3NiNaj2MvAXxS0wLmysR9Lm5VXnyOArO4cO4qI8F4C3/MTC/QbzELV/YbJWuf+Qy7hkbqUB+7tQM+zoAJWygEu9IaRrQ1mjDe86wjh+xoIg0fRmHTVx2u24/zXCrrrgQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b64200-ea0d-484f-803a-08def855fcf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 09:42:13.2805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JII8YqjokRfTBtYJ0HpQ9qX01v2EX01TAKGs9R4bofV2DuSnCLQJ5QUO810pwMXgM2+WHCNqOqIhf8sdaXEBhqV0YnEK9gy6GpBZpatd/9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8968
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786527739; x=1818063739;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Qv2gJYpiJciq6LaZr0T/rAiMj3E6C44T16AgMLl31Q0=;
 b=Y+wmFMX/AzH13E9oI6j+Esx8W0X1ioBDzutQ+dz6PqD20K9o2g6pEkCe
 wF1AqBwJxtCgYNzu71Xl5qZpEKDARbmgKLIS/CYZci+ORzwySdlYIwGFl
 /35rVufn6M2+WGJJHCkbQ0nj5lq94Lu4UbogankxgJnZ3/f+qmbIbjwAs
 C6QQmAGtP64ld0+jLPLj1dQPwh99Kl66aeulBsRRo8CZ1gdgC/N/YlZUH
 IgGDtq2bWKBsaPrcUGq83W86LHafR9C2+U6Mfmf973yl3cPFLa8iUPXQz
 J26AC2jh+nNzzhhYOlnc9fOkw2czt+Rfz+W4shJjDcrOY4lYOk5kO+yyA
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Y+wmFMX/
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Recalibrate PHY after
 settime64 on E825-C
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
> Of Tony Nguyen
> Sent: Wednesday, August 12, 2026 1:11 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Machnikowski, Maciej <maciej.machnikowski@intel.com>;
> netdev@vger.kernel.org; Keller, Jacob E <jacob.e.keller@intel.com>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Recalibrate PHY after
> settime64 on E825-C
>=20
> From: Maciek Machnikowski <maciej.machnikowski@intel.com>
>=20
> The PHY on E825-C requires recalibration after large jumps of the
> system time. Add missing PHY recalibration also on E825-C.
>=20
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C
> products")
> Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 84b99cfc5675..bf625b9f4991 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1956,8 +1956,9 @@ ice_ptp_settime64(struct ptp_clock_info *info,
> const struct timespec64 *ts)
>  	/* Reenable periodic outputs */
>  	ice_ptp_enable_all_perout(pf);
>=20
> -	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
> -	if (hw->mac_type =3D=3D ICE_MAC_GENERIC)
> +	/* Recalibrate and re-enable timestamp blocks for
> E822/E823/E825-C */
> +	if (hw->mac_type =3D=3D ICE_MAC_GENERIC ||
> +	    hw->mac_type =3D=3D ICE_MAC_GENERIC_3K_E825)
>  		ice_ptp_restart_all_phy(pf);
>  exit:
>  	if (err) {
> --
> 2.47.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
