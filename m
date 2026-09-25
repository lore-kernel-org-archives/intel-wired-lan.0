Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E837C98321
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 14:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1AEB60DB0;
	Fri, 25 Sep 2026 14:30:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dK5NhVLnRsgG; Fri, 25 Sep 2026 14:30:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1520760D5E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790346644;
	b=RRRMIVhlujaHA7YwTq5xGnp1hsnx2u/CLbTdKHrc+nMveI3P1p/iHo7egMI+EE1bdtaI
	 ZzQ6qm7EWYfVuHPwJWJBbJF+iNwEpmjU8PWPNXvYtC0totMZ53uXUBQDYe2PXiSrTteIo
	 cRKCwKMtgO+SXFB73XY1X40+R6yYfnNx21EpGyhtpnpypjtc+WKzCVjz8kjNgxBSLt5mg
	 qud7tPD4Ge/4HmChMc8El/1R1Y34B+K2ywcKS3Xz43xFn2uNdf4H5IPj5K8mi+y5vf69g
	 tI4LEENwGOxnEa2SPaDs5KkykgL2Ovppi8v1mMdTyBI30lRy5X0ffMOpGrYCCMK/Kmw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346644;
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
	bh=v9Q5FmynN1ZDloR0Qn5cIQheETOtLWz17VJcmPwAuzU=;
	b=rPP4lpzJD8h5FQSXqlSLvhwg6lNtPhvoCjeM1x0yRKZFSdnzHTqnfvuK7CRY0bzjUZnX
	 bn1htKEZRuABqfsI/zbz5JvBhzt7u/wfTygINMpGu0PGIKBPiHerlv/jf1tjHb4irf8s/
	 VETp3J8WOA+gKrIKwwKs36TRqqF/AiSj1MyXq0ysuTGFWW8fWJLfX4pffYSswsfVDSUV7
	 LyI3gK6fZ+NUxgdKEYzn7abZIqkkXAABd02ad9WLZp5HWVFKtgtaw3ujiNoZ2RIPjhIwZ
	 wkkMcNNfza1F6Dq20jlzT91pc3XIKGw9Cry9AqyRMn9T4uTUmc0csOHwTNmcTY3Tigg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790346644;
	bh=v9Q5FmynN1ZDloR0Qn5cIQheETOtLWz17VJcmPwAuzU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hTvgMVTkoKhw2zqnyLpPCOWxu/aOG/9Osjragt3J58yVBFT0vDtHl5rrRPUSEFbYS
	 iE3QYBUoaEFIQb44O4CUoGk7Y7X41ghx8+OHcQ4N96s3gqWAq5O0WwEsVNCjhqS6Fv
	 viAfqBkITHZz4hlWQ+m4ZImwWJMs1tOTfxpSoFN9e2xo1g/Zwtk2kJ9+AI6DNroJcW
	 R17/FSvulOpclX9gMCG0IAepGD0HllIMn4Xqe8ZGzRtD0FPS1WDwMb7XQnSCE8jS7k
	 t9zUz6r15xekSPt5uf/alvJzhVN+ie7RgLDy+oIbelZCkoPNAMZpL11DvYt0qytcqL
	 5drNaEVknyDzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1520760D5E;
	Fri, 25 Sep 2026 14:30:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 723CC35A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 586BE4016B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:30:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c301pxyJrMp7 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 14:30:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6CBE94005E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346641;
 b=ei1+UH2p9UNA6MKeLQXuPy1UBzpIgJmSU4wd48MUMlImiCopT8r/odCB0HXGjsKrW16N
 4Fk5IQSm16CYiQZyNNPzZ3UU+cWeIN4dErjD/8gPa2TzVGb2GZEsIuTToyfLOyALk4CDm
 PAngWgRREN8Y+epnsFXXbEcWkm79d34i48mIveBU5nCraTZTb2FAno6A3H3hDl/mHig2d
 nkwOyQUzbWCDDzu9JLjmOg/L+EhlvtckBFr/0EmWCVfjukBAij3Sddx6wlWlpkRN8SYn/
 r+Gg/QBgdMc/j9MNocVF8++hr1Rv19SnML6VbQmBclTjEfUKlOOI4NvILJVL+gKXAIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790346641;
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
 bh=v9Q5FmynN1ZDloR0Qn5cIQheETOtLWz17VJcmPwAuzU=;
 b=P1V2d3yvl2nGSSkeK+I/dRW3d97lo4c1cyZf59xf+SYvc0otHCnAeoQUpk6Afw/S0I9s
 v2Hk0J7zOuQSOot0TEF9RED1qyJR+wQ0s7wPi67BW3adtzFgMsrNd+uAXUpblbl4rJfMr
 4rl1EB4Br6flpV23OdmYKxEFUFzDWjTtY1YS9xA+rHuh1/3ET7xs486WdofkKgRptNGAX
 Roky2rho05+hIiKmfR8lLu3N/q54rYSvlFvPHlHUx6CYCpM7CNwQ0pg6jk+ygJSjLrS5N
 AwidTJdLZPfh2RsihzGXtJjf6lUZTdb5u4dJF96g6+OAYZOTnEjlt+1ZLGyljT5nr1w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eoEErXTo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eoEErXTo
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6CBE94005E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790346641; x=1821882641;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VqrM6RnQtFKXqGoaiHaa1dwCknU9/fhx3ovW8Q648v8=;
 b=eoEErXTo9VA5jfZwBKKhG0cUU/d607l4SUG2kAXYdS6cFNkKvz/64MSE
 I4JHZxqw9MHNG79uJSyNXp1SjciQklarjGfu+ntrIEQaF6BAr+ONSzYz/
 rNgdJYcmxBQer6WGs+Gy5Z8ZZkBK/qXene2rMHekdy9C1iDBFvQ92fWLJ
 2ntxgNxu4hDjrN1W9LyyFyX7q/WGsyBoNjbstIMOzCKTAbJ8QESANE0Ek
 UpG9HCfyxPAYz5cvfOa7oVAhRCzQTCjXmHEFRjzq+f6RGbrlxfDpPZsjY
 mCRLGkWG7J3SbRNBcVl+Ojeme0eEmEMqHXM7rkugMsUXEl5reLwrOAr5m Q==;
X-CSE-ConnectionGUID: OJmIkaHdSmiLT5p3e1PkAA==
X-CSE-MsgGUID: CBOu0tv+Q2WnfehMFQc3Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93850463"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="93850463"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:30:40 -0700
X-CSE-ConnectionGUID: PgC3zQrFTh2FwLRXT8Nv5Q==
X-CSE-MsgGUID: uHPTFvDiTmSGEdtH3ZYH2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="273904113"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:30:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:30:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 07:30:39 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:30:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVROOu4x7myrK1CJSi+3+tmGTv9NHBGX4NWKsjagN2r0iHpXxhnVJAOkhiuqO9CBjESwJyH+Z3L04wkr7OnLk2gybQ5XWOopkKWXl3pzFdYFEZnzsqipr0ECTF/rzOIfNp2qgj9HyeliylsJuupymhn40irIZtoGuGc/AODDwYZHZmDJjYmO/q6DfGKCFsSlI392ww+N6kEiPQwpmWsMs2OvgNzKTKVFDUM54p3YSvlJ/deplagAx4wn19Cx9V40b6LP9iJ21fjt4QeSzo9zxUs0lbSjFclApFHcSEieQVyJPPX+Wbw2PP2puMobNcunIBS6rcitOAtfO7ZZpIdDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9Q5FmynN1ZDloR0Qn5cIQheETOtLWz17VJcmPwAuzU=;
 b=VEDqJ+hsQiBwxCIulZbLiYdU0992gv9wR0Ww57HcROMMXelZ0MV78WQDvdLEUFHKBVDkiYrtqMqXHzT7S1209VAnlTBRnMZuSK5lmssVBkJIUmr2qi4dsWQczt9XIvHKlCxFusL4FFexpN2ATTGK0zgQybw8fhigvrJY/JhbU/W79+m2wtTisbqEvEa4YDrfN1A0bhi/sgce2cI1uTvU260xojGr/xy94Zyrg6uWFG7Cih+MkSInp9kOuf2zTJa2Qxcd7XBo/hKIczR9vq3g5gGWk8hnFsULhSDaQjk+T0ygdOaMScBFupunJMk8TdKBlKE6oUDq1TAKplpMzKiFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SAWPR11MB9572.namprd11.prod.outlook.com (2603:10b6:806:4e2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:30:35 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:30:33 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
 <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Schmidt, Michal"
 <mschmidt@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "edumazet@google.com"
 <edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>
Subject: RE: [PATCH net v5 2/6] ice: extract __ice_vsi_free_stats()
Thread-Topic: [PATCH net v5 2/6] ice: extract __ice_vsi_free_stats()
Thread-Index: AQHdTPGSA6Acs5FsF0qJICcj4QV0FLbfWuYw
Date: Fri, 25 Sep 2026 14:30:33 +0000
Message-ID: <IA3PR11MB89862DA76E2A7C095138A304E5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
 <20260925132636.123300-3-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260925132636.123300-3-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SAWPR11MB9572:EE_
x-ms-office365-filtering-correlation-id: c8dd7df2-55cb-4bb4-c550-08df1b118f02
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|11063799006|10067099003|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: eSV00Hluum+ejRM+KI5wOrcg2Nx8p9yf1gv5YzSXNIp40NMyB2kHYEKK31bNcYCExgLLb9Lj/CMuALzw63Kyg/LvIBupmfTe9yhVFHiiOYn5/BCTq9GKApX1Ai6yARsrmIqV74ANuqTFvNVPB8MB5kyOWGCQ1Yzl1fLNQQYoWOih9CpGNOFVSJsfbhVI8oDLXyD+S+YkW1w1qyvl++1gNGHiClZ7XcVGHQsoEA0/XoYWDAS2GXEKZqHcETnDqXWGuKpdZR+VeMKYpe3rwfqSQWTkvHWb40Wlw9f4GeIqDdRwMdpDAW3ajxyCasmfMgu/OAkhSrLjMLhoqmnul97UvHxWTmh5h/iupBks1pkRO87bpuni21DDTFZYNbSlyQdPFe/9uDJoZPrLANSwNAN6dNoX4i8+FHaUyQjb6J6m4rbkY0r0D0/NVo5GTnH4Gi437YrHpv9oBpNMvw9ziwkuJol0ahFDrROFYGJqyWsUcAAKHNAaMagx2hC1f64Ae4KNX1KNKJZvQS11JFtzzWTeSbCwrDYawX/vXpYrMLlgKmi+wvTeWnGAUQmVho0zAwCj3rQHuoEoC1+GanPjuYhDGIzr3FzmElHS1Cz7NzYISWpu6OLSm8RGsnw9ZSN3N5tVfOnefjzxSwRDhx2pWkARHctsetktdOSexF+mLnGO2k6R7opNH/6JXaPYYi96TtEFMC4mpQQL6q8pxGlEwXmua7AuxQQJjj1bdarW/nHfrSo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(11063799006)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jEPosSKPTqg6aMJ9jJHRWc72tg4yy+zr77Xk5TUwIFPYMIFrbJndFhoQC0vP?=
 =?us-ascii?Q?9augVlcVz8cfA65E7/1vbc3rq1hTSwKy5hGGBRXEizdvsuM03X21mr4C4KHJ?=
 =?us-ascii?Q?qomQHnbiy8rFiyza8gtVm4b6kQq3rmHVtyTdv/JYCUTJ0lwkY561T0xq2wHy?=
 =?us-ascii?Q?umj9+pzuw08ZMAsaV9ZlzOXfFyFuFL+D7N0/P0zqboIFbFdOqze6p9uGtAd6?=
 =?us-ascii?Q?D3mEI0PSyoZfPTJk5jwtreI6I95uHp70tRGzc5oIfyQVsIB1DoXXFKCquq9o?=
 =?us-ascii?Q?5SGBsuPWGNk6K6VsRZjyVgLyvuSkhO9UDahoUfVD5suSRarAJAaECGSdA8S1?=
 =?us-ascii?Q?jPqh2pQACK6Rcnw1N+RhSo8gfRxwKHKMndBJrETl0wqfMZc9tYefngjigaUJ?=
 =?us-ascii?Q?2lTlucrpVd6bfbO0yGfJSdynyb2m97PbHrDDA6Kmcj1rKH5ADmI8wa1FzaA2?=
 =?us-ascii?Q?ZPALnJrE5pdpwIX+NIpeHGUgTfAKclOoXZyxs1mztc1Gx7ONgcSNgQLIQHGf?=
 =?us-ascii?Q?6+NzQxsVHSy4UnbGPBVQLDWzmUv95Q7Ry8rGyV0FfgtKQ61rsrHKLNsUYaEh?=
 =?us-ascii?Q?llKI/uiqH0ApbnijvUPRounxRP8PAYlW7MqAiGl+K327AZrbHrPHYgynXjhX?=
 =?us-ascii?Q?51WYJYuEYPe2YhH1zhR7o7jrIwPF2d4J6zR78TH4P/m40m5JYm1P493QpG5C?=
 =?us-ascii?Q?DyoBW0Y6h6zlmBSDWqoE+H5o8bkXhXb1tXuRApEH4o8tbV1aejm65KdSJdxk?=
 =?us-ascii?Q?2nXJM0j7uONN36aeIF5JzvcGt2tmGBvdTNfmxJmRWwBllp7iPcpjNvCaypK2?=
 =?us-ascii?Q?Q2P8wc3SalJapupxvIQ1JcS1vvLRuSovDlb1wrWW0m/7LTbPqViwOjRKeieD?=
 =?us-ascii?Q?S/siYRaGu5pGHAE4XD+hQn1/XoK2/drJyoiq9fjiaGb9fPulfIkyZsXppETN?=
 =?us-ascii?Q?zQOwxo5PORTptGfupQChV1FINb6/mDdUuZb+6FWV4DG2L0igRiuyMfOZqJ+e?=
 =?us-ascii?Q?mwcIj9iTLjZZVYudPhYUEdY+22WHyWStbvqhVdlo+2A96u6MkL06/3yA8iaX?=
 =?us-ascii?Q?a11JDFB7bjiS1feZrfQF1900pknuF0UPaY6Ig6tmRdXNNL6GQCrbjKuO1K3V?=
 =?us-ascii?Q?ABeBo1DeC7CY10U9QBUbvCuC8P/JHaWslTefHMK9d/37T+vhU2v5zHY9INRZ?=
 =?us-ascii?Q?HZToXReWimvBMjHvbQpBVJ2wT0qYQtgrk0FRtyl6e9wUJI/ODQ/mq09UdOch?=
 =?us-ascii?Q?J9gxc/mQcYIfs5UI11fqf4AD7IYmnWN4jSeLs0J/mJ0H/g46sXQuMoRaHN8K?=
 =?us-ascii?Q?ysl0e4H4ikMQABBvyrNFE9iHg3oRemOvVC2vD3BPttUf3Ep4zRQRLb/nSRQ4?=
 =?us-ascii?Q?UsP7+vx+YrtpXxZfrFqX5wfgs1A4sMoBUlzsHH5Opyr2pZdHi9MyPQ5JJOtS?=
 =?us-ascii?Q?HUb7M+i4i4QdOPIOE0mRWzwCX4SyQ3lCLjEEev9svApmZfQhHbM/hx1yqVG4?=
 =?us-ascii?Q?DX2fDur+Z4I/xjZVia63pVsQd+pVQ9K5mr2BY2rFlKjYc1GtfdHWwYIYOo+1?=
 =?us-ascii?Q?/9aZOGIBAa/dNWjE7Xn+2ijidjaM2NnRY9v0ew5679dejGZh2xOYf3fLEclR?=
 =?us-ascii?Q?weJYF/uWeFeIW70X0JiThwAOv6CzmIX0UitRfAiKvx9AgAETLPMCcye5kTaD?=
 =?us-ascii?Q?eMl8xTWyqhXnmGA/SOpM8FMDDWFzlpNuMT/MN55uBZS38mQWH/qYrVyyV8gc?=
 =?us-ascii?Q?iQ44EnjsvQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2AiEvWQ/27GIEyhHTOunTte/eCOhVbG53MnrKLJDvx4b8GyM+myKcMSO0pap89+IYNbPJ+M3BNIXni9k834xfCJrN01/qEsvoJEDA7NrbzQWbJuiEdu6DfmxBnUp+qO6WAXBxw0Gs2BpzABwogLQn6SMt2P1htrp6a43qQCCfeD5a0a9Kr+ZzCt2mivynT6NzXJmqKW9CwZDzfk5Xjc+9oh6H+NRrfM9bmPEVe+hT203Gm1gi3iiyNo+7yh8ArUSExD7gR9bvkciuTvOgzPxsTfAvlD3hpoEnDqCvI/vbXhFcP9C9H4HRNo6tlCdhw9R3FCpGYr2AX51AKxX2zzFIA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dd7df2-55cb-4bb4-c550-08df1b118f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 14:30:33.7393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptBidtV2Pt+jSqGFB5MI4rWuCoqffyozvbE2Jdqkomn+pdFxHENXKiCshUE5dRHcHG/WbAbhqNB5oLFY1i9aEShbCCRbeuV+XDfbc2m6nbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9572
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
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Friday, September 25, 2026 3:16 PM
> To: netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Schmidt, Michal
> <mschmidt@redhat.com>; intel-wired-lan@lists.osuosl.org;
> edumazet@google.com; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH net v5 2/6] ice: extract __ice_vsi_free_stats()
>=20
> Record the length of each ring stats array in struct ice_vsi_stats, so
> that freeing the array entries no longer needs the owning VSI. Keep
> the new fields in sync in both places that size the arrays.
>=20
> With that, the body of ice_vsi_free_stats() becomes independent of the
> VSI and can be split out as __ice_vsi_free_stats(). The @free_entries
> parameter is always true here; a later commit adds a caller that frees
> only the array container, after its entries have been handed over to a
> freshly allocated stats structure.
>=20
> The free path now stops at the recorded length instead of the VSI
> queue count, so it follows the real allocation rather than a number
> that can disagree with it. Sizing still does not: "ice: rebuild ring
> stats arrays instead of reallocating them in place" starts using the
> lengths to carry entries over, and only "ice: size ring stats arrays
> from the final queue count" makes them authoritative for the
> allocation path.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v5:
>  - drop the "no functional change intended" claim, the bound of the
> free
>    loop changes owner here (Clashiko)
>  - state that the recorded lengths govern only the free path at this
>    point in the series (Clashiko)
> ---
>  drivers/net/ethernet/intel/ice/ice.h     |  2 +
>  drivers/net/ethernet/intel/ice/ice_lib.c | 52 ++++++++++++++---------
> -
>  2 files changed, 33 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index db3c7015c56c..fadfe94bf1c8 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -328,6 +328,8 @@ enum ice_vsi_state {  struct ice_vsi_stats {
>  	struct ice_ring_stats **tx_ring_stats;  /* Tx ring stats array
> */
>  	struct ice_ring_stats **rx_ring_stats;  /* Rx ring stats array
> */
> +	u16 tx_ring_stats_len;  /* Length of the Tx ring stats array */
> +	u16 rx_ring_stats_len;  /* Length of the Rx ring stats array */
>  };
>=20
>  /* struct that defines a VSI, associated with a dev */ diff --git
> a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 31af378aa0e7..1414127d32cd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -330,42 +330,48 @@ static void ice_vsi_free_arrays(struct ice_vsi
> *vsi)
>  	vsi->rxq_map =3D NULL;
>  }
>=20
> +/* free single stats memory */
> +static void __ice_vsi_free_stats(struct ice_vsi_stats *vsi_stat, bool
> +free_entries) {
> +	if (!vsi_stat)
> +		return;
> +
> +	if (free_entries) {
> +		for (int i =3D 0; i < vsi_stat->tx_ring_stats_len; i++) {
> +			if (vsi_stat->tx_ring_stats[i]) {
> +				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> +				WRITE_ONCE(vsi_stat->tx_ring_stats[i],
> NULL);
> +			}
> +		}
> +		for (int i =3D 0; i < vsi_stat->rx_ring_stats_len; i++) {
> +			if (vsi_stat->rx_ring_stats[i]) {
> +				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
> +				WRITE_ONCE(vsi_stat->rx_ring_stats[i],
> NULL);
> +			}
> +		}
> +	}
> +
> +	kfree(vsi_stat->tx_ring_stats);
> +	kfree(vsi_stat->rx_ring_stats);
> +	kfree(vsi_stat);
> +}
> +
>  /**
>   * ice_vsi_free_stats - Free the ring statistics structures
>   * @vsi: VSI pointer
>   */
>  static void ice_vsi_free_stats(struct ice_vsi *vsi)  {
>  	struct ice_vsi_stats *vsi_stat;
>  	struct ice_pf *pf =3D vsi->back;
> -	int i;
>=20
>  	if (vsi->type =3D=3D ICE_VSI_CHNL)
>  		return;
>  	if (!pf->vsi_stats)
>  		return;
>=20
>  	vsi_stat =3D pf->vsi_stats[vsi->idx];
> -	if (!vsi_stat)
> -		return;
> -
> -	ice_for_each_alloc_txq(vsi, i) {
> -		if (vsi_stat->tx_ring_stats[i]) {
> -			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> -			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
> -		}
> -	}
> -
> -	ice_for_each_alloc_rxq(vsi, i) {
> -		if (vsi_stat->rx_ring_stats[i]) {
> -			kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
> -			WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
> -		}
> -	}
> -
> -	kfree(vsi_stat->tx_ring_stats);
> -	kfree(vsi_stat->rx_ring_stats);
> -	kfree(vsi_stat);
> +	__ice_vsi_free_stats(vsi_stat, true);
>  	pf->vsi_stats[vsi->idx] =3D NULL;
>  }
>=20
> @@ -539,11 +545,13 @@ static int ice_vsi_alloc_stat_arrays(struct
> ice_vsi *vsi)
>  		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
>  	if (!vsi_stat->tx_ring_stats)
>  		goto err_alloc_tx;
> +	vsi_stat->tx_ring_stats_len =3D vsi->alloc_txq;
>=20
>  	vsi_stat->rx_ring_stats =3D
>  		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
>  	if (!vsi_stat->rx_ring_stats)
>  		goto err_alloc_rx;
> +	vsi_stat->rx_ring_stats_len =3D vsi->alloc_rxq;
>=20
>  	pf->vsi_stats[vsi->idx] =3D vsi_stat;
>=20
> @@ -3055,6 +3063,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>  		vsi_stat->tx_ring_stats =3D tx_ring_stats;
>  		return -ENOMEM;
>  	}
> +	vsi_stat->tx_ring_stats_len =3D req_txq;
>=20
>  	if (req_rxq < prev_rxq) {
>  		for (i =3D req_rxq; i < prev_rxq; i++) { @@ -3074,6
> +3083,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>  		vsi_stat->rx_ring_stats =3D rx_ring_stats;
>  		return -ENOMEM;
>  	}
> +	vsi_stat->rx_ring_stats_len =3D req_rxq;
>=20
>  	return 0;
>  }
> --
> 2.51.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
