From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 Nov 2017 12:56:31 -0800
Subject: [Intel-wired-lan] CONFIG_DEBUG_INFO_SPLIT impacts on faddr2line
In-Reply-To: <20171113201013.GO8522@tassilo.jf.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CA+55aFx0O+NTbBjavPm_jPucqHdXFYPmUya4kw=ps7LSqTFd5w@mail.gmail.com>
 <20171113011338.3qmnp64pttyscuus@wfg-t540p.sh.intel.com>
 <20171113185227.GM8522@tassilo.jf.intel.com>
 <CA+55aFzbQBPOwah9gQPHR9WL+zZBOXnHsP6GKmC=QE7qOn+psw@mail.gmail.com>
 <20171113201013.GO8522@tassilo.jf.intel.com>
Message-ID: <CA+55aFzFUuCniKCutTVNchuhY-bkB=3JkPv46rYwpx1Q0_5n0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 13, 2017 at 12:10 PM, Andi Kleen <ak@linux.intel.com> wrote:
>
> You're right. It works for line information, but strangely not for
> inlines. I assume it can be fixed.

So I'm not 100% sure it's strictly a addr2line bug.

We do more than just link the vmlinux file. There's that whole
complicated script for our final link in

    scripts/link-vmlinux.sh

which links in all the kallsyms information etc, but also does things
like the exception table sorting.

So it's possible that addr2line works fine on a normal executable, but
that we've done some munging that then makes it not really do the
right thing for vmlinux.

But it is also equally possible that addr2line simply doesn't
understand -gsplit-dwarf at all. I've never seen it used outside the
kernel.

               Linus
