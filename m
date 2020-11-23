From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Nov 2020 15:05:31 +0100
Subject: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for
 Clang
In-Reply-To: <alpine.LNX.2.23.453.2011230938390.7@nippy.intranet>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>
 <alpine.LNX.2.23.453.2011230938390.7@nippy.intranet>
Message-ID: <CANiq72=z+tmuey9wj3Kk7wX5s0hTHpsQdLhAqcOVNrHon6xn5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Nov 22, 2020 at 11:54 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> We should also take into account optimisim about future improvements in
> tooling.

Not sure what you mean here. There is no reliable way to guess what
the intention was with a missing fallthrough, even if you parsed
whitespace and indentation.

> It is if you want to spin it that way.

How is that a "spin"? It is a fact that we won't get *implicit*
fallthrough mistakes anymore (in particular if we make it a hard
error).

> But what we inevitably get is changes like this:
>
>  case 3:
>         this();
> +       break;
>  case 4:
>         hmmm();
>
> Why? Mainly to silence the compiler. Also because the patch author argued
> successfully that they had found a theoretical bug, often in mature code.

If someone changes control flow, that is on them. Every kernel
developer knows what `break` does.

> But is anyone keeping score of the regressions? If unreported bugs count,
> what about unreported regressions?

Introducing `fallthrough` does not change semantics. If you are really
keen, you can always compare the objects because the generated code
shouldn't change.

Cheers,
Miguel
