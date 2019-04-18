From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 18 Apr 2019 15:40:15 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v1] igb: Fix limiting the
 number of queues to number of cpus
In-Reply-To: <CAKgT0Ud1WkN9OT4ftwzry8Wf2Qwr3h=SwVrsRc9zu_BEg3w0_w@mail.gmail.com>
References: <20190404215632.9881-1-vinicius.gomes@intel.com>
 <461c66428b411644e78ad5a9a44c47442c9b6edf.camel@intel.com>
 <87d0ljhw09.fsf@intel.com>
 <CAKgT0Ud1WkN9OT4ftwzry8Wf2Qwr3h=SwVrsRc9zu_BEg3w0_w@mail.gmail.com>
Message-ID: <878sw7hr8w.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alex,

Alexander Duyck <alexander.duyck@gmail.com> writes:

> On Thu, Apr 18, 2019 at 1:57 PM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Hi Jeff,
>>
>> Jeff Kirsher <jeffrey.t.kirsher@intel.com> writes:
>>
>> > I will discuss the issue with my fellow developers and hopefully we can
>> > come up with a kernel interface that all drivers can use to handle this
>> > issue.
>>
>> Did you have the chance to discuss this issue?
>>
>>
>> Cheers,
>> --
>> Vinicius
>
> Is there any reason why you couldn't just use the "ethtool -L" command
> to change the number of queues after creating the interface instead of
> having to use a module parameter? Just wondering since that would be a
> way to change the number of queues, and it should support values
> greater than the number of CPUs if I am not mistaken.

No reason at all. Just not being able to remember about that ethtool
parameter. It indeed works even when the number of CPUs are less than
the number of HW queues. Thanks a lot.


Cheers,
--
Vinicius
