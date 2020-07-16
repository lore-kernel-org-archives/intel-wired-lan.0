From: Li,Rongqing <lirongqing@baidu.com>
Date: Thu, 16 Jul 2020 05:33:31 +0000
Subject: [Intel-wired-lan] =?utf-8?b?562U5aSNOiAgW2J1ZyA/XSBpNDBlX3J4X2J1?=
 =?utf-8?q?ffer=5Fflip_should_not_be_called_for_redirected_xsk_copy_mode?=
In-Reply-To: <CAJ8uoz3Qrh7gTtsOPiz=Z_vHEk+ZoC35cEZ1audDNu5G5pogZg@mail.gmail.com>
References: <2863b548da1d4c369bbd9d6ceb337a24@baidu.com>
 <CAJ8uoz08pyWR43K_zhp6PsDLi0KE=y_4QTs-a7kBA-jkRQksaw@mail.gmail.com>
 <7aac955840df438e99e6681b0ae5b5b8@baidu.com>
 <CAJ8uoz3Qrh7gTtsOPiz=Z_vHEk+ZoC35cEZ1audDNu5G5pogZg@mail.gmail.com>
Message-ID: <8c3ad8e1f3484d79a09b77170abb5d3f@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > > >
> > > > Thank you RongQing for reporting this. I will take a look at it
> > > > and produce a patch.
> > > >
> > > > /Magnus
> > >
> >
> > Ping
> 
> My apologies RongQing, but it is taking longer than expected due to key people
> being on vacation during this summer period. We are debating weather the
> simple fix you provided covers all cases.
> Hopefully it does, but we just want to make sure. The fix is needed in four
> drivers: the ones you mention plus ice.
> 
> /Magnus

If my RFC patch is suitable for this bug, I will resend it.

should I send four patches for four drivers, or should I send one patch for them?


Thanks

-Li


