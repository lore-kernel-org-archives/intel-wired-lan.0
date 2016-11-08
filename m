From: Ray Bellis <ray@isc.org>
Date: Tue, 8 Nov 2016 16:31:26 +0000
Subject: [Intel-wired-lan] i40e performance regression after 1.3.9 ?
In-Reply-To: <9BBC4E0CF881AA4299206E2E1412B626502D1704@ORSMSX102.amr.corp.intel.com>
References: <9f9f62ec-fbce-534a-d2bd-e918a03a3899@isc.org>
 <CAKgT0Uc9W_tvMEoKzLzBG-pK7Sjznr3B+xgjne0tUuTX17d+Hg@mail.gmail.com>
 <fe40bb83-d28c-8fc4-148a-37ff7ad5c7aa@isc.org>
 <CAKgT0UfB-ofJw6gA2f-FJvBcn-4Qd52DrQuth828xWkp8+WSDg@mail.gmail.com>
 <aea231d5-64bb-97e7-57f6-cf845629d9ef@isc.org>
 <9BBC4E0CF881AA4299206E2E1412B626502D1704@ORSMSX102.amr.corp.intel.com>
Message-ID: <9948372e-4093-4ce3-ee3e-aa06d2a7a939@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 08/11/2016 16:05, Wyborny, Carolyn wrote:

> Thanks for this info Ray.  This narrows it down a lot.  I'll be
> looking closely at the adaptive-itr mechanism for some improvements.
> In the 1.3.38 version, it was not actually enabled.  The i40e hw's
> ITR feature is different than our other parts.  I wanted to confirm
> something though.  Are you still seeing variability in the
> non-adaptive ITR settings  on your client system?

If I upgrade to anything beyond 1.3.9 in the client system I seem to be
unable to maintain the original packet rates regardless of adapter settings.

With default settings, immediately after loading the 1.3.38 driver:

1478621396.881368: 391141.759023
1478621397.882212: 354922.445456
1478621398.883211: 416478.937541
1478621399.884240: 430534.979506
1478621400.885273: 422226.839675
1478621401.886212: 422115.633420

I then turned off adaptive-rx and -tx (note that this is the same test
as the second set of figures from my previous email)

1478622609.157284: 1328728.765727
1478622610.158216: 1308772.224287
1478622611.159251: 1332014.365132
1478622612.160215: 1282047.106589
1478622613.161251: 1269727.562246
1478622614.162212: 1152071.858944
1478622615.163212: 1291263.736264
1478622616.164220: 1260214.703579
1478622617.165220: 1336847.152847
1478622618.166216: 1087381.967560
1478622619.167211: 1260368.932912
1478622620.168214: 1312834.227270
1478622621.169253: 1000005.993772
1478622622.170286: 1320425.999942

For unknown reasons it's producing higher figures than my run from this
morning (UK time) but the variability is still very high.  This time
it's averaging 1.2 Mpps (still down from 1.35) but earlier it was more
like 930 kpps.

[one possible difference is that the client machine was rebooted in
between.  FWIW, both machines are using the default Haswell intel_pstate
frequency governer in powersave mode.  I can change that to
'performance' with a specified range if necessary]

If there's a specific sequence of tests you'd like me to make, please
let me know.

Ray


