Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799E8C531D0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 18:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AC036068A;
	Mon, 27 Jul 2026 18:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xnb_a256LVP6; Mon, 27 Jul 2026 18:04:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A001760717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785175466;
	bh=/tH8d7c8Y9Ogdyd9RUBtmiImbvFKoXBgmdsrlUrZR6g=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Smr6Ntb97HcnVT6NIH2czxgNzYFScxEZ1b/z7OVWL+AQjq9RKk/y57IpOZww9vUMd
	 SsKmO0BhqnisZlz+2H8m6F4kTLETh6lsIVC5IKF9HZIMshpU+fee8xH1cbtulfj5+4
	 X8ykn4Y39bSBQWOT/MQUQDQtz1eEj923PXuY3vlyskBBe4kRC/iXtrdodShEBFUTre
	 PyO6IhPOxjDwTzlPA+QqjmP1hhnnPZMJI0IvtIAQUWCDPaBOMb7ZX7HcXe+gK8AQDI
	 +1bg/zJ6JlftQef718X7gGgdL1EM13IS5/spzhsNaRI6qznk9LSlbGrpzQnp6l4+C+
	 rXHH1BU3QDA7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A001760717;
	Mon, 27 Jul 2026 18:04:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8890D2E5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 18:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6605860717
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 18:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q_0WESPwZ8vX for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 18:04:24 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=samuel.salin@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 623956068A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 623956068A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 623956068A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 18:04:24 +0000 (UTC)
X-CSE-ConnectionGUID: pPEB9HiTSduoVFnbLIgZ0w==
X-CSE-MsgGUID: apNi8/7BQgG0rRtUu345IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85762512"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="85762512"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 11:04:24 -0700
X-CSE-ConnectionGUID: QZn9snQQRVyGmcc3DE+1gA==
X-CSE-MsgGUID: 0mrOhUMGQg6ZEsnmbjFb1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="263788016"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 11:04:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:04:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 11:04:22 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:04:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9raOO96hfhL6M3o9BnX8MgQ3G0yAIhYBBZXGaL6RmjGDXwgXPEbEsJ2cSc+9MkQ2ZVHlvf8Y/krB09Ja0GrXBsTAJHhpivvC50eCmgwmWFoDoSOBEBOZot/fxE3/O4rSuma5Nfk6eo51NbS735xpxS9yYoJbU4iTFE5n09grJPST5+mGQ1SSsCrFPu7Yn+ki4sf0ieuD2cj4FjXp3MBD+qyLXq/fE/Rf7psWvqqY3NiuTFPkBTbSsybJbL/a1fbjZB/W+8jjY04oXeBp11o2kuFh7e5+N5RDtBLhWT/dPorPhd8bdnPnwetuZIpVCP3FXqroLs1v9ria+XxJsfBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tH8d7c8Y9Ogdyd9RUBtmiImbvFKoXBgmdsrlUrZR6g=;
 b=WdGFiUwpOPu+jMthJQ6IV+L/qYQxWb/TOXZNJzn9cPctUirM6vFH2fYv/yKAnek1MdboudPdGSbw0WcozRZoce6pTRSO/6ungrFBzWh83Z1wCp9iAi5gZeiGtQciG7j28dVHSnedq0BTXyw3iPeXCBdXBA/U/KyN1Lr1k5ctKU6vMcwmwot3c13nqkKVkFb2R6543SaK7ul1V54uKV7KkEgcB1d2SyMteNa+I0uIQWKaAaU2MYOWNuK55IDo0DaqWIjSeu83o2YS3mmfswbgUKgCFeo0WbiElxBf7EnOPO+Boe4r6TIxOXR+rBxKLqrlOuZLZoOP44gIdGb45BYmcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SJ1PR11MB6225.namprd11.prod.outlook.com (2603:10b6:a03:45c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 18:04:14 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 18:04:14 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: adjust TxQ ring count
 minimum
Thread-Index: AQHdCOqUr/D6CMuwAUaeMhGDY1SlUbaB0jhw
Date: Mon, 27 Jul 2026 18:04:13 +0000
Message-ID: <SJ1PR11MB62974AEF11ABA313D9D26EB19BCC2@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260630235619.756633-1-joshua.a.hay@intel.com>
In-Reply-To: <20260630235619.756633-1-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SJ1PR11MB6225:EE_
x-ms-office365-filtering-correlation-id: 8a86d182-ae44-478a-d0f8-08deec0977bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: SioQ49R8hWB7pssZZTdQbeoq1VSVav9OKwFDb8eCscBxJdf065SAgLUoXjuTULDNDwumC/2zVWDnz0YfY1QCFj61wZT1WKJwLi66ftn52b+YX/EFYsnRpaU/fM9jDuFBwAvM6MCNJIjeOp1Ggie0NQLM4TsE7S7WPNA4q3MolfcKTJkPi9jM3Qha1SixV7+zlZ0i1GRODAnxKEp5B1UDUxxtG2RmohrjwCOoTXycWi3uzGQyRo453Y/AYWtVnnpV5leE530rBp2a++JwGpVfXfub/Ruq8y2F3m5AKnNtJCIUEFn02ED/WSGkGiHePiziyXYjrBL7I+fen6irkGDdynbPjl9Wx2nDUNj3meS2R4sGbxtiWX3n3V+G4FoX+EuY+LOY5llKvG/KQn12jWqArNtwI4oXG0K9bvH/8X6kS1hlzdME7pgdWJ1KGXxtUId3UihMq0+9uc3ZvgIPSMsKaOvxg0gMOqzdUkdqL/dFprKjz2H+HWwEZaYCuijXpz4i906wELF8yVRgaHx3ASLe6Eu8JnytlmzXtaGfyuA3t6kdYVwW3vBn2veTIbwEc+ZTOYG/X/fHtDwULcbnX2c57vHWmcX5+luFxlPrJjuBjo0vtqDuUU8/i2V5e9elRFB6s7wmsY+PziSTkeHpmfP2/wUQOFmTej7al4C3yBrnPMax5GWlf8FjPiN4J6tAkXFwA7PmPfi6Y+cT8ikX1SCdg2XQK3fDsMhhLJ3Fi0fGpeg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6297.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2OiSPdCgNZMzx6FCc71VOkJHS4vfkC1W9SCT3uFJhIMEn4udLxzMF5T4xirl?=
 =?us-ascii?Q?d6y0FSo3ERxj5TopSCH6OyCRmqrMkRW1CVzJRs8xkBPFWNShZ7NrvXoCbPt2?=
 =?us-ascii?Q?j0IX68VjBpqsdrdwl9RDkYi3Njj0SPk03PVQW4TYH3+KRZOFvmHpxY9p7AHt?=
 =?us-ascii?Q?Sg1SerxhLSZ4gwGv8k7y8Wn3ePSOA2uZ3JfDqyBDEqb9c435R0jea54RBjLz?=
 =?us-ascii?Q?Uin5dZheoH66wO+QEIdRmKt+HBMRI1VLdWnH1zrkOzg+FWRdev0/ZpSQOn27?=
 =?us-ascii?Q?j+I/hq7UszjUP42AIRAEVqxyIhHZ2xDzoE2L/Lw2vaSp1ZtQVzjwMdAeYp5o?=
 =?us-ascii?Q?G361hjubNduAJ3hwPwmylw7t2rQ03ctCrGvkgMyIbwtATfCQr5JgfyKUnEho?=
 =?us-ascii?Q?SLp/WQZsIlubQpgoKxaDynUFI7IkNeJyp2daYfH06F3vYv2JVGg6Zmx6N+XD?=
 =?us-ascii?Q?kXTQLX0+fnTsBc91/8CPOv46/Wj+cLrX+0wXjsqy9szYHqd9Q6ka0nHGMcKE?=
 =?us-ascii?Q?wn6TXD1HtNNj366m80qEzVJXok4+seFBte3A1ZQ3ZhKSvgluycpjx/BUDhUM?=
 =?us-ascii?Q?l83mdCMDeUnTo2KcygdIdf/1Xe15fcquDpGi2F5RfMHqiIf//EscEAKGXmqP?=
 =?us-ascii?Q?JaAm/jBgW5zdfrdaoczHM++4jHeH/zt6a83JSJ9eYLncMrstNfLRashHcmih?=
 =?us-ascii?Q?9O1k7lQM+9/A3tmJv7MICldPsEx8PBxlz0el90Yxs8fvjux4RKfQOgQeccZT?=
 =?us-ascii?Q?NUlbbuC30oy+E4TSmAoKC4NjJ062Z8X/Z3OO/sJw9vUO5h97CL54JNlxy++J?=
 =?us-ascii?Q?DVMuV8kbKSAYRQyXBWokB5k9avtu+/Oo+tHfuMWfPGUnU55MCjheHVCyHz9c?=
 =?us-ascii?Q?Al0+X2Afq6BoVRvmvHgOy1q7TP1a1iQNHwJty19kjcrhWJNIrrHFSfOXSjVV?=
 =?us-ascii?Q?eRrSOH9fbOl5u4+11jUYSK1pa0v5k1MSVca4d3JV6tXODbP+HiZcldJb7aOo?=
 =?us-ascii?Q?auykJUrO95OiXNuqvUMQihnRnN7w6VUiAjVX3Do3gwPe1ULIbbWXMBUvrrdu?=
 =?us-ascii?Q?5KjCgo8W1pz+R/IGhO6HupJN7b7o/YnsH9y/Zm0B2GoR6Fk0T+t7TfexY1OA?=
 =?us-ascii?Q?QwQhUtTO4dT/FvUkxsOad7fjYdejMJHi2JmvnGU9qoI14dS2XNYMYiBJtLJ+?=
 =?us-ascii?Q?xlI13+GTQrfnVpuMBeAZtPCf3vUGQ6eI+HxUKzr8fRJ2J4BsbKaBAXD88iSk?=
 =?us-ascii?Q?I7NZ5rzKNb45TkTrBUanVns3Ohn6Z6p2R4nFT3IzalZXG6YUiedyGwHJx2X+?=
 =?us-ascii?Q?5w94hMnfH5dQXv5q8TW6/m60BgqOWyxlyO1bVC6OaTpchjUbOeDEbZ6ZOeb/?=
 =?us-ascii?Q?ALveV788Y67TuCWlmbN/meBMRsU5CWwfHPV+0dmT16Cic3EZsTHB8OX4ffJg?=
 =?us-ascii?Q?verYIE5uwTtlX+nmJMhLPpogdM7vGQrkrIsgGWw0awhrHd2sdxmTKjCoPvxn?=
 =?us-ascii?Q?cEoiv31qHqDW3BeYcoMak87gjvXEawa+2v3rNEQbJ9H6t/XYum5y73YTyL6e?=
 =?us-ascii?Q?ugInXO7lNi5oqFWHFOAVJNL42I+YWHYXf6LnBGEKvXt//5pIZcDhXnl7xwiu?=
 =?us-ascii?Q?kfOLG8PHN5sPBWqIM3RIgJIdCZ89SlGei0/dpf0rkfVx/LPMzOyhzziA2icd?=
 =?us-ascii?Q?VRXYxqPmX5cWg0fOzpQm4rg1AZu8lXWgjJ1J+4hihOirzX3MREtjUI3HXAaI?=
 =?us-ascii?Q?j1RR7pd43A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MPMuSlKZEh9Qx0CkGIiRmv7ryKahVtUSjXJQ3EhPAe56jVWtI/aPvrgpw8KPtkrRwtxt0m4r2LWw6lJye5gR2Qx+0LnSXDsWlMgetYyZyucjOEipSXt1szNiFdthHrjTNtQyQJRsdwRT/UfIy8cgIMzP3FvuDCxjO7j257l1K0WESO8OqQSIA4CqqmlqYRQQrC+rJs2CaGlCRtDzY1XU4wFGCOXcJJPvokd6hji+gdEw7e0N2ND33sK+QzN0VUJvo8GyuW7/0uC/VmVRlJstxBaN/+aa3uJmfqTYPlWr7NsUuzKX59dQthYBj9dQ0XyF7pMeA5DU9pXc/HRF7S8cxQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a86d182-ae44-478a-d0f8-08deec0977bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 18:04:14.0018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJbo1LRCv4msI0ctXizCNGXEyUsYdnR9cU0MuUJEf6yBKQ3KvtRujfx5kKFb6vl6c0+uzc6pVhVb17hxFIiWIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6225
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785175465; x=1816711465;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/tH8d7c8Y9Ogdyd9RUBtmiImbvFKoXBgmdsrlUrZR6g=;
 b=hOw024EhrWSaUTOGbJBWFBMmi9WoDsZzTCZClS0bKG7+bJJxXeyNnqaY
 xRo2jIZCaY9fVcEPCkNar40TIsBVstJsx3+ouZiCWmfRe5giuDOwmTx0d
 LccYi7afNQvaquDicDz//Hd3DzvcJYNeUukz1BS1A77dZGweoi9l/SgIa
 1oc6LFn61C8VlSN3Li0AgNWINE/uBWpQ1t7rEwZJ2FUOBLLLlGJQkpjpk
 QWzm/f8Kox5xomOg6dEgOVSvcqRjt1M0RI3nnZjnhuUATqhI8N87d/MQE
 jrY7YGV86P/he5OZYZ2nqwniclEcVlxfE1WdsQ3t9j790dgwHeSAbjr0o
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hOw024Eh
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: adjust TxQ ring count
 minimum
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
> Joshua Hay
> Sent: Tuesday, June 30, 2026 4:56 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: adjust TxQ ring count
> minimum
>=20
> Set the TxQ ring count minimum to 128 descriptors. Any lower than this, a=
nd
> the queue will stall and trigger Tx timeouts in flow based scheduling mod=
e.
> This is because next_to_clean might never be updated.
>=20
> In flow based scheduling mode, next_to_clean is only updated after a
> descriptor completion is processed, i.e. after the RE bit is set in the l=
ast
> descriptor of a Tx packet. This will never happen with a ring size of 64 =
and an
> IDPF_TX_SPLITQ_RE_MIN_GAP of 64. No matter what the value of last_re is
> initialized/set to, the calculated gap will be at most 63 and never trigg=
er the RE
> bit.
>=20
> Even a ring size of 96 does not solve this. Because of how infrequent
> next_to_clean is updated and how small the ring is, IDPF_DESC_UNUSED will
> be much smaller on average. This increases the chance the queue will be
> stopped because a multi-descriptor packet, e.g. a large LSO packet, does =
not
> see enough resources on the ring. In this case, the queue will trigger th=
e stop
> logic. The queue permanently stalls because there is no chance for a desc=
riptor
> completion to update next_to_clean since it is dependent on a packet bein=
g
> sent.
>=20
> Fixes: 5f417d551324 ("idpf: replace flow scheduling buffer ring with buff=
er
> pool")
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
 > 2.39.2

Tested-by: Samuel Salin <Samuel.salin@intel.com>
