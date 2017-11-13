From: Andi Kleen <ak@linux.intel.com>
Date: Mon, 13 Nov 2017 13:41:48 -0800
Subject: [Intel-wired-lan] CONFIG_DEBUG_INFO_SPLIT impacts on faddr2line
In-Reply-To: <CA+55aFzFUuCniKCutTVNchuhY-bkB=3JkPv46rYwpx1Q0_5n0w@mail.gmail.com>
References: <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CA+55aFx0O+NTbBjavPm_jPucqHdXFYPmUya4kw=ps7LSqTFd5w@mail.gmail.com>
 <20171113011338.3qmnp64pttyscuus@wfg-t540p.sh.intel.com>
 <20171113185227.GM8522@tassilo.jf.intel.com>
 <CA+55aFzbQBPOwah9gQPHR9WL+zZBOXnHsP6GKmC=QE7qOn+psw@mail.gmail.com>
 <20171113201013.GO8522@tassilo.jf.intel.com>
 <CA+55aFzFUuCniKCutTVNchuhY-bkB=3JkPv46rYwpx1Q0_5n0w@mail.gmail.com>
Message-ID: <20171113214148.GP8522@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 13, 2017 at 12:56:31PM -0800, Linus Torvalds wrote:
> On Mon, Nov 13, 2017 at 12:10 PM, Andi Kleen <ak@linux.intel.com> wrote:
> >
> > You're right. It works for line information, but strangely not for
> > inlines. I assume it can be fixed.
> 
> So I'm not 100% sure it's strictly a addr2line bug.

It seems to be broken for normal programs too

$ cat tinline.c

int i;

static inline int finline(void)
{
	i++;
}

main()
{
	finline();
}

$ gcc -O2 -gsplit-dwarf tinline.c
$ addr2line -i -e a.out 0x4003b0
/home/ak/tsrc/tinline.c:6
$ gcc -O2  -g tinline.c
$ addr2line -i -e a.out 0x4003b0
/home/ak/tsrc/tinline.c:6
/home/ak/tsrc/tinline.c:12
$

I filed https://sourceware.org/bugzilla/show_bug.cgi?id=22434


-Andi

