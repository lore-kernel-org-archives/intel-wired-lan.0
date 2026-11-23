Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D63606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=rHlPzZRB;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Bt4mUF79
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD0C2405AE;
	Mon, 23 Nov 2026 20:50:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HAXK_KiwR2nm; Mon, 23 Nov 2026 20:50:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E68D406EF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795467049;
	b=TFdxa55F76OMVQKLpIeYW88NVMDvTMYWOMzAIexpqo8iUPOiGvuls5VHv6wujURaQtTB
	 LeDXVCkLdLkwFFrlngEG96D3AfX8wJpuPtyx5jL1wH8t06MTFze8V/rROZ9ap5Qh8enNa
	 vQ5GxiWGh8W4noQSdos34ki1ZdwnSSxNMpFKnJ9LBFwDWaKYtXIZmTnUMhmTFnZOEk0iN
	 ZmxVFZlVwUTOLpZDBJ6Ohq6c99NxCzLeLHhco7zYMVCV/aj5ppUDMK19qH29nBmfaTGWp
	 GXQ/rGd33+R8AlJL267QhzyMZD1jydNlHC/T5amoCS68htIne/+jefv1lVqaUKT/L4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795467049;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rtg1QwlxUlqKdWFFkOLdbOG6qOLObjBGzDminPCVQ78=;
	b=sINIn3Sp6COkdq7SHKrd654vzj4J7TlVOtOBCBoY/px8A63daMwjl3o3V3lii57+yysj
	 TmgALs+kJU60/0/FDQ92Yw9Jxx3xrAm7gwEmHKZmi+SWusRwZaYz/HKlAHo9mWFeSxLek
	 fu6QeKpDx9AogqyscDXjyqfPMHWdLOtkOnQG6lnTQvkcraQD945BLqdV1GYo+qx8bqzNA
	 WDkPkUaaRr7hrxXYyl89ZN+S0cKsFHbOafQtk8EF+srWI753/aLzeinNDhqPNRauXpmfd
	 0QKjSeQnPnfNM0RY8rs52wq79LMyqFUnBThCbn4JzHV1SgRqURM5+qdEm3Gfa3gQF6w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Bt4mUF79;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795467049;
	bh=rtg1QwlxUlqKdWFFkOLdbOG6qOLObjBGzDminPCVQ78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rHlPzZRBGDnfId48+e2Z90ahZ80loiD+VW+lZIhOI/l7OsaOrmmlfvL68Wj0WYlSK
	 Tr2+OK2ixOFQ4zdUGZI3szF8PGoNElX/LWSR61S/xYsZTx/2PBrTC/Dx+Y+ZcTgOEi
	 ubzgtjRm5Oz+9/NAbyzKtypwJXO/ZDNn+6sLQ2xGWlmwmn90QmQ+YOiqr+LfIs0RvI
	 pA96Zhqankc6Dy7ZlZPjbKL4AY1RrrI9aSnjEx0tVqta7vNVTbvdoDaiTJYKqTxVG6
	 SXwPRyMu47RH76lSpm5R2jkGx5MLksAG4uNQ1X21IXjhb653Rm5PJS00dq8zCLfVKp
	 RmHIqVseQqg9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E68D406EF;
	Mon, 23 Nov 2026 20:50:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4EC4311
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB3C6406EF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XC7ZPUcZ_nl7 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 20:50:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D13F8405AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=Bt4mUF79
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D13F8405AE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 20:50:46 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4a85c656c58so2350682fac.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795467045; x=1796071845;
 darn=lists.osuosl.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rtg1QwlxUlqKdWFFkOLdbOG6qOLObjBGzDminPCVQ78=;
 b=Bt4mUF795jtef7tyj6wTszJ8Tvwc2NmdcEHpGt8Vn/48paRHyUbmZtgFPedklKwBrh
 6ITr4T+LoTUriKXMbRWeW5LK0xvYp8m895dezYJ6cPADG1kamZDTKNr3LiaHbQ2k+B7Q
 OEYpO4utKYyAh3jBFJUO4WB42WlBBxapTrnsri8JqX3K6xRy/k8n1xl5vm8cmJFTfBB/
 CB32zQ0/WvmR3+D23MrsFlB7T9sMPdHQ26oU9akeTtCynIGyXPJ34S7YUJ5SVhYmTmts
 YXA9BlnATJH299fjNXSZ+VF6kzUN+0Tveq2EieLA8poRKC+dNCYXTteRlaQIj6bw76Uk
 iU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795467045; x=1796071845;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rtg1QwlxUlqKdWFFkOLdbOG6qOLObjBGzDminPCVQ78=;
 b=nVeHnvCPT3EJgngBeRyB79h+gHlCGOn+CW1otPnNBGgvbfaqE2SUOpounOMY+JAltH
 QTgGjJ4/r3cWRHmXBQ4BRvXQ53hPShtJH04kVsOlae6YXQ/1ACxSi8p1U9UeZgSDHimo
 EFCm9zXtSNXwsB0RCnoMS1YwamHQ5T5r75UN/3Vspb44Vo6j0ZVElNFCPEfDJlqyUBi2
 97gN6qHxjtEUyR2SzGuwZPuf8k24AeEfFGmzAG6ZPVEg/6KV2nVkovST3VXj4qbNxQCq
 QUlazEgMhLCg3A7wQn4WIYCIId61RQV9HvwQjiRkKu3Gj1b3Lb6CXe4+hgsUvtFoJ+uM
 cAnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGmR70Oi7yHf4Ix39qa8R4zRA8k8G1M8P9cCyCquhsNP62a7qmg6NnktHbEaRJT26aI9Ww7DbrmSskUWpSWvPs=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9bc2B+uYHmkZ/KLIwZuIH5Uhp1CDl6d6A0DJ8+kUG1ffROq6wx
 CXgK0yh9+iTxRJ5ypxttSJqWCO7uL1RomWUkreMeyS9sKVNAohaQqhm6LaAWcJsL6JLQJA8pwbI
 fXrNbwLmHfNd8bEJg47jFWUyn+PIks2xEtUKEg8al9w==
X-Gm-Gg: AZFdTZeEX7jFtofUX9YA8b0KJCd1LpXxpMTdJLdqH8ckJR2wJBulaZUX1EhMZWEcNnG
 1zecA2lbNMYdM+DpUA1zq2EVwehp+ISioRYtXnt2hSw9eavSj2SOCBgCR/E3AhEWMMaIH2aLn82
 S6FNCMhHKPptQCV8lGc5b/MPoQL+ubHmXBXIWdkE1hHDU0vLdZmbIl/xxGJFsjsJCda+QXDn0yV
 rVqSUM1s7nGb2upcihYDNtfp585L5m0ZM89lVX5IFGCfk6HrVE3L7BFnpYOxBpNxaQM70kACShZ
 3TcTJCK0xZCd/r004AZDcKVHZ/BPqb722dgrsVgZbBFwERsc/Kh+S6V5xfOenuzse9F7UJXR6o+
 0MGYW4EHDKTn/NRP21wkTD7V1ufSWWqzvbWsdgdP9Sftl4TrAaED5smHd+nodXW4MBLCOX7JYu4
 pjDyi88ssqhA==
X-Received: by 2002:a05:6871:5214:b0:494:9899:dc19 with SMTP id
 586e51a60fabf-4bc858fe4e1mr11416644fac.57.1795467045382; Mon, 23 Nov 2026
 12:50:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <awSF9MseWZF7GXoT@boxer>
In-Reply-To: <awSF9MseWZF7GXoT@boxer>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 23 Nov 2026 20:50:33 +0000
X-Gm-Features: Aa3M54qknv-LC3GqPC4I5eLThmOD4Cwkbfje5p8LrDaQRMJr2NeCERG3yi0ic8o
Message-ID: <CAG4wq-fmKUPCpvu_m8Zw-9X23QW3k2F3ucjSQdDvWQTpjKNYaA@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Alice Michael <alice.michael@intel.com>, 
 Eric Joyner <eric.joyner@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 07:29:08PM +0100, Maciej Fijalkowski wrote:
> Anyone else besides mlx5 behaving this way?

Thanks for the ack, Maciej.

From roughly analyzing the code, no. At least fbnic, gve, idpf, enetc,
ionic, mlx4 and nfp report CHECKSUM_COMPLETE with an XDP program
attached too, and I am not sure this list is exhaustive. So I am
wondering whether we should enforce it for all drivers, with the
drv-net selftest I mentioned.

The existing tests in xdp.py (test_xdp_native_adjst_head_* and
test_xdp_native_adjst_tail_*) already change the frame and return
XDP_PASS, but they only check the payload. A stale CHECKSUM_COMPLETE is
only reported silently as "hw csum failure" in dmesg, so they still
pass. Could you check the dmesg of the ice-E830-XXV2 NIPA runner?
