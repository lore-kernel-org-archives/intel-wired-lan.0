Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACF8C6FD1C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Mar 2023 19:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8EC9400F6;
	Wed, 22 Mar 2023 19:17:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8EC9400F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1679512642;
	bh=fUVXcWsdLGM/bE6uOUJo0NW+G2L2pKxI6lia80TSSpU=;
	h=References:In-Reply-To:From:Date:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Od0WNsaKyGlVo0vSH8NhwqUxIYznbzFf1mw1b1RdZWInTDonmPmewm3KSDkchgWsc
	 jtVdr+SIAWxgspIY6G6+cncwn5UU7RFZKuEcxAnn/tJRHQbX03FQq0zyK9tavIhYYH
	 GeYwCrLkuqx97ASh1y701p2GFhtPR9Wm2IP6YGU/b+5SS8uHOOEc/Nud1pmTL10+lM
	 +EAZRGKy3sJiOruAFY4fC6xpst8OT+RrDNA6cs109UTAZQqFT6InSF7Xf+GDChjQ4m
	 WUKu3JWINq9lH8Ru+XDr31UcbkBYllkQGjIkHJG/p8X0+ZU54iUp8Cfw+mAe7K0XNX
	 MyA+tiUCqVewA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vI3RwCyvgBHy; Wed, 22 Mar 2023 19:17:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 98086409A8;
	Wed, 22 Mar 2023 19:17:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98086409A8
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 95AFD1BF3CD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 19:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B4BE409A8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 19:17:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B4BE409A8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZmksjbIQFwd6 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Mar 2023 19:17:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D01E400F6
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D01E400F6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 19:17:18 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so77270696edb.6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Mar 2023 12:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679512637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zq7Jl3TGbJwfMRCJgFwbgsM8JVMZ+vr7U3sGfe6jsB8=;
 b=rC9JN1LJqtgulYdT4oFrCFdFhf6x/mMUGCk0uKJQG6Jd0sPTxsvAzX7qOuMFvZqitR
 tGhw9/yEzEBdtM3JmwTfxySlyEHkoRvfd63F/VX9BHJQyg7QPLvcV8fthylfWDl4OHwS
 h4/uQtmEgBnoHBWKv+u+LTNFv+qaAIVjJ/sMnngU6YTXSPYEUNQPrcG/TbFnDnq5gZ7/
 glEobtZUpGwKR5ZCvfRLGAo4sCH2WHcbbl6BF5xxXwuWk0sjBmly0ky5haWZipCRN7xz
 /wYb+FP00uCL5+MzqFxA2mXg1JDXylM2l58sxF6G7/DciOEqttENzYX3OGbIuKjBlI2P
 L4ng==
X-Gm-Message-State: AO0yUKVh8fFWxxQhy8uQFbUp1MrKlCm118qe7skJoBToJAtDCd+GskG9
 cC68jPtwmXxxKWfKc2C2e2oK7zrEe2DGzTlWh5E=
X-Google-Smtp-Source: AK7set9552GdKOTmZ+tiPEVlGLee/ERxdsxUe3D7HddBqrBIhldF7UjpKsvlmjxDOFDXG2JkBtFdTg1eCUR1gkUJ0ys=
X-Received: by 2002:a50:9995:0:b0:4fa:3c0b:74b with SMTP id
 m21-20020a509995000000b004fa3c0b074bmr4126749edb.3.1679512636925; Wed, 22 Mar
 2023 12:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <167940634187.2718137.10209374282891218398.stgit@firesoul>
 <167940643669.2718137.4624187727245854475.stgit@firesoul>
 <CAKH8qBuv-9TXAmi0oTbB0atC4f6jzFcFhAgQ3D89VX45vUU9hw@mail.gmail.com>
 <080640fc-5835-26f1-2b20-ff079bd59182@redhat.com>
 <CAADnVQKsxzLTZ2XoLbmKKLAeaSyvf3P+w8V143iZ4cEWWTEUfw@mail.gmail.com>
 <CAKH8qBuHaaqnV-_mb1Roao9ZDrEHm+1Cj77hPZSRgwxoqphvxQ@mail.gmail.com>
In-Reply-To: <CAKH8qBuHaaqnV-_mb1Roao9ZDrEHm+1Cj77hPZSRgwxoqphvxQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Mar 2023 12:17:05 -0700
Message-ID: <CAADnVQ+6FeQ97DZLco3OtbtXQvGUAY4nr5tM++6NEDr+u8m7GQ@mail.gmail.com>
To: Stanislav Fomichev <sdf@google.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679512637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zq7Jl3TGbJwfMRCJgFwbgsM8JVMZ+vr7U3sGfe6jsB8=;
 b=IwEJFjUWISTejU0FVnsTrdJHJe6HwK372fdhRbbSA9UYXwB1Bgz77aw/8yVgn2DQ5A
 F6rXGGxKi86YjpcmMYtnebKufUdSIaIVUyZnxArAh6CHPOADa+yUlffw++XpSAxd4E9E
 GVFlY677GTCphhkdyh+uvKjffRznl21AJRM66o5tJprFyzO97+F2/V//Cxd6laqEM7+k
 cFEK/GUJiyE56D6rZXx5wU9FDGyfN4S2mYri3eGl+FIH/Zk7g6J+bu7IyiEQ+NhFNqpY
 TuKUzhtcY6Rbq7f2ym1cuHMu9A2WrMOyAT767LCavF7x9ryAAWlWvPJrF9pwlyAmwrHz
 0ekQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=IwEJFjUW
Subject: Re: [Intel-wired-lan] [PATCH bpf-next V2 3/6] selftests/bpf:
 xdp_hw_metadata RX hash return code info
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: xdp-hints@xdp-project.net, Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Network Development <netdev@vger.kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Song,
 Yoong Siang" <yoong.siang.song@intel.com>,
 Jesper Dangaard Brouer <brouer@redhat.com>, "Ong,
 Boon Leong" <boon.leong.ong@intel.com>, anthony.l.nguyen@intel.com,
 bpf <bpf@vger.kernel.org>, intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
 "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

T24gV2VkLCBNYXIgMjIsIDIwMjMgYXQgMTI6MDDigK9QTSBTdGFuaXNsYXYgRm9taWNoZXYgPHNk
ZkBnb29nbGUuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgTWFyIDIyLCAyMDIzIGF0IDk6MDfigK9B
TSBBbGV4ZWkgU3Rhcm92b2l0b3YKPiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3Jv
dGU6Cj4gPgo+ID4gT24gV2VkLCBNYXIgMjIsIDIwMjMgYXQgOTowNeKAr0FNIEplc3BlciBEYW5n
YWFyZCBCcm91ZXIKPiA+IDxqYnJvdWVyQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPgo+
ID4gPgo+ID4gPiBPbiAyMS8wMy8yMDIzIDE5LjQ3LCBTdGFuaXNsYXYgRm9taWNoZXYgd3JvdGU6
Cj4gPiA+ID4gT24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgNjo0N+KAr0FNIEplc3BlciBEYW5nYWFy
ZCBCcm91ZXIKPiA+ID4gPiA8YnJvdWVyQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Pgo+ID4g
PiA+PiBXaGVuIGRyaXZlciBkZXZlbG9wZXJzIGFkZCBYRFAtaGludHMga2Z1bmNzIGZvciBSWCBo
YXNoIGl0IGlzCj4gPiA+ID4+IHByYWN0aWNhbCB0byBwcmludCB0aGUgcmV0dXJuIGNvZGUgaW4g
YnBmX3ByaW50ayB0cmFjZSBwaXBlIGxvZy4KPiA+ID4gPj4KPiA+ID4gPj4gUHJpbnQgaGFzaCB2
YWx1ZSBhcyBhIGhleCB2YWx1ZSwgYm90aCBBRl9YRFAgdXNlcnNwYWNlIGFuZCBicGZfcHJvZywK
PiA+ID4gPj4gYXMgdGhpcyBtYWtlcyBpdCBlYXNpZXIgdG8gc3BvdCBwb29yIHF1YWxpdHkgaGFz
aGVzLgo+ID4gPiA+Pgo+ID4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBKZXNwZXIgRGFuZ2FhcmQgQnJv
dWVyIDxicm91ZXJAcmVkaGF0LmNvbT4KPiA+ID4gPj4gLS0tCj4gPiA+ID4+ICAgLi4uL3Rlc3Rp
bmcvc2VsZnRlc3RzL2JwZi9wcm9ncy94ZHBfaHdfbWV0YWRhdGEuYyAgfCAgICA5ICsrKysrKy0t
LQo+ID4gPiA+PiAgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEu
YyAgICAgIHwgICAgNSArKysrLQo+ID4gPiA+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+ID4gPj4KPiA+ID4gPj4gZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy94ZHBfaHdfbWV0YWRhdGEuYyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy94ZHBfaHdfbWV0YWRhdGEuYwo+ID4gPiA+PiBp
bmRleCA0MGMxN2FkYmY0ODMuLmNlMDcwMTBlNGQ0OCAxMDA2NDQKPiA+ID4gPj4gLS0tIGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3hkcF9od19tZXRhZGF0YS5jCj4gPiA+ID4+
ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy94ZHBfaHdfbWV0YWRhdGEu
Ywo+ID4gPiA+PiBAQCAtNzcsMTAgKzc3LDEzIEBAIGludCByeChzdHJ1Y3QgeGRwX21kICpjdHgp
Cj4gPiA+ID4+ICAgICAgICAgICAgICAgICAgbWV0YS0+cnhfdGltZXN0YW1wID0gMDsgLyogVXNl
ZCBieSBBRl9YRFAgYXMgbm90IGF2YWlsIHNpZ25hbCAqLwo+ID4gPiA+PiAgICAgICAgICB9Cj4g
PiA+ID4+Cj4gPiA+ID4+IC0gICAgICAgaWYgKCFicGZfeGRwX21ldGFkYXRhX3J4X2hhc2goY3R4
LCAmbWV0YS0+cnhfaGFzaCkpCj4gPiA+ID4+IC0gICAgICAgICAgICAgICBicGZfcHJpbnRrKCJw
b3B1bGF0ZWQgcnhfaGFzaCB3aXRoICV1IiwgbWV0YS0+cnhfaGFzaCk7Cj4gPiA+ID4+IC0gICAg
ICAgZWxzZQo+ID4gPiA+PiArICAgICAgIHJldCA9IGJwZl94ZHBfbWV0YWRhdGFfcnhfaGFzaChj
dHgsICZtZXRhLT5yeF9oYXNoKTsKPiA+ID4gPj4gKyAgICAgICBpZiAocmV0ID49IDApIHsKPiA+
ID4gPj4gKyAgICAgICAgICAgICAgIGJwZl9wcmludGsoInBvcHVsYXRlZCByeF9oYXNoIHdpdGgg
MHglMDhYIiwgbWV0YS0+cnhfaGFzaCk7Cj4gPiA+ID4+ICsgICAgICAgfSBlbHNlIHsKPiA+ID4g
Pj4gKyAgICAgICAgICAgICAgIGJwZl9wcmludGsoInJ4X2hhc2ggbm90LWF2YWlsIGVycm5vOiVk
IiwgcmV0KTsKPiA+ID4gPj4gICAgICAgICAgICAgICAgICBtZXRhLT5yeF9oYXNoID0gMDsgLyog
VXNlZCBieSBBRl9YRFAgYXMgbm90IGF2YWlsIHNpZ25hbCAqLwo+ID4gPiA+PiArICAgICAgIH0K
PiA+ID4gPj4KPiA+ID4gPj4gICAgICAgICAgcmV0dXJuIGJwZl9yZWRpcmVjdF9tYXAoJnhzaywg
Y3R4LT5yeF9xdWV1ZV9pbmRleCwgWERQX1BBU1MpOwo+ID4gPiA+PiAgIH0KPiA+ID4gPj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEuYyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEuYwo+ID4gPiA+PiBp
bmRleCA0MDBiZmUxOWFiZmUuLmYzZWMwN2NjZGM5NSAxMDA2NDQKPiA+ID4gPj4gLS0tIGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3hkcF9od19tZXRhZGF0YS5jCj4gPiA+ID4+ICsrKyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94ZHBfaHdfbWV0YWRhdGEuYwo+ID4gPiA+PiBA
QCAtMyw2ICszLDkgQEAKPiA+ID4gPj4gICAvKiBSZWZlcmVuY2UgcHJvZ3JhbSBmb3IgdmVyaWZ5
aW5nIFhEUCBtZXRhZGF0YSBvbiByZWFsIEhXLiBGdW5jdGlvbmFsIHRlc3QKPiA+ID4gPj4gICAg
KiBvbmx5LCBkb2Vzbid0IHRlc3QgdGhlIHBlcmZvcm1hbmNlLgo+ID4gPiA+PiAgICAqCj4gPiA+
ID4+ICsgKiBCUEYtcHJvZyBicGZfcHJpbnRrIGluZm8gb3V0b3V0IGNhbiBiZSBhY2Nlc3Mgdmlh
Cj4gPiA+ID4+ICsgKiAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL3RyYWNlX3BpcGUKPiA+ID4g
Pgo+ID4gPiA+IHMvb3V0b3V0L291dHB1dC8KPiA+ID4gPgo+ID4gPgo+ID4gPiBGaXhlZCBpbiBW
Mwo+ID4gPgo+ID4gPiA+IEJ1dCBsZXQncyBtYXliZSBkcm9wIGl0PyBJZiB5b3Ugd2FudCB0byBt
YWtlIGl0IG1vcmUgdXNhYmxlLCBsZXQncwo+ID4gPiA+IGhhdmUgYSBzZXBhcmF0ZSBwYXRjaCB0
byBlbmFibGUgdHJhY2luZyBhbmQgcGVyaW9kaWNhbGx5IGR1bXAgaXQgdG8KPiA+ID4gPiB0aGUg
Y29uc29sZSBpbnN0ZWFkIChhcyBwcmV2aW91c2x5IGRpc2N1c3NlZCkuCj4gPiA+Cj4gPiA+IENh
dCdpbmcgL3N5cy9rZXJuZWwvZGVidWcvdHJhY2luZy90cmFjZV9waXBlIHdvcmsgZm9yIG1lIHJl
Z2FyZGxlc3Mgb2YKPiA+ID4gc2V0dGluZyBpbgo+ID4gPiAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFj
aW5nL2V2ZW50cy9icGZfdHJhY2UvYnBmX3RyYWNlX3ByaW50ay9lbmFibGUKPiA+ID4KPiA+ID4g
V2UgbGlrZWx5IG5lZWQgYSBmb2xsb3d1cCBwYXRjaCB0aGF0IGFkZHMgYSBCUEYgY29uZmlnIHN3
aXRjaCB0aGF0IGNhbgo+ID4gPiBkaXNhYmxlIGJwZl9wcmludGsgY2FsbHMsIGJlY2F1c2UgdGhp
cyBhZGRzIG92ZXJoZWFkIGFuZCB0aHVzIGFmZmVjdHMKPiA+ID4gdGhlIHRpbWVzdGFtcHMuCj4g
Pgo+ID4gTm8uIFRoaXMgaXMgYnkgZGVzaWduLgo+ID4gRG8gbm90IHVzZSBicGZfcHJpbnRrKiBp
biBwcm9kdWN0aW9uLgo+Cj4gQnV0IHRoYXQncyBub3QgZm9yIHRoZSBwcm9kdWN0aW9uPyB4ZHBf
aHdfbWV0YWRhdGEgaXMgYSBzbWFsbCB0b29sIHRvCj4gdmVyaWZ5IHRoYXQgdGhlIG1ldGFkYXRh
IGJlaW5nIGR1bXBlZCBpcyBjb3JyZWN0IChkdXJpbmcgdGhlCj4gZGV2ZWxvcG1lbnQpLgo+IFdl
IGhhdmUgYSBwcm9wZXIgKGxlc3MgdmVyYm9zZSkgc2VsZnRlc3QgaW4KPiB7cHJvZ3MscHJvZ190
ZXN0c30veGRwX21ldGFkYXRhLmMgKG92ZXIgdmV0aCkuCj4gVGhpcyB4ZHBfaHdfbWV0YWRhdGEg
d2FzIHN1cHBvc2VkIHRvIGJlIHVzZWQgZm9yIHJ1bm5pbmcgaXQgYWdhaW5zdAo+IHRoZSByZWFs
IGhhcmR3YXJlLCBzbyBoYXZpbmcgYXMgbXVjaCBkZWJ1Z2dpbmcgYXQgaGFuZCBhcyBwb3NzaWJs
ZQo+IHNlZW1zIGhlbHBmdWw/IChhdCBsZWFzdCBpdCB3YXMgaGVscGZ1bCB0byBtZSB3aGVuIHBs
YXlpbmcgd2l0aCBtbHg0KQoKVGhlIG9ubHkgdXNlIG9mIGJwZl9wcmludGsgaXMgZm9yIGRlYnVn
Z2luZyBvZiBicGYgcHJvZ3MgdGhlbXNlbHZlcy4KSXQgc2hvdWxkIG5vdCBiZSB1c2VkIGluIGFu
eSB0b29sLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJ
bnRlbC13aXJlZC1sYW4gbWFpbGluZyBsaXN0CkludGVsLXdpcmVkLWxhbkBvc3Vvc2wub3JnCmh0
dHBzOi8vbGlzdHMub3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLXdpcmVkLWxhbgo=
