Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4127BC79F82
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 13:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BF5E40587;
	Tue,  8 Sep 2026 13:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ykslnmOz4yMc; Tue,  8 Sep 2026 13:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 247114058B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788873402;
	b=aXVYWYO776D8HgDATuAgb6UCUpOx77eHIQisGv2oNW4SczFnZCL1qOUKjpY4eTRa2GbG
	 fKPr/yeaWTsOF8ReZzBuTLEJbvThBm7ISPBkZAoscDYDkIBumNgj+dov5QSGhxD+e57Qq
	 FgnQ5nS7XqLWPG91R9QobnnrlqYOcJo0enj3mSwrCF5diiOIRQRS+EGFHD1znDXXEw7Bz
	 cNhsi5fuVU0tRiEnq6nIIFZ3B4yBvLa1cNfWs0+kshvIo/4JgVoQ/yCNpkIxN/3fL5Eed
	 l04QbGYRGjSCBwbBr5VguvETnG69//Vl22i94QqSEEiQDK7GK0kw2DnqwE9kIZ3XXCA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788873402;
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
	bh=WE1gut0p3Pfai+NkRlQEij9k55p/rDEOqsoyglLWb04=;
	b=X5Eufw0V7nBUD7KoT8ulgoQAM2XtAfzxbyBP5Lljh/SpTaGJ6Siqn+NrXnvdd8k6iVVv
	 mU++q6BVZ96vVrjWgxSzdJyxD5hM99d51VS0LMNE8px4/sfFFv98w7AH6OvFy4xsVEObW
	 e160MVuxxefxQeLzQ1LiJtEnHVoU3UZaRJPPaG5d9UUFRv8EJhTzJDEksKpcZ9hmYk4ku
	 NAn2LO0OzMWcWx69rZGb5AzYS/PCJYz7tDGW//DGOfreJwSncr7mV+I5mBSfiat4Morbn
	 UOp395b4l3QSi3+nPVc82uxt6+uxAtkwbR6U64oeLi6Hv4Vt59iM6I54ofxi1zpDkqQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788873402;
	bh=WE1gut0p3Pfai+NkRlQEij9k55p/rDEOqsoyglLWb04=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gUtBXBdIvM4fQ92uko3+WJ9lDBfYKou+yAlVEacAjKYbf5y5OyWsyct3N/qv39Vp/
	 d9enNG25V+/TudTDxMJHljt7h0mPSek1ugReI3nQMU58MUpdJMpy5iQ3ZG1FVxXMgd
	 a92GpHs4JxWMPDSwxBJN62a6+vJuS20iOfgL1dnt1/YP+0g39JnXO8lRWzgP94FvLC
	 pRfSp4NawMoXzD/m70WYm/fLbklXgbEMGgqVZaQZsj0T+0hl5AMqJKurWt4fdOrqkE
	 ZWAxxEfrEG60BNBH4fJSL2gCkwrGTiFC4OCYK2OA5g/rpAijsc7SccZKmGnbjI5T0I
	 NVEH7mYynUTzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 247114058B;
	Tue,  8 Sep 2026 13:16:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 96515D5F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C4B580AC8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hogUx00HW9Bd for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 13:16:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 578DB80883
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788873400;
 b=MZ5AQcxaWC/b4EtlfcQsebVPc1LOD8OItjLHk4zNBmOTRxoSrtOb5dWSzmu8LhRVu+hQ
 izmBrH5U6ks/PRy2NABVIzFFLMRKUbnLXpHSvpISPKJFHrMa4gGjhVub3P83TRiqKs+eq
 9qZNBnS91LanurT44Sd5vMCJBzAgBQbCdHqcH4mnbJ2Ujw+SSnfc+G4avkf6GEonFMYCJ
 ObrzovVB8QX2qur//N2ifhH/eJW4KRYl9WRP+agwsmyKkfIMFvEc55q/smNT4ZOAl0nZb
 ii8Te7IMhepqWBZb+sOaEljiGhf1KcA3ssAybPoP+wcaDjc625adTs1eejbP/Ayd5uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788873400;
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
 bh=WE1gut0p3Pfai+NkRlQEij9k55p/rDEOqsoyglLWb04=;
 b=L4KGMsijjC5UAKoeKm1PNmw6iLxr8CtBE90GfKbuLQES2NMVu6pEryWIOI4b3Vp75JC1
 PTYJKGJfuIP/K5/8jT+MSn0gRbNzSJcOFjeLim5IpSJUMARUDGwUns6E3d2fubd2VcoDG
 Qo7YtRxz94p27yDaWAQ8Po7854up1rckJVZnhqvjuFjebdJr5GzfIt4pj2WrAcuIoByOt
 ynUDCv2DnTmmPZMa1N18h22cHIOpCkqgNcHXFDJVda+FcVzUGgMWBk5jYhs+ODJm3z2OA
 X07f0E/Fc7HaW0vwYi4ZFhm8l79nAkCiae/VUBq1LlNVORgwa207EOq5qCNLyvk3Ckg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RJMKk+xG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RJMKk+xG
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 578DB80883
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788873400; x=1820409400;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=j05DfXJLDpWMypbYHTX9ycHhP68GAHURVYbcEAfRwZw=;
 b=RJMKk+xGLCFbJflIkySpL8WtUWap3dm6GIJztunCYp+uYAmi3xRClAJp
 NeEWNt/6ZXUAThviWYgycK2aLH8qthKfDvcBO8I/NDf8hVCW0+K38K/S/
 2cOGS6ZTVxcQPCkJFDQBV/Y7zGeRZiPy2xR6MKMbDVcm3W1I2mFViOuWZ
 5qpcZQ7OqeAp+siMRfWoBFDLOdQxN4h8suUKNw5Ve2CRU2oeMCjuxHwyK
 w+6LGNZmRcYVG3Df1cqA8tGb0rS8Bwiffw8kuKg2aNmdB8X/7M3qF98H3
 3HnhaAupOLIPHS4tcmRdWyJPQ+/f8L0/dIaIpIpH9nr1NkYvT1XN1bdDZ A==;
X-CSE-ConnectionGUID: ZXfEJ/pVRhiK1SkYSsgHLw==
X-CSE-MsgGUID: ILeztWSaRYqmDgtIytUobw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="93094899"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="93094899"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:16:33 -0700
X-CSE-ConnectionGUID: 89BlxcEZTW+TlYBLbBEQiQ==
X-CSE-MsgGUID: jvO3v8YjSnOGpjQZUnEfkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="270510895"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:16:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:16:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:16:32 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:16:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTs3SyQqnrfRMoEdL4NFvVtsK01u1xMAoP1VY/orfxhie69Zfn18fhsmP516Cx05Lp7idsTmJYxYHAinzN2kqLasmbiSs65x6Q1wzy0kRnqKNSrGieKtK9CfO56ECaQCK0XEJONJ+O32Z22CBsX0cqO2UooUh9QdNXA+rR7FUS3aGrKmnO1/HuhtSilYO431cps0uAMRk4FOZIt7rE6YdK7XaJ1jt9u4G1LQf/nmUkEsFY1vdOh5l4iRvewiK9/8lCE7nA6vDUL2Q7q0GjbLn2y7Vpgui6bKDD0wuy6oXbzpf2axvGPfrysjWb7y056Mr03XxMKkGxibTJ1cBA10uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE1gut0p3Pfai+NkRlQEij9k55p/rDEOqsoyglLWb04=;
 b=jvDANpIIt5qSib30Zp15EhMwFY7SVmXmNZx//tjrfzwAllsBsF16S/z4DW6wp8vkGPkKK570ssbzPDThzOs3k6X8xFAY0bvx96hkMU87E6v4uVUlTM2RI1qwGn7OLMrChZzKuuf/GbnzmTLuXTBfv5HxPDWxaFB1S2T4VUiHrcVp2YCGfJhcpgMsyHwZRd8kv+V8wATFDJFEO7BQGRvZ2d8yLca8hKpS0ieDzWiH8VCqC4W0VSSPlmEpAYj2fb9IzZbX+6coCoaDSgzUWAidfGSD3jvq3s5HP1F/IZ4zL8AbMI7xWkPTR26jnS8xt4t83veS2IR2fHbKbANEIsxRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA4PR11MB9297.namprd11.prod.outlook.com (2603:10b6:208:56f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:16:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:16:29 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "pavankumaryalagada@gmail.com" <pavankumaryalagada@gmail.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "skhan@linuxfoundation.org"
 <skhan@linuxfoundation.org>,
 "syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com"
 <syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com>, "kohei@enjuk.jp"
 <kohei@enjuk.jp>
Subject: RE: [PATCH iwl-next v4] e100: prevent shift-out-of-bounds in EEPROM
 access
Thread-Topic: [PATCH iwl-next v4] e100: prevent shift-out-of-bounds in EEPROM
 access
Thread-Index: AQHdMIgKx4BmWwjwjkmRGTY12qpnhbbEx2dQ
Date: Tue, 8 Sep 2026 13:16:29 +0000
Message-ID: <IA3PR11MB8986C8A760B37E94352670C8E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260820094045.41400-1-pavankumaryalagada@gmail.com>
In-Reply-To: <20260820094045.41400-1-pavankumaryalagada@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA4PR11MB9297:EE_
x-ms-office365-filtering-correlation-id: 7ca79403-3846-4e27-6245-08df0dab6526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|13003099007|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: rVRXdzyq63Hl7j2zEEo4ER8i882WcbNL2avoml+BoiG54lq7m7NZhG5DW+1QvWiaSy0dVyJBf2/9A6iwQb4NSVT7nQVtsgQsaE3X/isoGlW4cqYE93gSDBPc/H91dDfYKf9Y3eH8N36OrlYB2m91KZEEK2/crY+yQwuHqvntylWEdXVMidTWGDDID6WQGDGFzt3G0oKAoMXOfuvgsSRnMbjVw9OtrHhTbSOLTFrxZMld1k7OtQYDmFAOAt115pkeoAthp9vcmY+nZ4FUIdYfnvT2UQ8aFI7+XU/M79hkmcHDlCgFcJ22aO1ULhPynKVX9PQmuu7t14eUFNgSORWqEUCupQaDom6L8W/EOdkXADwZpBhoO/s20yWXk5ZqGottq4HVvKmEzK2XnczrZ0CJoYZfv8pTy2ajJVU1CfqT3IEu6TzCh9fQzSlSCrLpMJByP09krQ9Q6fwxlDkKojkxXBhQx4hwwJuF2YDyx+V9ewMvFECXwXjf2xI8Q3/ReIQjqkciCLtcYqZcvJnsZB2bWmeVECKT+LySDGGDNEp754ot6WDwAohL3Rs0/oQ6DmnbWRD014OipwwfkD59GQTcWT9FCcXoQDuKdYmroELo5eG6N2YMnR50duc00tYnWzb/6iXEFhNFBO2g7fIg5Zi1o4/3iZ813ULXkQ5bIJdn9oU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(13003099007)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uu1/eehXS3QSTkhn97YwwYydnEDpugwQ7aRD32GOATgoEBoJSo2fXvyG/DC5?=
 =?us-ascii?Q?Z533dkKGTysNFy/yA+N/jqw8473l7u7Vu33JPfHuIWf0HtKObHY8bCP0UtZA?=
 =?us-ascii?Q?STJF5XMAkFDTFA+fERTaj5uQHWgI+rDQAfgh4Z0FSAwTJsFMbbztB3UQPC5d?=
 =?us-ascii?Q?OBAiiVYpOJtM1d5O/+NKEG7+6S5v66PposL01acYklLY0HnflVXlw+XvJjwf?=
 =?us-ascii?Q?fmUD0Z9tHli685KMpqH3r6sXU1eWgCtJ5K/wpfERNSLKlv2mXx2vi3y5XrLU?=
 =?us-ascii?Q?qSkKxAjBMJeBG7yO7OL+bqgn9Qyc/EfSRo8yYsMLgHFKk5OXCIjjXiO2672L?=
 =?us-ascii?Q?d92wn7T1Ufsykz8K680zeTFPGweqaPYR09vH5HBaNw9yopIzTdjLuxUd/HNf?=
 =?us-ascii?Q?E2Q29C7S3S7cGaHqxj0wjayNCTYBG4hMd8i8NguFtfy/L5o62JmF5/PIOsWa?=
 =?us-ascii?Q?5uajJtTwYxhCFyjmSpllEehuZ/aVwJqlaKfO9nfr00G52kgZ1m+mD3CxnzC7?=
 =?us-ascii?Q?g7CMy7DhC41c8QBkzGj5Uky9XIo+ySjffi/OUBQANI9VCRUOIyqDaWnlTUTs?=
 =?us-ascii?Q?ZuixIdeSGrtQRAtqp1yAKkzoTOuPemwSu1nlnbKGP92coBqix05sLRYuv+ok?=
 =?us-ascii?Q?G6ibHvp5QLwFeNQtbAPQg+gyL0tAJFFHflGWn6yn1uK51hCizfsXDXF228XP?=
 =?us-ascii?Q?koj8hZe1cnLwvyzOqZZDq1rPy4DT60sS3xUToB4TbJsSC9Bi9dco8zWXcY1K?=
 =?us-ascii?Q?BQTA8bgzLHZpOeT2A3oZTJ8dojecrNLgGAEC/GwyrznC3zOmuvvk4+C/Xo2p?=
 =?us-ascii?Q?RCeDIA74PT/KG7Do9IwA+P6fz6tTozIMyY6+e6InBUVfRd3SLLzWnB7V9Qpu?=
 =?us-ascii?Q?Jnj0Tz2FUGeXXcjCA3Y9hCF2XnTt7YOzc6B9Qrp5bOBrFuGqC4yW/5P0fjFY?=
 =?us-ascii?Q?3xxHH554riA1X1EYIfjB6OphFnQACTTGUMRXRcowfpGVFOM32/Ie/TMHkJNe?=
 =?us-ascii?Q?1UKDlg8SzpVXyGhaG7UDmyL9n9HKrICP9F1MwCcatEUSpM/0C4/9/wfppYaI?=
 =?us-ascii?Q?CTml7lSBGbgzeNaNJ1eXn6Phkyi/12vLYCdmz03/XhzJLvhNd85XUo9vokvA?=
 =?us-ascii?Q?SGEi4px3eGREi5SdXNJtpias59PSovrxVK5ardyObK0hMZe1daNQN2ICVxwC?=
 =?us-ascii?Q?Tt3d2mXTjxsvH4f5+4AE0G8F7JhBAVDtgmfZxy/uk8zytaBpsVCovxcBaFZL?=
 =?us-ascii?Q?zCCbHJ2o166qQ5FM3hIuT6RBRDIPsPttzqhFjYh+AhX48BQYY4dd41LeOAGQ?=
 =?us-ascii?Q?mBgRPHPiE4vIm6qf9A5iSVFsUGUMFTeTpTYFZMj9QGo9sQW9iJhz08I3ktQ2?=
 =?us-ascii?Q?PhXmSdSJdQeGmCgysTHL0yCPinIqrDw7eY8Wz1D/iQc/fPQ87uWiFd8t22uq?=
 =?us-ascii?Q?xXir0RP7svx285s40oxKHbR+bzXrruUSLVy4n+2whtcuymmmpzr60xy07+Na?=
 =?us-ascii?Q?gok9DGjgQdF3xifGgIkrN00+oLXSLcZOQmpDdJ/HPn/uRTJra5N/mqJ4SCHF?=
 =?us-ascii?Q?vJBCjqAUnR9UHa1xeD3AKYB9UwSCRNTrS+hPn0x1ZCDJCc5sTylA735S1KO9?=
 =?us-ascii?Q?ZaR6FpSzUD9qsNJ/i2ew/kgWgfot46stWvJUW2W3/9GQI0qk8Sxv2/TQ8tMH?=
 =?us-ascii?Q?NQSWnOQVv281bbrDYECkQdimmsO39RtG57QfXyluEseayv/J92LAoozCbrX4?=
 =?us-ascii?Q?IBW1FNvzOrDdXcrXwDqaBtBowyMJUQk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WivQphf2ctASkMOvKEVUBP90pyZsO7FLqh7A1MZnMQYusc5Qu5LrlK5Fsvw823uo9RO6FIMM35EEelZijV/29HP0K0v+HBi0ayCy3s5VKOQRZKjs1baUTQuPYjPJQrQ/635XgkCpVoXcdA05DaR7tmVc3svkfdUfTRLhQA6bCV1jcIeoVS/8YjZJjIx2DxvYq7DGac5NBnc2EMNn9LMRaldYhtYJKp7MefAXu5VVzMuRUUNRQLWbsNoA6dO2sPjQ5wWtVjFbXqFnQO9AUFPGc6MBb8jVMaOo0bN37EcEL6zTBp+SjK/hcr+rf1KKAVS8tF7LITfxU0Qu7KFJMNy9yw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca79403-3846-4e27-6245-08df0dab6526
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:16:29.7233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btLIeaYj99o2Xb0J2enINnavhRIx63hF1fa1s61hvu04XR9DuNQp7ZfXhD9C0JU524FdGxaGdTSQjy/ec/kkO5LrGR2Qbt9sjSCoxEXuqSM=
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
> From: pavankumaryalagada@gmail.com <pavankumaryalagada@gmail.com>
> Sent: Thursday, August 20, 2026 11:41 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; skhan@linuxfoundation.org;
> syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com; kohei@enjuk.jp;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Yalagada Pavan
> Kumar <pavankumaryalagada@gmail.com>
> Subject: [PATCH iwl-next v4] e100: prevent shift-out-of-bounds in
> EEPROM access
>=20
> From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
>=20
> When reading the EEPROM address length, e100_eeprom_read() can return
> an invalid length. This value is then used as a shift count when
> calculating eeprom_wc, resulting in a shift-out-of-bounds UBSAN
> warning.
>=20
> Stop EEPROM address probing if the detected address length exceeds the
> initial address length to prevent addr_len from underflowing.
>=20
> Validate addr_len after reading it from the EEPROM in both
> e100_eeprom_load() and e100_eeprom_save(), and return -EIO if the
> value is zero or greater than 8.
>=20
> Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De0abb1d45ac291ebebeb
> Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> ---
>=20
> v4:
>  - Squash the v1-v3 changes into a single standalone patch.
>  - Prevent addr_len underflow during EEPROM probing.
>  - Validate addr_len in e100_eeprom_load() and e100_eeprom_save().
>  - Use BIT() and cast the result to u16 for eeprom_wc.
>  - Target iwl-next as requested by Tony Nguyen.
>=20
> v3: https://lore.kernel.org/all/20260816113754.22900-1-
> pavankumaryalagada@gmail.com/T/
>=20
> v2: https://lore.kernel.org/all/20260810083355.21631-1-
> pavankumaryalagada@gmail.com/T/
>=20
> v1: https://lore.kernel.org/all/20260807145626.52692-1-
> pavankumaryalagada@gmail.com/T/
> ---
>  drivers/net/ethernet/intel/e100.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e100.c
> b/drivers/net/ethernet/intel/e100.c
> index 29960762e64a..cd8190386652 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -744,7 +744,14 @@ static __le16 e100_eeprom_read(struct nic *nic,
> u16 *addr_len, u16 addr)
>  		 * complete address.  Use this to adjust addr_len. */
>  		ctrl =3D ioread8(&nic->csr->eeprom_ctrl_lo);
>  		if (!(ctrl & eedo) && i > 16) {
> -			*addr_len -=3D (i - 16);
> +			u16 len =3D i - 16;
> +
> +			if (len > *addr_len) {
> +				*addr_len =3D 0;
> +				break;
> +			}
> +
> +			*addr_len -=3D len;
>  			i =3D 17;
>  		}
>=20
> @@ -765,7 +772,15 @@ static int e100_eeprom_load(struct nic *nic)
>=20
>  	/* Try reading with an 8-bit addr len to discover actual addr
> len */
>  	e100_eeprom_read(nic, &addr_len, 0);
> -	nic->eeprom_wc =3D 1 << addr_len;
> +
> +	if (!addr_len || addr_len > 8) {
> +		netif_err(nic, probe, nic->netdev,
> +			  "Invalid EEPROM address length %u\n",
> +			  addr_len);
> +		return -EIO;
> +	}
> +
> +	nic->eeprom_wc =3D (u16)BIT(addr_len);
>=20
>  	for (addr =3D 0; addr < nic->eeprom_wc; addr++) {
>  		nic->eeprom[addr] =3D e100_eeprom_read(nic, &addr_len,
> addr); @@ -791,7 +806,15 @@ static int e100_eeprom_save(struct nic
> *nic, u16 start, u16 count)
>=20
>  	/* Try reading with an 8-bit addr len to discover actual addr
> len */
>  	e100_eeprom_read(nic, &addr_len, 0);
> -	nic->eeprom_wc =3D 1 << addr_len;
> +
> +	if (!addr_len || addr_len > 8) {
> +		netif_err(nic, probe, nic->netdev,
> +			  "Invalid EEPROM address length %u\n",
> +			  addr_len);
> +		return -EIO;
> +	}
> +
> +	nic->eeprom_wc =3D (u16)BIT(addr_len);
>=20
>  	if (start + count >=3D nic->eeprom_wc)
>  		return -EINVAL;
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

