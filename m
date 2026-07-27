Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B27C531D0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 08:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B421E60675;
	Mon, 27 Jul 2026 08:27:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P6htqJzM3jbM; Mon, 27 Jul 2026 08:27:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E1DA60672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785140842;
	bh=jqHv2kFrH80krCXt+CmZCGPNdEBSPYQzSIg5+a6DMQU=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OAQ891pq8UOm8PJeUMi6DkeBTWNgFc8seaAgMTXdYuDBxB5EHqn5g/ckZ6bQXsBI5
	 gvRUrrDfjI64olDmu0TWl0iOg+2emO85lXCVbhhAJ0Q5RDD73PyB8r67l0hjGCq7c2
	 WRXFdrpf2UoQLWSqj9fR8z0ZYGQ3JkKOrlJtNgIs1mGWFlGktzrcy1a2CiuMcTH72G
	 rLb+H3txlU7ewUJwH3K+HHxEJSjxMXDPgnOf0DqnZp5qPf0EInweIjCM22kU1bYJFY
	 PlnTuL0LNmBxHH//YaH+Cfef0a8k83fcbaSkHn/Yq5vdM8gFNhZZQ+JKxyWlGMamus
	 FURN9FIwkJdQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E1DA60672;
	Mon, 27 Jul 2026 08:27:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CF1845B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 08:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E90D60672
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 08:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mBmxUoDlHrzN for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 08:27:19 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4DD396065A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DD396065A
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DD396065A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 08:27:18 +0000 (UTC)
X-CSE-ConnectionGUID: qo4luJBlQCqCrlwYYw05OQ==
X-CSE-MsgGUID: z8pNbelZQ466pMZ8NjSgVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85573325"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="85573325"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 01:27:18 -0700
X-CSE-ConnectionGUID: uJHYVEU8QzO34MVj7GA5Lg==
X-CSE-MsgGUID: DtPk4d3kT3eSA6GngV1LWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="258071375"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 01:27:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 01:27:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 01:27:17 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 01:27:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxRaGngNzdMvOMON1GMJvc8LyOlvThfOXjy5mlChpt88Ld4DaAeGhKU3uDzGjpEMPvKY5BASYyzACZxW4fJOn/HHbzBKq6qxAFA6ULJRe/M5V9Dlkt+1J/0Fv2NUCMzaLJFv9oVYsUfbCQDOOmPVpmenxyHLXamnG0nQ+iC407DsqoxM8+jMBKqoIHp2FKqlAnAv+i8J92YIUSJhrFS31Q4QB86NEAtLpNwxO399UEqTOChjA5S7Jqp3FQWb1iMO/CeCPlluahRIxqTGKycTbjhcqtxbq43NnMBy2eNWPiZvNz7bhmq4OcKSXy92W2uEdrmVkjxibrcsuJuvwtwkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqHv2kFrH80krCXt+CmZCGPNdEBSPYQzSIg5+a6DMQU=;
 b=nKzp582Sh8pDESSftqaJZ4ftqT1gMcB5ChZZdRl6qhZ3xzOcl4EshMX91SFFk4EFRihOy4UxNv/73l2VYTUhfcyC+5B+a3kEyYCO2qwb61DrdC+g+U29ARd7/el/Nl8ANMLKzRBCQHUkQ71X0pMLKZpcNoPwVrx9WuSMRQf1wwK8TZUn1KhIuvSvyz9vgJTOc2pLctFGqI1uFQx9Z+ZxYEccz+uWSoB7MiFy8pT8Z7oYAEN9FkL0LhxRDq2fdZ4ezxx+K0oFzvMKyzyC3JTBdWbL6cREQmouCCRqrl3Z1MqYsoFeOE0Y88lnJAcnsov4gB0VgZGYJpHzu2uHqkbNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 08:27:14 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 08:27:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Robert Malz <robert.malz@canonical.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH iwl v2] ice: acquire NVM lock around
 each flash read
Thread-Index: AQHdFeWeJuCZbMVMeUaU+LgND7OJ7raBFxIg
Date: Mon, 27 Jul 2026 08:27:14 +0000
Message-ID: <IA3PR11MB8986E2BE513E6BA3AEAABE6EE5CC2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260717121224.3908963-1-robert.malz@canonical.com>
In-Reply-To: <20260717121224.3908963-1-robert.malz@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6031:EE_
x-ms-office365-filtering-correlation-id: ac6c665b-a740-44d6-47e4-08deebb8dccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|366016|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003|3023799007|921020|38070700021;
x-microsoft-antispam-message-info: FipoMq6YTdr1tfO/y7ezpmhrHITfzhMlW3YlWAnFaeWdFpVticUANYHiOSmIO1jlBLqCk41vK0dUieXBw72IXU1X/fwTUCTGrTAUAisFUk8Jygrs6M88YAtcXxcHhyGtYqeVTYjoRQDTp0vywukCNYD6TAF1W7WgU8FlK+GffngywXKdI0hB4uHtmdvMhNzwFcn2vBvZbQsa3EqXY4rehlaG/Wuya1JjGdPcbw1P61pZhvq/iDzxo2tQV3deBpZfQP4VWv8vcWKQwObex6Xxm7Vkgffe7c9NeD7dZ8PpXWi/y5cnOEmNqfu7MILEP+tO31NSufHndZ0tH6LAm68KX8bhjWkqHajnH26y219T2sw33KxI1uCGj2e+bHa17Y4NWDdDHhL0JuUtNGk6Agt3Ooda/u2KBtgwwVrdP9U7QIVirDqUgy9EQg9u8AvYOLKDdiT/cKj8K3sispw97R4wHcPbKoKMCOdGMXZMWNyU/40r61sLjGquNeC19j/NYs9Nk3enZdBIMz4TgShJ6op6O7sZvJ6+Dn8SPqnwzOnPwSquAEJZTWZw3cf5UhlPUps1g8ItAyylwoXEpUI3JYXXcZCOd9FCGmNmuSnQ1h+BVwtgvkaL1DratyH8dN+t1yED4A47Q65yRvus7z0Lxcu659BBFRyuaxzossrVbGrVe6E/0xB5HORhZHFrezJlRYfInwl7QMzCEgy9XI6a1tmhWM61qzAj6wIuPrmLfv9R9cw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IVN770FI33Ru68L/IiVJoSVIfxaS4aIeY5R6x3kgiKbsGS5zduOHEraxijgR?=
 =?us-ascii?Q?yF+QPscrYiUKyH9DTycuanjG+sfqszxmEX5HeEKAZA4qNv4pwOqHMFzPo5HZ?=
 =?us-ascii?Q?2EZ51PvSfqoCNZLfFwz2cyQkS7fueVTTU1xWaIWLZVs3IVAx16FhNfEZDcm8?=
 =?us-ascii?Q?QCfVoWs4VYab22FoiuZjEy70qFHK0ixz8StqL4FUfSZkBDO7o0iSt6wdk406?=
 =?us-ascii?Q?6x4FrlmaY43M1nRLjVd5+1WJYXd3fxLk5gIBnDfHPZOBNLzrta2hb7jsb6UA?=
 =?us-ascii?Q?ZXS6sJ1awVzML5H56WwFDl18rukfTkAM5z4va7bzLXI4PIRheOmJmbMV9kSo?=
 =?us-ascii?Q?LpmiUWS9XVqIqsTA/2iMD8JxAA/EMVO0oTrOvqDXp5IkuzRR+LwpsvLYXOng?=
 =?us-ascii?Q?/rK2Eik3/QjIN29Hzf0K5cCIGUTdbVWnLsMNodse5Zmbc7RM9n86UH09NIC/?=
 =?us-ascii?Q?dmbQAkAwe3+bXtLw+LAdw8+APGluTMeoVqDJkdiXUjBx82yQbVja41SBUg/d?=
 =?us-ascii?Q?rGVSW0GlDkClumIZmV5xKWY30ljzDDOVl6qml3ImTMnl+hFqfmh7oCAdhrZr?=
 =?us-ascii?Q?Kt2O2+BHHCcNgHgqZyS+rgRN2de0/I8Sf3M66Yi0YxRyUGURsy7XPKIPQUxi?=
 =?us-ascii?Q?LmY9jfMbtDY4CQSwiuUso3fWcJAHpOgSZtzKAIHBqXAiK32zU4KBE0Lpv2gK?=
 =?us-ascii?Q?DLNUAqfkqZXvyBhHr0Rg2IiVOkCS4hYhLnWr+PSdmPRxE/9wIGm/Az5Bd3QH?=
 =?us-ascii?Q?hbIT1C/qX+SU3lhqb3RQreE0FoiHIspuoImLc+R+BfUrCcAw8X6OPktyy4C0?=
 =?us-ascii?Q?huIFCWoZPQTaEspivDYpHI73c6xpmJ1ZzH4oR38VZR/FTs66fad8rYSykQ9Z?=
 =?us-ascii?Q?leMell95pi8g5ModqEfUCCAJIz/kpnYMIRvEkJkBBAkqJYmaAcDyjlsgXznc?=
 =?us-ascii?Q?w2vZW6Xo7SxEtMn9Sb//sNGwh4UylRc/C/JvQGeN6if2/noVMVTJNjW795q+?=
 =?us-ascii?Q?JM45GLBpWW0g22rI/LdU7fZaFhMv+/ktREcgxIBpRmaAe5Gqf4PvEZz3FUWX?=
 =?us-ascii?Q?K1wDmYctr3GT18K8A6IhLYdN8dJhp/PO3zhoudRjWaHCnqyrNM7nvAxx5ddV?=
 =?us-ascii?Q?L6uhlNxBa5In1lpfnsqjnmwtizI2ElS29wIoVtH2E0E9p60E1DlCwikbArfa?=
 =?us-ascii?Q?lAH5F/yDlw3uakIYZf3+Wgij07zZNmK4TRxvmukR7148PnJnDTy+CPcEFzws?=
 =?us-ascii?Q?puRKSaYrgJMLGJPSOhbQ2CCnGKXb/domxKyjlqjXl7zr1h4qk5eygcXuDneJ?=
 =?us-ascii?Q?U/8fDJU0YZgbwc9Npb6V4ZsF1X6wlwQoQG15245EaUQE4AG4pG2An1pO27+H?=
 =?us-ascii?Q?GnSwTa5QgAvIdoE+Y3YuKdMX4DWLsEgaV7O8zhHUyfTT8r6raPHMtBq4nLMu?=
 =?us-ascii?Q?tcHKnRNvsWrSuA8+MA2rW1f6u8Hxg7YdZaQnI1ir/QFqzcIZSoVnc3Cbruzo?=
 =?us-ascii?Q?IuowpZyQCjLDpWM/ny84cYSxfP537ezoMn4WVD3CTeP5kHUND+fEufBkzXm5?=
 =?us-ascii?Q?DzM6MLT3LUz6yZ68+8msCCP7oDsVE6YTRoqrRD/Q1z05JkoZyJwDcKwpuX4o?=
 =?us-ascii?Q?r39gtEjp2ODQlMNA9H0qwiS4fnld2/WVi+aIkAim13JNaRcBu82OY3dLbvIr?=
 =?us-ascii?Q?eruUNxXGHgNIYDeVh6qvPDDsL2hKH1N++y5E/Yn52Sq0ShCMkkpbOBba/iKO?=
 =?us-ascii?Q?tEJ7aQmR64q3QU8lwER+AiCJdV597qk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TQmZmkwekmP8Df0j4c8HFiDbMaBGLcsic6bJ5bVkPAMCu4wbYNbRbt0CgK8wfKjtxwZyoN35J/fdc+8LfRNDFUiLXRSZeK4OL6HdbdpyEZsI6BWotip2qH3qxuYhtahI8sQXia0r3U8e9NA/aco1BvzVXlSjCfHRte0H1BhV2C9Rw5B7EdICvPrgivQBZxRij6PBeGGsEEJ4bLTqz6pe+D26RbfovofWiS0mDXEGJSiu/UCLiEKCpLaQSRsS0ZlEsdgOUjSde7iz3WvG9U4RZ//NwE6KdZShWV+kHrGyRAco5QwbA5cGY25ac606+cUwNMS+jEiB585ganfTnh8TQA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6c665b-a740-44d6-47e4-08deebb8dccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 08:27:14.3552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiyoEYae2lTE31z4yY9A4xX1s3KagzUm+iVlkSUB2vz5qdVrn8dG/UpPYbS983Wx+mEnUHHAFkSLDPWmkfVs7JsYm7Mp07RhxN5TjZzz60c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785140839; x=1816676839;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tDq0aJg3ncfavzlNas3vl9gXzqp+hwnLBsrPCwFjLhQ=;
 b=Ow7azLIGVb2tfb/eHuMJFfKAc8QmdFXH2UpQsBoN0LfcDuFlP1Q1sUUS
 tb/iR/R222QL5+0CTyWtrJTCwob9n7fTgwyn7Zg++9l1xEK44ucpzJMJq
 eQretMcgxgqAgRmc17gDezo5IoiqO/vhXVnpV2x0eAxioJ089VtXNZbEk
 h53tdg2quo55Q/AqyyOPKjFQoZ1KmHBAgLiLjy+FjAI9lZUITic0MOCmM
 eMv70TvNmLmi1c8l/J8KiC76uF0GgtzLkee5K/sfivJmGM7fEl1Z/sCZ9
 95GDLDzEEGfGFp9MGk3s5C8CWCfYRRMVR+HOm+oAGPhy5NFtpDJJdmJOT
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Ow7azLIG
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl v2] ice: acquire NVM lock around
 each flash read
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
> Of Robert Malz via Intel-wired-lan
> Sent: Friday, July 17, 2026 2:12 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Jesse Brandeburg <jbrandeb@kernel.org>
> Cc: Robert Malz <robert.malz@canonical.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl v2] ice: acquire NVM lock around
> each flash read
>=20
> FW caps the NVM read lock at a maximum of 3000ms regardless of the
> timeout requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a
> read into multiple ice_aq_read_nvm() commands, one per 4KB sector, all
> issued under a single lock taken by the caller. Reading a large region
> can exceed 3000ms, so FW reclaims the lock mid-read and the remaining
> commands might fail.
>=20
> Move the lock acquire/release into ice_read_flat_nvm() so it brackets
> each individual ice_aq_read_nvm() command, ensuring the lock is never
> held across more than one FW read.
>=20
> ice_release_nvm() issues its own AQ command and overwrites
> hw->adminq.sq_last_status, which some callers inspect after a failed
> read.
> Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
> capture the failing read's AQ error before the release; callers that
> need it (ice_discover_flash_size() and the ethtool/devlink log paths)
> use it instead of sq_last_status, others pass NULL.
>=20
> Callers that previously took the lock around ice_read_flat_nvm(),
> ice_read_sr_word() or ice_read_flash_module() now call them without
> it.
> The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
> dropped.
>=20
> Fixes: e94509906d6b ("ice: create function to read a section of the
> NVM and Shadow RAM")
> Signed-off-by: Robert Malz <robert.malz@canonical.com>
> ---
> v2:
> - Replace the save/restore of sq_last_status across ice_release_nvm(),
>   which could race with a concurrent AdminQ command, with a new
> optional
>   read_aq_err output parameter.
> - Add missing "Return:" kdoc to ice_read_sr_word().
> ---
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++------
> drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
>  drivers/net/ethernet/intel/ice/ice_nvm.c      | 76 +++++++++++-------
> -
>  drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
>  4 files changed, 56 insertions(+), 70 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 22b7d8e6bd9e..5a1ab9654fb8 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1856,6 +1856,7 @@ static int ice_devlink_nvm_snapshot(struct
> devlink *devlink,  {
>  	struct ice_pf *pf =3D devlink_priv(devlink);
>  	struct device *dev =3D ice_pf_to_dev(pf);
> +	enum libie_aq_err read_aq_err =3D LIBIE_AQ_RC_OK;
>  	struct ice_hw *hw =3D &pf->hw;
>  	bool read_shadow_ram;
>  	u8 *nvm_data, *tmp, i;
> @@ -1891,26 +1892,16 @@ static int ice_devlink_nvm_snapshot(struct
> devlink *devlink,
>  	for (i =3D 0; i < num_blks; i++) {
>  		u32 read_sz =3D min_t(u32, ICE_DEVLINK_READ_BLK_SIZE,
> left);
>=20

...

>  {
>  	u32 inlen =3D *length;
>  	u32 bytes_read =3D 0;
> @@ -92,12 +102,27 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset,
> u32 *length, u8 *data,
>=20
>  		last_cmd =3D !(bytes_read + read_size < inlen);
>=20
> +		status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> +		if (status)
Silent lock failure without any traces in dmesg looks scary!
I'm pretty sure we need at least log an warning or error.
> +			break;
> +

...

>  int
>  ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16
> *module_tlv_len,
>  		       u16 module_type);
> --
> 2.34.1

