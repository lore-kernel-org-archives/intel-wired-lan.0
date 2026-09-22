Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA44C98307
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4094B606D0;
	Tue, 22 Sep 2026 18:22:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ATK1z8VdzWB1; Tue, 22 Sep 2026 18:22:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A6A3F605D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790101339;
	b=sB7eU0H2euDlG2/RPfYIrvaTUWdDf9WPEs1/FX5VXbsDxG+rx0xfdqIvUFXaNT9PZxXE
	 W8SlH+AV9Ar7OxWRZIllfmokp0rNQl1NXLjkkeXaZBUbFGH+NSzQcEUNpL71d1whSRr3I
	 RWV/R1zgFNWips0YFj7/u1BamvGDoewb5gY/muVzYJj26hkl62T7E04G6tGh/AV43ccWK
	 w8XZUX4YPXXYcCcULqtBWcARlUgzM6VzZ0CE3Pidru3U01FMo2ERc2ukLNgJnotH49rCp
	 VtK08GR6hpOQI8MxdTb+jDnf68L8EycIgKQZw6BEKPwNypAu7oeQZXsU/8mESU81ccw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790101339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MRtD+LvKA8k0qh23e2kYmI98CWVJaQioVM2C5FlEVyQ=;
	b=d3vZiBVAOydV1o6n3IyU/x45b9zgep3893tz6chdt8o0V6wtSZhs7G+tDd3o5xsODsA9
	 W06HQ011aPTE+KeDJL5ZTpwYbCTK5zqkZ4qU98cjHxVsmjMFM1BusQRvexqrRhoieHDnF
	 rHggii8EJ5enWPWnS5fjvXZyIoU6hHQ58RL//bYD5hAECUZoXrIOdTe+Jcj2dwAfmosX0
	 Awu/fNg8PbTbTZ72ZICZC2grv2iaW8h68O8W+CMgEbJLx8VD7kdBbaa2Dcz5fY2tosmTs
	 kR3trOwBwI0/5qdV5Py/IMn1e7uwApdQNyK51LazSmwuTADJgi0JdKV4NB/DkiF8Qzg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790101339;
	bh=MRtD+LvKA8k0qh23e2kYmI98CWVJaQioVM2C5FlEVyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ksXs9q0eBtl+V2WejaoYNjblVJ/iHya0Vx/9/Z0O0L+bmmJy4QtbX0PaIjNM49mPM
	 qJBYc8Fy2MHiDDFztWM8oUrXfnORGHzZXWV9TGo1zLU3uwLUiceqPp/bYItYSpw6dR
	 uex8k4ZDPODgOe024rsGjoNDx7HFS89YXhjMk0oJ1/4C9ChKPlaRtvVBqGTthn6Kwa
	 IOGxlIkk9fbUaqXl1+qtk/kCzRKTjvzMa7YEUQCRpBTh2zd5LeZPVMnCTI4FC7JzU/
	 btBvJchtjJwahdKWBXlZxflvUXDv1kDxA6HNrvo3xK7nDlBhHJhDvqf2mXsnLaVCil
	 jU7bQNI6vyEMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6A3F605D6;
	Tue, 22 Sep 2026 18:22:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE3A6355
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9757680969
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iir-OgoKIz1O for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:22:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F2AB5808C4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790101338;
 b=Jr2utSOd/o2dJmb5NwOP+LA6oDSdPDHPp+80vt691DqRRLkK94uNua60uF9fxpwyXDFm
 B+ZdKf8cM7jbJMXVwcPB41fZWArJYPiwmu6fhXJcBwGRUmnn/3Ar6Jl1bTp/fne9MUzE0
 ou8L2Vjjvv3J4gHLrW8ycBkKN7icBhU+F64UCqTtK1KqmHN6cUuGkgeQUQL7+F3TIKETC
 JhcYNJ1muKZKI81bjYNlQnw/4IzZ9qf4YxWLYcsrJ/vCYg+WWlCei3gCBabMHgUZfa1AD
 ICsAqm3LPmzd27sSSHUzKe+T8muiM5v2Plk63r20UcyiZiAH+6zZLZsN7ElkfQKyy+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790101338;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=MRtD+LvKA8k0qh23e2kYmI98CWVJaQioVM2C5FlEVyQ=;
 b=Hg0i6kAmVKyagDKZsQqmuoQO8Uqn6CDgrIUl4cknODAmLULzV+rB6dzD1GnIE5olIhEF
 +pC6YTkx8yC+QVfEbKwu3+t4kG0afOBiaHonpYSfopopXAG9lAV5utD3h7EvuDchEo8jl
 BMwan/H7hr9suS+UGSNCAy8ZPDHKesfqN/ROUJrw5Wj/jpf6KuC1EckwJQDHQmb1UH1Fz
 F0tSxmI61qTzjLz9a8yrno6CxxLJzPwpLqBd4fSrRdP5DxaZs20MRWV1XpUPL2Uow8uhH
 gjDutsNs/bEsHU+1mgZcUBW4NYjcgDY/TO2DOE8wMXmaEq6AP+Ezf8cskfx5Xt9X+rw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gFHs2ii4; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=gFHs2ii4
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2AB5808C4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:22:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E44C417F0;
 Tue, 22 Sep 2026 18:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B986B1F000FF;
 Tue, 22 Sep 2026 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790101337;
 bh=MRtD+LvKA8k0qh23e2kYmI98CWVJaQioVM2C5FlEVyQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=gFHs2ii4Co6Da2jt7D/KyYwpJBbi53RXnRY5R/da8ix0ZZYilXCal1cSPlnZ+cHHh
 a0qeH1zSXn4PKmRAT9q14m8OYYrsQ9cvZQ6nDk+yWwfal+Sl3LM6uTkapXUs7phgFk
 Z0SrcyruNu1nQGGCSKcDKgenqpQ85If0BNfEzppkaNZMV0pv4me7lOFofU/wykr9b+
 4TcdLFq9OBRy8rqdRmH85R7TsmiZap1BsahX9/nOH+TBDbLIwaHWbMDPI5LeVZNmqJ
 /1UdUIByzZpsoMKgwxFttEsZao7X+H4/8f+2V4Ap7Jd9Tg8Ja/1oCmr+IemMWCttQn
 EHNYlzjDDpOCA==
Date: Tue, 22 Sep 2026 11:22:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Intel Wired LAN
 <intel-wired-lan@lists.osuosl.org>, Maciej Machnikowski
 <maciej.machnikowski@intel.com>, Przemyslaw Korba
 <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, Anthony Nguyen
 <anthony.l.nguyen@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Petr Oros <poros@redhat.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH iwl-net v2 00/15] ice: E82x: timestamp processing logic
 fixes
Message-ID: <20260922112216.41e6f8cf@kernel.org>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 22 Sep 2026 11:02:33 -0700 Jacob Keller wrote:
> Subject: [PATCH iwl-net v2 00/15] ice: E82x: timestamp processing logic fixes

I think we need to reconsider iwl cross-posting to netdev.
I can't get my unread email count to stay under 1000, and
I don't think the cross-posting is really bringing much
benefit to the community. IOW only Simon and Intel people
look at the Intel postings, anyway.
