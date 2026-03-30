Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD2A1061B1B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 30 Mar 2026 19:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D862440B6E;
	Mon, 30 Mar 2026 19:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jCtkLomCe2Jd; Mon, 30 Mar 2026 19:16:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B18E940B7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774898214;
	bh=DjSXt8h6HpJNtuZl8APzR6n2jIhEIuL+a7wJqt0K78A=;
	h=From:Date:In-Reply-To:Cc:To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=geAPYvvTCzt8HU2DwgX2brzhtJ3EdF/mGVHBSA0GnnxmF+nnGhFbdx1t36K5G49R+
	 T118Z2BvGSSzx1JHpSQNeyRdrf46bX7EaUOCgU938uToXEAXsiUUIXt7U76Egrp7rj
	 u0bMXoCLNDQn765c5cPeXvvIc1rwfSN+bQs/17orDG3rcE+phAP6WiIrqiQZ7lwOmu
	 MPapazTCbnt5PO5qDGDuQBRu0kA4j4GAuXCTtcfpYSi5RKQGONUkeU/XzyLLd9EzVs
	 /I8qrhBm/cTg/QMwDUz4Itb6LB+/ntHt0SRIJnRFVGGnUEdOEnyA8jOnisDfkjZK9Z
	 ExNxJV1D6k8FA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B18E940B7D;
	Mon, 30 Mar 2026 19:16:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E3ED73A4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Mar 2026 19:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA33D4055A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Mar 2026 19:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mKEJ_IvC5Jf9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 30 Mar 2026 19:16:51 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com;
 envelope-from=bob@vanvalzah.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0512340206
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0512340206
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0512340206
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Mar 2026 19:16:50 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8c9f6b78ca4so664311185a.0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Mar 2026 12:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774898209; x=1775503009;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DjSXt8h6HpJNtuZl8APzR6n2jIhEIuL+a7wJqt0K78A=;
 b=q/lDFCWjqW9p9ARyhv4Otsb7FW0nuhjZWraxLc9MiGaT1gCy2j5fvXdrcKNMFEPT7Q
 LVMifw360w0f4sMGrlE3L8C4XHos/2OD5tjz8KdEfpYCiJn01BKO3lohKvkCKxvSUpDU
 JE6Hvdgi1nUfWbEndh4nG921cBPWiFTji467q6Zc2gC3Yq/RTaUCmlpUu6rMu4R512V6
 lCXYYJJob64Ru+E5F4qb4QQaWLe5r8eNETFtLedVg9UXfqdLrf+LaWcNqmrYfbdf4nNG
 yZOhOc/rzBMtpK6JUAMNU2xduSQSsJRZ3IhykvjwhCcKVB+752qyVh7u75LXPNjV2LHA
 /fVA==
X-Gm-Message-State: AOJu0YxLq6NRbj/Su0DAmOM0fwtpfXgHbWVuF3/ZipOTBZIAjEML2i69
 keLgMeAWv63AP4hRXqnwiilXeeCf7PyleY+3+JyJ4Ig1cr92OYnzNoSSTj5BLg2CZB78rC383os
 Z3opFNbk=
X-Gm-Gg: ATEYQzzJXNrB2qVoF8q/W/2tg1whKf6t9uOa2DiGAIRcbdGsMVpDhu0XAPAzjm4EnUy
 78pSBQEdGeG8sjFbwz8v9uK7ciw1Eily6rn3LGunCNxp1q594a9jKzAejj94jwbMAxFHk9Eels5
 YBfFe32642FIGUiFLh2bEivWMYkmL27QmnjrNgl2CX8C9KDZhJQbirFB3dfy1mQJl0WYHuaCjg4
 gkHdFfFzaACXivMBu/0osavdoXVn+dkykldEn6GvvFVYXzKDT6nFiArQ2raHwDA/R10/ImnKZhB
 o9fmGwXSNXBkDTwjQnO/SgVAbgSKDDdr6lkVSVBUf/webrqpQuqUeQfnnkn/dEi/V95XAWEafC/
 0+W/OHPvQeyC3GjGnOJtkdW6bKEddVpeBnDaswz95CLW4qkedVKBzPHeMdio8CUzGyJ2A0L8AQC
 EAqAI=
X-Received: by 2002:a05:620a:4593:b0:8cd:942e:82e6 with SMTP id
 af79cd13be357-8d01c600b99mr1822022285a.18.1774898209314; 
 Mon, 30 Mar 2026 12:16:49 -0700 (PDT)
Received: from smtpclient.apple ([75.104.94.42])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d027db4770sm795472885a.0.2026.03.30.12.16.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2026 12:16:48 -0700 (PDT)
From: Bob Van Valzah <bob@vanvalzah.com>
Message-Id: <CD9DC8D4-25AF-4329-881D-86ADBC9ECF73@vanvalzah.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_FA8CFCD5-4254-4834-BF82-D5E4AFFB41A4"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Date: Mon, 30 Mar 2026 14:16:28 -0500
In-Reply-To: <65977d5b-16eb-418c-995e-6a918f67707a@linux.dev>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, julianstj@fb.com, jeff@jeffgeerling.com
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <D1C3B3DF-960F-40C7-BBD7-994359F0C8AD@vanvalzah.com>
 <65977d5b-16eb-418c-995e-6a918f67707a@linux.dev>
X-Mailer: Apple Mail (2.3864.400.21)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vanvalzah-com.20230601.gappssmtp.com; s=20230601; t=1774898209; x=1775503009;
 darn=lists.osuosl.org; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DjSXt8h6HpJNtuZl8APzR6n2jIhEIuL+a7wJqt0K78A=;
 b=A5aqtMwxVeB+/PKJ6eQ+ddOuA1lv8rTBbi+jpKO2rPPkyeGexa0sX7xWx3G24r3YRe
 80pFKZXsVcLt6GV6a2Hkzu/GcyoRkuTAOjkfYe3jJD6QuntCxyFnECvOMG/BDPikeguD
 /F6YWMDAJGVXHUlOXlTrAO3FkRdjkfC5UgJHuYm4T0qlUwROHgH7qIIHM3h0Wvd3q02M
 GPPOgr7TGza8JDeOF8oHGYJRbKWqymA7Ko4lGO7mfTSn7lua8j6HvpShabAQf+hh2Gol
 kiGN5Xis1O/BrRJNiWcIt6JHd14A77bLjoNgv7hYsB1hisf9JBKn0A3ye3DS59HhtKSZ
 Crqw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=vanvalzah.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=vanvalzah-com.20230601.gappssmtp.com
 header.i=@vanvalzah-com.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=A5aqtMwx
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix Tx timestamp timeout caused
 by unlocked TIMINCA write in adj fine
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


--Apple-Mail=_FA8CFCD5-4254-4834-BF82-D5E4AFFB41A4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks for following up Vadim. To be clear, we do not see our patch as a =
solution to the problem, since it does not eliminate the underlying =
contention, it just reduces the likelihood.

We now have a bit more hands-on time running the patch and can see its =
limitations. The driver just throws the timeout error less often. =
Moreover, our code calling adjfine() has to be ready for an EBUSY. The =
patch is certainly not an elegant solution. It may well have worked =
better, or perhaps been a complete fix, if we had taken tmreg_lock. =
Sorry if our report was premature.

We think the contention happens when a system call made by a clock =
disciplining daemon like ts2phc changes a PHC's frequency, while a =
timestamping daemon like ptp4l has requested a timestamp against that =
same PHC. A plausible explanation is that the hardware fails to produce =
a timestamp for a packet when it collides with a PHC frequency =
adjustment, leading to the timestamp timeout. We see this contention =
128x more often than the average user because we cranked our PTP sync =
rate up to 128 Hz. We care about every ns here.

Sorry, in retrospect, we may have overstated our case in declaring the =
root cause as the lack of locking, since our locking only reduces the =
likelihood of the timestamp timeout. Intel may provide insight to the =
underlying cause of the timeout, but my hunch is that the collision of a =
timestamp request against a PHC and a frequency change of the same PHC =
causes the timestamp request to fail, leading to the timeout. Our repro =
code makes this happen so reliably that it should be easy for the =
hardware guys to explain exactly what=E2=80=99s going on. Hopefully, =
they can advise on a more elegant avoidance strategy than our ham-handed =
lock.

We have not tried recovering a timestamp following the error. We may =
have used the term =E2=80=9Ccorrupted=E2=80=9D poorly here. Since the =
error message says =E2=80=9Ctimeout," that could mean the hardware =
produced no timestamp at all, rather than a corrupted one.

This isn=E2=80=99t a show-stopper for us, but we note that timekeeping =
daemons with imperfect error handling could react to this situation =
poorly and perhaps fail silently.

	Bob

> On Mar 30, 2026, at 11:39=E2=80=AFAM, Vadim Fedorenko =
<vadim.fedorenko@linux.dev> wrote:
>=20
> On 29/03/2026 04:25, Bob Van Valzah wrote:
>> Hi,
>> We found a race in igc_ptp_adjfine_i225() that causes "Tx timestamp
>> timeout" errors and eventually wedges EXTTS when a PTP grandmaster
>> (ptp4l with hardware timestamping) runs concurrently with PHC
>> frequency discipline (any GPSDO calling clock_adjtime ADJ_FREQUENCY).
>> Root cause: igc_ptp_adjfine_i225() writes IGC_TIMINCA without holding
>> any lock.  Every other PTP clock operation in igc_ptp.c (adjtime,
>> gettime, settime) holds tmreg_lock, but adjfine does not.  When the
>> increment rate changes while the hardware is capturing a TX =
timestamp,
>> the captured value is corrupt.  The driver retries for
>> IGC_PTP_TX_TIMEOUT (15s), then logs the timeout and frees the skb.
>> Repeated occurrences eventually prevent EXTTS from delivering events.
>> The attached reproducer (triggers in ~17 seconds on i226):
>>   One thread calling clock_adjtime(ADJ_FREQUENCY) at ~200k/s on the
>>   PHC, another sending UDP packets with SO_TIMESTAMPING requesting
>>   hardware TX timestamps at ~100k/s.  A Python reproducer is at:
>>   =
https://github.com/bobvan/PePPAR-Fix/blob/main/tools/igc_tx_timeout_repro.=
py
>>   At realistic rates (1 Hz adjfine from a GPSDO + ptp4l at 128 Hz
>>   sync), the race triggers in ~30 minutes.
>> The attached patch holds ptp_tx_lock around the TIMINCA write and
>> skips the write if any TX timestamps are pending (tx_tstamp[i].skb
>> !=3D NULL), returning -EBUSY.  This doesn't fully close the hardware
>> race (a new TX capture can start between the check and the write),
>> but at realistic rates the residual probability gives ~25 year MTBF
>> vs ~30 minutes without the patch.
>> A complete fix would likely require either disabling TX timestamping
>> around TIMINCA writes (via TSYNCTXCTL), or making the timeout =
recovery
>> path more robust so a single corrupt timestamp doesn't wedge the
>> subsystem.  We'd welcome guidance from the igc maintainers on the
>> preferred approach.
>> Tested on:
>>   - Intel i226 (TimeHAT v5 board on Raspberry Pi 5)
>>   - Kernel 6.12.62+rpt-rpi-2712 (Raspberry Pi OS)
>>   - Intel out-of-tree igc driver 5.4.0-7642.46
>>   - Stock upstream igc_ptp.c (same code, same bug)
>> 	Bob
>> ---
>>  drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c =
b/drivers/net/ethernet/intel/igc/igc_ptp.c
>> index XXXXXXX..XXXXXXX 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
>> @@ -47,8 +47,10 @@ static int igc_ptp_adjfine_i225(struct =
ptp_clock_info *ptp, long scaled_ppm)
>>  {
>>         struct igc_adapter *igc =3D container_of(ptp, struct =
igc_adapter,
>>                                                ptp_caps);
>>         struct igc_hw *hw =3D &igc->hw;
>> +       unsigned long flags;
>>         int neg_adj =3D 0;
>>         u64 rate;
>>         u32 inca;
>> +       int i;
>>         if (scaled_ppm < 0) {
>>                 neg_adj =3D 1;
>> @@ -63,7 +65,21 @@ static int igc_ptp_adjfine_i225(struct =
ptp_clock_info *ptp, long scaled_ppm)
>>         if (neg_adj)
>>                 inca |=3D ISGN;
>> -       wr32(IGC_TIMINCA, inca);
>> +       /* Changing the clock increment rate while a TX timestamp is =
being
>> +        * captured by the hardware can corrupt the timestamp, =
causing the
>> +        * driver to report "Tx timestamp timeout" and eventually =
wedging
>> +        * the EXTTS subsystem.  Serialize with pending TX =
timestamps:
>> +        * skip the rate change if any are in flight.
>> +        */
>> +       spin_lock_irqsave(&igc->ptp_tx_lock, flags);
>> +       for (i =3D 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>> +               if (igc->tx_tstamp[i].skb) {
>> +                       spin_unlock_irqrestore(&igc->ptp_tx_lock, =
flags);
>> +                       return -EBUSY;
>> +               }
>> +       }
>> +       wr32(IGC_TIMINCA, inca);
>> +       spin_unlock_irqrestore(&igc->ptp_tx_lock, flags);
>=20
> It's a bit weird solution, because in this case we may end up having =
no
> successful calls to adjfine with high amount of TX timestamp packets =
in flight. Another problem here is that access to timing registers is
> guarded by tmreg_lock, but here you use ptp_tx_lock, which protects
> queue.
>=20
> Were you able to recover "corrupted" time stamps to figure out why =
they
> are discarded?
>=20
>=20
>>         return 0;
>>  }
>> --
>> 2.39.2


--Apple-Mail=_FA8CFCD5-4254-4834-BF82-D5E4AFFB41A4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">Thanks for following up Vadim. To be =
clear, we do not see our patch as a solution to the problem, since it =
does not eliminate the underlying contention, it just reduces the =
likelihood.<div><br></div><div>We now have a bit more hands-on time =
running the patch and can see its limitations. The driver just throws =
the timeout error less often. Moreover, our code calling adjfine() has =
to be ready for an EBUSY. The patch is certainly not an elegant =
solution. It may well have worked better, or perhaps been a complete =
fix, if we had taken tmreg_lock. Sorry if our report was =
premature.<div><br></div><div>We think the contention happens when a =
system call made by a clock disciplining daemon like ts2phc changes a =
PHC's frequency, while a timestamping daemon like ptp4l has requested a =
timestamp against that same PHC. A plausible explanation is that the =
hardware fails to produce a timestamp for a packet when it collides with =
a PHC frequency adjustment, leading to the timestamp timeout. We see =
this contention 128x more often than the average user because we cranked =
our PTP sync rate up to 128 Hz. We care about every ns =
here.</div><div><br></div><div>Sorry, in retrospect, we may have =
overstated our case in declaring the root cause as the lack of locking, =
since our locking only reduces the likelihood of the timestamp timeout. =
Intel may provide insight to the underlying cause of the timeout, but my =
hunch is that the collision of a timestamp request against a PHC and a =
frequency change of the same PHC causes the timestamp request to fail, =
leading to the timeout. Our repro code makes this happen so reliably =
that it should be easy for the hardware guys to explain exactly what=E2=80=
=99s going on. Hopefully, they can advise on a more elegant avoidance =
strategy than our ham-handed lock.</div><div><br></div><div>We have not =
tried recovering a timestamp following the error. We may have used the =
term =E2=80=9Ccorrupted=E2=80=9D poorly here. Since the error message =
says =E2=80=9Ctimeout," that could mean the hardware produced no =
timestamp at all, rather than a corrupted =
one.</div><div><br></div><div>This isn=E2=80=99t a show-stopper for us, =
but we note that timekeeping daemons with imperfect error handling could =
react to this situation poorly and perhaps fail =
silently.</div><div><br></div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>Bob<br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On Mar 30, 2026, at 11:39=E2=80=AFAM, Vadim Fedorenko =
&lt;vadim.fedorenko@linux.dev&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On 29/03/2026 04:25, Bob Van Valzah =
wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;">Hi,<br>We found a race in igc_ptp_adjfine_i225() that causes "Tx =
timestamp<br>timeout" errors and eventually wedges EXTTS when a PTP =
grandmaster<br>(ptp4l with hardware timestamping) runs concurrently with =
PHC<br>frequency discipline (any GPSDO calling clock_adjtime =
ADJ_FREQUENCY).<br>Root cause: igc_ptp_adjfine_i225() writes IGC_TIMINCA =
without holding<br>any lock. &nbsp;Every other PTP clock operation in =
igc_ptp.c (adjtime,<br>gettime, settime) holds tmreg_lock, but adjfine =
does not. &nbsp;When the<br>increment rate changes while the hardware is =
capturing a TX timestamp,<br>the captured value is corrupt. &nbsp;The =
driver retries for<br>IGC_PTP_TX_TIMEOUT (15s), then logs the timeout =
and frees the skb.<br>Repeated occurrences eventually prevent EXTTS from =
delivering events.<br>The attached reproducer (triggers in ~17 seconds =
on i226):<br>&nbsp;&nbsp;One thread calling clock_adjtime(ADJ_FREQUENCY) =
at ~200k/s on the<br>&nbsp;&nbsp;PHC, another sending UDP packets with =
SO_TIMESTAMPING requesting<br>&nbsp;&nbsp;hardware TX timestamps at =
~100k/s. &nbsp;A Python reproducer is =
at:<br>&nbsp;&nbsp;https://github.com/bobvan/PePPAR-Fix/blob/main/tools/ig=
c_tx_timeout_repro.py<br>&nbsp;&nbsp;At realistic rates (1 Hz adjfine =
from a GPSDO + ptp4l at 128 Hz<br>&nbsp;&nbsp;sync), the race triggers =
in ~30 minutes.<br>The attached patch holds ptp_tx_lock around the =
TIMINCA write and<br>skips the write if any TX timestamps are pending =
(tx_tstamp[i].skb<br>!=3D NULL), returning -EBUSY. &nbsp;This doesn't =
fully close the hardware<br>race (a new TX capture can start between the =
check and the write),<br>but at realistic rates the residual probability =
gives ~25 year MTBF<br>vs ~30 minutes without the patch.<br>A complete =
fix would likely require either disabling TX timestamping<br>around =
TIMINCA writes (via TSYNCTXCTL), or making the timeout recovery<br>path =
more robust so a single corrupt timestamp doesn't wedge =
the<br>subsystem. &nbsp;We'd welcome guidance from the igc maintainers =
on the<br>preferred approach.<br>Tested on:<br>&nbsp;&nbsp;- Intel i226 =
(TimeHAT v5 board on Raspberry Pi 5)<br>&nbsp;&nbsp;- Kernel =
6.12.62+rpt-rpi-2712 (Raspberry Pi OS)<br>&nbsp;&nbsp;- Intel =
out-of-tree igc driver 5.4.0-7642.46<br>&nbsp;&nbsp;- Stock upstream =
igc_ptp.c (same code, same bug)<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>Bob<br>---<br>&nbsp;drivers/net/ethernet/intel/igc/igc_ptp.c | 18 =
+++++++++++++++++-<br>&nbsp;1 file changed, 17 insertions(+), 1 =
deletion(-)<br>diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c =
b/drivers/net/ethernet/intel/igc/igc_ptp.c<br>index XXXXXXX..XXXXXXX =
100644<br>--- a/drivers/net/ethernet/intel/igc/igc_ptp.c<br>+++ =
b/drivers/net/ethernet/intel/igc/igc_ptp.c<br>@@ -47,8 +47,10 @@ static =
int igc_ptp_adjfine_i225(struct ptp_clock_info *ptp, long =
scaled_ppm)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
struct igc_adapter *igc =3D container_of(ptp, struct =
igc_adapter,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;ptp_caps);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct =
igc_hw *hw =3D &amp;igc-&gt;hw;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unsigned long =
flags;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int neg_adj =3D =
0;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;u64 =
rate;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;u32 inca;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int =
i;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (scaled_ppm =
&lt; 0) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;neg_adj =3D 1;<br>@@ -63,7 +65,21 @@ static =
int igc_ptp_adjfine_i225(struct ptp_clock_info *ptp, long =
scaled_ppm)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(neg_adj)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;inca |=3D ISGN;<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;wr32(IGC_TIMINCA, inca);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Changing the clock increment rate =
while a TX timestamp is being<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* captured by the hardware can =
corrupt the timestamp, causing the<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* driver to report "Tx =
timestamp timeout" and eventually wedging<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* the EXTTS subsystem. =
&nbsp;Serialize with pending TX timestamps:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* skip the rate change if any =
are in flight.<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;spin_lock_irqsave(&amp;igc-&gt;ptp_tx_=
lock, flags);<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for (i =3D 0; i =
&lt; IGC_MAX_TX_TSTAMP_REGS; i++) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;if (igc-&gt;tx_tstamp[i].skb) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;spin_unlock_irqr=
estore(&amp;igc-&gt;ptp_tx_lock, flags);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
-EBUSY;<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;}<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;wr32(IGC_TIMINCA, inca);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;spin_unlock_irqrestore(&amp;igc-&gt;pt=
p_tx_lock, flags);<br></blockquote><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">It's a bit weird solution, because in this =
case we may end up having no</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">successful calls to adjfine with high =
amount of TX timestamp packets in flight. Another problem here is that =
access to timing registers is</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">guarded by tmreg_lock, but here you use =
ptp_tx_lock, which protects</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">queue.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Were you able to recover "corrupted" time =
stamps to figure out why they</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">are discarded?</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
0;<br>&nbsp;}<br>--<br>2.39.2</blockquote></div></blockquote></div><br></d=
iv></div></body></html>=

--Apple-Mail=_FA8CFCD5-4254-4834-BF82-D5E4AFFB41A4--
