From: H.J. Lu <hjl.tools@gmail.com>
Date: Mon, 13 Nov 2017 12:14:11 -0800
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
Message-ID: <CAMe9rOoeV-Y3gYAEpPXOQuRxxNq2GP-Zwm0Q+sohRduRyXUv7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 13, 2017 at 12:10 PM, Andi Kleen <ak@linux.intel.com> wrote:
>> Put another way: the CONFIG_DEBUG_INFO_SPLIT option is useless. Yes,
>> it saves time and disk space, but does so at the expense of making all
>> the debug information unavailable to basic tools.
>
> You're right. It works for line information, but strangely not for
> inlines. I assume it can be fixed.
>

Is there a binutils bug report for this?


-- 
H.J.
