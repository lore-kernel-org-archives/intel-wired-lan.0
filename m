From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 10 Sep 2021 05:51:08 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] e100: fix buffer overrun in
 e100_get_regs
In-Reply-To: <12ae57c9-aee4-add8-9b82-6bbab5de1144@intel.com>
References: <20210908175237.3058574-1-jacob.e.keller@intel.com>
 <20210908175237.3058574-2-jacob.e.keller@intel.com>
 <12ae57c9-aee4-add8-9b82-6bbab5de1144@intel.com>
Message-ID: <97e3e93d-e352-9d43-dbb0-bab6372defd8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/9/2021 6:59 PM, Keller, Jacob E wrote:
> On 9/8/2021 10:52 AM, Keller, Jacob E wrote:
>> The e100_get_regs function is used to implement a simple register dump
>> for the e100 device. The data is broken into a couple of MAC control
>> registers, and then a series of PHY registers, followed by a memory dump
>> buffer.
>>
>> The total length of the register dump is defined as (1 + E100_PHY_REGS)
>> * sizeof(u32) + sizeof(nic->mem->dump_buf).
>>
>> The logic for filling in the PHY registers uses a convoluted inverted
>> count for loop which counts from E100_PHY_REGS (0x1C) down to 0, and
>> assigns the slots 1 + E100_PHY_REGS - i. The first loop iteration will
>> fill in [1] and the final loop iteration will fill in [1 + 0x1C]. This
>> is actually one more than the supposed number of PHY registers.
>>
>> The memory dump buffer is then filled into the space at
>> [2 + E100_PHY_REGS] which will cause that memcpy to assign 4 bytes past
>> the total size.
>>
>> The end result is that we overrun the total buffer size allocated by the
>> kernel, which could lead to a panic or other issues due to memory
>> corruption.
>>
>> It is difficult to determine the actual total number of registers
>> here. The only 8255x datasheet I could find indicates there are 28 total
>> MDI registers. However, we're reading 29 here, and reading them in
>> reverse!
>>
>> In addition, the ethtool e100 register dump interface appears to read
>> the first PHY register to determine if the device is in MDI or MDIx
>> mode. This doesn't appear to be documented anywhere within the 8255x
>> datasheet. I can only assume it must be in register 28 (the extra
>> register we're reading here).
>>
>> Lets not change any of the intended meaning of what we copy here. Just
>> extend the space by 4 bytes to account for the extra register and
>> continue copying the data out in the same order.
>>
>> Change the E100_PHY_REGS value to be the correct total (29) so that the
>> total register dump size is calculated properly. Fix the offset for
>> where we copy the dump buffer so that it doesn't overrun the total size.
>>
>> Re-write the for loop to use counting up instead of the convoluted
>> down-counting. Correct the mdio_read offset to use the 0-based register
>> offsets, but maintain the bizarre reverse ordering so that we have the
>> ABI expected by applications like ethtool. This requires and additional
>> subtraction of 1. It seems a bit odd but it makes the flow of assignment
>> into the register buffer easier to follow.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Rerported-by: Reported-by: Felicitas Hetzelt <felicitashetzelt@gmail.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>>  drivers/net/ethernet/intel/e100.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
>> index 588a59546d12..7ac932e95fcb 100644
>> --- a/drivers/net/ethernet/intel/e100.c
>> +++ b/drivers/net/ethernet/intel/e100.c
>> @@ -2437,7 +2437,7 @@ static void e100_get_drvinfo(struct net_device *netdev,
>>  		sizeof(info->bus_info));
>>  }
>>  
>> -#define E100_PHY_REGS 0x1C
>> +#define E100_PHY_REGS 0x1D
>>  static int e100_get_regs_len(struct net_device *netdev)
>>  {
>>  	struct nic *nic = netdev_priv(netdev);
>> @@ -2459,13 +2459,17 @@ static void e100_get_regs(struct net_device *netdev,
>>  	buff[0] = ioread8(&nic->csr->scb.cmd_hi) << 24 |
>>  		ioread8(&nic->csr->scb.cmd_lo) << 16 |
>>  		ioread16(&nic->csr->scb.status);
>> -	for (i = E100_PHY_REGS; i >= 0; i--)
>> -		buff[1 + E100_PHY_REGS - i] =
>> -			mdio_read(netdev, nic->mii.phy_id, i);
>> +	for (i = 0; i < E100_PHY_REGS; i++)
>> +		/* Note that we read the registers in reverse order. This
>> +		 * ordering is the ABI apparently used by ethtool and other
>> +		 * applications.
>> +		 */
>> +		buff[1 + i] = mdio_read(netdev, nic->mii.phy_id,
>> +					E100_PHY_REGS - 1 - i);
>>  	memset(nic->mem->dump_buf, 0, sizeof(nic->mem->dump_buf));
>>  	e100_exec_cb(nic, NULL, e100_dump);
>>  	msleep(10);
>> -	memcpy(&buff[2 + E100_PHY_REGS], nic->mem->dump_buf,
>> +	memcpy(&buff[1 + E100_PHY_REGS], nic->mem->dump_buf,
>>  		sizeof(nic->mem->dump_buf));
>>  }
>>
> I don't think this is quite right yet.... I loaded this up in QEMU with
> an i82550 emulated nic. I still see a KASAN error with this applied. I'm
> verifying everything again and will get back once I've got a proper fix
> that doesn't trigger KASAN.
> 
> Thanks,
> Jake
> 

I re-ran a build and made absolutely sure I got the right driver
installed. Once I did that the KASAN warnings went away. I suspect that
the build I was testing with the above comment was somehow not complete
or wasn't saved right.

With that being said, I can confidently say this is correct at least as
far as a simulation from qemu-kvm with the i82550 is concerned.

A bit odd maybe, but...

Tested-by: Jacob Keller <jacob.e.keller@intel.com>
