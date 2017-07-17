From: Greg Edwards <gedwards@ddn.com>
Date: Mon, 17 Jul 2017 17:06:31 -0600
Subject: [Intel-wired-lan] [PATCH 3/3] igb: do not drop PF mailbox lock
 after read of VF message
In-Reply-To: <CAKgT0UdRfaxcy6FodbJojENpUA+Fi7YY39EbKvm5PUQB_G_52Q@mail.gmail.com>
References: <20170628152226.25369-1-gedwards@ddn.com>
 <20170628152226.25369-4-gedwards@ddn.com>
 <CAKgT0UdRfaxcy6FodbJojENpUA+Fi7YY39EbKvm5PUQB_G_52Q@mail.gmail.com>
Message-ID: <20170717230631.GA24395@psuche>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jul 14, 2017 at 09:03:50PM -0700, Alexander Duyck wrote:
> On Wed, Jun 28, 2017 at 8:22 AM, Greg Edwards <gedwards@ddn.com> wrote:
>> When the PF receives a mailbox message from the VF, it grabs the mailbox
>> lock, reads the VF message from the mailbox, ACKs the message and drops
>> the lock.
>>
>> While the PF is performing the action for the VF message, nothing
>> prevents another VF message from being posted to the mailbox.  The
>> current code handles this condition by just dropping any new VF messages
>> without processing them.  This results in a mailbox timeout in the VM
>> for posted messages waiting for an ACK, and the VF is reset by the
>> igbvf_watchdog_task in the VM.
>>
>> Given the right sequence of VF messages and mailbox timeouts, this
>> condition can go on ad infinitum.
>>
>> Modify the PF mailbox read method to take an 'unlock' argument that
>> optionally leaves the mailbox locked by the PF after reading the VF
>> message.  This ensures another VF message is not posted to the mailbox
>> until after the PF has completed processing the VF message and written
>> its reply.
>
> I really don't like the design of this patch. It is fixing the PF for
> a VF bug. The VF should not be sending multiple messages to the PF at
> the same time. In the case of the Linux VF anyway there should be the
> RTNL to prevent multiple messages from being sent. If we are sending
> multiple messages at the same time from the VF it points at a bug in
> the VF, not the PF driver.

Sure, I can look at fixing it in the VF driver, if that would be the
preferred approach.  The I350 datasheet made it sound like the PF should
be able to handle this condition (Section 7.8.2.9.1 "VF to PF Mailbox"),
but I realize that may be implementation specific.

Greg
