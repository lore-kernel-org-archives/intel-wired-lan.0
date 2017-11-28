From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 28 Nov 2017 10:24:52 +0100
Subject: [Intel-wired-lan] [PATCH for-4.14.y 0/5] e1000e: Upstream fixes
 for linux-4.14.y
In-Reply-To: <CAMi1Hd1nhFjKS6YKsFjBehk5xCxn14f43-uEUDHt59q5uxCkug@mail.gmail.com>
References: <1511787217-10987-1-git-send-email-amit.pundir@linaro.org>
 <20171127125903.GB13615@kroah.com>
 <CAMi1Hd1nhFjKS6YKsFjBehk5xCxn14f43-uEUDHt59q5uxCkug@mail.gmail.com>
Message-ID: <20171128092452.GE7891@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 27, 2017 at 06:39:47PM +0530, Amit Pundir wrote:
> + Jeff and intel-wired-lan (moderated) mailing list.
> 
> On 27 November 2017 at 18:29, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Mon, Nov 27, 2017 at 06:23:32PM +0530, Amit Pundir wrote:
> >> Hi Greg,
> >>
> >> Found few e100e upstream fixes from Benjamin Poirier in lede
> >> source tree, https://git.lede-project.org/?p=source.git, and
> >> these fixes seem reasonable enough for 4.14.y too.
> >>
> >> Also submitting an e1000e buffer overrun fix by Sasha Neftin.
> >>
> >> Cherry-picked and build tested for linux v4.14.2 for ARCH=arm/arm64.
> >
> >
> > Any reason you did not cc: the maintainers for this driver and their
> > mailing list?
> 
> No reason at all. Thanks for pointing that out. It didn't occur to me
> to do that. I was marking only patch authors in cover letters so far.
> I'll start adding respective maintainers and mailing list going
> forward.

Thanks, please do that.  All now queued up.

greg k-h
