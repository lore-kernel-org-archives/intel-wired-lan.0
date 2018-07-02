From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 2 Jul 2018 09:18:13 -0700
Subject: [Intel-wired-lan] [PATCH v3 02/11] igc: Add support for PF
In-Reply-To: <70f27bbc-676f-1583-c0e5-e6d9ebc72592@intel.com>
References: <20180624084500.10021-1-sasha.neftin@intel.com>
 <63d4f9f3-d9c7-64f2-9256-fca93e8383e7@oracle.com>
 <70f27bbc-676f-1583-c0e5-e6d9ebc72592@intel.com>
Message-ID: <d1a8c9c0-c558-8f15-ca03-83b089a99785@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/2/2018 1:57 AM, Neftin, Sasha wrote:
> On 6/27/2018 03:32, Shannon Nelson wrote:
>> On 6/24/2018 1:45 AM, Sasha Neftin wrote:
>>> This patch adds the basic defines and structures needed by the PF for
>>> operation.
>>

[...]

>>> +
>>> +/* forward declaration */
>>> +struct e1000_hw;
>>> +u32 igc_rd32(struct e1000_hw *hw, u32 reg);
>>
>> Can we do this without the forward decls?
>>
> Can you advice another place?

Yeah, this one is my mistake, putting the declarations of functions used 
in other files into the headerfile is fine.

[...]

>>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c 
>>> b/drivers/net/ethernet/intel/igc/igc_main.c
>>> index 3e10d27752d5..ec3451dad91e 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>>> @@ -25,6 +25,69 @@ static const struct pci_device_id igc_pci_tbl[] = {
>>> ? MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
>>> +/* Forward declaration */
>>> +static int igc_sw_init(struct igc_adapter *);
>>
>> Can we do this without the forward decls?
>>
> Can you advice another place?

It's these in the .c file that bother me.  For the most part, you should 
be able to order the functions in the file such that anything used by 
one functions has already be defined above it, and then these are not 
needed.  This way, the starting or "main" functions e.g. probe and 
release, are at the bottom of the file, and simple little utility 
functions are near the top.  This is not an absolute standard, but a 
general custom.

sln
