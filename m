From: Laatz, Kevin <kevin.laatz@intel.com>
Date: Thu, 27 Jun 2019 12:14:50 +0100
Subject: [Intel-wired-lan] [PATCH 00/11] XDP unaligned chunk placement
 support
In-Reply-To: <FA8389B9-F89C-4BFF-95EE-56F702BBCC6D@gmail.com>
References: <20190620083924.1996-1-kevin.laatz@intel.com>
 <FA8389B9-F89C-4BFF-95EE-56F702BBCC6D@gmail.com>
Message-ID: <ef7e9469-e7be-647b-8bb1-da29bc01fa2e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 25/06/2019 19:44, Jonathan Lemon wrote:
> On 20 Jun 2019, at 1:39, Kevin Laatz wrote:
>
>> This patchset adds the ability to use unaligned chunks in the XDP umem.
>>
>> Currently, all chunk addresses passed to the umem are masked to be chunk
>> size aligned (default is 2k, max is PAGE_SIZE). This limits where we can
>> place chunks within the umem as well as limiting the packet sizes 
>> that are
>> supported.
>>
>> The changes in this patchset removes these restrictions, allowing XDP 
>> to be
>> more flexible in where it can place a chunk within a umem. By 
>> relaxing where
>> the chunks can be placed, it allows us to use an arbitrary buffer 
>> size and
>> place that wherever we have a free address in the umem. These changes 
>> add the
>> ability to support jumboframes and make it easy to integrate with other
>> existing frameworks that have their own memory management systems, 
>> such as
>> DPDK.
>
> I'm a little unclear on how this should work, and have a few issues here:
>
> ?1) There isn't any support for the user defined umem->headroom
>

For the unaligned chunks case, it does not make sense to to support a 
user defined headroom since the user can point directly to where they 
want the data to start via the buffer address. Therefore, for unaligned 
chunks, the user defined headroom should always be 0 (aka the user did 
not define a headroom and the default value of 0 is used). Any other 
value will be caught and we return an invalid argument error.


> ?2) When queuing RX buffers, the handle (aka umem offset) is used, which
> ??? points to the start of the buffer area.? When the buffer appears in
> ??? the completion queue, handle points to the start of the received 
> data,
> ??? which might be different from the buffer start address.
>
> ??? Normally, this RX address is just put back in the fill queue, and the
> ??? mask is used to find the buffer start address again.? This no longer
> ??? works, so my question is, how is the buffer start address recomputed
> ??? from the actual data payload address?
>
> ??? Same with TX - if the TX payload isn't aligned in with the start of
> ??? the buffer, what happens?

On the application side (xdpsock), we don't have to worry about the user 
defined headroom, since it is 0, so we only need to account for the 
XDP_PACKET_HEADROOM when computing the original address (in the default 
scenario). This was missing from the v1, will add this in the v2, to 
have xdpsock use the default value from libbpf! If the user is using 
another BPF program that uses a different offset, then the computation 
will need to be adjusted for that accordingly. In v2 we'll add support 
for this via command-line parameter.

However, we are also working on an "in-order" patchset, hopefully to be 
published soon, to guarantee the buffers returned to the application are 
in the same order as those provided to the kernel. Longer term, this is 
the best solution here as it allows the application to track itself, via 
a "shadow ring" or otherwise, the buffers sent to the kernel and any 
metadata associated with them, such as the start of buffer address.

>
> ?3) This appears limited to crossing a single page boundary, but there
> ??? is no constraint check on chunk_size.

There is an existing check for chunk_size during xdp_umem_reg (in 
xdp_umem.c) The check makes sure that chunk size is at least 
XDP_UMEM_MIN_CHUNK_SIZE and at most PAGE_SIZE. Since the max is page 
size, we only need to check the immediate next page for contiguity.
While this patchset allows a max of 4k sized buffers, it is still an 
improvement from the current state. Future enhancements could look into 
extending the 4k limit but for now it is a good first step towards 
supporting hugepages efficiently.

Best regards,
Kevin
