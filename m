From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 16 Feb 2021 15:30:07 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <CAAOQfrHeqKMhZbJoHrdtOtekucuO7K4ASMwT=fS3WTx1XyhjTA@mail.gmail.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
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
 <CAAOQfrGqcsn3wu5oxzHYxtE8iK3=gFdTka5HSh5Fe9Hc6HWRWA@mail.gmail.com>
 <20210203090232.4a259958@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <874kikry66.fsf@toke.dk>
 <20210210103135.38921f85@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87czx7r0w8.fsf@toke.dk>
 <20210211172603.17d6a8f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAADnVQJ_juVMxSKUvHBEsLNQoJ4mvkqyAV8XF4mmz-dO8saUzQ@mail.gmail.com>
 <CAAOQfrHeqKMhZbJoHrdtOtekucuO7K4ASMwT=fS3WTx1XyhjTA@mail.gmail.com>
Message-ID: <8735xwaxw0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Marek Majtyka <alardam@gmail.com> writes:

> On Fri, Feb 12, 2021 at 3:05 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Thu, Feb 11, 2021 at 5:26 PM Jakub Kicinski <kuba@kernel.org> wrote:
>> >
>> > Perhaps I had seen one too many vendor incompatibility to trust that
>> > adding a driver API without a validation suite will result in something
>> > usable in production settings.
>>
>> I agree with Jakub. I don't see how extra ethtool reporting will help.
>> Anyone who wants to know whether eth0 supports XDP_REDIRECT can already do so:
>> ethtool -S eth0 | grep xdp_redirect
>
> Doing things right can never be treated as an addition. It is the
> other way around. Option -S is for statistics and additionally it can
> show something (AFAIR there wasn't such counter xdp_redirect, it must
> be something new, thanks for the info). But  nevertheless it cannot
> cover all needs IMO.
>
> Some questions worth to consider:
> Is this extra reporting function of statistics clearly documented in
> ethtool? Is this going to be clearly documented? Would it be easier
> for users/admins to find it?
> What about zero copy? Can it be available via statistics, too?
> What about drivers XDP transmit locking flag (latest request from Jesper)?


There is no way the statistics is enough. And saying "just grep for
xdp_redirect in ethtool -S" is bordering on active hostility towards
users.

We need drivers to export explicit features so we can do things like:

- Explicitly reject attaching a program that tries to do xdp_redirect on
  an interface that doesn't support it.

- Prevent devices that don't implement ndo_xdp_xmit() from being
  inserted into a devmap (oh, and this is on thing you can't know at all
  from the statistics, BTW).

- Expose the features in a machine-readable format (like the ethtool
  flags in your patch) so applications can discover in a reliable way
  what is available and do proper fallback if features are missing.

I can accept that we need some kind of conformance test to define what
each flag means (which would be kinda like a selftest for the feature
flags), but we definitely need the feature flags themselves!

-Toke

