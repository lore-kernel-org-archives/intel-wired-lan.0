From: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Date: Tue, 19 Apr 2022 15:37:47 +0200
Subject: [Intel-wired-lan] [PATCH v3] intel: igb: igb_ethtool.c: Convert
 kmap() to kmap_local_page()
In-Reply-To: <Yl3j/bOvoX13WGSW@iweiny-desk3>
References: <20220416111457.5868-1-eng.alaamohamedsoliman.am@gmail.com>
 <alpine.DEB.2.22.394.2204161331080.3501@hadrien>
 <df4c0f81-454d-ab96-1d74-1c4fbc3dbd63@gmail.com>
 <Yl3j/bOvoX13WGSW@iweiny-desk3>
Message-ID: <21796697-e4e1-bf51-76fc-bdb0e28d6b60@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On ???/??/???? ??:??, Ira Weiny wrote:
> On Sat, Apr 16, 2022 at 03:14:57PM +0200, Alaa Mohamed wrote:
>>     On ???/??/???? ??:??, Julia Lawall wrote:
>>
>>
>>   On Sat, 16 Apr 2022, Alaa Mohamed wrote:
>>
>>
>>   Convert kmap() to kmap_local_page()
>>
>>   With kmap_local_page(), the mapping is per thread, CPU local and not
>>   globally visible.
>>
>>   It's not clearer.
>>
>>     I mean this " fix kunmap_local path value to take address of the mapped
>>     page" be more clearer
>>
>>   This is a general statement about the function.  You
>>   need to explain why it is appropriate to use it here.  Unless it is the
>>   case that all calls to kmap should be converted to call kmap_local_page.
>>
>>     It's required to convert all calls kmap to kmap_local_page. So, I don't
>>     what should the commit message be?
>>
>>     Is this will be good :
>>
>>     "kmap_local_page() was recently developed as a replacement for kmap().
>>     The
>>     kmap_local_page() creates a mapping which is restricted to local use by a
>>     single thread of execution. "
>>
> I think I am missing some thread context here.  I'm not sure who said what
> above.  So I'm going to start over.
>
> Alaa,
>
> It is important to remember that a good commit message says 2 things.
>
> 	1) What is the problem you are trying to solve
> 	2) Overview of the solution
>
> First off I understand your frustration.  In my opinion fixes and clean ups
> like this are very hard to write good commit messages for because so often the
> code diff seems so self explanatory.  However, each code change comes at the
> identification of a problem.  And remember that 'problem' does not always mean
> a bug fix.
>
> The deprecation of kmap() may not seem like a problem.  I mean why can't we
> just leave kmap() as it is?  It works right?
>
> But the problem is that the kmap (highmem) interface has become stale and its
> original purpose was targeted toward large memory systems with 32 bit kernels.
> There are very few systems being run like that any longer.
>
> So how do we clean up the kmap interface to be more useful to the kernel
> community now that 32 bit kernels with highmem are so rare?
>
> The community has identified that a first step of that is to move away from and
> eventually remove the kmap() call.  This is due to the call being incorrectly
> used to create long term mappings.  Most calls to kmap() are not used
> incorrectly but those call sites needed something in between kmap() and
> kmap_atmoic().  That call is kmap_local_page().
>
> Now that kmap_local_page() exists the kmap() calls can be audited and most (I
> hope most)[1] can be replaced with kmap_local_page().
>
> The change you have below is correct.  But it lacks a good commit message.  We
> need to cover the 2 points above.
>
> 	1) Julia is asking why you needed to do this change.  What is the
> 	   problem or reason for this change?  (Ira told you to is not a good
> 	   reason.  ;-)
>
> 	   PS In fact me telling you to may actually be a very bad reason...
> 	   j/k ;-)
>
> 	2) Why is this solution ok as part of the deprecation and removal of
> 	   kmap()?
>
> A final note; the 2 above points don't need a lot of text.  Here I used
> 2 simple sentences.
>
> https://lore.kernel.org/lkml/20220124015409.807587-2-ira.weiny at intel.com/
>
> I hope this helps,
> Ira
>
> [1] But not all...  some uses of kmap() have been identified as being pretty
> complex.


Thanks a lot for detailed explaining , yes you help me a lot.


Thanks again,

Alaa

>>   julia
>>
>>
>>   Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
>>   ---
>>   changes in V2:
>>           fix kunmap_local path value to take address of the mapped page.
>>   ---
>>   changes in V3:
>>           edit commit message to be clearer
>>   ---
>>    drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>   diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
>>   index 2a5782063f4c..c14fc871dd41 100644
>>   --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
>>   +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
>>   @@ -1798,14 +1798,14 @@ static int igb_check_lbtest_frame(struct igb_rx_buffer *rx_buffer,
>>
>>           frame_size >>= 1;
>>
>>   -       data = kmap(rx_buffer->page);
>>   +       data = kmap_local_page(rx_buffer->page);
>>
>>           if (data[3] != 0xFF ||
>>               data[frame_size + 10] != 0xBE ||
>>               data[frame_size + 12] != 0xAF)
>>                   match = false;
>>
>>   -       kunmap(rx_buffer->page);
>>   +       kunmap_local(data);
>>
>>           return match;
>>    }
>>   --
>>   2.35.2
