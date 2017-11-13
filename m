From: Fengguang Wu <fengguang.wu@intel.com>
Date: Mon, 13 Nov 2017 10:22:02 +0800
Subject: [Intel-wired-lan] CONFIG_DEBUG_INFO_SPLIT impacts on faddr2line
In-Reply-To: <1510538727.2418.41.camel@intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CA+55aFx0O+NTbBjavPm_jPucqHdXFYPmUya4kw=ps7LSqTFd5w@mail.gmail.com>
 <20171113011338.3qmnp64pttyscuus@wfg-t540p.sh.intel.com>
 <1510538727.2418.41.camel@intel.com>
Message-ID: <20171113022202.yvkqeiukkc5j5mrd@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[...]
>> > Oh - and talking about "big step forward" - does the 0day robot do
>> > any
>> > suspend/resume testing at all?
>> Yes, we do. CC Rui and Aaron on power testing.
>>
>yes, we have added suspend/resume test in 0day, including both
>functionality and suspend/resume performance. It is not widely run
>because most of the 0Day testboxes are servers/desktops, now we've just
>added some client laptops as testboxes, and will add more in the near
>future. :)
>> >
>> > Even on non-laptop hardware, it should be possible to do something
>> > like
>> >
>> > ???echo platform > /sys/power/pm_test
>> > ???echo freeze > /sys/power/state
>> >
>> > or similar (assuming CONFIG_PM_DEBUG is enabled).
>> >
>
>yes.
>
>I will run native suspend/resume test on laptops and other test boxes
>that really support it, and run suspend/resume test in pm_test modes on
>the others to help us find more issues.

It's a good plan, thanks! Client devices can be much cheaper than servers.
They have more diversities in HW while being more general available.

On the other hand, if there are PM functionalities that can be tested
inside QEMU, it'll be good to have. Since no real HW can be tested as
cheap and extensive as the large amount of VMs.

Thanks,
Fengguang
