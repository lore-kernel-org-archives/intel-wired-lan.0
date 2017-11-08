From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Nov 2017 10:05:50 -0800
Subject: [Intel-wired-lan] [vlan_device_event] BUG: unable to handle
 kernel paging request at 6b6b6ccf
In-Reply-To: <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
Message-ID: <CA+55aFxohPiat5DpPqfxiJqvChKqq=giL-FMPbbVPkdcP49SEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 8, 2017 at 9:12 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
>
> OK. Here is the original faddr2line output:
>
> $ ~/linux/scripts/faddr2line vmlinux vlan_device_event+0x7f5/0xa40
> vlan_device_event+0x7f5/0xa40:
> vlan_device_event at net/8021q/vlan.h:60

Hmm. Yes, that's not what I hoped for.

> I notice that this trace shows no additional inline files at all.
> Is it because I did some kconfig option wrong, so that inline info is
> lost? Eg.
>
> CONFIG_OPTIMIZE_INLINING=y (reading lib/Kconfig.debug, it looks better set  to N)
> CONFIG_DEBUG_INFO_REDUCED=y
> CONFIG_DEBUG_INFO_SPLIT=y

Hmm. It might also be a compiler/linker issue. Debug info is sadly
often a second class citizen, because it's generally not something
that gets tested nearly as much as the actual _code_ that a compiler
generates.

So we've certainly had issues before with incomplete debug info.

That said, I'm not sure how well that CONFIG_DEBUG_INFO_SPLIT works,
I've only ever tested with

  CONFIG_DEBUG_INFO=y
  CONFIG_DEBUG_INFO_REDUCED=y
  # CONFIG_DEBUG_INFO_SPLIT is not set
  # CONFIG_DEBUG_INFO_DWARF4 is not set

which was the config that my scheduler example was generated from.

It might be an issue with the particular version of 'addr2line' too,
for all I know. The one I have is

    GNU addr2line version 2.27-24.fc26

and who knows what else could influence it. I *thought* that as long
as you just had DEBUG_INFO enabled, it would automatically be ok, but
I was clearly wrong.

> [  745.719623] BUG: unable to handle kernel paging request at 6b6b6f4f
> [  745.732871] IP: vlan_device_event+0x7f5/0xa40:
> vlan_device_event at net/8021q/vlan.h:60

Ok, at least now there's no lost information, even if it doesn't have
that nice inlining information that I was hoping for.

              Linus
