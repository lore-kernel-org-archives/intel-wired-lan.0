From: Fengguang Wu <fengguang.wu@intel.com>
Date: Tue, 14 Nov 2017 16:13:36 +0800
Subject: [Intel-wired-lan] CONFIG_DEBUG_INFO_SPLIT impacts on faddr2line
In-Reply-To: <20171113185227.GM8522@tassilo.jf.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CA+55aFx0O+NTbBjavPm_jPucqHdXFYPmUya4kw=ps7LSqTFd5w@mail.gmail.com>
 <20171113011338.3qmnp64pttyscuus@wfg-t540p.sh.intel.com>
 <20171113185227.GM8522@tassilo.jf.intel.com>
Message-ID: <20171114081336.e32bqhcu3eu4yl23@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Andi,

On Mon, Nov 13, 2017 at 10:52:27AM -0800, Andi Kleen wrote:
>> > It's the "CONFIG_DEBUG_INFO_SPLIT" thing that makes faddr2line unable
>> > to see the inlining information,
>> >
>> > Using OPTIMIZE_INLINING is fine.
>>
>> Good to know that!
>
>It works for me. Perhaps your binutils is too old? It was
>added at some point. Can you try upgrading?
>
>% ./linux/scripts/faddr2line obj/vmlinux schedule+10
>schedule+10/0x80:
>schedule at arch/x86/include/asm/current.h:15
>
>% addr2line --version
>GNU addr2line version 2.27-24.fc26

I use debian and tried addr2line in 2 systems:

GNU addr2line (GNU Binutils for Debian) 2.28
GNU addr2line (GNU Binutils for Debian) 2.29.1

Regards,
Fengguang
