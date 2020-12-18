From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Fri, 18 Dec 2020 18:02:53 +0100
Subject: [Intel-wired-lan] Maintainer of ./drivers/dca?
In-Reply-To: <CAPcyv4hqdiLci3xBa=UafJVec_YKZL2aw68DKgUf1RSz8BbFaw@mail.gmail.com>
References: <CAKXUXMx7+DGUc4LLWa+BXAkgrp9bQxCQoo_c98RNxKtw69BTSg@mail.gmail.com>
 <CAPcyv4hqdiLci3xBa=UafJVec_YKZL2aw68DKgUf1RSz8BbFaw@mail.gmail.com>
Message-ID: <CAKXUXMwEp=jfprB9T2vr+GeqBn8KkUFm3iOG2L9MFfUuN-5Cqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Dec 18, 2020 at 5:53 PM Dan Williams <dan.j.williams@intel.com>
wrote:

> To my knowledge DCA is effectively abandoned ever since Chris Leech
> and Shannon Nelson moved on to new roles outside Intel.
>
>
Thanks for the quick response; and too bad to hear that it is abandoned.

But it is good as a potential user relying on that to know that it is not
actively maintained. Maybe that is a motivation to get engaged, build some
basic tests and grow towards becoming a maintainer for that small piece of
code I (and my employer and its customers) could rely on in the future.

If there is no other news, I will send a MAINTAINERS section marking it
orphan for now, so everyone knows the current state.

Lukas


> On Fri, Dec 18, 2020 at 8:32 AM Lukas Bulwahn <lukas.bulwahn@gmail.com>
> wrote:
> >
> > Hi Dan, Hi Jesse, Hi Tony,
> >
> > I was reviewing the MAINTAINERS file and I was trying to understand
> > who is using and maintaining the files in ./drivers/dca, looking at
> > the recent git history and its uses, and I could not confidently say
> > if it is maintained by someone or not.
> >
> > Given Dan's activity a few years ago, Dan, you might be the maintainer
> > and it is just missing a MAINTAINERS section?
> > Or maybe, Jesse, Tony, you are maintaining ./drivers/dca/ as you use
> > that in your IGB and IXGBE network drivers?
> >
> > So, who is maintaining ./drivers/dca/ or is it actually orphaned?
> >
> > I am happy to create and submit a patch to MAINTAINERS with a new
> > entry, once we clarified the status and maintainer of those files.
> >
> > Thanks for your help.
> >
> > Best regards, Merry Christmas and Happy New Year,
> >
> > Lukas
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201218/f24da731/attachment-0001.html>
