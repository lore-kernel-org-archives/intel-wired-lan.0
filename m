Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524C8C88E4D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 22:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B5E060602;
	Fri, 11 Sep 2026 22:12:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P2poGTKbf1gI; Fri, 11 Sep 2026 22:12:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 57EA560615
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789164769;
	b=jwGzrUNFZIW/smkER8p7pkp9CFbjeOEDSC2132A9BU22p7JDJv/Kl9j0209qqmW/mJH3
	 HDJMHtzZ7MEBGbe/Ezg+OQh5boxPS1yJTjqvcecFngsIn34UxwJ4REUxIiA9gsQL0yAjF
	 kDJchAuApfWUUOgGoPn+Z7LLc/jsrqX6hrszRZg70b8xu+lF1OqMWI9YYlFElUYPTFbvP
	 XaIzl2k9vJ3Z4Uuqzyh6tcLsfqqjPQnkLf96c7YLgxAHfcXQsh4urH/5fyfZ1j6epmn58
	 /99bDUO65vk83RpzoIOVZi07WIn1NAQWsS2Njegta5AMtXbjQub2yuScwPB2+nUH/eQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789164769;
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
	bh=78LrgKfu0LoxTRqVirEJ2qnJM3MyrKhl1vXvsgp1gnU=;
	b=Kvp5BZN0CjVObldm+8sg8EjksToRK3YJw9rnErHRsba0wyDpOjuEqOIsPY/pmqXYE3Vn
	 CT9QPfXiu/IMVniMTehjUNFfV4LR0rS4ZlFfEm6qysIZ70JxkCgZqeRCfW6ClG23Dj3aV
	 GbI0cNtJpCOLnrgcssttsx/O9PsAFzuHHSyDerPq7LnVqWIQltJiBoGBKARxZZsnTwCPu
	 EhMXD7DwjbNM2veenuc8F3a/OTlHmFoSN6oq1vjU/bQSWad1QWs3Gn2birDGpIr7iy9VS
	 XcrfOlq3I8u7LscH0CWF1bWHffgT/vxyFblDtIzbEiB/UEHWMDp+2FAm7pU1tI8vp7g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789164769;
	bh=78LrgKfu0LoxTRqVirEJ2qnJM3MyrKhl1vXvsgp1gnU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=35ZX1irWS8Yeqqak9THAeEwqzbSMSpHOimmOc3RCerxH+GYdQWaO+G8DPVzuoj2SB
	 ZwYkxw6wMbd3U9OQkOsNgOH86V0vZ/2bxdw9M6RkkV4xy+G4cuNilTfV87uT0AISYS
	 f8knmwcM2zgARVygsmv2GxEPXjtPQxUDlJfZ/lrKqFpMrSjew/3BdcQOtUqK6swovN
	 qoZ7W/vWm+N8uRVAuy2gRDsOPDwMdxd+VjAeEMVDHLbIkiiWHjU/K61gSxmwVhE8J2
	 4Vegjh+c5KuMpf00SOP6hK6kidhRhgv7509uCEnxkoACH0P67xhGIPN93wWbIAOi71
	 IgCSzqIiq6UKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57EA560615;
	Fri, 11 Sep 2026 22:12:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC1782E3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BDDDE407C7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:12:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3cUuSUjm5swd for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 22:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D876A407CA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789164766;
 b=aqMhDMWD0SymBlqkAIUEvKUcjhaefCrFsnm10j6S7NHIhVwE47QSrD44E2G5QLQijCex
 9iF/sVIAowJmlzDewAiFOQUtuBb+LtEHjaHqNPZm1NwA1fcErA9uX5mbweDHcv0sQjYNn
 uiipKTWE+vBJlgdmZHLqkmhAOnvR9+hZD/vswjAkzQCqWDuYfOk9xeFAgY9wNwxwCObJG
 LPH8wHKCA6Y3plJ7NX2+224hZsz6qXLXdh8OLHtmfZbnnUlKdwXY10yRFljLf9yCZjA/1
 h6XHMjIBnhFhXatbC6RGU0sV84lHoktf4ukXvkQXCApPIse5cmlyy+ktKyEjbWqcfkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789164766;
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
 bh=78LrgKfu0LoxTRqVirEJ2qnJM3MyrKhl1vXvsgp1gnU=;
 b=kPHV/DkIbPArBVZW/M+iU8zRkdvaIrC5Hx7t0JkqiAH76jzl2krMaMDdtgDaqC0gHhaa
 k1LJ01rkhyxsJRmyN/lU6sqXaG7SqiyMzx+1Xbj5CjBc1Ru9gDcExc9iQ5Zm1OEKSMdHo
 mYEBIZyzkvQW9p3Yqueg6PFvsRh4z2jWkupR3PsUsJW71Cz0qiIIevV6R6+f6wNKS4DOv
 x4JylP8GtA4wP7402JhTZ+ap9IlxSUKK5BUNLtNrHkIMck6AdM/F+sGgSFB8dB4BxI8Zx
 kgQT7USGrsL1Z7Q87LXt/xf0o1F8qV9v3CjUhDSaEmQ0n5hJ6/oGKcig94EIzNSWQdg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bFMhW0fk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=sunithax.d.mekala@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bFMhW0fk
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D876A407CA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 22:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789164766; x=1820700766;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5lsPTDqyXWnzjssR3c2nRA9i4lb1rp7L9uQgiupBNsY=;
 b=bFMhW0fkrfzP9/T3SO1hzfBhI4SWNt65jCcCAOVLP8r9s/O1Sk+uD3ar
 EZqPagh0kerlYqON4uoR8T1n37fptE0AWUVTUZDPkSYQkRMMvyamI6wpI
 W2AV5mlgnP6Cv/1bb9dLcfGFKRpNBg4Nbb+evNCVG/LV+S8My5OAevjv3
 P2BLZWYxT7oB2Wr+vuBET+zQVXzX2PkAGKbIiKygBRS4OcTvhCtQdJ0P9
 QrP+mfb0T0Nj+oBKf0IilWtFgOsRAyORXoHDJJ1WpDpttp1iRcEEPn2h8
 ki7n12nHd3IDz9BZ0T4xLmwl2oZ7O9EwaQ4iE4gpBca4KQKWKLm5U9+QI Q==;
X-CSE-ConnectionGUID: 7rt+FyLUTOG+Qngveg0wbA==
X-CSE-MsgGUID: X+KP1RHGSFqDbkL2RQewDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89472433"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89472433"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 15:11:12 -0700
X-CSE-ConnectionGUID: fakrnI84RMWsh53KeesTAg==
X-CSE-MsgGUID: XZfxZyTUSlWrLum+8SQvQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; d="scan'208";a="272010251"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 15:11:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 15:11:11 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhSIQGFA6m4inV7rSKjzAe049fFRBHBaCdidUmhdeY0t3AV+JkPzKj/z5jfUpOO3wqmQhA92BGwHkb83pRvd+DBUHFIeacxmATOmaurPMnYzMqUODzaWSvHahB6tBGbXVA76j7QjeHlShHdYJNYusHj6u3iW8SfoNzJQfXN/zzYSgb1X1fY6h2cIFYlF/T7pO+KVoOdXJ/l9EaZ5m2PWnEj4gZiMMvYPXoWjGb+0+5upfxJxy9/e6/gA7saYOhap+RX44Ip1PKOctkC1e5O2PD2TI4K5QjOT5LkLmhSihDGthcXxWOxCGdHtYANX3kdnfMzOD7f6ELh97HBDH693Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78LrgKfu0LoxTRqVirEJ2qnJM3MyrKhl1vXvsgp1gnU=;
 b=W7+E1Xrla4Ya/xEC1lBRSXiDtL8LJJMu5r5K+4SJPVGmpvvAsD4joB2SjR3z377Z2CvNvAb66k9axqa3DsCbjF9NFPOFP1UhvW/cB2cLkQEFXibWBzcAXZO+XU/m74pCNirqo2OOpXXiIAOX9Y5Sw1JDL6S8WIXrroe+CtboggrnisbPaZxFMXo8v+xDkqYbxU1vpuc85VRnZ4hRCYiGnpbIr/vydVkNvLVTCI5FTDVYA6tsFh5/w/Q9HQ/VFtR8WNRf2UTjvI0P6QXOsNIgcecNyEetkgfPQN5mnyUVGJl5632GNTlJBLHViQbqvNQV4ks8bj7hB8M31sqHWSV/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 22:11:09 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 22:11:09 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v5 4/6] ice: dpll: Check for bounds when updating
 the pin states
Thread-Topic: [PATCH iwl-next v5 4/6] ice: dpll: Check for bounds when
 updating the pin states
Thread-Index: AQHdOVgf+6nVha2IGEqcLWZKKAytkrbJ/96g
Date: Fri, 11 Sep 2026 22:11:08 +0000
Message-ID: <PH0PR11MB7522B2DE2A977721B8234A80A0BE2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
 <20260831145005.191040-5-sergey.temerkhanov@intel.com>
In-Reply-To: <20260831145005.191040-5-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CY8PR11MB7800:EE_
x-ms-office365-filtering-correlation-id: 720f832c-4d5a-4619-2cf9-08df10519522
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: S8gti6u18fQu2oRx8s8MfSUC44t2hxGs6aYPY18oe/HkfZfbSIhJnjv0l8hTV4FnsDRHHGDkwJtST4dyfJYLfRx4Ny88LqLSk+SJhyWHXDM2VmJ6D1JCclsAcD0UB+HgUxZJIIN/eBq4GmHfGO0PqSezCC6nKJy0lyEfCJe0ffmf404htDcc2SO7+zwyCho8JY43pwbhVux1lZf6mosqmPo03NqaPmVmGa6DSlgkB+uTVgWWqQ9VhbTKU6vgtTkxKT0U0hiq/hKB8w1LadUg2rL/Z8jdp6aVt6/f5x9VSYPo1sDbYcSdY54CFH5wggTl7Wlyh7syqMwYDQCtK3fJjHHrAFNkDXcMV0UYegQ+wI856uuo5VITNpionRJLs116luBl5R0pjkmdp93OxBpa3+p+3yMxw2jzhsSY5SliqhQINhYwg3PLGn9nsmHV/JenAA8mXH2BxgTMi2BeM1vnfKNkEwGf5a9Dvi48M4Ahn5DDqc9s9sASqIgapLMjEEklBgEjnBdElzKCwRyqAvyvqwb5/c9EcCxmKaPKESP17SbrHpo8/ZcjqU57vLGvz2uVT005yIh24P8SEbePneCZC5yigFjud/UBkZCi2GhyK2gGt8las6kDiPpA90YKlAVtemvmbx0wxBjiVvV1BWMI5RGhv4mGxDWvseCszMmHBn2kW0XMlUj3I2rZ9xvWqLCyW+x6XKyl6FQy+irYRgIOU2YJxluYCg4/WRkJekCUf9o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kUCQt1bYynlMjFsmwnNFf3F2ueRknB6Vu8Y6WzIZjzFaJP5gKf56FdIVRkiQ?=
 =?us-ascii?Q?xbXxz47W0pA8pPJ2z5b65JyMm7mwq0uqXPkcv2CDQ0MsEBEoQofjcB8G9dfX?=
 =?us-ascii?Q?7/W943hutCib828lWlPtOmXLIIJlOZL8UN/UFkrNaO5xjKla009ZUfBTQPX9?=
 =?us-ascii?Q?BdVFWX8anA5fXmMqKRzCoKypwl/mYjNH1KdZAyR8Xmz2dTFXNBH2JJT2LGfO?=
 =?us-ascii?Q?g0Sn8qBcWDvchOvOgY3BfddKmurCA2OhbqPRkNgIDWJceZVbprQn/ANofn67?=
 =?us-ascii?Q?AsDvyB6NChB9GVRlLzGJnNsePWVjvGlKkQDnaTpy1PdxY1QjcjtLq8o7yrZf?=
 =?us-ascii?Q?fGElpuX+u+63mS7qbi4d5UY7P5JqbFQZXyC1FsNA/nMFMjw7eq+AvszfSJzy?=
 =?us-ascii?Q?vZkOxYGURm3h/gXYfOkynyjFSDzaWDQRXHSSYZQuM0h3lhXjfJq7PaZGr+NZ?=
 =?us-ascii?Q?wtRfLCvtwg3cOwvJKN/b/3274GaJRfijtlJfMLNS0GHkqZcp1tlCRHkbzHhb?=
 =?us-ascii?Q?mKsOlhXfoBguul+fjltmSMgPAo4jwmNwBjK6uwJyu+mASKwe48g2BeMjS5U/?=
 =?us-ascii?Q?/hc5Ieqry5ml/bDJq/OpdIjIXLc8qerN/IUgQt0dNT0ngE1digY2Zhsog3rB?=
 =?us-ascii?Q?8FFPniCUOm814Rh1VPyVDORpOwXbllVQJLVrjdYEneFFIuhteH+oMlfVI8hI?=
 =?us-ascii?Q?5xgormV2J5BjkRyJFoZ7IuSL/AhNygD10UepKjQBBJ+J7VI1WCbX48uVqy4r?=
 =?us-ascii?Q?rA/GMmOQMsRu+HNGgjmeR9shUBVE5GFuQYeP398qwMylLizWbPvj1rbDHk76?=
 =?us-ascii?Q?+W8GCdQZoBjPOrxJDuNZ3m0/bMO4aD1zLTFz5uqmacGIEa9D7t4poT2thyxH?=
 =?us-ascii?Q?PoB9Tp9l/ur3qgLh9qJfJqOhkuojl++FrP1u3uhdvl0N7ukJMXJAYGbRmdw6?=
 =?us-ascii?Q?O5v/5GdPAdcIxYmQJ0Ef71fTQbEdINgBfSLpGWgAeJrvwTJVyJl2HcPHBxJ4?=
 =?us-ascii?Q?Z93ZXPN9QEaX63t1OYnBVe6z+OGVtDTydrC46gNaSYc5JAVrO77CoDomT1ic?=
 =?us-ascii?Q?YyH4Z7PEVffDGhxurb8KSU+4nb1AVERhdOZ8Q9Fo9yIF/S+sTz7S+z/UpPxR?=
 =?us-ascii?Q?pcgigA7ypG91UlABuukE/bwWBtB9TKKQDABsshuF2pd3JGcZtSU3fLfbFQ2l?=
 =?us-ascii?Q?PvHGa6VVFDP+koRCcoRS9+IYwWQ2n/jDu+FqBA+rQ4ydlmxCShklmzmWKufc?=
 =?us-ascii?Q?FMDVSjuHqQ3Wrw0ur45FNFV6ocLStvkf0QV3fNEUW/TGLYY0Z41T0MSH+GdN?=
 =?us-ascii?Q?By4vltz11ms8DBGbS20ZwkY+omr4D/jafpM3z7yOgxHLPaCDhVty/zzviJSZ?=
 =?us-ascii?Q?hZAnKJgdZ2VEjjQQkdsdyZ2JwGYjOtyYuzsynMtFMcAXq8OQMay5fJI5K7Lm?=
 =?us-ascii?Q?70jSYEAwKkGXS+2q5z6nYbxrxHaevJVTGeG3UJ4M+LspLJADZRYkTIAY680B?=
 =?us-ascii?Q?a9b8lb1aK6CpzZTT6zcHwXomynBlsiyaeThu6TVGH2OVgfGg3gZWMOnUWpQ3?=
 =?us-ascii?Q?sHebPsRSIoK6jA5BhEcZQRntH06G6W6RZswYl2UQgIn8ahtbl3y0eyhEzF47?=
 =?us-ascii?Q?mVStKyzgUmqfvaVcIqyfOXm+wRmONMQ+9jwZypaeGZ5R4kmmLP6pRd1eB54T?=
 =?us-ascii?Q?g0AiEKdpqdrW5WQldqZX5ST/z7MJ5Np4hJ7ZrDC10Ng3JyPIMeK4kLcakNHU?=
 =?us-ascii?Q?K/3ZboY3NA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ii6n90z/bZ1pItOh/qmLFryrFHXz4Oq578Fu9eyyMctWmeDOChLDD+/QtgX36KNCTlPDWu5+GiGjBru9nxoMWmH37aqyLGkapnu9XRo/QbrAKfUbWwjbt1mbS9dmOmoUDPCQEEJM8vx6/HxId+dkScfnNsn0jvUrVvjEBpc/UHJxJbqmx17hOHo3tiU9JUW9RmuD2J7w6Gut8IgzTYNnZFMznfNvrFL26uEYZi7Y+Ro5dL3iVRXOOuHxw7yAEDQohQXufkXyHUSg7di6rbzILGUPMKnKA5CqItCI2T4kMcaQa2kuM/H2ZMQQ3KboDevHminWqCbOAOEaHfgdqn/elg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720f832c-4d5a-4619-2cf9-08df10519522
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 22:11:09.0176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VN4gUQ3D2T/WGIsf8rqAIcED+6nGkXpTHgsBoY5DSv7tyDUfQ+pbO8zUnmwVn7G3MqI03QWJ7U8hij311bOcptXmG8/Humt2CAyWX+3jYmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
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
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Monday, August 31, 2026 7:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [PATCH iwl-next v5 4/6] ice: dpll: Check for bounds when updatin=
g the pin states
>
> Add bounds checking code so that any potential out-of-bound
> array access is avoided
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_dpll.c | 46 +++++++++++++----------
>  1 file changed, 26 insertions(+), 20 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
