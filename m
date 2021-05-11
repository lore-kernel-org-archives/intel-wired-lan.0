From: Matthew Wilcox <willy@infradead.org>
Date: Tue, 11 May 2021 19:48:18 +0100
Subject: [Intel-wired-lan] [PATCH 5/5] docs: networking: device_drivers:
 fix bad usage of UTF-8 chars
In-Reply-To: <8735utdt6z.fsf@meer.lwn.net>
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
 <95eb2a48d0ca3528780ce0dfce64359977fa8cb3.1620744606.git.mchehab+huawei@kernel.org>
 <YJq9abOeuBla3Jiw@lunn.ch> <8735utdt6z.fsf@meer.lwn.net>
Message-ID: <YJrRcgmrqJLSOjR5@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 11, 2021 at 12:24:52PM -0600, Jonathan Corbet wrote:
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> >> -monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
> >> +monitoring tools such as `ifstat` or `sar -n DEV [interval] [number of samples]`
> >
> > ...
> >
> >>  For example: min_rate 1Gbit 3Gbit: Verify bandwidth limit using network
> >> -monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
> >> +monitoring tools such as ``ifstat`` or ``sar -n DEV [interval] [number of samples]``
> >
> > Is there a difference between ` and `` ? Does it make sense to be
> > consistent?
> 
> This is `just weird quotes`

umm ... `this` is supposed to be "interpreted text"
https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#inline-markup

Maybe we don't actually interpret it.

> This is ``literal text`` set in monospace in processed output.
> 
> There is a certain tension between those who want to see liberal use of
> literal-text markup, and those who would rather have less markup in the
> text overall; certainly, it's better not to go totally nuts with it.

I really appreciate the work you did to reduce the amount of
markup that's needed!
