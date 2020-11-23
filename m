From: Joe Perches <joe@perches.com>
Date: Mon, 23 Nov 2020 08:32:41 -0800
Subject: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for
 Clang
In-Reply-To: <fc45750b6d0277c401015b7aa11e16cd15f32ab2.camel@HansenPartnership.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>
 <1c7d7fde126bc0acf825766de64bf2f9b888f216.camel@HansenPartnership.com>
 <CANiq72m22Jb5_+62NnwX8xds2iUdWDMAqD8PZw9cuxdHd95W0A@mail.gmail.com>
 <fc45750b6d0277c401015b7aa11e16cd15f32ab2.camel@HansenPartnership.com>
Message-ID: <32dc7423124b51da4e144e931bf099a368ab50a8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2020-11-23 at 07:58 -0800, James Bottomley wrote:
> We're also complaining about the inability to recruit maintainers:
> 
> https://www.theregister.com/2020/06/30/hard_to_find_linux_maintainers_says_torvalds/
> 
> And burn out:
> 
> http://antirez.com/news/129

https://www.wired.com/story/open-source-coders-few-tired/

> What I'm actually trying to articulate is a way of measuring value of
> the patch vs cost ... it has nothing really to do with who foots the
> actual bill.

It's unclear how to measure value in consistency.

But one way that costs can be reduced is by automation and _not_
involving maintainers when the patch itself is provably correct.

> One thesis I'm actually starting to formulate is that this continual
> devaluing of maintainers is why we have so much difficulty keeping and
> recruiting them.

The linux kernel has something like 1500 different maintainers listed
in the MAINTAINERS file.  That's not a trivial number.

$ git grep '^M:' MAINTAINERS | sort | uniq -c | wc -l
1543
$ git grep '^M:' MAINTAINERS| cut -f1 -d'<' | sort | uniq -c | wc -l
1446

I think the question you are asking is about trust and how it
effects development.

And back to that wired story, the actual number of what you might
be considering to be maintainers is likely less than 10% of the
listed numbers above.


