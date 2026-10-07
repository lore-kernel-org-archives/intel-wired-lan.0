Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAA9CA5FFF
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 09:15:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FE1B605B0;
	Wed,  7 Oct 2026 09:15:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UJSVn9jgmENp; Wed,  7 Oct 2026 09:15:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CE9BB6068A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791364539;
	b=cjGWYTgS0Az/whlmZNOuaasV3d3HpH9xBuODMF0RXrE4/VuiplA4C63w4ZqRc5efZuTl
	 zu25Yc8jgCU8KDxjl6rv0KLsCCedILfXJcE4pSaFaXfoEMRX+5OK8o3IUh0ZscuJL4R52
	 6NkXMYpYIJ+Lt/nMX2rta5jqUvIzVWuAW944BZiJf9F61EBzYzONL7QKnVvRW6MkGInmQ
	 WnmwN6niONE9JET2z8mkZE2/TVju501IEpJ1DgcmbP/R9Bxa7APWnFDGQLv3Tht6Rr5sI
	 WBAY0BATVL+3FQCIgqDlvbHz0ZimzXzRSodvyBGs9ETlQH0ugXOVNXm7M39ENpnVnXw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791364539;
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
	bh=4TR5e4WyvxYH/q1CQPorXKLzc96gNM/hdO9QbIeTpAE=;
	b=XqTuUhhk1MtXM4Zh4E6T88CZRI5ZLMZNslXahsTmj75RPusbi5vsz6GZvGu6i9hByh7m
	 Ytk22qCo2SML1B3/AhPwkemFqabqmD3/JxDfmv0ZFWGr0OHuy+nTjOiHHS1CpL+UAZTDB
	 Vq42p1nGrEF7VPNmnKbjtITZTP2uafA4+xbZojK/VGizt/ANJTrHNBYnXc+5G9ViOSb/O
	 vcZ4TuaDEGJFigczCUabJljXXr3Mpbvy+VBTmkJ7Ex0vrHPWFEJVpEAT3UIgYoKv+NnHp
	 8y5ZBeuytQ9jNgy03YXvaHUf0g0M4qpsMcAsNw9ia9atUbU1BFA0qQK5IgWPj8KDFkg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="NDc0R/pB";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791364539;
	bh=4TR5e4WyvxYH/q1CQPorXKLzc96gNM/hdO9QbIeTpAE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pTd1/PIKykT/VDL45nKN39mfwe718vCbM2HdsGA+R4St87LpZW6ZP5zxwpxWYBwhC
	 LLvCpD43XJDN+GwJDsBLiDhmis0CbPShWDVbdQOKuyM3qifRRuhjSsy4zeKK87v5rh
	 p0gun4nmSo6dn8Ue+q5p5Gzew/ame45WSsX5VZ51IO3JgkXsEHfc9PNgniv9NIc7Yn
	 7R3bk9FTHhxNLlLFCy89Gj4+VupqWNJjbQqK/Boh0tjC2RoxpQjcHhyqHemX6XKPUr
	 jmjoXAqqmqwvAgUQwFd7Ty9GDSZNHvrKxTT2MCAZnVP1E7OayLV5OMkdT6ctALbiIm
	 8uL7VIPPUWZ/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE9BB6068A;
	Wed,  7 Oct 2026 09:15:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 617BC1D2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 09:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 527A5606A6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 09:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kKslsW0i_QnJ for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 09:06:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 06D0460685
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791364002;
 b=reOqUN3VlMiBdcNPEQazTpqlc1ykgbTl4tMo9XP+67PzUqeL4FoYqKqNc4yBpxd1hSV/
 62CYUUVRA2zs9GJ1q7Bl+n7SR12N9tbtAKYY+38E44HEpj/EKJr5GG736muJLuIt1f/eQ
 nN5B783ZfdcJEadrNtmfA3yFzzv/1xl3x7tEVSeh3W0u7OGJaWwc9W1VJ+zRr3dFL4Etd
 QO3oVNtcxyNY+y/TQYmxtGW36EXbXJs09bRMBlbdfZLn77EWq70hqAjjDpVTjUg9pOSHZ
 uQf8gugYOLdvym90IyIuz4chi9PTcX7qtOnZ1k+tgbkUOksRRWvyrRof/i1u18DVIGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791364002;
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
 bh=4TR5e4WyvxYH/q1CQPorXKLzc96gNM/hdO9QbIeTpAE=;
 b=ePAe0nyhntj+/Tg1y8ZBfn+jlsSoXzkGjh6sifTYReDr6oQKt6e1n+PBcqcs9/8Pyy8L
 uhkdS1nrerLqrCKUt2B9JXAgU+vdwanbgtPVOvs2z68ojTKwPZpzUZcbMAMCkuD23TtdQ
 pDhYdDPnAAS6CWejjxKWaP5CNNNDQsUWjtcSz5j3IbK8fbw5FV29AZ0EKA/vuVS/NJDdr
 Eb5/Z8A9kus0xcY9hORMcMvNn/aWocFxHfRtWR0dd/7Fvp+zDLYb8AL28/Gr989X15tdd
 ohyAx6unOLNmRaHCwVb28rsLsIX6acJxrZbE5LP9v5tdV7mQEqwpgcwEJ7ElSenTPAA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="NDc0R/pB"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=jakub.andrysiak@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NDc0R/pB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06D0460685
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 09:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791364003; x=1822900003;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zHJY5VhU47KuUPssxa4/nSH7Of0PSyBszGtmthJSbk8=;
 b=NDc0R/pB7eQZNfFPTySyVd7tP/pKb5qTbRg1sDVRHwQxE7PUxCultpbL
 f76n9r209BPOFJsYfpHad/5y1rOEGezmJ3IayOvLxwTSivYjhidtBUay3
 e+F6tsArJ2OyXBaLX03JRRsZfGM7vKCLUah5WyRV/tNajm4MytzoTZLCz
 SGWW3cXbbZbhxypwYlytCzuG0H18+ObSPnK/wOHYha0+wAcVCYKEOYk1a
 PVaNmlUEYRaud1i/nEJ+7ChJqoxnQh7jLlu5ftJ9GeGhPYHulSBkmKM0/
 laIh++LGfa9gd3Yzfxk6CGZ0qmhHv1JsY8mL9W1rAsMeWzpfuVZQo9Qeq w==;
X-CSE-ConnectionGUID: yH79RobvQTa70wR7kRIPqw==
X-CSE-MsgGUID: hRND0XL/QtaahpDTALKs/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="17368"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="17368"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 02:06:41 -0700
X-CSE-ConnectionGUID: BpRDzFGGQI+WOaZcsQXlJQ==
X-CSE-MsgGUID: rKqZNP9TRludl9qFickQTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="315418634"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 02:06:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 02:06:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 02:06:39 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 02:06:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3O0XoqOn1/dzDMq5yILRGKyF22Fpi6G4a+Q8GP2xiRZuaGnu9CMzJOrPM/6mpN2L+Ou6f9sd2ja8kRLDmC41XOIQdGwJRGqIo0IZCSgFmCwaAQVpK2tf45XTbBBNj+t4/yOPwzI2q89ZVCuR/+xx9gTJytmKkPY2QYPJ1DIDR4Ve1fiwZtGrsuWVEqJp7QX3HqX9QGfHrgbMZrcZxgmdVOHwQ72odnKNFuN5yStDXPg9goXsSyUR9SfGcZMjzEtYlu/yNDTU0ELRPbArywJ+IafgxvbVour8Vdkn0I9IkJuzkP+nRjKDH3eLymfXDq32MhCPuu1ehpfwuEklV3ifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TR5e4WyvxYH/q1CQPorXKLzc96gNM/hdO9QbIeTpAE=;
 b=ZxjIPSvpM5EzLej0jwX+r8C1SqTPjZGuCGe0+CNpypRgzTwg6XJeAavHZhOfmtfyFSQqcpbawIJ4m5g33jYxTc3O1fF+1qaWLmpCf9ZUf9AUJOG+p/V/J07xUxU07tEHZ3uN3Ob7ns/rgoL9WJz9f7oZ1SvCtnhTJ19MBE8BcQ2jzPeKeXcrHasPfAveAqUzFy/XHnPIf9RDufcpZc81kMm0bDB0PxPQE5vDRPOpsfd4hEQPAzgHQXzDg/mCpQVdAv218erJzxMCK6Snfc5HOJrE8S+w+NJCZT6c5NOTCnwRbW5yLBaqLN99dQsfEaI7WBdzMVrTO7yr5fQNVureEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8562.namprd11.prod.outlook.com (2603:10b6:610:1b8::13)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 09:06:35 +0000
Received: from CH3PR11MB8562.namprd11.prod.outlook.com
 ([fe80::ea76:e083:b8bf:7484]) by CH3PR11MB8562.namprd11.prod.outlook.com
 ([fe80::ea76:e083:b8bf:7484%5]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 09:06:35 +0000
From: "Andrysiak, Jakub" <jakub.andrysiak@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
 <xiaolinkui@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH] i40e: fix NULL pointer dereference in
 i40e_lan_del_device()
Thread-Topic: [Intel-wired-lan] [PATCH] i40e: fix NULL pointer dereference in
 i40e_lan_del_device()
Thread-Index: AQHdRQDPEfE85s1+D0iZMiuwHhDK8bbx69Vw
Date: Wed, 7 Oct 2026 09:06:35 +0000
Message-ID: <CH3PR11MB856293C2FFD2F4BC38B81316E6942@CH3PR11MB8562.namprd11.prod.outlook.com>
References: <20260915105447.574951-1-xiaolinkui@126.com>
In-Reply-To: <20260915105447.574951-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8562:EE_|PH7PR11MB6474:EE_
x-ms-office365-filtering-correlation-id: 6728aa4c-e336-4395-0024-08df245249f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|7416014|1800799024|18002099003|22082099003|10067099003|921020|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: ePW7qZ02g7Ss9pNf5cUaKwwS9rbfg+3Ub28xg90uBetYMx4DmIQL1c+5XrJSYyHhAbk/uipUIBBpjEpuopb+OO1uE9W7S/hnq3xbmYMNNMKMquNdA1L2/wwbNVa+aBtmOjND9i3GnEgxzULTIAjt9XJQUQp3L4ON3O1sqpnvsYWeV6R0B63n0eSYtzNiJDHVXRPCqHeQWreaEjUUPTzWcKgbtI32+9YJG8ceo+0aUkQ6CKkXPuk8ryocObPI9H2cuVnSmvGVWdfveHzsSJvJdTnLUQK3ei/0RRTgYvdF5clnJdItYuiC6FkRXbSOY3RY6Ra/176uNoy7o1SAwRqeB3ejT2MIZMmKdcpFSN70riaDn5DcZNwJnyAZNHO1esRnr0BfJdtzZG4avSLNXEcYdlOvHwGtWO9gDOch1nQX+P6lXmzQSIy0rXfEDzBbGyDwPSZOtg+Bo6qwor5KklGYP86wMbHyc0BGL/Ky4nLal/QP4ui9dxiZfZI7K+OjmflDUWb7YG+8CoQKfQj8iJDkQ+TabPSroDo0Np1gTUdp1AOfz+D1z+NtiyGP8712ZwRWFTcEvaUur35nMeonRypKz3cGEUVSruc3KOlI6u5Yag0+xczUdPXRxaxszclr3a+LhLakul/ASjGyRjwkaY+nNwsvzHvgtGjUMv5vA4XqEYqAqt/W5MFN6BqIseGOxg0IaC0Dz4znL11Aufb9Izl0gkJJcIbYZUaXeFuZ9rvHS28=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8562.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(18002099003)(22082099003)(10067099003)(921020)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qa6ZmjrTrnibhpC3tKxU8OfZxy35VSwZ/DtayDM2SYlLxQK33hydXvVpTj1v?=
 =?us-ascii?Q?EIsTnu7Z4Fn/pGRzQnFMgpmNJoadzUNGv8iZ4Q/9BjZ/inAfDJIQJ0VHSCAe?=
 =?us-ascii?Q?MWFdaKYdeNoB0ZkQyNoMBgKyXbytuAsrg3lL/DSkmlyT/Vn2QrSL9kC1KxW/?=
 =?us-ascii?Q?cMILXvMb477TmcWf9Fcc47OVLVgdGYhQ8Q82/qVAFOw3DQryMTz3HMZHo6Ik?=
 =?us-ascii?Q?QcJioYasatdBQnXbhAUOpLPgEeghPxUWSSgGWJsgHLOHHT2/xksk2+jOLoh2?=
 =?us-ascii?Q?pJKvVwoB4IKAg5edcQ2jjGfUtaJL/cTNVWcsCH23hbvPpy7AyFO7byFyc+wj?=
 =?us-ascii?Q?BBsm7BNCPR+nspMPqFPK/YQV9oKA4wwA9LgXKG3vIsCUu+WNyxKnJnnxFc/l?=
 =?us-ascii?Q?WbLZTNWRUSJEW2TJdLJ+lPZADqAfAZmKx0PfFjhOAjLjWC7emxgc7MFxDmzA?=
 =?us-ascii?Q?jUHj0rjnLYPiE+W+Cu+Y7h0bN4th/48w/hn1ViVQ8nkxPJtNileED/WjAxjC?=
 =?us-ascii?Q?xUXH5wLNWUtlkY1AoosRIy73PMpRz7Ux7gZw3kfgXwsbLYVUFN9w4wULFv4a?=
 =?us-ascii?Q?OysK9ng77B7T+kZ9aKr17B/YegUAZz0KTB4MVyiQSlsKti4jrRo7hHWl1ylX?=
 =?us-ascii?Q?fzFQf3rOfMOFBRdNEMPgJ2Nlp41ZHH6d/foBM/B32lGZe50NZ1WMgFIxFBGz?=
 =?us-ascii?Q?/ytF2/oPpN7Bn1tO9fMrlI5E+UkpXg/7LdZOPieuZfQXg91zNEgG3hawgoHa?=
 =?us-ascii?Q?GqGhLd9VTH8rAUEl6p9bkPxOQA3lN8gBEVSqnIzi1GsDQ/SMpLwD6+FCyv8J?=
 =?us-ascii?Q?w45BVKeuLeT4BqYQV3UFu+L3Qnzf/kFSFHkWRsnuEb5nSg7ywxwUCgQRqSx0?=
 =?us-ascii?Q?fzpzbNI1Rva3xwzVE8H6sq7b3yFmKM8V+YJIoXKEFpmAkeAIG9Ilni6uKqNW?=
 =?us-ascii?Q?ghzRvNWM7sd8WshdM5hshBRDJn7RzaR7bIwotr7L8vJ7zdBlwSYxCVFNYVV3?=
 =?us-ascii?Q?5oGYh8h6XPQe29FsF6usHSFor2J3FwHpDT53Sf7FYJpe45FFSsLAg8cnM/9Z?=
 =?us-ascii?Q?q/1IMtTpQ5wW2Ph+qyyMvaxp5AClJWImcbgSYSL0Rf/Ygv0eAD6Qeji2ITeh?=
 =?us-ascii?Q?JsDpKRdb3ZE+c3hY7RFbgDDs+iZ6zyFcUTdTKj987mjzSprurK8Y3nKd7UFm?=
 =?us-ascii?Q?EeOcl5v0zgUDf12v3nUjczG3SebY47aZPs5D64bkpum0rGnkStnpfzIBKFaG?=
 =?us-ascii?Q?qL/jST1GjlcKWGQshcEh45Z+TMNbgIpQXZQlD0hVFlM0gQG14FBbOBInSDB8?=
 =?us-ascii?Q?/FBgMBGK5tOxPO9iP0QmgqD6OS87MYAqyGh98f3SyFekgX/YbFX0NvDN63Nk?=
 =?us-ascii?Q?YmP03OUL0uAtNHE8/Eka5SKTpvIBW6fOmue2svC1dfpX+uZnYl826fo0YS0h?=
 =?us-ascii?Q?+/VmzpTUiWCTmB7GnLV9Y7bt8h+l3V8stHHX8kFPpnP28URcq9tiknRuPoj/?=
 =?us-ascii?Q?fwClqO5znLel9VOAW5Zx9aV78JvPq4lojNNKMUX+48waBAKhLLeT3LkGnHOk?=
 =?us-ascii?Q?7x7n3qddZTWCFprRT0krXk17QL2h4F3vaweYXntwuX0bLor+vVKp+7R1654m?=
 =?us-ascii?Q?ZeERxgJeUgjCmQA6TkZLKVj+5uDtjGzBW/57LkG558jcRSxBekgJlqrFCyj5?=
 =?us-ascii?Q?ZsI3hID0l66mrhYjjdp7Fr2EoSPG4fD57yztn2ppIefgkaNjFF6rxfAir0UN?=
 =?us-ascii?Q?zf2dDQszhA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cNH6mWW5ZjzeYF2Z39mesIZIb3Erbs11hJ3l0U99mLiH+uECQ8I+ZGxAeh5x7UUPXfnPpUpdKJlMzOGFqRPNOVnPWhkKMfdisjsIo+y3ESIOOuzQxZ+EUEM5CY7rrMspGUHKCeTcp1BJNtPzKlhDCSHSyDeXf2OAjyIRa2BwsvDOGESWJMBK5TxUAdue20893LrDDBGcz1dsbKZUYv7oGbZK77UzTulLicbzT/SsJ7XFKVVT6CYvahanpqKN5Q4hX+IqcwPTi3UvwuVhdRSITIJmcksci2n3DOpM5P3r0y5C3TJ8iN2qwcWrLiPNsO+sQo8+gETUBtS4oHN4QRZgeQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8562.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6728aa4c-e336-4395-0024-08df245249f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 09:06:35.6249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuisBjpb7XG12rMON7mxuQ61C30EpesTfGAXtJ9XgfeatoGcYVpEGz6Xft3cdZGPHQHdPFhSotPQE+T4LZEn3xsjPbKzglxN/Pp5RuoNrus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
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
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Tuesday, September 15, 2026 12:55 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH] i40e: fix NULL pointer dereference in
> i40e_lan_del_device()
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> i40e_lan_del_device() dereferences pf->cinst unconditionally. pf->cinst i=
s only
> assigned by i40e_client_add_instance(), which resets it to NULL whenever =
the
> i40e_client_instance allocation, i40e_client_get_params() or
> i40e_register_auxiliary_dev() fails, and it returns void so
> i40e_lan_add_device() cannot report any of that to its caller.
>=20
> i40e_lan_add_device() can also fail before it ever gets there, for exampl=
e when
> the i40e_device allocation fails, and i40e_probe() only prints a message
> instead of clearing I40E_FLAG_IWARP_ENA. i40e_remove() therefore still ca=
lls
> i40e_lan_del_device() and dereferences a NULL
> pf->cinst.
>=20
> Only tear the auxiliary device down when an instance was actually created=
.
> Removing the PF from the i40e_devices list below does not depend on it.
>=20
> Fixes: f4370a85d62e ("i40e: Register auxiliary devices to provide RDMA")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c
> b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 84a97ca8a6d8..9a4f50af5347 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -496,15 +496,22 @@ int i40e_lan_add_device(struct i40e_pf *pf)
>   **/
>  int i40e_lan_del_device(struct i40e_pf *pf)  {
> -	struct auxiliary_device *aux_dev =3D pf->cinst->lan_info.aux_dev;
> +	struct auxiliary_device *aux_dev;
>  	struct i40e_device *ldev, *tmp;
>  	int ret =3D -ENODEV;
>=20
> -	auxiliary_device_delete(aux_dev);
> -	auxiliary_device_uninit(aux_dev);
> +	/* i40e_client_add_instance() leaves pf->cinst NULL when it fails,
> +	 * so there may be no auxiliary device to tear down here.
> +	 */
> +	if (pf->cinst) {
> +		aux_dev =3D pf->cinst->lan_info.aux_dev;
>=20
> -	/* First, remove any client instance. */
> -	i40e_client_del_instance(pf);
> +		auxiliary_device_delete(aux_dev);
> +		auxiliary_device_uninit(aux_dev);
> +
> +		/* First, remove any client instance. */
> +		i40e_client_del_instance(pf);
> +	}
>=20
>  	mutex_lock(&i40e_device_mutex);
>  	list_for_each_entry_safe(ldev, tmp, &i40e_devices, list) {
> --
> 2.25.1


Tested-by: Jakub Andrysiak <jakub.andrysiak@intel.com>

