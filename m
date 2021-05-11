From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Tue, 11 May 2021 21:10:28 +0200
Subject: [Intel-wired-lan] [PATCH 5/5] docs: networking: device_drivers:
 fix bad usage of UTF-8 chars
In-Reply-To: <YJrRcgmrqJLSOjR5@casper.infradead.org>
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
 <95eb2a48d0ca3528780ce0dfce64359977fa8cb3.1620744606.git.mchehab+huawei@kernel.org>
 <YJq9abOeuBla3Jiw@lunn.ch> <8735utdt6z.fsf@meer.lwn.net>
 <YJrRcgmrqJLSOjR5@casper.infradead.org>
Message-ID: <20210511211028.557de948@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Em Tue, 11 May 2021 19:48:18 +0100
Matthew Wilcox <willy@infradead.org> escreveu:

> On Tue, May 11, 2021 at 12:24:52PM -0600, Jonathan Corbet wrote:
> > Andrew Lunn <andrew@lunn.ch> writes:
> >   
> > >> -monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
> > >> +monitoring tools such as `ifstat` or `sar -n DEV [interval] [number of samples]`  
> > >
> > > ...
> > >  
> > >>  For example: min_rate 1Gbit 3Gbit: Verify bandwidth limit using network
> > >> -monitoring tools such as ifstat or sar ?n DEV [interval] [number of samples]
> > >> +monitoring tools such as ``ifstat`` or ``sar -n DEV [interval] [number of samples]``  
> > >
> > > Is there a difference between ` and `` ? Does it make sense to be
> > > consistent?  
> > 
> > This is `just weird quotes`  

Gah, sorry for that! I sent a wrong version of this patch...
i40e.rst should also be using:

	monitoring tools such as ``ifstat`` or ``sar -n DEV [interval] [number of samples]`` 

I'll fix it on the next spin.

> 
> umm ... `this` is supposed to be "interpreted text"
> https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#inline-markup
> 
> Maybe we don't actually interpret it.

Well, if we use it as something like :ref:`foo`, it is then interpreted ;-)

using `foo` on Sphinx produces, in practice, the same effect as
``foo`` (at least on the initial versions): it also sets the font to
monospace and stops parsing other markups inside the `interpreted text`
string. 

I remember that, at the very beginning, I did some ReST conversions
using `foo`. Then, I realized that this actually wrong, from the
definition PoV, and started using ``foo``.

> 
> > This is ``literal text`` set in monospace in processed output.
> > 
> > There is a certain tension between those who want to see liberal use of
> > literal-text markup, and those who would rather have less markup in the
> > text overall; certainly, it's better not to go totally nuts with it.  
> 
> I really appreciate the work you did to reduce the amount of
> markup that's needed!

In the specific case of using things like: ``command -n``, I would
put it on a literal block, either like the proposed path, or as:

	monitoring tools such as::

		ifstat

	or::
		sar -n DEV [interval] [number of samples]

ifstat is there using the same monospaced font just for
consistency purposes.

See, if you use just: sar -n

The Sphinx output could convert the hyphen to a dash.

Btw, if there was two hyphens, like: "ifstat --help"

This would be converted into "ifstat ?help", using the EN DASH UTF-8
character.

So, I strongly recommend that programs (specially when followed
by arguments) to always use a literal block markup.


Thanks,
Mauro
