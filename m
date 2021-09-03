From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 3 Sep 2021 22:03:24 +0000
Subject: [Intel-wired-lan] Potential oob access in e100.c:get_regs(_len)
In-Reply-To: <c2ca99a7-9389-de32-bf2d-5128158a094a@intel.com>
References: <1f52bd29-43e7-0639-57cf-abfb7dc9804b@sect.tu-berlin.de>
 <c2ca99a7-9389-de32-bf2d-5128158a094a@intel.com>
Message-ID: <39ddfe6f-976d-2929-8f3e-51a20d8f0d7c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/3/2021 2:39 PM, Keller, Jacob E wrote:
> On 9/2/2021 5:15 AM, Felicitas Hetzelt wrote:
>> Hello,
>>
>> I think there might be a bug in the get_regs ethtool ioctl in e100.c. It
>> seems pretty obvious to me, so I wonder if I'm thinking wrong but:
>>
>> here the size of the regs array is set:
>>
>> https://github.com/torvalds/linux/blob/4ac6d90867a4de2e12117e755dbd76e08d88697f/drivers/net/ethernet/intel/e100.c#L2444
>>
>> which is used to allocate an array to store the regdata:
>>
>> https://github.com/linuxkit/linux/blob/ccda4af0f4b92f7b4c308d3acc262f4a7e3affad/net/core/ethtool.c#L1339
>>
>> The size of the allocated buffer would be: *1* + E100_PHY_REGS +
>> sizeof(nic->mem->dump_buf);
>>
>> Then the reg data is copied, but the copied size is *2* + E100_PHY_REGS
>> + sizeof(nic->mem->dump_buf), no?
>>
>> https://github.com/torvalds/linux/blob/4ac6d90867a4de2e12117e755dbd76e08d88697f/drivers/net/ethernet/intel/e100.c#L2464
>>
> 
> I spent 20 minutes digging into this. You're correct but not completely
> correct about what's wrong.
> 
> 1 + E100_PHY_REGS + sizeof(nic->mem->dump_buf)
> 
> This is the total size of the buffer. It is supposed to be split up into
> space for PHY_REGS and the size of the dump_buf.
> 
> In the get_regs code we're doing the following to copy in the dump_buf:
> 
> 	memcpy(&buff[2 + E100_PHY_REGS], nic->mem->dump_buf,
> 		sizeof(nic->mem->dump_buf));
> 
> What this is *trying* to do is get the address of the buffer just after
> the E100_PHY_REGS section. Then we can copy the dump_buf into place.
> 
> So that's off by 1, and we'll overrun by some size. But...
> 
> Even worse than this, the get_regs_len returns size in *bytes*, and then
> the get_regs function assumes that the size for 0 and 1->E100_PHY_REGS
> is in *u32* chunks!
> 
> We're only allocating 0x1D + sizeof(dump_buf) space but we're using
> 4*0x1D+sizeof(dump_buf) space..
> 
> Looking at git history here it seems like we've had this bug since the
> pre-git days... It seems like this should never have worked...
> 
> 
> I spent a good 30 minutes staring at this trying to figure out how the
> analysis could be wrong and I don't see it.
> 
> 
> Are you seeing the same thing I am?
> 
> Thanks,
> Jake
> 

For what it's worth, the u32 issue was caused by abf9b902059f ("e100:
cleanup unneeded math") which did this:

>         strcpy(info->bus_info, pci_name(nic->pdev));
>  }
> 
> +#define E100_PHY_REGS 0x1C
>  static int e100_get_regs_len(struct net_device *netdev)
>  {
>         struct nic *nic = netdev_priv(netdev);
> -#define E100_PHY_REGS          0x1C
> -#define E100_REGS_LEN          1 + E100_PHY_REGS + \
> -       sizeof(nic->mem->dump_buf) / sizeof(u32)
> -       return E100_REGS_LEN * sizeof(u32);
> +       return 1 + E100_PHY_REGS + sizeof(nic->mem->dump_buf);
>  }



The original code divided dump_buf by u32 and then added that into a
total before multiplying it all by sizeof(u32). The new code failed to
keep the multiplication that was necessary on the other values. Woops.

The other bug has been there since before 2.6 git era.
