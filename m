Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4424C531F9
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Jul 2026 11:33:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9273E409BC;
	Tue, 28 Jul 2026 11:33:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZks0dRsKQhN; Tue, 28 Jul 2026 11:33:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAAA3409A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785238421;
	bh=JT+lQJdIUtqxhXDZ//+5T7t8jxz34IvLjai9YtTMc+w=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ppCr730j0WwV/wxrIDHYFD/W3onpIdHgybBvhwgPnLs3ofOxljiFqZ78EEDpNHujz
	 pw8NjQDnkMKWXobZs9xPaH9t4IYJb7ZThMkMgMqYsD2AuSZD6jD52BVgdjl9F6Uiji
	 0cNoOf5pickHSt6fd1DusBLiFheif9usyRGVLbg4tnPv1EUgIZAA2y10Y2CEWUCOjH
	 I5+f86fFwD06k/CB+XPGvWB1dvj1lNXTFWvfUI/1zbXt2v920O28M5ip+Wnm93EfVL
	 MRDlglNK5fU7EozZ/J9R0B2cJJ7QXns7/z1rJsnLlnLHWdcDf84e9Y8fECekLkuSF/
	 z6uATvM3z1Kew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAAA3409A7;
	Tue, 28 Jul 2026 11:33:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 47EF742A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 11:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 394D140309
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 11:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oq9Yn2hQiYj4 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Jul 2026 11:33:39 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 59BB4400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 59BB4400D3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59BB4400D3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 11:33:39 +0000 (UTC)
X-CSE-ConnectionGUID: 0ANOWbhuSIaS3xzOJc5KRA==
X-CSE-MsgGUID: xXbNjFzvR7iyYektoWgNHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89489145"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="89489145"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 04:33:39 -0700
X-CSE-ConnectionGUID: VEN/RXmLRjOcKrID26fg8Q==
X-CSE-MsgGUID: G/x3g9EQSQS9hg8OueISPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="255744644"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 04:33:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 04:33:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 04:33:37 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 04:33:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9urrI6q7IBl0JpzfvOGJBjUnNaSmwe/8mVNLzuA62vH38M/F/LBFMkNLFKEy8fXRi72um0t5jZuoXA81Pz6XrGizdOmyOQZTCKYVL4ZDu+vwbWjI4mXV0Fpwlyxsdfh0TkwlFlDUgSwrVIVmY1qF+Pm0BaM0uxTwifbfRLEQHMpIDK2CaMNvlxGBeDPvZVGqpv/vGrtZWXQBwNsM91OE5lR4fHRljdf5/7AyXfR8IohQeYv8t9E8jR+/fIQ43b5yq+wqxAlqniZXwshJMfQKuguBVZTqJ42BOhGlx7LerHa6p7LfX7Rzz2pXt8KvDMNPv6qbstGsCPYGA0k8ABobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT+lQJdIUtqxhXDZ//+5T7t8jxz34IvLjai9YtTMc+w=;
 b=f6qDElKnz5E5JcQlH7o92fm/tw6CrxWIfks7j1psBIkFne3vEB3xSHhyc90kloLPzNJ9wPKcp3M9lKEqjutsS7rTuyPwejeHjo1JinUEM6/uxmZBhsnomx/LdJYsEvmEBgrv6XRaUjgx7N/tEWcwcW74E8IW/cro2Mcm5oJwu7yJhs8sfFN/Mz3P3lRI70Z0VV5sjWQynDHTMQAZnjb75kUX6vACaJmDGGKHCwANEQgGGAupPD0SxGsE+KdYTjQU0HypN1Qq4OlKNTCXv6K+SLUJPU6qdLiiCvoUIiOQM6iqtBrIoBbumaq3YEGlnFgKhvSlIHFLS1XiNXCQzwFUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:33:35 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 11:33:35 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: detect duplicates in ACL
Thread-Index: AQHdG1md/GJYyfvzxUKn52aAErkXe7aCzztQ
Date: Tue, 28 Jul 2026 11:33:35 +0000
Message-ID: <IA3PR11MB8986A764DBAB961509FAD3EAE5CB2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260724094454.16079-1-marcin.szycik@linux.intel.com>
In-Reply-To: <20260724094454.16079-1-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB6219:EE_
x-ms-office365-filtering-correlation-id: c32e8fa9-76e4-4066-ea43-08deec9c0fbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|10067099003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: qyO0IJHDeJ3laTM2EebxEfrzmg8aTy6j5eyOgbQdzEMGcSwfch59/JJbqYz7wqrEZPDIL/kD1INjmyB9BOVTVoU4mqeP47NCOk8L7ejisqUUIa/Xq6sF0iw8Kmx30nq7krQYfIz3EjrPNFVcR+s917l2D8dQToICslBt98QW+SbwfTDiWgWEx/ybNvfqyqO0FmAon3K2FeqvLqW6kRY63tOwxNeKmXupHMG5ua4/tJnoOj7GjXm24etBS8QWWmxpnJoM3Lg+iSdGM8rQoOQHhhVHD8+zegw0wGp3p1ftbYU9Z5CESCDWKs8Ulgw+BLrxHqbu7Jp1U4kUVzuZ8PpZsRXIP3KGfBLiTZ8DijfKIdg2jZpOdrubVyTThza/5tTf12NgRDmc0DvZOvvFIX/kMjCjUp629GCPzmGvZS2uIFmRm7JKc/3lHLXRl//bMZtWiX5RVB48PYjGcxlnUk3pF0Q9T4ULEMDssmERzlVSfeWRNrxsBRTjIfrIGXJn6QvzXDjS1e0XMK9UMSHKU0AUcvAOJsecvARGSuKGtE3y3c4PNvGDUGAlnP668uzZEu6KEGEm4eqqslYljIU04YnDOX8nQP9UVvwa+uEIOXvAunuh2cml9qpPiy5o6drOM+3t+/k4qAsxRClB969aTeuVdOm8yN2LD23ydhkP/AVAKsNzpVQVRPzplymA7/ma5jFLOCpg6HjaR3bJPtKSCy1hajyi6d3wqT7A0HF81PrOX8A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O2UyPJTYZbNMqGKLtsdH/lHlsFTRbWjPSAihMAKRPa6lBl2zNqh/4DobToh+?=
 =?us-ascii?Q?GBwzD6E3KemlksT2+YqsS4pboB4szTwJPxKkrH6khADWRsyuwUcKNDWvl5Ms?=
 =?us-ascii?Q?SjNxNjiwB1a0nsaLas9io6Hcz1nLhfS3G8RrufGYOjBJe0PU/PEJvMO14/my?=
 =?us-ascii?Q?t3MhCRjL0b5BE0GcC3TyUH4EoTb4JJWHH3Z5YKZLpLFtkqvrdfT72NTZsJw5?=
 =?us-ascii?Q?B4ZfCI3YcPdgjxhCEoOI/L2F5Ods8Gy0I+Tik/r4H+gBA2jCccBPpE1XW1zc?=
 =?us-ascii?Q?fNIt9HRKmsP+kfrAb9PFxApXWJloiuRF71QWMvkhKywpLO1XaV21d459Kj6N?=
 =?us-ascii?Q?J+365rEuZCDvKts0Qh1VGx3vWQ4nOhMXT+QdvrdFvDoVrs1H8dYIjvFjAH/7?=
 =?us-ascii?Q?ykj7EK8zAPUGVyyTGDJSAIoWG/tf2ZywNOdJSdZ4OI0CbXXzboWShyZ19qG4?=
 =?us-ascii?Q?1XXniSnx7npBfVkh2HqE0/fEAHpZFWa23XlwioAFHyI4x5GtDrQZVwI1m/cd?=
 =?us-ascii?Q?tNA6QH5RG/AXsugqCTGxBhXtix+DvemPcrlEGprcfbv76LNkjdN6TXHifwyC?=
 =?us-ascii?Q?JDvZMdmYHTt6KMSU93OOaOPeI+EC/EM8ms8ZgIBK7QfXweicIpYNIg0hU8t9?=
 =?us-ascii?Q?DR5MWJTxjuBZFkNy3dRDJf0cPYs00NlWn0ZZplOAOJxPVF8yCBB4PmAzRWdq?=
 =?us-ascii?Q?fsVmncDQq0A0I2/dMRD43iCEbJvKXuQijZunXJ2V04Frre54HvxRui8ZfKMC?=
 =?us-ascii?Q?sncQrUWTl2MU5VWm6z7Mz9DAlkxGUD/lEUctYkJURGAQs80rAKXT/g6FVAeu?=
 =?us-ascii?Q?31AbvY5lpQFWNn3SxukAP2LusXNBrIDs14K91KxBgUbTTtwT2wpbx+keW92W?=
 =?us-ascii?Q?0kVV1DnKzY02wkQgREvJHKV6WlqCxAnFYYNWjHe4L7THDY1OsCj4uim+dvbF?=
 =?us-ascii?Q?2A4kiftkWJkSCtP0ShN/TPITeVS3CAgeVNnZUJ2NzBPeA4waywYFEam2aYnV?=
 =?us-ascii?Q?3BiVHUYTEjm5qWwfh7TpvPaQvRs3DiogYrtpqI6oGyxacjLIOMktCB4IB7fs?=
 =?us-ascii?Q?6FPgWbw/eY6YhLNHUM7RV96CJm3//8uSttMOAAZL0MGf6+kNMJRRT5BiqhqD?=
 =?us-ascii?Q?WI5NI7Pd+1g6IbEBAV3FYzxDLpkWXk5NGLbI+gtz545A42099drAKdiQH5Y4?=
 =?us-ascii?Q?GaDbEO7NnGEUGU6ny/yg9Ch6tWTFwAqpHI4pb7cCPWhsVDpYnSBoiUdh/TSb?=
 =?us-ascii?Q?HHS4RVSjC+3GCshuZB6hruQ+l5YI9miok5C57TG0EVg5ZIO9cvjW+Oy5kSIX?=
 =?us-ascii?Q?RURm+GhUX+shpQGCedFLK2zOHxxIzgc0z0yPBTK5ZmcfibtyfwR39jbA3fnf?=
 =?us-ascii?Q?QaHq33rte2NybTCKx5gnUlZc7Hj9qKVMT5P4o85JCdRZxIQ1yuy3CCBmtaKK?=
 =?us-ascii?Q?MbJyRpKhkGGpV8JpJbDu2ARM+AH3k/YbbJhnXPMx40hDEdNB2anfld4EIsmU?=
 =?us-ascii?Q?MGcYfAlHsMIJdlwcIoZXYWZ4evfxNGMp6HQSoegR0LU5i0oaj+ZYyUk4YpCG?=
 =?us-ascii?Q?a6L4RFnddMAhzUUuneGrVgMqK9tSP5Use97rM41eKydKoA0hlaRRuzsWl0CS?=
 =?us-ascii?Q?zhyXcl9Z3jXdkszNq692k/bHUbRsmSt1YBKj6W1SO5k7NEf9nM6+rzbFTYnP?=
 =?us-ascii?Q?CRwXpzsazrpEPVNKHHg/BTeusZfAYXCs4Crq8qAFDy4BO8wEFfhLH+AnLviG?=
 =?us-ascii?Q?2lP2zyjMazUT4J4G7Ma/6fdX4wnVt7o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Je6YRBljEhOOpCPldZf+xh/vjjr+YxHpJ/Qad2yNqFpM4+IXbQBqHsIs093x1RgYx966FJzwd2ovLTCLgqaPDsB8zi94am4IYSKC3uOmLterIGsLhTTw4w5hkY4oYbRqzCvL3Nhg1Ik0QRqf2L6DM0VRhGBs6R4qkimiUtqJu528HKGO4pp/hdqWcY+ODhNMK4cEziK6kOcEA7Gq+h5jYlao8LTCEiYcJlPebmcckD1lb7a/fS42c6rV6DQLKRFpESwoSQnLzNdb/vXD7owrO03ojByhtWvlzvBCIkWXzxUcM8/b+rdYPruG7w3gExr9BX5817xLvgBbb+8JHjknrA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32e8fa9-76e4-4066-ea43-08deec9c0fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 11:33:35.5888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFjpJQIiNbaLj83/wV8ryo3hgmbuMnBD+HaNszkr+Net0w2peKd0m4XcSIWA57QPNBZR6TqJUGWq2je79OfqXresnnuWO3Mzt1103C4ju8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6219
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785238419; x=1816774419;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dRBZl/1dJEw9v/Blj3mVo9zlXEEglsxMHa7m+gDqdWk=;
 b=jcly6GZfKg/OaCmTXg6H/86yu/BCjqLhTPCLDJneRHpxToHxaGUhWhN+
 BUbQU++75nZ6geN69Bgi5PLJk+VdcWawWobYxXAT+/qg8N6hOweeG3qGX
 vd7o9xdkcCWZlHFHJMzIgxupGaMm1iRNghR1jVPNHBUNPGYq0tEySn0Ab
 yYxrwmsWJsSNmLeS+x4no/1Np+FREPdMi73EyUX0ZZe4Dtp6wfrGXqtmK
 gJgvz8eFr1nflFJFyRN2rYnpkoNOfS0bLbN4Jdg4+i62dTSCOFdpsivCl
 UArIxottm3LlQbBlGqq1wNO2FKpb7ZGIRlqNGsOecR0JoyhRwRgBDIrDS
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jcly6GZf
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: detect duplicates in ACL
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
> Of Marcin Szycik
> Sent: Friday, July 24, 2026 11:45 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: detect duplicates in
> ACL
>=20
> Prevent duplicate rules from being added to ACL.
> Also skip checking ACL rules in ice_fdir_is_dup_fltr(), as it's only
> used for fdir.
>=20
Please add test info: HW/ASIC + PF/VF/SR-IOV, kernel version/branch, exact =
repro steps, before/after results (expected vs. observed).

> Fixes: fe9b91ade50e ("ice: create ACL entry")
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> Not sending to net because the fixed code is on dev-queue.
> Tony, please squash this with the offending commit.
> ---
>  drivers/net/ethernet/intel/ice/ice_acl_main.c | 87
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |  3 +
>  2 files changed, 90 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c
> b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> index 7c566077d55a..473b329b37bb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> @@ -283,6 +283,85 @@ void ice_acl_replay_fltrs(struct ice_pf *pf)
>  	}
>  }
>=20

...

> +/**
> + * ice_acl_is_dup_fltr - test if an ACL filter is already in the list
> + * @hw: hardware data structure
> + * @input: ACL filter to check
> + *
> + * Return: true if an identical filter (same flow type, values, and
> +masks)
> + * already exists at a different location  */ static bool
> +ice_acl_is_dup_fltr(struct ice_hw *hw, struct ice_ntuple_fltr *input)
> {
> +	struct ice_ntuple_fltr *rule;
> +
> +	list_for_each_entry(rule, &hw->fdir_list_head, fltr_node) {
> +		if (!rule->acl_fltr)
> +			continue;
> +
> +		if (!ice_acl_comp_rules(rule, input))
> +			continue;
> +
> +		/* At this point rule and input have same match
> criteria.
> +		 * Different location is a duplicate.
> +		 * Same location with a different queue is an update
> (not a
> +		 * duplicate).
> +		 */
> +		if (rule->fltr_id =3D=3D input->fltr_id &&
> +		    rule->q_index !=3D input->q_index)
> +			continue;
ice_acl_is_dup_fltr() documents that it returns true for an identical filte=
r at a different location,
but the implementation also returns true when the existing rule has the sam=
e fltr_id and the same q_index.
Documentation or implementation should be updated.

> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +

...

>  		if (rule->flow_type !=3D input->flow_type)
>  			continue;
>=20
> --
> 2.49.0

