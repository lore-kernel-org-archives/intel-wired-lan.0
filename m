From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Fri, 21 Sep 2018 16:51:56 +0300
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 00/14] rename and
 shrink i40evf
In-Reply-To: <20180914121727.00003913@intel.com>
References: <20180913223144.75823-1-jesse.brandeburg@intel.com>
 <CAJ3xEMj3OXwz=A5+5JQ0mXoq2OU3N7DP-TpJVMtdTWXZw5tQ9w@mail.gmail.com>
 <20180914121727.00003913@intel.com>
Message-ID: <CAJ3xEMi2HGS+rpEaEc-iuqbrswedKidox7QRNmdgURaoUUqmfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 14, 2018 at 10:17 PM, Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
> On Fri, 14 Sep 2018 12:10:45 +0300 Or wrote:
>> On Fri, Sep 14, 2018 at 1:31 AM, Jesse Brandeburg
>> <jesse.brandeburg@intel.com> wrote:
>> on what HW ring format do you standardize? do i40e/Fortville and
>> ice/what's-the-intel-code-name?  HWs can/use the same posting/completion
>> descriptor?
>
> The initial ring format is the same as used for XL710/X722 devices, and
> planned be supported for the Intel Ethernet E800 series (ice driver) and
> future VF devices using SR-IOV.
>
>> > This solves 2 issues we saw coming or were already present, the
>> > first was constant code duplication happening with i40e/i40evf,
>> > when much of the duplicate code in the i40evf was not used or was
>> > not needed.
>>
>> could you spare few words on the origin/nature of these duplicates? were them
>> just developer C&P mistakes for functionality which is irrelevant for
>> a VF? like what?
>> if not, what was there?
>
> In particular, some of the code was not used at all, but was not caught
> by any automation because it was in a header file and included into
> multiple file scopes.  Other big chunk of the duplicate code was for
> the PF's usage of the communication channel to firmware, which for some
> reason was left in the VF driver code (probably just to avoid changing
> the file) - but the VF driver doesn't communicate to firmware, just to
> the PF.
>
>> > The second was to remove the future confusion of why
>> > future VF devices that were not considered "40GbE" only devices
>> > were supported by i40evf.
>>
>> can elaborate further?
>
> The name i40evf was generating customer questions, and was confusing
> when you add in multiple generations of PF hardware that are no longer
> using the i40e driver.
>
>> > The thought is that iavf will be the virtual function driver for
>> > all future devices, so it should have a "generic" name to propery
>> > represent that it is the VF driver for multiple generations of
>> > devices.
>>
>> for that end,  as I think was explained @ the netdev Tokyo AVF session,
>> you would need a mechanism for feature negotiation, is it here or coming up?
>
> The driver already has it (a feature negotitiation), please see the
> function called iavf_send_vf_config_msg, and follow from where it is
> called.  Basically the VF driver negotiates with the PF for what it can
> do, and the PF guarantees that the base set of features will always
> work, with optional advanced features which the code may/may-not have
> in the future.

got it, same goes to the other replies below/above

>
>> >  41 files changed, 3436 insertions(+), 7581 deletions(-)
>>
>> code diet is cool!
>
> Thanks! ~4000 lines less made me very happy too.
