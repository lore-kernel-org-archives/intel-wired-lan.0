Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B6606A690
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Nov 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vibEISYv;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Zig6KLa7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 051EA60664;
	Wed, 25 Nov 2026 09:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oj9RS5vb83oA; Wed, 25 Nov 2026 09:13:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38A5E606A3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795598003;
	b=ZMe5qNoKneUk9zE73ElH7MxSMswrtDD6T/vq/nkdWMhXSIatO2toxHGxMuq0xUdNcYz8
	 cKH1+sZmkDERnykyDZkqP46uAbOcKXy9I95lvmcMn3qcfT0tUdab0afLy8byrKrYspXZ+
	 2CqaVETfe0PJMxxt7A6bZvxSGItcwEwtjc/0u+NiL+FpgMredVAzgmDrFkIawuanUeRrX
	 SNtQYFPXHP14UVGb2F3FCRKzQkX99iYbbYkuTzp/FVkiBMY5RbGuPxTPyQC232ulNe7/7
	 hyU3op7Hci83mqtPJnXF3NxUddQ2Gsnx8Jyv+BcyT9yVJfD8irZF0VxjazT7F0sKwZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795598003;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2SrnLqwi6obns0/0mQLix36QghF6a+1nH1591GRlSFU=;
	b=NJQwc6BprjmZifIcxTD7em/nRX7EKApluLHJ1zkuhvODVWTNXRgZl1+pvr3Ffvb/mRWv
	 SswEIS6hzIEGUNSMn05LW8unTAQSxqKvm6COHc4QliiPvT9F02tH6OkTwFmwS/Yn3pQQ9
	 9uNJJWIawB8Eg96ZBpNeSCNbkdekFr64Zi0RKQo+MgoVdfgz/58MBKMW8i6iPbu+EDNER
	 5TLzXojy3/DHRMrch6KA6OKLzDjU2U4YsmN73vRdLME1/yj4QUE6xY4LPAFa7e599BqoY
	 F5zMYCscgSMlPSuEggJ9w0D9dGD6NZs9cKrn54lUnIcQ+k3eJ6DE/AHibuZkeNRuSVA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795598003;
	bh=2SrnLqwi6obns0/0mQLix36QghF6a+1nH1591GRlSFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vibEISYvhL4Z5WD4RpOdEgxNgOO3R12838oGh2fv0eRf3c0w7U0oBhGmFcc90JMme
	 rh6J9nzrsBmNTXyV6MM63dwKwTdqIcSAeMOOGGLxxgFnaaylcJt2m7DiRBHfcNRVER
	 wHrNN5zJ4XWgEJZht/PvWYXqjoj0kII19LD0nO05QAx9/Zt9+Dc5sh07wd1ZNxFUh2
	 a1/iRS7gQGbLMnUoe9ZNjjwMf9QiANK+fxLhiiMY5MJRF5Txee3QkTN2OGzl/CKDw2
	 /P09brYsP4QChBteSaSk9pnmTo3/jXXzzUrpneBaj6zNvrroRM1v6dS2qx9ZiAqu+Z
	 L1P4emEhWnD4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38A5E606A3;
	Wed, 25 Nov 2026 09:13:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CEE691C9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 09:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC74B40122
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 09:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ztcvXj6qpzB9 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Nov 2026 09:13:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6849340064
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com;
 envelope-from=tianyi@cloudflare.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cloudflare.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=Zig6KLa7
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6849340064
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 09:13:20 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5c1c0c8d61aso3647049e87.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Nov 2026 01:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1795597998; x=1796202798;
 darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2SrnLqwi6obns0/0mQLix36QghF6a+1nH1591GRlSFU=;
 b=Zig6KLa7DOYRcBn7ooKzLwU1KFNB+/EHxg5gPOnK+F4Kz1nEN0V4irT0z9CSopEQCG
 PwyviKBV3UASIkkcbldauTis9PFBlsfOlh4iwVETCbYWFR/YM/KC1N8xziRsKhh1jP2E
 +XphbWhHiuF5Y2yK943Jq76xKQdzu0vCCM9piESHkc2p8F5X+IvCeIl6pAFcwCAaYqth
 peTa4lw3XwHESnb76ZY8nmzQ9Nn+thu2HTUlCiKniDZA0MkQ9LsDHC9PWjUkcLKtIyDK
 sssC9voPs3SeCnb/6T9zc52UG2OK/AbpBhu7qzSZADtudnY8FtYMXAnWD0AiZD/i2n9x
 4ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795597998; x=1796202798;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2SrnLqwi6obns0/0mQLix36QghF6a+1nH1591GRlSFU=;
 b=iSTb5fymwVzmRTxxg39Veq51ljipBPfj0wS9J5vUAFhoOyG+M+fS5CaSWvWt3UkGXj
 afd6FlOWGgy5f8+HgWPlBXRkwO0CrL8du1ib0+Ul/IaCX29M0kwGKyamXePrr7BtL5Ap
 SsbQywRQkXo+dL8jibz0oDUijiKBf8yu7tciiSRspKOwc/K5q6rPjNhtpxaRrtHtz+/n
 U58R4lvrgruc8FiA4JTPaCAk+cOBFRPpwrtHzwam2k3agBmwe4qD9zVY4kD3jgXu0Nl8
 QJfFBCl3xcGkOAP6M1OkFAH45qR0BpOUU9OkITABK4kqm4F6Pj8yffum+V/iX1yqAmoo
 WScA==
X-Forwarded-Encrypted: i=1;
 AL+hErHS9uD5WQVqTgV/Oo5jUBUhFSBHc8KIwhoT8PokLVun1NjyTz9zAAH2Ldb3ydFTjuWeSh/pg8GWyjTE0SPTOkc=@lists.osuosl.org
X-Gm-Message-State: APuU4Z9hVX8Bf2dkQde6pmiQrQjUEMla9AiOmQnIrowvqvbJl4TpSpfi
 +HQj7QegAK0hoyeOvRcPThKxTFlPtCf/l2MBLJCYqUHeZA+IrBAgciYKisQfF6/7K8EWavkvpD+
 1dN1qou0=
X-Gm-Gg: AZFdTZcZAnxbTBEdlEhoe8kosE5B+REIZo3XlVZdVY6uHjv8rQyFXNV90c6HoAWIjH3
 CsmX8Q5zjqJShlGhA4M75btu311S3FPrAWi3dQ7ll/wv9S+Rp5YopbDyU3DbIj+Z4pLDTX9f07b
 W6FJiexKi5RTTRbfuSVesRs5qmUEBXtj2H7tSnrvLeGhsyer+OCzv9/qMGX3YegrUS/3tZksac9
 MmmTuqOESj8uXpp8DPmlF5RIXlL7/R6uKusBDXbqMUsY+ufUxPXqHdN1DRHmEFKZzdUWdAc2cPL
 orq7Hprsgff9a9UJTiuI4fif4eOT98Oo25cO15kkm6YbFK2kJ9ZUw7RubM+cqqt46cCQrYoE6L4
 vj55iuV/Vv7hQwcyS0fh+iiozFIYbNTEUz1dD8ET27whKAoTsY47TPEvn0DLXikAdSB4p44x1aD
 L3tBKkH0T+U4/hTh22uM+WZYn7tcaY1xwpOBCXp7WIUO4SbPXGMqo7CSPjJDfOw5oD9ISRRDLy/
 bPP6DFBFp6cEJYqo8zp4/M7cYhobG5ffnMV5CrTtoofBqdpt2P1/M+3Q6XdoEMkseKmrvbsQhpK
 fwi89vJa2hz9IyqN/iERuL7u0gRYw+6UM4dJUafbZ0auiHBKA4wtI7pZHQ==
X-Received: by 2002:a05:6402:51d2:b0:6ba:6f75:9d44 with SMTP id
 4fb4d7f45d1cf-6ba6f759e80mr8443781a12.9.1795597656119; 
 Wed, 25 Nov 2026 01:07:36 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.55]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba7b9570e9sm6152930a12.36.2026.11.25.01.07.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 01:07:34 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Alice Michael <alice.michael@intel.com>,
 Eric Joyner <eric.joyner@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
Date: Wed, 25 Nov 2026 09:07:32 +0000
Message-ID: <20261125090732.69233-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com>
References: <20261121012402.84848-1-tianyi@cloudflare.com>
 <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
 <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
 <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
 <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
 <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-23 at 16:17 -0800, Alexander Duyck wrote:
> Any reason why you couldn't just strip the GCS enable flags from the
> rings when you add the XDP program in ndo_bpf instead of having to add
> a check for every packet if the XDP program is present? That would be
> closer to what they did for the Mellanox NIC and wouldn't be adding
> code to the hot path. Then it is just a matter of also adding an info
> message that you are disabling this in the log so if somebody does
> have to figure out a regression it should be more obvious.

Thank you for your valuable comments.

Clearing the flag in ndo_bpf alone is not enough, because
ice_vsi_alloc_rings() sets it again on a VSI rebuild, for example after
"ethtool -L" or a PF reset, while the program stays attached.

In v2 I will set ICE_RX_FLAGS_RING_GCS in ice_vsi_cfg_rxq(), which runs
every time a ring comes up, similar to what mlx5 does when it opens the
RQ.

v2 also logs an info message when a program is attached on a port
with GCS. I tested it on E830 with attach, detach and "ethtool -L",
and I will send it soon.

> Thinking in terms of what the final fix for this might look like,
> currently the drivers are already starting to carry stuff for frags to
> determine if they support jumbo frames via frags or not. I suspect we
> will likely need to do something similar when the time comes
> indicating if the program can avoid corrupting a checksum or not when
> it is stripping headers.
>
> I am not super thrilled with the idea of this becoming standardized.
> In theory this would be much better if there was some way to pass the
> data out that the frame was mangled and what the checksum adjustment
> is to the total frame.

100% agree. We should be able to tell whether a frame was modified,
keep CHECKSUM_COMPLETE for the frames that were not, and give XDP
programs kfuncs to read and set the checksum status.

Unfortunately, today there is a big gap before we start that:

- [1] lets a program read the checksum status, including the
  CHECKSUM_COMPLETE value.
- [2] lets a program set CHECKSUM_NONE or CHECKSUM_UNNECESSARY with
  csum_level on the skb.
- Nothing lets a program pass a corrected CHECKSUM_COMPLETE value to
  the skb. [3] lists this as future work.

> As it stands we are probably going to be
> getting CHECKSUM_UNNECESSARY on everything even if we don't expect it.
> For example I don't know what will happen with an ICMP frame sent over
> this tunnel. I assume it is likely just discaring the
> CHECKSUM_UNECESSARY since it isn't used.

From roughly looking at the code path, ICMP does use it.
icmp_rcv() trusts CHECKSUM_UNNECESSARY, so after decap the inner ICMP
checksum is not checked. TCP and UDP are the same. This is the decap
case left open in [3]. E810 and mlx5 with XDP behave the same today,
and this patch does not change it.

[1] https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org/
[2] https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.com/
[3] https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/

Thanks,
Tianyi
