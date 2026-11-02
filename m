Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B467606EE8B
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YIn0WdT2;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m2GFRS32
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D81E760703;
	Mon,  2 Nov 2026 17:30:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0NUZwTf5ITlr; Mon,  2 Nov 2026 17:30:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E75C96060A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793640649;
	b=S6GU2NkBp7229NfBW5E77nMPa9OsOYQkbUGDcchiX5i0T2ClYqd6nhX8cmfpTXZueMb7
	 URj2zMamKkb2tMiNkl4iyKkaxQRelKVo3GnJ7xXdjZ7lxbhp5dERo9zuIVd8BCT1XUaAj
	 gMwxWZ5GcFpkwgUjgtIBBvRSGARQ3s/PX67MQfUWpJU1bJAk6WWwf4P3FgS4gwIT3ISaN
	 YIHIuQtHc8cJ6LmZE42v9853HwqZ9RVamUiuPDAdLkV25wfNaKNwMzVlKiNFFgudLp0Sb
	 zvlZ7PdC2mfhKdq/C2R1+JXmCA4uMvZhvg205Hz1/Ayoqa9xzqIThJ7IoNiMrR4bX3A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793640649;
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
	bh=5gMCAI2r8wjs+GW1NHX+0znrDTSn/AIc2zVBR1Zyqlc=;
	b=nchYmH6bptVKJX1teJWK79Cvhc2veORrJYtU7vrw8aYMALfiE3TlzZaXrQ5BAfHvzgrO
	 UmZlmY4zxE0u5wu1EmzWbUWaMRUHXLkvHHjPYIrKgqxmIdoQofz6DMxOkVZfbE8LmMlY2
	 kYHJt2r0/tnHgjRn6lLg30DRn2Z5R5w4Ccis0iwKohY8GhJ3ETZuMKKBMtoT0yfKkmQ01
	 EcL8p5J+tDBeWqdWU8lGKsa9LiNx4rNrcN3XbbxPHRTY5zyGWGsQ3IQPEqxSh3F/jGffB
	 KjennpU5biXXCONPVmJW+K2M0whF8QNSBTuIKIpRV6XuA7r7feu74PqjBI8NOpn9WBw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793640649;
	bh=5gMCAI2r8wjs+GW1NHX+0znrDTSn/AIc2zVBR1Zyqlc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YIn0WdT2vhUCDIZf0Vkk7AkrOoODeWpMVV3nQGPDmFrV0Bn6++p2ujoeVCczenwe+
	 Sdbqp9716kR/NGb2na2v7jcaHjlPj01uSL4/RflCOE6QQeyb5HuciNZ3jDyec1nGNc
	 RtfZkWK9K7J8XaZK+Y6TmDxPxJUpIh/vIALM/KpsPNB6D4Th5U9gsQ1g3XGCwnG+1Z
	 UVBZFvQ9erP1jEfdViZQD/1jhYCoGNXHPrku2plzALqxuO4jvTeZImkSNsFneyRAOs
	 KEWdub89+vN/+2oiAakUq0EUFunI20be3TGC85GordfG74/XKeZwfiyakgVsEiLrK4
	 XwminJcKqXNgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E75C96060A;
	Mon,  2 Nov 2026 17:30:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 542DC235
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 17:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A2178108D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 17:30:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjE7gril97yO for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 17:30:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D62080FFF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793640646;
 b=XJe3hKrO1XYPXJWcrYjMEm4V9RWn0kBuxUMME/CGkGmlYcnIlqmXwj/Ox+16ZWcN2D8+
 +01cTJx1T12CKZ9McmjMPbmVrogP4iV0TgkJ7Z7iDZCxNtBhPPKNQXprriuKGSZp0s+EJ
 lL9RqZAnT1CXdJHhUb6C6eRitIcu3m4pExwbY2uNIdzR3zSlhjo6SwVNMEqyph92w9rJh
 u4zldSB0jEe3DBpqSalLZc52hHXYtCxVrxVUbNpuVJCrqWfdxqiRx36h0y2ok9ZLd+neo
 ipO0Ndbh1ZpIlwzKZLEOFeFUi8bYVJosFmm+OFV+u1aRzmyRpa3m9xJCh3g5Kvivsmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793640646;
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
 bh=5gMCAI2r8wjs+GW1NHX+0znrDTSn/AIc2zVBR1Zyqlc=;
 b=LwSv6lbjPzu95wV6v0rKyWq0xNOZ40fOkcdUBro53noghSA8YIPbbgZMCkq9Omzshvx+
 2FJBdycqgi3TPDfuHQSFZbfTuFVMczxqok9IAPdiXuxkLPkOqPIK972ywB5K/n2+RJeXV
 uxSgOFcWrmVWSCYQYPM70oPiORxmI1gboGet6R0WmaY7H/tjSAzKvfO/hLryM2kWQnJ+j
 eFfkQd17h5tXtDBlqn1g2MS+iyDkxZcwcdmts7l8KV9+VkxiJrfjOjhqAjC+B5wHwggRg
 XlyuqvbQMDN2yZj6Z8pZWkP5p0LsG1jhML9EeVtzLD1RRM3QqIcY0UWo9sM5jUEc3IQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=m2GFRS32; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=sunithax.d.mekala@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=m2GFRS32
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D62080FFF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793640646; x=1825176646;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Mj1wJqzpMlAGp6leGayreSKmkvxsxjyNMFkSN2+UnHc=;
 b=m2GFRS32rW/Sb5f3AqPR6Y28Yq7rKJz76dFEZVrprg+6cwaxQHEY163x
 nALksCIDmkJgSB0qxWsdC5diWfKe2bkHqqpyk0CjLpsSvD4ijULnN2yDb
 6vucJ2rnHWz2UV6z3N77MdD5IOdU5OuUWG8uDlYZQKIAGrUFhCUsArHvN
 2d6oHLqGjBUW2KNUuZ69e02qgCmNbzi66gwUmgucPbkqvKBUliZCuZMWf
 7vcECEMB8Rj2UQMDN17r4UrLwysy9LW7OZ8uOXO0qgAU4umWd6iRxbac3
 DBGwNJ9ASFJjGIZ89vRGeJVKJ0ZjtNfxNjRVY2LpJMnZXVG6WVvefcgBg Q==;
X-CSE-ConnectionGUID: GINZUJYXS1W0NpXybMqRDw==
X-CSE-MsgGUID: 1t3hJ+JVQPS7GPscEMViWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2355187"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2355187"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:30:35 -0800
X-CSE-ConnectionGUID: F2RL8YO4TCaOLneGyvTaPw==
X-CSE-MsgGUID: c0QsIw37T6aPdBMdspD8sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6514804"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:30:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:30:34 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 09:30:34 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:30:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDUf/JcKEzJF19Q5md5N5oA2DRd4pK4IdMxe+SsxkCqGLc7wraAKNyxn5FWbQcqx58IVn4L+0l5XBKLNBCUvcX7MpOHG2AFKevIJZdP3J4oEdVF2ioyoBKf2wkXPlt/E/OAjtd7sm4SUcYUvLfj9nrc3jUfF0kPIiFyEv0g2n3wDhxo/4QvbwiIeH1O6YitxF9EuYqGbKFGytgiJptmAg5zT0TeBSnZLhqp6Sf8iT7c9n1XENQWe1A9Q29VQ5bH1akMxCgqWkitk7LmRa2lvyqM0zrG3bSYGs9CTHHvYf0htTA03+NP+1Hd+seg5jZGadoYwJOP8P7pCzp/u+JYPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gMCAI2r8wjs+GW1NHX+0znrDTSn/AIc2zVBR1Zyqlc=;
 b=WmflaqjEJ+rGycN1FI0b4ZXom0LbG14lyJwM+nqbgxD3VYLU/A2ooU5ovlE5nFI5Bvq5jdjP3XaH2gJgVeuKaNZ/icS6Mn0NWpEx5SlbtTPmpG8zRDTeySOKTFldek12eNHOKUcG0wQ6wl6DcDLHhW62dvNCwkZVf451SoMGX6OukheRJVSTrbxg/ohNRDnER0o842ZYHn0sRvAYLPDtmgYLigKmoOyCFJ/BuO41MDv8MSeeIg6HENrDhKF8TQSahaRtXR5f7ZbioaB2b3Mex0NrbKeKpWX+AJaqvcavWBcY8977n2juICTkXydYc//HG72W12BTSWyg6K0qQZSksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CH4PR11MB335913.namprd11.prod.outlook.com (2603:10b6:610:50e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:30:30 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:30:30 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] igb: fix uninitialized first word
 in igb_set_eeprom()
Thread-Topic: [Intel-wired-lan] [PATCH net] igb: fix uninitialized first word
 in igb_set_eeprom()
Thread-Index: AQHdReLRo/ViUveT00mts/pPdKRM4bcbUvtA
Date: Mon, 2 Nov 2026 17:30:30 +0000
Message-ID: <PH0PR11MB75223DF8615A173566FBBE1EA06A2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260916135254.1016847-1-xiaolinkui@126.com>
In-Reply-To: <20260916135254.1016847-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CH4PR11MB335913:EE_
x-ms-office365-filtering-correlation-id: b541fe99-a9c8-4f65-19b8-08df3906fde7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|921020|261102123227099003|38070700021|261021121427099003|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261022075727099003|261026140227099003|261022105027099003|261022115727099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: OmmNU9gRMmz34QAkv47qsSzqydT7ylk3xh+Lp0PjtLjOtz1NErb4MusqJCDur7VBZf17bTS010vGHawtionbinSKzBZrha3EupQdcoyPDlj2xnCt6ieWQiOB1XDdu5X1EGenhvCMaIi4JrZ8Ino0zEEcvfRVygdMO6NxSyIaKtCi09+x86R6zXxr5beu7yLfVnNZGqhtCkxnTzKVwq59MXiakB79Ccaf9p3i2lHmLHTAhzCTGL3OZ2pbzRJbBQIuo6K5HeVCu3O5dovTY6AemFct+LkqYRFsNn9b0eQ182aR4KhKZ+2TuQNcg2mo9bxZbCYjF02Hhbbq8ayh7zeHrEcvhbNb+kMiWV6Slz1Iwj2ZaBkdXDAWHUuM8156acTzCT4FcoTOpZFJL2ByYjfluBE6IwsSHyl0A9QMb7wGBpBj/K9lslMtl630eWqfrAap/JOiMq6oQTAAj78aUnYMFMgK4vI7Fow3IgFgVmUqSCS961gSvvzaFaV9bmWXGAta7Wscgj96NhPiFzvx8rmltq/3y2WylMzsVNicNH0bvbpv0JpVwYRM9Mq3AoyGInpt3s3AuBry/M2uRt6miZODgSDjKLFmzjcBsTUUU4tJUnVWD6BGRYswwshBxWSUIrVWbkSi1r78K5OKrJiTZYR0zw+zg8LFSF5J61Z9vGTxkwp5J2uy2BgV5tSpdrmkz3yzBZUUn1QGrGD2pB6d5H2oFxSN4tATe6m9C1DnDf2V26SJbXZvxBgpcfExySNhUIQi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(921020)(261102123227099003)(38070700021)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261022075727099003)(261026140227099003)(261022105027099003)(261022115727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CQbFvGqUmRyfRoQuM5h8tfCz/q267fOB9hh4NeZU1m5w9h420DJZeo/QWVkM?=
 =?us-ascii?Q?p3zfnHQLUVONRf4o5pa+QvTmkenFcPAgltOhEVv02hL7PgLM7wpTpMb+hb5x?=
 =?us-ascii?Q?nQmowgSf6/QYoeAkek6GWNS9ubsQV5+WySWsq13buiwxmsC9HFMPw8whc14R?=
 =?us-ascii?Q?VTk2W2vU68GGGuDsmu7X1twkrwBwuVYPj+fSwDpKCUzLrDhIWE/KpY4qBLYs?=
 =?us-ascii?Q?Nbb9Tc8a6mC/AFWeea2iGoE56/hgw2Q7B2csWVUPg24wxXqMk7mvPyx1FXi6?=
 =?us-ascii?Q?/lq3lobPLHFKwdkWXyVutFytNY7kMhfsVc8vYCPdfnC3j82tii5JPgK317oc?=
 =?us-ascii?Q?TLbnp0rSIGgovktc9fNMqQEoeTBPTRNbn2P7I+MKtpr21U77LrJ6BNJaafQY?=
 =?us-ascii?Q?+OR3Bpz+lDZRujHu/m4wEq6lTkNReoQKAb/hYT388WnqurMMambCrITWnzqA?=
 =?us-ascii?Q?FBgB54QAf9EZid41g072UsCZMzjdenb4ogNeOcFqGeBepY/PgmkxPd6cBPYg?=
 =?us-ascii?Q?h977i8vEmjrPrbBfwNeKAc+xsPKQuNkWPiRGCkxVYcXhzPqGr4mmZ6jqWyBT?=
 =?us-ascii?Q?M4vo2VEHaZM72Jed13ty8FcgxUDAKBsCnZy7IKwmFsJn077wg7U+TjUDeVdw?=
 =?us-ascii?Q?Q39KqiPrP/jhZ2dGY+1VSWwVWW1C+nWeOobWvCfEavdO/UAWVC06bap0WLXf?=
 =?us-ascii?Q?sjjxzy5UvcCJNgiCQdugquc3U3qq3G3Y+eSl8hjuX5wM9V48pKnV0gd7icV+?=
 =?us-ascii?Q?euZJGrl8PrRibsGMBWTc15AckosfbnwszlJOrN+rg/e16qOViV2fSsf/dnSm?=
 =?us-ascii?Q?4omYD1on2u1EZHVbJHwu3brvIceMzsvmU6KUVkzhVm7URqQnYRxzlwkRoEc/?=
 =?us-ascii?Q?tIFQNvFpeLtopG1ZrIWodSvyKGIaI2Zx2rAgMO3qG7yDbRweMoUz2ROQIhLD?=
 =?us-ascii?Q?0H3QfvDV7auG8d/1n2tm6uZET12zFAhnCh+ulaXz0lRiu3UyYuKFWW81gIm8?=
 =?us-ascii?Q?4A+gGr8mOObJ7XqHeWRQah9L314tipQY0aBpXta1/loXEyFgT0wJrzjY1zcS?=
 =?us-ascii?Q?JkbVillx9lDBezL1bXctVJq15nc8ZpF27fT32lD2WVeDk6rxNDrPYcv2H/D3?=
 =?us-ascii?Q?5hJwTEeemIGHpFYV2Z10/0GtYJ8L2cF2lafXBoKm6fA+6QQ9UTTyi0XGNWXS?=
 =?us-ascii?Q?aEjd0o3UfvIHyCdDjfcbUnVkjwJhgflJmMyJXT7W9S+uhBr//mBXcpRfT6Be?=
 =?us-ascii?Q?G3Qmhh8ye+VtK9SWtXY+7fIPaKvMuMaDRsJSzNrmFZra9wFk3vvqfmAyATsg?=
 =?us-ascii?Q?WBKSUkuMJblKnQn0wWicCokJLjA7qPTRkssMygIjJUxpEB6JA48Tdnrv7iLm?=
 =?us-ascii?Q?191kGjHQTZTkgR3JIqXsvZzSktYsBe7Sn7mc9nkaFYldZS7bNRLghtnB0yoB?=
 =?us-ascii?Q?hFJAPl3atpCF0gAt71mrfyXnN8TZ4s9hCvKUt9RgOkbCdQIyWYTuQXX+TH6v?=
 =?us-ascii?Q?QkPn8FOxOBJTdinTWNcS/vJxx3C2Zx9ZImYkBXH9Rs2wp1SXlQMeB844RWPQ?=
 =?us-ascii?Q?Eb7cuvO4ZXpSSJsm6VbPVqdxiWF4rxRcfZPH5catKRkyzaZp9eX5PRp21zyu?=
 =?us-ascii?Q?FIeN4ktP3M6vDT57zG0Ghj0Qcw0bB5/xiZWw7rt+CA/8WSbjDo5GcA4hFdNx?=
 =?us-ascii?Q?bV98qg/R8BGmvEJC+p4MQ9uTntrLDzJc6JCJd+ri+9Xcw9Dm411XDC/AC5Q1?=
 =?us-ascii?Q?5UcX44eTxQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YLONiJiyybM12N0BoTD+aD9jiB+CUON5q4/gwHrjysZK4rs0Uk5lJU30+iVEhAFgudVpWDPhgfSMxuSR4nwLEV0e2vjhP3+meiI/8VIuDrpqYkGrTgUQgedVvwJqeQNPtW8jATnGRxV1KZOpWbxtYddImgE6xeSL7jidRbv9is1EpwNwzuW1sOHzywraEcAckeF0H6cEj4autnrCCpAAxNNk3IO+afQJhOxI5VdLUSvfxe9lTDk44+itcIvS9HR74rBHZU1GeCQH/hNIGRl1PQTkuE7NhuBw/+5o+l8QDRduHqnQBWmvs1WIaWPnQYfEsVE4YnOzmlsU+RlUd9/KQA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b541fe99-a9c8-4f65-19b8-08df3906fde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 17:30:30.1666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AQtPo3VR7HPFCRhXxmdExaB6bcwO5Ie6iXlUp0WejZZSrLJJeiehpFUIjOIgIEFdzh5lj0ti0KaY1UDd+cpl5T7stTfwknE97kwIK2s9JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR11MB335913
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>=20
> Sent: Wednesday, September 16, 2026 6:53 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; =
edumazet@google.com; >kuba@kernel.org; pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kerne=
l@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>; stable@vger.kernel.=
org
> Subject: [Intel-wired-lan] [PATCH net] igb: fix uninitialized first word =
in igb_set_eeprom()
>
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>
> igb_set_eeprom() does a read/modify/write of the first EEPROM word when
> the requested range does not start on a word boundary. The error from
> that read is stored in ret_val but never checked, so the function keeps
> going with an eeprom_buff[0] that kmalloc() left uninitialised and
> programs it into the NVM. The read failure is not even reported, because
> ret_val is overwritten by the result of the write below.
>
> The write is followed by nvm.ops.update(), so the corrupted word is
> covered by a fresh checksum and the damage survives a reload.
>
> The read of the last word already bails out on error, do the same for the
> first one. Skipping the write also keeps the stale ret_val from being
> lost, and igb_set_fw_version() is correctly not called since the NVM was
> left untouched.
>
> Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
