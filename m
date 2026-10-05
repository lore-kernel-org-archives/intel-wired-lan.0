Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B745CA5FCE
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 11:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72E014061F;
	Mon,  5 Oct 2026 11:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3E0RBKRNlBaE; Mon,  5 Oct 2026 11:13:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4A71C40608
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791198813;
	b=IemgyrB5/H7DlMzETWTOnO58nQ0rqMzXgDeqwb9bt9wQJSTiHf0SmdkfGoLtWYwDSyqG
	 MJOx4ZikhuSgcIJ5cmFCOqKtjrY2qPqbJhANhtVfBqH3/ajE3EBtKs/m5MbsKaA0FV1qJ
	 29kajgJe6of34KXcXoXeCWnF16NmPO7yR1lMXdSZGta7Hj/DcRy3bImO7XugvodhwR/3a
	 bRNG19tS9sIcUX8gHqzN39MuOAj21f7plPvONJpkD4cvlpkUGwFtanr1dRNT3Hfb4m3VO
	 t3eouwL9apXTdoR15kHV/wLQroG7WmMIO0iSvWPmbJYVW+mfV0kuC+uoj/zn6PvmIfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791198813;
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
	bh=uEFSvsTLfOUlqT1o6y9ak99ZoCorKoRtvjE4qKup6C8=;
	b=fqFeoX5fjvW1YtM2uUTMDPAefPp/hCr5gvr8FaMNdIzPv/0sykZP4NwtEoKwGz+6siyp
	 RVdB8wDOS/P2aZm6DGuu1JM2uim6vps33eBhoNzvS/A+OEJFGrRuhz9HM4KxGCROmgrQf
	 RUPjSwwmEl9n9Af22SUT4C618Ny7C2/3kmtUyZzahwKMCtQ9xBpS+Wdc9hJTFt8OBL+/W
	 +Qy2jE5M15UKUdMV7F5SLZ2ghCCqHPt44iddlJmxIhsBez0WHe9GwaHBSdIiviL3GbdpQ
	 OaiYnG/jRXoPaVPxxVWPNLKfWTpwMkvS5D0tIANxpOSIvdSzwJhOHI57DQ1J9isZTzQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791198813;
	bh=uEFSvsTLfOUlqT1o6y9ak99ZoCorKoRtvjE4qKup6C8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TMo3TClIpGXuOKxUtQBqW+nFcPXcGMbTGzl5r9paX8u2vbwQkJtZyBBN/PXfsJ5tQ
	 M600bjlroKoxyBJhjsONV1ngbhCdoIjGihOViz8igyDSOejrgBEnQhFfw/riWMcwrW
	 IZcUS92xLQxF2NGCtmoHtn9SDctKzDLW/jqrQVQS6U202UCpwfoOW2WGLNo32k0bdu
	 cnZefHkXJf9AGqFfHbZ/Zt7JPOM0/rqByzNjT0fKlMusRmS5FoHN1f1vaZhdmQsr2N
	 hmddGDPQF218fRIIkwEHk3sE48InSDyTfrYn9TTPRsXHdqUqE0Aut6Yv6HvUhw8Nsz
	 nxKEBcSI2Xg1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A71C40608;
	Mon,  5 Oct 2026 11:13:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4774A282
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38CD560613
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kv-fZCU-HIzN for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Oct 2026 11:04:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 55C0460606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791198240;
 b=EDfLF29O+fLR1dNyrU7Z+UZLvFNyM+KsZVt4jHpbNt1gXZT663N3WwRwrEKYROHtIalZ
 IyJsvNZqcC7QSblUv4zzLDKVa4dNh7jKvAIu9Lrr3DF89KXLG4Hr28qfc2+PP3tGCPRZZ
 cE1O8FT6b4FBcUnjBAtruNwbzj62oViYjJRvGHipEw3663edPMmEx4s8vS0h7sVBoZPtn
 NhXazxJNjfvh0iKAAAqJ79icKX4Pp92F8Yq7XlCcA1yMsjKPQ1Ec7OTjOQyCl21x+M8IR
 OJsnBLrqaczRwM9WV4ewS9UcDYNBU/0sVs9MS6HkIPEpowtWuui9XckCqoaXt3dATEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198240;
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
 bh=uEFSvsTLfOUlqT1o6y9ak99ZoCorKoRtvjE4qKup6C8=;
 b=Aa3PWq82TtPK25L0j9KZCgkrGkLP7g4H/COG0gnTEoFX06eagy7FA78TdUYIDiCN/5En
 C/c3UE3+pu5Y4MMxK5vv5N1ei2irgqh4K8aIRkhfyx/maXLuinxZ3dQaBNRvgc3JX8dz/
 aZkr2n11plbBYk3Aw4BrHor5XI22/ER9jqeH8X7nFCdLhG3UoC9Z0bzmtrssSf9FlN5+s
 bp9q+wvB1oddhKH7kyCCpBtRBxONeF1j1KAAJaKMqx3OxTEMsErjxiD42e2SFVIunIx/a
 e47VV73W2xzD1DEX36TijvR9Z5F2k8sz2kYl751Exh4E09HPbYAomSO9AxYD9BUtV5A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ktva8uGf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ktva8uGf
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55C0460606
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Oct 2026 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791198241; x=1822734241;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uEFSvsTLfOUlqT1o6y9ak99ZoCorKoRtvjE4qKup6C8=;
 b=Ktva8uGfwwMDbAApR+WtVdseoNWNLafQg7IDWuxowYppebxY64Uok+ls
 1QI78CrlGbqdcX7ovuLVjgYybT9fWHN5AtL7aa+a9mIiGy7mfCVddwp6h
 7JuJJ/pDfyuIgz3GiCTImQt4ctHleZFys4AaOhaWPggi2HDQdv+OleaRf
 asKGq3UNl4ELKqHs46xLHs7Rudy8CLEfPj5QBrVCxkpMH5WzuUGvhtr/s
 ywJEbAIDvCQ4Yh6y78tiGFslTYXAtzEbcY/VtAZxq1NX6yZopu95QThsz
 AWOCS2j3icML6zaLe+2HLnO79HpprOX957ZkAmjl446N/zGE1oc/T+b+S A==;
X-CSE-ConnectionGUID: nHgyuCkIRW21VIivB1NseA==
X-CSE-MsgGUID: UFnnsSz1T+2UrNnLIXWSCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="102385362"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="102385362"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:03:58 -0700
X-CSE-ConnectionGUID: ZjypuycBSba/hzUnn9+Wkw==
X-CSE-MsgGUID: IDgg3dtfQ9SMKlI6HFTmZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="276923540"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:03:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:03:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 04:03:57 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 04:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oe9VogZKdWHOuT+OYMs+W1WODH0r3DSHNC8zb4tB2EtA4Yt2YHBJmAYTepZTddgWOA4xXh/zHMNZwQMWiqCff+THQfAiEcTFWg0zpin9xc/cvcXhhnptuyCWlPCKePUzlidosSYVfyoCdRc0SAf/8RjgN4zmoVK1iIgx6Ce8bknyjgrEXdj64IqiC+L3nKjPenGevHHRKhCGx+8cL0A2bYaAQFgCSt0jrhBMYHfFpzq9bNRGF0hY6LOmDQN6IhABn8jelF9AmLf/Vz5qy9DUL5njmpiziZlXJQ8UcjHVR3cKUngYcwH4kvRPLzNRCtBL0Y4eMlKrkPik0Q7fQYwFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEFSvsTLfOUlqT1o6y9ak99ZoCorKoRtvjE4qKup6C8=;
 b=nMlqYA6eb6Lm3LuiAbbXc6lqZiKGplC5mGUEX1StoCUc53FKOuFDkdHro187lry84Zyww5TVA064Kp/x720GPj+gp5xRJ85LMq0wcg9YeSljYCQKGFo5K9AD2cve8UkPzZO5gYAqctHlDjwcpf6a2+GRbSCg7K+wKUC2LQLtR9uusLUcVDyNdt2dA7gJx4xKYo4/Ll2N9ri8eIkVv6aR+tui/hxvkBCqRx1pytUXjtgAl2lY67Z3AMlA/IYmIHn9ZiO/zfgh8QlOLileKvtaP4ntwEzqDJVVh4PP/PDqsUYguZHaPn1iRvlKV/kwFb8ZGJ+OucalLbcBTY5K7WxGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 11:03:55 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 11:03:55 +0000
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
Subject: RE: [PATCH iwl-net v3 08/15] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
Thread-Topic: [PATCH iwl-net v3 08/15] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
Thread-Index: AQHdTUnKZhGAGaYyOEy1imXtoJbfH7bu18bQ
Date: Mon, 5 Oct 2026 11:03:54 +0000
Message-ID: <IA3PR11MB89868185FB85DF6209C0752DE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-8-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-8-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS7PR11MB7784:EE_
x-ms-office365-filtering-correlation-id: 9b907152-70a7-4b37-2752-08df22d058ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|4143699003|3023799007|6133799003|921020|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: TkQRXQnyFw64v4efuzJPB0sBeC8++L6GNC0hauV3x28qRUzdyDuYcYJS1Q37peNExseXd88HKNFEU3yWIefI4tAA/N0rUSbAgRI6d0rA9l5p09dhGiifH5ofl2VXyYZat7NRps9mS2p6qY5y6iCe+/ulva1FM80Me7BaViIb2+sFbXvz9IdyPUq8hZHlyHjbufpVG5VzkAfaZlW8q/ORYiMfgf5kqmq1T96fB7FQ418xm/0mx0pa08sGZhzWrXupKXs/UCyao31C1C6+JCY7QvSUE0oXKcUcLwDI1cd6W1LSW1LBX3FrUsrTUeL+jUEwxhvaCwXGaRKkCv32h7PswdEQd9K7JGjFbuVcTiOqlyg4seRdJsqnYe33/g/yacup3QZIF/4CvnslUjPCOaTPBEHug7s/YjGxXOH3oxwXrd/XWo8aCatNRr/Xro9ifAOBZAeGlr9QMuVCM2xqeBDVLYPMn3kPmeI2Zk2LoKARlRAXE69OOCUAMYc60+aPNyOHSYZRwB9hBKUIY0XMZYCbhkvvFrfmas0mb4Qi1Hxdo44vQFI5zhNfYRUZph7ow4Ao/SeA5WBcLVf3YNGYsxmfEVYYG3+L8J/1glD3F1tHwpNJX/l1PYqtU8ru6i7QzbWzotUIC5hbbNOWYeXnprGVe6b0O/1l3oCzz6TcknEzkk3HHtjXeEAfJIHxGE1PnxS6uo9kAxta7Qhavs9F6jUpowDTxvJqVAZtxAI3VLnYi0nIXD7UYpTL6kY5tMjw8r3E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(6133799003)(921020)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clVvK2tCeDRvZmJWOUp4RGlhMHVPa21xMCtZbVNiMmtBRlFod3E2Z21WTkFi?=
 =?utf-8?B?THNEU2VzeUtWV1hNL3NWN2dJblRnNW1VVWF1Y2FqZGZTL2JCZmVpaTl6a3pN?=
 =?utf-8?B?Yjdpa2hLbkRuUHlXWWRBdTU5ZWlaMTRJK0dOMzhYbitTNE9UbVU2cW9UUi9p?=
 =?utf-8?B?ZklVbEhNY1lIZUMvU3M0bjRHdFhmeW5XWlpoUzQzUzR0L1JRZXVEdXRadC9x?=
 =?utf-8?B?MTdlVVp5bzY0T2RGLzVtb2xzbVZ3Nk1PdGNKUHFsbXVnN0hVRjczWkpRNFUy?=
 =?utf-8?B?ZHJkWUorOWVHbmZxbU1HalZkQWZtbkZsem5BbCtzYmlVYjgrUnFKS0VaSHhn?=
 =?utf-8?B?citCOXg5QkFQNVdrbGxValpjaUNGaXhPQVprRm9mcVNlamxLVzVYc0hWbFBJ?=
 =?utf-8?B?aXF5SVFTZW94ZHdWbUVSMlJYK2U4YVRhcUJpU3pSeHRTQXhhNFJxeEk2Zy9E?=
 =?utf-8?B?eGVtS091MXFPanJsUzgzWmczMko1MW5IejB5SU1sdFQ5OGNvaklieXBpZ3o1?=
 =?utf-8?B?TWVSNjdWK3RlMDluYVNtM2dzQVlXbHNaenhiVkw1WGlUYnI5djhZWTlTaDV0?=
 =?utf-8?B?ZXU0a1NCeUVta0RJMjU5UFExUStXSVhKcDBpajg4cVRZcHQ4UVJDN1pXZ2hn?=
 =?utf-8?B?YlBSdklFSWRxL2QzL0x1YThrY2xQcDJEVlpSdzR2SFI4Z3FyZ1FCTlNLaVk0?=
 =?utf-8?B?MzFveFBTV1RNaStkeWltWUdQYWFwRU1rQ2RCZGJTaHNDNkpnN3YxUk9NZ1pY?=
 =?utf-8?B?YWNQdUpJR2hUVG5XeGszWW51ZHRnb2I1UFJJY2g0ZUhLWWdUQk0zZnhkVVdi?=
 =?utf-8?B?ejVPTGMyRzF0NlVsTGV1Wis2TDB0aGg1c25SVHRnc2lhUUtJbjV0ODQ1d0FV?=
 =?utf-8?B?WWp0Mld2QWsyQk5Ia2MvT09lbWgyeEhDUlYzM2RsdXFncVBVSXpGR3FtbHps?=
 =?utf-8?B?U0RlV0FKbVFQaUxnMlpCWEFqbGYzblFSL3dMdHZmeDlLaTFrc0NUV004VWdD?=
 =?utf-8?B?N2N5dldnL0YyQVhaclZGaWZLUy92NUoxZUM0LzNxQmJLN0RxdlJ3TkdjcDdG?=
 =?utf-8?B?WHZzOVpJellCYU9CaElRN2phSTVCa2VNN0hNOXlnYVRXOGRnSldlNVI0UkVW?=
 =?utf-8?B?QjVqZ2JwTDZyNDJRdTdKNlJtRGE5eFdoZ3F0ZTE5aHNqclc3aklxTUFUbzN1?=
 =?utf-8?B?N1BodTk0SnNsZVVhUzBqMVRCSEtoN2J1SG56VkxxT3NRc2ltdzhaYkl0a0lo?=
 =?utf-8?B?Sjk5L2pXcFVTa2lKU2p0aThFa2p6dis5RFI4czl1ZEtmUmhING5yamozWFZl?=
 =?utf-8?B?V284c0ZNdU9jMFE5NVcrZG9aZXViQlRjZEZUTTU5V2NtVTRIcUFLYVBZRnZU?=
 =?utf-8?B?UXp4RTVQZWJjNkxHcHFLeXlGazNNWHk2cGYxWGJ5SEFESzQxV1VCZWNsaWM5?=
 =?utf-8?B?TFl0Zlc5enpsT1ArcG1QeFFDaXRKcTRHQnhJcVNRc3A0OGhRVlI4MGFvVFpQ?=
 =?utf-8?B?c052YXB6dlBSbTZreExEc2pFUWZhVTIvQkFOSFNLTk1xUEdRMTZSTHc0V2N1?=
 =?utf-8?B?OStncmU1elh6NnlkcS9jeHVUb05lUm5vWUkzN3NkZkFveFdiOUhMc1FrNkVn?=
 =?utf-8?B?VGNBakMxYVZlVndDQmhzeEVvV2loUDh0bklMZWVRck5UUlMyRmVyQWVxWS9z?=
 =?utf-8?B?aDdxcG1pRXhVYXdGbEFNYkMwQ1ZOQTVhSFZZazU4M1NRSklwanhIQ29pVGor?=
 =?utf-8?B?dDQ2MUdWdkRZSEE0R0RLR2RXaWtTdkNXTUZzTWhHZHZlNGVkbEc2MENVWWxh?=
 =?utf-8?B?UGtFWSt6Y0ZnZ0FSUkpHNllDM0FPOGJrdUhzUDZhSHJ0Z1VKLzlVTzNRQVFj?=
 =?utf-8?B?TFNOcGpySUJRbEM0cGEvU041WitsMXFuQVp5OXdGdHZRQXU5ZzkrKy92ejQ5?=
 =?utf-8?B?MUtiTjFBdmtndW5OcDhuSEIxNjdub09WL291ZzhFMEVNU1JGa09mWExZemFG?=
 =?utf-8?B?QU9PeWZJUzBlRUV4SVU1cUVNRTRIcTYwaExwYWJSZEhlcC9aOGpSdEdhRml2?=
 =?utf-8?B?WkIwOTA4d1V0NCtXWXdQMXN2MGFvTEZXRHZNZUxBOW1PaHB1MU9CYmhuUFVS?=
 =?utf-8?B?WDRuTmxPN21tMVhCMHJ0Q1p6S0JKWElpajdkV1JPWmFVQTlRL0ZCVWhBSEtJ?=
 =?utf-8?B?eTVMYkZIQ0FleVNlNlhGZDNNbGhsOC9Md3RxbnE0eWVXSVpWYmlzQUNzN1VU?=
 =?utf-8?B?RzQ2cEswNDg0NXh5dnpPajJnNTUwQVJPdlJnQll5WGtHdCtPTlFUbEQrVVFl?=
 =?utf-8?B?VVpWc2FYSTRQQzNWYm9TY0l1SE9Wd29lY3JJQzBLNFo1M2M0aFFDK0JFN0tj?=
 =?utf-8?Q?6GC6gBaDzwTWjzgc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: u5qMASF6zKtfn0jGRL8nHqEDbUyahBByol+BKfP+PTdscbPN+IjiO8mGgbcrubaGJblTMEunsulKfM1TRldTh4NWPHTpiYSmrDkUynUOJ8c8Vqx7w8k+Y6EmqHpt9dgsrjgqj2lDs9k0IBYPq8yUdqxnIHozVWtMGex4X2N82uUA/0XJXGYpRmTBk+ZMFyQjvq9tArhtSG065bTUGoLfSL7hMtSaMibFiq33TXbAT64vjSOM+qwTS41LCjCbKh291hUjjjkbsAlEohtIJAckbJtW6JDjkEqYiXIFLxgOW9NpnQLtGTU6bgDjmJKRuXyG/6pv7bZdWN65ufkhyLwEZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b907152-70a7-4b37-2752-08df22d058ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 11:03:54.9242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i32hTYRu3j8DD++AjZh4qWTKm6b/BqAcE48WDscnleGmfAJQPeROgUbY7CKt6LEJNbKZ4jUwcK2rXYtATaJm9wMBdCjL8VRRVB8yIXhawGQ=
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
LW5ldCB2MyAwOC8xNV0gaWNlOiBFODI1OiBzdG9wIGNsZWFyaW5nDQo+IFBIWV9SRUdfVFhfT0ZG
U0VUX1JFQURZDQo+IA0KPiBUaGUgaWNlX3N0b3BfcGh5X3RpbWVyX2V0aDU2ZygpIGZ1bmN0aW9u
IGlzIGNhbGxlZCBieSB0aGUgZHJpdmVyIGZvcg0KPiBFODI1IGRldmljZXMgdG8gZW5zdXJlIHRo
YXQgdGhlIFBIWSB0aW1lciBoYXMgYmVlbiBzdG9wcGVkLiBUaGUNCj4gZXF1aXZhbGVudCBmdW5j
dGlvbiBmb3Igb2xkZXIgRTgyMiBkZXZpY2VzIHBlcmZvcm1lZCBtYW55IHN0ZXBzLg0KPiBIb3dl
dmVyLCBvbiBFODI1IGl0IG9ubHkgY2xlYXJzIHRoZSBQSFlfUkVHX1RYX09GRlNFVF9SRUFEWSBh
bmQNCj4gUEhZX1JFR19SWF9PRkZTRVRfUkVBRFkgYml0cyB0byBpbmRpY2F0ZSB0byBIVyB0aGF0
IGl0IHNob3VsZCBubw0KPiBsb25nZXIgdHJlYXQgdGhlIFBIWSBvZmZzZXQgYXMgdmFsaWQuDQo+
IA0KPiBXaGVuIFBIWV9SRUdfVFhfT0ZGU0VUX1JFQURZIGlzIGNsZWFyZWQsIHRoZSBoYXJkd2Fy
ZSBzdGlsbCBjYXB0dXJlcw0KPiBUeCB0aW1lc3RhbXBzLCBidXQgaXQgbm8gbG9uZ2VyIHNldHMg
dGhlIHZhbGlkIGJpdCBmb3IgdGhlc2UNCj4gdGltZXN0YW1wcy4gVGhpcyBzb3VuZHMgcmVhc29u
YWJsZSBhdCBmaXJzdCBnbGFuY2UuIEhvd2V2ZXIsIHRoaXMNCj4gcmVzdWx0cyBpbiB0aGUgaW50
ZXJuYWwgb3V0c3RhbmRpbmcgdGltZXN0YW1wIGNvdW50ZXIgYmVjb21pbmcgb3V0IG9mDQo+IHN5
bmMuDQo+IA0KPiBXaGVuIGNhcHR1cmluZyBhIHRpbWVzdGFtcCwgaGFyZHdhcmUgaW5jcmVtZW50
cyBpdHMgaW50ZXJuYWwgY291bnRlcg0KPiBhbmQgc2V0cyB0aGUgYXNzb2NpYXRlZCAicmVhZHki
IGJpdCBpbiB0aGUgdGltZXN0YW1wIG1lbW9yeSBzdGF0dXMuDQo+IFRoZW4gaXQgY29tcGFyZXMg
dGhlIHRpbWVzdGFtcCBjb3VudCB0byB0aGUgdGhyZXNob2xkIHRvIGRldGVybWluZSBpZg0KPiBp
dCBzaG91bGQgdHJpZ2dlciBhbiBpbnRlcnJ1cHQgdG8gdGhlIE1BQy4NCj4gDQo+IFVwb24gcmVh
ZGluZyB0aGUgdGltZXN0YW1wIGhhcmR3YXJlIGlzIHN1cHBvc2VkIHRvIGRlY3JlbWVudCB0aGUN
Cj4gY291bnRlciwgY2xlYXIgdGhlIHZhbGlkIGJpdCwgYW5kIGNsZWFyIHRoZSBhc3NvY2lhdGVk
IGJpdCBmcm9tIHRoZQ0KPiBtZW1vcnkgc3RhdHVzIHJlZ2lzdGVyLiBIb3dldmVyLCBpdCBvbmx5
IHBlcmZvcm1zIHRoZXNlIHN0ZXBzICppZiogdGhlDQo+IHZhbGlkIGJpdCBpcyBzZXQuDQo+IA0K
PiBTaW5jZSB0aGUgdmFsaWQgYml0IGlzIG5vdCBzZXQgd2hpbGUgUEhZX1JFR19UWF9PRkZTRVRf
UkVBRFkgaXMgY2xlYXIsDQo+IHRoZSB0aW1lc3RhbXAgY291bnRlciBpcyBub3QgZGVjcmVtZW50
ZWQgYW5kIHRoZSBtZW1vcnkgc3RhdHVzIGlzIG5vdA0KPiBjbGVhcmVkLg0KPiBUaGlzIGxlYXZl
cyB0aGUgY291bnRlciBvdXQtb2Ytc3luYyB1bnRpbCBhIFBIWSBzb2Z0IHJlc2V0Lg0KPiANCj4g
QWNjb3JkaW5nIHRvIHRoZSBoYXJkd2FyZSBlbmdpbmVlcnMsIHRoZSBQSFlfUkVHX1RYX09GRlNF
VF9SRUFEWSBiaXQNCj4gaGFzIG5vIG90aGVyIGVmZmVjdHMuIEl0IG9ubHkgY29udHJvbHMgd2hl
dGhlciBoYXJkd2FyZSBjYXB0dXJlcw0KPiB0aW1lc3RhbXBzIHdpdGggdGhlIHZhbGlkIGJpdCBz
ZXQgb3Igbm90LiBTaW5jZSBjYXB0dXJpbmcgdGltZXN0YW1wcw0KPiB3aXRoIHRoZSB2YWxpZCBi
aXQgY2xlYXIgaXMgcHJvYmxlbWF0aWMsIHRoZXkgcmVjb21tZW5kIHNpbXBseSBub3QNCj4gY2xl
YXJpbmcgUEhZX1JFR19UWF9PRkZTRVRfUkVBRFkuDQo+IA0KPiBOb3RlIHRoYXQgdGhlIFBIWV9S
RUdfUlhfT0ZGU0VUX1JFQURZIHBlcmZvcm1zIGEgc2ltaWxhciB0YXNrLg0KPiBIb3dldmVyLCBj
bGVhcmluZyBpdCBpcyBmaW5lIGFzIHRoZXJlIGlzIG5vIGFzc29jaWF0ZWQgdGltZXN0YW1wDQo+
IGNvdW50ZXIgb24gdGhlIFJ4IHNpZGUuIFJlY2VpdmUgdGltZXN0YW1wcyBhcmUgc2ltcGx5IGlu
c2VydGVkIGludG8NCj4gdGhlIGRlc2NyaXB0b3IuIENsZWFyaW5nIHRoaXMgcmVnaXN0ZXIgY2xl
YXJzIHRoZSB2YWxpZCBiaXQgZm9yDQo+IHRpbWVzdGFtcHMgdW50aWwgd2UgY29tcGxldGUgY2Fs
aWJyYXRpb24gYW5kIHJlLWVuYWJsZSB0aGUgcmVnaXN0ZXIuDQo+IA0KPiBOb3RpY2UgdGhhdCB0
aGUgc29mdF9yZXNldCBwYXJhbWV0ZXIgb2YgaWNlX3N0b3BfcGh5X3RpbWVyX2V0aDU2ZygpIGlz
DQo+IHRvdGFsbHkgdW51c2VkLiBJdCBpcyBhIHJlbGljIGZyb20gYSBjb3B5LXBhc3RlIG9mDQo+
IGljZV9zdG9wX3BoeV90aW1lcl9lODJ4KCkgdGhhdCBpcyB1bm5lY2Vzc2FyeSwgc28gcmVtb3Zl
IGl0Lg0KPiANCj4gTm93IHRoYXQgd2UgZG8gbm90IGNsZWFyIHRoZSBQSFlfUkVHX1RYX09GRlNF
VF9SRUFEWSwgbmV3IHRpbWVzdGFtcA0KPiByZXF1ZXN0cyBjb3VsZCBoYXBwZW4gd2hpbGUgdGhl
IFBIWSBpcyBjYWxpYnJhdGluZy4gVG8gYXZvaWQgdGhpcywgc2V0DQo+IHRoZSB0eC5jYWxpYnJh
dGluZyBmaWVsZCBvZiB0aGUgVHggdGltZXN0YW1wIHRyYWNrZXIgd2hlbiBzdG9wcGluZyB0aGUN
Cj4gdGltZXIgYW5kIGNsZWFyIGl0IHdoZW4gZmluaXNoaW5nIHRoZSByZXN0YXJ0LiBUaGlzIGVu
c3VyZXMgdGhhdCBhbnkNCj4gbmV3IHJlcXVlc3RzIHdpbGwgYmUgcmVqZWN0ZWQgdW50aWwgdGhl
IFBIWSB0aW1lciBjYWxpYnJhdGlvbiBoYXMNCj4gY29tcGxldGVkLiBBbHNvIGNhbGwNCj4gaWNl
X3B0cF9tYXJrX3R4X3RyYWNrZXJfc3RhbGUoKSB0byBwcmV2ZW50IHJlcG9ydGluZyBhbnkgcHJl
dmlvdXMNCj4gb3V0c3RhbmRpbmcgdGltZXN0YW1wcyB0byB0aGUgc3RhY2suDQo+IA0KPiBVbmxp
a2UgRTgyMiBkZXZpY2VzLCBzZXQgdGhlIGNhbGlicmF0aW5nIGZsYWcgd2hlbiAic3RvcHBpbmci
IHRoZSBQSFkNCj4gYW5kIGNsZWFyIGl0IGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBzdGFydCBwcm9j
ZWR1cmUuIFRoZSBFODI1IGRldmljZQ0KPiBkb2VzIG5vdCBwZXJmb3JtIHZlcm5pZXIgY2FsaWJy
YXRpb24gYW5kIHRodXMgZG9lcyBub3QgbmVlZCB0byB3YWl0DQo+IGZvciBoYXJkd2FyZSB0byBt
YXJrIHRoZSBvZmZzZXRzIGFzIHZhbGlkLg0KPiANCj4gSW4gdGhlIGV2ZW50IHRoYXQgdGhlIFBI
WSB0aW1lciBzdGFydCBwcm9jZWR1cmUgZmFpbHMsIHRoZSBkZXZpY2UgaXMNCj4gaW4gYW4gdW5r
bm93biBzdGF0ZSBhbmQgdGltZXN0YW1wcyB3aWxsIG5vdCBiZWhhdmUgcHJvcGVybHkuIEFzIHN1
Y2gsDQo+IGFuZCBzaW1pbGFyIHRvIEU4MjIgZGV2aWNlcywgdGhlIGNhbGlicmF0aW5nIGZpZWxk
IGlzIG5vdCBjbGVhcmVkIG9uDQo+IGZhaWx1cmUuIFRoaXMgbGVhdmVzIHRpbWVzdGFtcCByZXF1
ZXN0cyBkaXNhYmxlZCB1bnRpbCB0aGUgbmV4dCBsaW5rDQo+IHJlc3RhcnQuDQo+IA0KPiBGYWls
dXJlIGluIHRoZSBzdGFydCBmbG93IGlzIHVuZXhwZWN0ZWQgYW5kIGl0IGlzIHVuY2xlYXIgcHJl
Y2lzZWx5DQo+IHdoYXQgc3RhdGUgdGhlIGhhcmR3YXJlIGlzIGxlZnQgaW4uIEF0dGVtcHRpbmcg
dG8gYWRkIGEgY29tcGxleCByZXRyeQ0KPiBtZWNoYW5pc20gZm9yIGEgcmFyZSBldmVudCBpcyBu
b3Qgd29ydGh3aGlsZS4gVGhlIHBvcnQgcmVzdGFydA0KPiBwcm9jZWR1cmUgY2FuIGFscmVhZHkg
YmUgcmUtaW5pdGlhdGVkIGJ5IHRyaWdnZXJpbmcgYSBsaW5rIHJlc2V0IChpLmUuDQo+IHZpYSBl
dGh0b29sKS4NCj4gDQo+IEluc3RlYWQgdXBkYXRlIHRoZSBkZXZfZXJyIG1lc3NhZ2UgYXQgdGhl
IGVuZCBvZg0KPiBpY2VfcHRwX3BvcnRfcGh5X3Jlc3RhcnQuDQo+IENsZWFybHkgaW5kaWNhdGUg
dGhhdCB0aW1lc3RhbXBpbmcgaXMgZGlzYWJsZWQsIGFuZCBhZGQgYSBub3RlIHRoYXQgYQ0KPiBs
aW5rIHRvZ2dsZSBtaWdodCByZWNvdmVyIHRoZSBkZXZpY2UuIEZvciB0aGUgaW52YWxpZCBNQUMg
dHlwZSBwYXRoDQo+IHJldHVybmluZyAtRU5PREVWLCBza2lwIHRoaXMgbWVzc2FnZSBhbmQgbG9n
IGEgZGV2X2RiZyB0aGF0IHdlIGZhaWxlZA0KPiB3aXRoIGFuIHVua25vd24gTUFDIHR5cGUgaW5z
dGVhZC4NCj4gDQo+IEZpeGVzOiA3Y2FiNDRmMWMzNWYgKCJpY2U6IEludHJvZHVjZSBFVEg1Nkcg
UEhZIG1vZGVsIGZvciBFODI1Qw0KPiBwcm9kdWN0cyIpDQo+IFN1Z2dlc3RlZC1ieTogTWFjaWVq
IE1hY2huaWtvd3NraSA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwX2h3LmggfCAgMiArLQ0KPiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyAgICB8IDM2DQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKystLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX3B0cF9ody5jIHwgMjUgKysrKysrKysrKy0tLS0tLS0tLS0NCj4gIDMgZmlsZXMgY2hh
bmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHBfaHcuaA0KPiBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwX2h3LmgNCj4gaW5kZXggMTZiMTk4OGU5
OTNkLi4xNzAwMGRmNzdjZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2ljZS9pY2VfcHRwX2h3LmgNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWNlL2ljZV9wdHBfaHcuaA0KPiBAQCAtMzc4LDcgKzM3OCw3IEBAIGludCBpY2VfY2d1X2dldF9v
dXRwdXRfcGluX3N0YXRlX2NhcHMoc3RydWN0DQo+IGljZV9odyAqaHcsIHU4IHBpbl9pZCwNCj4g
DQo+ICAvKiBFVEg1NkcgZmFtaWx5IGZ1bmN0aW9ucyAqLw0KPiAgaW50IGljZV9wdHBfcmVhZF90
eF9od3RzdGFtcF9zdGF0dXNfZXRoNTZnKHN0cnVjdCBpY2VfaHcgKmh3LCB1MzINCj4gKnRzX3N0
YXR1cyk7IC1pbnQgaWNlX3N0b3BfcGh5X3RpbWVyX2V0aDU2ZyhzdHJ1Y3QgaWNlX2h3ICpodywg
dTgNCj4gcG9ydCwgYm9vbCBzb2Z0X3Jlc2V0KTsNCj4gK2ludCBpY2Vfc3RvcF9waHlfdGltZXJf
ZXRoNTZnKHN0cnVjdCBpY2VfaHcgKmh3LCB1OCBwb3J0KTsNCj4gIGludCBpY2Vfc3RhcnRfcGh5
X3RpbWVyX2V0aDU2ZyhzdHJ1Y3QgaWNlX2h3ICpodywgdTggcG9ydCk7ICBpbnQNCj4gaWNlX3Bo
eV9jZmdfaW50cl9ldGg1Nmcoc3RydWN0IGljZV9odyAqaHcsIHU4IHBvcnQsIGJvb2wgZW5hLCB1
OA0KPiB0aHJlc2hvbGQpOyAgaW50IGljZV9waHlfY2ZnX3B0cF8xc3RlcF9ldGg1Nmcoc3RydWN0
IGljZV9odyAqaHcsIHU4DQo+IHBvcnQpOyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWNlL2ljZV9wdHAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lj
ZS9pY2VfcHRwLmMNCj4gaW5kZXggN2NjMTUxYjAxYTEzLi44MThlMmUyNjVhN2UgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYw0KPiBAQCAtMTIyMSw2ICsx
MjIxLDcgQEAgaWNlX3B0cF9wb3J0X3BoeV9zdG9wKHN0cnVjdCBpY2VfcHRwX3BvcnQNCj4gKnB0
cF9wb3J0KQ0KPiAgCXN0cnVjdCBpY2VfcGYgKnBmID0gcHRwX3BvcnRfdG9fcGYocHRwX3BvcnQp
Ow0KPiAgCXU4IHBvcnQgPSBwdHBfcG9ydC0+cG9ydF9udW07DQo+ICAJc3RydWN0IGljZV9odyAq
aHcgPSAmcGYtPmh3Ow0KPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAJaW50IGVycjsNCj4g
DQo+ICAJbG9ja2RlcF9hc3NlcnRfaGVsZCgmcGYtPmFkYXB0ZXItPnBzX2xvY2spOw0KPiBAQCAt
MTIzNiw3ICsxMjM3LDE0IEBAIGljZV9wdHBfcG9ydF9waHlfc3RvcChzdHJ1Y3QgaWNlX3B0cF9w
b3J0DQo+ICpwdHBfcG9ydCkNCj4gIAkJZXJyID0gaWNlX3N0b3BfcGh5X3RpbWVyX2U4MngoaHcs
IHBvcnQsIHRydWUpOw0KPiAgCQlicmVhazsNCj4gIAljYXNlIElDRV9NQUNfR0VORVJJQ18zS19F
ODI1Og0KPiAtCQllcnIgPSBpY2Vfc3RvcF9waHlfdGltZXJfZXRoNTZnKGh3LCBwb3J0LCB0cnVl
KTsNCj4gKwkJLyogRGlzYWJsZSBuZXcgVHggdGltZXN0YW1wIHJlcXVlc3RzICovDQo+ICsJCXNw
aW5fbG9ja19pcnFzYXZlKCZwdHBfcG9ydC0+dHgubG9jaywgZmxhZ3MpOw0KPiArCQlwdHBfcG9y
dC0+dHguY2FsaWJyYXRpbmcgPSB0cnVlOw0KPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZw
dHBfcG9ydC0+dHgubG9jaywgZmxhZ3MpOw0KPiArDQo+ICsJCWljZV9wdHBfbWFya190eF90cmFj
a2VyX3N0YWxlKCZwdHBfcG9ydC0+dHgpOw0KPiArDQo+ICsJCWVyciA9IGljZV9zdG9wX3BoeV90
aW1lcl9ldGg1NmcoaHcsIHBvcnQpOw0KPiAgCQlicmVhazsNCj4gIAlkZWZhdWx0Og0KPiAgCQll
cnIgPSAtRU5PREVWOw0KPiBAQCAtMTMwMiwxNSArMTMxMCwzNSBAQCBpY2VfcHRwX3BvcnRfcGh5
X3Jlc3RhcnQoc3RydWN0IGljZV9wdHBfcG9ydA0KPiAqcHRwX3BvcnQpDQo+ICAJCQkJCSAgIDAp
Ow0KPiAgCQlicmVhazsNCj4gIAljYXNlIElDRV9NQUNfR0VORVJJQ18zS19FODI1Og0KPiArCQkv
KiBpY2VfcHRwX3BvcnRfcGh5X3N0b3AoKSBtYXkgaGF2ZSBhbHJlYWR5IGRpc2FibGVkDQo+ICsJ
CSAqIHRpbWVzdGFtcHMsIGJ1dCBzb21lIHJlc3RhcnRzIG9jY3VyIHdpdGhvdXQgZmlyc3QNCj4g
c3RvcHBpbmcNCj4gKwkJICogdGhlIHRpbWVyLCBzbyB3ZSBlbnN1cmUgdGhhdCBuZXcgcmVxdWVz
dHMgYXJlDQo+IGRpc2FibGVkDQo+ICsJCSAqIGhlcmUuDQo+ICsJCSAqLw0KPiArCQlzcGluX2xv
Y2tfaXJxc2F2ZSgmcHRwX3BvcnQtPnR4LmxvY2ssIGZsYWdzKTsNCj4gKwkJcHRwX3BvcnQtPnR4
LmNhbGlicmF0aW5nID0gdHJ1ZTsNCj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcHRwX3Bv
cnQtPnR4LmxvY2ssIGZsYWdzKTsNCj4gKw0KPiArCQlpY2VfcHRwX21hcmtfdHhfdHJhY2tlcl9z
dGFsZSgmcHRwX3BvcnQtPnR4KTsNCj4gKw0KPiAgCQllcnIgPSBpY2Vfc3RhcnRfcGh5X3RpbWVy
X2V0aDU2ZyhodywgcG9ydCk7DQo+ICsJCWlmIChlcnIpDQo+ICsJCQlicmVhazsNCj4gKw0KPiAr
CQlzcGluX2xvY2tfaXJxc2F2ZSgmcHRwX3BvcnQtPnR4LmxvY2ssIGZsYWdzKTsNCj4gKwkJcHRw
X3BvcnQtPnR4LmNhbGlicmF0aW5nID0gZmFsc2U7DQo+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJnB0cF9wb3J0LT50eC5sb2NrLCBmbGFncyk7DQo+ICsNCj4gIAkJYnJlYWs7DQo+ICAJZGVm
YXVsdDoNCj4gLQkJZXJyID0gLUVOT0RFVjsNCj4gKwkJZGV2X2RiZyhpY2VfcGZfdG9fZGV2KHBm
KSwgIlBUUCBmYWlsZWQgdG8gcmVzdGFydCBQSFkNCj4gcG9ydCAldSB3aXRoIHVua25vd24gTUFD
IHR5cGUgJWRcbiIsDQo+ICsJCQlwb3J0LCBody0+bWFjX3R5cGUpOw0KPiArCQlyZXR1cm4gLUVO
T0RFVjsNCj4gIAl9DQo+IA0KPiAgCWlmIChlcnIpDQo+IC0JCWRldl9lcnIoaWNlX3BmX3RvX2Rl
dihwZiksICJQVFAgZmFpbGVkIHRvIHNldCBQSFkgcG9ydA0KPiAlZCB1cCwgZXJyICVkXG4iLA0K
PiAtCQkJcG9ydCwgZXJyKTsNCj4gKwkJZGV2X2VycihpY2VfcGZfdG9fZGV2KHBmKSwgIlBUUCBm
YWlsZWQgdG8gcmVzdGFydCBQSFkNCj4gcG9ydCAldSBvbiBsaW5rLXVwIHdpdGggZXJyICVwZTsg
VGltZXN0YW1waW5nIHJlbWFpbnMgZGlzYWJsZWQ7IEENCj4gbGluay10b2dnbGUgbWF5IHJlY292
ZXIuXG4iLA0KPiArCQkJcG9ydCwgRVJSX1BUUihlcnIpKTsNCj4gDQo+ICAJcmV0dXJuIGVycjsN
Cj4gIH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vf
cHRwX2h3LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5j
DQo+IGluZGV4IDNhNDFjNzExZTc1MS4uMDdiNTVmYmI4OGRkIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jDQo+ICsrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwX2h3LmMNCj4gQEAgLTIwOTgsMzIgKzIwOTgs
MzMgQEAgc3RhdGljIGludCBpY2Vfc3luY19waHlfdGltZXJfZXRoNTZnKHN0cnVjdA0KPiBpY2Vf
aHcgKmh3LCB1OCBwb3J0KSAgfQ0KPiANCj4gIC8qKg0KPiAtICogaWNlX3N0b3BfcGh5X3RpbWVy
X2V0aDU2ZyAtIFN0b3AgdGhlIFBIWSBjbG9jayB0aW1lcg0KPiArICogaWNlX3N0b3BfcGh5X3Rp
bWVyX2V0aDU2ZyAtIENsZWFyIFBIWSBSeCBvZmZzZXQgcmVhZHkgZmxhZw0KPiAgICogQGh3OiBw
b2ludGVyIHRvIHRoZSBIVyBzdHJ1Y3QNCj4gICAqIEBwb3J0OiB0aGUgUEhZIHBvcnQgdG8gc3Rv
cA0KPiAtICogQHNvZnRfcmVzZXQ6IGlmIHRydWUsIGhvbGQgdGhlIFNPRlRfUkVTRVQgYml0IG9m
IFBIWV9SRUdfUFMNCj4gICAqDQo+IC0gKiBTdG9wIHRoZSBjbG9jayBvZiBhIFBIWSBwb3J0LiBU
aGlzIG11c3QgYmUgZG9uZSBhcyBwYXJ0IG9mIHRoZQ0KPiBmbG93IHRvDQo+IC0gKiByZS1jYWxp
YnJhdGUgVHggYW5kIFJ4IHRpbWVzdGFtcGluZyBvZmZzZXRzIHdoZW5ldmVyIHRoZSBjbG9jaw0K
PiB0aW1lIGlzDQo+IC0gKiBpbml0aWFsaXplZCBvciB3aGVuIGxpbmsgc3BlZWQgY2hhbmdlcy4N
Cj4gKyAqIERpc2FibGUgUnggdGltZXN0YW1waW5nIGJ5IGNsZWFyaW5nIHRoZSBQSFlfUkVHX1JY
X09GRlNFVF9SRUFEWS4NCj4gKyBUaGlzDQo+ICsgKiBjYXVzZXMgUnggdGltZXN0YW1wcyB0byBi
ZSBjYXB0dXJlZCB3aXRoIHRoZWlyIHZhbGlkIGJpdCBjbGVhciwNCj4gKyBlbnN1cmluZyB3ZQ0K
PiArICogZGlzY2FyZCBhbnkgdGltZXN0YW1wIGNhcHR1cmVkIHdoaWxlIHRoZSBQSFkgaXMgYmVp
bmcNCj4gcmVjYWxpYnJhdGVkLg0KPiArICoNCj4gKyAqIE5vdGUgdGhpcyBkb2VzICpub3QqIGNs
ZWFyIFBIWV9SRUdfVFhfT0ZGU0VUX1JFQURZLiBDbGVhcmluZyBpdA0KPiArIHdvdWxkDQo+ICsg
KiBjYXVzZSB0aGUgVHggdGltZXN0YW1wcyB0byBiZSBjYXB0dXJlZCB3aXRoIHRoZWlyIHZhbGlk
IGJpdCBjbGVhci4NCj4gKyAqIFVuZm9ydHVuYXRlbHkgdGhlIGNhcHR1cmVkIHRpbWVzdGFtcHMg
c3RpbGwgaW5jcmVtZW50IHRoZSBpbnRlcm5hbA0KPiArIGNvdW50ZXINCj4gKyAqIGFuZCByZXN1
bHQgaW4gb2ZmLWJ5LW9uZSBhY2NvdW50aW5nLiBJbnN0ZWFkLCBUeCB0aW1lc3RhbXANCj4gcmVx
dWVzdHMNCj4gKyBzaG91bGQNCj4gKyAqIGJlIGRpc2FibGVkIGJ5IG90aGVyIG1lYW5zLg0KPiAg
ICoNCj4gICAqIFJldHVybjoNCj4gICAqICogJTAgICAgIC0gc3VjY2Vzcw0KPiAgICogKiAlb3Ro
ZXIgLSBmYWlsZWQgdG8gd3JpdGUgdG8gUEhZDQo+ICAgKi8NCj4gLWludCBpY2Vfc3RvcF9waHlf
dGltZXJfZXRoNTZnKHN0cnVjdCBpY2VfaHcgKmh3LCB1OCBwb3J0LCBib29sDQo+IHNvZnRfcmVz
ZXQpDQo+ICtpbnQgaWNlX3N0b3BfcGh5X3RpbWVyX2V0aDU2ZyhzdHJ1Y3QgaWNlX2h3ICpodywg
dTggcG9ydCkNCj4gIHsNCj4gIAlpbnQgZXJyOw0KPiANCj4gLQllcnIgPSBpY2Vfd3JpdGVfcHRw
X3JlZ19ldGg1NmcoaHcsIHBvcnQsDQo+IFBIWV9SRUdfVFhfT0ZGU0VUX1JFQURZLCAwKTsNCj4g
LQlpZiAoZXJyKQ0KPiAtCQlyZXR1cm4gZXJyOw0KPiAtDQo+ICAJZXJyID0gaWNlX3dyaXRlX3B0
cF9yZWdfZXRoNTZnKGh3LCBwb3J0LA0KPiBQSFlfUkVHX1JYX09GRlNFVF9SRUFEWSwgMCk7DQo+
ICAJaWYgKGVycikNCj4gIAkJcmV0dXJuIGVycjsNCj4gDQo+IC0JaWNlX2RlYnVnKGh3LCBJQ0Vf
REJHX1BUUCwgIkRpc2FibGVkIGNsb2NrIG9uIFBIWSBwb3J0ICV1XG4iLA0KPiBwb3J0KTsNCj4g
KwlpY2VfZGVidWcoaHcsIElDRV9EQkdfUFRQLCAiRGlzYWJsZWQgUnggdGltZXN0YW1wcyBvbiBQ
SFkgcG9ydA0KPiAldVxuIiwNCj4gK3BvcnQpOw0KPiANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4g
QEAgLTIxNTEsNyArMjE1Miw3IEBAIGludCBpY2Vfc3RhcnRfcGh5X3RpbWVyX2V0aDU2ZyhzdHJ1
Y3QgaWNlX2h3DQo+ICpodywgdTggcG9ydCkNCj4gDQo+ICAJdG1yX2lkeCA9IGljZV9nZXRfcHRw
X3NyY19jbG9ja19pbmRleChodyk7DQo+IA0KPiAtCWVyciA9IGljZV9zdG9wX3BoeV90aW1lcl9l
dGg1NmcoaHcsIHBvcnQsIGZhbHNlKTsNCj4gKwllcnIgPSBpY2Vfc3RvcF9waHlfdGltZXJfZXRo
NTZnKGh3LCBwb3J0KTsNCj4gIAlpZiAoZXJyKQ0KPiAgCQlyZXR1cm4gZXJyOw0KPiANCj4gDQo+
IC0tDQo+IDIuNTYuMC5yYzAuMzk1LmdkMWYzNTI0ZTE1ZGMNCg0KUmV2aWV3ZWQtYnk6IEFsZWtz
YW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KDQo=
