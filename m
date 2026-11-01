Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ACA606A326
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=PFI3eb5F;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=jGZbdmzX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8BAA6060A;
	Mon,  2 Nov 2026 22:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fe6fPwuUOucG; Mon,  2 Nov 2026 22:32:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F7B0606E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658775;
	b=NN/X29gbdqmKEoxsZXbl+ZMIZ3wbDGyTCeYPegQztQWCASOSx5VTTl63MAFqTYWYnuZh
	 HTMnXOYCEO7TLEIH3598JNOdHIXPL8XBcJh8R8UOpPXLIST63p7FOM07KfvXOE9eiAQiQ
	 K80zIOMBWWYfepjNq2GHhjIFtVyPcMOWBsjxNdv22Px8fP1yIO31YJI9CJ6fWn7zCytaN
	 c+MRDmugLCfa1rgsOT9cQ91nXp7jvKlGXJTlg9FHeyvkzcNHBhbWbHI/TOvPnd4iiDeMZ
	 JQw9jbfA6x4Zy4PWNeFFEEkkMk7stmikax/4WsjoHuLxEk1xy4VfdYKUtdk3YXlX8kA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658775;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=POsgNR6eNljnTfEYpS6eyYrflzHZ116+kioTHKvudNs=;
	b=s+r3+etDZDDGDgZzfUZVEU847YOfcm1wwARzqJ6/9iTo5FZQvhgP3qut+jEbYKW6JEDX
	 pD8/a8yr32WuqCYw5Df84PSF6jMtxL86xLpVedQihUB2MCXT+6BHT3EJRdnkwMJL91bf0
	 VwdeIJ0vvxjfFyosOYliVse+KkeqgX6eDFAYo3pSY/GAHUnz/0ckkWupwVKg7rhg7pD2L
	 GsH8p9W/Sl7Vd+vLK+W099RqPzEeOKWWAvzw7MD3zAHWVGyWGnC+YwMEZgW4aArr+AES6
	 kIcXYxR0m3t03HDlTEoWrxwYlkr1xar0iZYHuU+Z8gI6dng4jliHQO5FgqMPFcWNXHA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658775;
	bh=POsgNR6eNljnTfEYpS6eyYrflzHZ116+kioTHKvudNs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PFI3eb5FALtKEZhrSqUp1x88jnSPVpdtw83+JhlDG+buPkM3r3HjhKBOmSn2GMOmn
	 IlbpqCLyctBmq5pQm9RmwZ4Xcgz9LnlbJjNPSp3WznRiGQp7fxz34y+FnPfwy+qELt
	 0OCS8e1zJde1uqCgMMjC75WKkXVOfiBRVu8fxOWszDf+14W5ETIrJdYA+uun0crMGP
	 6Kl55jqTPLMHz8fvNRxrmaMLfljvFbwswaVu3V1q/oXyIEkiUxcsnTCrZ1ULVgI3fT
	 Nlr6d2ALzNtsGylB5a2PdygoHf/HxPbf7jeV8vtmTkBB3Z6j4qrbw0vYmCA6T+UNB5
	 ycrJzMPlgLYFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F7B0606E9;
	Mon,  2 Nov 2026 22:32:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 33B1F3A7
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 13:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19B8980DCE
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 13:09:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q7R1I0SUdMKu for <intel-wired-lan@lists.osuosl.org>;
 Sun,  1 Nov 2026 13:09:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1ABBE80D1F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793538573;
 b=rE4SwoSZMdkZjQBd+dQmFMIuCskqzIFfuo5jyAzMZ2CIYjQ16hLKT4mqIVb2iOcrd2WX
 hrM2UY56pRVSFCJstTeDuLdouMEv8Br3SPXnxRPxRRQHtfxVToxRAsXM/RWppYhBL63uq
 e98/8v4eUopu/PcvqcwnSSWLtiKzTSWwhGjBzHlr/ktKdiuyUqlS1pPgUlVloC6zceswZ
 2z8OjhkEEdXBj2JA/4Edzucnnq6gL97cX4v9P1tf1VP+aUvgEuSoB+2KqKjOth5Uxkw3n
 DDj/i/mFJDp8lPcl74GMDGpCrtIss6wrOqIrcfBza9cFDMbd4tX9uA5VIRkOZlQRLGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793538573;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version;
 bh=POsgNR6eNljnTfEYpS6eyYrflzHZ116+kioTHKvudNs=;
 b=Eonp3icVaWeQwLU2nvO1Qy0j94sDnKiBlJHI9CE0c+mOojwsnGH0/73i/8uO8XQRyiia
 23f93R9FU7pc0LF3JTISRU4oPSiyrA8QSYS8jVdjejZZOFRF9VKEXK9BqRHRUzKedulGe
 EnivRZCOkY/Mie5bN9ZxqoUgUuoeYqRK1NVpf0qZfGsETMGM4F1XHAkw1A/JNw/Iw68Zg
 VcR5pjcGzFKEGuD98N+ugfsvcU3cqQXYDD2YDef259/UQ5vRiWXAO8i6kMW5WHqu1RHS4
 4zF8ZYF8fGpMhc+MzMftJiRhSB9KGO+poQDUv6ptTsE8JlM9IwyWwF9TiKkixWB+QSg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=marvell.com;
 dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=jGZbdmzX; 
 arc=none smtp.remote-ip=67.231.148.174
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.148.174;
 helo=mx0a-0016f401.pphosted.com;
 envelope-from=prvs=27654e60cf=nshettyj@marvell.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=marvell.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=jGZbdmzX
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1ABBE80D1F
 for <intel-wired-lan@lists.osuosl.org>; Sun,  1 Nov 2026 13:09:31 +0000 (UTC)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1CTBgR2419686; Sun, 1 Nov 2026 05:08:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pfpt0220; bh=POsgNR6eNljnTfEYpS6eyYrfl
 zHZ116+kioTHKvudNs=; b=jGZbdmzX08kECHd275c1FrgBm/rHizlZK6z3DGlMs
 prXixOYl4te5j+sDBjwiJzvo9SjwKoCFOOkwY9sfCyjHdYcwwwLeDcTjwkZhd4jM
 ++R+ChYvplnIu8JQxRkObni82oH4uBT4IIYWV8Y0rywEyDE8hoiI79Na7kA2cN6G
 zJq4Asqw3VN1WwyGG0dZwohqBNNKrFdtVnOLSSmpYmLWjyjTppnbZ0bU4k+XUrKK
 pztCsAZbWkvYKhcGnwx1H+F4sCGncVzW2Z692akCCtTFtbyus6PrRwMTmb0Bh7gI
 d3AqrjOE3DixEpWfFsyHFvv50G/sHr80Gb2166ArjWR/w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hp5fd020x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Nov 2026 05:08:57 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 1 Nov 2026 05:08:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 1 Nov 2026 05:08:55 -0800
Received: from nitinsj-apex-workbox (unknown [10.28.40.177])
 by maili.marvell.com (Postfix) with SMTP id 4C4C93F7075;
 Sun,  1 Nov 2026 05:08:48 -0800 (PST)
Date: Sun, 1 Nov 2026 18:38:53 +0530
From: Nitin Shetty J <nshettyj@marvell.com>
To: Marcin Knap <marcin.knap@vecima.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "Simon Horman" <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, <jtollet@cisco.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Joshua Washington
 <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 "Sunil Goutham" <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Message-ID: <auc55SPJVtJNhpNn@nitinsj-apex-workbox>
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA1MiBTYWx0ZWRfXzkctue3SCKIW
 7Cn0Jhc1bFPBR88rY6odabuL0zLvhgmEYMrgFITbXg+WGkw3beESsB7hrOxqC9rw1Bq49Ilb+0X
 sZGKlD8WNnSS6cbySPpl0mern8MBVxjs+CHFP0FDop7KTMdd0IYPsv9eBxZxIyecXKQr9X3VWSv
 JJ5/xthcQHwMytKoNdu1Sm4LGjU9GEJsjPN7Ltpzk+3epb3sRBsFKhZKLq/KKYQqXck6P80xTpP
 Bv+DvoT7CJxfVltpKHE9coVZMc4hKXtxBucRGiDr6oQzplrZeBZD0zIkLBSJRlzqpYM/8JccN1c
 2YMKNJ/JCwYlYLvashe0KHt+9LP7BmLVDCMgoXGFMuxG0PSXjEupLA5tEwyxI+M4VimO1dK772x
 32Zdx/vZ77OsW2aPaFL+gB7FsCVd0cGBltPsEkwRLb52CSTgI7EcaykyklzviPRGgi6IZAdAaTt
 zJG2bvJvbM3B485IlHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA1MiBTYWx0ZWRfX8RCS6d08dSYW
 //vMIMPZS+4FF8csNIIXxJCQdYCUVYaI1fKKWXFhO3FLcwnvKCYbHWsr+dDME5UM8r4ya1VVlM5
 UIFJIc9C6idBG3y7w/se0FmWoFoa1e8=
X-Proofpoint-GUID: uFRGXjxDV5PgyjAoYMCm7Ia5Fkyxo_3i
X-Authority-Analysis: v=2.4 cv=bszZl0ai c=1 sm=1 tr=0 ts=6ae739e9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=eRKzQBkOje3ih_7c:21 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22
 a=VbtP2V50AAAA:8 a=M5GUcnROAAAA:8 a=HB_4VZhdTIFFo8uudmsA:9 a=CjuIK1q_8ugA:10
 a=khSs6UnhJ5OSbz3Ji1I1:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Qh0BGDiy-lhdOgvBjkqA:22
X-Proofpoint-ORIG-GUID: uFRGXjxDV5PgyjAoYMCm7Ia5Fkyxo_3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_04,2026-10-21_02,2025-10-01_01
X-Mailman-Approved-At: Mon, 02 Nov 2026 22:32:42 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-30 at 13:44:17, Marcin Knap (marcin.knap@vecima.com) wrote:
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 90af9b9044aa..6d10c132f61c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1555,7 +1555,8 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  				*need_xdp_flush = true;
>  				return true;
>  			}
> -			return false;
> +			xsk_buff_free(xsk_buff);
> +			return true;
>  		}
>  
>  		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);

the Octeontx2 changes look good.Thanks.

Reviewed-by: Nitin Shetty J <nshettyj@marvell.com>
