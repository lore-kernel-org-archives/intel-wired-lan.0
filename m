From: Marek Majtyka <alardam@gmail.com>
Date: Wed, 3 Feb 2021 13:50:59 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <20210202113456.30cfe21e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <878sad933c.fsf@toke.dk> <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
 <20201207230755.GB27205@ranger.igk.intel.com>
 <5fd068c75b92d_50ce20814@john-XPS-13-9370.notmuch>
 <20201209095454.GA36812@ranger.igk.intel.com>
 <20201209125223.49096d50@carbon>
 <e1573338-17c0-48f4-b4cd-28eeb7ce699a@gmail.com>
 <1e5e044c8382a68a8a547a1892b48fb21d53dbb9.camel@kernel.org>
 <cb6b6f50-7cf1-6519-a87a-6b0750c24029@gmail.com>
 <f4eb614ac91ee7623d13ea77ff3c005f678c512b.camel@kernel.org>
 <d5be0627-6a11-9c1f-8507-cc1a1421dade@gmail.com>
 <6f8c23d4ac60525830399754b4891c12943b63ac.camel@kernel.org>
 <CAAOQfrHN1-oHmbOksDv-BKWv4gDF2zHZ5dTew6R_QTh6s_1abg@mail.gmail.com>
 <87h7mvsr0e.fsf@toke.dk>
 <CAAOQfrHA+-BsikeQzXYcK_32BZMbm54x5p5YhAiBj==uaZvG1w@mail.gmail.com>
 <87bld2smi9.fsf@toke.dk>
 <20210202113456.30cfe21e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CAAOQfrGqcsn3wu5oxzHYxtE8iK3=gFdTka5HSh5Fe9Hc6HWRWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Feb 2, 2021 at 8:34 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 02 Feb 2021 13:05:34 +0100 Toke H?iland-J?rgensen wrote:
> > Marek Majtyka <alardam@gmail.com> writes:
> >
> > > Thanks Toke,
> > >
> > > In fact, I was waiting for a single confirmation, disagreement or
> > > comment. I have it now. As there are no more comments, I am getting
> > > down to work right away.
> >
> > Awesome! And sorry for not replying straight away - I hate it when I
> > send out something myself and receive no replies, so I suppose I should
> > get better at not doing that myself :)
> >
> > As for the inclusion of the XDP_BASE / XDP_LIMITED_BASE sets (which I
> > just realised I didn't reply to), I am fine with defining XDP_BASE as a
> > shortcut for TX/ABORTED/PASS/DROP, but think we should skip
> > XDP_LIMITED_BASE and instead require all new drivers to implement the
> > full XDP_BASE set straight away. As long as we're talking about
> > features *implemented* by the driver, at least; i.e., it should still be
> > possible to *deactivate* XDP_TX if you don't want to use the HW
> > resources, but I don't think there's much benefit from defining the
> > LIMITED_BASE set as a shortcut for this mode...
>
> I still have mixed feelings about these flags. The first step IMO
> should be adding validation tests. I bet^W pray every vendor has
> validation tests but since they are not unified we don't know what
> level of interoperability we're achieving in practice. That doesn't
> matter for trivial feature like base actions, but we'll inevitably
> move on to defining more advanced capabilities and the question of
> "what supporting X actually mean" will come up (3 years later, when
> we don't remember ourselves).

I am a bit confused now. Did you mean validation tests of those XDP
flags, which I am working on or some other validation tests?
What should these tests verify? Can you please elaborate more on the
topic, please - just a few sentences how are you see it?
