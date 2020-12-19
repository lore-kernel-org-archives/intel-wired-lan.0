From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 19 Dec 2020 12:59:18 -0800
Subject: [Intel-wired-lan] ixgbe: 5.10.0 kernel regression for 2.5Gbps
 link negotiation?
In-Reply-To: <MN2PR11MB361416A8BFB904EC0149C178EFC20@MN2PR11MB3614.namprd11.prod.outlook.com>
References: <7bb485c3-9556-d9f1-e70f-a4b3a05909c9@candelatech.com>
 <BYAPR11MB3606E48BA821185142354D67EFC30@BYAPR11MB3606.namprd11.prod.outlook.com>
 <3bcba0ca-8f3b-8428-861a-86aaff1688b6@molgen.mpg.de>
 <c54c8f2c-a295-c691-466e-07ae8f41b0ac@candelatech.com>
 <3c8510fb-af8c-b5f9-2af1-64584a667ac8@molgen.mpg.de>
 <BYAPR11MB36060F3889C66AE55092DA01EFC20@BYAPR11MB3606.namprd11.prod.outlook.com>
 <86fb482f-81b0-8a5f-1580-ed5b6f13c743@molgen.mpg.de>
 <MN2PR11MB361416A8BFB904EC0149C178EFC20@MN2PR11MB3614.namprd11.prod.outlook.com>
Message-ID: <CAHk-=wiCOBCW-eKVuag6FOjarYnYAG8E2Rak2Qn2=qYJBjCTgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Dec 19, 2020 at 8:07 AM Fujinaka, Todd <todd.fujinaka@intel.com> wrote:
>
> I am stripping the maintainers because they're on the mailing list already and multiple copies of the same email means they get annoyed and likely ignore the email.

Don't do that. This is what "Message-ID" is for. People don't get
multiple copies of the email, because any sane MUA will see that they
are the same message even when they came in through two different
paths.

Of course, if some maintainer has a broken MUA, that's one thing, but
I would expect kernel maintainers that deal with a lot of email to not
have quite _that_ broken a setup.

            Linus
