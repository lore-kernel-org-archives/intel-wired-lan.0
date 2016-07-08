From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Fri, 8 Jul 2016 17:00:38 +0000
Subject: [Intel-wired-lan] [PATCH] (resend) ixgbe: always initialize
 setup_fc
In-Reply-To: <CAE2NFgVpZoBrNTFV8J3uybuowDj=84nTwgRkta9B0OqGRg-ZDQ@mail.gmail.com>
References: <CAE2NFgXe4uPT1WDVzSq_rr54XA7xDNuedoBgHdtd2_WekNQZ+A@mail.gmail.com>
 <038AE347-E85C-4738-BC91-C8C16AE88620@intel.com>
 <87618083B2453E4A8714035B62D679925066EACF@FMSMSX105.amr.corp.intel.com>
 <CAD=hENdLDK6Odi=oV2CNsoKR2_z4tM3oSSgtaA0yiyofErwrog@mail.gmail.com>
 <CAE2NFgVpZoBrNTFV8J3uybuowDj=84nTwgRkta9B0OqGRg-ZDQ@mail.gmail.com>
Message-ID: <87618083B2453E4A8714035B62D679925066EC02@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Patrick McLean [mailto:patrickm at gaikai.com]
>Sent: Friday, July 08, 2016 9:45 AM
>To: zhuyj <zyjzyj2000@gmail.com>
>Cc: Tantilov, Emil S <emil.s.tantilov@intel.com>; Rustad, Mark D
><mark.d.rustad@intel.com>; netdev <netdev@vger.kernel.org>; intel-wired-lan
><intel-wired-lan@lists.osuosl.org>
>Subject: Re: [Intel-wired-lan] [PATCH] (resend) ixgbe: always initialize
>setup_fc
>
>How about just initializing it when the rest of the struct is
>initialized? This is what is done for every other model.

That works as well.

Thanks,
Emil

