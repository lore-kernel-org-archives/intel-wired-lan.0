Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C35606A31E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=SU+P8K21;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ETgZUKDV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B02C040AD7;
	Fri, 27 Nov 2026 18:22:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2iFI0kv0K8hP; Fri, 27 Nov 2026 18:22:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A54440AD9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795803730;
	b=MYj7reCvQyUNwFuDUdydyvcpMQebfcAyUjD6bi7ObleUhQJeNIjhmttqv7IfHcAY4o5y
	 o7feoG44VCd3/+pZV4WggKmwghRq60JSf8QnbT+a6kEBOrhKBIQAwIBF8fWo5kGWtPQgs
	 3EuDgz+zMf3yXf6kzrKP8xInd8yZg3yEv97CNpI+GWs+3mEcaRuvSvzjRNB9/mCQv7dzO
	 1B3vA5RUjnSEhzusggvnzTZyEhphYiMcjSoStDvDeA2YG3P/mLInVj6uJwxrbsz+nEfRC
	 ScdIvO1djFLlspr4Nlmn9snzynY29j3i7ZMLlqQN0npmWGqPeY9JY9GtnH+DsDymjWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795803730;
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
	bh=iXDsUyGroTC8jZ+JLsrl+wbIOh6cpp39U8Sd9iVsMds=;
	b=JaRRzLPUbZ9Fa1RhpL5I3dKjpHcC/dZdGo0YdeyljNmsJ32qPZbzXySWzCTAWSEfFKEe
	 PnFnGhIEYy0yZYU9Q2xlh4lekfarxwAny/cP7FRXQs6c0hu23PcmkMm/Sze9R0Fki7ZL6
	 t/LFJzv/gBwLemlK+feW1ZCUKOs7rxYlQw04p0BCh0thyMTFv5pXIv8mvhzXFjlCvWJME
	 ozTnflroVlBvw2XTF8e0sMT4+1CXWvxeP4dTNr+Ae1lmECp3suPbpqR0abeA56U3fxjM2
	 glQExgYCYTKbnxwrZYzlmPk2aL4ayGqOhTOdEwD7FNULuJab1/ntJqWQgxda/pWGxYQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795803730;
	bh=iXDsUyGroTC8jZ+JLsrl+wbIOh6cpp39U8Sd9iVsMds=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SU+P8K21oa3aioSmRvKuc0DsTTYZN3+ErH6MKNoNAslEs/Geb1I4T59kt2+iSNQif
	 jIwTurQ8ZY6hNpTeqdiblsh4+iPlAD1r+n8jdUuLizNgSD0B64Oav3BdWrgkhxXz1C
	 CUPIgic+YoNcod2b4RD9ltuewzByanEtB/AhwBg1XeINVtFCtCiKEvbYAsSh9L3aBh
	 b7CILKPfyEQyVwXAzll+zQPxPcYSc9hmuf4vfWZkfDdINjZwtHqN3wrMGJeJWQn3PV
	 WgtEIQv6UyauFM5OojoQlVrnef+BboIXvzGdRMMb2fihsPhnBO/xZJlX5THiulAGuP
	 v5saI7BgoMUmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A54440AD9;
	Fri, 27 Nov 2026 18:22:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E742CD13
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 18:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6E22812CD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 18:22:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rrqWlVO2PQqH for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 18:22:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2ABE812CB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ETgZUKDV
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2ABE812CB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795803728; x=1827339728;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=z0kqtXhlBPXT7FAzhHK3I3GELF8gTP/HB6Lvynp79Q0=;
 b=ETgZUKDVpy4pa7obdnqIrmKBvl3WLKbB52wPJMdVAUNKFMcBsXgT/eqg
 2TTKpP7R4F/rILkWJIlQ7met0FQLhJCFAEr4ra2xSx0gObAqhTTKuUVnJ
 F4zvqvFWk8xaJy7NLcLNv7+RaIHvS57rSECErc+aue2I/9OeWQbfVmD5v
 hu1fLa2YSlbkB4vpw0A0W8vZKqnsqmO3d1Q5plTto5Pizt9ak+thEz9vq
 AFQVsOKjfOD4R/o1JZ9gNwF6T4vSxqY1X6FWnEDnltGYxbpgt7o3y+oBU
 Y1WZcd1eLtG8xRKZ+7MlsrmrhrdxRfdTQnMmqKaavx9YE5M8W3trJqbeF A==;
X-CSE-ConnectionGUID: XYMXGvZyQJSr9BzZiTmDhg==
X-CSE-MsgGUID: looRUuJCS2izOZg+9Cyq6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4611630"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4611630"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:22:06 -0800
X-CSE-ConnectionGUID: QrzdrlZOSNSo58HgVAjUEA==
X-CSE-MsgGUID: ano+BZ9ZS8SCdDfj7obIxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12601080"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:22:06 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:22:05 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 10:22:05 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:22:05 -0800
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SA1PR11MB6944.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 18:22:02 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%3]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 18:22:02 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH linux-firmware] ice: update DDP package to 1.3.59.0
Thread-Topic: [PATCH linux-firmware] ice: update DDP package to 1.3.59.0
Thread-Index: AQHdfo9blcEvhaqs4kKZVChpA+wgmbdCOwDA
Date: Fri, 27 Nov 2026 18:22:02 +0000
Message-ID: <CH3PR11MB566895BE4D0EAFF30DA94658E6E5412@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261127164952.282833-1-marcin.szycik@linux.intel.com>
In-Reply-To: <20261127164952.282833-1-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SA1PR11MB6944:EE_
x-ms-office365-filtering-correlation-id: 1ad47eae-2917-4cdd-bbfb-08df4cb3558d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|261009223327099003|261009223027099003|261009220027099003|261009221227099003|261009221727099003|10067099003|261026140227099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|261022105027099003|261022075727099003|11063799006|56012099006|260925021311599003|260925021911599003|260925022911599003|38070700021;
x-microsoft-antispam-message-info: YTUnUJCAjfqld5qqyY1e0lhJcohYP5NsL9YMS1hPd8IJU5kBfAWQxb/ogWn+v8jHhjIAK3vuG67SImYnuQhXXRJUhE77/A9ooW5wpXcNcdnqRuZ4Uc9P3PR62so+WN7evsXcg0uYgfMSUFF9iVkph2msMEIGDtZUE9T45MUME3fRYgh49cefjf+cJ6lBIagI3990m1txuNHlpQnKYBZaExCGBjV7ihR7yFLL6qlocbwl4AnJJcYcUt3KxavKu46OItgC+mkbS0220/rrFhnxTgBg/nAvQIIaJJlXplUtkkBBD2sJqEGrfpVRlpmph9Y7rPgGiveuepzPORJYi5TNH/rfQXyVbfI7M9uU9y7t/cI9WsMBZ6VLk9hJY2e2fP6JWc8wTWk69t45YmcALzJGZjXnpzByscG5qhOeeyeZRemZGpIm1hQHGknmD+CL4XwrVTJEV724DmRLk+UF/64oD09L/chFzwqk4bXfXLeWfm+1bOtmujzRIR4pQ3PuGSMCrpajwr28iNcmUkCIZpjawjmmJ1pT4AsItEjLUkB0ZIQbYlz4bHV/2Awisnt7z3pDKRiJV/BnfU5mko0d9pzJWABcUBPDiYDUlvR4Rtiu7Z9u8xwkihFDG5lUXYhI0cjBBxcQJ7zaNWTVKfxFTtnKRnBLiTripCVjYrYU734myaIOIof8jIkcd6n5sxhVU7HAbYkoxkMRmas8dwQh6zPs+0wqSvBZXaXUmFY+s4LtBtc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB566895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221227099003)(261009221727099003)(10067099003)(261026140227099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(11063799006)(56012099006)(260925021311599003)(260925021911599003)(260925022911599003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HVJgLaDQQDmSzw+kIkQ2VCTe2cMl5d2gdtfRpWcddQWGwJnSIRxO6h23Sq1V?=
 =?us-ascii?Q?ljN9x9EJ5UcdOGGxPzYHOccoS1YANJczkTEH9uW8eXx2rCvDtI+12h5HfC99?=
 =?us-ascii?Q?uXrysrPqmd0QayClCCdQt/xFe4cDfBA9glWpDogHm2imQ4LnPuP/ZA1o2Kfe?=
 =?us-ascii?Q?KeBCHcx5HBiF3m19M7Qm514zbDcZYOOBJyazcakvwMFV5CZjnwFoQMoOZvAd?=
 =?us-ascii?Q?vNQhloGbY9TGxOeBwBbtZh0OYtrsRBFyAlpCsFx3igy3t+Azn7AGS3RB4dFP?=
 =?us-ascii?Q?yq6kVBqg/3saupppXVHxxWuWRzZ2T1N96iXW4m4xobc9uKT5d24rR8xTJf0U?=
 =?us-ascii?Q?dw/jMl8+iKBVAKpu9DNKHA38RTZb0kdBc5cJmw3wOzU1WkZuu1w9hYgfpF60?=
 =?us-ascii?Q?9/gC//AZBm6wm7fThFOUbf6voB5hlHkkO1wIzGVC5yT0XmldWntnibr5gCq9?=
 =?us-ascii?Q?5AjTvK1NBhmBa28EFGmo5MLAhrJaMoq5Boe2QjEzQ7tbw+iRqMXs61Xi/HNq?=
 =?us-ascii?Q?06vTiocqUe/834k6dXcPXsx6p7m5PeRVeDrMEIeCwXOYVldp2S5qLdzysuxS?=
 =?us-ascii?Q?BcJqJUpViz5T1Fr9HbeP6tPMxWXl8SP//2LwZfVPVR8OfWOU0lxPmI+5BWha?=
 =?us-ascii?Q?XKw2pE1TY4h372jLpPHLOWSmsA8Bw38dzggpUzUUVBrjeMw9Vh92CNtP93Es?=
 =?us-ascii?Q?FhbcU5Htar6TZeI5f1Bd0eOIC23zAPacB4mQJsKBXWrtFoeG52y+oe97/8fS?=
 =?us-ascii?Q?gV5+a46eD3sZVrUMgPC/c6gM6fYdsZk2Pp+M2GcJ7Od5CP0h6yss/eqrH/gn?=
 =?us-ascii?Q?gbbNLNdtE2wbOGwtfG4Nbzg785tctFB/bArKhdBkYC+Z4LbdnO2DQxS4Cc7I?=
 =?us-ascii?Q?qiPurzhdVe8hMyZYChcb688Nrh3NzQhWAuH2j+mYuqJlEZOziQCW3Xasz4gw?=
 =?us-ascii?Q?VNJ+hDDmnPVGeLy9yZEMIB36eNGHiqhzfvaRpgnANLARv8ZvhBnqQK+0GXon?=
 =?us-ascii?Q?tcAA1k2Z0siY8ARKV9tptNN5gjLHkPcOQ5NBUVBocaDfaaqLkKvb0GDjZkWo?=
 =?us-ascii?Q?cvu7XvzKkI7EOK+tyeWQh/XmcEcGeTYMkcEwqdeQtXak9f63Lrtjip9GnTRA?=
 =?us-ascii?Q?IIVcHtKY2s4z5sHDPEFV9BIuxfIPgmB4p7iNbKeXSHixSe/3y2cauDsH95/E?=
 =?us-ascii?Q?7wjZ1RJ5JE6SjAnjSTPBNGhmEzJRXhbxs2YGfavTkSDXEtdjCHEF0XsRkKoG?=
 =?us-ascii?Q?eACudvxWfg5Of3oXe/acR1logEP7AaNPIP86MjxbMorzv4lwURTHVkuuIUbs?=
 =?us-ascii?Q?oJl5N71mL2A4I4QVu02iGCYwEZ7isOcPA+qRDLrdylQEewbZSWZuaL6eyljS?=
 =?us-ascii?Q?8SAeo2xFl+oGs5ocEcuFrX02J/DwJW0vlWIl7g/dmlMFkqwRQEAMVF4WGzGM?=
 =?us-ascii?Q?gzFT+gdIz+cfw6YOmDTfHcVqmPX/QyWqGLYuUZQ3CKhBGhf2U8dFjgJWdxDQ?=
 =?us-ascii?Q?P4rJdT2VehpW+bSJy9aJDpnoZpDIp3O7fvNEOwRxArK8Xb75+iFaT7IlcQPk?=
 =?us-ascii?Q?Y4iNrlv+FGDwWy5QsmEFHhpW9XgHALCprTmluxxZkllC4FtEvBsa4L4lWCnB?=
 =?us-ascii?Q?4urhbVEuvDF+46VejQp+EH2zRoKg8IFC2WmfC/qJTrG4BnnDikOXseKuS0UK?=
 =?us-ascii?Q?qzXMzmeOMM0pDMeHNnedcvTV/TTChvwH/0OXyg7TkuQmZz8aynzdeefmKRBm?=
 =?us-ascii?Q?8T7u8wBsq0nU6SDrPn71M4SVDX675ek=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZwoVU9ShANw/3lAO/Q7ltQPX6WR4MuD3JW/A8h/0Za6VGRIIi5pavG2wncH2WhZ87KN6f3POyl2NRPWoTyXWPJzQpHctyduSsSyg49nNYJZivoqnSNV0w0aC25YILMw80Z8fTBmnAQ8KBX2WOspz5uzPDJ4zDhQB86OXkbEkFY2g1IcRa5vfXq5n93rEjvoocmCN25BLrxVpJgdgYAEnPkZyqTqRYfW1KNfgV2g9+bZh055c2pMOG3ly152YbMy7khdoQewtaM2YgHFEz0KrTx6icblJeBfywcSR7mEb4kVXe+AsA7M5mPH47oH7l0d0azFwfQlBNkkZg1A6yijJtQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad47eae-2917-4cdd-bbfb-08df4cb3558d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 18:22:02.7494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNY9SLxTx9UFr8vERM3ZSqNHLWMzQZZy9GwfH3rna4QJ6jbcrfzH2vo9cfpuaMnFI1tQq7T4JPOSKMy4pbonJ/tTvNlldDIvoLFRJ5Epe8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6944
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Marcin Szycik <marcin.szycik@linux.intel.com>
> Sent: Friday, November 27, 2026 5:50 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Marcin Szycik <marcin.szycik@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH linux-firmware] ice: update DDP package to 1.3.59.0
>=20
> Highlights of changes since 1.3.43.0:
> * Add switch profiles for ICMP/ICMPv6
> * Minor fix for FDIR rejecting certain rules
>=20
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  WHENCE                                        |   4 ++--
>  .../{ice-1.3.43.0.pkg =3D> ice-1.3.59.0.pkg}    | Bin 1352580 -> 1360772
> bytes
>  2 files changed, 2 insertions(+), 2 deletions(-)  rename
> intel/ice/ddp/{ice-1.3.43.0.pkg =3D> ice-1.3.59.0.pkg} (96%)
>=20
> diff --git a/WHENCE b/WHENCE
> index 37db426bfbab..2b1d11390a3e 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -7617,8 +7617,8 @@ SPDX-License-Identifier: LicenseRef-
> LICENSE.amlogic_vdec
>=20
>  Driver: ice - Intel(R) Ethernet Connection E800 Series
>=20
> -File: intel/ice/ddp/ice-1.3.43.0.pkg
> -Link: intel/ice/ddp/ice.pkg -> ice-1.3.43.0.pkg
> +File: intel/ice/ddp/ice-1.3.59.0.pkg
> +Link: intel/ice/ddp/ice.pkg -> ice-1.3.59.0.pkg
>  File: intel/ice/ddp-lag/ice_lag-1.3.2.0.pkg
>=20
>  License: Redistributable. See LICENSE.ice for details diff --git
> a/intel/ice/ddp/ice-1.3.43.0.pkg b/intel/ice/ddp/ice-1.3.59.0.pkg
> similarity index 96% rename from intel/ice/ddp/ice-1.3.43.0.pkg rename
> to intel/ice/ddp/ice-1.3.59.0.pkg index
> 8a9cf0577571121aace49873f0295a7e9ba3d3bf..a0ef874000e4db6486b2c027f9e0a3
> 7277b01f33 100644 GIT binary patch delta 6521 zcmeH}dpK0v-
> @w<N8O+`@!<ZQ%_Yi|l<C1GKB}u82q9Sx9QA(#IouOPR%H1j{bP<(`
> z!Jz2oRw5^gbU8{Vog|f_FxLC*F6aH#|L^-ezvpTHwLahdUF%t&wb$C;6<xn5I?g>w
> zU*-k@Tu&q$2{5~4uNcfc`RNqQJXINUqOkyoggPZuLzuIiprs~Y+Ef<pmG}Y{jET;w

...

> z_-5`uPT+n0#Awj}5xj38u|B>K{_%zIk1vFOd?Ebf3*jGM2><x<-|qiEfEW$>e>@s=3D
> zzYH4+iYKM4i&7M>i(*9TNomdm*x-pQdb>eN3GK;eNDE;uV-YbW^vz8P3B8ysyPCfN
> D((WZQ
>=20
> --
> 2.56.1


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
