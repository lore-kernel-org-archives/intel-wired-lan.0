Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F99C88E77
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 06:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4756980C98;
	Wed, 16 Sep 2026 06:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbmUxhMN0g2g; Wed, 16 Sep 2026 06:01:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6314580C0D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789538486;
	b=gkWwpJeqPhGti4vEDodT9RjQTQYC/oebbzmJKMMxBjLUVPftDk0gpBZ4hXyVRd2OsD9f
	 4qNoeKEKxDC0Ut+3rX4JvQBVYnfboQWqa3OrqnakiXjew6vXUPMf0AtitSLVRPiUKM5Co
	 ahN+BJKDZLmlAaIXo1VFXFeSGVrGUJXcUzMv9SkDRWyJ9Wd6gYYefXBBuFsGO8E6TR8sE
	 /sqRvUtWQFpa/dDA7GIaMFBCc6Sq3gytX7eIcSD1hW30PeA9BOfoziNBrTgtslngSBF6e
	 3zhqMQbItuWHXzb4/F1io5GMrNHrJROqZrCYyPDcWo8EV1dS7khDPg3G55I/Vat4AgA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789538486;
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
	bh=AWK0cSEFzO+fzerMdms1pkwuUjPQyG0Jbn0ttYmaWbc=;
	b=bIAqJndPgTHfXM7oTz8Wu+96VWfFNSXhbe1m5v8eJ+p27gAn9n1UHLEJQpJBnUuxWikE
	 BKxdc8MUV6lfjwLYpRRDAYremBOdX+tTX5MzZvWYrOj10LNZEO0okYtchN3CyK/eMcivF
	 2aZTOUdnaehUcmXshN7Yt1tCRruhcSi9wZVrX2iGZASrgxg5xPH2DKmulJ6FL6uqoI7FX
	 c9SuKdoFedZI3tprW0SV6eFtbXg0+MZX+sEoKwl1+n563LunaNgey0BSEKBsQ71i2kcPn
	 gQNbXGYTvbeIk5aR8a+aVz8lr4CLz/CmR7UWexL+IE31JbhUtgwbY2FZ8k2XK5W9Hgw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789538486;
	bh=AWK0cSEFzO+fzerMdms1pkwuUjPQyG0Jbn0ttYmaWbc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oUlcEJ4GiQPlr3yYcSSyun5yhebUKkRhbqVnNBwO18A2Smvv7YpSDl3l2iFwZkbeS
	 j0Ct7M1Ca7EAqmWVkke8zzqFJ+O4qK+dzHppnFeiDe4u08TXfmDAHG7v8c3dWGIKFN
	 j2kC90UjT2+l91s7Zr7gjdLFO2mPPJg3c8rvwYkCTHHeS7Mt7nHa0myyUISg1n6qfk
	 2LUDcbh/sqGPGdmoJ9X/mrZtb0+fM9StAWFRO/33OjTB21SFC3+XN14yg+PGOX9PYA
	 JRytmO2N98WfX+vLpxg0YuaYS2v//8KdYnHHol0eeZoYWVNdnWr8dvQh5RKZwk81vI
	 6PXLYiwOHRypg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6314580C0D;
	Wed, 16 Sep 2026 06:01:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 35D923AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 06:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27BF84009C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 06:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BfCVqIvOtjeq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 06:01:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C1AAB40076
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789538484;
 b=XdWRZHfgj93rDsYx4eFSASpeCAOssOa2dKDyAqyEBVNvOLeew/Ul39UcFNf8YRYRPiwx
 wKCKjoColmUKtMS43iDXhaNoPZ+p4fk/WbqlnLePOKWjTGxmGsAEpQ2v7Wzrsz+V+KvAs
 GLGqMc9mogIxhXReEtsHesElvkh5y67/5keemuz3+ccjwlBIFHGQ51hyJzHQa+nR5ynqJ
 TKR2ZcQXF/Gw8DRuM7jfE09rx18GWEi6mIeg+JjOmQ6C/bcidRt/04iDn8rc5hAhGi3yc
 rBsVDXfreUWKyR7SZJhkHWEUo1hweOZSi1ddkCIKd7LGFgjjFgBASZBI2oGihU2Chsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789538484;
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
 bh=AWK0cSEFzO+fzerMdms1pkwuUjPQyG0Jbn0ttYmaWbc=;
 b=iwg4g0CJuqU5gL21PuzMglVKo8XGBLW2zciFlAITmJjXF1w3jkyOccVAZQu4wn0ZVFmv
 uYfqOQGzoMvw6YnGIK/plPOcpFbhSPhnRkh4KlYjmBL9VI/2pnyiV1A4Hviqw5Exb+Qjb
 n+rDA8UFOTmlA5QSzKrDxTlrSRwmzkslF56mP27uyj4OndxnA1C3VZkXKZa5XYIbKjaOQ
 3ZB1/nKYqHRkqkmiVGq5497NdZQyqJUaY/0NWEfSScLMyyVHDbgEfJ04lomBHP3c7zrcs
 UIWV05630lPruS0wyp09lbxBEdFe8Dg4h/w/Iw5t/2cBRcN9JFN/LcXRcs1jmAkJdvw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AA7zizCm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AA7zizCm
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C1AAB40076
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 06:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789538483; x=1821074483;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3IKJpTdx3PseRJHaNc8yFXD7onLNqkO/yGnZwpB40f4=;
 b=AA7zizCmL4HH+o3m4BKiIZWq4wptVAxzd1Z8g6K5XFvYeNG8DTGhZemR
 hxabKxl19s1znsksnPL/I7DBZVZGhiQpyGIEKI/dZJPcJwrPiOkbGRqRX
 nRojTQ3vMZBNfKChKSF8umBJVcwMa3f37uec3OOF/Gc5NyLN1E5ZQ0x6g
 bF2i9jl96mXH1En2aCj5SEYXioYQUD3sqIPiBeiTUGzCnbzXIZTZ5K8Lk
 OxjTyC+hp2KM+7rKZOl4Meit0kQX33GMUymLKUZ6tlpqCBJN9xqZ3Wa6a
 bBXLmfClxvrC7u/dB1BbdISi2EpbkZnE2t40h0JqgU18ZoxAFMmyEWGNn Q==;
X-CSE-ConnectionGUID: DWSYYE+uQEa54JwQWHFQHg==
X-CSE-MsgGUID: MVuSBuWWT3myxUQH8YyLew==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100232997"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100232997"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 23:01:22 -0700
X-CSE-ConnectionGUID: vuQ8RMkXQg6YUBMDFz6M/g==
X-CSE-MsgGUID: uoZPbq+MRdqtUWHOCdcf2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="273203392"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 23:01:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:01:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 23:01:22 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:01:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdGOoYJ/djTaHvPW+kOvW3DY2L+SdmE+Txn8+KgmbIs7TmfJspBuDYvNSsUkTQ9gRojJyFrCHZW156ZrYCBfGnH43eGzpDsmW7HCE8dYeSSZeVtl8/ODnsW1USAK++Zmm/Nm+0BcYihZjak1yPL8Au8d+ZqK4YqR/rrGovsk27tg5AbMg7gB5C6DEIMlreoq8qLCUc7XbUbR+n3nhLFSO5Fi95+cv8VFB0pgTR48TQbxQKXbcQA8UnH/yDhVoqkZ2YyanSimr0ulzysZQLe7Oxi6mEg/pgjB6WN/Gd3ZNdEArws5+g7E+w9kCaM/Uv1mnWQirlC9vJaqLqr0P+dvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWK0cSEFzO+fzerMdms1pkwuUjPQyG0Jbn0ttYmaWbc=;
 b=KdGSAvETbCjbx4+g1oiv8OplWdKSzAMSlqyONFxDiyOW9PbFQOhEznWFoLNidetr5t1e0TKmmSgrObkdY4+AySi+BZM8St9VyCXhaQET3+cOBPtG5A1FKQXBgrQ27TzUsO/zLZRbiluUma5/8zN89rdwNAzHzuPWEHhVnCLhyHlg3DU09czuyTwGSBoJp1rSeeg7vP7notcA0XQSwkxo5U3eU1m7Sx2hyvRRvpmnwU+dgJqxFmMJt86OAwpJlDmNyL00leAvebNEvRtxOe9+RN8h9H1k+Yrc/sHiP0gwYqqKtzI3S4HPs0bapDFotFIrcHvYcGT7v8OHB4DWw1cblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 06:01:12 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 06:01:12 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Filip Balluch <fballuch@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] e1000e: rename init/exit module functions to avoid
 confusion with e1000
Thread-Topic: [PATCH] e1000e: rename init/exit module functions to avoid
 confusion with e1000
Thread-Index: AQHdRTY8RYCLhD0Qa0GBNooIjq+rSrbQtwcg
Date: Wed, 16 Sep 2026 06:01:12 +0000
Message-ID: <IA3PR11MB898663C59013D40EDCD7A386E5B92@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260915122639.64936-1-fballuch@redhat.com>
In-Reply-To: <20260915122639.64936-1-fballuch@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7948:EE_
x-ms-office365-filtering-correlation-id: 9c8887db-531f-4f98-924c-08df13b7e97d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: /9QK/93ZuDyQCu5xA5De/kTWSd8Jow+9NDQNBEdZNHSyupULDQT3K8ceq6hdZA1pGCstM2k/EoNlw14GeJohdtu7Isfcpr3dsNVf4wODwoxqTk/s/bn+1oy4/u+/ShyX3O+kdt4CPjDsC+bSzh6FNi9DjF62OCu/xV+gBqalbsEoCfQHqdfVmj2B2ZXCWVxAiEnc1y80E5y8XKvvO75BdBhvDoBvkFsrlt1/4aUDeUeg3JBNM8l3h2URBJL4xYKxCh0TCjIb7ujI+W+ZgO9c3BIUBL7PamjkpcGjFb0lSPb7BC0Nb/mBRhVvfQkqsBzAiIz2Ljdl+mMi7BrnmsObUlkY9OVG2Xl0MVK+oZR3dL7R1vPpQ2n8ytBqCwG9NQOG3UE4eSQFBa0TVjFMbu5xMae05UBp/0U/WsaSao7AhZGQxn1LB1bPGhv3rt8b6cBXB4CPGPrVbrempp/6AWS2FfSmDJedJKzbxh9ZXntMsojCcSLJ8BdLikGJtq2udiyPc1a4HuvByn6XakLjXd804inIXTcAgDL0FPzhvbzT27sfupoPEQoHp8MnWHLfyZSchOnINDgT8ObZyN2ntwPZvMl0qS8/ibNmSeW97xrPDGf/v92pkJdF/NydhY+aR1IPdgL6ob6q8m3PI66XuYIMu3qICrFDETGd7+FCXwLFgTtZb3+D07vUP+oAomkjIkd1icU9VboZOyDiaOlHUt7FRsciLXW5SDxYJY2LPopB5mk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cX+XJYm2vxs73oc3CcobHrNHO55EvqiSH6Lg2or8hAZrAaJ//LgupSCTqRte?=
 =?us-ascii?Q?hrTSpgWUS+V8+sfiNUax00ax7GkKG2unLm5lMzJkvt7oeVVfAHZ4sTXsCCf4?=
 =?us-ascii?Q?c8+h8nHZPcg8Ht7KI0NlucMVG6dD2rlshhH/1vx+VpUbtqAdsb5dUNVbUlNr?=
 =?us-ascii?Q?m+qLEvz5f1J12/i2xoA8Qd6hd71krhTtIW0bEzvSSNbYH+P/Nuln8zM04xUW?=
 =?us-ascii?Q?AkT90SPfY47qGt23mAtEivVgHpDQf/EEJBH6XmTTIAF4bHJQwYlbsxtjy+Zx?=
 =?us-ascii?Q?M3UVdANOEo9CMAbvYXBWa1aE+4cDNNOyNJp/ADw2vrIkxC2TaA69NcQYV8Uh?=
 =?us-ascii?Q?H3DfpXUWRt3jc+GGr96bTiX+mc+Gnr3jziAsh+1FNd+GoO4qAm5nf0XbmpyN?=
 =?us-ascii?Q?SLcwO/jWmO05yNiK1fBbCZofrItH+EAKmYh66tHb0g8yUU7o9CEI8k4Btkvx?=
 =?us-ascii?Q?Uvk3M9sqg2rQCHwkjOwNqYu2gB7qzHFUpSs09P5RSughPgyibZFCb7ktiZ3a?=
 =?us-ascii?Q?YOw4PDQ5mHnvU88XjQEbq6HCrldzUv2jXDQEMMadSyJMlR5C3glqHGOFn4cU?=
 =?us-ascii?Q?UXqkelV4XIvm1ZBCPUe3Q1+jG2hflxpk5/Z6ob87trRC2rpXAUBoz7AurzVe?=
 =?us-ascii?Q?xz8XrL5KRB1uA6LxA3RlMpuj+tTo9haHThWo2no80K1zTKh5EELhBcAHIt+z?=
 =?us-ascii?Q?tzJ04rwImWNjovtedBeivBnQ7FW9KkjJzJTkvT2te5sItRDsjcgc2C85aTI6?=
 =?us-ascii?Q?SCxrCaeOooNHRh/nOtZnH5B2Fwn/0oszYuIDOT7zMBlnZM3+9moAvkw9I++O?=
 =?us-ascii?Q?Qv7GrUaoPUCIMRkVsORa55TxZmyS+4WOXXtNTmPESFVed3sYS6O1/hCfBIwl?=
 =?us-ascii?Q?/XBToI+skhRoZGye3V9wn0ag+tbxTRXBYyjKVcRWL3C2Z1b2iXMEhS40pl/9?=
 =?us-ascii?Q?OPfrDJS2EWegE1qqSyQo4FCeb4LWSFH1NwyRTWCxawsCkftcbV3snPz9SmoA?=
 =?us-ascii?Q?aNpLVg35e+KNTbxNONU4jcxIg+mKpT6GSHUlB0//kgyzTRWdJBjQ72a874aY?=
 =?us-ascii?Q?ypD/H3NvTdmxMTicrurvCDsQEQXjInKtbukiPr9YSpyVGv0lqasn4+jjA7aA?=
 =?us-ascii?Q?gfdlLhWVwQyhpLYIQ16LzBmXE8MzylKtuxuyGhvBaKKr02dlDUer/o1fgsWz?=
 =?us-ascii?Q?1DfmarO6fKwDkkhJiGWNS9pWyySnAeTBVhy6i96vrNXjbjjqJXjanCUhcZji?=
 =?us-ascii?Q?8LFsAj3OwZjsuCipF2seTZV51W3LmdfaJ1mcfjgCPdg5Lhxo+AwQCoqZxmWd?=
 =?us-ascii?Q?LvbFW5Tdpa3HLOZI8rz5WPC0FiGYrSfBudthmf7wKaWCzWrelJgdkhayv9ug?=
 =?us-ascii?Q?GVg1VKD1U+Opvq9BsMafdwP8zRdCNbWH1eT/kc7MPUPZjyOlQxzmwqSXvDAD?=
 =?us-ascii?Q?/6rkhaO+YeQFqIpCtSEkuWebjygOuHSKFPgAIUzwKsUMYCM+BaIr/BXsWM5x?=
 =?us-ascii?Q?tEWQooXWlFJGZvifjV4+X9F7cTu4X2oN1fhgnnG9Wygf5jisr1y2AjF3zQbg?=
 =?us-ascii?Q?kEUhOqtvvSfcndFMd6srkoVuD5jqUXpcaXOTeF+NEtg+eHksBAPZsWUN/AP3?=
 =?us-ascii?Q?OYJbXK57rsoBrKCWRFoJz/27KpS9FH++EKhk3+mh3PaSCl/Ey4oR8RcMamT0?=
 =?us-ascii?Q?yiG4snKyKNaNZxTd3e92ahflE01IVFfNZNST5WbCAigqv1m7vL1HxfWVlipb?=
 =?us-ascii?Q?qyJhlmrEjU03AHBOHYMZqzDQeIDtQo0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZhJ9VatvU6mKy/WDDABDbzlJfzuOH+8QBQq2WYZvqn1O0N8JV+3wvPwlnRJdKVZc7HWZqo2xmjIx8UOQcyC5KXxQs36H/QKqeKns9bc76b9mb7gF00J//r7i51uJndW4eMufKIhWNVz2hl3N06LwnHf70kd9rOUtTxIEEOGOybSqUStZXIohqv8+t8R/WCiFZ3tB9hLve6owu5QN0br1H5Ui58ipcBk3yzgkPa4Atz5aVgF0nrlcN1/upbpUYlm8c3tRN2MwBZXzd0rm1uNzHTs6BjmKhzZkXCKThwVMv7uCKdNZoSLPQI1BX1HeXkIVLNCl2t4ExgK03a7E1OU2xA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8887db-531f-4f98-924c-08df13b7e97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 06:01:12.7011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0tD8FGMibjAmk6Km3f1ddBe9KHGhOHJHzSJlyVtK1LB6JzASVf4Y6O5ifm32FZye2Ek1DbVQhMNZ3RC6qjTxVLah/0oGXWre/beSMmyOIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
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
> From: Filip Balluch <fballuch@redhat.com>
> Sent: Tuesday, September 15, 2026 2:27 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Filip Balluch
> <fballuch@redhat.com>
> Subject: [PATCH] e1000e: rename init/exit module functions to avoid
> confusion with e1000
>=20
> The e1000e driver uses e1000_init_module and e1000_exit_module as its
> module init/exit function names, which are identical to those used by
> the older e1000 driver. Rename them to e1000e_init_module and
> e1000e_exit_module to clearly distinguish e1000e from the legacy e1000
> driver.
>=20
> Signed-off-by: Filip Balluch <fballuch@redhat.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad..2a4cf75bce34 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -8203,31 +8203,31 @@ static struct pci_driver e1000_driver =3D {  };
>=20
>  /**
> - * e1000_init_module - Driver Registration Routine
> + * e1000e_init_module - Driver Registration Routine
>   *
> - * e1000_init_module is the first routine called when the driver is
> + * e1000e_init_module is the first routine called when the driver is
>   * loaded. All it does is register with the PCI subsystem.
>   **/
> -static int __init e1000_init_module(void)
> +static int __init e1000e_init_module(void)
>  {
>  	pr_info("Intel(R) PRO/1000 Network Driver\n");
>  	pr_info("Copyright(c) 1999 - 2015 Intel Corporation.\n");
>=20
>  	return pci_register_driver(&e1000_driver);
>  }
> -module_init(e1000_init_module);
> +module_init(e1000e_init_module);
>=20
>  /**
> - * e1000_exit_module - Driver Exit Cleanup Routine
> + * e1000e_exit_module - Driver Exit Cleanup Routine
>   *
> - * e1000_exit_module is called just before the driver is removed
> + * e1000e_exit_module is called just before the driver is removed
>   * from memory.
>   **/
> -static void __exit e1000_exit_module(void)
> +static void __exit e1000e_exit_module(void)
>  {
>  	pci_unregister_driver(&e1000_driver);
>  }
> -module_exit(e1000_exit_module);
> +module_exit(e1000e_exit_module);
>=20
>  MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
> MODULE_LICENSE("GPL v2");
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
