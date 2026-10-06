Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3B6CA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 01:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B2D8405F0;
	Tue,  6 Oct 2026 01:39:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9oeRM4fIGrxd; Tue,  6 Oct 2026 01:39:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A890F405FF
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791250743;
	b=k6AsO7/0ycbIOvHe6MTLW1JovLjd69MFmzSWoQs4JKy3AhE0E+yH/mJ/6H/LakP2BA8T
	 6mGRxsRDXuE9xEptpT02T3sfoTWPTe4z8woH6PPd015ycAS8wbenpwA9BPjrram5rv1rq
	 uBg4U2hCme9vbvHw6JyLCOhPq0tz9eDEUoO4jWJKE5+jj877mqQ8vPz1SzYNiIR2bOadI
	 zG1bSlpLAaZ8dOdix1oarMgPfBIPTmgS7Y2ObG4BoqC90KK7iIhX9eGJ0g8+Rm6n2gYyr
	 xbLOwGdfSiwdCPPGdwAypUH+TIryL5znnpdmWQeSk+bfnMvCikce5OeH16wpeGfnmUQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791250743;
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
	bh=Gb6ZwxmEuWTQX7XxYuZnqFzwEE094s2YfIH2nhQetVA=;
	b=AEqGhkkwwolJE3+/FFrXkwB2KFcwL+u10RPjn74G6+npVZ2FgzY+D1UXOaV5WHtuNg5p
	 lvNLilPNSFRwrCIyeSrQz7cyQh19Gsupe8dL+DzRutQAF+zFsuPZbcQuXvV9zPmVgigY1
	 whXaGI4pgVH9LDqsHfJn22UHNHU52o+ReUlU3QggFpU4KF40EaacMhlSJO5p+OiDlI+eY
	 8WWEeRr2FgsZDnZ0ZBvZDbCTQ3VmbzF5wCRJ0xwOsBPw1TL8K4goUYruU134nKVlgHCVG
	 AmPRPfIdYel1y+PbnZTc+618Uk9BaJm6afsjLg7AYGXewuKcoB0zvNHD2X2hwpFbMig==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791250743;
	bh=Gb6ZwxmEuWTQX7XxYuZnqFzwEE094s2YfIH2nhQetVA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vQ7OSZo6/gCFaekm3yPNj/smPjndNd8o58HR95tJVqs9/XN75nMxe7VFw4RhwEGCJ
	 7iCj+jKaoga8ruBE0sYTxcValzMV1cb9g48HTo7E7DrR/WUitXZXDaqVkpoI4aE7hk
	 AgMWmq0FG3fZmv2L1dcbkaqS/pqQDNqf78StI3lVw4ahlHOTvri6Sg3kp719PGGTvF
	 QwvljtD/vjbxah1J12Wv71wDdHebXCCNQv/ENMq40LZ9lohS+trq9EcZFU8b3pE5cV
	 X0cepOFHTC1C8DwQ15SzPojRoKnCax1rO/KTrQCeTgKzsFJad4QlqwQkqaXi0DLRyu
	 TZ7Cwdvebkk3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A890F405FF;
	Tue,  6 Oct 2026 01:39:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BCF1B1D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA29F40204
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:37:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tab54YgUxREx for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 01:37:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6C1794009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791250660;
 b=WVEMBdvY4bBlcs2MofG/K/se1oUWv81ZL1U4EUc9onCzrwa0xG/g5i++QG95u13M0SKw
 RnBDFJq3MKEu7KdwU1rNPqI1HQ4fDpijbdhPAurzq/MpFE3a04Xt8JUFYpS7T3oXsurao
 NrKSq06zfWhv7ZpiRQz89NMTTegYCkHVvOXKa/yL/IlqQ9XmkKa2FQwaxMd5AGQ7c8370
 EP2DM3ftB+enxxziuunACdDCMSwgw28YURREZUrHcoN0DRDLO+YR5vG7jzk2PngGS/V1s
 E3qQTzSABDY8Bp9Ov9hPzoxC4BhL63QjCTtnPmpm76ZEPgfirXKqsCRQnIwcuWq9Czg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791250660;
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
 bh=Gb6ZwxmEuWTQX7XxYuZnqFzwEE094s2YfIH2nhQetVA=;
 b=YcLZhLEbrbdjbT8aSMuEeqyGLxtb2SMzim6bUxoRHPQJPFyQ2j2emGDyUw4uKsvpNC5l
 g3ty/SjNrNW0nKmbVixKVkOQT3OvDKXku2Ajl5qhVnslSuqzHxYXf/YNAAC8jhUFZ1qTg
 fEGv8P8e2CTPxA7aQUYHCVQ26xTaLOgZYEAEzmhz88NUVvCLtztg2eEFJM3NrD71O1ftt
 jtOamNo+fYSEBXZWTXCaLP7NgNHdawVKDntXKTg/sdNoTrUTNLKDLBY6g8DBdoxU/4WI5
 63SE2hfRXRTs2orESyOkt9ftQSXNaYQ4qskNrTJDLQnc13X4wR6Lj857fvxsuPSZNlg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cdtcdkNr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=alexander.nowlin@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cdtcdkNr
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C1794009D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 01:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791250660; x=1822786660;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Gb6ZwxmEuWTQX7XxYuZnqFzwEE094s2YfIH2nhQetVA=;
 b=cdtcdkNrI+3vsqzrj0K3e2Ms9IIHu7cQrUU/+xW06bV0XAci1xanIAGr
 9h2wDYCLTlk//1S+0KbR01B3x6gVqKCEJKRiImVNfhubq9tqiLVrCwajb
 0r0AZaltppbo6AA9BvzA2lWlJIdvbYPUsOx3dxuKPn6t0Eu5Yxgi7ljzl
 5+aHo4qVKIZ1RK/Ig9WdMBkoKOlSuREKWcyddMHRw6pt3kMiR4ExpGsSU
 lvhY2jpYmf0lgiCbelmR+IzZgL0t6PA/2vvsZQl+/PTv+/P6K50PTiKRS
 bbOv5s5P3+xgp+ZZKOEIIx1wStTwh1bG8vSEOO9q7hpYPOz629Hf351nR A==;
X-CSE-ConnectionGUID: lA/n0N7WQsCb/0Ke+i5UjQ==
X-CSE-MsgGUID: LAM1ADqxT+O9BJlAku1rjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="113716209"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="113716209"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:37:39 -0700
X-CSE-ConnectionGUID: 5AXsKXt7Qaakr727jcL2WQ==
X-CSE-MsgGUID: QFR26M0HQkaeSYc9/DP5Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1046072"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 18:37:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:37:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 18:37:39 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 18:37:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlwF1NaeJ86Cy1RbWpjlx8GzdWNBmeV1eZgyKjIIRr111OTJQ7bmh1rd2rVYrdC93oP9DHX/32jMNfDIGKBkOepR4fd1iFuXVlgG15pqqZy3U3pRdtA7dA84O4IbsjiUZmDp97S41DYi4/9mC1MuWaJEX2xRkS9AaneWD4vsKtR+lSzqSa1LyCshFqs1HkCwx/okT4QhShcJUGTb7T9fn8nb/Bk1EMCwrARgVUNFONoVSQYrMSOnoYtiI/sMqRdM1KNDfBXu6Uvj7RXup9dnj/1clqA3j1DfGxBn0bLNj0hfHQ+Z5Xft2jwZT1MQjCJo9flH+ymp7xwyT9l3y7jrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb6ZwxmEuWTQX7XxYuZnqFzwEE094s2YfIH2nhQetVA=;
 b=A4qMPiDq3IE1M4+aZZ/0+f+EM/2l1rM09FfHe4mvM+NbOKqlXKBu7NyjPCZ7Hun1ltOHMdFtOMNPnIOIOxuIR6Tunhas3qr9lXlcjTgkHjayha1FEtDeojvpnd7VNkSsCTqpbkaM9uc/BbwrF+sKCqobxsC02/VU58kKtZAX5KOz3sbEVUJ4N2NWKpWHYIz36PGNwR1+RUSihzdnZL1PE7+WgsVBXj7M5A7Con0nxiZ3FAS/zPguNYXV4tR3X2TO1u3R8U/vXUUBakeHAxj7BMZZETiFClsT9QY/lgqxNs0VtHzjugiZpFW3gvMbfPfQJXrW36z/wUcRzDPJxm1brw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:37:29 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:37:29 +0000
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
Subject: RE: [PATCH iwl-net v3 02/15] ice: use reference counting and SRCU for
 PTP port access
Thread-Topic: [PATCH iwl-net v3 02/15] ice: use reference counting and SRCU
 for PTP port access
Thread-Index: AQHdTUnAZykoOyoRik6FD/H+20kh8Lbvy7Lw
Date: Tue, 6 Oct 2026 01:37:29 +0000
Message-ID: <LV1PR11MB87903D258F9955B89BFBDCC190952@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
 <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-2-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-2-6532598e8da8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: 49aa8d13-4fc5-4ec4-dee2-08df234a6274
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|10067099003|921020|38070700021|4143699003|56012099006|11063799006|5023799004;
x-microsoft-antispam-message-info: euHeQfv1SXhU0pxDTXFkwHsm9L0ExMgRFrddtqDZdVHSJZ7Q+V5M3s+IjdGACIQbT9U+8Z7Z6fjPW9rYdsc+QsqxJKU+F+pdkou2EbPKxJM3udZh3LHSZmdGUbj7MEKkBb8lPK5osv4t9T+t5pbzf17Irh5GsFwYZ8gVFLWhucNNICgka9dKdlxffJihRfF7rrBjXEtVstdxsdtNGkO010fO+ycgDJp/DU2ejFiHnkaM1c8V/LQgaqWDW9/crQa/o32oDRThE6y+4adqULcFHZViz3NzmHJRWhF72Cl8LlFkVdnSfmuKqVUqcs8yNckdGkaKiGeuA1XLPnOfGN4301VFZfzIxKVSwTc8WQYfBgAirPFqQvQpSFL9+/SwuRAEIksnARWu0ZHVGRHzEuc5jc44Cf/jWV2T1JAYYMNuD7hUV0AXxsVM8sXghUepsDuKp7TBEjyOgElJ1LVxhtkwVoFPERgWl6Fk9xDnxHvdrueIMNWpBQlPOq9azVOAXAiGa7nxpvKdnxbv5w8Xo4d1jULu/dIBS7M1PNCiQnUJ/abrGbQq0dHgOVj/CMa2fuJRM9gngLUP4EXcNZJuV9JVSKXx2TGWc5dgR1tnvLY4BGC+0Tn/B9cbUgU+fsjTGTJ3hZeLXOo+R8Fqi0rYkKuQtB5zfDSGGv1E2CC9GeAP77hrcDIPXdz4MSwjv/wwACKnG+lc47qMbpKmjh2cfAtBZ+FeOd28C2KlhsVBL/rZPHq0gulBLzzkGBOF7N5zE6QG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV1PR11MB8790.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a053RVMrZzU4YzJSaEhwM0JGbFJZUkVZdi84VkVSTGZEc2hmUy9Tcm9QbnU5?=
 =?utf-8?B?WjRnMmNEaVBTYmYydVlBeXltSFJXMlNWS0RRL0Y3QXg0MTlValkxdS92dTA0?=
 =?utf-8?B?VTR5VlJYWEUwam5ZSDE2K3F2SEhmMEVXbS85VUxwV253NVE0a1hkZTZsZnQ4?=
 =?utf-8?B?cmx0TU5oSHBXVmo0NWc1WXNqL2hIdFVBMmJ4aWxEU05VV3VOUHYzOFNvRG41?=
 =?utf-8?B?REdHTnIwVnJDbVN2Q1c0OVkyVDBnaTJXTVV4RlVaSmxURXFoQUVZWC9RNjRv?=
 =?utf-8?B?Zk5XTzV5Sk1NeDZGalR6ekZkNVFNMlhjckJqeHdOKzJtZHA5S1ZYdFZwYmlV?=
 =?utf-8?B?N2cwWFBmSjZ0c2QvZEpmakVVNXdIT01PUlo1dzRhSDJ3TXhIVktpSExESHNq?=
 =?utf-8?B?aFU0TUt1WWd3cUhuOUR5K2RFWjNHNDBmRmMrMEhVc2M4bW10L1ZXOUVLUGp3?=
 =?utf-8?B?N2ZkVXphb0d4RXIxQUd1T2JTWUxWL0VDL3dobFV0OEw5VDgwVUtuU1ozQTcy?=
 =?utf-8?B?V0RRV1NLODZ2TThFMjVpU0pPRVo1bE1Yb3dFUFdTZE5ZVkdwc1BMMG9BQUZS?=
 =?utf-8?B?N0IzNE94WWtwREdQOGxhZXVzUENIVmZJWDd5V0RUWnFSUVFkL0JwZVpDNEpP?=
 =?utf-8?B?NWE3clBnVmwrbXNrZUhjb29ucHZWSWQ2cWVCSHRmS09wNjJTRlJZQ3Jxbis0?=
 =?utf-8?B?bDRuZVJQZlAxQ1V3b0oyeUJvZGFxMVp3RlZucjF1R3hueTNQYkcvS09jODZM?=
 =?utf-8?B?YVFiZlAvZnJFcFB4cWgzZCsxRHRhNitIOGRRU2szaS9iU3QyKzA0VS9Bc0sy?=
 =?utf-8?B?ZnB3a2QxbVZONm9CMHhONzFZdkllMlkzZGhSbThtQXBoM2dhOUN1RHdUSTJF?=
 =?utf-8?B?TWkzTnNhYjZSYUd4ZXJ6YUNxZG9ueXhDSjVhRTdlNDJRdzIyZWFseXlmR0dW?=
 =?utf-8?B?aytuNFd2TldjMFUyVHBhcWRBL3hpbWw4SWZqZTduV0R2TU91NTFqbTJONDZP?=
 =?utf-8?B?RVplckhJbUdRMm5xckVNNGxCRFVjOVk2M3BYaFQ3V2FLUi9xRFJOOEpEVlc0?=
 =?utf-8?B?cjZhVzVadXFHbndGaE8vVlBOUHc1TDVLclA3aFQrQ0wxcnhJT2RTTFNDblB5?=
 =?utf-8?B?eGQ3ME8xMXErTHRrdGRPaVExUmJZbTZUUkdBWWQxZEFsUWhWQzRGY0d5UE9X?=
 =?utf-8?B?RXU1WnVTc1UrNzdybGdRQUdrMFNJQ01xUVNrK2xMbENsN1ZNcXRXT1FUY2U2?=
 =?utf-8?B?WjZUYWVpOThPbTI2UGkzVWVwN0g1V3FoMXpKdURudHNwbG5iNEI5YkNjNkFW?=
 =?utf-8?B?VklQdlN3d2YxVVlJT0xhZVVzM3plTWxzNm8yWXBNUUN2NkwrcE9PaUVPcEJF?=
 =?utf-8?B?Q1I4VDZFN0IvdWRmWWk5amgrQm1CdGJQN2t3WFUzOFZYUlJlQ2I0ZGxkRUht?=
 =?utf-8?B?RTlzSGpXVHM5V3BNNTdCdy9VQkRSejZFMmZKZ0l5MXlnbFAzMm5LYnJpLzlM?=
 =?utf-8?B?UzJjbGV3N2xwZCtPdXVUTU16cG5MdXJBNVJqREh4MDc0RUJXeTlldmw3M0pJ?=
 =?utf-8?B?VVcyZE1qZUNaTkZ6d3B2cW1QSG9lS0grZG1Db203SDdzWi9SR2hGTnYxeHlE?=
 =?utf-8?B?S2xaNkU2emt0Y1cvMDdaS3NRL01zb01UeExBQ3I3TWxSbGtHdFl4c2pVTEd6?=
 =?utf-8?B?c29pSUhkek9HQVFST3c4TThZSjlZamxYNXRPaEFacnp0cGw0WXgwaDkrMEpN?=
 =?utf-8?B?cmE2U1lWODRocTAzTURpeEE5dUY3dVcxME5vZ2ZyV2ZkMGgzbVFVWDNndGhC?=
 =?utf-8?B?c1VodzNXd1RqTHJqUlpuQTJNajM1bU5OcldCcVhHZjlxL0k4Qk9Nd2VIRDlU?=
 =?utf-8?B?ME95ZXNKOXdNZ2p6SWxWMVc4R0NYdW45V3N2QUVPSzE1N2ZlNUdvNFhTbGFQ?=
 =?utf-8?B?YTFNdTIxY2YrbXRvUFN1Z01UU2tYUVc5TDFRWHFwV0hKN1NiUm8vd21ZaE0v?=
 =?utf-8?B?ckpGdTNVTXZvYnEzelpWWlcyTXBYZDBOVHpmblAwTm13bDlHWDVBRDI5c2VJ?=
 =?utf-8?B?Yld5cXlsM1loVVd5NVl0Y1JCVEtKQ0pUQVpvdEpkTllEUGI1d1pPUlF6aTNu?=
 =?utf-8?B?RGZMOHV0elBndmZiNzB3YmhLRmFEVzhQSVkyRHdKc2JabW53cE4wS004dmJW?=
 =?utf-8?B?UFZSWkplTXdMR0YwNy93R2NBM0p6N29OWk9XVVFTMVFGVUZMd0hJRUtuemVt?=
 =?utf-8?B?UTNKdGI2M1UzUk5qOXhjRWs2M0wzMndzcjU4bGFWSG14OGY2cEE0MU5HTGx0?=
 =?utf-8?B?b2hGa0dYVjhVcTZDdmFCZWlBQ2tVZmxpdTIzdGJoQ25FRjVtaENFZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZV4lnj2xF5hdW+fSNhZlyp5oQMn7RYl3VzeZyUQC9HUn+F9hwzTz8pe2wa8AjoNrVGRMXSRZRey4pU/KQdBRxUYzWf66AI3e45rd7k5oP6o0BuerCGQm4TJvktzSC0ZyVpvSWUIjWSO3I2e2AuOsZB3XwhpFltzTAiVunygrf1mLkNUJAxAW5hr+SkKfhRuOrihHarVWySd8OunWfE3MujpAOxXRFunDNY9BoTcmg24e8KpkPqEo3BI2/uryBfWpiMc36rI38ZjQrWyaWL1cUc6FurintqiXQb7OHLV1lDAdDrhXdyYkNEu9nHq6JG9jRfROmm6WjUImLysbaz0hIQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49aa8d13-4fc5-4ec4-dee2-08df234a6274
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 01:37:29.6168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+speh9cAxF2eQToZARdeY9206cGFzyaUDvFnH2L7Dzl8KfmP4MhWohm9lcb82OQI8gssCMkwMBdrihsj1mc5ZfnYbL+0rSulY07sngYgEk=
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
dGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXQgdjMgMDIvMTVdIGljZTogdXNlIHJl
ZmVyZW5jZSBjb3VudGluZyBhbmQgU1JDVSBmb3IgUFRQIHBvcnQgYWNjZXNzDQo+IA0KPiBUaGUg
aWNlIGFkYXB0ZXIgc3RydWN0dXJlIG1haW50YWlucyBhIGxpc3Qgb2YgcG9ydHMgYXNzb2NpYXRl
ZCB3aXRoIHRoZSBhZGFwdGVyLiBUaGlzIGlzIHVzZWQgZm9yIHN1cHBvcnRpbmcgUFRQLCB3aGVy
ZSB0aGUgY2xvY2sgb3duZXIgbXVzdCBoYW5kbGUgbWFueSBvcGVyYXRpb25zIHRoYXQgcmVxdWly
ZSBhY2Nlc3MgdG8gdGhlIFBUUCBwb3J0IHN0cnVjdHVyZXMgb2YgdGhlIGFzc29jaWF0ZWQgUEZz
Lg0KPiANCj4gVGhpcyBpcyBpbXBsZW1lbnRlZCB1c2luZyBhIGxpbmtlZCBsaXN0IGFuZCBhIG11
dGV4LiBUaGlzIHNvcnQgb2Ygd29ya3MsIGJ1dCBhIGZldyBwbGFjZXMgd2l0aGluIHRoZSBjb2Rl
IGRvIG5vdCBhY3F1aXJlIHRoZSBtdXRleCB3aGVuIGl0ZXJhdGluZyB0aGUgbGlzdC4gVGhpcyBp
bmNsdWRlcyBpY2VfcHRwX2ZsdXNoX2FsbF90eF90cmFja2VyKCksIGljZV9wdHBfcmVzdGFydF9h
bGxfcGh5KCksIGFuZCBpY2VfcHRwX3ByZXBhcmVfcmVidWlsZF9zZWMoKS4NCj4gDQo+IEZpeGlu
ZyB0aGlzIGlzIHRyaWNreSwgZXNwZWNpYWxseSBzaW5jZSBpdCBpcyBub3QgY2xlYXIgaWYgd2Ug
Y2FuIHNpbXBseSBhY3F1aXJlIHRoZSBsb2NrIGFyb3VuZCB0aGUgY29tcGxldGUgaXRlcmF0aW9u
cy4NCj4gDQo+IFRoZSBwYXR0ZXJuIG9mIHVzZSBmb3IgdGhlIHBvcnQgbGlzdCBpcyByZWFkLW1v
c3RseSB3aXRoIG1vZGlmaWNhdGlvbnMgb25seSBoYXBwZW5pbmcgZHVyaW5nIFBGIGluaXRpYWxp
emF0aW9uIHdoZW4gZWxlbWVudHMgYXJlIGluc2VydGVkLiBUaGlzIHR5cGljYWxseSBvbmx5IGhh
cHBlbnMgZHVyaW5nIGVhcmx5IGJvb3QsIHRob3VnaCBhIFBGIGNvdWxkIGluIHByaW5jaXBsZSBi
ZSByZW1vdmVkIG9yIGxvYWRlZCBhdCBhcmJpdHJhcnkgdGltZXMgdmlhIGJpbmQgYW5kIHVuYmlu
ZCBvcGVyYXRpb25zLg0KPiANCj4gVGhlIHVzZSBvZiBhIG11dGV4IGRvZXMgbWVhbiB0aGUgZHJp
dmVyIGNhbiBzbGVlcCB3aGlsZSBob2xkaW5nIGl0LCBidXQgaXQgc3RpbGwgY3JlYXRlcyBjb21w
bGljYXRlcyB3aXRoIGxvY2sgb3JkZXJpbmcgYW5kIHByZXZlbnRzIGl0ZXJhdGluZyB0aGUgbGlz
dCBpbiBhbnkgY29kZSBwYXRoIHRoYXQgKmNhbid0KiBzbGVlcC4NCj4gDQo+IEluc3RlYWQsIHVz
ZSBTUkNVIHByaW1pdGl2ZXMgZm9yIHRoZSBwb3J0IGxpbmtlZCBsaXN0LCBhbG9uZyB3aXRoIGEg
cmVmZXJlbmNlIGNvdW50IG9uIHRoZSBwb3J0LiBUaGUga3JlZiByZWZlcmVuY2UgY291bnRlciBl
bnN1cmVzIHRoYXQgYSBQRiB3aWxsIGhhdmUgYSB2YWxpZCBsaWZldGltZSBhbmQgbm90IGJlIHJl
bW92ZWQgdW50aWwgdGhlIHJlZmVyZW5jZSBpcyByZWxlYXNlZC4gTm90ZSB0aGF0IHRoaXMgY2hh
bmdlIGZvY3VzZXMgc29sZWx5IG9uIHRoZSBwb3J0IGxpc3QgYW5kIGRvZXMgbm90IG1ha2UgYW4g
ZWZmb3J0IHRvIHJlc29sdmUgYWNjZXNzIHRvIGN0cmxfcGYsIHdoaWNoIGlzIGN1cnJlbnRseSBi
ZWluZyBpbnZlc3RpZ2F0ZWQgYnkgYW5vdGhlciBkZXZlbG9wZXIuDQo+IA0KPiBVc2Ugb2Ygc2xl
ZXBhYmxlIFJDVSBpcyByZXF1aXJlZCBiZWNhdXNlIHdlIG9mdGVuIGl0ZXJhdGUgdGhlIFBUUCBw
b3J0IGxpc3QgYW5kIHBlcmZvcm0gb3BlcmF0aW9ucyB0aGF0IG1pZ2h0IHNsZWVwLiBBdHRlbXB0
cyBhdCBpbXBsZW1lbnRpbmcgcmVndWxhciBSQ1UgaGF2ZSB0aHVzIGZhciBub3QgcHJvdmVuIHRv
IGJlIGFjY2VwdGFibGUuDQo+IA0KPiBUaGUgcmVtb3ZlIHBhdGggZmlyc3QgcmVtb3ZlcyB0aGUg
cG9ydCBmcm9tIHRoZSBsaXN0LCBhbmQgd2UgdXNlIGtyZWZfZ2V0X3VubGVzc196ZXJvIHRvIGVu
c3VyZSB0aGF0IHN1Y2ggcG9ydHMgYXJlIHNraXBwZWQgd2hlbiBpdGVyYXRpbmcgdGhlIGxpc3Qu
IFRoaXMgZW5zdXJlcyB0aGF0IG9uY2UgYSBwb3J0IHN0YXJ0cyByZW1vdmluZyB3ZSB3aWxsIGRy
b3AgcmVmZXJlbmNlcyBhbmQgbm8gbG9uZ2VyIGJlIGFibGUgdG8gYWNxdWlyZSBuZXcgb25lcy4g
VGhpcyBhdm9pZHMgbG9vcCBpdGVyYXRpb25zIGNoYWluaW5nIHRvZ2V0aGVyIHRvIGluZGVmaW5p
dGVseSBibG9jayByZW1vdmFsLg0KPiANCj4gVGhlIGljZV9wdHBfcmVsZWFzZV9wb3J0X3NyY3Uo
KSBmdW5jdGlvbiBpcyB1c2VkIGFzIHRoZSByZWxlYXNlIGZ1bmN0aW9uIGZvciB0aGUga3JlZl9w
dXQoKSBjYWxsLiBUaGlzIHVzZXMgd2FrZV91cF92YXIoKSB0byB3YWtlIHRoZSByZW1vdmluZyB0
aHJlYWQuDQo+IFRoZSB3YWl0aW5nIHRocmVhZCB3aWxsIGJsb2NrIHVudGlsIHRoZSBmaW5hbCBy
ZWZlcmVuY2UgaGFzIGJlZW4gcmVtb3ZlZCwgdGhlbiBpdCB3aWxsIHVzZSBzeW5jaHJvbml6ZV9z
cmN1KCkgdG8gZW5zdXJlIGFueSBvdXRzdGFuZGluZyBTUkNVIGNyaXRpY2FsIHNlY3Rpb25zIGhh
dmUgaGFkIHRoZSBuZWNlc3NhcnkgZ3JhY2UgcGVyaW9kLg0KPiANCj4gVGhpcyBmbG93IGVuc3Vy
ZXMgdGhhdCBhY2Nlc3NlcyB0byBwb3J0cyB2aWEgdGhlIGFkYXB0ZXIgcG9ydCBsaXN0IHdpbGwg
cmVtYWluIHZhbGlkIHVudGlsIGJvdGggdGhlIFNSQ1UgY3JpdGljYWwgc2VjdGlvbnMgaGF2ZSBl
bmRlZCBhbmQgYWxsIHRoZSByZWZlcmVuY2VzIHRvIHRoZSBwb3J0cyBoYXZlIGJlZW4gZHJvcHBl
ZC4gU3RyaWN0bHkgc3BlYWtpbmcsIFNSQ1UgYWxvbmUgbWlnaHQgYmUgc3VmZmljaWVudCBmb3Ig
ZXhpc3RpbmcgY29kZSBwYXRocywgYnV0IHRoZSByZWZlcmVuY2UgY291bnQgYWxsb3dzIHRoZSBv
cHRpb24gZm9yIHBhc3NpbmcgYSBwb2ludGVyIHRvIHRoZSBwb3J0IG9uIHRvIG90aGVyIGZ1bmN0
aW9ucyBpZiBuZWNlc3NhcnkgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IEZpeGVzOiBlODAwNjU0ZTg1
YjUgKCJpY2U6IFVzZSBpY2VfYWRhcHRlciBmb3IgUFRQIHNoYXJlZCBkYXRhIGluc3RlYWQgb2Yg
YXV4ZGV2IikNCj4gUmV2aWV3ZWQtYnk6IE1hY2llayBNYWNobmlrb3dza2kgPG1hY2llai5tYWNo
bmlrb3dza2lAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29i
LmUua2VsbGVyQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pY2UvaWNlX2FkYXB0ZXIuaCB8ICAxNiArKy0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX3B0cC5oICAgICB8ICAgNCArDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX2FkYXB0ZXIuYyB8ICAxNyArKystDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX3B0cC5jICAgICB8IDEyMSArKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTE2IGluc2VydGlvbnMoKyksIDQyIGRlbGV0aW9ucygt
KQ0KDQpUZXN0ZWQtYnk6IEFsZXhhbmRlciBOb3dsaW4gPGFsZXhhbmRlci5ub3dsaW5AaW50ZWwu
Y29tPg0K
