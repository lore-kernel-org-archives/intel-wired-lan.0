Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E8DC79F99
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 06:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4BDC40510;
	Tue,  8 Sep 2026 06:19:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YNL75mbkg4V4; Tue,  8 Sep 2026 06:19:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1C01C404EB
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788848372;
	b=gOr6QrTuwXRFG5KSsjs3ig7CLm1hOAhBO4FM6AOyRr+2dc2JSuGVv63VeN57RLjO7AnX
	 67WrVls1wxIyp43cg3GKG9bmgNV1K20/5YajhIidUm5MRISQtvUdF4sLvXaoxpZWF3nza
	 5oV2EcHUjTB1DStW/+O6GChNX4vhtIE5yCltw5IUP7m9LqFSkopiYzP+S5hP6GIh+HCiS
	 ph4852BdShU2+uE3a8Q/l7seBiazIMxsItsIA2b+ORviXE67IdE6Cnd7at/TZEmNPdXwl
	 Si2ly2u6HsnUPaE61ZBrwer5oOEmAvOVVMq0A8PAE1dUt3hOZSpKbPB6B2qeAOUTpYg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788848372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
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
	bh=4wbxVrP6p+6n8UA63Qo9HJ10Kl1VZVeHBEs3+fUrLQU=;
	b=dZRnjODAJ5J3qkWeMppbeZTL/Jy4Vb9aD1/F/DwuX3Ejmj2HWpUasUqBWNMiIwM323Ph
	 qPliAvbi8w0Ye/Fb0QD2yJjBXmu45aAQlwVDbwQEkRP9zNLiQx6Gf5J1qoezsITxlivqW
	 9o7IkZA0tMjhMyVhc2DSuZXFamjEaH99iwlYp6emHTOp8wi5TAyhkSYX86H0V0DzjViBV
	 1zQOg4fJn5rqcyjsWJYeNhU+JaVDDD/2f1WPGbTIH10aP609GvOhALHP4lcVDnaepnTgw
	 ivcpkSRusHQi61lOg38uXC2nxV/xn5gIqvMsa6JEHPe8bp3SjyGa8L9MP0d/cXvr+8w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XjLFHRZ+;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788848372;
	bh=4wbxVrP6p+6n8UA63Qo9HJ10Kl1VZVeHBEs3+fUrLQU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AvVmXifCfwMuQ+OqHcjU806KOUNWJwyx5IarvOv0p5SLqthcqz14QdL/3fyt+V1dK
	 /g8O1hbl6FxKX4uedRz6xtXhBAgTeagrSCRR2lCnlmS5aDGVLD4TQ4jYV0UIwFHCoS
	 l+6UeS0ZaUMj5pCX1++u2JuX5B2jiKPRE4hPUodpqNUgr6+okC9kcxeXrsnMV2eaDu
	 5uEF+uq9QbmXi04l4qSk2yO2vDn9B7USt6QDUXc0nC1vlyDpyyxkGCVW9wdEYyaGX4
	 FsumQIyM9TJiJ8J5JLfkikjUViin/lX/nYm+hBmPehIdc+psB01YAu8JW5kLaXw/6y
	 vDbbO01fk0ZFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C01C404EB;
	Tue,  8 Sep 2026 06:19:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DDC37AEB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3871404EB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQZ4dgewhG8A for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 06:19:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E4BB3404C1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788848370;
 b=gss3uWZVyMamXKh1lUMy+42cv0SWQjn8x9RQVVE+R2qgURG4T66KVC4Sf3anh+g7p0aC
 U2NAwuQ3pGMor50Ss89ZM3OnDpehpd3XX3azA74WviLAvwNjVZGGA5rLtg/xhzmakmnOL
 IDiyDiCIwridnmF22yzQ+0To1xKYUgcp0soEh6L/fRxc32HhIP33CICzQtk7LI3aTSJXb
 qUjGG9gxUukP9KtglcABBBhd3F6dAaujYihNeA8NrPUbr2YBAvGlYT1RV0/tgxHlBnein
 NnmiBIaElb0r2SzlDPQSVhukJWU/lcyMnhotaXPzAdYIV8wtJGiDHrkWiywYbjC1Fmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788848370;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=4wbxVrP6p+6n8UA63Qo9HJ10Kl1VZVeHBEs3+fUrLQU=;
 b=EKDA38gs+EDANTsinIuwa9mo8nrnnM0zHYCXvNOny5BSIkpbwY/BXlfR6JkPa94wgK/m
 ti/7ToqAPgNDPaBv5sHbK82AF/grQCiN1M6QzNsc6A5VovQWeHDZSjplCX5SlqL2Ob0Y1
 YOswjyyrgY65RtDfKHAmITx/VtTAchTmC87Soe4wMDL330amzsV8imD2jKlRN9eSsMSxc
 5I7uaHgGBJUHrMRqD4zycNgYAMEVoI6t53tUICCnJHSBp8ilSsu6+wvv/zNJgwQec/rBg
 pjIwrCcVFs9pckRAW34HwikrdE8Cp67QXstIHgLY23us0kq6wTOPPCfgDn/O2UuxZ2A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XjLFHRZ+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=sunithax.d.mekala@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XjLFHRZ+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4BB3404C1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 06:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788848370; x=1820384370;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XdfkOCaQhtIu5xx0f/9AKJfkfWuvLUPV/INoSwPFu0c=;
 b=XjLFHRZ+d5ijYXqSOPznQ1VBtORbRDzmRGpaKo9/k/twhkej7JZ0sZwO
 vBoGs5p+7O/S6tXpsotauiWP+T0ZlzvUDU3b8nmcHMM98umsz0qzxlJz/
 frG+mukoydZTyE+k8lSUoR3P5lM1kD8oVe/3C4t8XUmScaGiw0cssLHlv
 rfin/fCyxjK59migzPppGPuQWpNgvJoCENhalRzX2PkWd5w+cGma8rP/5
 kBELebTiERJvXvDGK1Ruv2pHhsoz466Ag3SUEWJtI0tB5atg0A8DWPtPm
 5jlOfu5XaM5qylukRi0E9XMnNN6ysTuQkOInN06tPsW3EY4st6wcLe+2l w==;
X-CSE-ConnectionGUID: i3uNImp8Qd6mneEjuSF4Ig==
X-CSE-MsgGUID: WmrstW45S9Cx791GZNWzrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89085623"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89085623"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 23:19:28 -0700
X-CSE-ConnectionGUID: 6xcJD7ESTPS1K3XaPDfcZg==
X-CSE-MsgGUID: sOwq42OTR+SMzc5iNcGUng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="294375861"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 23:19:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 23:19:28 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yva5udfq/AY6Jv/jNWlo0C8JMZtVSf9cs7GZjkzjDDaPn3ZGebHPrbhhoczXmN+vCvD3yQb/s4QOnAB/+7/vnp+iDoLtxGynC9f3lADTj9+yWQv8USjmTZmKLgp58fBzlMMOHpNuFPwA01sKb2QaxSrBeSq0H1GJojAnJAgo2aB3KiKLetgJTuCximzo3P5fUkN7O5JzrgAlG8b62fcEJCC+oO6hA6dGS4gmaZ7XZrZIqcuUC2D6771y9NdOhhPi1g3LJgK0Lpxf0rABGHuXWJQgQ71A2CkRgM8clRPa0VLEzzwH504ZHR7oquK1hpOgvJs7O0yg1+OkPVht0iZ54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wbxVrP6p+6n8UA63Qo9HJ10Kl1VZVeHBEs3+fUrLQU=;
 b=mXgJkuwvZqkdEpTYmIrVigvVqppL5ct6HRREOTmCy0MlTM3pAFpebsitfxxvA4R2SW8QjKVk5NRCP/QChseb7m5byeKNFWX71x0lTNZE91N0TIDAtG2V2UyFk0+2I5aVndJiWRFNe9LPHpK4aiScqLuLL1nhNqbI1aQPMvIGCHOPdU3MOuyQpX9zWx3dMhaDtMtsOm6J4ygs1+uxDmMAm4Fx6PO/R5cR4HuJxxNRd/5bSfUbjBEloM5qE4zpeXkKSRT6RlxtVctSQyZaucJVI9mHGOFRcv4MqJ5ngoZQvyQSs86KOC6jsQe2t+7hEKYxPr4jo5sYnLNyNWm9PC1uxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 06:19:25 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 06:19:25 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>, Sashiko AI Review <sashiko-bot@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v5 net 4/7] i40e: avoid deadlock when
 calling unregister_netdev()
Thread-Topic: [Intel-wired-lan] [PATCH v5 net 4/7] i40e: avoid deadlock when
 calling unregister_netdev()
Thread-Index: AQHdCVeXtF2zF5SmS0yI9fpkTn5QkbbEnJQA
Date: Tue, 8 Sep 2026 06:19:24 +0000
Message-ID: <PH0PR11MB7522888A218284D08D37021BA0B12@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
 <20260701124524.13644-5-maciej.fijalkowski@intel.com>
In-Reply-To: <20260701124524.13644-5-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|LV2PR11MB5999:EE_
x-ms-office365-filtering-correlation-id: b3c80202-302b-4bf7-9c2d-08df0d712135
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: hrtsiJYg8HDYRnjuMdx0i4IN3qSJGwRIbryH3N7oDd5ex4vryiSy/4mPZzCPsq0kH2/oq2U5O6OKX80iGXG2RYfTzCiaD/8pn+tt4JB1hMueBNa8iCFEBDZjopgFYfY9B3FANzNs6xGdVnoJdD6DWdr0lfPaBAx7h+UkblUqFh0tMXSwjvCS7qa8kRM18AOfEpWiCQ5Ecxqq62wFtS41S2WQKDQ2WfWtwD10ieBFbHZwvox6olhHEOy+8pnvuqUxSDqfDaBPHvXi1KxKWR+DKCIo6n/D4VMvlZK9EBdLG4tQldriszfreSrGN3q2pOssicwkQOaNpeQDymioIan+NBHZwEQZcOQLGSDhgP2VRyZ+58U+XKX4cLO3dntHCnHgbUVlGlUhTnHM6NqGRvf7th4FYo08eJJ4w2VikVqmki7xk/03NECUPgRn/7c5ykTgKLksf++VFNkUAR36MCzB5YASFiYMvBgnvzOcpwMxLjRkwaJpmaX3dde68XtRWmkv1nZ3vKFWRSYRxmcFF8PNN8FWMsQeaBFAla0v7UzsrbRN0D/LFJ8e2anVhPxSupxyOeJgOVzXYVgYnkG9Aia/rRJnCoW6DTarNUuRxokcL8SEjkC7POSyMJMaUb9nF1PFjgaWWlFbXLf7LdHWGONX+RhLlM2QJA7JosY4VbrHdjGA89UJ+0Kp7oYyL/HuOl3mF9EEWDpFPs1TcWQA1lMVsEirbksuhhuz2YHrenxiWSo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EKJO9Unzi6mLLWZ9Vp+VERsgs/Q6l97TsyjveBoHSLnb0RMYEB2kGn1Hqax2?=
 =?us-ascii?Q?quaUkJMCu/xrYL7j4BRYWA9O231304TJLk9W3HYM8qPjuEBiSa8pHsSuOh0o?=
 =?us-ascii?Q?TcgSXO+RdJdMhMGTEbkqRW+bZfHXKmwFH8a5t8vsQPEXvEAqSErExeA/6lJC?=
 =?us-ascii?Q?MmHdQHqJbFxUxrgVQm/0t4N+72ZUESGlbNuzU8FWTXK1vO7ZqadsG+ge4vW2?=
 =?us-ascii?Q?bCjUMrDGIZ4j7GP9eRzW8+j14dJ87SlYaKsTO+K/KqU9IDGln+jLPWGRr53m?=
 =?us-ascii?Q?bcjBS6OvUDgJ9t+/ViHRhDw1LaGIC7HKD/v+yLqjpH+5ZWnK8FDcST/CvrKG?=
 =?us-ascii?Q?f5b+POX4y9s09rDCVpPCwbY77pEQP5cZvUSCqXOPG4E6ZtghHgPiHu4diecb?=
 =?us-ascii?Q?tiwbQv3JEUjSGRhJW64e5Wu+qQH1368U+oDtdVO7K/DGC/cVqgwR2bYsXA5U?=
 =?us-ascii?Q?P59pd6oPo5ADoJ7EMZ46aN6ze7O34XvXymhr9g48QWY8riMcoNN8Cr19c4ml?=
 =?us-ascii?Q?gEi9J2PpRl/UNARE6JdIRJGU1HfX6iz4msSTlX0SZ8F94ShYg0Qx6YNn9gK7?=
 =?us-ascii?Q?PlbWm2DvlEmtCzMUYMcuC3xytXeZvE+gYt5kNUK/zG9C6JompMvk7nkomoRu?=
 =?us-ascii?Q?hr7ykHhuhi2lKGDg/rjrxLMxeZW4kLbFaUtKRtGS3MrZMdH1+XGjjftPTy2d?=
 =?us-ascii?Q?cRQDqv/xydkovrSEVE76Wf4ToKDeqSRy9pa32yDyIMqyao1m31oXGeBVeFaD?=
 =?us-ascii?Q?eJD6HJrWw7ThPNsWY2b2UgOHTvsaB1FEzUnPsfkI9oFpM8u9bx4LAiGK/uom?=
 =?us-ascii?Q?PXHgMwvdWR2V9nI2zDo1bGfKWGKYrnXJxltCt/seASQXnTjwtGFSBfpZXN0g?=
 =?us-ascii?Q?94JBnqtIWAXioplp8Ph6z9rm8ZdqdyhWvTeev94MxahDGN4CYhwrkCf75MIK?=
 =?us-ascii?Q?XqHFYOpeOTpiwLxwihk/K7SyN5otDulae4O6LZ5pxEnEY8tWTzi343tixp9J?=
 =?us-ascii?Q?BsXH3WlWZPzHLPK/Z+0jVni0Kmpl0sJQewH/yLxAZTbkXlHxD6Swb7ihg1zX?=
 =?us-ascii?Q?WqJ3wGV2DlmdQLZ8b4rvQBN07gTjnaHDUOWAiIg152lbCP9NdvY3SECuzBxQ?=
 =?us-ascii?Q?6Lo0RSCz/brUufiyyBnUScS0prA8WQCwqlrazGKeBMUO4YAk0mW7E2USpYCk?=
 =?us-ascii?Q?uHKDTZrWZptQns+zcxGHRS0zLcOgaT9AP3RDhPKuYdaOJj3Gt6NwnYaoQxzR?=
 =?us-ascii?Q?yPc+w758fh+BWyngTP8xZ/Q2OvH5VT0NuhBK29UI/OVBS1i6y43zu4ahyXWb?=
 =?us-ascii?Q?tLjhI2JSg6Frcb3wa0z4YwdYZ583ZfToRnOXw/JbwxO9kmmtp+TIfP+90AAH?=
 =?us-ascii?Q?VemvhsvS0NnEyRv+a1dbyO9QCVQdf/xQtohsAEeM9rTxlR5Bj+B0RPo/rLYC?=
 =?us-ascii?Q?izpsY4i9ohDZtl+zLjYJXLxZ5lskjoNZt9P6geNoN1tQwAc0ZzekUIRkROLQ?=
 =?us-ascii?Q?lOWkWcJF5NMx+BTAwuoyOWaA6+rvWT5FKLy6yYPeLGO0Ws00soD/A6vyWmET?=
 =?us-ascii?Q?pyl4BtGZFG1MfT7qi5n50EidJTGMPl1p9G2YPG8/Btct3dRxBD8y/BexWpid?=
 =?us-ascii?Q?cGSTuaK0PPYn6TN1bMf2bpKq62N4CoWE93nPoIKFtDN0XSyH/0Ot0P3pDFbf?=
 =?us-ascii?Q?W5C5np24ESzSFljgdrMpodI2hiJaTIqZn5pHTC/7KkvbgX0eDpP9tUrr4BNa?=
 =?us-ascii?Q?tbK/QuP46g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JneVg2CPE4r6u7HWKyFFWJ0soU20ITSg05WeZbVfZf/80SqG9j0OxN06o7w/kADD2SuOsh5fvK60xvhjXYHhpcaiRAD5ITby4fhjXSXEBb51U8PmcUA6xVM456jHa4YX+1EW5HVKUBtn0D/NDBPxy9qIgAZJ4K6Io8ekFjCz7BiOa5oYl/p1UVeAP5Nchf44Uxm0ge1/dzPCxLo8k0SFb0I+4C3q+n3eJVb7pg4bRomdsjyrP5Y53JFGIPVQquu5H9oVgm0eOZSKtb45xlSqROz86aYkeAsSoxPTx942r5gSt2cK88agdYTF+o8JfzQxTovwovDdafsW+NUYcYaO6Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c80202-302b-4bf7-9c2d-08df0d712135
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 06:19:24.9065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYno8Q+grxGTeuxTzjMW4gg5QHD40ohDw4C4c6nhWZohGl2XENnCBX1lNDoaSkTb8jjrzPBjp5K/k+2XTMbzhnEvuLi9hLzrHaUNVEG0228=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
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

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
aciej Fijalkowski
> Sent: Wednesday, July 1, 2026 5:45 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;=
 kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>; Keller, Jacob E >  <jacob.e.keller@intel.co=
m>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Sashiko AI Review <=
sashiko-bot@kernel.org>
> Subject: [Intel-wired-lan] [PATCH v5 net 4/7] i40e: avoid deadlock when c=
alling unregister_netdev()
>
> Sashiko reports:
> ***
> > +err_netdev:
> >  	if (vsi->netdev_registered) {
> >  		vsi->netdev_registered =3D false;
> >  		unregister_netdev(vsi->netdev);
> Could this result in a deadlock when called during a device rebuild?
> Looking at i40e_rebuild(), it explicitly acquires the RTNL lock before
> proceeding:
> drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_rebuild() {
>    ...
>	if (!lock_acquired)
>		rtnl_lock();
>	ret =3D i40e_setup_pf_switch(pf, reinit, true);
>     ...
> }
> If i40e_setup_pf_switch() calls i40e_vsi_reinit_setup() and takes this ne=
w
> err_netdev path, unregister_netdev() will unconditionally attempt to acqu=
ire
> rtnl_lock(), leading to a deadlock on the non-recursive mutex.
> ***
>
> Use unregister_netdevice() when the rebuild path already holds RTNL, and
> keep unregister_netdev() for callers that do not. This avoids both
> recursive RTNL locking and dropping RTNL in the middle of the VSI unwind
> path.
>
> Fixes: bc7d338fbb3f ("i40e: reinit flow for the main VSI")
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
