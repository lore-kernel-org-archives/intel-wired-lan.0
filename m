Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C242606A31B
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ex5igX4t;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lLrir397
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 470AC409C0;
	Fri, 23 Oct 2026 14:56:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SsteWWx8X_ob; Fri, 23 Oct 2026 14:56:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9A2FC409A1
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792767379;
	b=MsewHXfWxBU9xJAEOlqPWUA2n8iQiFQEFHa4VNoS4lcxeTPGT8kupmjE5AOl2RaI/Ltt
	 MUr2ZdSgihYwcOoeb4wo5KGcDz31Qv8sUlx8Wtyv8vtVoZCHRMFEMV3QanljlUupGU1Cb
	 5b42IjrUrFtFdAdgo814PX5Uei18ptphYHPcdNFrqP/CVxsVz697jvZ9ccuZ0bndUzcu5
	 bPHkI6415aneqllEDAAYlC+QqHsHjOFcaoYidl87tx7LeoI4e+SwV15HwKmCseDlNTUMl
	 BCRADbULTtUCCdE/1MjuzZYVKisIx8jEZlrinvJ9tRH/6RpkZqN8oz7xKY7hRXjnwWw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792767379;
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
	 x-ld-processed:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EWsxgS9nqbegP1ghhf0C3QWnC7y1d4lDMAKFkp2ysTg=;
	b=LXUxqvSUxEe9zegC9AyofET3kHBS0VdGCNBHhjRG2cnEFiA3yB2z1Z+3SzMpWzDsroYp
	 9BtQHQ7UCwQMr0JJDI40F6HQkmcVBKtlw6bNcwCYhYHBpCg/D7cJcOX1Y07arhnrpidij
	 2KiugPkMIR9rcFNiHkExXR59odNbi2/G5N8N2XUY4D/hvKNciNbnf31vkycDBoEUw2WTc
	 NM20z0HlIjhIkES32k6AJhPQi8BXBMLq+3AKECIobTiPD47SA3DAO5sMywGB32RfkkY+f
	 fEomV1ERA5Tqd13zbHNP0ur94XJFCaalu+vSx/IUoMWr5TICsQbc91sySJpNxlBqpGg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792767379;
	bh=EWsxgS9nqbegP1ghhf0C3QWnC7y1d4lDMAKFkp2ysTg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ex5igX4tiMpPxuFcvQuleoQ7sNdFxgT7Kl4h0SWVXf2biGts+zSipPOWm/NqdElDy
	 VWG23C3If3f9Gmz+ss7Rgjay9hIsDwpwZq4/0VoKEEHk8zwDRh0LXBy9lMfWuw5uEE
	 z8M/BY3jcbhhVg7aSwQErYmpBKDly4T8qnhGSlucxs1MeIDV3RKA/l++xO5TEXQT/8
	 GY9YB64eGLWBFC7EqGLDWTRuPmDJutr46Nu0VQ4q2Zqfh19ZsoOoVM9kDdgTrs5113
	 frwaXlG77WrhctHeRnxUiLsd6beCx0zXmQcDD+upZECYYaJSL4xCxyyz5shfgsUQ/X
	 hWT5Lc5E4O+/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A2FC409A1;
	Fri, 23 Oct 2026 14:56:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ABE373C1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A910E401DF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:56:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rebK2Dml1u-0 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 14:56:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C80A5401D2
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792767378;
 b=GllaZun3uyQWCKF6n9VWjA/Ob9GCoErXwJJdKO2f4y5Xx3LZybZH3JpFF4Qjy0yyk+F4
 eKne2tBvlEGaBLmS1SEYKnc0YQPcQuUalEqvEg9yEqqVwwry2fRkJJj48ay2r/jFn74Cc
 03gdSG8tvWOdGW29fKkLew1if53jVhFFAEQCN6DroiKWNxsKXd3AMukbwo/PVLjXzBKL3
 l0AWi13g/Q7164FFVivlcBALHi3Kh+y9fgXvTC9vVbUu4BjabZ+SDoKtNZOhVyAmrLnMn
 Z6p7VStJLZC8ZSs6I74okEccOZxarUmti0v8l2VDC1lHu/7mDTmAh+2p4noltNloh7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792767378;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ld-processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 bh=EWsxgS9nqbegP1ghhf0C3QWnC7y1d4lDMAKFkp2ysTg=;
 b=OecG/SEEL35UazUHReaKCtWBj/U6ReGArItU/k86upw3ky6+JulJ0AoXAJfbApcpiIHe
 llyOqsBhQaNBkCC6txXz/fZitIu2/RQI04AJmdLgxlltTYI12vBoYn8fzNRP8slMDxBcI
 RECO6MTChajsMTlcZ8kLwxvlAf2VfRwCeJUlxwKsFmKoGk91MahmEIRe0OhlJOavdRQGV
 RiACqNzxlJqLTER90lviP+UIiyMGRTW0oc2sJU3AeFPyGL9tS2nifmhgVL+x/5lYffy6I
 WBipviI5FS5xnCX8/TpE5MMaXKJTatw1yNVlFteSZhOW8hhNqf6MXZsK0IXiMvCBvkw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lLrir397; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lLrir397
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C80A5401D2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792767378; x=1824303378;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CsSd3hcP+2gecS5b42QV4ULGH6sU0NEOiS35fEjfZYY=;
 b=lLrir397+JnXYOLC/tGtROUkmHbmNuLqlG2GJ2JnBST+bnTH5KPkt3RI
 nmvaNvsOBlhAwZF1G6QqoGUBJc7VcSx5HXmmgtmDFWbanz4S2luUmOWGU
 d3aKpEw2diqZRPG9LKK3IrIQIv8hzy2bYZBiWjJHhZjIl/R1CzAcz7dUD
 hjAA1VVX6azCyVse20MGs3wwpVD1ECQKAX3J7rWl4J8VYs4G0ZV37EFU+
 eJc+PCQ9880495lFSdPv4MQkv/Yl6eTeIPpCn8b5wohFIYzKqKj9z+hVD
 NhC6+yHLvomfI7e5X46JEYtu+pr1bgNVZMvxlzdKS/obtnm5Z79qNp1VP g==;
X-CSE-ConnectionGUID: S20/sm1xR4actdgjMj7Yiw==
X-CSE-MsgGUID: nKyzjqa6TKSYAVvnckEXMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1539976"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1539976"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:56:15 -0700
X-CSE-ConnectionGUID: /stg5xbwRraZQkqEf0KvCA==
X-CSE-MsgGUID: TNsgkM3yRnCGwXpnGi0fzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4022392"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 07:56:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:56:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 07:56:14 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:56:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTsGM5CjZj4D48CYNHmoqGj0aSbr7cbsQEc/lCaezZEo9J55IqqvmAyU58E/qEQOFYCWFnUsufvYXU0MyFIz6kgYsBumHAx+nRQtuTH4h2VqetFu4GC98+XDKlUrMIufCsxnzpnTkyX59T/ySmkcvUG8lv0u4DgqG8jsWJzbOseI9c7zmK+pcGq4DqpHO0yHcO4XhT7PXAN4pLC50cXBYp5dFzCYmoupoObVGZrnN1fj1mtVLtW9GqAGyVV7GE3lnjEd03FxoNI0IycCFVxGKs4lNv98SkLOUqO3J9XiQw+KzWI7WIrFy7RMQVKWxZ/9HNmp2oVwTrBzHKdBMOl07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWsxgS9nqbegP1ghhf0C3QWnC7y1d4lDMAKFkp2ysTg=;
 b=r7AxSRfsIVnkV4IgccKoxi1KNmdFhLTTRckIBYH2LAsYXfL9/BL9KPQrH5n2RkoRR2Wn+jMU/ZoGgHUJTvI5wis4EWt00jghgzZvcn1fIbjWesf01V691P6Gz7d8l95x0jI9o8TNtZ4V4GgshLilTiC3sKOVfupzb/alOoGlNRUkjHBPUc9OviWUDNVC4/7+4gNvGPoRh0MDP2EE6T0Riy1Camvy6dpYLueeDmnpDCYP0f024CqEdRcdUwS79iSQXZvelDdd2i0OSiiA5DEWrt3rpap1D+O2Xj7bQcIQjduKgE22XWvxqqsbpoAiaSvWyyupuqTHz/dM3anKQflsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by PH7PR11MB7596.namprd11.prod.outlook.com
 (2603:10b6:510:27e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 14:56:12 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:56:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Ertman, David
 M" <david.m.ertman@intel.com>, Mateusz Palczewski
 <mateusz.palczewski@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafal
 Rogalski" <rafalx.rogalski@intel.com>, Shiraz Saleem
 <shiraz.saleem@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
 <linux-rt-devel@lists.linux.dev>
Subject: RE: [PATCH iwl-net v2 2/5] ice: take tc_mutex before the auxiliary
 device locks in ndo_setup_tc
Thread-Topic: [PATCH iwl-net v2 2/5] ice: take tc_mutex before the auxiliary
 device locks in ndo_setup_tc
Thread-Index: AQHdYryiSdqgh7mdQ0yq5RVAkwKfkbcLN8Kg
Date: Fri, 23 Oct 2026 14:56:11 +0000
Message-ID: <CH3PR11MB566895C68899356150B4AB5CDFE5642@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261023070258.730168-1-poros@redhat.com>
 <20261023070258.730168-3-poros@redhat.com>
In-Reply-To: <20261023070258.730168-3-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|PH7PR11MB7596:EE_
x-ms-office365-filtering-correlation-id: 42b2a4f0-52a7-4a6c-ff6c-08df3115c734
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|4143699003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: seQanzdao5mLfct8VNAGHMp8X2/5kh0SmQGR8xBZGJDw3zTm+m34i6RCgZgTmSdlAkeTWjo0FD/zS3yPZJ2Hhy7r2r7qZPTIKXn52RG7z8SGRDO5YEovcTH3O006jyjdyfnH1Vg3DGl3/u6/eso2Jkpu0Qvzp5D24affshD0izbsDeE4m5H070aSzq1c0/S1HlixC+04RhiFKM3P25lKeLSAIvEr/A6mpPG/V1+tKgbU1MRIBtfxK8V1QzH76aKCiwwrD3Av1y2z/tKtDPJV/w3Q87a0XoofkPf3Kxcnm+4/EM60QzeNv3nsvCLkwmtDQL8Q9X54YaVYgVl6HK2ETpc0L1q7TdzckK2qUASU6IRot8VZozQakO96fztAEN8mjd4hj8D0cNQFt7bC/NTbxsilFJT0UrWnLH2oTN+l7FXNPyG9tRCKuidAilcXb6Jz/OQIktP052hORx5vgS85B592baFr3jobtJ21FX7n3p81tPzVMITHO93JWo7oH1zyoyHb9leUWKeSmQGJ9ZFNQbQW5QYlVlqokeKGK/cS/LZGqUqa0qpnF2XBcWoVfcshKARW7QXJsvoDUITtRbjtSFGhZEq6pAx47gonjY7hlWK1OA/I30jiGMj36DwJVrhv5XKtVi0uBOvkxAQw2eRxw8eA9FADROG1ZbN7ZjRDQtJVWRvgTf6bBlkCa90kBoSgJEIoGKBWvwCrhBpGBWhS7SvIC1RLvjfG2AvkM0fthUA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(4143699003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/0pebS2NFOEZO4j5YM3rk6C0gTh77R2CtFOWMwNvdE95h0Etw93hP5KO59Tt?=
 =?us-ascii?Q?46jn3Oc1TJxxoRBce44tGzm33lQBFQ21XbnvpaNLQXLr8uKs4SjEwNt4r0wG?=
 =?us-ascii?Q?+YE+w3lNF31alV7m2ObYpfVBmK6329A0zLsQvrmO1sFudGAraO/wd+89lUT9?=
 =?us-ascii?Q?kF0WabpehENPqvm2aKTWwvyubkkwEZ/zeXGgAiK8Wn3PD7Fx8+b/APzmscZ8?=
 =?us-ascii?Q?RRWtKTNh6yjcgG2DbxrjCj6nkTBwr+VkdnE7JwwsKYZ7Fya2YW+Ghv5NXIRT?=
 =?us-ascii?Q?8xSI+7dLUjpALguZLhvo3McdkEks610Lwa+ToFL7D6FRt1MErY3iGII3zTXB?=
 =?us-ascii?Q?aRh8r55DV2dEthSYz4lOrl6cBUfb3SUfuKbT2pYi2DXv4xz+WmfJkgi1bUiL?=
 =?us-ascii?Q?+zN1RaStA+chUJKfd6EkA4Vf+HpR8pWm+UN6+MqDQLX5zzwOXUF3jfLhWNdW?=
 =?us-ascii?Q?jsZBKD3sFgOZ8MEvi3NeGK6MBQWFtOZGjFClMJ0xrQIyPrzZW0xrglkCuOyo?=
 =?us-ascii?Q?2iyE7QI0kjuRhfNzR2KnFNw9G1ULT6+LVTm6Z4fpECQjJ7mzKzx/XIEEZj1R?=
 =?us-ascii?Q?msgE156fZLwIiLcCdS1kVvEOyjbsdYLWabgubO6Wy6KVoWOTs854NYWPmFqF?=
 =?us-ascii?Q?LDn9k/2rIG+Cvs/Ljr6kthjRy51llYxfq8eXsj1bNUWaboXmOtVDK6YIbnRx?=
 =?us-ascii?Q?6+jccB0woX6xXNqSxNW4RRnhuG6dZgT/b1Fbu4PQM/ZKEY4rie6GfHQb2Dy7?=
 =?us-ascii?Q?SGW85372XcwfhKDhy1oAno25NEtm5IM9/bQcRdlBmaORYup0T4sy97bs/tYZ?=
 =?us-ascii?Q?YGgxdrg71JYYcMuBK0QCghBvIMZRt12OF9e/CFnQMTXilGiWQrsyeYDrf8SN?=
 =?us-ascii?Q?W/S0P3Q0XNBXfkRhDpOyt2niPACUCkj1Zs/5NY3QY5VI7ElNz4DPeC/ievvb?=
 =?us-ascii?Q?QPYX+Qw+aoV3RTgiFz5fho64leFwAhHmfrtNJks5z4ZrfgUPkNN5B97T2mGE?=
 =?us-ascii?Q?amYcmHClLNLCEgGUviCPRzyfrXlG6rRR3fsz6esCz7CRfFFnBG3h/t5O8f6H?=
 =?us-ascii?Q?u4UxqYtwBqTldh7ur4SUIMOKEV1/nypwQhFOGPw4YubPy737T5XYabkGOBLw?=
 =?us-ascii?Q?vCTp/zsKS3AnZZoqlHpJUFCOlmOSin1WngFdPAhmDxpG1MnL3Lfi3T0UViod?=
 =?us-ascii?Q?QpspVCYdxc2Bws5fcoysO91zAVhH9ogzakLcA+fZRAVX/Afjyc1NMzJzTJv3?=
 =?us-ascii?Q?5XZWQ898NrdHs2nOs/G3zsc2kbbN4HyWjbuTkSDrsfRuptSRB/KmgPw+448x?=
 =?us-ascii?Q?0anpBwQu4tk0xyDZ+pwYrljBtgSORtJ58GEW9v8qoyjOOry4jvdSDHcqnMPz?=
 =?us-ascii?Q?XKMNo603wLhxjyu5usS6ltjfXf7hBaKmQ5fG5IlQzup9BA5n5X3WDmI4IEtt?=
 =?us-ascii?Q?MHHQF2pY1NnGqlo8Yx/D1dZnhPEYVWScnnZ1yRJqZ1JXzmPFsZgjkL3OgJfW?=
 =?us-ascii?Q?X3WHnYECTpj8CUvmc5rs9kWJEmTTF+ryGn/faAFaqHZBRy1NQradyr345K06?=
 =?us-ascii?Q?BECE6XG2aALuhZpgDMTVDzdTHJyVgPjt1/NtDzQp4Hd5W4c+NGqheqGQgYJV?=
 =?us-ascii?Q?4YW6tlY2G4aZ8WE1plBOdNuApOsnHn5iYCcJ3dXCsA43biKH0ah7FPDBOR+H?=
 =?us-ascii?Q?AlZ8U/mmDBJuzmR9Ve1uOZCEChkz1QuT6jgkW0viiqM5qOmhGGhuh6r7Om21?=
 =?us-ascii?Q?gyRk6TmlpFySUOHAa8GwEb15YXWfE9w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Lb/eDYfUI7os6kqAK+dS3g47uIrMK7iWGkFLPeZT+LoiwkwZIQykcHf9sfHTD6KfbCNbB2q1qEqQp1q3Z71Wh6TsCc7wKac2o2YGs2nKVoZ6ua0xdmm8e9H9SED1RlPcdFURx7/D5v1JdMrOwWvfTU4Eht+rLYEpXbtBUDi0j6p2JOMO59rHh0THSoRKnznvze/eSNLfiG+LNJM+CouO26zZ/F8QQYHyx6w940SKyMYVqW1t7qIClSgqQeSHOZaGFQ4hwkleCQFjW4wenk6xzIgYznyiqESgQMyFBlIWFDjiKBN46p1DhzIZQVA8hQl48Ti0AQh3ePO9im80Xy7eXQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b2a4f0-52a7-4a6c-ff6c-08df3115c734
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 14:56:11.5729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOfc9m3LK4AfNwM8JHqGTV9yW1TvsQPbmwoWy7r+P367dCD1eSSNX/RSC1+fVkafYxQFkkl0Th8YTqiz8elnjo7JKIb3CAIEkRQupAASrgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7596
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Petr Oros <poros@redhat.com>
> Sent: Friday, October 23, 2026 9:03 AM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>;
> Clark Williams <clrkwllms@kernel.org>; Steven Rostedt
> <rostedt@goodmis.org>; Ertman, David M <david.m.ertman@intel.com>;
> Mateusz Palczewski <mateusz.palczewski@intel.com>; Leon Romanovsky
> <leon@kernel.org>; Rafal Rogalski <rafalx.rogalski@intel.com>; Shiraz
> Saleem <shiraz.saleem@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; intel-wired-lan@lists.osuosl.org;
> linux-kernel@vger.kernel.org; linux-rt-devel@lists.linux.dev
> Subject: [PATCH iwl-net v2 2/5] ice: take tc_mutex before the auxiliary
> device locks in ndo_setup_tc
>=20
> The mqprio path of ice_setup_tc() takes pf->adev_mutex and the auxiliary
> device lock first and pf->tc_mutex after them. The dcbnl handlers take
> pf->tc_mutex first and reach pf->adev_mutex through ice_pf_dcb_cfg() and
> ice_send_event_to_aux(). Both run with the RTNL lock held, so the two
> orders do not deadlock against each other, but they form a circular
> dependency for lockdep, and the DCB reconfiguration is about to hold
> pf->adev_mutex for longer.
>=20
> Take pf->tc_mutex first, which is the order the dcbnl side has used
> since pf->adev_mutex was introduced.
>=20
> Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v2:
> - new patch, ice_setup_tc() took pf->adev_mutex before pf->tc_mutex
>   while the dcbnl handlers take them the other way round
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 984479f1e1f6d9..8693ca285d5f1e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -9438,6 +9438,8 @@ ice_setup_tc(struct net_device *netdev, enum
> tc_setup_type type,
>  			return -EOPNOTSUPP;
>  		}
>=20
> +		mutex_lock(&pf->tc_mutex);
> +
>  		cdev =3D pf->cdev_info;
>  		if (cdev) {
>  			mutex_lock(&pf->adev_mutex);
> @@ -9456,15 +9458,14 @@ ice_setup_tc(struct net_device *netdev, enum
> tc_setup_type type,
>  		}
>=20
>  		/* setup traffic classifier for receive side */
> -		mutex_lock(&pf->tc_mutex);
>  		err =3D ice_setup_tc_mqprio_qdisc(netdev, type_data);
> -		mutex_unlock(&pf->tc_mutex);
>=20
>  adev_unlock:
>  		if (locked) {
>  			device_unlock(&adev->dev);
>  			mutex_unlock(&pf->adev_mutex);
>  		}
> +		mutex_unlock(&pf->tc_mutex);
>  		return err;
>  	case TC_SETUP_QDISC_ETF:
>  		return ice_offload_txtime(netdev, type_data);
> --
> 2.56.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
