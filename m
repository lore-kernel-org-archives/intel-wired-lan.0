From: Dan Streetman <dan.streetman@canonical.com>
Date: Mon, 2 Oct 2017 09:31:46 -0400
Subject: [Intel-wired-lan] i40e MDD events
In-Reply-To: <CAOZ2QJOQLyUzQa=E6QYjmGKcn7P9BL3N8OhUrJicRjTpr5Dp6g@mail.gmail.com>
References: <CAOZ2QJPbOrGLoZWnZUY268owFsFxFq-UcdYLbUn1Kf7tzE9oHg@mail.gmail.com>
 <9BBC4E0CF881AA4299206E2E1412B6265A15909B@ORSMSX102.amr.corp.intel.com>
 <CAOZ2QJOQLyUzQa=E6QYjmGKcn7P9BL3N8OhUrJicRjTpr5Dp6g@mail.gmail.com>
Message-ID: <CAOZ2QJPHqPftMdWYfAM01grFehCyrySXy6VwhP2pCE+98rmkkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 29, 2017 at 8:17 AM, Dan Streetman
<dan.streetman@canonical.com> wrote:
> On Thu, Sep 28, 2017 at 7:27 PM, Wyborny, Carolyn
> <carolyn.wyborny@intel.com> wrote:
>>> -----Original Message-----
>>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>>> Behalf Of Dan Streetman
>>> Sent: Thursday, September 28, 2017 1:53 PM
>>> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
>>> <jeffrey.t.kirsher@intel.com>; Duyck, Alexander H
>>> <alexander.h.duyck@intel.com>
>>> Subject: [Intel-wired-lan] i40e MDD events
>>>
>>> Hi, I'm from Canonical support, and I have reports from an Ubuntu user
>>> seeing MDD events occurring on a i40e nic, from the PF (not a VF)
>>> while using the Ubuntu 4.4 kernel.  I found two commits that I thought
>>> addressed this problem, but they did not help - the reporter still is
>>> seeing MDD events, which reset the PF for every MDD event.  The
>>> commits I thought fixed this, which have been added but still don't
>>> fix the MDD events, are:
>>>
>>
>> Hello Dan,
>>
>> What is the firmware version on the device?
>
> it's running 5.05
>
>>  ethtool -i output or dmesg log should provide it.  I believe the device needs a fw update.   They are available  on our download center here:  https://downloadcenter.intel.com/download/24769
>> A fw update will usually require a driver update as well, but the fw version info from the user will help with this determination.
>
> I see you just added a new 6.01 fw a little over a month ago, is there
> a known fw problem related to this that 6.01 fixes?  I'll ask them to
> update anyway, to see if it helps.

unfortunately the updated firmware did not help; an MDD event happened
again after upgrading to 6.01.

>
> Can you answer my questions about specifically what events in the NIC
> will cause it to generate a MDD, and specifically what does MDD event
> "2" indicate?

It there any possibility to get more info about the MDD event details?
 Like what specifically the NIC didn't like?

>
>>
>> Thanks,
>>
>> Carolyn
>>
>> Carolyn Wyborny
>> Linux Development
>> Networking Division
>> Intel Corporation
>>
>>
