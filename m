From: Marek Majtyka <alardam@gmail.com>
Date: Tue, 5 Jan 2021 12:56:30 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <6f8c23d4ac60525830399754b4891c12943b63ac.camel@kernel.org>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com> <878sad933c.fsf@toke.dk>
 <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
 <20201207230755.GB27205@ranger.igk.intel.com>
 <5fd068c75b92d_50ce20814@john-XPS-13-9370.notmuch>
 <20201209095454.GA36812@ranger.igk.intel.com> <20201209125223.49096d50@carbon>
 <e1573338-17c0-48f4-b4cd-28eeb7ce699a@gmail.com>
 <1e5e044c8382a68a8a547a1892b48fb21d53dbb9.camel@kernel.org>
 <cb6b6f50-7cf1-6519-a87a-6b0750c24029@gmail.com>
 <f4eb614ac91ee7623d13ea77ff3c005f678c512b.camel@kernel.org>
 <d5be0627-6a11-9c1f-8507-cc1a1421dade@gmail.com>
 <6f8c23d4ac60525830399754b4891c12943b63ac.camel@kernel.org>
Message-ID: <CAAOQfrHN1-oHmbOksDv-BKWv4gDF2zHZ5dTew6R_QTh6s_1abg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I would like to thank you for your time, comments, nitpicking as well
as encouraging.

One thing needs clarification I think, that is, that those flags
describe driver static feature sets - which are read-only. They have
nothing in common with driver runtime configuration change yet.
Runtime change of this state can be added but it needs a new variable
and it can be done later on if someone needs it.

Obviously, it is not possible to make everybody happy, especially with
XDP_BASE flags set. To be honest, this XDP_BASE definition is a
syntactic sugar for me and I can live without it. We can either remove
it completely, from
which IMO we all and other developers will suffer later on, or maybe
we can agree on these two helper set of flags: XDP_BASE (TX, ABORTED,
PASS, DROP) and XDP_LIMITED_BASE(ABORTED,PASS_DROP).
What do you think?

I am also going to add a new XDP_REDIRECT_TARGET flag and retrieving
XDP flags over rtnelink interface.

I also think that for completeness, ethtool implementation should be
kept  together with rtnelink part in order to cover both ip and
ethtool tools. Do I have your approval or disagreement? Please let me know.

Both AF_XDP_ZEROCOPY and XDP_SOCK_ZEROCOPY are good to me. I will pick
the one XDP_SOCK_ZEROCOPY unless there are protests.

I don't think that HEADROOM parameter should be passed via the flags.
It is by nature a number and an attempt to quantize with flags seems
to be an unnatural limitation for the future.

Thanks
Marek
