From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 8 Nov 2017 22:34:10 -0800
Subject: [Intel-wired-lan] [vlan_device_event] BUG: unable to handle
 kernel paging request at 6b6b6ccf
In-Reply-To: <20171109031206.x6ta5ysdalf3lk3s@wfg-t540p.sh.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CAKgT0UfSTwTsQFP9ir=aOJDz-BvYONBd3Q6SOJWQherkQ8XpFQ@mail.gmail.com>
 <20171109031206.x6ta5ysdalf3lk3s@wfg-t540p.sh.intel.com>
Message-ID: <CAM_iQpXJ1cqJKkp9X1-56gUi4V_s7Gbx_GPo=rgXzJ_LwY+v7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 8, 2017 at 7:12 PM, Fengguang Wu <fengguang.wu@intel.com> wrote:
> Hi Alex,
>
>> So looking over the trace the panic seems to be happening after a
>> decnet interface is getting deleted. Is there any chance we could try
>> compiling the kernel without decnet support to see if that is the
>> source of these issues? I don't know if anyone on the Intel Wired Lan
>> team is testing with that enabled so if we can eliminate that as a
>> possible cause that would be useful.
>
>
> Sure and thank you for the suggestion!
>
> It looks disabling DECNET still triggers the vlan_device_event BUG.
> However when looking at the dmesgs, I find another warning just before
> the vlan_device_event BUG. Not sure if it's related one or independent
> now-fixed issue.

Those decnet symbols are probably noises.

How do you reproduce it? And what is your setup? Vlan device on
top of your eth0 (e1000)?
