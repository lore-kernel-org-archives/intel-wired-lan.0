From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 4 Jun 2018 11:07:38 -0700
Subject: [Intel-wired-lan] [net-queue PATCH] ixgbe: Move ipsec init
 function to before reset call
In-Reply-To: <4b8f422b-b694-6729-709d-647d44148e7c@oracle.com>
References: <20180604162312.79628.37984.stgit@ahduyck-green-test.jf.intel.com>
 <4b8f422b-b694-6729-709d-647d44148e7c@oracle.com>
Message-ID: <CAKgT0Ue6C38xpHpT42o0A0yhpcR-z03k4fPo_Ts9UiMWtWyKsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jun 4, 2018 at 10:34 AM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> On 6/4/2018 9:24 AM, Alexander Duyck wrote:
>>
>> This patch moves the ipsec init function in ixgbe_sw_init. This way it is
>> a
>> bit more consistent with the placement of similar initialization functions
>> and is placed before the reset_hw call which should allow us to clean up
>> any link issues that may be introduced by the fact that we force the link
>> up if somehow the device had ipsec still enabled before the driver was
>> loaded.
>>
>> Fixes: 49a94d74d948 ("ixgbe: add ipsec engine start and stop routines")
>> Reported-by: Andre Tomt <andre@tomt.net>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> ---
>
>
> NAK - this won't work for the simple reason that the netdev feature flags
> that ixgbe_init_ipsec_offload() sets will get bashed later when probe()
> starts setting netdev feature flags.

Yeah, I realized that after I started doing any testing. I was already
working on a v2 to address that as we could pull the feature bit
setting out and place it with the other features and only enable it
based on if adapter->ipsec is set or not.

> The call to stop the engine in the init is probably unnecessary, I really
> put it there to be sure that no crap was left lying around from before the
> driver was started.  This can probably be removed to address Alex's timing
> worries.

Actually I think we just need to look at moving this to a spot before
the reset_hw call. My thought is if we place it here, and add the bit
for setting the feature bits later we can probably resolve most of the
issues.

Also it just occurred to me that we will always report link as being
down where the function is called since the watchdog hasn't had a
chance to start yet.

> We really need a way to check the SEC_EN or ENCRYPTION_EN pins to see if the
> chip has it supported.  The alternative is to do a quick check to see if we
> can write to SECTXCTRL.SECTX_DIS and SECRXCTRL.SECRX_DIS to clear those
> bits.  Since I don't know how to check the pin values, I'll work up a
> sequence to check the SECTXCTRL bits for writability.
>
> sln

Actually I'm wondering if we couldn't just get away with testing the
SECTXCTRL.TX_DIS and SECRXCTRL.RX_DIS bits instead. If I am
understanding your function correctly I think it is leaving those bits
set, and from what I can tell it looks like in the case of hardware
with the functionality disabled those bits might be read-only. If so
that might be a good way for us to test the functionality as disabled
by us, versus disabled by that bit may differ in those bits.

- Alex
