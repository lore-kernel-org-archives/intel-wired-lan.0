Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0836606B468
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mA1WiWLs;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=djTaVTQp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE64540611;
	Mon, 26 Oct 2026 10:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1PnzZngVFl9U; Mon, 26 Oct 2026 10:00:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F7D440613
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793008820;
	b=oYOh5Vf4q8X0UGHqtPPlnqSnN39yl/8ZWxYI11mYnw96xFa0Syjdps2BSzZipPzQf+3I
	 clx4yrQRRFW80v3Zxz4RIPBETDNLwtf34lDMp7vxuqg8hoL4vWtpOirqlInH8YQhjMrkU
	 mUQCrMtkm1TDh+PdErMnbxhJJMzqLjMDXQORY/7cAA9SX9mff58EnqQ/ZjBuW5IIOuxOX
	 ePW/rFiOCILnndG8Y4JaE97yZy3rIXJKmFNd0aykIvQYNWpYmFJD9z+fnsYAzNRRrMDW3
	 mm5DwSjT38DdI4+qfLaub9mLzxXF84N3KU1QXWt7WBD87a1ExQJHBU+PLcMV5ObnyKw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793008820;
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
	bh=0onMAL/bJBYa8k1YB3GEb6gWvWEQAsHkIkDcar66tBQ=;
	b=b3PZBplKe4ZCLPLpJXvuETAKzyPOkuNrsc1950Xymc0h43a5xn5LZtcQuy42K1CO4bB3
	 fDmtmethK68bN7r5foHo+5USnXpRonb4GnaGKqfGqfZioI0nzILlOHeRsX5kvWPhOIUhV
	 b9W1gad3eC/zXwwPyIgTTvYyKzGb/0H+x4OsgLT6IV/TPatzczL3mtYxF8+7cKu0AB03W
	 HVEsEen4G53tlhRAyFkkHq60vxFayahhO7TYpDzgfn5hiTr5hJkHGZ0fhwT6Q17tmzoGW
	 /rg65ZwMazSykUoQfc2MSS66UvkTBFrfmhpIWfX+zuYqQTE1PDx8Aw5vxsfN4Fr6pSQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=djTaVTQp;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793008820;
	bh=0onMAL/bJBYa8k1YB3GEb6gWvWEQAsHkIkDcar66tBQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mA1WiWLsVD0zjG6qB2BERvH++PLdKfAhZSlJAIe9HtvJEixQOJm9wmRe2rTq/HCCC
	 jXln49YtZscY5h0vqLeBkzG3ZTcUUGlaXoXrT5+IGHa+JOy2s/FCC1HQeKu2E1OWDv
	 IU4G6GfTZzwZqgmXBDYDJ7Ps/8WDwt5px0PitvFKxc4FrHQ0kEppXpn8/3Hmwg9PBL
	 /0tNXbR39ZFOlCpEAEnb2nxSvFDaAofXIkWfAV7AINCTNfZFC27rA1UsI7PDr2nmN2
	 CjjgoVYJroHylruNkS41nYCD1x9rh1eIsMvgUSw5mc2DYAttgypEYT0AMzTU7jJLyw
	 D32y9T6Smseqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F7D440613;
	Mon, 26 Oct 2026 10:00:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73EBA356
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 10:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A72A405EE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 10:00:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZIuVoP6rgUWe for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 10:00:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9D3E8405CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793008817;
 b=ffdEYf9LbkmPxl5T5KkROlRzG08lsAuLKltUJWaLM/URDrik0OFVVeQJIGObvqg82H8H
 cknZVBh/Yk7cCI2tq3MWTbxkV+14CKrJthDtRF1DLrisPumbwZwA6tuky276FGPOBjspg
 +KXQHBaH2oKccscvnmwkBXzwtXBLA182SzDbKCAcxuX6u5carO1q14/DjBHz9qq735wLy
 gme4dREMANFlo+x2So/MLQkLmiLFC7Np5bmOYbSHufwKXO0vBNUR1+/idmn08VlQ6oNo1
 AJtxPGElXCLniwYrXfKiqd5fn9FvC8q5lFzzq6mUtNAMuMVfqQmk0+T50QwMKVZetVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793008817;
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
 bh=0onMAL/bJBYa8k1YB3GEb6gWvWEQAsHkIkDcar66tBQ=;
 b=bL2E+x6YKgio8zQwFyC0yQi5R2+xcmE5iq/N4vxa83eSKEwypq3ZjH/Ijk54psgCVnQo
 pMlvl4g1HVoQg+OZsLNt2DESS7Qa/twZ7nYGaGNIYkTJFhyLxFf4X67FX3P8N7d0Ibi5S
 zXQuNqsEAKgTU1epLuocqiuZTEmcWjF8XVb073BCgS7pX0zBQ2J/7fQaKxFcRu6yEUD4u
 Vh0mPxiEuFfUdp5ePZNAPSY0jVB3qf4a5/xJXGUedtjIftw0iytwktOAhjXsO7oX0Kgrq
 C3QSjM4SnBfwQaUQzaUo4+vG2F67OsJo1MoxiHnizKPEHQxujrJDRb6l3ElYxfvZKVw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=djTaVTQp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=rafal.romanowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=djTaVTQp
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D3E8405CB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793008818; x=1824544818;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eRSGFS+7E7ABdKaE0l6fZkj2CizMiFXq8loRsOZsM4s=;
 b=djTaVTQpxIwWjmWotPrt7UBgIcMgpznddqSJ27AnklvJ7gBiS+ZIqxCV
 8XQwa37wQk7LIrHMcauNZuqQ57QACF59WCVftynE3qkun6a1fY1U1rvr9
 tn+kkyX744WR58ZNofEtlZvInHw6RreHVvUVAhjF6s1ECihQ5nSOYmTvJ
 bxefdoaaaPL5dBJSiwnTdD5tQH+Yvz/cPMeZw0H5vPYrJGjyzlYxzK42u
 wH/OOSC3PuvSerYjm+sg8l3jaw7qZa6Em+83/TBIN4RCojyWSxSb7QOiN
 MjXQ0LlnvwJy8jG8Xk4634G+ziIHeKu71kX0A7FcQCEh4DMF1pUOAoiK3 Q==;
X-CSE-ConnectionGUID: f20QjcH7QdqDFhXwgxaGfg==
X-CSE-MsgGUID: 0nSrxD25S5+Cqrhsl30Z/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1680522"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1680522"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 03:00:17 -0700
X-CSE-ConnectionGUID: 7BB1+BPmSM+wdu9uzGor5w==
X-CSE-MsgGUID: WP2f9ivMS9WlQ8182kxzqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4169790"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 03:00:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 03:00:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 03:00:16 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 03:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/rfvNOnA1rW7dmHN34mWXciRhNCust8AHciEP5K5vaRoU51JGAdNEQ56PMhf47qq14X6TuODmRoz8Sfm2/Hw1u7sGqp2sGeJ10i0QJ5uHGAB8X9kg0Pe0OYLM+12G+/MRUd+K+pF+p8IUr10WMZDnj9HhsIbUiCLxNw5wRzdG4W8JrEetvzTgrxvFVQUQt1m02UF4wOBXqyT+qEmTgalCUwVp/RzSej6hT19VJU3aTExwZyuqMrDZJV6k/bWYOWGsiKmBUeN/iZgyJvnonw/Z9cUyzmIU5E04PpVJooNeVBUYAbQq2smxnirUe9UC4JSjtIt9ugfBHftMY6yDWU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0onMAL/bJBYa8k1YB3GEb6gWvWEQAsHkIkDcar66tBQ=;
 b=ZoiKHaq5MLeFqGGGrivLQGf00PKNJJVuKFA97YVyVyWHs0CnK+AUt5NaWCO7AOYip2Yt3tEgchveN1IPOpfTppZPe1wtmB0xhVoTacqRQyXqzNxtJXWL8Pk+gSwKb7kUS9bmFm6/TMvV0258MeLDwY9+xdLzZo4SZMGpzilRP9VV2srobapQU+5Qpa3JWL6VCBeZbeUzvrSulnMWLZMBCyEOdo2C17qpvK+BP1Z0ipM4UtP0neUdvquZ5Li08kjhp+WyVyn631/2znCG/H53SUya/fpUE3snxntKq0jSm6Kla+dANm0K1Z+BgZNJIJX0ZpyGMl3BA0Wbv+39BEDgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:00:13 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:00:13 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>
CC: Simon Horman <horms@kernel.org>
Subject: RE: [PATCH iwl-net v3] iavf: fix error path in iavf_request_misc_irq
Thread-Topic: [PATCH iwl-net v3] iavf: fix error path in iavf_request_misc_irq
Thread-Index: AQHdVZ+8di0ueNkKN0ed9QHUSFF0eLcPtkgg
Date: Mon, 26 Oct 2026 10:00:13 +0000
Message-ID: <IA3PR11MB8985155BD4BF6FCFB335D9C38F612@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20261006143227.2879494-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20261006143227.2879494-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DM3PR11MB8734:EE_
x-ms-office365-filtering-correlation-id: 98b1acad-fe2c-43a0-825d-08df3347edbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|6133799003|56012099006|11063799006|261021123027099003|261021121427099003|10067099003|261009223027099003|261022105027099003|38070700021;
x-microsoft-antispam-message-info: 1GOHqOtCDAYVz1B3CR5uinCF/+zUhBNqTGoDX7/CagDThM6vCdsBNpXTDayibtA/K6k8lLFrh6apCV7UjKUxXwXrxs1TMeoCEWDnwV3qfHyMWbrtyiDXmUlSCHuKkgvvba8OzwhGeyY8WDEqzqu3rLO+WneZNoQuL+SsNvok5x+uXVWppEl8n6bulBR53miG2O48Io0Cpz2MB+GPfiJTWLaqZsyNXoM7PXUISYJhPAtVsIJf4JE0YThYZnMLXfNcKflWNSr+wn8fvmWn2oKFTroiyG8WDmnR26k+PwvdNabpsII/KD4kpJD8+bdMW5ZOdiQvbu4iGR6qUUt6lk/AFCM0YrJnJ3DiHugK6ljz2sAGo+oVtenWcvNf0TO905c7TYsiusGEA9LtSIKW92mzi2bfEm06ZPQlUIyUIgX/jenV9/7qqc7xRgxyM7FUd+mZCIl3Q4xNiIWvY22GjSpPXLMMPF/GD+dvY89To3pHuKMLAYxChIZ+gWN3vNRTVUen8ED/C761dphUJvw03gzfiL2jr03PK3Pj2Bam99RCGu2urVt4SgaG/RPEPIjN1STMqfHZlPSdXIxlt1s1PHKBw9ajPllRm8dmXj5RimwUnW6ij/CgBEWsHxee3cy7MBOxkqxNDCTF68sU/o1OXbvX0PGki5OGYP0Uaj4esP2UiEBSsune9Pzxmby6rHXogj/LLQGnPUsVLla4+Z9DreJxV938em2534HxwRQgnvgse8c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gKUNT5sCFM8uq+exGo6HXOZlmEKwcoSVHz+Ekcbdbr2HtsjtaB5V+x9kc6TJ?=
 =?us-ascii?Q?En2ayjMowR8FMl5lNpO9B7rcWEobkDPRDym8k4oeFLJoHabWjpQHUEfLKitM?=
 =?us-ascii?Q?sz2ObInv25Y/xEX4mUrsUbBcg1IHX7o0wrV68ckhPwmhm/M8GVeqk4JEK9+I?=
 =?us-ascii?Q?yc4GDT2FDnDpy+W+z0pLxVUCZZW4so5GanjmUVTdkI2FQ2U8PgLd3NtkYIS6?=
 =?us-ascii?Q?vfyQkQ9ZbeoWDggTDJLWID1QPgmVF3QPKxy6eTKU6cL2px58tMzRUuUsPMyJ?=
 =?us-ascii?Q?wIgmbkybTNaBV+gwR24PXnQlHFVkucHuwCVEnHX9P3a3WWJ/p00dn8PwdJQI?=
 =?us-ascii?Q?n/qstg+Wanf0FCNuefSq++N70FTFyRWA9mcutnWd7y7VdChMPeNwHAzg7HJc?=
 =?us-ascii?Q?V3S4tIi3yFQA5Ll2pwiz0GRNK2v1+3dKFDeE3fKudFkwaaYElBGOC7dowfkT?=
 =?us-ascii?Q?M6F7a6cJ1KqrFViOBQDRlbO99K+Xv6gyJEJ8atgzT8OeWWEG5Wa47R1nMqwD?=
 =?us-ascii?Q?l9lHb/jJzF9Oqviqkr7vvpXIJ0Ogmv322KYmn0J7aQLAa9ieDtCmk0387+bi?=
 =?us-ascii?Q?90q4Km2lh/GNQB7bgGk0Hm7Ixy/a8ZrLK9YTue8KlfVTLfBJBnXnFR6ulq83?=
 =?us-ascii?Q?T4/bmfQvc5E3m6/aqdgkBrtbKs+QqhTRs43ZS8PWwGNoR6LBmA7iefALVN+d?=
 =?us-ascii?Q?w2nV+LAQEjnTsKpF5E3uoD1UDKzPKCE5fPnoPqxkJsvcAUr1oFu7srSw5gj6?=
 =?us-ascii?Q?ObgngrZ5UukxwPsFFY0tdFssJSGuhUGkF7Ss4RRoEckbdTylsvOzpYzPaf37?=
 =?us-ascii?Q?gFgGveR/wLnieD2J5BYlv+93wLtFj7z0+zoX9pYX4IeFaK755avKezgko3TE?=
 =?us-ascii?Q?BrmgjADkLzL7a8jjrSG3OXyIXA1DZZuO4uZPxl2tVV5Js7JWfrhLiakG2yzj?=
 =?us-ascii?Q?G0GPMSbI9SrDBk5oWJcJJaZhP8zD041ga/sm7NlVqAEc4qeuX+C/faK3GcQb?=
 =?us-ascii?Q?T7RC/a6+v++G/K7W1jL8Zab2lRsW4Zze49jfDqQFfh5urTOTD2oSsu5vJrtJ?=
 =?us-ascii?Q?GhUW6I/bdegp6KDzr9l0Yiwwzc1xHGX/P3e6VVbbFDhCUb3xqD+8lBmaPUPa?=
 =?us-ascii?Q?S1mMmGbURIuUxx2lhV2+oVMIMR4UF1J7o4P16k5oe8q6HxtegXimzwQQ/CT5?=
 =?us-ascii?Q?suEW45vDMP0lDsAYn794nnuHDib6lgzOf3HI10pLb/QQs4EXJqglTE9txKnD?=
 =?us-ascii?Q?IHgHW3Z9EkXFnzoia6eMPA79SYqsZQi7Z0MY3UUX/+eyDlhac4wphggxI2CP?=
 =?us-ascii?Q?omNA5Ih20gdjpU78+AQ0AXiIpTHP06ZvwOKkDAy1hyieeqfel6TtLfq3tRT4?=
 =?us-ascii?Q?yfhioK72OD7MxMHNeK//+ptdMlMcGP4XsH/SttFl22cUhPscx1acFSlEnbLK?=
 =?us-ascii?Q?9a0ZzGfFwivrYS9EIc0/eJBLlJzrViXslKVVgH9ovhriN7oZ8aSGoVntW6M7?=
 =?us-ascii?Q?m0Q6/3skA4EHq7dMmGukV4uc6TWmBmrMbK8yjUcFBdCKTMWLUPlEf+XaRotN?=
 =?us-ascii?Q?kt5BDXlnuXLujvJ1kNxT5awoaXDmweGQ99ZuZnP6OFohgQTTzoXilFp4swli?=
 =?us-ascii?Q?UseaKURL/3oN1VGgAP8hMZRAm7pqe9I+Wf8NlQxmvGBJ1Km/jPgCh5PO0mCt?=
 =?us-ascii?Q?twLJxWeg1njqAfSRhPzzaJ45rISMnAIOr+68DMmBBjgB1tjg+j4akGUidcil?=
 =?us-ascii?Q?PxlAAsUA+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pIBbz1hXxnPtueTfyWoK87/NslD5Wk4SEd4jSGYtn7HyA7DFjF18H8NeasKWLMjNC9hWtvbH/SiUyLPxD1RDLnOqlPtiARs4AXo+Pbam9F4xh7rtl33VQqkuX5AYZT3kaHMyXiQPHM4gXK/OWtMGpgiRjuUFHUNe/eI1EojA2BgMbkEPD7I3mAo9PHwytsrKOyoeq8KM4WD6yIf9N6cjro+8UU2veoxpmtwF5GutoZnhJDOmHdmIratSzycdVG39FYTxqrOYGRF9vIg9aUSQdmgBxTqozGujsFknc1Vd6xptCYqeRyNCR49fmy2HOvF7c/rSTdxq9MaO21dMnfyTzg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b1acad-fe2c-43a0-825d-08df3347edbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 10:00:13.3021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqkTRohinAjYdfFAYQS7virdhoja2g30na026TFFngWsZUV3MCKyskMCjJv7SK6LuHP/Xpo5s//Ivz68WRA/D+hD1spO3TUo6ye+5gzYs/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Sent: Tuesday, October 6, 2026 4:32 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Cc: Simon Horman <horms@kernel.org>
> Subject: [PATCH iwl-net v3] iavf: fix error path in iavf_request_misc_irq
>=20
> From: Piotr Gardocki <piotrx.gardocki@intel.com>
>=20
> When request_irq() fails the interrupt vector was not registered for the =
driver.
> Calling free_irq() on a vector that was never successfully requested trig=
gers a
> kernel warning. Drop the erroneous free_irq() call from the error path.
>=20
> Fixes: 5eae00c57f5e ("i40evf: main driver core")
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index dad001a..ab5f5adc 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -587,7 +587,6 @@ static int iavf_request_misc_irq(struct iavf_adapter
> *adapter)
>  		dev_err(&adapter->pdev->dev,
>  			"request_irq for %s failed: %d\n",
>  			adapter->misc_vector_name, err);
> -		free_irq(adapter->msix_entries[0].vector, netdev);
>  	}
>  	return err;
>  }
> --
> 2.52.0

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

