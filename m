From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 14:03:02 -0600
Subject: [Intel-wired-lan] [PATCH 0/7] [RESEND] [net] intel: Use smp_rmb
 rather than read_barrier_depends
In-Reply-To: <20171116113358.00001d5a@intel.com>
References: <1510846675-15169-1-git-send-email-brking@linux.vnet.ibm.com>
 <20171116113358.00001d5a@intel.com>
Message-ID: <f360a8cd-518c-1df5-5ffd-91a0e9688ce2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/16/2017 01:33 PM, Jesse Brandeburg wrote:
> On Thu, 16 Nov 2017 09:37:48 -0600
> Brian King <brking@linux.vnet.ibm.com> wrote:
> 
>> Resending as the first attempt is not showing up in the list archive.
>>
>> This patch converts several network drivers to use smp_rmb
>> rather than read_barrier_depends. The initial issue was
>> discovered with ixgbe on a Power machine which resulted
>> in skb list corruption due to fetching a stale skb pointer.
>> More details can be found in the ixgbe patch description.
> 
> Thanks for the fix Brian, I bet it was a tough debug.
> 
> The only users in the entire kernel of read_barrier_depends() (not
> smp_read_barrier_depends) are the Intel network drivers.
> 
> Wouldn't it be better for power to just fix read_barrier_depends to do
> the right thing on power? The question I'm not sure of the answer to is:
> Is it really the wrong barrier to be using or is the implementation in
> the kernel powerpc wrong?
> 
> So I think the right thing might actually to be to:
> Fix arch powerpc read_barrier_depends to not be a noop, as the
> semantics of the read_barrier_depends seems to be sufficient to solve
> this problem, but it seems not to work for powerpc?

Jesse,

Thanks for the quick response.

Cc'ing linuxppc-dev as well. 

I did think about changing the powerpc definition of read_barrier_depends,
but after reading up on that barrier, decided it was not the correct barrier
to be used in this context. Here is some good historical background on
read_barrier_depends that I found, along with an example.

https://lwn.net/Articles/5159/

Since there is no data-dependency in the code in question here, I think
the smp_rmb is the proper barrier to use.

For background, the code in question looks like this:

CPU 1                                   CPU2
============================            ============================
1: ixgbe_xmit_frame_ring                ixgbe_clean_tx_irq
2:  first->skb = skb                     eop_desc = tx_buffer->next_to_watch
                                         if (!eop_desc)
                                             break;
3:  ixgbe_tx_map                         read_barrier_depends()
                                         if (!(eop_desc->wb.status) ... )
                                             break;
4:   wmb                                 
5:   first->next_to_watch = tx_desc      napi_consume_skb(tx_buffer->skb ..);
6:   writel(i, tx_ring->tail);

What we see on powerpc is that tx_buffer->skb on CPU2 is getting loaded
prior to tx_buffer->next_to_watch. Changing the read_barrier_depends
to a smp_rmb solves this and prevents us from dereferencing old pointer.

-Brian


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

