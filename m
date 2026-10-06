Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CA8CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6213640600;
	Tue,  6 Oct 2026 01:40:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b4NNRR7zK1nG; Tue,  6 Oct 2026 01:40:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6F6FC4066E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791250803;
	b=h+RXPlUD8E/fNEgedKn3m8I7d+r+dtXOeh7pSWdzE9E3hbemXnv48BIFL44yvFMCILiY
	 1FFxRJJEgUGdHPYd/kVZEhqn3OL0xO2ihfVU7d4G/L4AubUGMLqFLgacvpuRyaVFZRqV2
	 BKLrDxLpXJ7W46niD3G73FMQ2VqL4dKeOP116pdE9Eis87LKfkTIgoUqE3Dn3Ts99zDzq
	 AOMAfmDimsdUP+RONoij2lQ7P1J/firxy6LFqiM60Q5ruFycBkNzGJepxwFxRQWpRiA6F
	 o91tIxLMcgSshMnsb7yCSgF9SRHpQFR0jJV9d9zy1OKfVNkwlE57oqUBxQVeHfuATwQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791250803;
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
	bh=Ccx2D/dVuU9YLj9A7XbfrDdogrhSk3lNuX0hDS0L9sc=;
	b=IbZUpu+3JV8CIPYitr8AfXp4IKm+xdMPuu9Q5EEie7FAQyyE7kp/n8DOn7G7R+SnW9ah
	 ZHcBCl+c+JM2w0LHNjB4XKnJHyfUbaOxrB2jxcBTP/jnC2YwJnfE3NGubFGm3RiLWoLxO
	 0aT60cJRlY+skJHlYRClcD16eSM5nCOABrp8Ct9H5zh8qoK2tYa80pQz2DU6sIc5//erO
	 oMtaR0sibsUlui9KDCkQ87ssawSUHM46GOUDkSMkSvq9zvqQoIZ1eEAqVzfKP5Wxs+JJ5
	 fCruLaXr/m7OUyPnjNG5tgAdzNQ+oUELqsM3gHT6lEaB+W7sQJNAnzhnHXnBTC9md2w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791250803;
	bh=Ccx2D/dVuU9YLj9A7XbfrDdogrhSk3lNuX0hDS0L9sc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9cVMlFtrT6fPxRt9vQLH5fdl7iN2uQDiMgBlVmdxzy7Zj3oPKGO5F5N4lLRgarno5
	 tPlivlVRO4hl/L5hglChAuHICug/KkYaKtvx7QMMxVOdS5agLLgZX5HAPdzYcHUG7v
	 F3DqeuiJmgSZHDKymHPLvIA0pl1GJU/rjFn53TYaWYvMq1yquOB7zDvNpaKXTE2nEY
	 KGYqcP8ejaNvaVm17cPaqHvvIM5XFgtLB3TKMoptXnccaXAYwCbvEwMDM+l/E2W7io
	 sxXr012SHUWtDrFpW0Ild0YmznOol49bVx/eGJJgim9B72QPO97OAdpxYE+9oSdoBP
	 Wrxb8l0JtEOqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F6FC4066E;
	Tue,  6 Oct 2026 01:40:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EA30A15
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7F2760666
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FkAM_E2iapyv for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:39:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8D812605F9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791250799;
 b=N1WUNyYCmFuMwqgKainGrrSH6RL+yEWHtPG93S4e7motcPtkv9S1kYdc8WEZj28sXAcA
 lpov6pFVS8IhTcQ1bTO3cYP3F+vdNDtgjmERlhDXTR2Kn/0K73Teq+xVjUHL/OQ4RrNnv
 hlWfSBYU5fsxQ7jQGQnitGTUHje7Cv2QRPXEtbOynK8afthSqUcqrq5MSzI6vxkL5aMp2
 AYK6fRmQISqm7la9iuY2pTInVBfFYUBiLcitY1VEMBUDU0gMC/VCJbQRfdt7u+HZv2dww
 zE2XjYUHL4Hq4m9ArwYWyeuQ5mXcyNbL2621G1Nukg7QToPLPx1VbX7dfLCw82Kui1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791250799;
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
 bh=Ccx2D/dVuU9YLj9A7XbfrDdogrhSk3lNuX0hDS0L9sc=;
 b=Lig/M7sDBVIdlnNHvjXQXEGph9GBo9gzECWpC0iIRH7WpqCVywZhgBRHYaYlNiQRqHun
 glKYJ6UKdAp6RyS3ZtXTYeg1qmwfrcTnsOapCR8ZiUFiaODK58Q8HWNX90g3A0DJe3rVf
 NLO5WLfX3F7Aet1no3QNHdDZRjLDQvyqMha+BLSirOZz8yyhd5BBqwS57/E8pMI8Ci02U
 3/QWU3zSz4lM6TPEUT59a/wO4YKalZaLo/SnudBm/QJk2+2504fnKE1W/yNGKWGvur2i6
 RgCCRZVnfHWyRY5bp6WQnP6U0u88qZCM1uJWW7AIwXfMR/K8v2lomeRN4kfhYLJFccQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="lfuBYN/W"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=lfuBYN/W
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D812605F9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791250799; x=1822786799;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ccx2D/dVuU9YLj9A7XbfrDdogrhSk3lNuX0hDS0L9sc=;
 b=lfuBYN/WtxezDupvSye5BKq9Tc74mnDhpXpB8uHaJ96LFc+0+XtBULjb
 /CgpzqMfoZFSj91od2HfYvp1tHSZ4C+vebmykz8e48RwN6VJqzvDdCt3j
 m0+qOE+NlfsyuBdObgyQiiA/7nNhEmfY1yEc9UQPJmCrxeML2jhO5p5wf
 W8csqK+ns4sOHVeHA/IW9Qa/f/kCWgnbh4Zrqgbs6ML/ptTnDqHk0CI/Z
 ZuCH8Hhu008YOpzmIHi4Pc99ufbBUbjCTcqfv3JxF6gJQeD/+DXd9y+Pq
 Ln3gY3Ih4hwNQfdTk0DsMweyjqop9h8z70k4eIIyQtnXKtFyNfV4tgNbU Q==;
X-CSE-ConnectionGUID: CgL0ERHdQi2XOjNs3pYmpQ==
X-CSE-MsgGUID: ICwcYC7fTQCRLGm/ZkY1Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="92042166"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="92042166"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:39:59 -0700
X-CSE-ConnectionGUID: xprSKRBGQ8u5L8AQr1ejvA==
X-CSE-MsgGUID: p4zpNPwkRtqhFnIGZEF6Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="277108309"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:39:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:39:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:39:58 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:39:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl0EiqPIbojjRFqorrQDjJlFuT7W1u5dthbyPyZWhJlhf08dAATXZuNfzS7kMS2LP1j90mtgVGjD0JYTGkvXD7tLZdOKgxxBi5PPOVe1vO0mol02CZEuxOQaL4rCGJQSmlStyaACjDnaU41O6iNdpzuB6p4lJl2lZnltusoNHJiDPycA8PFjBfgbzTqcvjbMgy6xXX0+T1Ua9t3S72EJGT6V+ZfnN9eHQZ5wCKIHvbCyBAQAI55ON1GENRnXtDA2iBM5ir1kWt/wim5n2GGi6LGI+0yM5z2ehbg5mKb4DV1Jrm8eJmr2BkrAkZK64gO8oPmbHcoSR+YQfqJCkaS/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ccx2D/dVuU9YLj9A7XbfrDdogrhSk3lNuX0hDS0L9sc=;
 b=aTnmW8XIa4cW6Fi4jU5womQFCm1gJgH6anu2NdfgH5Ip48442CEu29K1evZk6VQcW+jxrvDV0k3F/yIT+iCnr4u0Ak/aOdEYY2F4O8WF6yCOKAVKXUEdv5nFuvIj77b5HLg69VqVkjJT1CuyheemjSyrsj1l4BD9oti/aFTsX6q/yOHQW0uawxevOu2lVEtOWkw3ZrKaApmk5qY1xZUT9g6Vz3MWgi6h9Bsry6sWF9qkzjHb2UsN6xJOmuNl2litImO/EdT1D4sYNi85pdwT33WsSDRAm6eMK+qmWT6EiUwc1EQ8NOl5HG1XRFTnKom5nDVGxvf7u/+zssS6aGtjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:38:18 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:38:17 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, "Machnikowski, Maciej"
 <maciej.machnikowski@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Korba, Przemyslaw" <przemyslaw.korba@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Nitka, Grzegorz"
 <grzegorz.nitka@intel.com>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH iwl-net v3 03/15] ice: fix PHY port restart serialization
Thread-Topic: [PATCH iwl-net v3 03/15] ice: fix PHY port restart serialization
Thread-Index: AQHdTUnIIKjWuEB3UUCzBrLIJHTOjrbvy/Hw
Date: Tue, 6 Oct 2026 01:38:17 +0000
Message-ID: <LV1PR11MB8790A7050B68A3AC09B9B24E90952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-3-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-3-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: cde5ca57-6d07-4f5d-97e5-08df234a7f24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|10067099003|3023799007|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: xEDFOzpU6ThO15VYpOTqmEiik3JwonbjWj3yXH/7cOE1nO39xXmz9cwXoNI7bDDNNSeuoce3QjSeHzw1ol8zxq6+GnLUjllLx6bCeXK+NhYv5NX9zCJR5NVy2nvzIuRRu7D+0Im0MpdFBqml5/ilRZlj3GqISwC8J/wIWxlTUPusOE7WzKDuu8OLZrsThjq+5kLKI07t4wPRMF031rcc+I0GNLQB3IBmw9nkdsBqaKRvnTthOlby/6oFtLJtO/tkDlT7S5WPc8bh7YWzyEOFkVse4PU6hrUcHVr3bEmjNzLAbAw/ZgJcVTzNOmBQTVAa3Qy3oHYt7uygmjbGIHhu+9had7CLaTM+RE3vhr2dZioIKZTAZbdJ6mbQ1VdUbCdL5CihBcPXWF9lx70lho7CoSYvGFiJKW0v3KQt7wNOTEn4p/VQ0UMLt8MBssB1WqI/FufmHbATBAyy16pCmCmU660Eq6mDvMao8iftAbg99URfT++PZwWfm07dh3T7KsdvYfmEGM+MAciZZz3nagYRvAQhYqGzrptLZhwDg9nvr6p1DAS9C7+szQtZ8lIjpD7k4DEHY37QIwS3zg8MvIJEmVbe2SSDNH+QyiI0O4vLOQKbPq/oOnRWKV49lBVQ9S5aM8LSV5T0bbR+WjaId/u7lk3LfTRw8YKjK4GedSC5yNLgNj29uDwOjXY9IgDEVFHM2kFCYBG+PVKHHTf88kZMvffqwxiz3vEGMRHxl7UsTvswl00kTQnjAgxGTtZXqCCW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(3023799007)(921020)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEo2MlJPbnIzNkNJNzdwMXNwVHoxdjhod3RCSmp1cENjQ09yRDQyU2lucHMv?=
 =?utf-8?B?WFpwZzBHOWdyYUsyUUVLZ3JMOE1vOU5WWkJzZGc5bUNlTlNndlNxWWt5REhx?=
 =?utf-8?B?TjNCV0lZdGUzTzc3dzUzT2w3QW5aT3pyUGN4V3ZsK3AyZ2FZeHh3L09OUHJI?=
 =?utf-8?B?a2lyWVVEbkdlV1lxTEpjVmhjM2QyNDdBSWlhYmFpU3crcjQ2VGFxSzd4Y1dH?=
 =?utf-8?B?MkN0NzFTV3dNTFo2d3lsQ3dKcXhRRC9pRnRFSU1WTUFOa2p5dGVENnl1OUdC?=
 =?utf-8?B?VTBBekUybDR0TzJubVZDU0RRZFUza1FTaW5HYVJVb2x5eTBGa3V2YXg5NHl3?=
 =?utf-8?B?bit4cnlDL21wU0xEY1ZWS095cFp3Q2pkY1hWUzB6TWluSjdCWU42cFI1ZkI5?=
 =?utf-8?B?L3ppekh3eEJHNTlUTjVSOWQ4SjJ0c1FvZUlyKzN5SXBSR201UURMOCtVWmFO?=
 =?utf-8?B?bkJBOUl3T1J0ZFl3N1NGc055Vm44NjIxOVAyeHU4OEcrRlczbEkvcHRwWHBn?=
 =?utf-8?B?SngzaUJxRHpKajluT3VtNDNvYnZpSlFoRXNTZ255OWRIOVNCWFRSeDFVYWtQ?=
 =?utf-8?B?RHB2L2xuZ0VGQkc1Rk1MUythamc2MUZvT1N1ZmIzNHFwZGRLZmFtOHVyK1kz?=
 =?utf-8?B?Q2lqMVAwbkJZbEcxdDVoVGEyZFEwRmlVdFgwaFNBOUpzekhCYUNNMVRFd3B5?=
 =?utf-8?B?QWpIYW92UDR3M1V2ODM1Vzh5aVhaUnZScXdta1EyaWpEM05HR29seUNtZzBX?=
 =?utf-8?B?NXhJbllTamh0UVR0NEd1RXVUN2J1S2VtZmFZamdPRmxFU2pta25ZbDcwakdM?=
 =?utf-8?B?eWU2V2JFbmJtV1NpR3laQW9tVHdlbFlNdGdBQnVBRm00WGx3dHE5dWptaEgr?=
 =?utf-8?B?ZlFsaFR2eG1BRVgyUVdlM0x6WUdHSEdZZ0JMQXJRRWdqRDEzRFBnYlpDeVY5?=
 =?utf-8?B?ZnZCeElMMlZNSGhVMWlHMitNWXlkakZSV29aa3BlUEp5YWlUemtKVlMxQlU1?=
 =?utf-8?B?U2FsNU1BREtjcE9PUUZRNEthdUMyb2k1MHdLNy9oZmJSZkVCMm9JUVYxTXRM?=
 =?utf-8?B?S3JVL2hERVljSDRsWFg4MjlyVGVSbDg5UG9BaTE4c3pSSkppMnpFOW5ZTWpM?=
 =?utf-8?B?ei9PQXpiamMzUVg0eWkzZTVleXRuLzFWbDJxcm8wZ3lTTlU1cUowTmFTNTAz?=
 =?utf-8?B?Uk5raGFCVk0yVmFkMDY5V3ZRaUREV0Qwem9rMzFwVE1nSnBtMjZiU24xNU9w?=
 =?utf-8?B?YUVJRUJkalQrUlRJS3VvQjd2UFg4dHpiK3FVUmVaVEFUSnh6SU1XM2owTzdv?=
 =?utf-8?B?N3hCS2hZQ3ZIZUk4dk9xOHM0VmZRdktpdkp1cHNuTFhObk93dS9pOFlDb3BR?=
 =?utf-8?B?QjU2bDlDeGovU2FDQkZWVDYySS8xMzExQU9zRCtUL1c3MzdnV1djY2JnSUs2?=
 =?utf-8?B?cnpuQUhOZGkyOE1uaUIyRngweTVjMmZlZWFheitFdVVOeGFnTDVnM0NNdTZ1?=
 =?utf-8?B?UEdwSXovYjF0VGh6a1Jwc1B4QXExU0RyMmpDckdPb1N2QUJod0Nva1ZENFZw?=
 =?utf-8?B?SDdnZldRNzRZNTI0OUdJTFFXZDlZQSs4QXoyWWgzVW84OFNnNWp2ZW12ZDEv?=
 =?utf-8?B?SmNVbHNFeHBPVTdjY2d1QlpDOVA4YStQaXk3ZEdZbHo3L2R3V2d2UFRHNzcx?=
 =?utf-8?B?d0dWWEFLVG03UTFoRnFVQ0FRNmJvK0k4aHd6a29nTklyRlI4TTdaMzR0U2Ji?=
 =?utf-8?B?bzhuMzBMRlV4RU53eDBGaUNDQWl5NGtKSWpWRWFlM3I2bWZSRTY3VmxDREJn?=
 =?utf-8?B?TC9SOUVuN0huU3dqWUhxZlV3M3d6S3hrNnpFMDg2SnVZZkFlQTNSc280RUxs?=
 =?utf-8?B?aTdHN29rc1JyYndiTnVLQlkxSTJ4SHd5V2l1KzJKOFphZnR2aDZHRnAzNmNw?=
 =?utf-8?B?R0dPUHdaUkhxb3VzUmJWY1NiL3JlSzA2NnpZZmpZdGZ5U1VZdkxTeHU2eE9B?=
 =?utf-8?B?UlZQTHhTZ3VMbnNmZmJpb2gxbitGZk1zb1RoTmxjSFRrSW54NWRsUTVWOXlj?=
 =?utf-8?B?NVVmQVpHUHN5TXN2SFBsS25aUXBsSWNBMEo3czVRZFBEUGhDTGZMSGpvNWxM?=
 =?utf-8?B?UHJxVnBxUHpucENmRW1mS2ZtbVBRYWh2aTAvVXhBc0FwWEYyL3FtTmc4TXJo?=
 =?utf-8?B?d0ZOSVpVNHdYRUdiZUR3TjRDNnFtZlBrQ1MvR0JSdjFwbDNPaXo0TUR4amVN?=
 =?utf-8?B?NGIweENGRkpzY3AwekY5dElkYW15TjhsWHl2dzdSZy83dGlLVFNhUEhWZWhm?=
 =?utf-8?B?cXVXT29OWUhvT3VnaWNPdVdITGZ0OURxVkZ0dklrYVYrcHJQMWdndz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s8D93hTpUjz86sdt51Xo3OAS0MfPv6Vsa3OG3dnxSHlbrhOl+Kee83RW5uB9iQ2yrAiOOExEZDonl/yBMJoiUuVwXi1/uoAXMjXiHNYL0j9cJ/D8h4KbEGRfzWyARBKrxQIN6JXrgdQ3eCMrgh7N6WXzOxL1lQisYOmwqaLf8HMkDvq74zlw62gr88O+DFlyg3b/IMEvBUA9+rOdNv6HCqdf9GE1HiT7ynW5AXTm5NhQjOnAram/FwOGf98HvgwFM1zQAODcFUHwQ+CgCjAQf0Qpn+GWgj7FptcnveCxZkNreIwyMZKrhMUz7ZAz0iV1G/CtJqUmD5sKx2aUMdpcLQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde5ca57-6d07-4f5d-97e5-08df234a7f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:38:17.7023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BP1xaOZF4iqv/PGUg8VwWD+gpYm3PjWCNTW87U5Cfhtn5m8yLzAjennzqv+zHXTb0RbmlmoreoLhHHWpeb0FodHy4cYU54a2KovVrVSIpUQ=
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
QGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjMgMDMvMTVdIGljZTogZml4
IFBIWSBwb3J0IHJlc3RhcnQgc2VyaWFsaXphdGlvbg0KPiANCj4gVGhlIGljZV9wb3J0X3BoeV9y
ZXN0YXJ0KCkgZnVuY3Rpb24gaXMgcmVzcG9uc2libGUgZm9yIHJlc3RhcnRpbmcgYSBQSFkgcG9y
dCwgcHJpbWFyaWx5IGFmdGVyIGEgbGluayB0cmFuc2l0aW9uLiBQSFkgcG9ydHMgbXVzdCBhbHNv
IGFsbCBiZSByZXN0YXJ0ZWQgYWZ0ZXIgYSByZXNldCwgYW5kIHRoZSBFODIyIGRldmljZXMgYWxz
byByZXN0YXJ0IHRoZSBQSFkgYWZ0ZXIgdGhlIC5zZXR0aW1lNjQgb3BlcmF0aW9uLg0KPiANCj4g
SWYgYSBQSFkgcmVzdGFydCBvY2N1cnMgY29uY3VycmVudGx5IHdpdGggYSBsaW5rIHRyYW5zaXRp
b24sIGl0IGlzIHBvc3NpYmxlIHRoYXQgdGhlIGxpbmsgc3RhdGUgcmVhZCBjb3VsZCBiZSByZS1v
cmRlcmVkIHN1Y2ggdGhhdCB0aGUgbGluayB0cmFuc2l0aW9uIHdvdWxkIHN0YXJ0IHRoZSBQSFkg
YnV0IGEgY29uY3VycmVudCByZXN0YXJ0IChzdWNoIGFzIGZyb20gLnNldHRpbWU2NCkgY291bGQg
c2VlIHRoZSBvbGQgbGluayBzdGF0ZSBhbmQgZGVjaWRlIGl0IG11c3Qgc3RvcCB0aGUgUEhZLg0K
PiANCj4gVGhpcyBvY2N1cnMgYmVjYXVzZSB0aGUgcmVzdGFydCBwcm9jZWR1cmUgZGVwZW5kcyBv
biB0aGUgbGluayBzdGF0ZSB2YWx1ZSBidXQgc2V0dGluZyB0aGF0IHZhbHVlIGlzIG5vdCBzZXJp
YWxpemVkIHdpdGggdGhlIHBlci1wb3J0IHBzX2xvY2suIEEgZm9sbG93aW5nIGZpeCBmb3IgRTgy
NSBpcyBnb2luZyB0byBtb2RpZnkgdGhlIC5zZXR0dGltZTY0IHRvIGFsc28gY29ycmVjdGx5IHJl
c3RhcnQgdGhlIFBIWSB0aW1lcnMsIG9wZW5pbmcgdGhlIEU4MjUgZGV2aWNlIHRvIGEgcmFjZSBi
ZXR3ZWVuDQo+IC5zZXR0aW1lNjQgYW5kIGEgY29uY3VycmVudCBsaW5rIGNoYW5nZS4NCj4gDQo+
IFRvIGF2b2lkIHRoaXMsIHdlIG5lZWQgdG8gZW5zdXJlIHRoYXQgdGhlIHBvcnQgbGlua191cCBm
aWVsZCBpcyBzZXQgd2l0aGluIHRoZSBzYW1lIGNyaXRpY2FsIHNlY3Rpb24gYXMgdGhlIHJlc3Rh
cnQgcHJvY2VkdXJlLiBUaGlzIHdheSB3ZSBlbnN1cmUgdGhhdCB0aGUgZW5kIHJlc3VsdCBpcyB0
aGUgUEhZIHByb2dyYW1tZWQgdG8gdGhlIGNvcnJlY3Qgc3RhdGUuDQo+IA0KPiBBZGRpdGlvbmFs
bHkgbm90ZSB0aGF0IHRoZSBQSFkgcmVzdGFydCBwcm9jZWR1cmUgYWxyZWFkeSBjYW5ub3QgcnVu
IGNvbmN1cnJlbnRseSBhY3Jvc3MgdHdvIHBvcnRzLiBUaGUgcHJvY2VkdXJlIHJlcXVpcmVzIGV4
ZWN1dGluZyB0aW1lciBjb21tYW5kcyB3aGljaCBpbiB0dXJuIHJlcXVpcmUgdGhlIFBUUCBoYXJk
d2FyZSBzZW1hcGhvcmUuDQo+IA0KPiBUaHVzLCB0byBzaW1wbGlmeSB0aGUgbG9ja2luZyBiZWhh
dmlvciwgY29udmVydCB0aGUgcGVyLXBvcnQgcHNfbG9jayB0byBhIHNpbmdsZSBtdXRleCBpbiB0
aGUgaWNlX2FkYXB0ZXIuIEFjcXVpcmUgdGhpcyBpbiBpY2VfcHRwX3Jlc3RhcnRfYWxsX3BoeSgp
LCBhbmQgaG9sZCBpdCB3aGlsZSBjYWxsaW5nIGljZV9wdHBfcG9ydF9waHlfc3RvcCgpIGFuZCBp
Y2VfcHRwX3BvcnRfcGh5X3Jlc3RhcnQoKS4NCj4gDQo+IFRoZSBpY2VfcHRwX2xpbmtfY2hhbmdl
KCkgZnVuY3Rpb24gbm93IGFjcXVpcmVzIHRoZSBwb3J0IGxvY2sgZm9yIHRoZSBlbnRpcmUgY2hh
bmdlLiBUaGlzIGVuc3VyZXMgdGhhdCB0aGUgbGluayBzdGF0ZSBpcyBzZXQgdW5kZXIgbG9jay4g
Tm90ZSB0aGUgZnVuY3Rpb24gZG9lcyBhbHNvIGFjcXVpcmUgdGhlIGRwbGxzLmxvY2sgZm9yIEU4
MjUgZGV2aWNlcy4gVGhpcyBvcmRlcmluZyBpcyBzYWZlIGJlY2F1c2UgdGhlIG90aGVyIGNhbGxl
cnMgb2YgZHBsbHMubG9jayBkbyBub3QgYWNxdWlyZSB0aGUgcHNfbG9jay4NCj4gDQo+IFRoZSBz
d2l0Y2ggdG8gYSBzaW5nbGUgbG9jayBmb3IgdGhlIGFkYXB0ZXIgaW5zdGVhZCBvZiBvbmUgcGVy
IHBvcnQgaXMgZWFzaWVyIHRvIHJlYXNvbiBhYm91dC4gSXQgYWxzbyBjb3VsZCBiZSBhIGZpcnN0
IHN0ZXAgaW4gYSBwbGFuIHRvIHJlcGxhY2UgdGhlIFBUUCBoYXJkd2FyZSBzZW1hcGhvcmUgY29t
cGxldGVseSwgd2hpY2ggaXMgdW5kZXIgaW52ZXN0aWdhdGlvbiBmb3IgdGhlIGZ1dHVyZS4NCj4g
DQo+IFRoaXMgZml4ZXMgb25lIG9mIHRoZSBpc3N1ZXMgcmVwb3J0ZWQgYnkgU2FzaGlrbyBkdXJp
bmcgYSBwcmV2aW91cyByZXZpZXcgb2YgdGhpcyBzZXJpZXMsIGxpbmtlZCBoZXJlIGFzIHRoZSBD
bG9zZXMgdGFnLg0KPiANCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYv
MjAyNjA5MTYwMTEyMjguMTYzMjg0OC0xLWt1YmFAa2VybmVsLm9yZy8NCj4gRml4ZXM6IDNhNzQ5
NjIzNGQxNyAoImljZTogaW1wbGVtZW50IGJhc2ljIEU4MjIgUFRQIHN1cHBvcnQiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2FkYXB0ZXIuaCB8ICA0ICsr
DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5oICAgICB8ICAyIC0N
Cj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfYWRhcHRlci5jIHwgIDMgKysN
Cj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRwLmMgICAgIHwgNTggKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRp
b25zKCspLCAzMSBkZWxldGlvbnMoLSkNCg0KVGVzdGVkLWJ5OiBBbGV4YW5kZXIgTm93bGluIDxh
bGV4YW5kZXIubm93bGluQGludGVsLmNvbT4NCg==
