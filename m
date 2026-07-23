Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC15C531C7
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 09:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0887B80EF8;
	Thu, 23 Jul 2026 09:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vITWz0el2kZr; Thu, 23 Jul 2026 09:19:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35EE480ED9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784798341;
	bh=Tfhedul19UdoLLHPY0jCaxTuGO3DPtL1AMjmf8stYDM=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S1FhX5xxj2HEYvJ1/ET+zF9s2wypssNUs8bB3drJq9/kElaBgmeKY+O/p7rDCsPw8
	 T0lfBKMZbg4LRDvjs/zi474SQKLPF52pzHbY6p1P/hyqalz2pE6C+jOHzASXyNkQoM
	 Er5P3Tsrr8DfAgUaVu4lsmAOig7QuLZOCrFTLV+a9BR2nNyXgcxYsSyg1fp1ZiAPU6
	 6A5sfEOZ/t7sWvl8xBcVQRMlrug8kTc0Qqs9ukcD5bTkcnLeqEZn6/QTyfXWB2n7Uu
	 6OTeWB3avhJfABT0929JRyupndlLdfFQdkxFHEoUdAR6DQllSabBZ5X08BrKnXoHn3
	 VFNQCTXDciPCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35EE480ED9;
	Thu, 23 Jul 2026 09:19:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C611D3B1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B87644081F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5p7qBNJMhf8M for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 09:18:58 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C052A40815
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C052A40815
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C052A40815
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 09:18:58 +0000 (UTC)
X-CSE-ConnectionGUID: Ho3Au91kSWuOWgHfiDVfUw==
X-CSE-MsgGUID: jk0hCok0RYGIabIRz0kupw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96963880"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="96963880"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:18:58 -0700
X-CSE-ConnectionGUID: dDkfv1vFSaakxR0piNVjOw==
X-CSE-MsgGUID: 7fJDGTYXRa2CPomv6NkXnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="263326584"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:18:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:18:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:18:57 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:18:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xj2UBIm6vulieD/zXXndLiIzROsIG3PFSV7ZEprLISHDFZGk3/EnYSNhFVMLfQs2k8ogeDBSAiSeWBuZpqLQ8yEnztUx8EXxjm1RofadS51OSKDFco4mcp1UpD3Dh2hIno9Avgmo3yR+KlcJ34/7WVkVAh9GrpCcrlOOlV88VaT+ffSI/Le759gE2+Xoa/NHsjBAeOox7J3fYqMwyCVKUd4/AxskAhXBUxNj061q03TIgRJjqW5mXXKYfrvrY0YqCIgeQRLyUf3NWVAAmHRcMwKb2mPe+B6MYQQDcUQgycKquuwdK9EPhnchb0NlJmq3IXqyGgapK+WK8PvAIJVMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tfhedul19UdoLLHPY0jCaxTuGO3DPtL1AMjmf8stYDM=;
 b=I1qRSvUWOdkEHekoP6w6v/2Z/UgdoKU8xgKspX4aJ4iCUe+FVXyHKGOj+yGK3Q/VHpg50dQFURcY1V1JsOH+ss+/zF+q/esEkAIeNQpYoFVxnOrRzZGZROnEWQ8UYFIom4GwzpmwXAGhKyq9ClrcWXQhSdxbUqzVaSiFFRACgtI3+ZJJT38q3tE7CYN85VbQqwqB3jirssGrS5hBN9FCMimHQDFdPf62LukiENdomyyAJURQSkri369i6PdZijuaaLo6kiy8jKc8moVrOs3UajC/5plTTcFHxJoVLqMCynb2C505QKesvfUds0bp5lh7gCHUig2gs3wS+wLP4ahklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9633.namprd11.prod.outlook.com (2603:10b6:806:4dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:18:50 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:18:50 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Philipp David <pd-lkml@3b.pm>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Thread-Topic: [Intel-wired-lan] [PATCH] igc: fix netdev not re-attached after
 resume if interface is down
Thread-Index: AQHdFf9cU8EawxtZsEauVsUMZulIsLZ63H4Q
Date: Thu, 23 Jul 2026 09:18:50 +0000
Message-ID: <IA3PR11MB8986D164F76EFE059EF2EA23E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260717092159.35496-2-pd-lkml@3b.pm>
In-Reply-To: <20260717092159.35496-2-pd-lkml@3b.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9633:EE_
x-ms-office365-filtering-correlation-id: 4e2236cb-784c-47ff-b18e-08dee89b68af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: CgIU3NQuW7icQL6RIy39n66w4uIa++YkD1c1VedDr5irUXOK1cbo47k+jUYHAF0khN569kSluiD/8+WnWufbHLeBGAE0UCr87pkcf4QNozQczt0I66IvfXM2GgDEbIden8wGEYlyU7zcdhmJNqkYPxsphH5GBAHNxDil5B6GTu7TE5VTfFFGMAHW4eD4mVaF7YiMu7z/KJkSXkZesHdmofAaT1nPrKpMlKuYCQWxAaHUO9Qc3H4IqYrMzIdWjT3unYDCpBP2rB6sq/WHdLXPWRDWCbckeM204A4ZcBhx/RsuTqZ/uPNIzOOAQiTC+QN34yH64UmQ3jyWWM4xU954L2KJzULbPyGfYt4QOuDOwIO6wz98dfVQIYNiOkRVWYvznwpztsMz0tXpmmEgyffww0NSS06ZfTqcSzjVtPfJ7/E/cyjJC/TGEXDHLo7gprGBQTOeCke3MxbR5fu/2ry2CwrZ4mkGdP1gaBfRvR24hyrg2a8UusPNKY5Tmxfjqqfh6Xh3cZtlLwbuYMAKQG4MUy90VzZwYS41A709rGZbQAIu/SLn63RlSEOaez3Mxu393vlrvlUmesp9OMV593D2iY9GbRX4BthGXVsocYxGUwmYjjjppedLFIk7vh3fu1Snh+3H9TmzO2mDhMZIpWsjlXQehZLVxrquvmnYlgC0WFXd8qEqa0WYI7og8s07ieZ+dAP75jA1xxytPZ22MKXNN/P94RndPTO5hahwT7rX5QA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J/VilK61YEcM9oJeX69wClk6u3qtciNSapkwcft08aCqLOTCkVgbXjDlfQHt?=
 =?us-ascii?Q?qTpmXFWIiMvyBveHEiZxLXrIYoOKrjFmXSIqsRiabBhmyqy/QcinOUfDpPNU?=
 =?us-ascii?Q?n9LdYk0t5wIainpBWm7LWlqV62EPddN3+4cuf6UhOdPHPYte8ThMeFpORsUg?=
 =?us-ascii?Q?bsYu2Si/MxsmyCqDNz8Brjb3bDVCZUkDaM0TuCtPCFMwZYCswYzzH+VQfPM8?=
 =?us-ascii?Q?AoJPelykS5G0k2tvTh+ZP/WYHLRvS6mYYaP8OdaI4hgbjgpFWI5C9saWjZSz?=
 =?us-ascii?Q?hvdVkpTyr6m7tmvCEcofpu1JKbFUSUPAb0+WZFlR18bZ9FbTBXV6jfGOmOHL?=
 =?us-ascii?Q?UzMp8U+AKo1iiOFNVTKUg9uosLgdXv9qkYrB9a0M0uWYJsC6WMVwLZhZ2xd1?=
 =?us-ascii?Q?dvs1B6zMQ1Zykvwy4Ltg5CIuv/LhXwxUCD7/AKflpTt6BqLMDmZB68YUelJN?=
 =?us-ascii?Q?KjmxVtGNglA851VxxwGv/Cy3iy/BKmL74mHviAN4ksdVwBU7F76GvqGVLGqE?=
 =?us-ascii?Q?5U8Ofj0iZLrFZfyNOtk9AN9gv4g35loisyVA0MaOj9TiQCfZQ9vEW07ySbeE?=
 =?us-ascii?Q?rhBo/rzQ/ftIMa4WZQN2dgrzLl1reHVPdYZ/RHWQFXu+aDrEbiZrBT7MjSi8?=
 =?us-ascii?Q?DPTyUGru3uITqmpcGGmvM4LgDUlQSvvxEphtYtm3AgDhuF2443XKbzIW/Fgg?=
 =?us-ascii?Q?XuQ5rviW0+edeY2Bn09sxqFjQOE1aMtmW6mxx1GjoIRJJbRz8EcSF8F32ri2?=
 =?us-ascii?Q?cthKSnseUMu6bMfojV7KtedVDM4Ig2fWu6JPq50bKtuMKPrQdCmUyzgORiN8?=
 =?us-ascii?Q?xrRqp2GWaqYx53NcV+pOUxhOfOps5Y7gJkeDq01W/I6EKt5UrPsJcOND5Y1B?=
 =?us-ascii?Q?vWsklukEiNV/TuFcNnAhavzzED33cnCplzlchckbBpP3RxYRx/SRmqlvGq5/?=
 =?us-ascii?Q?K6QleRD9eIIH8ZrbLSJ+0QQJTUWLL4TdoHDvkzxDD4u7E2JIpWfuo/82hU2w?=
 =?us-ascii?Q?6sZ/42dXmU3+2+R5+2qIGHMbrDgXEsQbLEykLW33wNN2rz1dLeoFXYgc+Kvr?=
 =?us-ascii?Q?Jdr4J6ZZifa1KNUHv4njlbHlzwYQpugsHm5NjvU86Gu5mztYlYOWsU01Vo3h?=
 =?us-ascii?Q?/miBygek0p7LrvdZJZ7ImUz7UT5TBQczPulyWUzyTAztNUcDjKNqm4co0yG3?=
 =?us-ascii?Q?nQjpNWshDtm2wGub7DqfCggvmOd2T6tx9WjP4t4qucKKLNb3KN40m1s3RJxG?=
 =?us-ascii?Q?+ScCJBS+CzjcccoV4LD5QHXzu0ZLDMTXIwu5Uk91SB+AcHe9zWJDJylUH7wu?=
 =?us-ascii?Q?fTq8OufFLZ0LahdjQMfgMfaDRWmWI0vlYwEY6377gSBzbNHkmj20he+TgXTE?=
 =?us-ascii?Q?T5yrTxunxWGMUtwAmNIczNFObC5qWWri8lwxvLL1t8JG+tlR1ODsZZ2j7rst?=
 =?us-ascii?Q?H4mY+WqukbkCGn94to9TIfxxYnaieeBjnGimIvx2WimY9E9cn/8VEimgavsi?=
 =?us-ascii?Q?KhmuMWX+c7BrOee4uqpIxXtnMWXxL3yRXAabKcJBt4og0asOZgSHTpLfU9jF?=
 =?us-ascii?Q?qMhAdzjaiNBwyzcuL11QJ3JpCOauKAEiBnBxnWQYw6CWdDydXBJPltl3bCTV?=
 =?us-ascii?Q?KDbram++LSManPNGhJx0up443aItJT20PAVpOzAB3x6cvuJlyoJxWN+M/ebG?=
 =?us-ascii?Q?DL4W4YUKTwoDjuMbwQKo79OVcXE8h0K8VxO/sTkEfPaXuvn0dlhwEo+jHfgR?=
 =?us-ascii?Q?uvn1WmUjV/1c99JXF9yKKDc/EaF9HQI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m7N4kh9GFvokONLOgSO0Pinq1qxhScbI9rEBI9kFpo+0vHAsdMNCKgCrbA3lfKkLTuCs9aSM6aYR8MUCdVr/z/8Hax6l/NU6K3kge5Xd9Yi9TBuDEck4dgziNcX28v41lp1k3uxwMdYf9bOwdZyFEFgFsy9GMBb+Z+FXIC+a5xN7n5iVNMdk+6e833xXZI2OSnesbwHOIium+xBronjd8U2juGOoL18MQfrxpfhlv30YSlf35aKXoEbz3tKjRXxhBqo5j1WYu6IH8/HPlMT9hZO/ybLXfDFx0gTAgRRSyJQD0Sn1pJzViU79fN/UFMuyEWeAB/Q8CT8YM2YO5lFdTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2236cb-784c-47ff-b18e-08dee89b68af
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:18:50.6578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXtxy7SD1QXZ9nmtrNcCWcPNAd3zIUl0d8v47YYUDv8Xuwl/oyHXMnjm8T04m/xOYJpTH4ondxvmb8GAExjp1vDdpGSiNJkd4HS0scGNo5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9633
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784798339; x=1816334339;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PMnamTQgDQa12PMv75u9npfAo3+qnke2lmCl5UD94DA=;
 b=WSbNs7lY4kiRKPUnQts9VpASEBkdX/0FRwVLIRjRz432FMteWPjPs0A6
 +HxTWU83ID1uwnHca6Za9lsP41wG5X9Wg+b6T7Abt5okgBy/ua5wMyzXV
 mA9K4xnM18hcnA5Uo3/YslGJxgMspO2MC0wnptsdOffNjqWD7xqlj6DaN
 Ra49k+GueqSkRtHsCoPFvL6mm4DWCLJOF89WWOYuPieSQnVt3EXYgbwV6
 n8mqwtHl9C8bAiX0YzEoZ1A3viOPwfPHJpyXClqXgGTyxYK41G6Z/9ucY
 N7B/j6u/Do6Pj+CBgefFkIz4JbUQ62B2QmDvLBfWCk6cHnFf7iEBxav11
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WSbNs7lY
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix netdev not re-attached after
 resume if interface is down
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
> Of Philipp David via Intel-wired-lan
> Sent: Friday, July 17, 2026 11:22 AM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Philipp David <pd-lkml@3b.pm>;
> stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] igc: fix netdev not re-attached
> after resume if interface is down
>=20
> __igc_resume() calls netif_device_attach() only inside the
> netif_running() branch, so an interface that was down during suspend
> is never re-attached on resume. It then stays in the not-present state
> that __igc_shutdown() set via netif_device_detach(): ethtool reports
> ENODEV and every attempt to bring the interface up fails the
> netif_device_present() check in __dev_open() with -ENODEV, silently,
> since __igc_resume() returns 0. Only reloading the driver recovers the
> device.
>=20
> This is easy to hit in practice because NetworkManager brings managed
> interfaces down before sleep unless Wake-on-LAN is configured, making
> the adapter unusable after every suspend/resume cycle with WoL
> disabled.
>=20
> Re-attach the netdev on every successful resume, as igb and e1000e do.
>=20
> Fixes: 6f31d6b643a3 ("igc: Refactor runtime power management flow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Philipp David <pd-lkml@3b.pm>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 2c9e2dfd8499..e777c2df0b73 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7586,11 +7586,13 @@ static int __igc_resume(struct device *dev,
> bool rpm)
>  		err =3D __igc_open(netdev, true);
>  		if (!rpm)
>  			rtnl_unlock();
> -		if (!err)
> -			netif_device_attach(netdev);
> +		if (err)
> +			return err;
>  	}
>=20
> -	return err;
> +	netif_device_attach(netdev);
> +
> +	return 0;
>  }
>=20
>  static int igc_resume(struct device *dev)
> --
> 2.54.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
