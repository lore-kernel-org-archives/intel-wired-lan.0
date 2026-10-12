Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BC3CA9ED1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 13:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 289A580AD3;
	Mon, 12 Oct 2026 13:57:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERUUVAN3m5sa; Mon, 12 Oct 2026 13:57:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4A02A80AA3
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791813456;
	b=O6wOADie5/5Mzbh7AVWrpgENse1j8kh83cusmzZ3vxdXgwpl7gN2nt0/E+zIG4YVfxr5
	 x2MDrgneSkXg1pJp9itPyftHyTx915OVO3qPI6/6y3KCOpaQPEsM5y1Mie2iHkvj5Bp8d
	 W/pe3NcR/l+juWBN8iEJgqo3XraheDru0FDX29BeWeKQgTD2bOeU8l6BP4ERASvLG1qhY
	 DjeM+xF11CmK70X8xNk05BbAWACf5JR05BbFoV6lQtZwR8XFZc05Hpb+08cJ138ZTVwyl
	 3fAuWeK0KoKVvL5+wqxSY11GvCPLhkF1gafBfPJ1gexivv6D4bXI4/uniB5DsHkwDIg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813456;
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
	bh=XeXI3TBtvvOwfS7OSPVPh/KJcWLIuUMploMN576Cu4c=;
	b=qsrEClshYNP2NcoFeJUL+0vxawJLeZZiFZO0UpxPaUn79xIoDlJbILQuhVbws60dBj90
	 BPnw9jJFzlknmL9fCFiTbMhm9TDq8T5kTv2ylzJHg1QroWQRy6ayiV/GHAPQYapvhpmvv
	 Ay14zz+EaDCXxVsYOEfc1MGWfJsx2WSqasQrjG5I+AIkSUErxP+FF6q94RoFt+Mt5V1Ko
	 djnOCv1VEnGS51nwdVfxi+qubJlyVi3LYzfex57KzrbROHFL8pqVfzsfn88VSlSw2/8ls
	 Yc5RL1a+3sALCEjnvqyMUXGF+SrL8PuEPwBZF2kx7Gzx6BFclMzFX8R1dUtlzrkyOpw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791813456;
	bh=XeXI3TBtvvOwfS7OSPVPh/KJcWLIuUMploMN576Cu4c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rABtG5ITqCgZcC6kFOLQlqZFryaa8gV3dxkNYqpnXhxRBOK4Xk1LAyCRYjdMe5EJT
	 F4C94JghLv6W3ASUdnIUqo6Jy1NsK5MLYQ2mbKXjY+XZ9b5obbUiQa6H65d8uQBuSF
	 pJ27rxPheK/zOkZAHtVUDBqvl52O71EYiC2oTfeqyfEllHN2wN7P+bYt2IAjH13A4E
	 eo0nawChSWm5slaRvOewnBpI0R3sXrjXwPxcOafR8d2FBS341qY+VuVZoIlqKTm7dX
	 ehdZu0GQMaLKqWKQgWMvAJotLcctTB/gW+xya+5nGErSDWJ5A/XSkDO0+b0pd+dCoo
	 rkwC4b+bSjbSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A02A80AA3;
	Mon, 12 Oct 2026 13:57:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ADAAB179
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93BAA4010F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmLWPIg1_gmr for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 13:57:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5EA0D4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813453;
 b=LB1Atj6v62mSsnemWKYRvZmGwC6kbWG1JGnafNwq+Wlv47FvtEeolddCoMm0b45USuU6
 09AFTZzvRJmuTA5wAyqQwSoo31xlD0VOdlTiSN181Jul2BAVAn0YBnwNjRDbFhJ4xc6+M
 3lct5zpUQEp+rAuWNcJjFMu/EBykXtfsZbXV1KRzqCF/6Ru5i3z1M3RFEXiVOedKnli/B
 pfPpFxZIxIXMRxZDlUeKIjDwDu/hqrwD8eFdrbmU5S8MImWFhDTji0UfXdXxwOIeQQinY
 eVND0HZxW/LVx9w5MJcX3G7gmckkzeGWbU0VLqUBqhuGB9psL1gZ8ciUQUL349VZNQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813453;
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
 bh=XeXI3TBtvvOwfS7OSPVPh/KJcWLIuUMploMN576Cu4c=;
 b=fmcDJfBglOX0kbSbAufb0J7vayCitgVcVT/yK2gDfHdfjNS7Sv4iviGo+vgSAeJlJN5y
 dnwNR5gwH3j3RgLNW2+Es5oMTii0sOCPHlCle80P7la36nUtrfNK2nZsOFkJtg7x3A7vJ
 vfUYVRcieVwFquZtby5KQXs9fLLFrbus/lsKHYAqUMl8Uhm25aE8zD358RsNmoV+ruG3t
 W9A8tBFn+vfJQctxPo3sIbz+5qbbyp/j5EJEb7+vdykHsVASGzgEH7khw46MVLFb+dRu5
 jpU6vCWK863PJhAOs3n3lmKR86c6tfIrJ5uzhlB9ChOajqLkVO3K0IJII0Nc4OWAlew==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IG5mx7Ag; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=patryk.holda@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IG5mx7Ag
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EA0D4004D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791813453; x=1823349453;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U+T5SWdgbqxpaTdAto2MSnGJVSXLFDZsZgxyH9CNKEw=;
 b=IG5mx7AgZFgWlhBYgZ5Se55GSYHWn+eZ1+D9Uog7CHZ7Tz2VYdY05lka
 EnLj+0+KXLZXgRv7Yp+MfpiAL3/LLEyq+ZPXN37ArO3xpU1EvnleUh7lm
 myRXLV+9G8Vyidq+tBLJOdpAaFLUTrIQqmrMZgAqTiMhAjcSbQgvxvbZL
 N7zgwX+7WoafMxs6LBFM5ZBddLSPrP6s2F+mAmC9VVYYSXCSh7AWi5dwA
 4yYc0xMY8pprf5DxYrTaM5sNjQaZJrjtQbNYWoETBEsw3h1AM3BLmd8BP
 dzvXaVaOyRkiwNxBkf9bbbceLorPeGWCGZS42uXM3m8XSzgoLd4yeQ/Dd A==;
X-CSE-ConnectionGUID: u5mSIlwVTBmhMUtWdLGSCQ==
X-CSE-MsgGUID: AJd32nTWS8SR6cS6eW8Frg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="544947"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="544947"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 06:57:13 -0700
X-CSE-ConnectionGUID: ar5/9tubRjWL1P2CuZ33iA==
X-CSE-MsgGUID: dgSbEy5tSqGASDTGsxU7qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="913175"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 06:56:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 06:56:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 06:56:29 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 06:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWXJc7CHRq+YqjIkzIA4rBgcEM2Q5LGsB70m1aOl+rn3ZYfZcohf5JZCr3ePdIMWl9fmgA1gxh13Y5rmnvSalGQYiwdWuAoQVliyCfA1dHul8Iz2+tIlEHqUu1Sq8W/454YqbSR0+DvlqDt0M9VdsDSRjftvrdH7T+tgt0/dAe7zmTrUT6JJkGnfQgMJv2JThYhm8z5bUQ/JLCQibGzLEWjUl2I+ny13xpQaS5nH8806cUBDwWx6RhyzJa7MIoPdZCSHIBhwMDw5gkYUx7xSEOGtxI4Qlghpc1wpkQUS0XGB5xWHiKIUk6/BklqcFbvJQZ7ONla5Z4d38SGjNuACdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeXI3TBtvvOwfS7OSPVPh/KJcWLIuUMploMN576Cu4c=;
 b=NJ/RpgUygijARkoeimE0xUDcCEr2fXyGTVWiJwpvnKnIV/PlMrZKO148ujGQGk0lAQcr6u6adG9y9EgLlbrKRQLUINgvyizWDKLZ42wAcpWHQ1n7SIPIwsSCewk7GpBD/4CzuXZyg1Xvg8l/En7JSzNQTw6IYb0BialvUrvQxaVdSXlSEd9Km7ZRvpIBwkVg6AJkbpBxD1L7fF7NpXbAf9L2vSj2mrjxdru2IKkl95/LuRruzY4H9pVAngZLFDmzrtiOvF39yI5dA94vykHTdpS2fsKfU0UX2+/nBUAosymyTZlSOGB7aOwNNHDpe5EGTkBnL33+6mDYBYDYF1EDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 13:55:37 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 13:55:37 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Wentao Liang
 <vulab@iscas.ac.cn>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kalyan.kodamagula@intel.com" <kalyan.kodamagula@intel.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Swiatkowski, Michal"
 <michal.swiatkowski@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: RE: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
Thread-Topic: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
Thread-Index: AQHdRpZqXDnztcfZrEew4RFsiLmT0bbSoj8AgCdzPeA=
Date: Mon, 12 Oct 2026 13:55:37 +0000
Message-ID: <IA3PR11MB9301A9DD05D22871DDE95AA98A9F2@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260917111114.2148482-1-vulab@iscas.ac.cn>
 <IA3PR11MB898619C38AC2792034B229C8E5B82@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898619C38AC2792034B229C8E5B82@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|MW3PR11MB4652:EE_
x-ms-office365-filtering-correlation-id: 8eb24ac0-3d91-4f0f-7b46-08df28687e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|10067099003|18002099003|38070700021|261009223027099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: dK0cGe0gSsLDreKj34c3bdHBxi8IYhcrWHfl8gYg2OZpSGuRDmLipi3lUQHl2o5HndM/St5deQ/7VTBlmS1NVfblavBwraCvazUpJW+Z0pMr/5ijUNdTvgZMIQo5YUNLkELOF1YMBuBiXf0hoe7r6QK430RnneXWlJMr4/felRgcgzmksIyNqQ3aoLjs1DJioOWMEIz7nzt/aMSmR+zf7yi3hlhxkAP4+St1toz4sEe5LW3yhLgjNNy4+2TVXGrRbWfWxDeVY7u37H0F/LRA1O5ziyPYQN+D8vf/sC4NmRVeLK0eC/0ZPghEeGQxXtNCQuS504aRSawMON5DM1CINxDwBoAftgsVSm5X7gXZg7q1muIhnE7fGb99CkwWiqE4+z19l8SwvZPl8NqG6CyZIw2pHlkFbbofbG7n5nj7W4Stz1vBihCkEfS1eAIrgFVToi/WkVyWbc5ezxHsSaVZdADpHT1Ecbg73Q/oRE8kDN2WalNof9i0faf4GepWlkj6Zi0xfsXU6FqGn8ckIfJ+jMwLb0UQFjQMuFnzJVupgS7baSSwqBgtqDB+/HnKI0v5XojRM580LiZhoiFmBpIdgkcrRjB7AIy68fVekzoY5TZQPx5IrT2vnTRZrjdFVegdFEjBCFISnQ9FIEHjwLDwhIk1lI5yMxgiva/ZlS4VUlLPkAJ7SCeQcR8h0pZFlHF2O1O03bRQTgOkrwp556UzSvl9etD2ZvDgOAOF8yEQNIM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9301.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(10067099003)(18002099003)(38070700021)(261009223027099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T1QxhtSaDOHlS2GRM6JGolTh5l2R3EyQqXp/ooRBxXvBezRaIUnmjdilDx?=
 =?iso-8859-1?Q?fcolVAwMvUIlqiBO6/yffHhdZym7AxbfLxIkWPMcxApJZO7TEnxqXT4eiQ?=
 =?iso-8859-1?Q?qY5ge7GEr84GQhxQb2W11OWRg5wMXC4fR5g96mO0ffF4UNjmrEX1jN6v3S?=
 =?iso-8859-1?Q?EYO1x+J+YSfhzHJLN2u8wBoMtMhTfmCMorLf0DMRQh+0kdAXP3nzrHW2tC?=
 =?iso-8859-1?Q?hNbJpEidrWd/teGDkVlMcJydd6QVMEkcz061fywbYqLvabt4+hx6YgTuCq?=
 =?iso-8859-1?Q?ajwFLbI0t+eC6PIVjfj7El4MZZLVjTQZC+ozwj9WqbFs0hbL+kRX+aZc4n?=
 =?iso-8859-1?Q?RYNrT7wgjtlryUF+VjEWchhNUJtgYPjV7NYZiScgKbIDwRN8M5Co8jO4cz?=
 =?iso-8859-1?Q?ZKPvGcq2VLq4Dgh6mdMI5IiUhTm99/26g0G0EKMTI8hjA0Ij9k55h2BdpF?=
 =?iso-8859-1?Q?+4UfS856n9uCW49us3YdpchrL/7DE0SHTEGW5mIflytZdI+fayFlTB1tzR?=
 =?iso-8859-1?Q?fkgqEUaW0RiNtnFsneYdctVwDOfhzbSF5fQOyvRsm8tW0PBiYRmpQ6sZXT?=
 =?iso-8859-1?Q?rsWVwWDdfapzYeeDiX3GiRc0MiGFPtcwxUYgBLPnpoDCoEEHAjLZuKFBVx?=
 =?iso-8859-1?Q?WAkLqOKPMscT51YCf/dLVHcGY1ucDCv7MKK/xinKl60M2DXDCjvJFaYsAt?=
 =?iso-8859-1?Q?WkkYn0oIQIIV9nIBp78JHmhhP524EzPlSMbQ4H7xphEZtnvqe/C2HxvUOL?=
 =?iso-8859-1?Q?QOTXlVVzYFEVKVLV8rc/7xXTAqZJ3o5LWkjrg+MhRIuvfg05BbNdhCwJOi?=
 =?iso-8859-1?Q?1FlhnNkNmlv62GJbcztQqN9dcRhxR17cokFIiioGb1ITvB5njK9m1Lhbdu?=
 =?iso-8859-1?Q?AH7CnSQf+6yLaJJNt5DjEQc35u5+5uhQ6tVwJl4FON5bGkTZXIhsWE685c?=
 =?iso-8859-1?Q?/C1ZYala72/8bf7j8FWrpF8amY8poLby7xqUTHf+FqaqNj35Wlqd7FO+CT?=
 =?iso-8859-1?Q?U5KIhrIbcUYbNOnzr6gvnaD7OfDIrFTiLRx/FFqV0rsDET5e4WMG2EdDFV?=
 =?iso-8859-1?Q?BQVDidg78ATptP7eI5XiP1NlHjphzHxr8IS1ixv0RAuyGyRZWh0ZhBUBod?=
 =?iso-8859-1?Q?NhlSOij5a8Q5JHLSNpkyxAzBs2UaRVXGp0apaPIKGs6qzzPuBIwMSXTh1C?=
 =?iso-8859-1?Q?oGtDy0POC5mPGd0t/71ACQNqJ3aaifCOAK0FNWLJqHn3coUfFtQgrLF0vu?=
 =?iso-8859-1?Q?MSErX+/H9gRT+LcmxKVMVEbH8+7j6LioyGnV9XXRWM5BMLtKopNQ3sAsPq?=
 =?iso-8859-1?Q?x3kkrnjP1JG1GK9tjIyo2ivo4hFwH5vQ1g/w61UBGDYm2dRd+E+3eCCeIS?=
 =?iso-8859-1?Q?JxG+CGWTD5FbE1Bf2v6ogj1EIUvOy9TuAGe++yR2rXseg7ZW8JcI3L5HtQ?=
 =?iso-8859-1?Q?nP6IDJFmXHGb7QWmU2kyJjyNaUe8l8xmxl8wSUkgU9Rtba5ewh+wESfJvG?=
 =?iso-8859-1?Q?+BEnk4wqpvDtXEQAgso+v+nEHVZ6NVA7WbltAHMsmXo3kcXyHNNPND9Nz7?=
 =?iso-8859-1?Q?p4ll/KjvFvH8dyg3VWy9x7NwgufgcEjSSXmKuHGGBsH6UyNpppisO2gAVQ?=
 =?iso-8859-1?Q?jPRcJjAAln3DzwpKYJHu3ko5rk9NoMb9FC5+eGTu151c/DZAEVaXbhp3gL?=
 =?iso-8859-1?Q?tHKKw0VhWbxUiB+n8qlm2pKHD66r9KfhR4RIPwDFQ1NLz1bxKhHclU8AD3?=
 =?iso-8859-1?Q?tV2RUaVhoBdOy0Ldu+1rWeyMGsuqaP7NGZneFRlLPYBBwE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S4i7jNV5Q43i4xb5Qw4065O2xOFZGYEU6oumDb0acqXL+vdnTSf2LZFtcMKhoeUjLxbH7ErcFJEQbGWKf/YvaLAR8x8+YxjgkEdu5rTpYncK7T5Hgv8kqX7n2eksAGt1jIEA4RDk+TSLNRqymGQgBzq+OfxP7KMbTFQvaWOEOfWwp0G1lq51JXbdr14/0W7Qztxek1M0ZFO+fxlc3I9XpwlAGREkIcatlcegmvtJl6OucHxIYfTW1L54L2OjJ04MHFwKsnezc3BV6PXUr5da8/OvlKiYoDea1YyzqdIjpaJcn7WwXWahMZLRCA2shxyQ5J2bHRPVqYml4uo/oXlDEg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb24ac0-3d91-4f0f-7b46-08df28687e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 13:55:37.1527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfC2lOQnhPf4aGbN4RtsOf9IUt/2seffCVpbzit2RrMSjINL3JBtpA+cQOzTaoGSIvaCa62CsnG0MzxHfWbNBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
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
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Thursday, September 17, 2026 1:29 PM
> To: Wentao Liang <vulab@iscas.ac.cn>; andrew+netdev@lunn.ch
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> davem@davemloft.net; edumazet@google.com; intel-wired-
> lan@lists.osuosl.org; kalyan.kodamagula@intel.com; kuba@kernel.org; linux=
-
> kernel@vger.kernel.org; Swiatkowski, Michal
> <michal.swiatkowski@intel.com>; netdev@vger.kernel.org;
> pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> stable@vger.kernel.org
> Subject: RE: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
>=20
>=20
>=20
> > -----Original Message-----
> > From: Wentao Liang <vulab@iscas.ac.cn>
> > Sent: Thursday, September 17, 2026 1:11 PM
> > To: andrew+netdev@lunn.ch
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> > davem@davemloft.net; edumazet@google.com; intel-wired-
> > lan@lists.osuosl.org; kalyan.kodamagula@intel.com; kuba@kernel.org;
> > linux-kernel@vger.kernel.org; Swiatkowski, Michal
> > <michal.swiatkowski@intel.com>; netdev@vger.kernel.org;
> > pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> > Wentao Liang <vulab@iscas.ac.cn>; stable@vger.kernel.org
> > Subject: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
> >
> > ice_get_vf_by_id() takes a reference on the VF, which the caller has
> > to release with ice_put_vf(). The switchdev mode check now happens
> > after the VF is looked up and returns -EOPNOTSUPP without dropping
> > that reference, leaking it.
> >
> > Use the existing out_put_vf label instead.
> >
> > Fixes: 83b49e7f63da ("ice: check if VF exists before mode check")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> > b/drivers/net/ethernet/intel/ice/ice_sriov.c
> > index 7e00e091756d..202224dba1a3 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> > @@ -1384,7 +1384,8 @@ int ice_set_vf_trust(struct net_device *netdev,
> > int vf_id, bool trusted)
> >
> >  	if (ice_is_eswitch_mode_switchdev(pf)) {
> >  		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in
> switchdev
> > mode\n");
> > -		return -EOPNOTSUPP;
> > +		ret =3D -EOPNOTSUPP;
> > +		goto out_put_vf;
> >  	}
> >
> >  	ret =3D ice_check_vf_ready_for_cfg(vf);
> > --
> > 2.34.1
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Patryk Holda <patryk.holda@intel.com>=A0


