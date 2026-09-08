Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C961BC79F82
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 13:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F0B240587;
	Tue,  8 Sep 2026 13:15:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LluGixPIXXiy; Tue,  8 Sep 2026 13:15:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D55604057B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788873321;
	b=O6kx95GaQC7CgBjDaEpsU/cmVq8mUNcsldHsxuZz3RR9Sv23D7GRjruiG4+RurOd0s2v
	 O+NHkemdB6mLDf2LtYUhabJUfviV3GmnvjRNHRrhoexCkdM69cb0dNsyfcSf2XHN3D04n
	 VVGYhO67pC96UFxOGa2uvos0efKplYcjKgnBYSfyiYvrA5jUGiUOcpsZLnXKIED3KtbHz
	 TRDw31bhHzXxeNOYiVfoF4v6He/7JgjZmDbzW+MausqHQOewH5FxvmO9lcEgdp9Bly32b
	 Z66OGKfXEgYY+pILLceRGkKvOgLOtoNl6LeKhyIr+vbxaArKcZYk81C+1jM5gIQrNUw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788873321;
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
	bh=GYTRWxnIW5JcWHUnQ6hW3jot4a1EkxsGYyZX3M3yBFs=;
	b=NmFmp/83rJnsTM5JGxbSVQG0lmU9mb6/MfFrtKb0Wd3Duwqcj5g5Nz84c8Yr4S2XxHGf
	 tIEiy1qcMYYZPmmcRC7ObTxsCXniJRvdGd/BQuS3D2nsZmtM9+0KAf3lVqCo+Mvb6qHZN
	 XIwGHdH5r8e3nrMA1PMiDtafqRusD1oXTs9WsSPOB8wUFPnRYE+1OaHSvOj4+pzv1kPXM
	 5GnpQhl++c+BBZIDGYqls5xU5uabYNYjupLNduz+HqWuaz5CqUfqZPDowkKWBuBUmhwiW
	 2cXbFqLBo1fodzuSkv9Qm/igvtIO7irV5hjtNZ66XAuy2DVd5QyqhGZDbjbW4Dq6juA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788873321;
	bh=GYTRWxnIW5JcWHUnQ6hW3jot4a1EkxsGYyZX3M3yBFs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ws+39edfwdI5Wfo+6U05IRaWjL4A+9MZQMQfxVwzs2pdb99coIZ9coknRN+boU8+3
	 MZ1NVn0OeMmA7TBcVOHb41mgilK2AH7dfI5UC4hudW82S+IfQ6C6B0M06rn//ukGZx
	 uz1bu73i8xty0nVg4ShjoC45zPR7MXK3U0flAiraEx9aNKBR+ilUJUSDbAhKnuFtVq
	 330D36sECrKirZSzrq58Rw7Pa4EWJuvt5b7qpc86XvveMDB1i4hw2CKZ2lCFUodBNY
	 2IulzXxsossHyXWfq5EKo3VVRdKLdEzUH1kjsCafQMvKzyNo4p1GblSg3YVVVsuVH1
	 POw6Um2GPp3iA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D55604057B;
	Tue,  8 Sep 2026 13:15:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BA4ED5F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21FCB40160
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:15:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f9IIzlt_kD9S for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 13:15:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1CB24400CD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788873319;
 b=YIS76KZcL6Pk/5445ImU3uWbEKtOSrWdVsmbqwGAhIRBdaC6dHKrTKZ3P6itivk6hRUj
 WnvotYGNPJkenQ0c5NPTiMP+coJO+AGLf621u1J6UNqp4hFVA7x19Bv26YcTXRneyNJzJ
 JK+/7gV8PoP9ViMHhRO1H9FB2f+joj6eBUkJmG4ruGKuh2Or94xTmtxTCKorEKETa2bHH
 MkzwYaoF3sEWMV4Hoicp+x1NRh/1b2dzhMEmDsur6EqjbQvE5ysrF8jPYVcU+bK1NOYOn
 P8yICgb51kNB2D/HIi0n/hRxJTC/81WZRGOjX0LGAbg/aGKBN79Sli8XGgL6sGIykAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788873319;
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
 bh=GYTRWxnIW5JcWHUnQ6hW3jot4a1EkxsGYyZX3M3yBFs=;
 b=kN/r9oVFyrWY4OxbyT8M5j75WTgOtqKP20yjmclY8qlQp46VYY6YoIMWBRqogx8i1Jz2
 /O1ErRiFgoCzdMrtqlsA4fMYWQcLUssJfbFC8hSXZpoMut+atG01AltG9B5mBeDEG4fq+
 SMfKJqC457mDXIamL+C+Pj5nfe4r+L+v8P0jGGQ22V7+2QG3velA0sRnN9hceaucD45xk
 UmG7Dp8nlVP8TYyB4RviUEuW+MYvE3wcKjRZ3QU8PiXP/N3Qgg4lVSZBH/BflV5S6IEMd
 /6xfrttliIOfkyfYSIZMMwcSbLfh/Yc8s0C3c1frzU5ruilhIfvES4AoazizueG+hlg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=STSdthOH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=STSdthOH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1CB24400CD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788873319; x=1820409319;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2OFUELpMiYqpFK99C52QhcEegQ66rGPPnyA7wa3kc0M=;
 b=STSdthOHWYEv88spm0rX3q1MOT60qZYghM7cSVS2oiNQ24vw2NcziciE
 Yu0eTZFqj78sRmG8wtIdxAMjleUVqwKS3V5RAOTtROFv0t+PyTWWZD4D5
 qlfitiPRF+0EvKZo4R+xbaEL1bxIwsTXwP9RmUnYOnnR6nzi+BRksAy0/
 hUq3bymGqcKmpV2fnx8BtGhpv3NdKQOYEtLbPCNwGLIHWxsjvVOksa+GB
 Da/HPzVUPfbsWS11Ll5coQfZgJNEIDXTZuts1HOVpFOKDSh5mVSIvXt3s
 tjeNesUcN9la66M7kgpVOHXw2Phiniz66oz/bh0TE9vJyi5AjpOFM7ExW g==;
X-CSE-ConnectionGUID: SN7OFwPBQiuopCBmJ+lSLg==
X-CSE-MsgGUID: Ec3LGcrpSzOt4URTUFzFGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="93094734"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="93094734"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:15:18 -0700
X-CSE-ConnectionGUID: W8viSTOYSb+eN8GWJlRcZQ==
X-CSE-MsgGUID: ZVmp0mzhQAuqG8MYnB+3lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="270510507"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:15:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:15:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:15:17 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:15:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzuAbKguAl5cNEwkJJh+vV5w+/0gYgynDtLX6Wm8OaUVNulpbsbhyDAs4o6u91eZOn46pnq3iHucdVTU+cPm7389G9lhFA3NBJO/ECn8xLmGgmQLZYicx9uuvacyDtQJabUoB9azVTLp6341HjajAuukhUPkq0qdFOKM/s5iXAVqoRBdHhKwwNKt9FmVnwTcSQaQ8mEgpkPuSpUuNHPexBZFG3N+MMLLzw9HM8uEe+QajFnXSwEq3FCdLfZQ+zjJ1H5wkIb50r88ZQ9yew35q/fNU1yh/bLkNQWBSL3qC72nVjopki1gSJ1myRiBEBWC1annaYX4XkCrDZnVKYYfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYTRWxnIW5JcWHUnQ6hW3jot4a1EkxsGYyZX3M3yBFs=;
 b=fM+qSqPJhx3Tbv9rt6yNuQBDdWEBeRKbDShMnxSLKCkcYLMViQaDfxaPP65NzPVUUH2rJN0khBWM338fXGiWzhsdz+uLzhHQfZKA//iizsKA/cjWVNjsiNWCnKh8WotlkH3WvUinWArVNGtJlc4azS201h8fONWwJZF29qFvypsV9CjHTKuYnL8T/I/mrwpXNsSbT2KKdFtqsdHDN9UG157Eyqf7KaEszpwmO9mTsdbwsTzIqZiYr966Yszxqzdjzlv6JVyBQVe8Xd+UQ8OECZY+GpME52ulPtzfHxiPXzFbRK0CQaI2U/ozKu8CjTXcnt3VhxMb4p0DplZYto0Eag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA4PR11MB9297.namprd11.prod.outlook.com (2603:10b6:208:56f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:15:15 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:15:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Richard Patel <ripatel@wii.dev>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew@lunn.ch>, Steve Douthit
 <stephend@silicom-usa.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
Thread-Topic: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
Thread-Index: AQHdPagzXf4PJZE+0EqfcaUY7S5n57bErM9Q
Date: Tue, 8 Sep 2026 13:15:14 +0000
Message-ID: <IA3PR11MB8986DD5E9AC23B822E9562B7E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260906023319.1978945-1-ripatel@wii.dev>
In-Reply-To: <20260906023319.1978945-1-ripatel@wii.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA4PR11MB9297:EE_
x-ms-office365-filtering-correlation-id: a0a6f66f-1522-4e87-83b8-08df0dab3880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 7lCZ+0iSK66luzwuYC9URkktHQAMTma723LUl7X9ZSjiPokeitTVOt3eQKmcooOOrzOgDIZAyX418pdndIni29yrdLxp0sjnCslEP3dKTgUaQsc89qwSPsm/NKZIvlhCwe2jYGlGZXHV7cNe7ChYaVa14bi12b2rtJm9GlOa9GHuPmoMirTasElQZxOHYJ9Ng3b4y0cdjs8LPJyxOBACQJbyt7QUZrJuIKQKZgO/ISSZM1JyqlEqwor/JGfCx9kN5EwRhY1LpV9KYcX13Vtd8coDX45aQLxjq7vtQ2cfleesXHeacxsLELaBdUAXobM1X6KLt/lRElo4o+68+kFNaBsis8eXUZdQh3FQAXbJnkjTatYOVGmz+4z4OWeA+zlaW7urW+kYKVTvmP+zV7/dDR3kdp9ubVMMDxjdjrGKIrphfnOxyL+w5pLFdi5feHljb5dOUJBT9wg88Ryh2Hye9ohA+5dzU8zQ4oDT1G6ZnMu4EJDEGKmk4PSBgs0AHcx1QmjI4+EbbjHb54jbERX/OkAxYY5U6aX+c9tSZOhsVbLpyllu18iunn1orbhg3+/Mh99rXv0iyThZrcu9sDlpg5uZYwqUPan1D0sOGkabazeYFFp4njNamvxqnwM1TwX3ARtOa115MV/GfMZgUT/0+Lnm0QZS9wWvzloTMOQndVn8wsA7BXcHBgbm4rT0aY2wlm0ViL3kW5MLJrFRw0Et0vQavFZVdpH9LAOkvx+hhW8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+OXXi9bYIUc8H9ViIDpYyJXAS4+7T92lvMeb+jJSv2hg6tAk2d7BYF7C4rVF?=
 =?us-ascii?Q?YHqoHUb5Li/CXiiFT6aYRQgH7qgg/heTl/ZxeqHZwbKDfhke+F/LBh2FDo9t?=
 =?us-ascii?Q?N/8lgFldOmbchL3LcvVL3A00zaG27c1r4OK7sVhjlPhaIBGlkMBgGTOXbk2k?=
 =?us-ascii?Q?ifZarYMrE1I0Vlt+Li8Wn+S4VQl0kPGB/J5rcYt0lrk808e8ufSbGo5xtz0j?=
 =?us-ascii?Q?QTo8Y6VATrZA3CbHAhk3wk07AEuL1I6hvWRNbFKT6JMM55/Zgq1biBvypp70?=
 =?us-ascii?Q?mKSgbDMLbBu9NZ7QsXFL6QI+iuRO5eRZY8CdE1xJO+Dho0STSD1xtIG7C2HH?=
 =?us-ascii?Q?lxKLK6bulQ0FJdyYMdHY78H3LnBz78dQnB93AjtmCXA72u9ERaPwI1n+2WyE?=
 =?us-ascii?Q?xIJojq0reQw3Lk0X3rqikjdgOdmmzz+XAYC/t4/WODaFHG82Xc0fLm5CRSO8?=
 =?us-ascii?Q?XGQWaZ7ZnbBASkGHwigSqbfdneE7BOxVe+siHWNOfJ9DQdFitiCTF/Tfec9G?=
 =?us-ascii?Q?t4gT+nQgq2P23UYfdNYsAgAAuNhOmpYqfAz3FjIUfCGebO0Sq87vw0V+upB1?=
 =?us-ascii?Q?ouArhzun77/Q5rTQ6cNmjJNx+Z+ugTJJjInxxMLnuSpHBtXYDKlwD9rYPdRs?=
 =?us-ascii?Q?l5YIq7HSFyiEjSRGwN84LJsos6jeFHxxxkEfeIm9kXJSsopXd/fffnR0ooyb?=
 =?us-ascii?Q?bTrNBBqW8gCAJaGHK5PoBKMCK0s3v2mQ8EYU5KN0IEo8MX+HqX9E0h0Zd86U?=
 =?us-ascii?Q?883I1iGXBrpcrSytTcqFG2taLP5hA438nSSCgQc/QrDCTH0IsbRB4CZj2lSA?=
 =?us-ascii?Q?0gwYPT6p97YTf/B4fVAJaT2yLZUfVgYJPZNZfElHfsUxJVpDqn5316wwQkSS?=
 =?us-ascii?Q?7m4ek1nmzcw7YOlKrzurh/JrMSGfdq568BOZCICN551koloW/9zLy9Y0kYc7?=
 =?us-ascii?Q?Q+ZhNGNO2O7tcw9OcsrJ6jeN4SUULrUsMN2xRbLWZC5b5/B5/9rYsWR2knZe?=
 =?us-ascii?Q?LBn1ZffLaYksZjibwYjSFcPTBgfEe9coZJkcKrHXFWWLPmgBzEm9jBNexRHr?=
 =?us-ascii?Q?M/CMHZghCRfY8Jm+F2TG3wcTcd+PB7LATxkdmvGD3EkuAz/Hiu17PcxtcTA9?=
 =?us-ascii?Q?L2tscFA4TUuaA57zL4qka6I49KVFsYOoq5A8NR9gyIVsHWkTRlFwNtKU1WR+?=
 =?us-ascii?Q?LFoNt2/RJyNd/VYfqYd1Bfw1HRhE2GQM1APFBaJmzuQBuoaD/rQNayqcWR/D?=
 =?us-ascii?Q?roUCW44zuU44HRUeUQbCCnfa3xnI+ZGKsjXOU4Ty2F66ej1Qms/iQIAofCbe?=
 =?us-ascii?Q?Nupa9G8zb7Yg+eHyezhRIx14JusDyLF9Ve5Rm9wRXc72Cf6fLIECyIZ5LUNT?=
 =?us-ascii?Q?Bn6sGzv4w9FGSTVZqJThdTsx/EgtHU9m1/T05WmMnzwvaio5GJ5a7RmiZZPD?=
 =?us-ascii?Q?qRXRYRWP1H5/VWhdxwNhid0uEwYPkY9glVAHSfGlIcyDnF9kxRna6ZZ21l1N?=
 =?us-ascii?Q?9tl01lsGOcE7YqDKafBClpl1MN0kC92sDVoW/P1xgqnMyF3miYBWHRRa4FZu?=
 =?us-ascii?Q?xFw3dRnKDs9sDJT4SsfTLOXHh+mtKqmIEBDNxJtCUABMJjkP/mE9e3pCdemh?=
 =?us-ascii?Q?bWX7ygf/w7z6LzsDvdgyW9cRDY5dZkMvu0bo3sr2TahFK1hERQ2G8tFlhYOR?=
 =?us-ascii?Q?55WLmNkUppmysrEgTeOgte6smajFJGIjcKXxATvwYQ5m+SxKD7ax/FGU8Ytz?=
 =?us-ascii?Q?6kAi/tac76tu1BfCORT7YqFVhS+g8QI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FyA7fiQDJ2EVoBFaHja8qU/9LJSEIXUSaE7PHcjnaKPrztQWZuWGZ/7etIglBwIi5EdqvmPViro0i00153UEjb5F6ZsmZVn0DzvMl+8dhIfj82cQsIHCGucacSGeHjOVBSkf8F9Eka1bk+nQyku3v8bxkOUFip14DqWxDMJ3AJnFkFq/PP/BazvpDfySXslFMq/TfxQwI1bab0/O9pG3NnmWrCIAg2+a9DWD2NhAZT81WXSTZ7SzlSKXW20RwONafHYdIVjPvOfonzt6zbSeVYEVHamUigI8KlQZqdxgn5y0ykROpL59bg6UnXIZP5SSlcymPDl3NzHYRz+ve6k92w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a6f66f-1522-4e87-83b8-08df0dab3880
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:15:14.8078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ReTbumKT6cxjrlRzlYmRgTxOPD8+C/yy18ij2PXQM6GhWWj041jZdDbUJF45B5NTq/OhLwpQIwfAeXHujitjmVbIlJEaLZ9ZKuYOYxBtrlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9297
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
> From: Richard Patel <ripatel@wii.dev>
> Sent: Sunday, September 6, 2026 4:33 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew@lunn.ch>; Steve Douthit <stephend@silicom-usa.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Richard Patel
> <ripatel@wii.dev>
> Subject: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
>=20
> Plugging in an unsupported SFP module caused ixgbe NICs to get wedged
> permanently.
>=20
> ixgbe unregisters the netdev when rejecting an SFP transceiver as
> unsupported.
>=20
>   ixgbe 0000:3b:00.0: failed to initialize because an unsupported SFP+
> module type was detected.
>   ixgbe 0000:3b:00.0: Reload the driver after installing a supported
> module.
>   ixgbe 0000:3b:00.0: removed PHC on enp59s0
>=20
> This code path failed to unregister an MDIO bus owned by that netdev,
> so when unregister_netdev() tries to tear it down (via device_del() ->
> devres_release_all() -> mdiobus_free()), it trips over the leaked
> registration.
>=20
>   ixgbe-mdio-0000:3b:00.0: not in UNREGISTERED state
>   WARNING: drivers/net/phy/mdio_bus_provider.c:711 at
> mdiobus_free+0x3d/0x50, CPU#21: kworker/u128:0/12
>=20
> This prevents ixgbe from reloading, even after PCIe remove/rescan:
>=20
>   sysfs: cannot create duplicate filename '/class/mdio_bus/ixgbe-mdio-
> 0000:3b:00.0'
>=20
> Switch to devm_mdiobus_register(), drop custom unregister calls.
> This is safe because the bus is already devm-allocated, so unregister
> always happens before free.
>=20
> Assisted-by: LLM
> Fixes: 8fa10ef01260 ("ixgbe: register a mdiobus")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Richard Patel <ripatel@wii.dev>
> ---
> v1 -> v2: use devm_mdiobus_register() instead of another
>           mdiobus_unregister() call
> v1: https://lore.kernel.org/netdev/20260826042945.2344686-1-
> ripatel@wii.dev/
>=20
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++-------
> drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 2 +-
>  2 files changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index f91856498eb2..96f60269fca6 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -8471,6 +8471,7 @@ static void ixgbe_sfp_detection_subtask(struct
> ixgbe_adapter *adapter)
>  		e_dev_err("Reload the driver after installing a "
>  			  "supported module.\n");
>  		unregister_netdev(adapter->netdev);
> +		adapter->mii_bus =3D NULL;
>  	}
>  }
>=20
> @@ -8693,11 +8694,8 @@ static void ixgbe_service_task(struct
> work_struct *work)
>  	}
>  	if (ixgbe_check_fw_error(adapter)) {
>  		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
> -			if (adapter->mii_bus) {
> -				mdiobus_unregister(adapter->mii_bus);
> -				adapter->mii_bus =3D NULL;
> -			}
>  			unregister_netdev(adapter->netdev);
> +			adapter->mii_bus =3D NULL;
>  		}
>  		ixgbe_service_event_complete(adapter);
>  		return;
> @@ -12104,9 +12102,6 @@ static void ixgbe_remove(struct pci_dev *pdev)
>  	if (adapter->hw.mac.type =3D=3D ixgbe_mac_e610)
>  		ixgbe_disable_link_status_events(adapter);
>=20
> -	if (adapter->mii_bus)
> -		mdiobus_unregister(adapter->mii_bus);
> -
>  #ifdef CONFIG_IXGBE_DCA
>  	if (adapter->flags & IXGBE_FLAG_DCA_ENABLED) {
>  		adapter->flags &=3D ~IXGBE_FLAG_DCA_ENABLED; diff --git
> a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> index ab733e73927d..74631cb2ddbc 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> @@ -1086,7 +1086,7 @@ int ixgbe_mii_bus_init(struct ixgbe_hw *hw)
>  	hw->phy.mdio.mode_support =3D MDIO_SUPPORTS_C45 |
> MDIO_SUPPORTS_C22;
>=20
>  	adapter->mii_bus =3D bus;
> -	return mdiobus_register(bus);
> +	return devm_mdiobus_register(dev, bus);
>  }
>=20
>  /**
> --
> 2.52.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
