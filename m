From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 8 Jan 2021 16:54:15 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 1/2] net: core: count
 drops from GRO
In-Reply-To: <CANn89iL8KZGQhNbwwYRS2POkc_VEiSCecOyaCF4z95=StRn_xQ@mail.gmail.com>
References: <20210106215539.2103688-1-jesse.brandeburg@intel.com>
 <20210106215539.2103688-2-jesse.brandeburg@intel.com>
 <CANn89iLcRrmXW_MGjuMMnNxWS+kaEnY=Y79hCPuiwiDd_G9=EA@mail.gmail.com>
 <20210108103537.00005168@intel.com>
 <CANn89iL8KZGQhNbwwYRS2POkc_VEiSCecOyaCF4z95=StRn_xQ@mail.gmail.com>
Message-ID: <74aeaa53-90cb-f2af-ede8-a40e92f3af80@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 1/8/2021 10:45 AM, Eric Dumazet wrote:
> On Fri, Jan 8, 2021 at 7:35 PM Jesse Brandeburg
> <jesse.brandeburg@intel.com> wrote:
>>
>> Eric Dumazet wrote:
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -6071,6 +6071,7 @@ static gro_result_t napi_skb_finish(struct napi_struct *napi,
>>>>                 break;
>>>>
>>>>         case GRO_DROP:
>>>> +               atomic_long_inc(&skb->dev->rx_dropped);
>>>>                 kfree_skb(skb);
>>>>                 break;
>>>>
>>>> @@ -6159,6 +6160,7 @@ static gro_result_t napi_frags_finish(struct napi_struct *napi,
>>>>                 break;
>>>>
>>>>         case GRO_DROP:
>>>> +               atomic_long_inc(&skb->dev->rx_dropped);
>>>>                 napi_reuse_skb(napi, skb);
>>>>                 break;
>>>>
>>>
>>>
>>> This is not needed. I think we should clean up ice instead.
>>
>> My patch 2 already did that. I was trying to address the fact that I'm
>> *actually seeing* GRO_DROP return codes coming back from stack.
>>
>> I'll try to reproduce that issue again that I saw. Maybe modern kernels
>> don't have the problem as frequently or at all.
> 
> 
> Jesse, you are sending a patch for current kernels.
> 
> It is pretty clear that the issue you have can not happen with current
> kernels, by reading the code source,
> even without an actual ICE piece of hardware to test this :)
> 

FWIW, I did some digging through the history to see what might have
removed other possible GRO_DROP returns. I found this commit:

6570bc79c0df ("net: core: use listified Rx for GRO_NORMAL in
napi_gro_receive()")

It seems to have modified napi_skb_finish in such a way that it no
longer reports GRO_DROP.

I had trouble finding the other cases where GRO_DROP was removed, but I
also am in favor of just removing it entirely at this point.
