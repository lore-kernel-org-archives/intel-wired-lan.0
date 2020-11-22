From: Finn Thain <fthain@telegraphics.com.au>
Date: Mon, 23 Nov 2020 09:54:48 +1100 (AEDT)
Subject: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for
 Clang
In-Reply-To: <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2011230938390.7@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On Sun, 22 Nov 2020, Miguel Ojeda wrote:

> 
> It isn't that much effort, isn't it? Plus we need to take into account 
> the future mistakes that it might prevent, too.

We should also take into account optimisim about future improvements in 
tooling.

> So even if there were zero problems found so far, it is still a positive 
> change.
> 

It is if you want to spin it that way.

> I would agree if these changes were high risk, though; but they are 
> almost trivial.
> 

This is trivial:

 case 1:
	this();
+	fallthrough;
 case 2:
 	that();

But what we inevitably get is changes like this:

 case 3:
        this();
+       break;
 case 4:
        hmmm();

Why? Mainly to silence the compiler. Also because the patch author argued 
successfully that they had found a theoretical bug, often in mature code.

But is anyone keeping score of the regressions? If unreported bugs count, 
what about unreported regressions?

> Cheers,
> Miguel
> 
