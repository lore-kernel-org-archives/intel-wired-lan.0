Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F77CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F8934066E;
	Tue,  6 Oct 2026 01:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4wOFoJ2Qf0K7; Tue,  6 Oct 2026 01:43:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9A08B405C9
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791251017;
	b=hU17VleN5pxQcH2kBZM7ObR6raZ0rrljNyRdAi1QSbx86tF607CFmP6VRnTglOli5SFx
	 wSZSapzehUCn1cGUMHXp5yPtYLWvfHT7mJwehg2SThn+a/RPHplAxOGaDecEDUYbNkbrp
	 z8LtfDghw+sFJeP6/yO5oPOxT09Z/tKjDuPp/fnJT6sIpz3WEcfOA/k1suJqIzi34frsC
	 T3EhxzWk8goNnnFyY9CXSk1wwF3mc3skCSyC6K+9iHpI/cv+MLF99Z4RCPwsj9Hnzzrck
	 T2QhPnkJHcPZeL4NNI98KiZ5jfw6e/zPE7MzlmFbEG1LxBh8Ffl5B/WaBu94xiRpBrQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791251017;
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
	bh=19LY5iKZY+qBDdCXN0iAMk47F3slxHy2TXEaA5Y8h6s=;
	b=Q7G1COPxCueOPYQtGnzq8fJlbxH1WEAEdEijFnWeSMOYF9LAMtWqtTPofI4vzVeJ3D7D
	 1OJ4jdGL4PAv2Rs3Bcpm4B12go6PHqd3Zm5Jg40O/B7POtacWI3Hnik91h4hth0ehL5uN
	 VCzGGOPnG6Oc9/QkBfAjaOJ9asJfa4bJTr/tGmaT6YRSu20rDa9SfsfVS8IqrRe5Y/w7q
	 74h6F+Rf/vOKmOKn0x3x9xKP9+qVtoaVXFtB/ncqvN9nGOR4f9TBEy/S2horuLUFeNxA2
	 7ZF76iztXleUk+Gek42XUtSc7Uvl0Ypcphx2OKItg1K9/IuE1ldDdsBjgn4XPoUyYxw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BWmMOTel;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791251017;
	bh=19LY5iKZY+qBDdCXN0iAMk47F3slxHy2TXEaA5Y8h6s=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E09BOy4X0mt4ul2BoBFeWGE7zuaR26Xbt/abpjhKV0nWTu3OLLXi/F7Mtvd4SixtN
	 HEoeTejI5j1uIiHoAjsfdor1bnuu/pMvWylRUVLiThiFTsLuVdFpxIX8Tw0RFivaYg
	 A3t7iZFeSLU+R0lLQt+w7I5UCNgMCnuij3TiOSXT8Re5OFmMlY7lj63GNILpAtFXj1
	 S8giv613ZLgvpYbBZ0YwLQcKtXhHytLL3WsYltUXkBjcV/erqkyoXU5/z5lMDcvBtd
	 t5ZGExrbb88+AD42RnTntr1zNp88yu7LtqVeYe0t5n0bHtl+12W3glp8rwUDjHCaIO
	 PdqGYrUbFTTiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A08B405C9;
	Tue,  6 Oct 2026 01:43:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B3D11D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41B774064E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pZ0EKUddcJSh for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:42:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 80C8E40600
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791250920;
 b=XgFXGGvpYewIi9RSHIkrszNLO+fGYBISJgsDjwjlRkwfGrBJA7Z3MdxFU6PvfGaSMdaN
 K7wKbiQdxG27LUkRCy/XFw2iZQ+vhdo/Y21cGLcQoi+lw4UW+SvGReggZrTY2wr3CpoD8
 qqOiMIqwXgHtB7UJrGNt1rwhvP+qrvtUY3iKE39+MWqEhmzCSZe48FJc2XD+0tAeTZ0zr
 vUYiM5VRiF2TjutwEDtmtezo24BgKB64XfcRL+dmfc0UqKTqFNCPmuJZH6KLOqY0R9NN0
 PdIs+43NdBfZIquMsEerLlXfC5a1z1O1mSyj48M9TAlXFNu6UNiGDUMrw9Vb9zVk8EA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791250920;
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
 bh=19LY5iKZY+qBDdCXN0iAMk47F3slxHy2TXEaA5Y8h6s=;
 b=YugyxaR7Md8rbQt19y7lTBy3PFLS064berIdSOwpiTbgugV0TdMEcXHX0gyo9nZCkmJS
 rlBjePhTtwnkbXSLjAFCkNX0zj6aPL7wcOWcibvyz2EheKmyIb7qCajLkeYnTRmAvTlmQ
 xO4503WYHIpdYqB7zrKJd9w9Wf9pZnXn3hTohj9kAJcBw+LieUGFu55GhLjPkRCWJaqgO
 xNdF1+7DNQMwHGXhc2cgQ5/YjeSlwd9zIJsVkwn15eFghEiHXU1+0xMW6K6QodvMw/fC3
 79yYyos5a01wP+DxQnpOTPiq7yatCBosYbLZ294vPKt/AYwm7t8cKmzkfZgq5y9abyw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BWmMOTel; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BWmMOTel
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 80C8E40600
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791250920; x=1822786920;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=19LY5iKZY+qBDdCXN0iAMk47F3slxHy2TXEaA5Y8h6s=;
 b=BWmMOTel8wfn+0PhKEPVtv1XfmpuB9DEOs/ssIzbcHr321e+MtN9KBmE
 VQ1caOres7JLFXijKAsVm/JHNzyNmVmaA781BR0N+4HGbGMchFC2JOSmP
 AsBumDW57neg3vBpCV15V8Df3lzgIFXE8MPgI9WYQnTP9WrYGQ7WE4YDK
 UwaJPZhngA8LPAr0GzLa6ib8qqlgZYb9t2pROCrm4iOzSzCMmN7VgxMDU
 9wVKn2QsAJ4rU6DAi9jen3JNNQk8KHBRAn+zQXR5TazgR2Kr6S5TBqgdG
 cmcDwrWc0p+ufOKjRb0nsdREwApHRIMKo/OaXXQp+10dI9zfbWzljT6xK A==;
X-CSE-ConnectionGUID: UVqPvCkPQrOkmUQ5prZkhg==
X-CSE-MsgGUID: WgpfSK2mRTCbxyZaI1+Dew==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="92042274"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="92042274"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:41:59 -0700
X-CSE-ConnectionGUID: OijE77GyQ/2lj5hT2CfhoA==
X-CSE-MsgGUID: 3VW4F6KTR/2FkhMJBrk0+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="277108636"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:41:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:41:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:41:58 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:41:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FddkTihGZWAgOFK5CmJDgIA4+/Ow0ptYQDUhsyKajDdnlcI55Qj3OXktzyS5Q1yN9u00NId5q1WkRBv+lWhtycZBuZRred+MS/k8AEYIuhQ0Jq3ArFgP4174I/raSyyWKyAOfSN+wM9qj55Z85J4zyzXAXy5Us2moAMkCW/tLMQWyDStLWP2BSDyGmKB5Ft8Y0X8STmlhUYf+oNcmrhXx3JycSRlZfjVFH5uJ9/4IXR8u43rc5QFWe/6kaPp0J6WqSCErmE4ivRYk7du2pBCj5etM4QbZPzdXvXTnP+nzKs9PmJGU+NZg+lFLtv8W0hNgZM/J0kfJeWlp6MglECeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19LY5iKZY+qBDdCXN0iAMk47F3slxHy2TXEaA5Y8h6s=;
 b=SV+5rhYIyssgMkp9Rs/xqIvBOhYAWn7+WuVzJOAKswkMqDALUk98eqUw29vRqii+xOJEqG1buwlgAsZzliSFz5Lw40ra+X+RekwxzFjC0YbZguE7sx1V76J/y7K1NRuSVlGlc4P9/fSKpSBI5rpaPNttcR/rLngrM86CvesDZHjT6pWdzxYivIwqDxfb+01Hqoh/Ec5R82AgklsAfxUEKtHAxm/xltBGDZrg4ZLziu0cxP6+fmOGJrax4CNAzxYnL6Elz1nYbAwuQE7K6QZLRNJZ5R2b/PNa1ZwMs8SpLIs2a/jcJ1bS8zYXars/ITR9K2bq+Uw+nz/QHfxZKxmEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:41:56 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:41:56 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v3 09/15] ice: E825: clear
 PHY_REG_TX_MEMORY_STATUS prior to soft reset
Thread-Topic: [PATCH iwl-net v3 09/15] ice: E825: clear
 PHY_REG_TX_MEMORY_STATUS prior to soft reset
Thread-Index: AQHdTUnFZSJutCUoFEe+oRrDx9NriLbvzQKA
Date: Tue, 6 Oct 2026 01:41:56 +0000
Message-ID: <LV1PR11MB87904A9CE81073AF230783CE90952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-9-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-9-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: 51fb1706-69ad-46ce-31a2-08df234b0177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|10067099003|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 03Wo0XniCYKFdRAsD+lXdGldHvWKFCdKRCW3GDVD/VXjSoTVw+doEkeyosmrwjU4eL3KncnzvNEwvce9jTZyMlBCpSLVjW17kVFL6ZIMcal7UU4ihUElD8z+1heYffQ6tki+V+XQ72cLaZPgGN7D78obOQw3Xu9DfBFVnSc8VX7DU2x91ZhdOw9jIVd3QBsBikRGS6iqG7vauE61M/c8RhucjbBNoe9Z+ZxnuNLPWoGzV5hUEesl3oAxnGj11fE3GQUMY72D2HN3IAuLrCQS9grmgUtoMXal1DrR6Kc+DdDhBkn+Pvby30Ndi5IfEEPAD7//EImgm+b/QMCo6F30vE4bKUmbR3JYLT7QH0ItE2ETsmZeGGcUpOxc+tvuOZQJWUs7KHp0KnWKdrs3w+EBqnupAG66PSxORDIWCN+MMnCWkjuYhlA2g06odtuOax+gQ8vYVNpjiuJVpG8NEodB+p10dYx6wZQSQRja7mBQE8LAc6iA88ZLretAH48KEPzSUH8MBPFG9piFo+6rdxCFknB3iyrGlxQp8QgW5TDnBaQBSFC9lppSUCAo3DbrKgT6hHGiC+ZLoKRB5eqKXF3895HKNmF9T+hZip7iIvkDWA39cVFgbZ1V8DoYWvjd5Z2DF4hCezdiqaOwEvgH8+LLj7OoYcxpNU6UZ1VlVscWU1xvhvkeGuTBliJKsHjk8pkdUDyPJI9LGJ/gPiozrBuZzlNw1ZJctzKgC0QMbTOM6XlH7cuKcxasHUNI2M+iYgDh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFo4Y1ZEUkVJR1B0KzdSNklDakd0MVJ0YklPcFZlYjFpazlXaUNPZDRvME00?=
 =?utf-8?B?YW1qcG9rQnBNR09qc3NGYXhvcGxHNkpqcVVFRnduQ0RoQ3o0U2xsSi9qUnlM?=
 =?utf-8?B?ekR5d3hWRVMySXhldEtVL1RHSVJmY3RxazltK1NERUhhRnc2dnFrdkFZRFRr?=
 =?utf-8?B?cWJ5UXJVUkJvclFNaE02SXRGZUFHeVZST1N2QWwwdFdRUUdjT3VPQjJMb0dP?=
 =?utf-8?B?ek4xMldTQkU4TXVLN3Y5VklwRkw1YjBlK0FLMWxocXh0OE95a0JDNzZxQndI?=
 =?utf-8?B?UFV2aU9PSmNubG8yUmkxWnJpQzRueXIxeWZMQjkweGZUZ25EK1Eya1V2VWhv?=
 =?utf-8?B?c0dKZ0hOVEhRZit4R3BaNDNVcmpyV0t1REIyY0RYZHI5MmcyMURld3pUK0hW?=
 =?utf-8?B?eG5Md05sL0xSTjMyZ1daUUhRalZoeUVxbEFKRlNVVWNCb2FZSENIV3l6K09B?=
 =?utf-8?B?MUR0Rk1GbkVQeDFiN3ZWb3VwWFJ5aHpFQTJ0SFA3dmVtTG51ckVhTVhib0VR?=
 =?utf-8?B?UG1BMG93ZVdTV2Vna05qVjRDOHhlYmNmTEQ3RDFjQzE5TlFHWFNsNzN1NmNq?=
 =?utf-8?B?TE5GMDhYL2VKYkVTRzhQZnQ2U3dyTE1LUTd0TkpJaEowdE93V2NWOGRDd0t6?=
 =?utf-8?B?UDllN0RMeXhjQzFmTHp5STRDT0FEY3VKUWUvRlZlNTkvYitMWUdBTTYxTi9k?=
 =?utf-8?B?UUEwamJhRUE0VlRVaEJMdjBMSDJnMTdYQ2k2YTQ5WXNSKzNKTkc2WWFWeHZp?=
 =?utf-8?B?blRyWWhGZXRpeEVsNkFaaGZFbzFqbUFubUp1THpVZnpMK01td21BTVljbDR4?=
 =?utf-8?B?QmpSL0JYWjNCZXBlcDROQ0VpbjVWMGRwbVllRWdMSTRqRFQ1d2RJVUFVbzNC?=
 =?utf-8?B?N1BlYStmWWVLSWYwMnZBQ1Z2bkNsTm9EeU9aMmdNTHR0SXl4dmYvS3A2OGpY?=
 =?utf-8?B?VG9kNHhvL0hlaDVsTjAxWWRTOEcxb21wWnR0OUkxUmMwY1FVdkVPOWpOTVc1?=
 =?utf-8?B?RDJmdmx6YVZZcDhYNHA2T3l2akwxbU5TUFgwbHJkMUNoRmNPbnlGWENVRU5j?=
 =?utf-8?B?WXVJUVJEaWl3WEprenRJYU9UejNLQVB2MTA2U3VkbkoxQWVwdGw0a0hyUE1v?=
 =?utf-8?B?OWdIZlQzUWxyMGlJN2hlUXIzNWNvU01vdVV4bWVEM2NoencyVXQ5T2VyVGl5?=
 =?utf-8?B?OUU3WlZqWnk3RFpReVF2L0pqbkZidkNmM0QzOTMvQlIzeHBwOHNtUGRTZzJt?=
 =?utf-8?B?a3NqcnBSdUh0elBoeFNYM05CVTc2WEZUQWlVUlpVUHNJV2x3aWZ1VUpkVW9M?=
 =?utf-8?B?b2ZJb2lHdzd3MHZJZnJiUjBCSzIzOEJGSUFndjB0U1dtMjFEWWVyREtlVEpQ?=
 =?utf-8?B?NkErWU8zcXcyVW9jb2lDNWIySWhJeVNaL3RQK1hDOUF5MStiUGhQNFVxMU8r?=
 =?utf-8?B?T0tBNm1aVDVoYWxvZHFjTnRJdXdqMENjMHV0K2IwYS85LzJXTmJvMklEdjBO?=
 =?utf-8?B?eXBKWTEwS2dqa2dhbzF1ZlM5UEUveHdHRExhVUpDbDhIK1pacG5tc0hNcno1?=
 =?utf-8?B?Q3VJR0JEdDBWYzY2R1BlVVhaYjRjdTdvUmwwclNUL2VQVktnV0xubkdONEh4?=
 =?utf-8?B?YVQzNzZoQmVNQ0JORC9uL0Z3RUVlRnRvYlppYUNKM3J0eUFKRGZwUU9kSnVp?=
 =?utf-8?B?L3dBRnVpMHl6Q2l6UDVTNjhSZmJKMUFMMjkxWi9Vd0ZWUDhHUnNmQnpVVlpQ?=
 =?utf-8?B?TWJHNW0rV0hOZFZ5MmJDTkQ4RjFnMkdyMjJqVld4OEYvVEMxTnYvTGhJU1Zh?=
 =?utf-8?B?aysyS1paand3NWtiTE5KRmNHNmlNR09KWW41Si8wdTFPM08xL3BJTGdHNUYz?=
 =?utf-8?B?dHNEZ0tqSVVoY0hMSnEvaGZxWUs3TkFIdkRrMXUvL3NwbkdZdUUyaWdOLzI2?=
 =?utf-8?B?WXo4QWp1ZDl6YUVYMTIrWHNyblM3Yjc4bU1LNHlGRjFCL0cvVVRDS1grbkIr?=
 =?utf-8?B?L2hkVFhLbkVJblp0UUlDOW5ndDV1RTFkWEowWlZDcGROc0piQ2lzeHJVNmZ6?=
 =?utf-8?B?WEZyaXQ3YkRVNVdxNzFDSkM3eTBuTUpVTUhKZzdYYUN0S3M0UmxiVkRLekpj?=
 =?utf-8?B?MWd1U3lHN1V1dXhrUTM4eEp3RCtDQkU2bEVXK0picTgydTBTQVJ3ZzBrZzl3?=
 =?utf-8?B?L0libHV2SitRYVU5VnpnNGFpVFlUc2JVM1Y4WEowU0gvWHYzbFB2dVkyamV5?=
 =?utf-8?B?dDVjZ2YrcUZoZGJMSWp3YWljOHlmUzRkTE1lQ1RBVlQ1d3ZKNm9STTRkamk4?=
 =?utf-8?B?ZHJCQ3dURVNNbmEvYU1MVWV0ZUNGNnhka3JwVTZpT3R4eDYvQlJ2QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P8QlM/1GSUOiCKuGMRurbTYLgGquhHlJkw+dIWx1Vpx7O+pGP734U9ZkBVmX4JPPffUQMlvCm4DV20ZaDbLXNrCSY92441HU0qTzenPjIt9R4LspiXAS0h8j43XtV8FyeaNehF/7FNCJTrJCWs++4EtAx4+s0EY+S0PgciivCOeUdIHGyLd1u0LEhSaAGmcv9SRfOJEgn17C9q8BpmeHzyr4I4GVK+/NFWvAcOaR7XH8tmm8+7b15xaSGcAeq8xEq/mfXJdFp1ceDvgSkoMZPW4B33DWhiBke4EAowZG/NaXTSZ9DJ81bilLj5S6ciukMJwa7+5qsIHGmk8AaCAL9w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fb1706-69ad-46ce-31a2-08df234b0177
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:41:56.3545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKoV9rcRBjA+zdBOfaENnkP/omfhtWAXdOIlpXm1eTXwpGtlDuVel4Y7/ml7iRzrKjxn1NHcADw9RX4cTGuiuvPIojO8Rte9VH0G1+2SKN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5907
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWNvYiBLZWxsZXIgPGphY29i
LmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI1LCAyMDI2
IDQ6NTcgUE0NCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9z
dW9zbC5vcmc+OyBNYWNobmlrb3dza2ksIE1hY2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRl
bC5jb20+OyBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47IEtvcmJh
LCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtvcmJhQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9u
eSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IE5pdGthLCBHcnplZ29yeiA8Z3J6ZWdv
cnoubml0a2FAaW50ZWwuY29tPjsgS3ViYWxld3NraSwgQXJrYWRpdXN6IDxhcmthZGl1c3oua3Vi
YWxld3NraUBpbnRlbC5jb20+DQo+IENjOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVy
QGludGVsLmNvbT47IE1hY2huaWtvd3NraSwgTWFjaWVqIDxtYWNpZWoubWFjaG5pa293c2tpQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjMgMDkvMTVdIGljZTogRTgyNTog
Y2xlYXIgUEhZX1JFR19UWF9NRU1PUllfU1RBVFVTIHByaW9yIHRvIHNvZnQgcmVzZXQNCj4gDQo+
IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIGljZV9wdHBfcmVzZXRfdHNfbWVtb3J5X2V0
aDU2ZygpIGlzIGZsYXdlZC4NCj4gSXQgdHJpZXMgdG8gY2xlYXIgdGhlIHRpbWVzdGFtcCBtZW1v
cnkgYnkgd3JpdGluZyB0byB0aGUgUEhZX1JFR19UWF9NRU1PUllfU1RBVFVTIHJlZ2lvbi4gVGhp
cyBkb2VzIG5vdCB3b3JrIHByb3Blcmx5LCBhcyBpdCBkb2VzIG5vdCB0cmlnZ2VyIGFwcHJvcHJp
YXRlIFBIWSBhY3Rpb25zLg0KPiANCj4gVG8gY2xlYXIgb3V0c3RhbmRpbmcgdGltZXN0YW1wIG1l
bW9yeSwgdGhlIGRyaXZlciBtdXN0IHJlYWQgdGhlIHRpbWVzdGFtcHMuDQo+IEhvd2V2ZXIsIG5h
aXZlbHkgZG9pbmcgdGhpcyBhcyBwYXJ0IG9mIGljZV9wdHBfcmVzZXRfdHNfbWVtb3J5KCkgaXMg
cHJvYmxlbWF0aWMuIFdoZW4gcmVhZGluZyB0aGUgdGltZXN0YW1wIGluZGV4LCBoYXJkd2FyZSBr
aWNrcyBvZmYgYSBjaGFpbiBvZiBhY3Rpb25zIGluY2x1ZGluZyBjbGVhcmluZyB0aGUgcmVhZHkg
Yml0bWFwIGluZGV4LCBhbmQgZGVjcmVtZW50aW5nIGFuIGludGVybmFsIGNvdW50ZXIgaWYgdGhl
IHRpbWVzdGFtcCBpbmRleCB3YXMgbWFya2VkIGFzIHZhbGlkLg0KPiAgDQo+IFRoaXMgY2FuIHBv
dGVudGlhbGx5IGxlYXZlIHRoZSBpbnRlcm5hbCBoYXJkd2FyZSBjb3VudGVyIG91dCBvZiBzeW5j
IHdpdGggdGhlIGFjdHVhbCBudW1iZXIgb2YgdGltZXN0YW1wcy4gVGhpcyBvY2N1cnMgYmVjYXVz
ZSB0aGUgUEhZX1JFR19UWF9NRU1PUllfU1RBVFVTIHJlZ2lvbiBpcyBub3QgemVyby1pbml0aWFs
aXplZCB3aGVuIHRoZSBkZXZpY2UgYm9vdHMgdXAuIEluc3RlYWQsIGl0IGlzIGZpbGxlZCB3aXRo
IGdhcmJhZ2UuIE9uIGEgY29sZCBwb3dlciBvbiwgYXR0ZW1wdHMgdG8gcmVhZCB0aGUgc3RhbGUg
ZGF0YSByZXN1bHQgaW4gdGhlIGhhcmR3YXJlIHRyaWdnZXJpbmcgYSBjb3VudGVyIGRlY3JlbWVu
dCBmb3IgYSB0aW1lc3RhbXAgdGhhdCBuZXZlciBoYXBwZW5lZC4gVGhpcyB1bmRlcmZsb3dzIHRo
ZSBjb3VudGVyLCBhbmQgcHJldmVudHMgbmV3IHRpbWVzdGFtcCBpbnRlcnJ1cHRzIGZyb20gYmVp
bmcgdHJpZ2dlcmVkIGZvciByZWFsIHRpbWVzdGFtcCByZXF1ZXN0cy4NCj4gDQo+IFdlIG11c3Qg
cmVhZCB0aGUgUEhZX1JFR19UWF9NRU1PUllfU1RBVFVTIGluIG9yZGVyIHRvIGNsZWFyIHN0YWxl
IHRpbWVzdGFtcHMuIEJ1dCBkb2luZyBzbyBtYXkgY2F1c2UgYSBkZXN5bmMgd2l0aCB0aGUgY291
bnRlci4gVG8gcHJldmVudCBpc3N1ZXMsIHBlcmZvcm0gdGhpcyBjbGVhcmluZyBhbHdheXMgYW5k
IG9ubHkgcmlnaHQgYmVmb3JlIGluaXRpYXRpbmcgYSBQSFkgc29mdCByZXNldC4NCj4gDQo+IFRo
ZSBzb2Z0IHJlc2V0IHdpbGwgY2xlYXIgYW5kIHJlc2V0IHRoZSBpbnRlcm5hbCBjb3VudGVyIGFu
ZCB0aGUgcmVhZHkgYml0bWFwLiBUaGUgcmVhZHMgdG8gUEhZX1JFR19UWF9NRU1PUllfU1RBVFVT
IHdpbGwgcmVzZXQgdGhlIHJlZ2lvbiB2YWxpZCBiaXRzIGVuc3VyaW5nIHRoYXQgbm8gc3RhbGUg
ZGF0YSBpcyBsZWZ0IGJlaGluZC4gVGhpcyBjb21iaW5hdGlvbiBlbnN1cmVzIHRoYXQgd2UgYWx3
YXlzIGhhdmUgYSBjbGVhbiBzbGF0ZSB3aXRoIG5vIHN0YWxlIGRhdGEgYW5kIHdpdGggdGhlIGNv
dW50ZXIgcHJvcGVybHkgcmVzZXQgdG8gemVyby4NCj4gDQo+IElmIGEgcmVhZCBmYWlscyAoaS5l
LiBkdWUgdG8gYSB0cmFuc2llbnQgc2lkZWJhbmQgcXVldWUgZmFpbHVyZSkgaXQgaXMgbm90IHRy
ZWF0ZWQgYXMgYSBmYXRhbCBlcnJvci4gVGhlcmUgaXMgYWxyZWFkeSBhIGR5bmFtaWMgZGVidWcg
bWVzc2FnZSBmb3IgZWFjaCByZWFkIGZhaWx1cmUuIEtlZXAgdHJhY2sgb2YgdGhlIHRvdGFsIG51
bWJlciBvZiB0aW1lc3RhbXAgcmVnaXN0ZXJzIHRoYXQgZmFpbCBmb3IgYSBnaXZlbiBwb3J0IGFu
ZCBsb2cgYSB3YXJuaW5nIG1lc3NhZ2UgaW5kaWNhdGluZyB0aGUgdG90YWwgbnVtYmVyIG9mIGZh
aWx1cmVzLiBDb250aW51aW5nIGlzIGFjY2VwdGFibGUgYXMgY2xlYXJpbmcgdGhlIG1lbW9yeSBp
cyBhIHByZWNhdXRpb24gYWdhaW5zdCBmYXVsdHkgc29mdHdhcmUuIENvcnJlY3Qgc29mdHdhcmUg
YWNjZXNzIHdvbid0IHJlYWQgdGhlIGluZGV4IHR3aWNlIGFuZCB3b24ndCByZWFkIGl0IGF0IGFs
bCBleGNlcHQgd2hlbiBpdCBoYXMgYWxyZWFkeSBjb25maXJtZWQgdGhhdCB0aGUgaW5kZXggaXMg
dmFsaWQgYnkgcmVhZGluZyBpY2VfZ2V0X3BoeV90eF90c3RhbXBfcmVhZHkoKS4NCj4gDQo+IEZp
eGVzOiAzZWM0NmUxNTdjN2YgKCJpY2U6IHBlcmZvcm0gUEhZIHNvZnQgcmVzZXQgZm9yIEU4MjVD
IHBvcnRzIGF0IGluaXRpYWxpemF0aW9uIikNCj4gUmV2aWV3ZWQtYnk6IE1hY2llayBNYWNobmlr
b3dza2kgPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBK
YWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jIHwgMTAwICsrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCA0OCBk
ZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4YW5kZXIubm93
bGluQGludGVsLmNvbT4NCg==
