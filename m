Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6B0CC6B34
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 07:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24A5E80FB2;
	Thu, 15 Oct 2026 07:49:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VQhFaAajG3WT; Thu, 15 Oct 2026 07:49:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9788C80FB9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792050586;
	b=AC3kKr+qLgMbAcKsSRgGn/AlJkRYqvjzjjCNZcS46Zv2G/ayqDVzMRdk23Ek52V62Azt
	 eeyMQuPTQAB4DigMos/JsGc1HG5IaoNGFpxrC/4x43vFeexVrKbqr2vtnHwya7+o//Vcy
	 UhK26wVslu6mWukUTGeDAk+WeqlXOgWEXhp9ClTfHPhDfDG7GV4vyLZXZnyC2Ufi9smo6
	 G0HO4ksWe4i3QDjBfrgsGVxhAEGTvJZ5t4AGOxoVhdGn1O+c91aJ6hyQL4v76k6Isy4qc
	 3eFkNhA5y+KWIq+QZz/7IuTsO72S/AOnIYqLr9lPlYizsIk2uhKqUXT6eE/96snQNRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792050586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=NBZNyC/u3t1sV7otM2d6d+AJLNkCDZWtb+QmmVTTSfhoI+AjiNNzMYFF5I05wtkM7XjO
	 n/2cjeyUgTnO+LvLYaS0lMaoD21mz/G3BMxO7fngo0NwSUOeV9yi0dZ1k6Nt+f1dSSVHL
	 eCwEZlLCHvaKscSZ9HWWkb3uGkYyUSBysLevGed5rxjQWi31M0wlaqIRIrLza+pbmG4Lf
	 XW/g8D0JQTsLKqFK9SYzgonPtnR3S+EFmSAKlErTT0DuX5twMQgyX0U3UGOeO0CXpt1iK
	 Xk5lvqieUZ7LAwTNaDTQTtnaOR8e5IAZAnAZLWUx6JhkTLxTeup2srp+WHZZ6hNPPPQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792050586;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dRdW2Z5CzR02n6hIAcdH4eDgxIPF+98i25vLGJZZkqIzT7y2J8yQXTNVXBxlvbUNB
	 n7PgwvThByCO2zr1frn0TLZhkuzBw04rJLuJxLZ3tOoQI1OVmDzdCAAUkbEUwuaBCi
	 Bn3v0NccTSI9xifrWwwmv6gpUBgQMN3LG+HIrGY3oGcZDxkDy1tqTVk96MYalY/eQF
	 +2zU54oM2wRpPXMT06iWSydYoo13csb5BugYsA3nrVnheaN3ouGuZHOMSNv8Hty81M
	 E4yg1TBq2Id8/BW4JA0TkKkethZik7IuHRcLtHAjjMhPmp50wOKjXo8MCZ8Eu3YSr6
	 TLw098o3Fi9Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9788C80FB9;
	Thu, 15 Oct 2026 07:49:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 98B7E255
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A5CF60787
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:49:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2daV52gJ434 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 07:49:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E7004605B0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792050585;
 b=QthB7vnz1B0vBljPFZY7llcD1AkRa9iD5zThyAQlfljHiPP9G5+ezxJXnUc6eJrxRkfl
 cvxwkENvQbTXyaZsVP+J4KO4VlkhNkdSqag3wXwGFE3ACe4EdH1+tqBh5EXuEHoqIWnJx
 9Y+ldXikjI8+/+Mlq/H1p53anmMKEPa7k3KeyLqLQ7tKE91Pycih648Bkn4O0t5UMnAWH
 e9CQKmOkh852lXvQaXB2IhU+HyHD2baSQdWjjq700uID7f0CXkg796oXzzEmyHSkW5Na8
 E5ker+Vwvov+fBTmFygKtq0tgC7bo41iZVkHyxChaPkiscgGo0jS995NUO0H8LTbUPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792050585;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
 b=D9qL2yPbsqsfxR93lMWvbBxQNnk/DheeEa7HmHgznBwXbIeRRW0CYGBklIlTnFQ0T3lO
 9yYY2yTXSIuXtKCIkQyPRv+aTylZhrhW7E5qvsNlZS/r1Q+mzzj1yqhAyr0Lx0W/MtjBx
 WvlnrXs6MfJXsdQfwhIzpsRUmt4NMs1bfHZXQ8CsT66b+59Q8yqhk7QRzxrCUqTFkiVd1
 vrPPhinH3mQsNsNNMjMFvgTJ9OKzK4ETyeECH+qE0CPWtLjmx5eS/pNfUw4R15nHPpVuU
 RyXEihIwQT1hQ4bueL21ACxX+XGN98ifQTOU0BkGFTDn5uDOA3Qs7egQx4qBYcW6WWQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HS+TGUBQ; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HS+TGUBQ
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7004605B0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:49:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB4F6435CD;
 Thu, 15 Oct 2026 07:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6F01F000C4;
 Thu, 15 Oct 2026 07:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792050583;
 bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HS+TGUBQm1vrVs0Ax8ZqhzrTZVO/5ZWp37Ddp2bPRo5Kbo72zVS6iUQqkBqXSiEs4
 9QTLOvcgLz/v5nMtu8a3ouaFeyzd+olvu74Kc1eDhbkhEo3Xa1WOzfLUR3ZP50jSsJ
 X0InUXuE5+cawESxicvMVz7tgbL9iQXpdJDlCQmTWWrLGoQlWLdUwlFoGQqnXxZ+dU
 lWutYlw6ogCgIBV5z6jdp/X9bFHKwz7R6cL4Cez5lA+O/QCuPynT6ySQifLzjnYcsp
 BRCi9JwcNeDqpflixEFHKhMQwRvV9QKhz+4USosYPzz0u2WMkbDlGG+RgA+OJ4oWXB
 /IzcWcJsYsecw==
From: netdev-bot+sinfo@kernel.org
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netfilter-devel@vger.kernel.org, virtualization@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org, pablo@netfilter.org,
 fw@strlen.de, phil@nwl.cc, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kaber@trash.net, jengelh@medozas.de,
 andrew+netdev@lunn.ch, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, aleksander.lobakin@intel.com, 
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, willemb@google.com, alice.kernel@fastmail.im,
 eilaimemedsnaimel@gmail.com, imv4bel@gmail.com, shiming.cheng@mediatek.com,
 sd@queasysnail.net, vega@nebusec.ai, root@tr0jan.top
Subject: Re: [PATCH nf v8 0/3] netfilter: bound asynchronous packet duplication
Date: Thu, 15 Oct 2026 07:49:41 +0000
Message-ID: <179205058144.408196.393758576070980065@kernel.org>
In-Reply-To: <cover.1792048855.git.zihanx@nebusec.ai>
References: <cover.1792048855.git.zihanx@nebusec.ai>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
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
