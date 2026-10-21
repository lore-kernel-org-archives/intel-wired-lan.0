Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C9606A321
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=V4MOOyXL;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UWSPxxfI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38E734063A;
	Wed, 21 Oct 2026 08:58:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EODIS0Q3xGHO; Wed, 21 Oct 2026 08:58:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8FBE24065E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792573084;
	b=KIzLpUiI6e4PgTz7voYO/W5mD0ntsQtC5SU1738wl6oR0mVytbE7AaIdwEvOeDRqLYtw
	 U7ZCuz0ddSjkEwOB1WdeYa1C4KOw4M7t0Z07T/GnWbK8/fLdOPnYEaKy0gQIq3fLDGCGS
	 vTQILC9xoqBm0asGO3KxpULuViIWuSXZMkdwG+R+SOQh2ehCO9GkabmxkyDgFJ9AYGtnt
	 cxpn4LWSuU6pue59oa9/NKgyi+GwgbyVeg/YyGW5P6M88AeG4/h28eez+UJ6Vo5SJQcO0
	 SrnQVpf1UyK+oY+2pPhA/FFcjwYw7bGY8ZPv2jm9lK4EnslSIvlRKpDsvT24yTIgN6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792573084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oFoTGPVnuzCoGoiTBSGHy1GvjjGVosxUHiJRL1fL/iE=;
	b=YLU9bJW1g8tXkSjjCJUv3ule8Aq/EjrJ8s5Zk4SJVWDjxtubkEl3ZO3UKIM6XEWthvDl
	 v23DdMdj+kuQ5W08JptMrAp848fRz32f0XH0pW9KVCujAe9Eramew+pv4dRinu4iZB3uK
	 GOT2NctSMsSInjQLsfIPX8hwwEx98n8ftwLmhTvHADP1LZ7KWXwG3zwInri0tIkL4vmig
	 TsBAvZlC90/fA1aH7tK4S0I570pmgFDUKk/cXh90em4cZYj0FQz4uazvyuOWzCLCB0wCy
	 1H0DKaqBD0sDJfnW6e0J2+YSzR62ceAN9v9aHOx+6mD3AHpeLU4xitCz6ehla2pqG8A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792573084;
	bh=oFoTGPVnuzCoGoiTBSGHy1GvjjGVosxUHiJRL1fL/iE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V4MOOyXLOlW2z6X0OcoVTRliRK19mwhe4c91GrYWIOgvY4VU29bbUk4ArlCEMnOz3
	 F0DT3B/AkSYku+ZIdMYjih4Pwm2EsUKyc2414YmODtIMQxmMQknKK34zWoIXVCYx8S
	 TLIAvZhn3eXMsvusg8Wa6iC3lA7PbTbIMwuxqVvF0EfZzND88EJ9NNkXQJAyiPkFqL
	 6RUKLB+CkGIk+OIYs8gX8Y8/6oTHCVNL1/8kFM2Bwikvocxxg4kBqIGxAm4gLUw6JV
	 tGQQ7fCBwm1YkM8eTW3lBqH4LtNWSN4GvbHhVikKODqENT+nXRqsEq4y7hAwPOvG78
	 O3FmAiwUsXwMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FBE24065E;
	Wed, 21 Oct 2026 08:58:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CAA33AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 08:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E17940050
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 08:58:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44fTZsfC4e6O for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 08:58:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6EE1E40060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792573081;
 b=XjrsE/EtSsaWnjsw7rSFzf+WBl4lrOtPCLO7UPaj2CX86t01z0R1GZY1ypRBiYANMfQI
 Bs6Xk+dYEjT0Yrkr2SNRT6PR52s/iU3DpsMCsuEXY8rIvbdm/bulBL/TU4OFQ4VljwR7d
 woliCdXRkbvu3f3gJs27spb4VAyPVSjkX6ivVQHBwbvsP4zo4tAcmcNAu+eib8gSGEdJr
 EAPtJNMu0ogfM/1LdzTuRnNQOSPNdHo9Ylqfgr0khSszfkc4nt0oVGr1Pq36alTmzP2sT
 +ITu58dbmEXDzkqNuEjtnRkzJMGKp2AWwsnKJsgHYLKpEDj3NXUzI3aX81Emj9z4zjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792573081;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=oFoTGPVnuzCoGoiTBSGHy1GvjjGVosxUHiJRL1fL/iE=;
 b=Z51hO9TGd1BQmoa3LUPtvuw/v/n8mkkFClVn7/fU07+7lAjenjilevJfumwmbrCamx5R
 9AwKbyHQ8M1I9lliELbcXOV9/yGwbxbk6qPdL3mcaTDinzOYpdTymH2g2/FhEOCVbtGBe
 7IH8pslCXUKwhFoThKNYXlHttxkwn+4kyxJpfJZCsknkdT3A7PjaAmGdBKES/657lv7dH
 OSGd/nvcWCpcpiBb8KUo10JimSMMxaOWHstcCXdbpIYWUofj4fmT30ECWRaji3YrC90zR
 Do3kEVBBQOKVxXALWd1iqsg83/K0iawH0YjrcdLGg+nHl7qLQLZB2o2i6XJ2Q3ZZPvg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UWSPxxfI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=david.laight.linux@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UWSPxxfI
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EE1E40060
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 08:58:01 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so5304525e9.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792573079; x=1793177879; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oFoTGPVnuzCoGoiTBSGHy1GvjjGVosxUHiJRL1fL/iE=;
 b=UWSPxxfIlK46PMioEN7dIhhik8arC+biOJsCaZkn4iPGoFyuTYI8w5h3kHmBcon7SV
 m9H5mrvrKH87EouHpyYbqWQodqfvu04WGbKZqE4fdNYD4GDr9ZX1kcvzk+ZV07Zye1ZP
 zMRh1iHIO8d+F4BA+e4IoRbEpbVY5iHauYkdy2gHGYm4NCosMK3KQtQTZEp+tZtm4wbj
 xN2SWiEq6+qrIBQz50O3MffPh+EJBxhq7FuiN6vn+rrBVtiwDxg9V9364l8Eg/1A1260
 N0W9+mO0JyXa8lsqKeBO+pEHAMac1I5Yl98rAMi+tp8eCHqtB7W+pKO5MIONEqQJ/itX
 wtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792573079; x=1793177879;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oFoTGPVnuzCoGoiTBSGHy1GvjjGVosxUHiJRL1fL/iE=;
 b=EYPZPf5Xdq6VdwUEURPqQThDT/mWz1eyxoE7lKmFEQ0mRjfjwU4MsIo9Wn+DcFIo47
 rby7/zXnQv5j/FugabZpYi71B++Xv30pb0epCtHXlEQxEnAHsMOZJt1Tv8TACt6JDnxC
 x3oT4LJ0GygHsaJA7va/91wuO6lw5cGSTbXY9s5ikSg897rQTRTsDuAJFyBOJS/xjk9b
 +RvYT0qTx2lDy5fGF5Ygg37ySCjTCd07gL4qBbXXzkNrQFC4qlGidvsTbqtKQhbUR1um
 z0AFaLwKlGWM1PT/4hi1/fBVUMN4I0jqtRod9EWW1vv5x23cpZTZ5P3qtYt3P+HDZ+Ug
 cNpQ==
X-Gm-Message-State: AFq9FYLIohA66JOFrZLwHzYt7TN0QcL2dssx4vCNwZ9w2VekClr1hOMP
 riuW5SXBhIw4PmZUSD/safF9Zl1pJ49Cn68+OyOBLHVGDW/yCTGm+FmB
X-Gm-Gg: AYBFou0ShVdWzHm6+jRtJQjLyt0LC2JIfR43OLMC7r82RJRG7FwBE/DO/z1RSfkGJFT
 CErfp6sjnDaDF7rYtBO2k7auBFugBF2eom7g9WnyXo44VN/+k8qMSu3CSRa5G7dzxkrLSQXIj07
 7uF+2bV/UMse2No8S09l7ZdUoiQEkfXWt5+LIx3IdvB/ZIdCiJEZ/duoc1S0hTWQNFH1OjZeZXA
 XmrTmapjmk+Vsqa04rsxNkUJqzIs5yS6YYtlrlng3taH9kg9zSbr7yooXqyjx7Sw7O2X0NG7XYm
 /JDJDxx7v7yM3MGh6E8GHmxVA0ErINzx9t1smgt0OulKSqnMsYX2DHDG++QgQvJzorSPSX8Sg2s
 8Mu6pzfoX3lXh2z4dm+AXVDdJttguXhKdd9M/vrodKDkXL6MgPs9fC915I7VUCOwnHMi+VglFK+
 HlibQL3U20LQwBNDL/uBoWXj0l30JLZCtrJHdZ8p6tvKNCVwoCQTBN+IjbeufSq98JyRCBV7RjT
 UJ0CpcIogvEoMqWpUVY6q9N6hXodWDAq2H4SnWKwh7E+q1iQ0skDTLecLH+5XJlrLcDaUfCpjyu
 3sB3pl5NgyWP/TZu9INDbKY9TAn9anLvJ1rA3w==
X-Received: by 2002:a05:600c:4708:b0:4a1:fa21:fd90 with SMTP id
 5b1f17b1804b1-4a1fdaef9a6mr26193665e9.9.1792573078797; 
 Wed, 21 Oct 2026 01:57:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc1b227dsm49117435e9.6.2026.10.21.01.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 01:57:58 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:57:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andre Brait <andrebrait@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 g.goller@proxmox.com
Subject: Re: [PATCH iwl-net v2] e1000e: work around TSO erratum that
 corrupts data and hangs Tx
Message-ID: <20261021095756.0f5770e6@pumpkin>
In-Reply-To: <20261020230211.75665-1-andrebrait@gmail.com>
References: <20261020230211.75665-1-andrebrait@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 01:02:11 +0200
Andre Brait <andrebrait@gmail.com> wrote:

> On I219, a TSO packet whose first buffer is long and has a 4 KB
> boundary just after the TCP checksum field makes the NIC send corrupted
> data and then hang the Tx DMA. Forwarded VM traffic (tun/vhost-net)
> produces such packets, so hosts bridging guests onto an I219 hit it
> within minutes:
> 
>   e1000e 0000:00:1f.6 eno1: Detected Hardware Unit Hang
> 
> Right before the hang the receiver gets TCP segments carrying data from
> 128 bytes earlier in the stream, with a valid checksum.
> 
> This is the erratum Intel documents for the 82571/82572 (#76), 82574
> (#17) and 82583V (#7): if the first buffer is larger than
> 3 * (max_read_request - 4) bytes and a 4 KB boundary falls just after
> the headers, a read is repeated, wrong data goes out with a correct
> checksum, and the Tx DMA hangs. e1000e never implemented the documented
> workaround.
> 
> Apply it to all e1000e parts: limit the first data descriptor of a TSO
> packet to 3 * (max_read_request - 4) bytes (372 on the I219, where
> pcie_get_readrq() returns 128). The rest of the linear part goes into
> the next descriptor, which e1000_xmit_frame() already reserves;

Aren't you using an additional descriptor over and above those the code
might already use?
So either it was reserving one too many, or you need to reserve another one.

I'm not actually sure all the logic there is actually needed.
The code calculates the number of descriptors the packet is expected to need
and gets the packet requeued if there aren't enough, but there is also the
'post transmit' check that stops the transmit if there isn't enough room
for a full length packet.
If the latter is valid you don't need the former.
Although a sanity check that the ring isn't being wrapped might not do any
harm. 

David

> the NIC
> still segments the packet.
...
