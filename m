Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDE8CA5FCE
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 11:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 481A340619;
	Mon,  5 Oct 2026 11:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kT-v8rElG8Z6; Mon,  5 Oct 2026 11:14:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3D3B840608
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791198866;
	b=RH+scUBnHMUqNXh870w/TEh49W6h0JqxAT6at162cyQIt2zoD7frcMQJMC8Tq+qTFM+7
	 ODtu+CZ+gfbs27O7eWF27ML1MRcHQm/RKxgq2OrNCzBc5/xC5K6QbI5z7VKSsknm33BoL
	 2PwPpInM2j/fbEWqTdJgyaKbtkFj84NBkxb6AxE+UJLkjbCqIRTK1MruRJy2zikInUwvn
	 3ieki8lZfiWhvn1tlCPOBMV0EYLcdE/VOP2lc1uRa6CEQ7S3Ly8cgX25AQJzVv6PrScuH
	 aOOhDVo9czdgG+oAuThw4AEuOkYrGRUKY6x4W7yNAiwTNtPOeFkZpT69U/rTbVRKbGQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791198866;
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
	bh=ubnPgCK0ebQQQeGSDt1ILj37vUKKdIKQf2sj7/cCjbA=;
	b=C6/X5JTZdP8XMcTiy1hjhckdewRKdXKNn0W0/lO4Wuf3g0gMsfwtTMc496Ee1KDRPKyn
	 BztGVZkxkR2tfwdk5B/8d6Wm4BYy4ZS/0DcUAV7NfYBXFBmdLGqLD917ibr+erWMmPQhi
	 5vU8giiezjCeS1d+quuHMm8xyFddSVtBm+sDMKOm66X7y+QoHQVkfCAcc8xXNW75NXXj8
	 oBQ1pYeX29b9L3AWC5ch35UqDVPXV2Uwqb6rMAtK3S9orAFEt7AwnRjFL3U6Oo4N3QWKU
	 dm8lQgoeWXsn1hHXA1J1XVBbIRtjGI1L7OEZwoW4n5XWhgV9X1SPAnA71VQQJt7wAFA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791198866;
	bh=ubnPgCK0ebQQQeGSDt1ILj37vUKKdIKQf2sj7/cCjbA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z18me0NpAlw3Rel//9v2avzkBi5z5S1GcUOhyT8YC6e78oAlHLNBH6TBhFNrbCaYF
	 0+TU9NrAWh5lrNNQvbnHmO4n0lAgj3fCbw811k938IooxhrAdBzLBOnSMm1xX08Eby
	 UhV7AkBw4o6mGCEMAnrShSaUHltbCFhpH4bJU7ZTbLCOyuAwx/PhvTWfG/Gie0wA8A
	 u8IYnSiuVUQ4sS67Y4tJsO3bn5Z/SILFL0405nGaM+chF0r37pe3dj/oEA6ESd2T+j
	 HR/2Ih2gh5fMUedQhhHgdFLqO27z4xUaBb1GHIcdVh0IsA6r3N5XDXTZ5+69et+DtE
	 l6fB6CV57dXTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D3B840608;
	Mon,  5 Oct 2026 11:14:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF65D282
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E133E80BDF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:04:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WvRN2JkkzX_g for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 11:04:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 26FC980BDD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791198275;
 b=PT1U03ofAkBbeidUr1ppnvm0t8sCmRdCANIhBYf1zzpenPwAIWSJaAgF2U0fSZIva8X0
 OQzuy/jnLIAcOGA2T3gpqyjTSVfAQUGoEgEI4zNc94RBSxQDgodMzjewbzJQS54LLEM6c
 IPVuSWbe28JrErQAwpMvm6IIvFBjsnHMPIDSu0J9hJBMj3xDE/JKmDT6md7dNgfRkIjWD
 eoVCiq6U2efwO2OlPXyN2M26Z+6F593LEDYHPzT0A5tSiaJ7p8+uHv1dGxbXjOsmeIOJ6
 rA8E19UA5CN9zFNYROsi1Ql64nOsnXmH/0uqs5SPP6UhjqrwDcMBtyR7Mynl7rQXnaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198275;
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
 bh=ubnPgCK0ebQQQeGSDt1ILj37vUKKdIKQf2sj7/cCjbA=;
 b=bf2NiIV1vIw/llh5Vfb/df72ZANyeB+wuoJ0VNzsGGVjshN2HXIVZtLINKHKE7e87Afa
 lgaS5nAFPpHTEwnz16X89D/RR2GLbdT8nZwEHmI1wl3Z46stYydPWPodb+IGIJA56uQVP
 nQnFwJrtB7APPXbdmF2RMn4fh4h0HwThVNPQYAPC9wkzQB3hHE1Waf3+HLnyePYXiFb4a
 gkQpN8mZy/QRW1sIqTEFWf7J4H2t6mLBgrXoCQMIjxGW8ef1JmsiEPoRhVxh/Tq+ja6/0
 Azrc1MYxMZih1XjC30U4yWZ9IRm2vjCtgohW/9ntvvbzeWUSa/hP+07QUzN8qa0/DeA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="mzt+yEx/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mzt+yEx/
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26FC980BDD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791198275; x=1822734275;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ubnPgCK0ebQQQeGSDt1ILj37vUKKdIKQf2sj7/cCjbA=;
 b=mzt+yEx/pswtiirDqhz3m0b5FzjAUA1zBDvDQVjGT9ScreRCWsmkbARO
 gIX0kKgtruedNGcJlA0rg1CRY925LE6GWq7T5HB1sOogQdyCF38Eb0E+k
 kL8xHw4zbSikXrNcHk8KtkWVOcE8/qCsxeXYOkqLJWjWaCPHDJYkkywxy
 7iriECHIfxshGNAJEMnBE03b4ixYX4filGHs8LmTYQUWvdcz2nPQfl4c/
 brvQsEwwnevXaqOKhJ8kWfcmLqNBxGBYU9pmFFe80QvD2DTxkh/sptHNz
 R6T7Z2qK796t46jUhcZWYOdPM/hOytkOWp4hVdH2OShWA2D7I6/Nitetf g==;
X-CSE-ConnectionGUID: 26dO5Q2TR+KE4diFD5VoUw==
X-CSE-MsgGUID: U9pbACBSQYatt+ZqpqoeDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="102385426"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="102385426"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:04:33 -0700
X-CSE-ConnectionGUID: jHxGE1TcQ1qR3TBmKRNAVA==
X-CSE-MsgGUID: DFDsIOD2RziBAA/gybVcdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="276923624"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:04:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:04:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 04:04:32 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuAzyUPoHb1NOd4vMUQPJb8IwSr1AigZls6Bhw4nSgmP1uLCZslg0sxtcwWv3ggJML1oXnnJRZlv3YcG2NwVqTHTgLOP0KqCiCMIQ+Aiw2ZlW2eTQU1aM7LMUgmtU/wtV3nbVVzJHat8m8AIrDo08Xe8Jz8GjA1sZLpZNaKAWz1e1GiLWrKJe7Hq16sEhzVuOyNzWy5+uQHjRXQElqKyUJWgmXRAp091YVdm/Qz9r9Hp21h18rhcnJ3pdFYAGrLogWJUFkqJzrWqy6hQT/9dA+i1D3NgaIrMNXRMh0lCszWGuJG39LulNy7I1qFEtA/vDuCPBdRgXrx/w85gynhpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubnPgCK0ebQQQeGSDt1ILj37vUKKdIKQf2sj7/cCjbA=;
 b=R6KhYyVOCq2+/C6Wu+n84DRJy3PKj9QBkff9R8DDg8NIMsX5iXA1zYrPHNbiejhANmlFe1z/mdmMdqAVf7khnUcEYG/RJkaZCQr7OrlIGfBKL9bd+0DBtJDk59ifJOtm5iz7XgEEEn7ryv6Cui3iBn1lPg7xjvnX/YeD8e5Y6oiJV55IX+AwRVYbnAEc/vj7viBpr+ecb2UgdppuauMBkbzz6VQKMiT51HsM27QNUU6ZjmSPgiZGUKZcOmzoZ2nPJFlFnFTZOJIgATJ6aJqC1S26QjJ8clP4nQA9kSTapZWQOfem68LVROyMhHwa8T1uE2yeAxw4XoucaDMCnN+zow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 11:04:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 11:04:29 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v3 10/15] ice: E825: perform a soft reset when
 starting the PHY timer
Thread-Topic: [PATCH iwl-net v3 10/15] ice: E825: perform a soft reset when
 starting the PHY timer
Thread-Index: AQHdTUnHZG+VLdlcikCaC2ldyf8687bu1/nA
Date: Mon, 5 Oct 2026 11:04:29 +0000
Message-ID: <IA3PR11MB898689F7DD14A1945EF3E8BCE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-10-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-10-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS7PR11MB7784:EE_
x-ms-office365-filtering-correlation-id: b9250e86-fce3-4d71-c95b-08df22d06d72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|4143699003|6133799003|921020|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: JtDBe69IuxGgt2EB03pEIMfx9xTPh2+s28Ag84J05FshEV2g+aP1tZO2G0p49Uht+1PF/tQrAxNQNOMh6pQ7UOb4+3q9QbvIhjR0oLaF4JqaCpe8aR/FuqONuw05GRdDQ1wFGZnOPrznhCsI7HatJv0KNAfQaQ+fkll6XekjThNNokzDUHBjcgl9QYs3Vt03T1k2r2grfDy+RZ2Fuw596Vt3nOvXZCoSzb8NtA9Nzq6beyhyQUr7nPkw8KfvVky1xUC+sb2aN/bHJKdGY+LkjaG+PJgPaHO8DR/eacBtxTns62NnU4JzpTr6o76Fs12foEGlDaINpEx6Gm1qgW6WCEbkKF9JrKk6cxqL2bJeAyQPAYSvkqys3+C6cRfdwnWsulg9bw5udgqvxuRp4FZ3HNJEMvU01j3tMmiAZzlbkNi15ntxw8RBHo56vWhfcNwhsIUGFQ//MADU40CEEvrNc0x3DXuhH6ZQa7XDHVemHbGHvXStM8mcCyNWP9n0MVJhjx9kNOLlFBW5b3AXLlsegkNdBkJEQ98viY1KDMdTn9bOKW2VEYh/RRA+k45FMt2AnSIHzA5jBsfSmteRuJvVmvX01P0ss5RQaFzwOgKcJJum4IO8qi8JQduco+k9jJAhXjDJfkZoVXLbYV5xt2e+o4VPLDCBlR+88ZpvgfHidc8s80Cg/hw5eHL7tfP2TDWL8P8KLcvJXstkVsThfQsUkJoigLw/wajDx8nIoCHoC5JgxQGWJA8lxZF6cP9i63mJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(921020)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlhnWGtWZUlsVk5rcVNuY1RycTJLOEFYVlU5dWFjSmQ2NUpzWnZTY0RhYkJC?=
 =?utf-8?B?QzBTdXJ5Wkk4S2hCTzlGZXhxWndOUkZkME5meXFKNGdMYk9sS29mQi9pR2Ja?=
 =?utf-8?B?WTlOSmY4S3UzK2NPT05iZEx0dWpKbVpMNldtL3RCM09zTlN2cFV4MTgxc3pl?=
 =?utf-8?B?MjMyeWw0aUhjZ2VjQ2xKc3haZWUyTitFOGlhenlvVjZBYXBGZEdLa2UwRmh0?=
 =?utf-8?B?MlVQQ2JGYWZnNDNRd2xEUGkzd21jM1NSczhDRzZxK1dUOTNnQTk0WUVYS2ZV?=
 =?utf-8?B?b1UrVmZKVnN2elluK3BvMmc1aEF0aFhhR29sRytRTU1vaVAvVDNuUS9vWlBH?=
 =?utf-8?B?aElwR05LTi9SVzBMVGpzWjlQbnNSQlVGd3pIa20vV0V4UUQ4ZW15aGhpYm9w?=
 =?utf-8?B?RVozb0d2SjBZLy9wNFY0M2NtRVlVZTFOeTkxbjcwYzBoQWw5cytvYWU2bW5O?=
 =?utf-8?B?YjNGRWY1NDR6ZHBrZTVGZkhwZ005V3dMWGw0UTFiWllhNHFiaE0vOGsydkd1?=
 =?utf-8?B?NDV5bldDdW5NZWFmRWNINVFZSGsrcnBxT0xnb1JPeEI4SGRxL0JqNGljSmJp?=
 =?utf-8?B?RE5SQlVyb2hWQm1oU0pCSGNyV1IrbkhOVURUOG9MN2lJSk93aksyOW15dVZ1?=
 =?utf-8?B?RldaTkd6aTh3eXBaWUFNRUZaTjJSK3NYTVU2VWFrV1BjcVUyWkg4ZCtjdXFu?=
 =?utf-8?B?TE56RkRBVVhBS0hpa2hqNFlpWGJQOU1YRGltT2U0MlQ5K0lhTkpJUFY3L3Ay?=
 =?utf-8?B?dG1qVXhoWUVjaGdvUWdlRVNNa1NwQktXYlF2MVBDYTZVSFQwZXlEcDhRdHBM?=
 =?utf-8?B?OXFqOUhuaVVPaERaY2plZTlsUVhET2p1U1NlQkV1T01nL2ppZnY1QUpkT0U1?=
 =?utf-8?B?cnBDVldZTDRJUFRqcTBEbjBLbzdpYWpLazB1d3NDNmpXQ0Y3YUpNV3JOejJL?=
 =?utf-8?B?TFFLY0dVS0t6S0tEcnF5Ukk0RmF5UVJ4V0RqWmZtUkNuRS8vZkNaakErNWdy?=
 =?utf-8?B?WGx2Q2hPdEcxb3NQSGlIeGJSQ3pBZ3B5SU5nUklBMkltNG02OHAxL1FLTWli?=
 =?utf-8?B?T0dBTndqQUhVSVF2bzJETmovSllSbTNrMTI1azhtOGg2NkoxOXFZNHY1OGZs?=
 =?utf-8?B?SEF5WlNvRi90V2RXYnk1aWlWK0EvbXhPNXN5ZndMVWkwa0twYmJpN3VyWW5P?=
 =?utf-8?B?aEFiUUZlM3JDcGdSMndoOTVSNllrUnNPdDBrRCtvRWtiZGRwNm96R0E3WFNN?=
 =?utf-8?B?Q0lmcUgwdS9hSEdmS3hOQlliTGJmOHNpOTdZTHErT2NGSFdGUlAxcGg3czUy?=
 =?utf-8?B?VGFwSGZWdE42U0puKzNUS21KZkd5VG8rR2JjbHluNitSMHd1eS9SUStzV25v?=
 =?utf-8?B?emN2Y2FQTGNoeU5DTXRIdjIwaXhHZzNyNFR2UVFFbnY0eHhyQWN1M1V0MXRy?=
 =?utf-8?B?azI2UXZkQ0s5OWVvYjUwemRmU0FDOEg2V0ZVT1dkbUZvYTZrRlMrMDREb3h0?=
 =?utf-8?B?NldDaFRoQXRPZ1ZEc3Z3MW1tZitheHlVbUplVnVQVkF3aFhGNW1uNWMwdnBP?=
 =?utf-8?B?SjlMLy8xVHprcWRtTi9EL1NOeDlRM2o0dFRGQ3dwRlRCU3J6cTAyc29yM3Rh?=
 =?utf-8?B?TTZBRDZiaERsZVNjbThRMWhjQ3ZuN05tMHljUmZHWXJIVDBHaW9raDBNVTNr?=
 =?utf-8?B?UHE4ZHozaTE0V0huOGl1Z0U5aWN5RyttZHp0dnZtME14L0wxQTJjTDhNVkZV?=
 =?utf-8?B?RGdMYVRyajYxYTBWQVR0eTQ1Rnd3ajlDRXhGakQrdGhnS2tYam14VmNNamVY?=
 =?utf-8?B?aFNCTE1DTldhRnYrWTE3dlVYYlJOcXZiTUxhUzkzRE8zSlpCUUhVQUZURDJH?=
 =?utf-8?B?dGo5SEgzUFNLcjV5cm9EblppOVk4NFVaZ09VdFpQTlY3dmJPSUlQVjlMdFQw?=
 =?utf-8?B?cVFMdHNublMxQ2NKTnl3QThWUjEwL0VHMkUwckY3aVRCd1NENzJTRC84SXhs?=
 =?utf-8?B?WGxIQ0kwc1NnTUprZDNWbGlHQkVndHRHR0xaMTNjR2lYeTMwb29xcE85YU9k?=
 =?utf-8?B?Z3BaUkZTRkk0ZHhhcUpYa1RTU3U5djJIQTlCSEE3c0hLT0RVYlpaZHRsV2FT?=
 =?utf-8?B?K0svakN1WHBxRFI5NitTenBrdk9jUTFSOHdRZDQxUU1nMExNWmN3dG1vR1Yv?=
 =?utf-8?B?bzVVN2xlTEJQNDQrUWVDYVhteGxUT05FdnNZS0FhTVg3ZXJCQXdzZFNveXkz?=
 =?utf-8?B?UERscFhrL1RkM3RMMDFnbzhsU2UzaXgxWXlwV0x0UW9HK0luOXdQVVM1NUpy?=
 =?utf-8?B?Z3MzTUJhZ3dJdVhNbVJqMDljby9jUVhRVFp0elQ3b3VJY1V4SUltZ2tySi9D?=
 =?utf-8?Q?jbqzPekGBcjoLE54=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ywMXL1/Cd4c2prxGccaevdyf5DcqPEUhgu9h8ue/p6wTq3tOx4N2JKBAy1jPFKrsCo5UTlthxor0qCVd0Zh7gRmZ6orkKwSuBCRjd1B9ySq4qgWVYXspXvW7tftWQqnmnd7tjMBs6JcCeLT47ETQiy0tue58XM0WR3Mu95ZGQEBVdKOqkhsmVTUAWCg7fXBrhAcO6VV73sRIpnY2u+GcAisEuXl767ZNNwXgQYRkiSu2l8z//4taOIllJ38p6giABdKhZs5mvdkzLLNnn/cpp0cy2QsmdfDdPbq5L5RtOgqO8Ubp9WvixTGrnuznejcYcXOheEwnmdYzQwRnnTCi3w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9250e86-fce3-4d71-c95b-08df22d06d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 11:04:29.4655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSeMdVIE77jBOHJOcNA7CZIeX28j4ljuKe9XpiSF0panqLpFOMhkk+RJcxD4hHdOxMYLKjZOT+aBhLC+ESDKYKpR2++dc74TpodPvY64kVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgS2VsbGVyIDxq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjYs
IDIwMjYgMTo1NyBBTQ0KPiBUbzogSW50ZWwgV2lyZWQgTEFOIDxpbnRlbC13aXJlZC1sYW5AbGlz
dHMub3N1b3NsLm9yZz47IE1hY2huaWtvd3NraSwNCj4gTWFjaWVqIDxtYWNpZWoubWFjaG5pa293
c2tpQGludGVsLmNvbT47IEtlbGxlciwgSmFjb2IgRQ0KPiA8amFjb2IuZS5rZWxsZXJAaW50ZWwu
Y29tPjsgS29yYmEsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua29yYmFAaW50ZWwuY29tPjsg
Tmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgTml0a2Es
IEdyemVnb3J6DQo+IDxncnplZ29yei5uaXRrYUBpbnRlbC5jb20+OyBLdWJhbGV3c2tpLCBBcmth
ZGl1c3oNCj4gPGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNvbT4NCj4gQ2M6IEtlbGxlciwg
SmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgTWFjaG5pa293c2tpLCBNYWNpZWoN
Cj4gPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggaXds
LW5ldCB2MyAxMC8xNV0gaWNlOiBFODI1OiBwZXJmb3JtIGEgc29mdCByZXNldCB3aGVuDQo+IHN0
YXJ0aW5nIHRoZSBQSFkgdGltZXINCj4gDQo+IFRvIGVuc3VyZSB0aGF0IHRoZSBFODI1IFBIWSB0
aW1lciBiZWdpbnMgaW4gYSBjbGVhbiBzdGF0ZSwgaW5pdGlhdGUgYQ0KPiBQSFkgc29mdCByZXNl
dCBwcmlvciB0byBwcm9ncmFtbWluZyB0aGUgUEhZLiBUaGlzIGVuc3VyZXMgdGhhdCB3ZQ0KPiBj
bGVhciBhbnkgb3V0c3RhbmRpbmcgVHggdGltZXN0YW1wIG1lbW9yeSwgYW5kIGVuc3VyZXMgdGhh
dCB0aGUgUEhZDQo+IGludGVybmFsIHN0YXRlIGluY2x1ZGluZyBpdHMgdGltZXN0YW1wIGNvdW50
ZXIgaGFzIGJlZW4gcmVzZXQuDQo+IA0KPiBOb3RlIHRoYXQgZGVzcGl0ZSB0aGUgbmFtZSwgdGhp
cyBQSFkgc29mdCByZXNldCBvbmx5IGltcGFjdHMgdGhlIHRpbWVyDQo+IGJsb2NrIG9mIHRoZSBQ
SFksIGFuZCBub3QgaXRzIHJlZ3VsYXIgVHgvUnggZnVuY3Rpb25hbGl0eS4NCj4gQWRkaXRpb25h
bGx5LCBtYW55IGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzIHN1Y2ggYXMgdGhlDQo+IFBIWV9SRUdf
VFNfSU5UX0NPTkZJRyBhbmQgUEhZX1JFR19UWF9PRkZTRVRfUkVBRFkgYXJlIG5vdCByZXNldC4N
Cj4gDQo+IEZpeGVzOiA3Y2FiNDRmMWMzNWYgKCJpY2U6IEludHJvZHVjZSBFVEg1NkcgUEhZIG1v
ZGVsIGZvciBFODI1Qw0KPiBwcm9kdWN0cyIpDQo+IFJldmlld2VkLWJ5OiBNYWNpZWsgTWFjaG5p
a293c2tpIDxtYWNpZWoubWFjaG5pa293c2tpQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
SmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuYyB8IDEyICsrKysrKysrKy0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5j
DQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuYw0KPiBpbmRl
eCBlODNhZDJiYjhkNDIuLmU1YmZlZGU5MDQzMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jDQo+IEBAIC0yMTI4LDkgKzIxMjgsMTEgQEAgaW50
IGljZV9zdG9wX3BoeV90aW1lcl9ldGg1Nmcoc3RydWN0IGljZV9odw0KPiAqaHcsIHU4IHBvcnQp
DQo+ICAgKiBAaHc6IHBvaW50ZXIgdG8gdGhlIEhXIHN0cnVjdA0KPiAgICogQHBvcnQ6IHRoZSBQ
SFkgcG9ydCB0byBzdGFydA0KPiAgICoNCj4gLSAqIFN0YXJ0IHRoZSBjbG9jayBvZiBhIFBIWSBw
b3J0LiBUaGlzIG11c3QgYmUgZG9uZSBhcyBwYXJ0IG9mIHRoZQ0KPiBmbG93IHRvDQo+IC0gKiBy
ZS1jYWxpYnJhdGUgVHggYW5kIFJ4IHRpbWVzdGFtcGluZyBvZmZzZXRzIHdoZW5ldmVyIHRoZSBj
bG9jaw0KPiB0aW1lIGlzDQo+IC0gKiBpbml0aWFsaXplZCBvciB3aGVuIGxpbmsgc3BlZWQgY2hh
bmdlcy4NCj4gKyAqIFBlcmZvcm0gYSBQSFkgc29mdCByZXNldCBhbmQgdGhlbiBzdGFydCB0aGUg
Y2xvY2sgZm9yIHRoZSBQSFkNCj4gcG9ydC4NCj4gKyAqDQo+ICsgKiBUaGlzIG11c3QgYmUgZG9u
ZSBhcyBwYXJ0IG9mIHRoZSBmbG93IHRvIHJlLWNhbGlicmF0ZSBUeCBhbmQgUngNCj4gKyAqIHRp
bWVzdGFtcGluZyBvZmZzZXRzIHdoZW5ldmVyIHRoZSBjbG9jayB0aW1lIGlzIGluaXRpYWxpemVk
IG9yDQo+IHdoZW4NCj4gKyBsaW5rDQo+ICsgKiBzcGVlZCBjaGFuZ2VzLg0KPiAgICoNCj4gICAq
IFJldHVybjoNCj4gICAqICogJTAgICAgIC0gc3VjY2Vzcw0KPiBAQCAtMjE1MCw2ICsyMTUyLDEw
IEBAIGludCBpY2Vfc3RhcnRfcGh5X3RpbWVyX2V0aDU2ZyhzdHJ1Y3QgaWNlX2h3DQo+ICpodywg
dTggcG9ydCkNCj4gIAlpZiAoZXJyKQ0KPiAgCQlyZXR1cm4gZXJyOw0KPiANCj4gKwllcnIgPSBp
Y2VfcHRwX3BoeV9zb2Z0X3Jlc2V0X2V0aDU2ZyhodywgcG9ydCk7DQo+ICsJaWYgKGVycikNCj4g
KwkJcmV0dXJuIGVycjsNCj4gKw0KPiAgCWljZV9wdHBfc3JjX2NtZChodywgSUNFX1BUUF9OT1Ap
Ow0KPiANCj4gIAllcnIgPSBpY2VfcGh5X2NmZ19wYXJwY3NfZXRoNTZnKGh3LCBwb3J0KTsNCj4g
DQo+IC0tDQo+IDIuNTYuMC5yYzAuMzk1LmdkMWYzNTI0ZTE1ZGMNCg0KUmV2aWV3ZWQtYnk6IEFs
ZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KDQo=
