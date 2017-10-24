From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 24 Oct 2017 13:02:35 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: add array bounds check
In-Reply-To: <87618083B2453E4A8714035B62D67992B40BDA94@FMSMSX105.amr.corp.intel.com>
References: <1508772111-4527-1-git-send-email-paul.greenwalt@intel.com>
 <CAKgT0UczobrvbRFoRDxa+B-PW733uJ=kJfd0YoK83=cC9RAXEA@mail.gmail.com>
 <87618083B2453E4A8714035B62D67992B40BD9E1@FMSMSX105.amr.corp.intel.com>
 <CAKgT0UdMAJC7UTDfeyEcCsrhKd3_YotCMfn8XkbOXiTONejTcQ@mail.gmail.com>
 <87618083B2453E4A8714035B62D67992B40BDA94@FMSMSX105.amr.corp.intel.com>
Message-ID: <CAKgT0UdnVziF6LrP9EJJVh+ZjrsvpuwO5uzysan5psf0Q0V97A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 24, 2017 at 12:48 PM, Tantilov, Emil S
<emil.s.tantilov@intel.com> wrote:
>>-----Original Message-----
>>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>>Behalf Of Alexander Duyck
>>Sent: Tuesday, October 24, 2017 11:49 AM
>>To: Tantilov, Emil S <emil.s.tantilov@intel.com>
>>Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>
>>Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: add array bounds check
>>
>>On Tue, Oct 24, 2017 at 10:44 AM, Tantilov, Emil S
>><emil.s.tantilov@intel.com> wrote:
>>>>-----Original Message-----
>>>>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>>>>Behalf Of Alexander Duyck
>>>>Sent: Tuesday, October 24, 2017 9:20 AM
>>>>To: Greenwalt, Paul <paul.greenwalt@intel.com>
>>>>Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>
>>>>Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: add array bounds check
>>>>
>>>>On Mon, Oct 23, 2017 at 8:21 AM, Paul Greenwalt
>>>><paul.greenwalt@intel.com> wrote:
>>>>> Add bounds check for index fcoe_i of rx_ring array.
>>>>>
>>>>> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
>>>>> ---
>>>>>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
>>>>b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
>>>>> index a23c2b5..5772fe2 100644
>>>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
>>>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
>>>>> @@ -698,6 +698,8 @@ void ixgbe_configure_fcoe(struct ixgbe_adapter
>>>>*adapter)
>>>>>                 }
>>>>>
>>>>>                 fcoe_i = fcoe->offset + (i % fcoe->indices);
>>>>> +               if (fcoe_i >= MAX_RX_QUEUES)
>>>>> +                       fcoe_i = MAX_RX_QUEUES - 1;
>>>>
>>>>Instead of using MAX_RX_QUEUES why use fcoe->limit? If I am not
>>>>mistake the upper limit is either 8 or 32 for the FCoE redirection
>>>>table anyway so odds are you can't even use 64 queues if you wanted
>>>>to. From what I can tell the only advantage of the approach you are
>>>>using now is that you don't potentially zero out the value when it
>>>>gets hit with the mask below.
>>>>
>>>>>                 fcoe_i &= IXGBE_FCRETA_ENTRY_MASK;
>>>
>>> Actually the check is added to protect from accessing rx_ring[fcoe_i]
>>beyond
>>> it's boundaries. The above line was supposed to be removed. This is
>>because
>>> IXGBE_FCRETA_ENTRY_MASK = 0x7f, and static checkers report possible
>>out of
>>> bounds issue.
>>>
>>> Thanks,
>>> Emil
>>
>>So is this actually fixing a bug, or just making some static analysis
>>tool happy? If it is about a static analysis tool I would stay just
>>identify it as a false hit since this value should be configured and
>>limited by the code in ixgbe_lib.c that is configuring the offset and
>>indices.
> It's a bit of both in my opinion since the line limiting the value of fcoe_i:
>
>         fcoe_i &= IXGBE_FCRETA_ENTRY_MASK;
>
> Is clearly wrong since IXGBE_FCRETA_ENTRY_MASK exceeds MAX_RX_QUEUES.
>
> Why even do this if we are sure that the limits are enforced in some other part
> of the code?

That is a very good question. Odds are that line isn't the correct
solution for this either. The thing we need to mask is actually fcoe_q
which isn't defined until a few lines lower down.

We should probably just be making certain that fcoe->offset +
fcoe->indices cannot exceed the maximum ring size which I think we
already do. We would probably be better off handling/verifying this is
occuring in ixgbe_lib.c where we configure RING_F_FCOE.

- Alex
