Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DE2C79F9E
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 13:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8819340385;
	Tue,  8 Sep 2026 13:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JoviWRYSemPJ; Tue,  8 Sep 2026 13:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D9F5440396
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788873275;
	b=BQkcQ/yRYSOqWcSDNiCCr+Se4la8J8pQOPw6xHU8Vy0ef5MdXpLWjCnPU1zYPixZWsYd
	 Pq7orCE5wuxfAxWd2ustUA6TG/zafDjv7Q5GZw9CJ0LwD/VtzdX/M83KVXP4MQE86xoiQ
	 RYWJC3tJ5ZWmLz5umwHS5LGtqscPJYzegJ1hsdonA/QJX2rIHPZBFPGbXefXGSR+SU8D8
	 LKOd9tMB+H9quLU5YOFwHgAmvhgq+q7Wj7EMpguuRG+8xnO1UfckOOngaF4riz7SJFH4B
	 QbAroHHm0O/BX6dQTMkD7P3DuHCjm+AkBBMRYR6M0hurB6l5bZuJvJ+JxIxJgzcmcBQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788873275;
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
	bh=CwsYeRpTQ0D/YL8PBayE47IV/KiX8bVrzp7yKxQwO38=;
	b=r3xzM7bhPuXMc+FFFzeMMEOERGARRr8+pvVebQwMM2LpwPBqooUCv2kRSFJQ0+q0NJIJ
	 c8xQ0yJMR/2OuJ8VIAjYWVsFRC+4INz3GX33jfzpjdPD1Pu+jtN3MOx7vyNdKBg4wOwb9
	 CFwNzTJnes52Lz/v+l/8gxZN5KhgBmAR6b2qb0s23JKVnwnCBxfONkAnQQ1dN2WuwnXes
	 7q+7MdfzBZPDoYrqhTlvXGOuqEC3A5t+Nq/ZhADRMkEOfHDFV4WhnhdXtPDysmZpxszrI
	 Q1/cTNGly5sRDiGo8DsoPGw7MkkZQ2npZ2AXpk+gkw+UkQ8kDhGthsAIeU3ajI8s6nw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788873275;
	bh=CwsYeRpTQ0D/YL8PBayE47IV/KiX8bVrzp7yKxQwO38=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iMEbmENlFZBHZz89GOna41op4J8cr2ZTeuz8vNgj1RzIY4UiAVRhQeJNOsA5OurJ4
	 4hHK7TDHsReRFz7APEumnygNZ3nV+wSUTRhznCPweDta6uQSmrFYF+gLnmIaGzU2LI
	 ZRh1FqeS/bjV4F5PjtNmq7OupHn2U3CncAgwTj5Ujk+IEDLo0fRXODQEtaFnqIIe2+
	 2uhTJmUfXKl9+ezXW3cHVNP7vnRYJ8OZFLrhGp0lhGPfkECGhg7zRYblBul2RFdT1o
	 ACJ3iQErxQlLGSfeOo4EL5nXzK7Oh9pIU/vTQWTpNwUKQKXiqykTecEefbuDey+jnn
	 hRpp/mTJcq8pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9F5440396;
	Tue,  8 Sep 2026 13:14:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 06BF8D5F
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECDDA40165
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YPLpC78l6KFr for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Sep 2026 13:14:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 37190400CD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788873274;
 b=KYQFog5sWzp7L9DUNjN19hfQKVb/C13XmZornV28Fg/sqCRQZ8vZPN9u15LaVJeebWI2
 ZHBqurTl5y+Uxc/B8LZmkJd6TxHfLCFrp7Qs5RF9m8pw6f3B598esgw3QTkonvA6W5W/d
 mn/xIPgksU82J1r7tnZLv+lP9me++CYyTzGkB0k60ZxrTWHS2t0ep+GfkIMFwUu3gfPAa
 dT+j93ghC4z4AZGbq+PrxugRdrFmFVg9JPS2fodTlFrx9MjrXFw0/vvNRuTVr8SoY67AA
 hwNKD1ZUynCV8/emZXwTIZELXSLMakUBOccIePwfUrxKFPDHKd4JX0ZOE2GTUIrbCvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788873274;
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
 bh=CwsYeRpTQ0D/YL8PBayE47IV/KiX8bVrzp7yKxQwO38=;
 b=pLQNhioBUj7GIY85lT1HMKITKMk5JOrLLlToFgWzd29HqV7SBspvRTlT1+SVjyAwncUF
 z8wRWEwYovheRFMuAEfbS8BMee1t/WYkXwKeON+tHehTFT17r5ZZNuo+lraK9NjI6Sh8s
 /lHhgPjgu2Jmmz8xhLL8zUeMgbmD+pxGbsbfuNK11xMxEjfPWlqdmZIEokH85+qAHFJQB
 BEMfwWThISOHU/7ZDjn19dyYAUDA+A8pNY6Pqxp63wFVIMmtKA4frdiWNctC310Is9qRL
 KRK5m2I0XCpKTKUOz/5QOmYu6Eo99eDAQtJKSS8s/u0VxkFfRpN9m13EM5sXpGVFzGw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aG2ZAGhH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=aG2ZAGhH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37190400CD
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Sep 2026 13:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788873274; x=1820409274;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=t399ww7Jhq1J0ZnWk6h+BPZhZpYtsf3+/lG8z97CWg0=;
 b=aG2ZAGhH8DWW4U4ou9Yp+wdSeqL/uC91A9QWaLiLxh9zH2L0IxvjnQi4
 ysKkTCV04gXRn870vRn4X2dNEwm+Ur8Yekf56QHlJugGr7TsAKekgG9Hs
 0YFQpDu/HvClazMBUulptGbge/w6OPL3tXkV06L0QmL8RjUVNxfqviO6U
 nsKCT2+fzVpB3IkJo00KewGw4fgpfpABRZJhm7TBGzq+F8UTq99o+wAm5
 0rdOQWNllEFVBZTzxG3xtigNiegctKAXt4o2U4Xsk2awHiWSzR5xQFI0G
 M+eDXzv03BzLv81O807LlY0Mjnp0zBwUPa1ht2mvQP4DRm2V+bpB5qzrO g==;
X-CSE-ConnectionGUID: m8pkfvbVSd6jx8Miy4z8rw==
X-CSE-MsgGUID: NayhAR/7ToO4vkfARPSB9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="91785720"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="91785720"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:14:34 -0700
X-CSE-ConnectionGUID: ZujWaguTRX+lgsMX4bPh2w==
X-CSE-MsgGUID: 8fTy/CLfTgqUoL8TLOfWsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="294499181"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 06:14:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:14:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:14:33 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb1RowVkRO4rf3pr0+zguKDcH3P4KSpXwFIBnw2YqdKqzvBSqD5AIvOpJ506X5IpxbT9lk6xnViT8nsCI8Waz1QTMwejTY82U/HttxoTxbGjBxP3i3hms0RdHrTLPYkJOdZsIPcolSfAWhGakUPtV7ctCzS5ewLNeGdUhXDDOOFn1PZBXXkGvnz6i6z5zvl5SrUTxdJKAP2dcmQTmlEqhINf64ie3gI6Jji8DNkmecqckrpneiq3BEAoYy+84+qtd/Vq17UaSURmoqQm4hzz3okmCtmKoj6SVsKxM4mMVs2C4HoovsCli38q4jS/0q5AcJwLnledSFEDGUwstn213w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwsYeRpTQ0D/YL8PBayE47IV/KiX8bVrzp7yKxQwO38=;
 b=dmqYzi0VIa51RvaXIHROorB1+ZwqsPPJeaTvNSROm4bQnIULm4JBmBvBHCYAvOWCbvUim7olYwepDm8IeCieizg2CVjWUlcxExrL2XW6ylP+Hi+V91xBPzDq1JRoLUME04KIyhfOPtknqm0glME/Zu1IbktV6Uin5JX8Qntqoyhb6bAxWQdEl8zQRoK5cnUxjgQtecNSorHzB2ZINBjOTwIWWAYfuDmSv8uXs0wPNQHmyO2GJv3thI9uo9dDqfZBtg9fRI58BIHiD8A9UQC9YjPpiX97SqFiYZghLqKSLoHB9rXQkhlnXtMwNe3+Gxv6dYQsvcIxROHmu8pd5K3F3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:14:31 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:14:31 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory
 leak in interrupt request
Thread-Topic: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory
 leak in interrupt request
Thread-Index: AQHdPIOhsAghvpo9ukSzrE3O2utT0bbEruLw
Date: Tue, 8 Sep 2026 13:14:30 +0000
Message-ID: <IA3PR11MB898652715785B4094C61E50FE5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260904091827.911123-1-zhangyunfei1@kylinos.cn>
In-Reply-To: <20260904091827.911123-1-zhangyunfei1@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7748:EE_
x-ms-office365-filtering-correlation-id: 3165caa4-1733-4878-2226-08df0dab1e76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: 8nHQk8ORYUyQNNRlTZVPIfgv8td9QUuKFPZ6MA1oBiexAOim5wS+RtZXsx+7QUJQUVqZEoiUCzAS0D+VKYEn/Z+Nx6aDtoHHVF4CFaNe2OsolEjJWcHifJQoAsrbqo7w4xfy2Tilg1F4TSI+R1EpvygZ3/RySAJWAm+3CyCvkF/iAO/93bLrAgWjYHXSCAeR+mFcl4xhgARBQebfvEsMqSOlj0PldHAfDE+mHoZm5eXJs9CUz4cBN8VdYeHSrxWDkVlIK5krcN15b+FIdPrCnpMAWOlCeNjCyjZcTigqddKaDfINAumDwDlZ/dujxqDKcqqaMLe50+mvhnXzShCzRWIr6l2NjKeHrSe1P4UlDDs4n/2ERzwavyRcQfN7fy4iDR0bs5XL6/ZNyT4BlbDrv+gKXwNfcethmq+UW+zV/Gri31NKjIJjFDRp+EY970y3+ZPEswz9sZ4XXL+BCReh5OLHbxnEei6MLKFRpBrUQILCC7dqeWoXBOEgsCPrjCN9Ko5SoAPZRpxfVSSC73X/1QZaCqfHskMKiva3VR9aJtKjgY+9jM+HQKPTo5RzcL8m1xwtTxWikEiKGR34h24a9J4zW5LhKaVwLmxw+bHBS7a+l5duekdqhS/RvM7JwSTBPSQwFFXVVYOg9Py/ddPMmmIWRxLrbyFnbpMl71xxJh8mPgigl/npZeSVafCo887N4Mf8XqVBYH+meBG5+dY7EjQA4xotTLCJ/oCoBRwzlhQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8986.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/W11Kra/olATpGpWddBEjkAtFl7XQIgmZ/bSScgherszQj8kKvXGzDjh9qe4?=
 =?us-ascii?Q?vXKFEQyDMJOK9VMWjdItDtldG+ObiiN0wCKT4YOyiPL0QFGqrpVqaEWnjPrz?=
 =?us-ascii?Q?yorugOgTYmzbK+XdjtORnJSoot0WXQLhVECJxloFHultl+IrYbn0MOhwkutn?=
 =?us-ascii?Q?jCVPInFrT/qKfZtGx6jIzo5ciyyo1TcNLzbjukZHiZAa2Z2HEdZemvPQMOJL?=
 =?us-ascii?Q?9xsIK1MJY2oIpPdCpE8j5KLlLeIKlp3GOSL6aSelqJ/5ypGMKtrnKqXSJB87?=
 =?us-ascii?Q?Uz4AF1Qds0lmf4+Ookkn8DZumx6LhG5DiakzJXhN2HscvEU7jGAOZrlEtyBH?=
 =?us-ascii?Q?53sz6/ljB8d9kikpemJmEKtFnV5hcSIQ0ZwyQ00pNll1rATU9K3+m6jxLsRl?=
 =?us-ascii?Q?1XEaz8M0MvPAtcnu8AEHO/wjDUZuiDAzulxieLgZGMrkY6XAZwI+dGYLhxJ2?=
 =?us-ascii?Q?QrAfGWG4v+5J+yCnxoNYOhJnkSgiLtJBwu7njAnJnpzQb84Fw8iWo0uDY39V?=
 =?us-ascii?Q?YfrA7mptsgsUO3qQComxELZnLYAEcxy1iVto96o/JxurL5Vrw7S8Pd9b2l0C?=
 =?us-ascii?Q?n8UIYYmgMuqkO5kCUQ+Nl6RuML9eBpMcec3ZG1Q4NDbxoMlAEPc8rFMjGmYO?=
 =?us-ascii?Q?2yKrxJice+PSG3OTYUhAzhywJJpAqw0MJi2U2p6ldxdhavu02F/dnGP5GbzC?=
 =?us-ascii?Q?b8ixcWYXdOFbkKQ/2e9MtJ8qz0m3V2gyp66dq+p2C/+GaanOstpVv1co6uFA?=
 =?us-ascii?Q?3kbadOXXXTGmIjP5xJtIcVSJrDl8f5GJ3pOrsikztPq4BRAuO9CIIIzBUQ0v?=
 =?us-ascii?Q?+agt1n/wOxk40D/biMS3kmupDn9FXffx2wCGUr+NXBbUVu2SX3gS9a0Asg4e?=
 =?us-ascii?Q?3cT7ZpSPCXMGoivN5gxsODqvCfRqzHL0Hz81tV0imn4D1KsoUIBaCjN4WceF?=
 =?us-ascii?Q?LXm3ft2aNU7XmJXyrjkCkiXPLzw3WOoaH7GrxKnI5h/e2bxPFtu3NtBmvNgq?=
 =?us-ascii?Q?wdq/WMSuvdih7VIVsUXH+XiSYnK+Nm0UyC6xt/mVOF06MtH/CQRuYyV90eGU?=
 =?us-ascii?Q?fRz/I5NYcUffaBAuBqtDM3+gRBzCtGaX/2iQRWEZgTl+1naFeedYzbhZd7PA?=
 =?us-ascii?Q?qPVbfS2MLEUwMQYbKFqjieGa05F9YZaveJMUbyDtlKVEW2R1qCT7CNhVEO7F?=
 =?us-ascii?Q?//AjnPmdygQ/HErbLyi8yIk0emVSnmAs4DrRFnnykqL03krDY85pOt14SKbl?=
 =?us-ascii?Q?8pEY9H+Xa0TD2my1QsPNMj4UpqFj6+euYd1TtQBrFmU9t2a9arp5YWwU+wGb?=
 =?us-ascii?Q?jfPszxcuSLFZ+BTWWGWfSPxDnv2EyDV7jZJOzVl4MRIaIqw2W2Y4ilIOzAN0?=
 =?us-ascii?Q?zZyA0ga8ZQNjvX7ftHkutAxylIKReaFkfFTqF4iAumSJASEisfetV+6aurcy?=
 =?us-ascii?Q?fF00vGYhRS7KdYVl7ZE8Zlf9RkVszzDrM8HBQsP+EYuchsoEcczMEdDlkvsw?=
 =?us-ascii?Q?Est0EZF9c2wkh9pLt1DsKRet/BfrCXYMXPEm+8R6BYNt3ZkjpX0+hKV5sinG?=
 =?us-ascii?Q?DCdfJOpviJvNWohG9ePumgqoOd3yHCoNhjMfLDgo0bE6IjZrwpSeaUPQrgFq?=
 =?us-ascii?Q?z/pKfF/wJTpnQl13hOuPhzhdQR9vl2KSK8O4D1see6vd/W8sLcHAo7RoWu36?=
 =?us-ascii?Q?2l1H+3GwSdHnRqMYNFPU8U7X7sy0CEgnn1iJ8CPvb4IzZ80U9C7WrBvckLtm?=
 =?us-ascii?Q?uDYTKfV2XbeyJP6A0FtVgYZkuSFk9Og=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jL++GpxRgk8sMMVf09GSkqcBIC/mp2gGdNH2xH6oOjFneUjdzLT+KTy7o8t9VheNIJah8XP+/hl9yZaK7g5YjO3lOkGK83gZiOg+smIenAr9WGma/vKrDQAYeOELqhMr+LLbGgBqIIZDB88vMKPeoUc8nX3CURx06Wihdy47+nmTaER+1om2rs8FWpEVNXB4avreT7W7OzyKNNZSEGtBvS8wlkdiAYLrNzidbBQ4mJgKzHOSfULNXbdnWIrVk62FaSHJ0yX+sQ9iB59cZD8pywirWX5iiNXr+JRJvqfwVFzXkOxjfHAcvD5mrF1O1m+Jym9XtDiyvwrY9mXk7xpDCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3165caa4-1733-4878-2226-08df0dab1e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:14:30.9376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXehZqGNR0QRbqnvQ0chsI3J8SpnrIaH2vvxvQn0EVOpdNEBUkeW7OiAZ9+RQHJbU9QLEh9VA8L1QCWYLgtTwVNUc2WUFvVV3OklTnTeqaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
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
> From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> Sent: Friday, September 4, 2026 11:18 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory
> leak in interrupt request
>=20
> The kasprintf() call in idpf_vport_intr_req_irq() can return NULL on
> memory pressure, but the result is passed directly to request_irq()
> without a NULL check. The IRQ core then stores this pointer as
> action->name and dereferences it later from /proc/interrupts and
> procfs, leading to a NULL pointer dereference.
>=20
> Add a NULL check after kasprintf() and bail out with -ENOMEM.
>=20
> Additionally, when request_irq() fails, request_threaded_irq() frees
> the irqaction itself without taking ownership of the name string, so
> the caller-allocated name is leaked. Free it on the error path only.
> On the success path the name is owned by the irq action and released
> later via kfree(free_irq(...)) in the cleanup loop, so it must not be
> freed here.
>=20
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Cc: stable@vger.kernel.org # 6.7
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 24b91be25676..86dedf5c1c09 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -4063,12 +4063,17 @@ static int idpf_vport_intr_req_irq(struct
> idpf_vport *vport,
>=20
>  		name =3D kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name,
> if_name,
>  				 vec_name, vector);
> +		if (!name) {
> +			err =3D -ENOMEM;
> +			goto free_q_irqs;
> +		}
>=20
>  		err =3D request_irq(irq_num, idpf_vport_intr_clean_queues,
> 0,
>  				  name, q_vector);
>  		if (err) {
>  			netdev_err(vport->netdev,
>  				   "Request_irq failed, error: %d\n", err);
> +			kfree(name);
>  			goto free_q_irqs;
>  		}
>=20
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
