Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804A5C61DD3
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 15:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 332FE60B75;
	Thu,  3 Sep 2026 15:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Euhi2jB5mFcJ; Thu,  3 Sep 2026 15:29:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 536C860B6D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788449384;
	b=S9KJzoX52FqlVghLGWj7KTqkBWn0ZguE+KawH9NzHBRM1AprBlGDyRokLl/edjM2Z55Y
	 M3R8bYcgUZrXm01UkM2BztEQ7oaY3+ShVq+xpg1f5ReDF9/GSUfCDi9EgAPlezhAvfmb8
	 FWpUiizjNlGxXn5lJZizh36F/h/tukWnp5tC/9QgHkF0rAFvRpcFHE0j84mrjLFAZSTgi
	 hHEMvMEsYjk9Z9gQKX3F6pUvKkCrv9Cr/7SdwSQ4UIhuOeF+cp6U890Fqhe64KDtaOfro
	 q9abHZylXCXtcvzzyd/7wYGYbbb5agGvb5ncikGss/Ev6V9hC7OxMFKKhRnDxxNhfRA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788449384;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:Received:
	 From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
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
	bh=s0kQL4BDiLlN55IgKiCoBAasdT7UV08qxGlTvTf11Cw=;
	b=JQFlk07ZJ8ftND3G2XJZAiKSawiU7Lrqi0df46i0H/xagTAi2UnncvR/EK+NR9e5MqkY
	 mwSJMDUsbUxPyDl7JAFgNuLRkjtD+qidD7kg4StIBcMWyhdQfvzVNuTvejTJVde1ctB19
	 Hscfy3i2RTTtuf8caeGmcGAEj8UuVbFi2olNQKqvdu7p0TY4qkCRFFdB7jvgBnn1PSwqC
	 VEhtZg+82H4IeYtVQRFWQZyQ4bf9a2mAzil3Zp4yrTYORRGllR1Wogloahju2YP+xYckw
	 5YRMUIGV4vO8jZNx/iOBxGmAtwACzOIZPF8/b7ZSQesc2RLxgLpcdpTYXJ2oHnubpyw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788449384;
	bh=s0kQL4BDiLlN55IgKiCoBAasdT7UV08qxGlTvTf11Cw=;
	h=From:To:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CP9McqvBo6HSYE/moR1Xt7hsct1ePnr/2AStBJ0lAP31yT3Bm6VSD0c9VF9W0yTML
	 kQVud+L95nEJS36Z0uJldF9c5JoFOoorIZE7VMVvBy8+lDeDkOaXlk15LCmq33MFPg
	 Ff2qZXyGaYpvhqFFCWMEjyq2/Wtl7fikrultti/j4L5WiVPHkIljsJnwKB3RZa8EcQ
	 PMbmdU2VG6ZgvRFb53nApeO1UQCS21c+HxXEeZYaDJBhy9JwR5w19b5ahmP4C/9dcq
	 xnOx19046vcnzmwe+YpOX4nXYvZ80WJcAnkun/cvFFDh4MdMmupp9Uc+F8AdP/05B/
	 jqV/15SDRKnzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 536C860B6D;
	Thu,  3 Sep 2026 15:29:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AB7B3279
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 15:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D97640B0A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 15:29:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9yCSp1vgUv0 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 15:29:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9B72A40AD1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788449383;
 b=e0qZpCaGpFpwCUpI4q9t/AV7WB8iXhc3k+xKeg5HWOC99Tpb/OHyLTDiMw5dGTdxiSSG
 M44/5MtM4ofwnFc7Q+2yIN/IxArK9R9dnPr9y/n8bm+m3RWCKRIvAiL7KIAF7Jb2xRXUl
 NMoyqRYr4x/2JxA3j8LXxqbRZ8HKaeRtmi+XMTEFz4wkTNyCUVvP9xDf0Gh9X1RiDmgdt
 beXcSX9Js1QFPBsJDUAAnnEGUVI7PJVSbA5ZT50vhN2aIGLfzhK9hIbavzNAUwaSuGWTl
 mNCdJt4JequqCWlpZDvOmsHwJMt57f+B2uhP5zG3M2oSsiOqjHjIx9uJPG4tyjvIYfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788449383;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
 Received:Received:Received:From:To:Subject:Thread-Topic:Thread-Index:
 Date:Message-ID:References:In-Reply-To:Accept-Language:
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
 bh=s0kQL4BDiLlN55IgKiCoBAasdT7UV08qxGlTvTf11Cw=;
 b=N5GAP3G6ZQ0MlKbnktoF6zYsCGg8E6PByi5tbWPI6zcIZGO3Va9EZJ6FyyUnQXpi9bLy
 5+jmCf4nDORdkrYORW1aX0vA0JBlXIqd8K4jb7D2+gXwFZtN/+NrOQ0W0XWq/u1yGwQ5C
 UFwJeHGgj+oQjysApemgRv1Lk5TblE8uX+9f4E/ErzuDcHGhpIOlVmf0ZcRqW0Wo1nXUz
 JFOF3iSavHExVRLmCljesGMIOX2ON/1ZJSv0Sg0osxYKgGIz6099amWTBwwfO04d/JzP7
 /Iq4k93KgZYQ08ZYoItEAHBVlahD5nmCA9DRggFhYw2kuZ6BsBeMdvZhcIPIqTm/OTg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CUatEZsw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CUatEZsw
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B72A40AD1
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788449383; x=1819985383;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=YR3tZyX8yMuUhCpnrARZUjoFqmA9e7ObKrkLBF21Bbw=;
 b=CUatEZsw6s8MzABC0WMsvUu0ihuc3WVC9b0kKnRJjJf1pB97DOfLScxT
 sf2YiskSEtrp7QFowKqVv5EZutsGdQabsyRVZZBQCrzGuzSpUhZ9f09Uh
 V86RJWWhen4O5yVkt8tUKzjtDoUIf0K+XkyB+hsQ9geAeCLP6gTRAfcnI
 vr82fxzdzy4FjORLWoV+O6TW2MG2BPaZ24oCUwW+5E9y0FJlQUtH9TYYk
 2qDqguPDET2uZT2TRs/ayMsWGUxzRgKgUiDmZJDh9eY2wzeO06yk1HSdb
 qNQUPgtdoa27uSqcKXf2DD7ZQlft5mePSlfA9jHeCowSgGmoT1q2NeUby A==;
X-CSE-ConnectionGUID: T8HN51HDRfexQBkhyQCJPg==
X-CSE-MsgGUID: a/Bh+DZTTN2OSnyPHXO/2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100450990"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="100450990"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 08:29:41 -0700
X-CSE-ConnectionGUID: ordnmjVkRbSFiIt9vo0UzQ==
X-CSE-MsgGUID: xU93eZ55T2yNweNRcUG9Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="270296055"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 08:29:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 08:29:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 08:29:40 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 08:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu3Fq0oFZ9aGB7uJUy5jWsVBIeq0StDNiiAYqF2BDosrTtyvic2fjiNjJPAjSnDFMNdyQqJyBLbatAmp4dddnruio0gg82LjK46Hne20/CAEN8oc0h+b1775IXwgl4EZZZ6mi5tOzvakaJGDx12YfFzbkh8wXyVLeQIDTmc66sfVx2JqvcI+/Bh33AiSAXRzFbzJHkVdfsi894VQcH7KWNf2WvNJu+zIM+1/SC5EA9PSGB+6mlHX7OLSlnjPIViCyFkG+lxciPcIB/guIYTYghnbhKY2kjczaN8LoVLrunvbTxPDFyKXTAGnddZfAP7BwP4Yrg0eiI3h72Hd8jJGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0kQL4BDiLlN55IgKiCoBAasdT7UV08qxGlTvTf11Cw=;
 b=zF6SoqONHXs8nxbRuzkq2vQFyGmQsQiZGSduMxGAhKv0uBjlEddzwTkiJSfoKQ993yjwOuPFPZuH1o0fyiR7EBtX4CLS4uynpe3fTpPIzU7Sk6KsiK4AINsMuPFu6wLfvW6YnZmYCBfbG1UuGLVqoVGOHg1WtFP7Y7U1nysI2lr3aqpF8Mj9+O03vJFsaROnW8d4Pj6G/Fgk3ZZ1XaZiHf5mrqVvSxdEx1xMhPP80Q4HvaATB6Ach6dfNn4+BPJJOw8nWW3Pax7xap8/GsnLK6PGeAXcVyqEy3LLY63GNnHEy7R8INKfg1M8zts8tj3GmYa1zrs2c55vI2P4vEkiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 15:29:35 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 15:29:35 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Yury Norov <ynorov@nvidia.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Thread-Topic: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Thread-Index: AQHdO6cpuxzxPOr6nEeiXshlL4xdnra8+orw
Date: Thu, 3 Sep 2026 15:29:35 +0000
Message-ID: <MW4PR11MB6864F8E60A0E8587D6F6590980B62@MW4PR11MB6864.namprd11.prod.outlook.com>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-3-ynorov@nvidia.com>
In-Reply-To: <20260903132037.81346-3-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|IA0PR11MB7910:EE_
x-ms-office365-filtering-correlation-id: 6b177e2a-e690-446a-76f2-08df09d028dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|921020|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: t7Pe1Ud0ySvGrhlG1eJYl4qSNOLDozarywQg2nZufldWxeskCEH+iJ3Q+D3V6MHU8J8P1N5WNAwDYq2tAHSjcXHdtCUCZ6cR3FRtk64ST3Xtxj2coV5GQd4h3/mZ37L3/LW4pop0+ndYanVIGQ3nPKaVedOW/3H+CxQjmgehZXka1S/y0XO8DtbrnIo2fodH7n+QdjfxEYNlSpDhVBDndNqELpKchzWJxV90qSKBuzSGho5izkW+fZtQDByGevdbFp5EZCYEa9EuluIun2WlT7YDqcFHuh9Q6vGfdzFs4STj1bCwa64D7+COevboHPw04BpgGnQvYLNcgqCWJi11C8hPGNy97wOTi4t8S/7I7TF7v/6vlbXrlyK2AEePKQ+NGcw5Soap5PQQY8f8gYn1e41qLvj1IgWCqKBjcqBIHKShiUR+J3PjBnKek9UYY+pIhj6agybqS8/00+MfY07LlUTpLePfKQSnVpWqC0F9hNpCeop4I5WhsIwLyDdZNibUrwS1P2Gd3U6+nppbTTi1313KD6YzOh2WBEA0MF893zZ1355bzd4aQailiq053hsJ9f/GLYhth9iSxK1iMeWKa3VcCUx7qDs4viStsT3OIZRXoI8M0j0UyrLEjOFE6nZxLVDcI3CCwHlbquTKLxVM2IxbjXgGWWOuN56OlxxBu8w1LXEyWd2e82/WxSh6P1z0LWArxkTwEO+7bOYnqh+qkLFPM7jRiYmk7aQy1mM26Ss=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6864.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(921020)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tq6ng7L/96K6IENwjBuJ+lvqSEcxHt/jJT1sBVj2aKjVMVkFzET6WIgRBhgs?=
 =?us-ascii?Q?hD33yxA4yxAk2osl/wWNI/pocGYcxI22snXru4T4l+a4rBQzo2I8mmjekuCW?=
 =?us-ascii?Q?kCBrlrdinCJT+V0gvayoMqaDxBHBD6Yh3C7t54vEc5uTEd307p7fuD6lszyL?=
 =?us-ascii?Q?1tGXfuaZoFBJghP1/BDhxGYXCmE+yP0I31dpGqcmwnjoQcrhdBfjvKP/xea+?=
 =?us-ascii?Q?3ohDKdy61JzySsfHb7YcrZqSE4V8e8RdAro5B1fHWXq/LDp2NMt2o7NPNrm6?=
 =?us-ascii?Q?KIBMyju+NgS4iLTm0O7UYC6szCkWWwwfSgY/UM2ADCSYtzcjcyclCi3GsOaw?=
 =?us-ascii?Q?/qcu7qz3fWzTCjHXOu2xGOMMYVZSWipe0x9KUT1HyHEsxByPPOV1X/pnyxJk?=
 =?us-ascii?Q?jAqEYrJehnySbpyImF8JRJ70zg80ng5G5AeL1pilvvcv2Kz7zXjdaHbU54GS?=
 =?us-ascii?Q?MI5mgaNlhfwr5gKRiH7HytYLojGj/6Op9q7uGPsHe1frjByf666bs9DUezHG?=
 =?us-ascii?Q?VDwMf4fd5usxcaVWnVDpUHvz1cDCRvMdMsv725yCE6/v/pWpidWAecDaE3qT?=
 =?us-ascii?Q?oGPrlGDm0VWnb/Uu1T2Du3YHe++jE1s9z3LYUQ6q4/btf8cNAlhL3wHIJIqI?=
 =?us-ascii?Q?HbIoIXaxlZF+7RQvrfpwVSU91nja3g9LSRackrf6n8zuJ72414olwK4I7nNG?=
 =?us-ascii?Q?5T0na+OPGm4FKrxj9wGDhzbeHB0D6s9j9UdEJzGwdpkP0TR/TYILlXcR9B8H?=
 =?us-ascii?Q?fSixbxac8a4T6DmsXt6oXTqLsOqshFdl7j+90ozETzV6JJHbfY+GUecJOYDZ?=
 =?us-ascii?Q?kDHQzVPDdfvwDfVJ3Ozijb5vQB0KTg9xc0wcTAwBDuEEbKvZVffL1sSd2yo0?=
 =?us-ascii?Q?Kj8nSV4e0eoVmAr2WSvLsAggmG5DX4lzDDjDdvJV0tbh48ttQ2Urf+b93Vvk?=
 =?us-ascii?Q?vmoqWPDF/TjGOYrsiLrKxjisXMDLgdwiyjRxIMOjRFGarhwp1XUk5hK8VybH?=
 =?us-ascii?Q?Jk68vCO1DAOuGqoafJ3rUQtHn07uMjxnlYrPFR0daliMf58j1h/L0OuDRCBY?=
 =?us-ascii?Q?Ta1jrH8daMHooTNjqrzC/VLUlScDc7rhHhpVz2r3bmpcRzMFHr/4tKau9FtR?=
 =?us-ascii?Q?vwuTbsQeOUsGlPtuHmwkKySPlDXSYOpHoORkzx9DmWCT/RcloMLI0y6Wfa3z?=
 =?us-ascii?Q?faiNAb0HN+zziWTVQ5bEtQy5IFNHx8MlllqJ2NXVpBqlogNW4si2tG0vUbyy?=
 =?us-ascii?Q?ap1Yg2JEPEd/FHR8CCe3bHIrEnJObfc36VdobSP4mb77sBG8HO5Fzz7CnG1Z?=
 =?us-ascii?Q?u5rGy/mA+DvEFtd9WEGRtw+jEV0d6CWNfEGC2VSpIh6zKiNceyeSR3/cDCbL?=
 =?us-ascii?Q?M0QWQZKafqmCjnX1IDBOojxU5H5GURxoKL4gU0IU5uQtXzyuobDmDvnPZePy?=
 =?us-ascii?Q?M4jpBRBtfzUWQApMe7UvNEOtOgXnQtDXgNevheqTDIK+hBq/UiswyMulPtr9?=
 =?us-ascii?Q?sWyGoYIv6rCKMdpEhsCBatyU0Y3t74FCs2Hkje5mGWThCru3bIJF30MPDisl?=
 =?us-ascii?Q?f140Lbp5T+wYMyBKclLUkbi0KNIWX4CsK8ee+YdUbMETyEx3tNQRL239uisu?=
 =?us-ascii?Q?JPqxLQHIVsEoFgPKn09h12pmHpHEysth1BLI3XszxcuKZYCy94WQ6DFrKijO?=
 =?us-ascii?Q?C/SJzHNvu91Quu0/I241hSJgzkwg8oLEBMkRBb6PBwerCpH6poZnF50f5Ior?=
 =?us-ascii?Q?wMBgxQOjeA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AH78OE1loruQifwVU7HSYLlR7CpXaAZ7FvN0TwsSbjniK5dCS81PmtAkayRTbPYBIV6Qy84+amdh/h7V8NLlfEsNU1v2VPLu5WxbPyv/AeN+HjiAN3pU9jScHlcS7BVUnn/vWiunKIDxGKroaDzNYju1Acyvarz3oVByFC0npgVf+uAzk9K+klIMdIstFwq1zegN9JSm4QQYhI8/lmNYWx7uYu665DDROHk32UOtiqRQyFsg6WJLsHH/h16GkuJCKNLYB3PwzmCRW7OtGdKkjetXOxvgCzbySEVcj9EEW40/R8ZaQuQOklXOWo75D/JNoMjdKLid+atxZNJIS9zJSw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b177e2a-e690-446a-76f2-08df09d028dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 15:29:35.2827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZADZKD5Z4ryszZnKSgtyj9US7z3ggYK7b8kH5uuxwxbehVzYAKxAS7hg42r5mHGSSGZcvc0l6UPOXmKa+Qm3HTl9iV3jcAjpdxrxx1jXus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
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
> From: Yury Norov <ynorov@nvidia.com>
> Sent: Thursday, September 3, 2026 3:21 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; open list <linux-kernel@vger.kernel.org>
> Cc: Yury Norov <ynorov@nvidia.com>
> Subject: [PATCH 2/2] ice: drop pf =3D=3D NULL check in ice_pf_state_is_no=
minal()
>=20
> The function has 3 callers, all except one explicitly require pf !=3D NUL=
L. Add the
> corresponding check to the remaining caller, and remove it from the
> ice_pf_state_is_nominal(). It makse the fun function a one-liner.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
> drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 73996e3022ef..6d5b8acc4764 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi
> *vsi)
>   */
>  bool ice_pf_state_is_nominal(struct ice_pf *pf)  {
> -	if (!pf)
> -		return false;
> -
>  	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
> }
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..168d85f9477f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5521,7 +5521,7 @@ static int ice_suspend(struct device *dev)
>=20
>  	pf =3D pci_get_drvdata(pdev);
>=20
> -	if (!ice_pf_state_is_nominal(pf)) {
> +	if (!pf || !ice_pf_state_is_nominal(pf)) {
>  		dev_err(dev, "Device is not ready, no need to suspend it\n");
>  		return -EBUSY;
>  	}
> --
> 2.53.0

Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
