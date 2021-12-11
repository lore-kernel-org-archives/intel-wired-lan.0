From: Stefan Dietrich <roots@gmx.de>
Date: Sat, 11 Dec 2021 10:50:30 +0100
Subject: [Intel-wired-lan] [PATCH] igc: Avoid possible deadlock during
 suspend/resume
In-Reply-To: <87h7bgrn0j.fsf@intel.com>
References: <87r1awtdx3.fsf@intel.com>
 <20211201185731.236130-1-vinicius.gomes@intel.com>
 <5a4b31d43d9bf32e518188f3ef84c433df3a18b1.camel@gmx.de>
 <87o85yljpu.fsf@intel.com>
 <063995d8-acf3-9f33-5667-f284233c94b4@leemhuis.info>
 <8e59b7d6b5d4674d5843bb45dde89e9881d0c741.camel@gmx.de>
 <5c5b606a-4694-be1b-0d4b-80aad1999bd9@leemhuis.info>
 <d4c9bb101aa79c5acaaa6dd7b42159fb0c91a341.camel@gmx.de>
 <87h7bgrn0j.fsf@intel.com>
Message-ID: <6bcce8e66fde064fd2879e802970bb4a8f382743.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

thanks a lot - that patch fixed it! Both "normal" shutdown as well as
ifdown/ifup are working without issues now if CONFIG_PCIE_PTM is
enabled in the kernel config.

I've done a DSL download/upload speed comparison against my current
5.14.0-19.2 and did not see any performance differences outside margin
of error. I currently have no other Linux machine I could use for iperf
but I will report if I encounter any issues.

As I am not familiar with the kernel development procedure: can you
give a rough estimate when we may expect this patch in the stable
branch?


Thanks again,
Stefan



On Fri, 2021-12-10 at 16:41 -0800, Vinicius Costa Gomes wrote:
> Hi Stefan,
>
> Stefan Dietrich <roots@gmx.de> writes:
>
> > Agreed and thanks for the pointers; please see the log files and
> > .config attached as requested.
> >
>
> Thanks for the logs.
>
> Very interesting that the initialization of the device is fine, so
> it's
> something that happens later.
>
> Can you test the attached patch?
>
> If the patch works, I would also be interested if you notice any loss
> of
> functionality with your NIC. (I wouldn't think so, as far as I know,
> i225-V models have PTM support but don't have any PTP support).
>
> > Cheers,
> > Stefan
> >
> >
> > On Fri, 2021-12-10 at 15:01 +0100, Thorsten Leemhuis wrote:
> > > On 10.12.21 14:45, Stefan Dietrich wrote:
> > > > thanks for keeping an eye on the issue. I've sent the files in
> > > > private
> > > > because I did not want to spam the mailing lists with them.
> > > > Please
> > > > let
> > > > me know if this is the correct procedure.
>
> Cheers,

