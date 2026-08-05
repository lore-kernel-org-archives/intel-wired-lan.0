Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F3FC55174
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 14:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 060DE60670;
	Wed,  5 Aug 2026 14:39:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5h4XcBGZFJ9; Wed,  5 Aug 2026 14:39:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F94960674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785940777;
	bh=u2VuI/1zLrPbtXgatuvN79OTRUUVGC97lBC34lB20x8=;
	h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3ZrmPqF/TAVAbeu7r6RBZS+60TdjKxZpiMi+/labUivZze27Zv1BUxXJ9A/M8Fh2L
	 ge2F5xifFIrG3iIjYTrWvx3Ommh/hmuT7krWRGwQqsLC8EuwIEyA2mAZH1hvQuPvgs
	 o8zgM8zOO7YVpsmz91vH0xTWF+ekvCnjqeW6/p0vy0z6nOvXmmj8isKPdtoj5eN1to
	 ypbGbbe1ylFPab4Ta5+kI6eS0CNrmDx0z6bf5INl5kbnivQE3PtljhPbXE9Ve49W+6
	 xLHCmrKfTnZazfKiYRPT6Ysp28NDbsuAiLCYOe4oZ09LT97S/Hk2jfNcn3IwVHSlLz
	 cxmRY/TIHQdVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F94960674;
	Wed,  5 Aug 2026 14:39:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A35F02B6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 14:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80D0F40535
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 14:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Vxt432_rQsE for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 14:39:34 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 59DDF40521
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59DDF40521
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59DDF40521
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 14:39:33 +0000 (UTC)
X-CSE-ConnectionGUID: fqIt85j1SkOboditVu5/Yw==
X-CSE-MsgGUID: GrIGeqF0QZS5rn3RMEwSzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="97164183"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="97164183"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 07:39:24 -0700
X-CSE-ConnectionGUID: RvTT8oO3SLmJb3XKLz7lkw==
X-CSE-MsgGUID: bFrVWQByRrqbcVozxGspeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="266052888"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 07:39:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 07:39:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 07:39:23 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 07:39:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cI2CuE/bvwtlRkekG7OsJ1mhwagxckVKNl+WRbnYit2ZHgr5BHh7AhCj0JCDyVs7drl+XroLi9SOSPxZXoZD5ovSmCu9EyG4b5LqR9Ma+R4jDGwOScNS1Q/k/vcc1CgPzvo0kVq/ftATf0ub374VFyGBVYL/T+o/sHE6nqySKK8FtcpI6PV4pjdEa/Bu0C4bei22gAOWH9WyLqN5TzGc+mKX36o0I+hlifNLthIZt1Quthi59NoDbUwouk/uIEyaqSSMkcxgwBKuO93FOaafQyHknbvS/3jPmmlwScNmZycGm7RRUOyvXJgK6jlMPeYeitToq17rExkWLAWQJWssFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2VuI/1zLrPbtXgatuvN79OTRUUVGC97lBC34lB20x8=;
 b=U8qI4cy+FfWUymhmaueGDqOOXRJ1odGRXFIF3a2xTCRXDj+WDjLARMjEI0FBCn0v2P8J/j4QncRmLiar7I+BYG2xku+9y1x0VIw0EHpblV8SkwW/0WYpinLOSbEvYVrD8j8fPxlEPhqxGCeqClxEXvUTIrzOBiMiEBTB8DSXQ8ge8NYNfO5286ATL4xAMqw7sPs7+lUguX2dR/bEXvF60uNeQgxT29mNXbuT1GRt6Tn0E1MoqgFLApFHH8Oe5tlpB8c0UMIk0AUrp8MYwV1FRHjwc5L9j3AZOIqYRsGowiKGKgpdZnlIL3HAcGPL07YySxuzIiROLggmoZSUi2fupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by DSWPR11MB9762.namprd11.prod.outlook.com
 (2603:10b6:8:354::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 14:39:16 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f%6]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 14:39:16 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Hay, Joshua A"
 <joshua.a.hay@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Willem de Bruijn <willemb@google.com>
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] idpf: add missing
 cpu_to_le32 in idpf_tx_splitq_build_flow_desc
Thread-Index: AQHdI4wedhcsVp5o/kayiXwJWTYEb7aPiTDg
Date: Wed, 5 Aug 2026 14:39:16 +0000
Message-ID: <DS4PPF7551E6552C4C8BEA399E3CCCF983DE5D32@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|DSWPR11MB9762:EE_
x-ms-office365-filtering-correlation-id: 048e51e3-4b37-489f-4cb2-08def2ff537e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: yNPYaaOi8FL8KuIcOKaUkWhLjlnOEFgtBxSSKjZSrh327ThacuOSkeB2EpO3UhN/0qPFmt0mtMu8CsAASvNLmHWzmX6H2iwuV5F939dcmUV/pNEYTehcrqnITdUkDX1FHqrvXDUHYGwW1V1Nxc05IFqXO+9KLW6V3iRqFMVCShA/VahXQiJ5snzfEqJowENQ/cWlgApPmu1HT6VSRNPmMFsk8SNveymIfVb07L3UKnghpdyQa3D6MzbJurjdpDFTtOaUnSBSvnxGzyLcWd31HUpO85w1KjjS1emV4jiUINv9v0btrCKv5xgjCJXZ8DFllJpDtdiY8dp9tm94bBM+tqw2rTpNgEZnQQMjTg1cgGg4ilUjd1RKAJX3Pcu+lGMTH+DvS2PI+DcuF8hxG+dU1JRtQRx6dGfHClslJOmYMWqqsN6C5RlnblhoCu1wJU7F6qScjHZkTz9ZmQvz0z1HLRcUkWCc5oXYQR9HGrCQl4qApFFDgW9F27949HED47J0+BstkHI3mosmyxq6XhOXYMa55XQJTsVcYK9SnNfL4aP64m079vaOI6DYVAHJgSXYqbFhPsZg7GTHQvnxaJJbnFd6R2E3A5fHgNfXI1nyb27NjmKRw33GePOsUJRADY1kj4u6PBlV4rK22kaCUhY+wDyJUy8nmwKu33yOaIWBMp8VmulWQM+nnMoRTK/fltuXbS3uwMU+P1jW9oPrBCnlUurz2Mu8avndqrwPnaiUwYw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF7551E6552.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eTZXIobeddEMGVwM+iG93yEvvZU0+EXR659DCA9+5n9lJg7wR2Tc2ucCovjU?=
 =?us-ascii?Q?1HdslkbeEt6ZfIuIwhaVEF66k5JcyBiyfVkhcLoTg3fRJ3DKCAjEJQQyrmiC?=
 =?us-ascii?Q?7383s8mBfnAOq1dMuOdNjvLTMw6slwE5V0FTh8iEUS/5q8J2a8g8/aE0j+lU?=
 =?us-ascii?Q?fZdQsiCjwLulqj3OlqYSsPILZGmevnjKuCgPvbIKk3QHk9r+uF2llwjDDeVR?=
 =?us-ascii?Q?sD+Jqusr4QIk67nmtbUTsx6rOTOduNmxaYwJbLTz7CpFNZEZtcyoQOJR+U9Y?=
 =?us-ascii?Q?PVhz+iembFZpUDw4YshpB/tukVcb5XTCjhA9XlB7CxxzE34tOYCcVkmBnSX0?=
 =?us-ascii?Q?248EZ8Nz6op3nhVJm+JkkaVufBGtQ8IKnSTaoNE0Ire43OTHP5SxELap2kUW?=
 =?us-ascii?Q?Qc1SLvJ4l0RJtQXsndq+pDWR5GH4WDELbHleGgBTB41e4N8V3+J0gJ+gOrk4?=
 =?us-ascii?Q?tY/PfQ10HWMgfAK8G1v4UJ+16vXprDgztAca0iDYSZ0iJon80Jzdcoj6IXK5?=
 =?us-ascii?Q?aAkCHvt+yuoY5C9oQ2eOVEh6lN0oSz6gnM/Rk1fTqmDm4wQDxRVmk62DgUP2?=
 =?us-ascii?Q?Ps9zI+mxstwNKpNT2sByhsBeKerkr72Ja5U8OBpSFFwV0B9/P+sQLEyiCMfE?=
 =?us-ascii?Q?X2GLSSHfdeP4GhVu7JtbGzch5gY5fLNbxJtQh192LWK0WnOd3+41ouzuXlJq?=
 =?us-ascii?Q?AjvNdZphQY2C/WaXp9Cc/H3YvusYLKn1vFWptWJGhlNOC4//I/q8IEwJYeI3?=
 =?us-ascii?Q?mC1RdUeXXmgP2gB4Hzvw0yJvWuwKedMeNZhthB7WmQN3vZ9UGaS0gBJlp2WU?=
 =?us-ascii?Q?aOnje9eAYH8uHbhzZEr8dFneMtg0duVolic8l86J/Tck/YSvu+0Ct0paoQxO?=
 =?us-ascii?Q?m7xULsmXuvr2/JX/lYC/ehzhaD4KHJCpiwkwBdNRYVd77iqu2+losyOBW5TK?=
 =?us-ascii?Q?hQc2a8Gf+e/v+CcdZ0SUpyCkmzanckjL8K1+lvz+tAXojns+TQGt2/n299B7?=
 =?us-ascii?Q?pbWHEn3SrGS3JwrQFX/4xsduX5j7WPh4ABbJVdyhPRr6iZL+3k6v3hySHej9?=
 =?us-ascii?Q?pS3aXj31amGRwnUx48hktlbFq8MhwJiLT+4VzFEjTo23/blXbyCSQrrMVT40?=
 =?us-ascii?Q?b9EF0dYcjw4bsf9mgS1GMWh3moz6cRetgy0dbLpLDmcOFu9MxUDE0fyQmZrb?=
 =?us-ascii?Q?4B6v1Yja32quVJXjM7tCz9+X8xSinB+f8xyaJPJqBQ9zfCv8/I+y4eJBBDFp?=
 =?us-ascii?Q?CbzYfgUKq+YI1ch0W55E/PN/QnpslBNMo+zOrcWUFjfvawNJ4fhavyQr7tDh?=
 =?us-ascii?Q?OcWgUUVmr46D9Jb6LV067pQxYg9YwWbe10Kb54asOqfgF2q6xFWhXlIvxrL/?=
 =?us-ascii?Q?TJFs8G5kGlO21xJXNpdhTK+SpCiWhG/dOyEeEsw9Cx19SRWXhnHo6VwdPW9f?=
 =?us-ascii?Q?sn94ddUEnZGjOJwll7a/24MxBiIv3a23qzD3kgLwLqnowxtpREzGUL0Egr0k?=
 =?us-ascii?Q?UVVMNPnlG8B2BmwwZVkQV5QjDqzck3E6fCMEsIdMq7aX6nKp2kU/bfvK/uJJ?=
 =?us-ascii?Q?rweSWedMWwVSRx0I3UpI9A7YomN2XF75C0zN8TR9bRJoDh2Bxni2b01nJuL8?=
 =?us-ascii?Q?dIZ8AMYo0+TFlxBeQr/GV8OO1mJz1hCEU5mL3lwdVeSMk0CYPERVJw0OAmYz?=
 =?us-ascii?Q?pbAzVLxhVHwbuGdXCt8QGv46Pw9FTMeYQAH2tcrTSWEHmaTF8aNDguy3FbEF?=
 =?us-ascii?Q?N5Kn7t6wNmZG55q3VNSS6iB51BT822U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U5RileMtzCSuIcmRKVi6qSeNi/MA01XIq3Xib6UruCNTydN0PfsF9N3Yls0lgUnUXBt/UgIgXZ3tQS96TWYuRx0ggvhNEN+DLVwHRMD7gZ37bqJdVjYYjW+PqMc5AcfjWNXo0bD1zs1fW2M6GWjkZ0C4cx6ejZbM0iGvZKKVztn5R2ndO7r8Ip1V33MyVKE2DbYdN+/sfxBFZ6/Q8NMR58BKXC0d0/BA93iquJlWBq4JhPE+qcEyA4FgLOYTWtR6Hlh1an2Ad8zHYcULDb079fyIoc1sfSQI5JtWqoscKGiHXAeHUPCZUOidhFsD1Z8i0a0Tu8TvV8PG6uHc7q2X8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048e51e3-4b37-489f-4cb2-08def2ff537e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 14:39:16.4256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEETd00baOnLAPXUIdSUQOE24IWmdWZfDaXosWocjNWu5rNkjkdOdUPdp2MTpt2AQ5HlkR5vpI39cCfhhDjm2Awp0e06QblDmKcxlh1Dk7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9762
X-OriginatorOrg: intel.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785940774; x=1817476774;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0LhklbFaqikQKMY02jECDErA9+5Bbb2MoZuJCKKcbqM=;
 b=lsiAan/actJ0W1VSZVo25onkXQz21FAoh8YguSF+M5j3yqsYaK8msgeO
 0h7fbOiNkYsaaPcl5nvWvVbhinJkX8Tjmcy67MFi/PtqtALnuTisMSf/m
 F1xS6lgE90Z/4Q/bgkYDGT9Xs69uaPAZrxUY8QTi+98UXExjNQ6tFTxeb
 TIQHI4seB4DEFuFCxEeX6ixNQV4cImmxCfSPr1VQqkaG2Xc75dJtUppqX
 7SPm1kyeX+8PGy8QzW/SWXWln9Vmud6yiVwKPoKsnRpp2v6sl0y9dYX2f
 y7RCA0VT0uzTiNXNp4OqhUGzJle4BgO6RiJZcHKPYdiou5Q/Kk58ut1SR
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lsiAan/a
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: add missing
 cpu_to_le32 in idpf_tx_splitq_build_flow_desc
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Willem de Bruijn
> Sent: Monday, August 3, 2026 11:06 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Hay, Joshua A <joshua.a.hay@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Willem de Bruijn
> <willemb@google.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] idpf: add missing
> cpu_to_le32 in idpf_tx_splitq_build_flow_desc
>=20
> From: Willem de Bruijn <willemb@google.com>
>=20
> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
> field in a single operation.
>=20
> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
> __le32 to ensure the fields are written correctly also on big endian
> platforms.
>=20
> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>=20
> ---
>=20
> Changes
>   v1 -> v2
>   - add Fixes tag, Tony's Reviewed-by and Cc: intel-wired-
> lan@lists.osuosl.org
>   v1: https://lore.kernel.org/netdev/20260731103137.4000876-1-
> willemdebruijn.kernel@gmail.com/
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index c724d429a7aa..91ca75e45463 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union
> idpf_tx_flex_desc *desc,
>  				    struct idpf_tx_splitq_params *params,
>  				    u16 td_cmd, u16 size)
>  {
> -	*(u32 *)&desc->flow.qw1.cmd_dtype =3D (u8)(params->dtype |
> td_cmd);
> +	*(__le32 *)&desc->flow.qw1.cmd_dtype =3D cpu_to_le32((u8)(params-
> >dtype
> +| td_cmd));
>  	desc->flow.qw1.rxr_bufsize =3D cpu_to_le16((u16)size);
>  	desc->flow.qw1.compl_tag =3D cpu_to_le16(params->compl_tag);  }
> --
> 2.55.0.629.g250fe7f194-goog


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
