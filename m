Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008B60A261A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=LsyoqYMV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiSaHsN/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23793605DA;
	Fri, 27 Nov 2026 14:24:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cBgIxfEy3O2l; Fri, 27 Nov 2026 14:24:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F94C605DB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795789465;
	b=HA6qfTtPNzD87QdirdgUaFR9YTmFZWS8f/M9BXncV3cWab0/Paup1OU2/6xfbFg8SEOA
	 cGg8HQSVnO1vAQ5ZjKL+JofZittz9gODP7tcvmyJ+wy9/VUF0y1hD95diAU1LbjwigLfu
	 YXcIe7Gz6szcPYT6N1kZhXUvY0IohGF/KmMwV2kT3gGC6WJcdfM6ZB6UCiSZQMmWqtqPG
	 S2+/gnv/7+x0N/AD4mRbSLbp66dXUawkFnrsmrJehAd/lo0AnEowLci7oDHxP4T0fQhoz
	 FcckvHlI5X371HLonHAbMzfEH8SnRDYAK1T5MpUxaY+GOjt9ZDQiVO4thpX8pZ7Gpfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795789465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=jtQFNsHxpXtF90BvRvXMjVANogCl2dSSMhOBuAlg5vVkUqLH+ZMXH+o2NPz0dje0VQDY
	 19askda2zgBlsGc3XTzhnAqOQNvqmPp0p6qg8rb0yvlkvlJ+NWm9KsyRDsGcYRzpX6z5x
	 1JpPqmCQfXfXTbcPLnzdCiUqhcm9d/yQl2Jewe5h9/EBLT6usZzai+OSwM+TCF34IzF6y
	 GSX9OIt1F1GBN/piU/fFHMZt26b6aWT7YIpX/usHbAKlTNRCxn0Tl1+OrLQlOaO3cudT2
	 ZRHXqoxqdnfdIVWu+3Ntejy7JJjUKkivvHwbTpe+Pjv9L9Ci0LXG1aDnLyDoBDb7//g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795789465;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LsyoqYMVTOc5OkXRAlNl2Ln+/J7Mivn70rcsAjhBFV2luhRhBr8cPwnkjfzZwwKBm
	 LUebe3hA4sg8tcpwsauoLSm7J9x75vJ6RxyreNgJK6WwkscoM5SLHZm9YGLzVmtaGW
	 u6iGKTFnJt5foJPZCuiq7WCOO2BrpJsDd/Sor7ttubxBL3s4zEuXOOae6/yqNmNhjW
	 ezR6PofngDykCahxIiXaVnUQ9xyobC535MBpFnwJedYXCGmJg/rBqjTp5ovS33gqew
	 0LQEDYvHbJGTi5Bkp2RpwvNWh/XePeoY+Z89k/acq4LJSZaCD1prECUZXnXgJimByL
	 gy28bJrcwXIzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F94C605DB;
	Fri, 27 Nov 2026 14:24:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E75B0373
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E48DE40518
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:24:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4O0sv34RP6mg for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 14:24:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 524FC4050C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JiSaHsN/
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 524FC4050C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:24:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54B7A448D0;
 Fri, 27 Nov 2026 14:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6389C1F00934;
 Fri, 27 Nov 2026 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795789462;
 bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JiSaHsN/eSaFadoc5tJ5VpXhzsvdCL87P+2sY3nhUY+cxtvQ88EyBcTq5fEP8Aw7F
 4vqC+aJOYByatEIRgQoADHOEfgTfQCjZ0wwKW3t/Z1Us+yb0Hmg4yf63LNY9og8WeV
 FuJ0ll92LJW0f//eDjv0hmdIceQRUtyXwxrD4mse/tfrhaDuJWDPXFAFTQy5ApqlMJ
 jxW/4yJ0rh8s/EIfYop/r0Uom2+Goi5WNdYoxoG2e/xqUYBy0UEMcXPp7NGSqcU1AY
 mMnSgGTjD/+FQ3sN+1sUFINBNvtR5sV7EniSzic+IXxVQch7GUA6SHPE+LRfXdb2Ke
 2xc7ddc9edrWw==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman <horms@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Colin Ian King <colin.i.king@gmail.com>, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 0/3] xsk: Keep the shared info of zero-copy buffers in
 kernel memory
Date: Fri, 27 Nov 2026 14:24:19 +0000
Message-ID: <179578945993.3294.13218544631013207467@kernel.org>
In-Reply-To: <20261127142131.3527737-1-bjorn@kernel.org>
References: <20261127142131.3527737-1-bjorn@kernel.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
