Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD599606A31A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UwP1s9ff;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoX0zDV3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B61D840959;
	Fri, 23 Oct 2026 14:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bUaQJ6ZMtXea; Fri, 23 Oct 2026 14:16:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37D18408D3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792765000;
	b=d1JjEK/y3ffAD1utFNo3S5LK52jI/ni9Vya7ARt+Tc8KGzqIaO8kTCK4xe0wdQoBV/W4
	 c97lWYC10o1rrMJ2Cb399G79vZ4zyvSmbQRhg1P8fG5ZPYK9O/nVioz+Lfe6VHtZGwjel
	 jB8t9AXgN7NqDyK1DwgGRPbFfFdWL+EguDEMa/0t+4godH8aw1wHT3ksJi+YdpgTt61cg
	 OXudiUBvljcxpazw9+a9I2o3dkpGinRRdI32mb0UOe1YYLh3NMxqibjIiH8TnEOFwdhzx
	 AlXnJdNMJIPrRFMkrlP8W/V5gncLFcry5qCaoKz8OhpD+JaSxFLQls5e7oV6Z+T+TqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792765000;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=qPwGFH655HVitk1N8V3TpAOkqIauB/kpHMTEznbg1bnVxvUtjtvwxuloB5PxyMwew2ZK
	 YWHqHZqPHeQ8btpxaO/PU0zOYGSREJ8Em+C+1/tdlXoszBCDKEx5w1+HZPTM7+p3c834n
	 7qonDp819PJMlPH1vLXOczA1YWyndpqNTI/pqb6vwBo/yEF25chQKEojaQqVAvZTGDyaR
	 0b5st5+48riJie1hkD3KDwEMVNorHpADYz/qFAcr3i0q2ntfVMod02lmiJLPAUd/RrzgE
	 NB7Qq5olxdZB7OUnh/BtqnmAjdjOZLtZSegiOAM82d5f1nJkUj14u8yG2fr2HlHfjwA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792765000;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UwP1s9ffT99k6JgfojciOzNXEDvuIlgFawrDda5FEhkJXl0f8lCv8DwuFrTDagsMd
	 29S1OJ8kfGWQOAlTK7YHFTT14Tu2ILylYDKhTNQ8CsgSZLC3qQPDvbWDwcHLLecgGj
	 UY/3XI2QJht+DvTVHdpdA49a4UkSVrMANBKzJY2ySY320eGidbdkarFif5EcKD9ie1
	 qYfzsuhnFIenNaYCaz6H8PPAHm4JjnOCOypRb3V8gwYOnI2dQu+h4gB3ZIaiw2q9Sn
	 iWyrnwjs3r6pxkg1SxoIfQ6ybKrpL8TnlZauwgh0M3CUWuDrbx1n9njnWeSP0joPfK
	 sREQ2lWLO9aoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37D18408D3;
	Fri, 23 Oct 2026 14:16:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D30BE371
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C14B5401CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:16:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LCmjjrSKYHaB for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 14:16:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 244AC400D0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792764998;
 b=HZcLqwMs8TiaSqlYjwzbJuBJmvdvr4tTXTrF3HZD+MxW7HJ1Syj+l3L8a9vf5q9nX/y3
 40CFQsXI0hlLdr97KJqDOK9qC+82N1z0gEiddfEMEaOwg31Khh6zekaNveu1CqfyE8hix
 xtI9kPhBSge48XCCWEWjUgxQKEYZv3Tjcv78HhvOS/wHdXN7DnoeBgby4i/qyLBKsozBS
 RbT0DdaRFMUWvCy84w8/U5vavCwiejSeWpjjq0EZ9PkF5p1obfbLIY/sb2FKVxSJRvOCU
 7yZvCs1UADewz3m/x9WIDGfQdqF9YQTJ89qWef1jeuRvpEAfCfjBWm7UKWyMOqCrtTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792764998;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
 b=jbvS1mMZvM9dvJ7fTKSK7ypDShLUevFLGmeeKmNcJ/ETbm7wJZG4yjzYnfeAxpJzOq1k
 DNNMF5Au3esMnvj9GrNt6sbugfF0BwPQmfgQPa83ZYg3hJsqkPu6nVc6GzEYVQCYKoR+3
 aHa16+70+yaQt7LqE9NPdJ8XCDgwR2C9pavuXjefUGt3mjsIDlJ5/um9BLzMsG8eNMy9I
 80PMHZvflQcw2QOBK4u5kxnYCEqkTAYHxAV5YCU0HdK9XxwkXPg/KevLNjM1tYKPRN8MV
 zrd5PWF9SCD9SIf0a46DcLIPBRBwZs6Ze1pWVgHVEfpEjhDt7pN9TYCZnZBmH5XtazA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BoX0zDV3; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BoX0zDV3
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 244AC400D0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 14:16:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3456402B1;
 Fri, 23 Oct 2026 14:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29221F01828;
 Fri, 23 Oct 2026 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792764996;
 bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BoX0zDV3/cysC/6BALN3iatWQRYpb5H2kDHaE5Re2qQc0McCIndzuUDTM0+z9pDrg
 TZKYcbIhT0FGAS4dUJN0bT6fkoCrvCVWaRrHO7xzSt0QXd+Sd/eO9TyzFbDn5SXesb
 2Y/KxsULEFwwLsVe7EUv/DHyJ3qUTy3NxK/B0h82GAwIAkoIMIg8Yi/RD2aUDo4B+/
 zir3lmy1WA1jE9Xw0DsN/jdEMiYbqRjL0Y3EGXH2zmFdmvmv0e+yDBAiQlUchYBAbZ
 EsO/T/2D8YkxF+Phgfcc0PrXVOkUET/p/PlhEh/IvvR/fR4SqLMcIl0YNniFx/8qla
 35HO5azHhIYxw==
From: netdev-bot+sinfo@kernel.org
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Date: Fri, 23 Oct 2026 14:16:35 +0000
Message-ID: <179276499536.3327.2674391031810316709@kernel.org>
In-Reply-To: <20261023141317.3904442-1-p@1g4.org>
References: <20261023141317.3904442-1-p@1g4.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
