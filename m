Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94765606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qP8o40Tv;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LZsNUm9N;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Opb5vIDz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BDA58108A;
	Wed, 18 Nov 2026 18:56:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2CIKv_NyXbu9; Wed, 18 Nov 2026 18:56:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9071B81117
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795028197;
	b=QMV1uWBmDuMZvUq3joh8jGAKPfxwcPEno2bGu2TB7U6YuOBFgjvbWl49exes6R1tZrcb
	 76OShq3o4SN8zt0PtoPvWyK+xUa4E50D6ol4a9V1gkGMgkUwNJJvVDvD/W1j7xN4Wq2hW
	 Akw85/nWPEsw9ETBCLtRWFV6WJal4yz3Q6GdAp2A0jYtlEaZDYEorDImSa1ITVk5edHRo
	 iqLv+26gXtIEuc4CJvgw3U0eYQTMt5BauyZeOullaunLmNfx2lQuIM2DzhZKXhTL3qljI
	 dHsRQxAfLJyXz4Q4o5HgtUSXKuiqNTZJn+Hq7ORq1x1tDk+h1NJuKWTEQeQsiEYG0RQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795028197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:DKIM-Signature:
	 Received:Received:From:To:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z3JcB8+CGmxCzEYZcTCBoyu8O3ZIDG2AMYNb/jZKJIA=;
	b=rWzII2d3guvhZvFeKztt8UIjO9tCRHSkORgtRJ7xjeTIr6EhK+/epJvHIw7cRtFGioGU
	 v0os88REOdzpKy8F8bmvXNoB1xvkQjmcKncOmz/7xK8Ybc2JaMgaHFFrZIRhc1p/6dqYi
	 dvIpX9ZBZix6VOuOGN3my6XtFaUg/TBSjMzQB6D19nITVVGlctAGVxdddBRqR4ckzIH+3
	 x0xIVmZiytnriyVyUfPm5PsQm/EHMxWIyIWulO1Kjr1U+OYRT3TWEfIHheUZoXaQVbgVi
	 7/HwcoR91DjDsMnwnqq/DiWHhcunhUKSl6naodbjGPCYUlYvOnyF4vfBY4LZ1NrsEgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795028197;
	bh=Z3JcB8+CGmxCzEYZcTCBoyu8O3ZIDG2AMYNb/jZKJIA=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qP8o40TvtvlJ+nkQhM/Ltau0NlK0OBIvwqk7B7vQNwEmpY7wqevTeBF6WchJ4dB3J
	 IVchB+wcf6r7/IwvpFxrO4Z9WisNR5wqpSDmC+8Se4lA3kjEGehBOnGlmYU5eDcl5q
	 qzc/q9KskkgsAu4vtqc0dZ8Fu42Ug0eA73XRi4nsydCTXpZ1jPEEjEoE/mKQ4JoNtF
	 SyS3cLgJiuBAQ+fHgjFppuR9vvAF/GUcCjPlwwxpi7EDXrd8VX1//siJESdW98sFw3
	 FS4OKN3mDXVFC9Iw0kjTtyluaxYcaPvYq04ZXJpQQL8Z9r2nXXjx1ze7wXPv8fER24
	 iUXtsvibgu5jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9071B81117;
	Wed, 18 Nov 2026 18:56:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 49FE913C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 18:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B46C400A8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 18:56:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N1I56pE6RjAq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 18:56:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 409AF40095
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LZsNUm9N; 
 dkim=pass (1024-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=selector1 header.b=Opb5vIDz
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 409AF40095
 for <intel-wired-lan@osuosl.org>; Wed, 18 Nov 2026 18:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795028196; x=1826564196;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=FHbmfRj3ohZQ6xCLxT9dGgdI0rTK5ZQRBLP7YeorXrs=;
 b=LZsNUm9NL39Di1t6ch/6yf2YF845IaqtfmjUMMegP06lL0WWpUYgJjM2
 e1wnZxvxpCep3JSIZG0himBf3Xxudx3a5CqIXRLJ36vchBwQbtWfVv44T
 FGjZVmQvwPuIMnrFnirNyIUX/iZJhs50kXOKNp353FE9ggfhzCeNprH52
 wHl4imxtpf0clFGi0sk2YHmoYTEnAGR6bBuAn78RC87hJySxOczZF/haz
 0oDgqUhO4om4WyXrKmLUOaB2b06IHbMn9oOMqC+Rs/00b2MuH3nOvsvID
 mw89Owz2p7PZQ3RhDld83D2tNODMZGqqQqY4urlnQIdt4ngyrjtT20XVz A==;
X-CSE-ConnectionGUID: 0v8hH83wTzSNMypYHRC2kQ==
X-CSE-MsgGUID: hA8UmgaTTu67jQwLIbATJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3751269"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3751269"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:56:34 -0800
X-CSE-ConnectionGUID: Ioq+n9W/TRikojD8GR1WUw==
X-CSE-MsgGUID: 3lrGjvaLQk65MUPV2UgHTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10460533"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 10:56:33 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:56:32 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 10:56:32 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:56:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3JcB8+CGmxCzEYZcTCBoyu8O3ZIDG2AMYNb/jZKJIA=;
 b=Opb5vIDzYJZKPg4WrYEOZPg4y6vrP3WZ9Ubc+weTH07WWD0V5gKRTidxocpvjczbjeacZvf1HaJnnGlGCIykjJz7Kda+BRxbjVD8SVptshu2h7xYMqpnidxzFn/L4RB2vSZq7q6+mx2WBJ6i9xWiX40JGv9fTHv6WAj+95sVc+s=
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by CH3PR11MB015790.namprd11.prod.outlook.com (2603:10b6:610:349::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:56:28 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:56:27 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
 "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>
Subject: RE: [PATCH RESEND iwl-net v6 3/7] ice: Reject PTP access without a
 control PF
Thread-Topic: [PATCH RESEND iwl-net v6 3/7] ice: Reject PTP access without a
 control PF
Thread-Index: AQHdWvMQlHNfVDyvG0CbA/5Brt5iy7c0Zvwg
Date: Wed, 18 Nov 2026 18:56:27 +0000
Message-ID: <LV1PR11MB8790192317F93487BC036091907A2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
 <20261013091235.1423979-4-sergey.temerkhanov@intel.com>
In-Reply-To: <20261013091235.1423979-4-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|CH3PR11MB015790:EE_
x-ms-office365-filtering-correlation-id: e5abf3e7-7d7c-4d30-9e34-08df45a5a6c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|10067099003;
x-microsoft-antispam-message-info: Oikn8Q8k1ZowpFw6xpOJkk6bfRGKoUnwIViTj2qaLV3OkO1WfOqeWkllZBnU3kAsnPJUwGuZbi3g6gYlo3Efv4Qd+PudPkg1GZX6mADhGN2EBH928qheFAvgPsfdjiLMhzmF8BNtBn6caazwUZGa4VCVmgpw+sA3ORAT/Rkir5K/s8kze6lSH03bFa6hjT/5q4v5xzN7Mpn/90Ve7Zg1f88bqiJ5K7aVHosZh5SeRjMWk5pbMsY9ebaj3glVqnEZbU5/wwbXz/SkKeaPWzNPKvhOQrpqIAAOuGh9tuIVHK+JEqkRW7G+DBXBuOXnjNR/avKLEjfkoZ52+zmo67z6o+tj773sr4uWhXqLBDDuQc/hD/PkHStMM0QPGeyPFqYGmkGriEXfTgtTOaheriHV28aBGfmEVHzaA4SJXmrWs0PvAUZaY4fRW7Sx0/Dib3+KXN9p39Od4sGwDK261w/a7KK8eZ9FKtzC8SKG+PXWvWxsn/ITIdNkURjrLFSYb25RJt5jENtmNgCCyAM6AChfjlALLuDwM6s2r74QY4F1P3h1vsvudQS1Ae9YVA5Ubg5AF2yJEn2BBHyYc2/2lvetgyI3LBFwmXdD7Pf0napDTJbIBhUHqep04DZUCOam+1ABWbEDgRH1dn7+Vy7k07PpV4j71xFfXwL0j0LTAW5/gZi+3BgEqCUy7z7VAA8wyAiw0+GmVbJjCSNwDc27rI40rjNVq5d9+f3Qjh3pXiHYtZs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FQf7LbuLmNn5X6huAYChYiie0zC7KsTz0tX5eLwVE/EEdpKeYfWbMvgL9/Z0?=
 =?us-ascii?Q?4BeImGfQy3o955Kkr7b2sxHYjs/W4E6N4JKKFUlPGakhPdlQROo1kJp4zYEm?=
 =?us-ascii?Q?pyTklMa3O9UiZRT3dNlJ4/4EqHrVvj8Th41H02HlHxFMR/dPhHdYuTWSkKuA?=
 =?us-ascii?Q?fbv8QzV38ZRM79O5VWxhh5khzfw7TTVSnytemOV9fIOWmVN8NdPKznJVVlI9?=
 =?us-ascii?Q?SFVYq6plm9cK4P0QdgoGO4sQXlFhPGnpMwoAHb61YJD8GwjrtfcNIpabAzp2?=
 =?us-ascii?Q?zTzYkxnICQ4XMNeF2R77SsNChPN8lhtROkm56iGSbTFZkjgkq04cb9OjVLJB?=
 =?us-ascii?Q?ufw/i55BSmoOF0q9mOSvZ7WxcsnRpxgsFAjyr2/LGUZR7X27LaFmbZG2trke?=
 =?us-ascii?Q?dQjgKgPwyf7gyDqHqgfAUImiDzmc3E1bJyN9Ui0qFQ1uaGcAOaX6ak2vdxNQ?=
 =?us-ascii?Q?vvghrBUJGmoPrbYo+SgzPXTesHW2Mq6jm1CuZ66gxCpuEt91pm+amE9MhkC9?=
 =?us-ascii?Q?R621PPX1izK1K7crdCBre3KitguHnOrrqJKG1Y1o9eKqFV9zgD1IX12NV8mb?=
 =?us-ascii?Q?AROJ8RXLuEOMN+HuwN1M9FDlfzv9ftsvV1fBlIR7KJblHDSYpw1lGfT4vh3q?=
 =?us-ascii?Q?Sfr1zz6lF6Srr9Rrc9NqJ2V7X8gafNttIBUKtvz/MqT+t5qccwIFPoh2pWEd?=
 =?us-ascii?Q?eQjTXLL/K0Kpy13kgpRm47+WwTH10iRfU5Pume6khuS5xyVaueUF/inXBD2k?=
 =?us-ascii?Q?AzJVE5qgI0VJ2Nl43/fc4Ij1BQSjsY2VzHiBtGSGxRVakHJXtplYwb0rbJep?=
 =?us-ascii?Q?fCp2BT8a5T57kM+7OAqq/DW4kA7s+vlaYMTMeKnTxCv8/cd43Kd0FMlFX65/?=
 =?us-ascii?Q?YJFlWe2hEppUW0/pbZOIza11V4/iKoLlLYvk8aBPQkt1yq/lYuBTHGHuX0LH?=
 =?us-ascii?Q?Bu+i+ncUHshLexiwu5rb1EiWIsLJ+gdXMzgKxTZipR2ASWLrqoWn1kwJ7gJt?=
 =?us-ascii?Q?qIPJd3vHxbKaM6ylJ1bbvGbNDaAdApJ1DjqFCHgjg2TGwgBMvGvZ78UI1Cfa?=
 =?us-ascii?Q?zCyTm4nm/RF8Sk0J0AOFbmRXcM/qSkkFWMV5meyiFbHkATTwRhqGuNDhTyR4?=
 =?us-ascii?Q?7WHrQzWjD5lfW8hpqDkSA4HbOCP1eG2t3spJhrCOSBPpFD6+Goo8AIjRqiKz?=
 =?us-ascii?Q?jyAlzBLe2xwg9M/kkKT7kfSnyeIjkQYY6hZbJJ8haJx/LL7HQiUaYNwkQfPI?=
 =?us-ascii?Q?rMdKrR4jYaSYS9bXsH095B3kMwd493QCDX0lRls7oS2bFAvqDVlsk24k4466?=
 =?us-ascii?Q?cLHFFAT102xYM7r/E6s1lHW/I4G27czuEFtWlYw3KuH3s/M1+sJXTWtAW+Tk?=
 =?us-ascii?Q?Okm+HYV8gKqgJRQ1pRjNSFBgp/t0eQqLOkGr75fE8IXhmSLvJpRFp0S3dQsW?=
 =?us-ascii?Q?IfC4qOjpSpNWbdyCpuFiwIIXJfAbSSRaLLgUIrWj6zo4uj/FZlwbVBkl0H0W?=
 =?us-ascii?Q?Zs64nhagHw1YmWkbeZy04ntTpRGKcxihIXfrSF3kBClIcmUr7pajN0PRU7gm?=
 =?us-ascii?Q?KvRe3KjdmDiKuMf6heIcttrFmgXoWEEmd2+3ypo9ywr5u4G2kmG4NUgYkN9r?=
 =?us-ascii?Q?/ptl/pMO8heSIVdvSmyZdrmpF4JAg5t8dEdJ78dwgcbrV4U9F9DwlzCYlKii?=
 =?us-ascii?Q?pxF/Tw/FZn6mKahpCOLBkMPa+oNtWQqn/YzSsY/3SmWg1+YJXPseMfLQH3J6?=
 =?us-ascii?Q?sHyTNIu4fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tkP8PujIvkoJf3H5CCm89rzKfENIw42o/p21E09iXlJpKX3xP+d0XHN0mi+Wk2jNYvaeMnFf55kKbhv06iVo9a8nNC5T7B445MO08kmmTeQHYYJZUq43aJ/yD1ZNhe2sHN3Zqi7b6vFgfy1YjkmqPxizHX/Q+DXWsVppdMDOkeIX5sfKy2u/BEboJOVyykNA6MxhQ1ySqE7PX+N+D5hZEq9owCUi9rQVZ5DeRJ3JaAaFKSPfTSxgcu9DcAzEWDIOBHR23YohFV6p05fC8coJFn0PW9hZ9XAycB2OBt4MsdgdqPgCPJmSAKEzi9X2yPfBf/9HCdrzfoRBR8WZz5B6lw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5abf3e7-7d7c-4d30-9e34-08df45a5a6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 18:56:27.9345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2eSPlyvdm7sP8RpCXGm0QrUb9eqTIOJPpHR6s9jPJPWcoAZtLawelXwMJ3pmBvoLC3+eIc8tYT3L000lWh88wDpHatBm9+Qi3tkCuyTKco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB015790
X-OriginatorOrg: intel.com
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Tuesday, October 13, 2026 2:13 AM
> To: intel-wired-lan@osuosl.org
> Subject: [PATCH RESEND iwl-net v6 3/7] ice: Reject PTP access without a c=
ontrol PF
>=20
> The timesync register space is not accessible through a secondary NAC.
> ice_get_primary_hw() currently falls back to the caller's hardware when t=
he control PF is absent, causing secondary PFs to access the wrong register=
 space after the control PF is removed.
>=20
> Return NULL instead and propagate the missing control PF through PHC read=
s and timer setup paths. This leaves secondary PFs operational while PTP re=
quests fail safely until a control PF is available again.
>=20
> A failed PHC read invalidates the cached PHC time by publishing zero.
> ice_ptp_get_rx_hwts() already treats a zero cache as "no timestamp"; teac=
h ice_ptp_extend_40b_ts() to > do the same so that Tx timestamps are discar=
ded rather than extended against a value that no longer tracks the clock.
>=20
> Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 device=
s")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  9 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c      | 85 ++++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_ptp.h      | 11 +--
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 24 +++++-
>  .../net/ethernet/intel/ice/virt/virtchnl.c    |  5 +-
>  5 files changed, 98 insertions(+), 36 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
