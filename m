From: Andi Kleen <ak@linux.intel.com>
Date: Mon, 13 Nov 2017 15:51:40 -0800
Subject: [Intel-wired-lan] CONFIG_DEBUG_INFO_SPLIT impacts on faddr2line
In-Reply-To: <CA+55aFzEb1qp872nO4Y20cY9WHdek2MC=7XX1xNcN8q1WvTOaw@mail.gmail.com>
References: <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CA+55aFx0O+NTbBjavPm_jPucqHdXFYPmUya4kw=ps7LSqTFd5w@mail.gmail.com>
 <20171113011338.3qmnp64pttyscuus@wfg-t540p.sh.intel.com>
 <20171113185227.GM8522@tassilo.jf.intel.com>
 <CA+55aFzbQBPOwah9gQPHR9WL+zZBOXnHsP6GKmC=QE7qOn+psw@mail.gmail.com>
 <20171113201013.GO8522@tassilo.jf.intel.com>
 <CA+55aFzFUuCniKCutTVNchuhY-bkB=3JkPv46rYwpx1Q0_5n0w@mail.gmail.com>
 <20171113214148.GP8522@tassilo.jf.intel.com>
 <CA+55aFzEb1qp872nO4Y20cY9WHdek2MC=7XX1xNcN8q1WvTOaw@mail.gmail.com>
Message-ID: <20171113235140.GR8522@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> I wonder if there is some way to use the split format for the
> intermediate files, but then for the very final link bring them all in
> and make the end result be a traditional single binary. I'm not
> talking the separate "dwp" package that packs multiple dwo files into
> one, but to actually link them all in at the one.
> 
> Sure, it would lose some of the advantage, but I think a large portion
> of the -gsplit-dwarf advantage is about the intermediate state. No?

Not sure it's worth to do complicated workarounds. I assume
it will be not that difficult to fix binutils (after all
gdb works), and disabling the option is a reasonable workaround.

> 
> I tried to google for it, but couldn't find anything. But apparently
> elfutils doesn't support dwo files either. It seems mainly the linker
> and gdb itself that supports it.

The original design document is

https://gcc.gnu.org/wiki/DebugFission

-Andi
