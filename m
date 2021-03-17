From: Gustavo A. R. Silva <gustavo@embeddedor.com>
Date: Wed, 17 Mar 2021 12:27:28 -0500
Subject: [Intel-wired-lan] [PATCH][next] ixgbe: Fix out-of-bounds
 warning in ixgbe_host_interface_command()
In-Reply-To: <CAG48ez2RDqKwx=umOHjo_1mYyNQgzvcP=KOw1HgSo4Prs_VQDw@mail.gmail.com>
References: <20210317064148.GA55123@embeddedor>
 <CAG48ez2RDqKwx=umOHjo_1mYyNQgzvcP=KOw1HgSo4Prs_VQDw@mail.gmail.com>
Message-ID: <3bd8d009-2ad2-c24d-5c34-5970c52502de@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jann,

Please, see my comments below...

On 3/17/21 12:11, Jann Horn wrote:
> On Wed, Mar 17, 2021 at 8:43 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
>> Fix the following out-of-bounds warning by replacing the one-element
>> array in an anonymous union with a pointer:
>>
>>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_common.o
>> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c: In function ?ixgbe_host_interface_command?:
>> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:3729:13: warning: array subscript 1 is above array bounds of ?u32[1]? {aka ?unsigned int[1]?} [-Warray-bounds]
>>  3729 |   bp->u32arr[bi] = IXGBE_READ_REG_ARRAY(hw, IXGBE_FLEX_MNG, bi);
>>       |   ~~~~~~~~~~^~~~
>> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:3682:7: note: while referencing ?u32arr?
>>  3682 |   u32 u32arr[1];
>>       |       ^~~~~~
>>
>> This helps with the ongoing efforts to globally enable -Warray-bounds.
>>
>> Notice that, the usual approach to fix these sorts of issues is to
>> replace the one-element array with a flexible-array member. However,
>> flexible arrays should not be used in unions. That, together with the
>> fact that the array notation is not being affected in any ways, is why
>> the pointer approach was chosen in this case.
>>
>> Link: https://github.com/KSPP/linux/issues/109
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
>> index 62ddb452f862..bff3dc1af702 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
>> @@ -3679,7 +3679,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
>>         u32 hdr_size = sizeof(struct ixgbe_hic_hdr);
>>         union {
>>                 struct ixgbe_hic_hdr hdr;
>> -               u32 u32arr[1];
>> +               u32 *u32arr;
>>         } *bp = buffer;
>>         u16 buf_len, dword_len;
>>         s32 status;
> 
> This looks bogus. An array is inline, a pointer points elsewhere -
> they're not interchangeable.

Yep; but in this case these are the only places in the code where _u32arr_ is
being used:

3707         /* first pull in the header so we know the buffer length */
3708         for (bi = 0; bi < dword_len; bi++) {
3709                 bp->u32arr[bi] = IXGBE_READ_REG_ARRAY(hw, IXGBE_FLEX_MNG, bi);
3710                 le32_to_cpus(&bp->u32arr[bi]);
3711         }

3727         /* Pull in the rest of the buffer (bi is where we left off) */
3728         for (; bi <= dword_len; bi++) {
3729                 bp->u32arr[bi] = IXGBE_READ_REG_ARRAY(hw, IXGBE_FLEX_MNG, bi);
3730                 le32_to_cpus(&bp->u32arr[bi]);
3731         }

I think it is safe to turn _u32arra_ into a pointer and continue using the array notation
in this particular case.

I also mention this in the changelog text:

"Notice that, the usual approach to fix these sorts of issues is to
replace the one-element array with a flexible-array member. However,
flexible arrays should not be used in unions. That, together with the
fact that the array notation is not being affected in any ways, is why
the pointer approach was chosen in this case."

Do you see any particular problem with this in the current code?

Another solution for this would be as follows:

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 62ddb452f862..3ad95281d790 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -3677,10 +3677,11 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
                                 bool return_data)
 {
        u32 hdr_size = sizeof(struct ixgbe_hic_hdr);
-       union {
-               struct ixgbe_hic_hdr hdr;
-               u32 u32arr[1];
-       } *bp = buffer;
+       struct ixgbe_hic_hdr *bp_hdr = buffer;
+       struct {
+               size_t len;
+               u32 u32arr[];
+       } *bp;
        u16 buf_len, dword_len;
        s32 status;
        u32 bi;
@@ -3704,6 +3705,9 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
        /* Calculate length in DWORDs */
        dword_len = hdr_size >> 2;

+       bp = kmalloc(struct_size(bp, u32arr, dword_len), GFP_KERNEL);
+       bp->len = dword_len;
+       memcpy(bp->u32arr, buffer, flex_array_size(bp, u32arr, bp->len));
        /* first pull in the header so we know the buffer length */
        for (bi = 0; bi < dword_len; bi++) {
                bp->u32arr[bi] = IXGBE_READ_REG_ARRAY(hw, IXGBE_FLEX_MNG, bi);
@@ -3711,7 +3715,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
        }

        /* If there is any thing in data position pull it in */
-       buf_len = bp->hdr.buf_len;
+       buf_len = bp_hdr->buf_len;
        if (!buf_len)
                goto rel_out;

@@ -3724,6 +3728,9 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
        /* Calculate length in DWORDs, add 3 for odd lengths */
        dword_len = (buf_len + 3) >> 2;

+       bp = krealloc(bp, struct_size(bp, u32arr, dword_len), GFP_KERNEL);
+       bp->len = dword_len;
+       memcpy(&bp->u32arr[bi], ((u32 *)buffer + bi), flex_array_size(bp, u32arr, bp->len-bi));
        /* Pull in the rest of the buffer (bi is where we left off) */
        for (; bi <= dword_len; bi++) {
		^^^^^^
I just noticed it seems there is a bug right there. I think it should be bi < dword_len, instead

                bp->u32arr[bi] = IXGBE_READ_REG_ARRAY(hw, IXGBE_FLEX_MNG, bi);


What do you guys think?

Thanks!
--
Gustavo


